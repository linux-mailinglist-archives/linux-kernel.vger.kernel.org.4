Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18C9678B05
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjAWWtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjAWWtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:49:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28BA14E93
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:49:01 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NLhtdV012747;
        Mon, 23 Jan 2023 22:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=4yRtXD42ExssOjNJz8CgKj7FnN0pE8XaTk8pfSEk0SE=;
 b=piXA05V+UYTEFlMKUOKEATnDG4YrBROfgaR7tUwIrOltJknK7YgJlgO4XgapwceclP+0
 v5faxtVDICM2s5qDyqHkDX9aSdFbRctxW3/NeGsYW9abig3VlrBLoykt7DGW+bOj1jJp
 5AkdGKEgGfT2sr/c7f1+xbWtS7uqaUwxHBb7SO2t9/tLyaOw4au2uaeGlbMVTMvvQejL
 2HmCCqweqFy5BFxkUzJfN7P5vuzxDLSKnTP7HhgXOp3N9k/JMR1zvnzhObk2N9xSsKyS
 z7VLtm2Mt03sQT7+MtulviLzi2Ppvzf6PrJ+duWJj0Xl1ZHUnZxL8q4h/UGM2Yy/A3oG kg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n87nt43q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 22:48:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30NMdml0039589;
        Mon, 23 Jan 2023 22:48:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gayn4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 22:48:54 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30NMmrip028578;
        Mon, 23 Jan 2023 22:48:54 GMT
Received: from dhcp-10-152-13-169.usdhcp.oraclecorp.com.com (dhcp-10-152-13-169.usdhcp.oraclecorp.com [10.152.13.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3n86gayn2j-1;
        Mon, 23 Jan 2023 22:48:53 +0000
From:   George Kennedy <george.kennedy@oracle.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     george.kennedy@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] vc_screen: reload & check struct vc_data pointer in vcs_read() to avoid UAF
Date:   Mon, 23 Jan 2023 17:48:19 -0500
Message-Id: <1674514099-17696-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301230216
X-Proofpoint-ORIG-GUID: Dilrso8TJ5rXLHtiM3Bawbo0aPCXJNzg
X-Proofpoint-GUID: Dilrso8TJ5rXLHtiM3Bawbo0aPCXJNzg
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
freed by vc_deallocate(). Because of that, the struct vc_data pointer needs
to be reloaded and checked for NULL to avoid the UAF below when vcs_size()
is called.

Syzkaller reported a UAF in vcs_size().

BUG: KASAN: use-after-free in vcs_size (drivers/tty/vt/vc_screen.c:215)
Read of size 4 at addr ffff8881137479a8 by task 4a005ed81e27e65/1537

CPU: 0 PID: 1537 Comm: 4a005ed81e27e65 Not tainted 6.2.0-rc5 #1
Hardware name: Red Hat KVM, BIOS 1.15.0-2.module
Call Trace:
 <TASK>
dump_stack_lvl (lib/dump_stack.c:107)
print_report (mm/kasan/report.c:307 mm/kasan/report.c:417)
kasan_report (mm/kasan/report.c:184 mm/kasan/report.c:519)
__asan_report_load4_noabort (mm/kasan/report_generic.c:350)
vcs_size (drivers/tty/vt/vc_screen.c:215)
vcs_read (drivers/tty/vt/vc_screen.c:415)
vfs_read (fs/read_write.c:468 fs/read_write.c:450)
ksys_read (fs/read_write.c:614)
__x64_sys_read (fs/read_write.c:621)
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
 </TASK>

Allocated by task 1191:
kasan_save_stack (mm/kasan/common.c:46)
kasan_set_track (mm/kasan/common.c:52)
kasan_save_alloc_info (mm/kasan/generic.c:508)
__kasan_kmalloc (mm/kasan/common.c:381)
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
path_openat (fs/namei.c:3558 fs/namei.c:3714)
do_filp_open (fs/namei.c:3741)
do_sys_openat2 (fs/open.c:1311)
do_sys_open (fs/open.c:1324)
__x64_sys_openat (fs/open.c:1337)
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

Freed by task 1548:
kasan_save_stack (mm/kasan/common.c:46)
kasan_set_track (mm/kasan/common.c:52)
kasan_save_free_info (mm/kasan/generic.c:520)
__kasan_slab_free (mm/kasan/common.c:238 mm/kasan/common.c:200
    mm/kasan/common.c:244)
__kmem_cache_free (mm/slub.c:1807 mm/slub.c:3787 mm/slub.c:3800)
kfree (mm/slab_common.c:1021)
vc_port_destruct (drivers/tty/vt/vt.c:1094)
tty_port_destructor (drivers/tty/tty_port.c:296)
tty_port_put (drivers/tty/tty_port.c:312)
vt_disallocate_all (drivers/tty/vt/vt_ioctl.c:662 (discriminator 2))
vt_ioctl (drivers/tty/vt/vt_ioctl.c:903)
tty_ioctl (drivers/tty/tty_io.c:2776)
__x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:870 fs/ioctl.c:856
    fs/ioctl.c:856)
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

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
>ffff888113747980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888113747a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888113747a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
Disabling lock debugging due to kernel taint

Fixes: ac751efa6a0d ("console: rename acquire/release_console_sem() to console_lock/unlock()")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
---
 drivers/tty/vt/vc_screen.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 1850bacdb5b0..efa4f14fc9c0 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -403,7 +403,7 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		poll->event = 0;
 	read = 0;
 	ret = 0;
-	while (count) {
+	while (vc && count) {
 		unsigned int this_round, skip = 0;
 		int size;
 
@@ -465,9 +465,17 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		pos += this_round;
 		read += this_round;
 		count -= this_round;
+
+		/* Reload if more to do. May have been freed by vc_deallocate()
+		 * after console_unlock()
+		 */
+		if (count)
+			vc = vcs_vc(inode, &viewed);
 	}
 	*ppos += read;
-	if (read)
+	if (!vc)
+		ret = -ENXIO;
+	else if (read)
 		ret = read;
 unlock_out:
 	console_unlock();
-- 
2.31.1

