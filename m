Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B2E69D957
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjBUDkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjBUDkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:40:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029C623C5F;
        Mon, 20 Feb 2023 19:40:31 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31L3WlfP024053;
        Tue, 21 Feb 2023 03:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=/GVb4wycuCVNhEAc0NlG98fXAINLCXANvJ5816SChDU=;
 b=nFtIc9LhUDFiMGLf87urMoWqSWR9RbcH13pH+qlt+EngpG/kdmM48xhlUlnXnhjVRpZD
 FDHXyDOp3LKXxXXpgyfUSzvyF2TBOe9C8D5xS1BdJuvEILNBMAv5lJgYWbwRBT7zfeW9
 qFnKo32fejnUdtPe0J44DinKpgUvnhwesCL2ddTdSTQjRRwSmdIJgpIXYkcLLU0LHgGF
 /nLbn9Kc4wlwQwxGAvqePC0H0F1RzdiLMv5xbwvyMmgx0cCpohRN8jSan6P81A2zNGaX
 nmHfZcNOqyPE1QrXSmYkHeXxQTGsv1IZvDTbzKzetHMrAe6NDv7fRvw87fYt0rIfjfxr 9A== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nvjbcckfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 03:40:26 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31L3UfSC005310;
        Tue, 21 Feb 2023 03:40:25 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3ntpa6vru9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 03:40:25 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31L3eOCA1835720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 03:40:24 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1025358058;
        Tue, 21 Feb 2023 03:40:24 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA91358057;
        Tue, 21 Feb 2023 03:40:23 +0000 (GMT)
Received: from ltcden12-lp3.aus.stglabs.ibm.com (unknown [9.40.195.53])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Feb 2023 03:40:23 +0000 (GMT)
From:   Danny Tsen <dtsen@linux.ibm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, ltcgcw@linux.vnet.ibm.com,
        dtsen@us.ibm.com, Danny Tsen <dtsen@linux.ibm.com>
Subject: [RESEND PATCH v4 0/6] crypto: Accelerated AES/GCM stitched implementation
Date:   Mon, 20 Feb 2023 22:40:15 -0500
Message-Id: <20230221034021.15121-1-dtsen@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fKmMe0R9VfaNit1oNHgqaE9BsZOnk1hg
X-Proofpoint-ORIG-GUID: fKmMe0R9VfaNit1oNHgqaE9BsZOnk1hg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_19,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=532 lowpriorityscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210030
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enable an accelerated AES/GCM stitched implementation
for Power10 or later CPU(ppc64le).  This module supports AEAD algorithm.
The stitched implementation provides 3.5X+ better performance than the
baseline.

This patch has been tested with the kernel crypto module tcrypt.ko and
has passed the selftest.  The patch is also tested with
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS enabled.

Danny Tsen (6):
  Glue code for AES/GCM stitched implementation.
  An accelerated AES/GCM stitched implementation.
  Supporting functions for AES.
  Supporting functions for ghash.
  A perl script to process PowerPC assembler source.
  Update Kconfig and Makefile.

 arch/powerpc/crypto/aes-gcm-p10-glue.c |  345 ++++++
 arch/powerpc/crypto/aes-gcm-p10.S      | 1521 ++++++++++++++++++++++++
 arch/powerpc/crypto/aesp8-ppc.pl       |  585 +++++++++
 arch/powerpc/crypto/ghashp8-ppc.pl     |  370 ++++++
 arch/powerpc/crypto/ppc-xlate.pl       |  229 ++++
 arch/powerpc/crypto/Kconfig            |   17 +
 arch/powerpc/crypto/Makefile           |   13 +
 7 files changed, 3080 insertions(+)
 create mode 100644 arch/powerpc/crypto/aes-gcm-p10-glue.c
 create mode 100644 arch/powerpc/crypto/aes-gcm-p10.S
 create mode 100644 arch/powerpc/crypto/aesp8-ppc.pl
 create mode 100644 arch/powerpc/crypto/ghashp8-ppc.pl
 create mode 100644 arch/powerpc/crypto/ppc-xlate.pl

-- 
2.31.1

