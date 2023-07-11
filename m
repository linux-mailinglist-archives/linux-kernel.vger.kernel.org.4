Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7972750CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjGLPhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbjGLPhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:37:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4611BB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4C2E61870
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D66CC433CB;
        Wed, 12 Jul 2023 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689176227;
        bh=jc2J4H1tl9tgCU64obhJD7vtLmPv1NxjiyiMrRi0nP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMb3cYSHrRSH4npwBLyUFpiFCf1EvxpvrdF7v1oe5x+SeBU19wQisO1/uhLglhibD
         jX59ayIP7pKY5uwJ/JsHXg+/2frEze6FSnRNNXSTbP0pbB/Kkfer2aqk7cCU/o+gTW
         B5kkNtiiiEhHOHR0cKJLWGlQ8mSkrm68D9AzpeWq+43n8WAghRchJ9gTEj8UFpCB16
         ptIvBWqs22lSQEQ1fi8w4DZDiwrqrIed8Tj8I0eeuiouS+9Bu4F8KKHVyLSti4BT4c
         OHoYfi8SRmAIMvVrqO1wvTPzqelcuTO04eVtr68Ng2GVkmlJj260fid/JEsUazfDkq
         QUfE3Hpy7bTkg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: compress: don't {,de}compress non-full cluster
Date:   Wed, 12 Jul 2023 04:08:06 +0800
Message-Id: <20230711200806.4884-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230711200806.4884-1-chao@kernel.org>
References: <20230711200806.4884-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs won't compress non-full cluster in tail of file, let's skip
dirtying and rewrite such cluster during f2fs_ioc_{,de}compress_file.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 79cb6a41f128..74f79e7c8c02 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4092,10 +4092,8 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 
 	count = last_idx - page_idx;
-	while (count) {
-		int len = min(cluster_size, count);
-
-		ret = redirty_blocks(inode, page_idx, len);
+	while (count && count >= cluster_size) {
+		ret = redirty_blocks(inode, page_idx, cluster_size);
 		if (ret < 0)
 			break;
 
@@ -4105,8 +4103,8 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 				break;
 		}
 
-		count -= len;
-		page_idx += len;
+		count -= cluster_size;
+		page_idx += cluster_size;
 
 		cond_resched();
 		if (fatal_signal_pending(current)) {
@@ -4172,10 +4170,8 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 
 	count = last_idx - page_idx;
-	while (count) {
-		int len = min(cluster_size, count);
-
-		ret = redirty_blocks(inode, page_idx, len);
+	while (count && count >= cluster_size) {
+		ret = redirty_blocks(inode, page_idx, cluster_size);
 		if (ret < 0)
 			break;
 
@@ -4185,8 +4181,8 @@ static int f2fs_ioc_compress_file(struct file *filp)
 				break;
 		}
 
-		count -= len;
-		page_idx += len;
+		count -= cluster_size;
+		page_idx += cluster_size;
 
 		cond_resched();
 		if (fatal_signal_pending(current)) {
-- 
2.40.1

