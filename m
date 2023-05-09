Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852516FBDEE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbjEID5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbjEID4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:56:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DE9D2FB;
        Mon,  8 May 2023 20:55:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7E5D63141;
        Tue,  9 May 2023 03:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E331C433EF;
        Tue,  9 May 2023 03:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683604528;
        bh=A5cVwsx73lMpP6hlI3ekkuyMJI7zZZWgRvnobB8yFis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HigE/1EMBsBtwxZpoSKuGTF0nvIhBZgpOiOpIE6371r1MFZVqF49Jy2a1wtWW/gf9
         6eWy5vUFgXoX/dvpikAQV7G6Z9OIgC+b7hjpzTu+890+b+bhua8eDM3x1hpFJhL27s
         xjAQ2LlwQ+03yoBWVvTD3jVwElPjtf7wxFuu+f/s0xg9MZ4DbhZpCPCMlkoxTJBFGv
         iiq/oslwLwRi0G1nEvH8t+NlDz1fjmuFV3v0FJqqDf4/h3bQnm8t4mPbb0NHK37xt2
         /OKNr5rE6AEu8QbRE2SBiihxcyZ9ce4/YzkBRXHhiCSILWcttnM6qupfzX1ChyQscy
         eocAr/MmIRocA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hao Zeng <zenghao@kylinos.cn>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>, zhangqing@loongson.cn,
        chenhuacai@kernel.org
Subject: [PATCH AUTOSEL 6.2 6/6] recordmcount: Fix memory leaks in the uwrite function
Date:   Mon,  8 May 2023 23:55:12 -0400
Message-Id: <20230509035515.59855-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509035515.59855-1-sashal@kernel.org>
References: <20230509035515.59855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index e30216525325b..40ae6b2c7a6da 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -110,6 +110,7 @@ static ssize_t uwrite(void const *const buf, size_t const count)
 {
 	size_t cnt = count;
 	off_t idx = 0;
+	void *p = NULL;
 
 	file_updated = 1;
 
@@ -117,7 +118,10 @@ static ssize_t uwrite(void const *const buf, size_t const count)
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

