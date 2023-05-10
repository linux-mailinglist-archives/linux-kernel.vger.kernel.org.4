Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FFE6FE306
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjEJRJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbjEJRJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:09:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2171BFE;
        Wed, 10 May 2023 10:09:10 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ADwx3r014162;
        Wed, 10 May 2023 17:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=Cnv47P/yMcrmh+FaCz05BZSuMrv22ypz4lgstoFRav0=;
 b=S/HGBPIl9S0TtkNeNI9ZsJgLvXWl8WfAiLv6QOINT8/Jafzr5iluouE40aI+iYF2VjTu
 2QOD2VRWY1SSqF7hVWZiETC1G25kR/fEpPOyUT1iLU15DxCPTyKnY99YLWL5ToHC6s3g
 S7eKVH5bhKNNGvWvMUm6evGgr9UqCw2+QzCy7cLjhseWnp5UQgZi8y9LyE/hz8HvHHfP
 0eW1rhh4/ctjNH74sPrIKmt4OlZMUUIb6oHHmtMzikAJgNnPnCH8SUNp5bY6hFqxvO+X
 aSJm5WZ6zSyi/g4JM4POUNT+OcKmJ7MvO5BdwvR4/nxdCIBHVIbhyvnn1jOjuYdc99hN vQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7755759-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 May 2023 17:08:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34AGVvfX004415;
        Wed, 10 May 2023 17:08:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7pjv8ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 May 2023 17:08:41 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34AH8fCf031266;
        Wed, 10 May 2023 17:08:41 GMT
Received: from gkennedy-linux.us.oracle.com (gkennedy-linux.us.oracle.com [10.152.170.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qf7pjv8t3-1;
        Wed, 10 May 2023 17:08:41 +0000
From:   George Kennedy <george.kennedy@oracle.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     george.kennedy@oracle.com, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux@weissschuh.net,
        regressions@lists.linux.dev
Subject: [PATCH v2] vc_screen: reload load of struct vc_data pointer in vcs_write() to avoid UAF
Date:   Wed, 10 May 2023 12:07:11 -0500
Message-Id: <1683738431-3647-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100138
X-Proofpoint-GUID: cOaHX4ehEeBSa5D0BUijYco7cfZC_EoU
X-Proofpoint-ORIG-GUID: cOaHX4ehEeBSa5D0BUijYco7cfZC_EoU
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a call to console_unlock() in vcs_write() the vc_data struct can be
freed by vc_port_destruct(). Because of that, the struct vc_data pointer
must be reloaded in the while loop in vcs_write() after console_lock() to
avoid a UAF when vcs_size() is called.

Syzkaller reported a UAF in vcs_size().

BUG: KASAN: slab-use-after-free in vcs_size (drivers/tty/vt/vc_screen.c:215)
Read of size 4 at addr ffff8880beab89a8 by task repro_vcs_size/4119

Call Trace:
 <TASK>
__asan_report_load4_noabort (mm/kasan/report_generic.c:380)
vcs_size (drivers/tty/vt/vc_screen.c:215)
vcs_write (drivers/tty/vt/vc_screen.c:664)
vfs_write (fs/read_write.c:582 fs/read_write.c:564)
...
 <TASK>

Allocated by task 1213:
kmalloc_trace (mm/slab_common.c:1064)
vc_allocate (./include/linux/slab.h:559 ./include/linux/slab.h:680
    drivers/tty/vt/vt.c:1078 drivers/tty/vt/vt.c:1058)
con_install (drivers/tty/vt/vt.c:3334)
tty_init_dev (drivers/tty/tty_io.c:1303 drivers/tty/tty_io.c:1415
    drivers/tty/tty_io.c:1392)
tty_open (drivers/tty/tty_io.c:2082 drivers/tty/tty_io.c:2128)
chrdev_open (fs/char_dev.c:415)
do_dentry_open (fs/open.c:921)
vfs_open (fs/open.c:1052)
...

Freed by task 4116:
kfree (mm/slab_common.c:1016)
vc_port_destruct (drivers/tty/vt/vt.c:1044)
tty_port_destructor (drivers/tty/tty_port.c:296)
tty_port_put (drivers/tty/tty_port.c:312)
vt_disallocate_all (drivers/tty/vt/vt_ioctl.c:662 (discriminator 2))
vt_ioctl (drivers/tty/vt/vt_ioctl.c:903)
tty_ioctl (drivers/tty/tty_io.c:2778)
...

The buggy address belongs to the object at ffff8880beab8800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 424 bytes inside of
 freed 1024-byte region [ffff8880beab8800, ffff8880beab8c00)

The buggy address belongs to the physical page:
page:00000000afc77580 refcount:1 mapcount:0 mapping:0000000000000000
    index:0x0 pfn:0xbeab8
head:00000000afc77580 order:3 entire_mapcount:0 nr_pages_mapped:0
    pincount:0
flags: 0xfffffc0010200(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
page_type: 0xffffffff()
raw: 000fffffc0010200 ffff888100042dc0 ffffea000426de00 dead000000000002
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880beab8880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880beab8900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880beab8980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff8880beab8a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880beab8a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
Disabling lock debugging due to kernel taint

Fixes: ac751efa6a0d ("console: rename acquire/release_console_sem() to console_lock/unlock()")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
---
v2: added "ret = -EINVAL;"

v1: This patch is similar to the recent UAF vcs_read() patches (226fae124b2d & 46d733d0efc7).
vcs_write() should have been checked for the same UAF issue at the same time the fixes went
into vcs_read().

 drivers/tty/vt/vc_screen.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 498ba9c0ee93..79a8e8189000 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -656,10 +656,17 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 			}
 		}
 
-		/* The vcs_size might have changed while we slept to grab
-		 * the user buffer, so recheck.
+		/* The vc might have been freed or vcs_size might have changed
+		 * while we slept to grab the user buffer, so recheck.
 		 * Return data written up to now on failure.
 		 */
+		vc = vcs_vc(inode, &viewed);
+		if (!vc) {
+			if (written)
+				break;
+			ret = -EINVAL;
+			goto unlock_out;
+		}
 		size = vcs_size(vc, attr, false);
 		if (size < 0) {
 			if (written)
-- 
2.31.1

