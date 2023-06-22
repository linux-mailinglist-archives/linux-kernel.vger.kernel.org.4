Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D87173A147
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFVMzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjFVMzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:55:21 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5511F10F6;
        Thu, 22 Jun 2023 05:55:20 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MChoZZ013565;
        Thu, 22 Jun 2023 12:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=VCuQ5gG0TnmWKwG3oiEM5w2mHyN88iriwTagvgLQmcU=;
 b=c+dtaSjcSvGfhD0Q0YpVtpB7jrw6Zh/xvb02vkBBKTlfgSXnWPOkCdocp/X+3CrrXP4L
 aNBO8RMapv9ZEzNmR6B9Y4qCzNzx+o7dOStao2bwZX5a0D5RJsn4fD0XJEj+ffwdSTkf
 dbPAD9kMq0PwspVUg1YaxjdqjR+woGgkiZ1BhwW0Q0nUtmNGKyCrU/DTtEUjzncTsn/R
 CPtvfRBqpWq3gLj3MZxiWHuDhEMajZBgoRagByOxkEF1kH7uDmGUcLGX5lJWvVXXy7jI
 s1uHjcKdijSRAre8XSaRl2O5G2HvQqc6b7+jvAY6wZhA4mtr8n+YpXU1ObuN3UcMdFcT oA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rcpj78a3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 12:55:16 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35M8G2WO024574;
        Thu, 22 Jun 2023 12:55:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3r94f5ammx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 12:55:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35MCt9j624576588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 12:55:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79D6B20043;
        Thu, 22 Jun 2023 12:55:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FEB82004F;
        Thu, 22 Jun 2023 12:55:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 22 Jun 2023 12:55:09 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390/decompresser: fix misaligned symbol build error
Date:   Thu, 22 Jun 2023 14:55:08 +0200
Message-Id: <20230622125508.1068457-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: asdIpcSa8pPfj8Xz50nagA6-Sp0SJTWT
X-Proofpoint-ORIG-GUID: asdIpcSa8pPfj8Xz50nagA6-Sp0SJTWT
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_08,2023-06-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 adultscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Chancellor reported a kernel build error on Fedora 39:

$ clang --version | head -1
clang version 16.0.5 (Fedora 16.0.5-1.fc39)

$ s390x-linux-gnu-ld --version | head -1
GNU ld version 2.40-1.fc39

$ make -skj"$(nproc)" ARCH=s390 CC=clang CROSS_COMPILE=s390x-linux-gnu- olddefconfig all
s390x-linux-gnu-ld: arch/s390/boot/startup.o(.text+0x5b4): misaligned symbol `_decompressor_end' (0x35b0f) for relocation R_390_PC32DBL
make[3]: *** [.../arch/s390/boot/Makefile:78: arch/s390/boot/vmlinux] Error 1

It turned out that the problem with misaligned symbols on s390 was fixed
with commit 80ddf5ce1c92 ("s390: always build relocatable kernel") for the
kernel image, but did not take into account that the decompressor uses its
own set of CFLAGS, which come without -fPIE.

Add the -fPIE flag also to the decompresser CFLAGS to fix this.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1747
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index ed646c583e4f..5ed242897b0d 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -27,6 +27,7 @@ KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float -mbac
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS_DECOMPRESSOR += -ffreestanding
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-stack-protector
+KBUILD_CFLAGS_DECOMPRESSOR += -fPIE
 KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
-- 
2.39.2

