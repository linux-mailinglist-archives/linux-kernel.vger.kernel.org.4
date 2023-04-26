Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AA56EFABC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjDZTMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbjDZTMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:12:13 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E36C133;
        Wed, 26 Apr 2023 12:12:10 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QJ9dwD028793;
        Wed, 26 Apr 2023 19:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=yhvrAIKR5O57Y5/51eA5aOty3mrW59iWoKUgs2oPvAQ=;
 b=H/PJ+d8IO01PGaMx8ecDjU40okUO18C8qBr2ImM4Pp6VBkuvVuZGSN+CxsqRC8HucE0T
 jQKg9mUUiGdQ1I7/tUqOH5/jehwnybZUtKMGK8pITFKTl4U3kU9hqL/H6NNx50xfmVaP
 vrjj/bVkFIc/y58KvRc+0I6xPJDVZAO7F+BOItIx9F5jzsMRlXn/grV0jGVf14IuttAn
 BexiSvvAarQ/lX9YWXgHzC8zkIHWpu2Zdw8NjbLF0N0rlJIFGuGfFXU6+ultiZP/QtOD
 hZtBxv8a4v7i/j1JnuePzgFPInPU/TqRxmvyaNutTDVdM6WwTc8FpjzuEH71eSb9s3mP Ag== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q78023apk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 19:11:53 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33QIYbWi009083;
        Wed, 26 Apr 2023 19:11:52 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3q4778cgba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 19:11:52 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33QJBoqh36438288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 19:11:50 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71C4C58059;
        Wed, 26 Apr 2023 19:11:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CCE258055;
        Wed, 26 Apr 2023 19:11:50 +0000 (GMT)
Received: from ltcden12-lp3.aus.stglabs.ibm.com (unknown [9.40.195.53])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 26 Apr 2023 19:11:50 +0000 (GMT)
From:   Danny Tsen <dtsen@linux.ibm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com,
        Danny Tsen <dtsen@linux.ibm.com>
Subject: [PATCH v2 0/5] crypto: Accelerated Chacha20/Poly1305 implementation
Date:   Wed, 26 Apr 2023 15:11:42 -0400
Message-Id: <20230426191147.60610-1-dtsen@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1iYHzCvbW89hit0Gy51rS9MZavwYgW2Q
X-Proofpoint-ORIG-GUID: 1iYHzCvbW89hit0Gy51rS9MZavwYgW2Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=536 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304260169
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series provide an accelerated/optimized Chacha20 and Poly1305
implementation for Power10 or later CPU (ppc64le).  This module
implements algorithm specified in RFC7539.  The implementation
provides 3.5X better performance than the baseline for Chacha20 and
Poly1305 individually and 1.5X improvement for Chacha20/Poly1305
operation.

This patch has been tested with the kernel crypto module tcrypt.ko and
has passed the selftest.  The patch is also tested with
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS enabled.


Danny Tsen (5):
  An optimized Chacha20 implementation with 8-way unrolling for ppc64le.
  Glue code for optmized Chacha20 implementation for ppc64le.
  An optimized Poly1305 implementation with 4-way unrolling for ppc64le.
  Glue code for optmized Poly1305 implementation for ppc64le.
  Update Kconfig and Makefile.

 arch/powerpc/crypto/Kconfig             |   26 +
 arch/powerpc/crypto/Makefile            |    4 +
 arch/powerpc/crypto/chacha-p10-glue.c   |  221 +++++
 arch/powerpc/crypto/chacha-p10le-8x.S   |  842 ++++++++++++++++++
 arch/powerpc/crypto/poly1305-p10-glue.c |  186 ++++
 arch/powerpc/crypto/poly1305-p10le_64.S | 1075 +++++++++++++++++++++++
 6 files changed, 2354 insertions(+)
 create mode 100644 arch/powerpc/crypto/chacha-p10-glue.c
 create mode 100644 arch/powerpc/crypto/chacha-p10le-8x.S
 create mode 100644 arch/powerpc/crypto/poly1305-p10-glue.c
 create mode 100644 arch/powerpc/crypto/poly1305-p10le_64.S

-- 
2.31.1

