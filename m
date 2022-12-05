Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5A76420C5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 01:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiLEAfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 19:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiLEAfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 19:35:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4325ADF03;
        Sun,  4 Dec 2022 16:35:13 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B4LOElN031367;
        Mon, 5 Dec 2022 00:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Ww2kztcN/J/ICRB7ps8+D5a4H/sLs5jeOgAdPXpmvsg=;
 b=gWoq2HYBaKpoQD9P7DxNjjU6AB4Z+dbylX0Zvli4CX8D6516u23kS/Ld9ZsOd3I3y0S+
 WqCCbgCZtee3zUXK/UwiEpBcUUGqYUAqPhQOXE0s+cnfM4tABTdhPm7PUYpRFjpMaviG
 9z6wZQ0fiW7DVrFdRxfLAbQBLsFiddxh0I8InNyUo/LrvicEfAjDb0iWkXA7hlS3CbPG
 e5XI19LqDOzfQPpD0TlhYAvg6DgFcpRfjOgdL4BipbrOAxD7AXkjniIdv0npW6SZxTII
 6sA8KfgHcWx/9IjN9cxKFtBrZsBcB2xzWn+PKp3x+xPmoqXbvFqMyyZGDwmQIS3OANW/ DA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m8gd0u98q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 00:35:05 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B50LA4S010889;
        Mon, 5 Dec 2022 00:35:04 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma02wdc.us.ibm.com with ESMTP id 3m7x39j8s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 00:35:04 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B50Z2AW16908872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Dec 2022 00:35:02 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A23865804E;
        Mon,  5 Dec 2022 00:35:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E85258055;
        Mon,  5 Dec 2022 00:35:02 +0000 (GMT)
Received: from ltcden12-lp3.aus.stglabs.ibm.com (unknown [9.40.195.53])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  5 Dec 2022 00:35:02 +0000 (GMT)
From:   Danny Tsen <dtsen@linux.ibm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, ltcgcw@linux.vnet.ibm.com,
        dtsen@linux.ibm.com
Subject: [PATCH v2 0/6] crypto: Accelerated AES/GCM stitched implementation
Date:   Sun,  4 Dec 2022 19:34:52 -0500
Message-Id: <20221205003458.4182-1-dtsen@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TPuqeMhfML8WLHhkff2iLGRNSqRTA_fI
X-Proofpoint-ORIG-GUID: TPuqeMhfML8WLHhkff2iLGRNSqRTA_fI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-04_16,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxlogscore=582
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212050001
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enable an accelerated AES/GCM stitched implementation for
Power10+ CPU(ppc64le).  This module supports AEAD algorithm.  The stitched
implementation provides 3.5X+ better performance than the baseline.

This patch has been tested with the kernel crypto module tcrypt.ko and has
passed the selftest.  The patch is also tested with
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS enabled

Danny Tsen (6):
  Patch1: Update Kconfig and Makefile.
  Patch2: Glue code for AES/GCM stitched implementation.
  Patch3: An accelerated AES/GCM stitched implementation.
  Patch4: Supporting functions for AES.
  Patch5: Supporting functions for ghash.
  Patch6: A perl script to process PowerPC assembler source.

 arch/powerpc/crypto/Kconfig            |   11 +
 arch/powerpc/crypto/Makefile           |   10 +
 arch/powerpc/crypto/aesp8-ppc.pl       | 3846 ++++++++++++++++++++++++
 arch/powerpc/crypto/ghashp8-ppc.pl     |  370 +++
 arch/powerpc/crypto/p10-aes-gcm-glue.c |  345 +++
 arch/powerpc/crypto/p10_aes_gcm.S      | 1519 ++++++++++
 arch/powerpc/crypto/ppc-xlate.pl       |  229 ++
 7 files changed, 6330 insertions(+)
 create mode 100644 arch/powerpc/crypto/aesp8-ppc.pl
 create mode 100644 arch/powerpc/crypto/ghashp8-ppc.pl
 create mode 100644 arch/powerpc/crypto/p10-aes-gcm-glue.c
 create mode 100644 arch/powerpc/crypto/p10_aes_gcm.S
 create mode 100644 arch/powerpc/crypto/ppc-xlate.pl

-- 
2.31.1

