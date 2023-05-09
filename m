Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B92E6FBE15
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 06:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjEIEAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 00:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbjEID7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:59:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B05E71B;
        Mon,  8 May 2023 20:57:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE783643B4;
        Tue,  9 May 2023 03:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EED3C433EF;
        Tue,  9 May 2023 03:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683604596;
        bh=/qKhNrWfvzFdzQz2sPlreJy0/idtBkrSut+nElfdZjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVDpSIZO5cvMkodSMmzmhuFuS0aFyQTx9g18cvypF3WKM9S9RoHK2ip7b7sjxYIK7
         ZHXMqZefPHltWau+uU7/25FrqZ15kuO73qAdIqK1WMFR/0TKXGVLqAJmhjnuT4Xg1W
         vdVgxYBsRNsuvH/TXz493veg1iWT6JQiDopbtmSSHpmnvvOZsGfEvzoUagz4BGjDbi
         tT9jFKMF6HtSYbW4TdcIQ6cKC1gR4i53sPDo8950G0g24A54jHNCvo/J8D8KaK6oNN
         x86wvQORHr8eVgySoOXf4EtFtm8njsGYv9em3L7ZSlBFz3rMoPY30gDbGM5BuXtlWt
         qodOj950iKLuA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hao Zeng <zenghao@kylinos.cn>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>, chenhuacai@kernel.org,
        zhangqing@loongson.cn
Subject: [PATCH AUTOSEL 4.19 2/2] recordmcount: Fix memory leaks in the uwrite function
Date:   Mon,  8 May 2023 23:56:27 -0400
Message-Id: <20230509035632.60967-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509035632.60967-1-sashal@kernel.org>
References: <20230509035632.60967-1-sashal@kernel.org>
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
index d3e61dcc61295..ae1ae7c86d0c6 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -132,6 +132,7 @@ uwrite(int const fd, void const *const buf, size_t const count)
 {
 	size_t cnt = count;
 	off_t idx = 0;
+	void *p = NULL;
 
 	file_updated = 1;
 
@@ -139,7 +140,10 @@ uwrite(int const fd, void const *const buf, size_t const count)
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

