Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472226CFFDB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjC3Jco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjC3Jcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:32:41 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CFE7698
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1680168761;
  x=1711704761;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=ARulaqHJxPwB/WKU7rfcwJ3+y3Mu0UnpMwYgGZ/ZzmM=;
  b=cirIf2Dr7mJ9K4/sA7f8sfQNepMza7P747a+4lsojzpZwCtM8hCXbwYf
   lW6r6RKXkkECNfpk4yIGvkY7kEkN5zGEcCIwGaZl11t65zYbGHSg3M0I0
   sESW0vJ7RlZbcrd3Keb+mU0ObyWzBC+/f/QJf2X4jQytjZkRKIUseZSJR
   gVm3f52x9Jh5I5eFFtPm2a8wbH9W/QgurmL5zWtmpOdQ2/7Ry2q3rfdpx
   n5Z5wrvZhmtGsrigycRLLXYp5bo7FpeC+lyf1x7+npXqXZUDQaPzhEZBY
   0dQh/7tl+C/+nSksvV+KjL8laxIoF21XkKcamX8jtwLHBNXahi1ch9Uyr
   Q==;
From:   =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Date:   Thu, 30 Mar 2023 11:32:14 +0200
Subject: [PATCH v2] ubifs: Free memory for tmpfile name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20230329-memleak-fix-v2-1-cb8d9394300b@axis.com>
X-B4-Tracking: v=1; b=H4sIAB1XJWQC/22Nyw6CQAxFf4V0bQ0zozxc+R+GRYEijQ6YKSEYw
 r87sHZ57iNnBeUgrHBLVgg8i8o4RLCnBJqehiejtJHBptalzpbo2b+ZXtjJgkVOqWmpu2QlQ3z
 UpIx1oKHp948nnTjsxSdw3B+aRxW5F53G8D2ss9nT/4LZoMHcONfSNWMqujstoudm9FBt2/YDO
 U6Ms74AAAA=
To:     Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>,
        =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680168758; l=1585;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=DvHc9WiK+hCXxAJFzO5SlY8uEWNpRF0ZPAgyp0dhgpQ=;
 b=+VxG8dBorTmhj1CUJGkeCxLyzvmUn+kHjSxEOH4y6tqHD/w29wuRZ3n5bTPTEvZR/XLLGNmCU
 e4XJ5VCW9Y4DDcaapawU1ESDAnzvAz+1R4Nfbf5X56egcCPv//z2JCX
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When opening a ubifs tmpfile on an encrypted directory, function
fscrypt_setup_filename allocates memory for the name that is to be
stored in the directory entry, but after the name has been copied to the
directory entry inode, the memory is not freed.

When running kmemleak on it we see that it is registered as a leak. The
report below is triggered by a simple program 'tmpfile' just opening a
tmpfile:

  unreferenced object 0xffff88810178f380 (size 32):
    comm "tmpfile", pid 509, jiffies 4294934744 (age 1524.742s)
    backtrace:
      __kmem_cache_alloc_node
      __kmalloc
      fscrypt_setup_filename
      ubifs_tmpfile
      vfs_tmpfile
      path_openat

Free this memory after it has been copied to the inode.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
Changes in v2:
- Call fscrypt_free_filename after ubifs_release_budget
- Link to v1: https://lore.kernel.org/r/20230329-memleak-fix-v1-1-7133da56ea8f@axis.com
---
 fs/ubifs/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 0f29cf201136..7dd6dd34b84c 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -492,6 +492,7 @@ static int ubifs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	unlock_2_inodes(dir, inode);
 
 	ubifs_release_budget(c, &req);
+	fscrypt_free_filename(&nm);
 
 	return finish_open_simple(file, 0);
 

---
base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
change-id: 20230329-memleak-fix-87a01daf469e

Best regards,
-- 
Mårten Lindahl <marten.lindahl@axis.com>

