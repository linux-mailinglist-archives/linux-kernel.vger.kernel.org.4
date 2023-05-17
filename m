Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A86705E34
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjEQDlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjEQDls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:41:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF14D171E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31FC3636E2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 03:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D064CC433EF;
        Wed, 17 May 2023 03:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684294906;
        bh=jIMBSZU6DcIg128BmiUzKyo1mKFJN6bwGmXxDRJS/7c=;
        h=From:To:Cc:Subject:Date:From;
        b=VqrUbrMhVu67DZAKgx7QGu0lljDrcRx6jtZsupnKWYnfdTmBgee5hTRyvBHETW+xo
         gXQE7ukGIpqQMSkqqK2I6imfGLm6KhutUU1M8JgTHVymX65P7ebFizM1SE5cCDgLz2
         2ifO5Ze/6NuxTUI2dKlyEVqxEsHU0d6N0Lgc0w1IWuLIado07S9ucjmC7kTugM7W6A
         Dpz6KlMSaM4yMNxZU0YI4GvdildW/n3SoOWINSyUYW+t+vN/GRKPsPUno5NDG1186H
         Wxv7dex7f5zc8h579D3FnHFBRW7XY39PsHuw5IW03AKXj8YMH+dL/zduLpnCzKDLOn
         aBODLwSM8MNHw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: compress: fix to check validity of i_compress_flag field
Date:   Wed, 17 May 2023 11:41:39 +0800
Message-Id: <20230517034139.12879-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

The last valid compress related field is i_compress_flag, check its
validity instead of i_log_cluster_size.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- rebase the code.
 fs/f2fs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index f8bf75c1eca9..0a1748444329 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -361,7 +361,7 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_compression(sbi) &&
 			fi->i_flags & F2FS_COMPR_FL &&
 			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
-						i_log_cluster_size))
+						i_compress_flag))
 		return sanity_check_compress_inode(inode, ri);
 
 	return true;
@@ -490,7 +490,7 @@ static int do_read_inode(struct inode *inode)
 	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_compression(sbi) &&
 					(fi->i_flags & F2FS_COMPR_FL)) {
 		if (F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
-					i_log_cluster_size)) {
+					i_compress_flag)) {
 			unsigned short compress_flag;
 
 			atomic_set(&fi->i_compr_blocks,
@@ -728,7 +728,7 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 
 		if (f2fs_sb_has_compression(F2FS_I_SB(inode)) &&
 			F2FS_FITS_IN_INODE(ri, F2FS_I(inode)->i_extra_isize,
-							i_log_cluster_size)) {
+							i_compress_flag)) {
 			unsigned short compress_flag;
 
 			ri->i_compr_blocks =
-- 
2.40.1

