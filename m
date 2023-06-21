Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729AC7387D5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjFUOvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjFUOuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:50:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF9D2723
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8070061596
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6702AC433C0;
        Wed, 21 Jun 2023 14:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358908;
        bh=Ozu8vusVt/ZPAtMPgGZ1LcgmA54r8kMF/Hvo6mj2P0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DX/q6KXulzPhf+oHWyMmvCGyi706ot1Qy0Pi395ff90XpXZI0hO7LfIudjPIKhYzc
         F/RGJ5d//DkWpgJdCc2adkI8XtqmH2qgNtmW2iCx4qwVCKCxEDJxFoLdroVZReCgFh
         NRyOlzEIEH02IhhA22k2LE9PRbbAuj55LwjKfCQyLfzX7SnTlE2k2xUT/FF5DzhepI
         8rBrZ83aRfEctaAKZyefrUTET+nLRRcv9sf11A8VLPk5sCC1Q1sBAdYr74HyJeXIYo
         2fmdVgDLMSJ0nePOf/zqm9RGcOwKNIQsZwPxgXgLJZB3DUisoMm1UVpzBpndpcrdC1
         RX0lKMeAyXthg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 31/79] fat: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:44 -0400
Message-ID: <20230621144735.55953-30-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
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

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fat/inode.c | 8 +++++---
 fs/fat/misc.c  | 7 +++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index d99b8549ec8f..b34ae7298796 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -562,7 +562,7 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
 
 	fat_time_fat2unix(sbi, &inode->i_mtime, de->time, de->date, 0);
-	inode->i_ctime = inode->i_mtime;
+	inode_ctime_set(inode, inode->i_mtime);
 	if (sbi->options.isvfat) {
 		fat_time_fat2unix(sbi, &inode->i_atime, 0, de->adate, 0);
 		fat_time_fat2unix(sbi, &MSDOS_I(inode)->i_crtime, de->ctime,
@@ -1407,8 +1407,10 @@ static int fat_read_root(struct inode *inode)
 	MSDOS_I(inode)->mmu_private = inode->i_size;
 
 	fat_save_attrs(inode, ATTR_DIR);
-	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode->i_ctime.tv_sec = 0;
-	inode->i_mtime.tv_nsec = inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec = 0;
+	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode_ctime_set_sec(inode,
+									    0);
+	inode->i_mtime.tv_nsec = inode->i_atime.tv_nsec = inode_ctime_set_nsec(inode,
+									       0);
 	set_nlink(inode, fat_subdirs(inode)+2);
 
 	return 0;
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index 7e5d6ae305f2..0d3ba6001ff0 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -331,8 +331,11 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
 	 * identical in memory. all mtime updates will be applied to ctime,
 	 * but ctime updates are ignored.
 	 */
-	if (flags & S_MTIME)
-		inode->i_mtime = inode->i_ctime = fat_truncate_mtime(sbi, now);
+	if (flags & S_MTIME) {
+		ts = fat_truncate_mtime(sbi, now);
+		inode->i_mtime = ts;
+		inode_ctime_set(inode, ts);
+	}
 
 	return 0;
 }
-- 
2.41.0

