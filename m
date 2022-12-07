Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58F16454ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiLGHxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiLGHxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:53:11 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF38A13F7F;
        Tue,  6 Dec 2022 23:53:07 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B77Jdc3006593;
        Wed, 7 Dec 2022 07:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=fTRRkI2GBCiaUjB8L8U1clfQh8PnTIZhmwr1+IwnPyo=;
 b=miyq6+9zMknHjrZO496SoXlR7p5vGCYAqSo8m2E+HwEff3MMO5iZ98TM9Tijo+LkbIZI
 afCynM8ZkSP64m2G1/kPYVhqrSzw3/ZDg5q070Ates3KwzNxh9pJB9BOoxMgqFOE/FMV
 JK/up68MeNBcnGUAzzRPG+/vKvSjkVyHsxMgPkucQTtrzSTSiVTpQRUVZ88OVQ0aZ4CU
 W3IGOjanFN/sk2xoT9wLMMDhELW1r+xxqjniLBMZqPAnptX4jMefyUbC1xOpkbl4EvTI
 wPmQY829gv4ZIiQbnCy/VOVjA7fA4KPLkzO9ygShsN/wPQnOAkKxGO/OlP6X2H2mnQgJ 3Q== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mapbdgq6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 07:53:03 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.16.1.2) with ESMTP id 2B6DMVdG016460;
        Wed, 7 Dec 2022 07:53:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3m9m6y1w7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 07:53:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B77qxsj14615252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Dec 2022 07:52:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AF1220040;
        Wed,  7 Dec 2022 07:52:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 184CE20049;
        Wed,  7 Dec 2022 07:52:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  7 Dec 2022 07:52:59 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id C2B73E0213; Wed,  7 Dec 2022 08:52:58 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/1] tty: fix out-of-bounds access in tty_driver_lookup_tty()
Date:   Wed,  7 Dec 2022 08:52:36 +0100
Message-Id: <20221207075236.23171-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221207075236.23171-1-svens@linux.ibm.com>
References: <20221207075236.23171-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: neW-MVtlQzCSnUML-vU0I5Tk1cPpNZwV
X-Proofpoint-GUID: neW-MVtlQzCSnUML-vU0I5Tk1cPpNZwV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_04,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=754 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When specifying an invalid console= device like console=tty3270,
tty_driver_lookup_tty() returns the tty struct without checking
whether index is a valid number.

To reproduce:

qemu-system-x86_64 -enable-kvm -nographic -serial mon:stdio \
-kernel ../linux-build-x86/arch/x86/boot/bzImage \
-append "console=ttyS0 console=tty3270"

This crashes with:

[    0.748921]   No soundcards found.
[    0.749293] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    0.750125] cfg80211: failed to load regulatory.db
[    0.750611] ------------[ cut here ]------------
[    0.751100] refcount_t: saturated; leaking memory.
[    0.751603] WARNING: CPU: 0 PID: 1 at lib/refcount.c:22 refcount_warn_saturate+0x51/0x110
[    0.752438] Modules linked in:
[    0.752772] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc7-00194-gc911e8eba40a-dirty #15
[    0.753609] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-2.fc37 04/01/2014
[..]
[    0.763352] Call Trace:
[    0.763648]  <TASK>
[    0.763907]  tty_open+0x5be/0x6f0
[    0.764304]  chrdev_open+0xbd/0x230
[    0.764694]  ? cdev_device_add+0x80/0x80
[    0.765217]  do_dentry_open+0x1e0/0x410
[    0.765719]  path_openat+0xca9/0x1050
[    0.766224]  do_filp_open+0xaa/0x150
[    0.766694]  file_open_name+0x133/0x1b0
[    0.767260]  filp_open+0x27/0x50
[    0.767674]  console_on_rootfs+0x14/0x4d
[    0.768189]  kernel_init_freeable+0x1e4/0x20d
[    0.768726]  ? rest_init+0xc0/0xc0
[    0.769108]  kernel_init+0x11/0x120
[    0.769480]  ret_from_fork+0x22/0x30
[    0.769863]  </TASK>
[    0.770128] ---[ end trace 0000000000000000 ]---
[    0.770599] BUG: kernel NULL pointer dereference, address: 00000000000000ef
[    0.771265] #PF: supervisor read access in kernel mode
[    0.771773] #PF: error_code(0x0000) - not-present page
[    0.772311] PGD 0 P4D 0·
[    0.772609] Oops: 0000 [#1] PREEMPT SMP PTI
[    0.773066] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.1.0-rc7-00194-gc911e8eba40a-dirty #15
[    0.774027] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-2.fc37 04/01/2014
[    0.774878] RIP: 0010:tty_open+0x268/0x6f0
[..]
[    0.783386] Call Trace:
[    0.783715]  <TASK>
[    0.784013]  chrdev_open+0xbd/0x230
[    0.784444]  ? cdev_device_add+0x80/0x80
[    0.784920]  do_dentry_open+0x1e0/0x410
[    0.785389]  path_openat+0xca9/0x1050
[    0.785813]  do_filp_open+0xaa/0x150
[    0.786240]  file_open_name+0x133/0x1b0
[    0.786746]  filp_open+0x27/0x50
[    0.787244]  console_on_rootfs+0x14/0x4d
[    0.787800]  kernel_init_freeable+0x1e4/0x20d
[    0.788383]  ? rest_init+0xc0/0xc0
[    0.788881]  kernel_init+0x11/0x120
[    0.789356]  ret_from_fork+0x22/0x30
[    0.789842]  </TASK>
[    0.790163] Modules linked in:
[    0.790502] CR2: 00000000000000ef
[    0.790861] ---[ end trace 0000000000000000 ]---
[    0.791332] RIP: 0010:tty_open+0x268/0x6f0
[..]
[    0.799648] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[    0.800479] Kernel Offset: 0x10400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    0.801534] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 drivers/tty/tty_io.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index de06c3c2ff70..1ac6784ea1f9 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1224,14 +1224,16 @@ static struct tty_struct *tty_driver_lookup_tty(struct tty_driver *driver,
 {
 	struct tty_struct *tty;
 
-	if (driver->ops->lookup)
+	if (driver->ops->lookup) {
 		if (!file)
 			tty = ERR_PTR(-EIO);
 		else
 			tty = driver->ops->lookup(driver, file, idx);
-	else
+	} else {
+		if (idx >= driver->num)
+			return ERR_PTR(-EINVAL);
 		tty = driver->ttys[idx];
-
+	}
 	if (!IS_ERR(tty))
 		tty_kref_get(tty);
 	return tty;
-- 
2.34.1

