Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C1B679E65
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjAXQRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjAXQR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:17:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C160947094
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:17:27 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OGEqZ2003193;
        Tue, 24 Jan 2023 16:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=3dzjlb7/GF9BHkzbcKCR9If7yWi4T/hk0VBlM660xSI=;
 b=QEMgmcMpKKfwgcN0QOQHFfskYzFnIr48M1bC2ElNUXlbUnncVZLx+N7eqQdZrIyUBLRe
 9YpYNtGCkZsJIDnDcpo5x/jtW+uFHaXeMSUdL4WEzl5QyBSvJMCD9CW/4NNWi3e5GcHV
 PVEUMd/pIbWVni0gH/TFbxCI73wQYa+3gaq+QLjp6iYGzEc5TgVyFNMo//NBbpfl8LMc
 NZvPGYnAEMgxYLoLlEqbK2NIVv8d32bIY7NHRSZZkPZMpfcoSxh+1KbkBkTseHWI6eLu
 nyleQylUD8CiHolYGXYoQQGQpjfqIfRSFOcyBj/xVp2JKXQOi79z6MMDa7xhe4uHwwRD EQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n87nt5sng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 16:17:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OFd49E029364;
        Tue, 24 Jan 2023 16:17:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gbeny2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 16:17:23 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30OGHMrS030820;
        Tue, 24 Jan 2023 16:17:22 GMT
Received: from dhcp-10-152-13-169.usdhcp.oraclecorp.com.com (dhcp-10-152-13-169.usdhcp.oraclecorp.com [10.152.13.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3n86gbenxg-1;
        Tue, 24 Jan 2023 16:17:22 +0000
From:   George Kennedy <george.kennedy@oracle.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     george.kennedy@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF
Date:   Tue, 24 Jan 2023 11:16:54 -0500
Message-Id: <1674577014-12374-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_13,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240148
X-Proofpoint-ORIG-GUID: 80BrzDzP5Vprf_uUYdsEYHhqWnoYtoYK
X-Proofpoint-GUID: 80BrzDzP5Vprf_uUYdsEYHhqWnoYtoYK
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a call to console_unlock() in vcs_read() the vc_data struct can be
freed by vc_deallocate(). Because of that, the struct vc_data pointer
load must be done at the top of while loop in vcs_read() to avoid a UAF
when vcs_size() is called.

Syzkaller reported a UAF in vcs_size().

BUG: KASAN: use-after-free in vcs_size (drivers/tty/vt/vc_screen.c:215)
Read of size 4 at addr ffff8881137479a8 by task 4a005ed81e27e65/1537

CPU: 0 PID: 1537 Comm: 4a005ed81e27e65 Not tainted 6.2.0-rc5 #1
Hardware name: Red Hat KVM, BIOS 1.15.0-2.module
Call Trace:
  <TASK>
__asan_report_load4_noabort (mm/kasan/report_generic.c:350)
vcs_size (drivers/tty/vt/vc_screen.c:215)
vcs_read (drivers/tty/vt/vc_screen.c:415)
vfs_read (fs/read_write.c:468 fs/read_write.c:450)
...
  </TASK>

Allocated by task 1191:
...
kmalloc_trace (mm/slab_common.c:1069)
vc_allocate (./include/linux/slab.h:580 ./include/linux/slab.h:720
     drivers/tty/vt/vt.c:1128 drivers/tty/vt/vt.c:1108)
con_install (drivers/tty/vt/vt.c:3383)
tty_init_dev (drivers/tty/tty_io.c:1301 drivers/tty/tty_io.c:1413
     drivers/tty/tty_io.c:1390)
tty_open (drivers/tty/tty_io.c:2080 drivers/tty/tty_io.c:2126)
chrdev_open (fs/char_dev.c:415)
do_dentry_open (fs/open.c:883)
vfs_open (fs/open.c:1014)
...

Freed by task 1548:
...
kfree (mm/slab_common.c:1021)
vc_port_destruct (drivers/tty/vt/vt.c:1094)
tty_port_destructor (drivers/tty/tty_port.c:296)
tty_port_put (drivers/tty/tty_port.c:312)
vt_disallocate_all (drivers/tty/vt/vt_ioctl.c:662 (discriminator 2))
vt_ioctl (drivers/tty/vt/vt_ioctl.c:903)
tty_ioctl (drivers/tty/tty_io.c:2776)
...

The buggy address belongs to the object at ffff888113747800
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 424 bytes inside of
  1024-byte region [ffff888113747800, ffff888113747c00)

The buggy address belongs to the physical page:
page:00000000b3fe6c7c refcount:1 mapcount:0 mapping:0000000000000000
     index:0x0 pfn:0x113740
head:00000000b3fe6c7c order:3 compound_mapcount:0 subpages_mapcount:0
     compound_pincount:0
anon flags: 0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0010200 ffff888100042dc0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888113747880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888113747900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888113747980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                   ^
  ffff888113747a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888113747a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
Disabling lock debugging due to kernel taint

Fixes: ac751efa6a0d ("console: rename acquire/release_console_sem() to console_lock/unlock()")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
---
Changelog:
v2:
	- simplified the patch per Jiri's suggestion
	- trimmed the stack trace in commit message
 drivers/tty/vt/vc_screen.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 1850bacdb5b0..f566eb1839dc 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -386,10 +386,6 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 
 	uni_mode = use_unicode(inode);
 	attr = use_attributes(inode);
-	ret = -ENXIO;
-	vc = vcs_vc(inode, &viewed);
-	if (!vc)
-		goto unlock_out;
 
 	ret = -EINVAL;
 	if (pos < 0)
@@ -407,6 +403,11 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		unsigned int this_round, skip = 0;
 		int size;
 
+		ret = -ENXIO;
+		vc = vcs_vc(inode, &viewed);
+		if (!vc)
+			goto unlock_out;
+
 		/* Check whether we are above size each round,
 		 * as copy_to_user at the end of this loop
 		 * could sleep.
-- 
2.31.1

