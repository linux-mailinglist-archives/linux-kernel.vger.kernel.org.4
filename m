Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8876069294A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjBJVc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjBJVc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:32:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814E181CD9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:32:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1069B61EAF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 21:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54472C433D2;
        Fri, 10 Feb 2023 21:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676064774;
        bh=J3Gyaseg7yhQVMzzAFVCsvKsCGLb9pPjdnQxlIuqQSM=;
        h=From:To:Cc:Subject:Date:From;
        b=UlHZ7Wr9nKKcfNOZ+RrvVsHagvQ1NcpyDMwY0EEiuLVJIv/32rh11KQzSYSt6eNBm
         0WoXa3ggxLx7SE11k1rpBpLPbjN+cjSA/qHiDN44gOtzMQCpQ12FsU2ynCUxsDrX32
         EzGfEGwGjsnkGsc7sIDzTLJ/Eek7fkEsLH24TdmAEZPbKe87+wWEu5j+JfQwUqxgbR
         Z9024rKOqhd7Pbqvd48GC2SHHXefCfURVsiyVTKIi32EsT5+VKhtcAIJSGohaDU2pL
         LBFEYUvjpEZ4JWYKCNTdACxDwasYtaeI6/G7j1B0DU7NUGl2y7wgTMpPFbyJ87mydl
         IcWBcCuWaD4PQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix wrong segment count
Date:   Fri, 10 Feb 2023 13:32:50 -0800
Message-Id: <20230210213250.3471246-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAIN_SEGS is for data area, while TOTAL_SEGS includes data and metadata.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 8ee5e5db9287..6003fbaf4b7d 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -720,7 +720,7 @@ static inline unsigned char curseg_alloc_type(struct f2fs_sb_info *sbi,
 
 static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
 {
-	f2fs_bug_on(sbi, segno > TOTAL_SEGS(sbi) - 1);
+	f2fs_bug_on(sbi, segno > MAIN_SEGS(sbi) - 1);
 }
 
 static inline void verify_fio_blkaddr(struct f2fs_io_info *fio)
@@ -775,7 +775,7 @@ static inline int check_block_count(struct f2fs_sb_info *sbi,
 
 	/* check segment usage, and check boundary of a given segment number */
 	if (unlikely(GET_SIT_VBLOCKS(raw_sit) > usable_blks_per_seg
-					|| segno > TOTAL_SEGS(sbi) - 1)) {
+					|| segno > MAIN_SEGS(sbi) - 1)) {
 		f2fs_err(sbi, "Wrong valid blocks %d or segno %u",
 			 GET_SIT_VBLOCKS(raw_sit), segno);
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
-- 
2.39.1.581.gbfd45094c4-goog

