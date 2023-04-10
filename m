Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0624B6DC287
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDJCHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjDJCHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:07:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6067930D6
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 19:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF26361724
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D65C433D2;
        Mon, 10 Apr 2023 02:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681092460;
        bh=gvtVs77/FSkY/6eE8xO1TaHO2ECWAurgukRxLECf6AU=;
        h=From:To:Cc:Subject:Date:From;
        b=AlfMFPSJjjeVX4qUcR3E5MYpq56I6gyVHmEJO74PL1sijsNUxi5YJXVcoHhQU0Sht
         oOXxkTrqJ/A9hNKinEzkATncmB1DtxQ28OsaHM6Mx3BSndif2T4qpQtLotDy7uPqXd
         G8SbRKkiGRzK1b0umu6s4Z0BqxN50kt6EOtO5dvbZRXTDK5yVX89r3RExdrdsoE//T
         nuCkIyOHXfIbY27ulwOpwRfogQyNji9mrCEH+HdB1MSHhEyxD1er+rs5i6y2rPAaEw
         +h5coy8Qj5ylmCWTuBBB/UpdVVZi8VUrMMiZKFEia5BZrLdRXyGpdAF5WRgU3DD6eK
         glkAk2n187ojA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: fix to tag FIEMAP_EXTENT_DELALLOC in fiemap() for delay allocated extent
Date:   Mon, 10 Apr 2023 10:07:24 +0800
Message-Id: <20230410020724.1817150-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xfstest generic/614 fails to run due to below reason:

generic/614 1s ... [not run] test requires delayed allocation buffered writes

The root cause is f2fs tags wrong fiemap flag for delay allocated
extent.

Quoted from fiemap ioctl manual from [1]:
FIEMAP_EXTENT_UNKNOWN
The location of this extent is currently unknown. This may
indicate the data is stored on an inaccessible volume or that
no storage has been allocated for the file yet.

FIEMAP_EXTENT_DELALLOC
This will also set FIEMAP_EXTENT_UNKNOWN.

Delayed allocation - while there is data for this extent, its
physical location has not been allocated yet.

FIEMAP_EXTENT_UNWRITTEN
Unwritten extent - the extent is allocated but its data has not
been initialized. This indicates the extent’s data will be all
zero if read through the filesystem but the contents are undefined
if read directly from the device.

[1] https://www.kernel.org/doc/html/latest/filesystems/fiemap.html

FIEMAP_EXTENT_UNWRITTEN means block address is preallocated, but w/o
been written any data, which status f2fs is not supported now, for all
NEW_ADDR block addresses, it means delay allocated blocks, so let's
tag FIEMAP_EXTENT_DELALLOC instead.

Testcase:
xfs_io -f -c 'pwrite 0 64k' /mnt/f2fs/file;
filefrag -v /mnt/f2fs/file

Output:
- Before
Filesystem type is: f2f52010
Fize of /mnt/f2fs/file is 65536 (16 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..      15:          0..        15:     16:             last,unwritten,merged,eof
/mnt/f2fs/file: 1 extent found

- After:
Filesystem type is: f2f52010
File size of /mnt/f2fs/file is 65536 (16 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..      15:          0..         0:      0:             last,unknown_loc,delalloc,eof
/mnt/f2fs/file: 1 extent found

Fixes: 7f63eb77af7b ("f2fs: report unwritten area in f2fs_fiemap")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix type and update description of fiemap manual in commit message.
 fs/f2fs/data.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0a5832ec4046..becc7bdb7403 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1999,7 +1999,10 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	}
 
 	if (size) {
-		flags |= FIEMAP_EXTENT_MERGED;
+		if (flags & FIEMAP_EXTENT_DELALLOC)
+			phys = 0;
+		else
+			flags |= FIEMAP_EXTENT_MERGED;
 		if (IS_ENCRYPTED(inode))
 			flags |= FIEMAP_EXTENT_DATA_ENCRYPTED;
 
@@ -2039,7 +2042,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 				size += blks_to_bytes(inode, 1);
 			}
 		} else if (map.m_flags & F2FS_MAP_DELALLOC) {
-			flags = FIEMAP_EXTENT_UNWRITTEN;
+			flags = FIEMAP_EXTENT_DELALLOC;
 		}
 
 		start_blk += bytes_to_blks(inode, size);
-- 
2.25.1

