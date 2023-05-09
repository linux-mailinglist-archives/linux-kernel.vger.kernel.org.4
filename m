Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3C86FBE11
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbjEID7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjEID7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:59:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D146A30D8;
        Mon,  8 May 2023 20:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E277F62425;
        Tue,  9 May 2023 03:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39089C433D2;
        Tue,  9 May 2023 03:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683604606;
        bh=ED7IjzAxUGMLvXXehsI2ODsAjynIgQI0BHZDdZbOvHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kPm1rnliv566LZeID4FbiH/05D/7vWkaARFbzxgtMn2hqy3sqVA4oYvFQZtyLmE5z
         D89/CXAKaAoIMbJ02e5PtPJkVe2bua0DT3bMsDWdolNeTlDfhS/3OKk60DW50c7rUX
         Du6Mk6171hsGYU6xzIcObeWWe8ne+5k1Mg0SHdjvvSd2HBA7Na3BqwjxKhEsQ+dWAS
         8RhoUymXbpCfEdeusLIZEnakBhC973+VKrSkJ0Hy2IvLA0PJ4AkbHeQ0OQ4FS4Jyg5
         EjaVebp6P+cEAyCiWfXAPDx38SfwTqnIG73tjKT3dvrQiZqPgitVhJR+MNajnDrHc7
         KCY9JczuypHqw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hao Zeng <zenghao@kylinos.cn>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>, chenhuacai@kernel.org,
        zhangqing@loongson.cn
Subject: [PATCH AUTOSEL 4.14 2/2] recordmcount: Fix memory leaks in the uwrite function
Date:   Mon,  8 May 2023 23:56:36 -0400
Message-Id: <20230509035641.61093-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509035641.61093-1-sashal@kernel.org>
References: <20230509035641.61093-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hao Zeng <zenghao@kylinos.cn>

[ Upstream commit fa359d068574d29e7d2f0fdd0ebe4c6a12b5cfb9 ]

Common realloc mistake: 'file_append' nulled but not freed upon failure

Link: https://lkml.kernel.org/r/20230426010527.703093-1-zenghao@kylinos.cn

Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/recordmcount.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 9012e33ae22f8..731600de03893 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -146,6 +146,7 @@ uwrite(int const fd, void const *const buf, size_t const count)
 {
 	size_t cnt = count;
 	off_t idx = 0;
+	void *p = NULL;
 
 	file_updated = 1;
 
@@ -153,7 +154,10 @@ uwrite(int const fd, void const *const buf, size_t const count)
 		off_t aoffset = (file_ptr + count) - file_end;
 
 		if (aoffset > file_append_size) {
-			file_append = realloc(file_append, aoffset);
+			p = realloc(file_append, aoffset);
+			if (!p)
+				free(file_append);
+			file_append = p;
 			file_append_size = aoffset;
 		}
 		if (!file_append) {
-- 
2.39.2

