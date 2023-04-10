Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2754B6DC2A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjDJCU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDJCUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A28F30E3
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 19:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34E1A60D41
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61513C433D2;
        Mon, 10 Apr 2023 02:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681093221;
        bh=HwCOx5xRy3GdD+M/EnsNjrEY2Cu6MG8VzpDDAD4BMUU=;
        h=From:To:Cc:Subject:Date:From;
        b=Dh2D5sgNAfWB0M966BgWaici/0xOyy4b9b4KM0EyKesTAx4HMLa0OPU0pf73J6c5g
         OLZBeSSMJjNU+Bw4zc1TJdZJ+ubO23vf+5JQovX27Y3vWt+BrMSpvby4tRtBy2qkH7
         wqVqDT0zWlbfVkRQo5qlTxqg4iEeG+jd6ITrmcs7tfQjcltPt01TOFZfyKnRwje+ID
         lwVpJXYqGMGMh8tT+mm2XEVXy3p4hy3UFiq8tK8GnRxfqQObDCoINKqeDuTU9CYEI1
         lRwV2WmSG8fNnxcdfddY4CxJS59ZGbERxTCd6DCYpgjsb6/h6EMt9eM37hvV4BepFy
         sRhYcCI7qNj8A==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: remove unneeded in-memory i_crtime copy
Date:   Mon, 10 Apr 2023 10:20:12 +0800
Message-Id: <20230410022012.1839127-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i_crtime will never change after inode creation, so we don't need
to copy it into f2fs_inode_info.i_disk_time[3], and monitor its
change to decide whether updating inode page, remove related stuff.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h  | 5 +----
 fs/f2fs/inode.c | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7d9c5a65f974..e78cbc8a6248 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -844,7 +844,7 @@ struct f2fs_inode_info {
 	kprojid_t i_projid;		/* id for project quota */
 	int i_inline_xattr_size;	/* inline xattr size */
 	struct timespec64 i_crtime;	/* inode creation time */
-	struct timespec64 i_disk_time[4];/* inode disk times */
+	struct timespec64 i_disk_time[3];/* inode disk times */
 
 	/* for file compress */
 	atomic_t i_compr_blocks;		/* # of compressed blocks */
@@ -3290,9 +3290,6 @@ static inline bool f2fs_is_time_consistent(struct inode *inode)
 		return false;
 	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 2, &inode->i_mtime))
 		return false;
-	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 3,
-						&F2FS_I(inode)->i_crtime))
-		return false;
 	return true;
 }
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index bb5b365a195d..cf4327ad106c 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -326,7 +326,6 @@ static void init_idisk_time(struct inode *inode)
 	fi->i_disk_time[0] = inode->i_atime;
 	fi->i_disk_time[1] = inode->i_ctime;
 	fi->i_disk_time[2] = inode->i_mtime;
-	fi->i_disk_time[3] = fi->i_crtime;
 }
 
 static int do_read_inode(struct inode *inode)
-- 
2.25.1

