Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D5E6FBE0A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjEID7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjEID6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:58:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DE3DDA0;
        Mon,  8 May 2023 20:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABCE3643F9;
        Tue,  9 May 2023 03:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E03C433D2;
        Tue,  9 May 2023 03:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683604571;
        bh=V+SRqTeOIQkCJr1YG3oqjich7N1hefNlgQc35gKG3p0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qzNhRAhIVuVwTXkaUBOSBl4Gcww732+ZSN3xnVFGfzIcD6GzrAlaxAHFC4r4GuZXy
         tAoN0LYmDpSus+aqG3PRw6mnNEBjGY0dNsP9sJzqG+smxsc5Pw+C1FOnaBicYcQAv4
         CvkTBloYzZL3RzLjIfivADpywfj319py9nylaQtDU/nN9JpqpA6a6rzrsjQrM/mf3R
         hQLuZe9Ejejsr9zEpkS215xDA2tYWvR60XvIIe5RH2UBM+9VWhcUUB9tk+dVAxd71D
         MusoFydmpnpumKOK6P93HTwZHX3F0tJuyTZMniqhTvJjxh7Ukwiv0hrVWn+rfeknJ6
         iyzBTOTYwDQ3w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hao Zeng <zenghao@kylinos.cn>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>, zhangqing@loongson.cn,
        chenhuacai@kernel.org
Subject: [PATCH AUTOSEL 5.10 3/3] recordmcount: Fix memory leaks in the uwrite function
Date:   Mon,  8 May 2023 23:55:58 -0400
Message-Id: <20230509035602.60613-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509035602.60613-1-sashal@kernel.org>
References: <20230509035602.60613-1-sashal@kernel.org>
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
index cce12e1971d85..ec692af8ce9eb 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -102,6 +102,7 @@ static ssize_t uwrite(void const *const buf, size_t const count)
 {
 	size_t cnt = count;
 	off_t idx = 0;
+	void *p = NULL;
 
 	file_updated = 1;
 
@@ -109,7 +110,10 @@ static ssize_t uwrite(void const *const buf, size_t const count)
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

