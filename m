Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9B965BB27
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbjACHUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 02:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjACHUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:20:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A3EA47C;
        Mon,  2 Jan 2023 23:20:38 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3032ftfb015083;
        Tue, 3 Jan 2023 07:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0WI9esVpndro8n3pvm3y/FeUtSxwl2+r+I4pJj3DJ9U=;
 b=I5GCGanL7C1q9vLCPD2vIXYzBysKkZ9RcJyoH3ZCFnOabGLK6JavXnwDwJnMjJ8G/4He
 xtLa4aH+gQHkN89WRblCzi4BkXXQZuboGHDHFxxxTv5krv+9xkhX0gwBUnlaVH1u0y6+
 KHGP3nkQa1+I0uj/BxT06COUoioOBUm+NhJ3Mo/QlqtLqiJKBRZbqB25Edp1v6ghK2vp
 87LB39MONflhrUWbrPR6iQX5JFtW+7/SEpBmu5XtZ6iXb/xEmluSe5hq/eR/TGQ7nKp5
 a10pawy9iDmcYGnsPTwC5ruThHqmycnMunu4I9E6WudqlbJ04AoSMvfYFOERbyAYano+ hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvbt6utey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 07:20:08 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3037ARwD016089;
        Tue, 3 Jan 2023 07:20:07 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvbt6ute9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 07:20:07 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 302La9fB012120;
        Tue, 3 Jan 2023 07:20:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6aggf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 07:20:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3037K2vI45285644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jan 2023 07:20:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 759F22004D;
        Tue,  3 Jan 2023 07:20:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6669A20040;
        Tue,  3 Jan 2023 07:20:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Jan 2023 07:20:02 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 36533E0959; Tue,  3 Jan 2023 08:20:02 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Willy Tarreau <w@1wt.eu>, "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 3/5] selftests/nolibc: add s390 support
Date:   Tue,  3 Jan 2023 08:19:55 +0100
Message-Id: <20230103071957.222360-4-svens@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103071957.222360-1-svens@linux.ibm.com>
References: <20230103071957.222360-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Tfo8WX7ZY92X5D8TbsiUw4Y_5a98V869
X-Proofpoint-GUID: AS9_LeugtFfdSvXZSAV3QP8RK9_5Z3YH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_14,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
---
 tools/testing/selftests/nolibc/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 22f1e1d73fa8..2bf613ee363d 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -19,6 +19,7 @@ IMAGE_arm64   = arch/arm64/boot/Image
 IMAGE_arm     = arch/arm/boot/zImage
 IMAGE_mips    = vmlinuz
 IMAGE_riscv   = arch/riscv/boot/Image
+IMAGE_s390    = arch/s390/boot/bzImage
 IMAGE         = $(IMAGE_$(ARCH))
 IMAGE_NAME    = $(notdir $(IMAGE))
 
@@ -29,6 +30,7 @@ DEFCONFIG_arm64   = defconfig
 DEFCONFIG_arm     = multi_v7_defconfig
 DEFCONFIG_mips    = malta_defconfig
 DEFCONFIG_riscv   = defconfig
+DEFCONFIG_s390    = defconfig
 DEFCONFIG         = $(DEFCONFIG_$(ARCH))
 
 # optional tests to run (default = all)
@@ -41,6 +43,7 @@ QEMU_ARCH_arm64   = aarch64
 QEMU_ARCH_arm     = arm
 QEMU_ARCH_mips    = mipsel  # works with malta_defconfig
 QEMU_ARCH_riscv   = riscv64
+QEMU_ARCH_s390    = s390x
 QEMU_ARCH         = $(QEMU_ARCH_$(ARCH))
 
 # QEMU_ARGS : some arch-specific args to pass to qemu
@@ -50,6 +53,7 @@ QEMU_ARGS_arm64   = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TE
 QEMU_ARGS_arm     = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips    = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv   = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_s390    = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS         = $(QEMU_ARGS_$(ARCH))
 
 # OUTPUT is only set when run from the main makefile, otherwise
@@ -62,7 +66,8 @@ else
 Q=@
 endif
 
-CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables
+CFLAGS_s390 = -m64
+CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables $(CFLAGS_$(ARCH))
 LDFLAGS := -s
 
 help:
-- 
2.34.1

