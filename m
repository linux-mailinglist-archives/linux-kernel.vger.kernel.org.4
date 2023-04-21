Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C215A6EA164
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjDUCCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjDUCCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:02:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C134C24
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B2F764924
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4A4C433D2;
        Fri, 21 Apr 2023 02:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682042525;
        bh=9340DfwcHIyLGEj8rbvnurntm4mO9XqyjEGJYFQnSS4=;
        h=From:To:Cc:Subject:Date:From;
        b=uWywheHbQHNcegTawbbJPT4238fUZcZ1xAsKEDARxcQ7ie+F7oqRCDPAoqIl3r/r7
         RhRIDLsCSQK+JbTEy1jEJcnKh8ReknKVnP20eSYk7a4PwxPvsn3uOmrbYfuObYXOec
         or4Os/WmAo//ceNYJy4rNNPYFnDB+05Ibq/KPblzizq0xQ8XS4g4cjloaef5OdkH60
         OfYZ1vhFmEm8NlHBPNrnW/kHlHELCQ7KMkt320Xl/rijF7+DD1PEJnKZi+rqkBlDP+
         xQstIFpJwPOXdy+jtoxA9TQSpcoupbxOnGPUMgblAbC0nbEJceF6sYpOKFU6E2YT+0
         QtTRSI/bJc57g==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: compress: fix to check validity of i_compress_flag field
Date:   Fri, 21 Apr 2023 10:01:38 +0800
Message-Id: <20230421020138.2727050-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

The last valid compress related field is i_compress_flag, check its
validity instead of i_log_cluster_size.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index cf4327ad106c..516d5dd8f976 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -286,7 +286,7 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_compression(sbi) &&
 			fi->i_flags & F2FS_COMPR_FL &&
 			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
-						i_log_cluster_size)) {
+						i_compress_flag)) {
 		if (ri->i_compress_algorithm >= COMPRESS_MAX) {
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
@@ -442,7 +442,7 @@ static int do_read_inode(struct inode *inode)
 	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_compression(sbi) &&
 					(fi->i_flags & F2FS_COMPR_FL)) {
 		if (F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
-					i_log_cluster_size)) {
+					i_compress_flag)) {
 			unsigned short compress_flag;
 
 			atomic_set(&fi->i_compr_blocks,
@@ -680,7 +680,7 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 
 		if (f2fs_sb_has_compression(F2FS_I_SB(inode)) &&
 			F2FS_FITS_IN_INODE(ri, F2FS_I(inode)->i_extra_isize,
-							i_log_cluster_size)) {
+							i_compress_flag)) {
 			unsigned short compress_flag;
 
 			ri->i_compr_blocks =
-- 
2.25.1

