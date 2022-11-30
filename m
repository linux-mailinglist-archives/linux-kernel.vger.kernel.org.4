Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D7B63D0F3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbiK3IoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiK3Inx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:43:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9452FA4F;
        Wed, 30 Nov 2022 00:43:34 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AU888jq008576;
        Wed, 30 Nov 2022 08:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=wGbf741YqFg4O19GQu2oZornlXONeb3hN86RQUCoA8g=;
 b=tZSrXRl3A+lk8kaTd2PmE2b9xIaqUXdSooYvrDOZNb0ELC+5MxEXovAL9e3EKd/ShbbQ
 hMFL0LSzzBz03lBnbrsqnily+LWBtTTJjlt9/zCsevCpJsmiGdo24WxbNZP6RQbqGH4T
 UoR/lXRapGoXUJ7qKw/kT6n9gazMRSg7p98x/WSEhEJQlnrRHWr9kh3XUhkDs++ACZXu
 SuBgzBe6rhB1iWbmDHxjwQnM4psC3d84y+t/eVqxLnn2nthQQ2N7XVOOZpWhRqgortGp
 EZtznbG5MbGVbscvOffq3K0NcmUOrgmK3IZoYIKhDhOusPnA20ARBBxpS0gaHFFVS88x qQ== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m607rd4tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 08:42:24 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AU8ZVgk003829;
        Wed, 30 Nov 2022 08:42:22 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 3m3ae9jp7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 08:42:22 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AU8gLFR18416516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Nov 2022 08:42:21 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3550F5806D;
        Wed, 30 Nov 2022 08:42:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C03F258060;
        Wed, 30 Nov 2022 08:42:20 +0000 (GMT)
Received: from ltcden12-lp3.aus.stglabs.ibm.com (unknown [9.40.195.53])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 30 Nov 2022 08:42:20 +0000 (GMT)
From:   Danny Tsen <dtsen@linux.ibm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, ltcgcw@linux.vnet.ibm.com,
        dtsen@linux.ibm.com
Subject: [RESEND PATCH 0/6] crypto: Accelerated AES/GCM stitched implementation
Date:   Wed, 30 Nov 2022 03:42:05 -0500
Message-Id: <20221130084211.48154-1-dtsen@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XrOthgGLX7U8fIwVnM7DuSnhmd4ou8XG
X-Proofpoint-ORIG-GUID: XrOthgGLX7U8fIwVnM7DuSnhmd4ou8XG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=557
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211300062
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
passed the selftest.

Danny Tsen (6):
  Patch 0: Update Kconfig and Makefile.
  Patch 1: Glue code for AES/GCM stitched implementation for Power10+
    CPU(ppc64le).
  Patch 3: An accelerated AES/GCM stitched implementation.
  Patch 4: Supporting functions for AES.
  Patch 5: Supporting functions to ghash.
  Patch 6: A perl script to process PowerPC assembler.

 arch/powerpc/crypto/Kconfig            |   11 +
 arch/powerpc/crypto/Makefile           |   10 +
 arch/powerpc/crypto/aesp8-ppc.pl       | 3846 ++++++++++++++++++++++++
 arch/powerpc/crypto/ghashp8-ppc.pl     |  370 +++
 arch/powerpc/crypto/p10-aes-gcm-glue.c |  341 +++
 arch/powerpc/crypto/p10_aes_gcm.S      | 1519 ++++++++++
 arch/powerpc/crypto/ppc-xlate.pl       |  229 ++
 7 files changed, 6326 insertions(+)
 create mode 100644 arch/powerpc/crypto/aesp8-ppc.pl
 create mode 100644 arch/powerpc/crypto/ghashp8-ppc.pl
 create mode 100644 arch/powerpc/crypto/p10-aes-gcm-glue.c
 create mode 100644 arch/powerpc/crypto/p10_aes_gcm.S
 create mode 100644 arch/powerpc/crypto/ppc-xlate.pl

-- 
2.31.1

