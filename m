Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13ED669D519
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjBTUmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjBTUml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:42:41 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BADD536;
        Mon, 20 Feb 2023 12:42:40 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KIWfXI011955;
        Mon, 20 Feb 2023 20:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=wYQM81MhR49i4sTY6/pc0BUgIjZhL7lVYao9JfJz3ag=;
 b=ObtJRsB1+sf2mMQqA0pzM5w4ZqeQ7cPnTACwEzcwVNrrcGFKgf/PGp6GvAD6upkp4MrK
 okcky5b+I39IcksEjXhb+v2SgLU6d9y5FhUznRIMocdQktvZ81xfI15vv7n1212WB+QD
 /gi6i+v0LuOh8yUeb0YF0MgqqMV1TFASuyryrvyXTCma5B6EKDTCdUD04FMGhcdcw8mR
 YkFRwHWMxVs3e/CgOdCSEieWtwwLvAAVJxp+u7sCCHVxozknnnKPmYeFczohjd0jFkDx
 ok03H4k9/5tJPDnvH0YyA4rwryyl0tw2JHDGKKx7gnm1RXr1QQ/L9Oc9419HuWqiv7GI KA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nvbudwrwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 20:42:33 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31KICCRY019800;
        Mon, 20 Feb 2023 20:42:32 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3ntpa72t2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 20:42:32 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31KKgUxl9634498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 20:42:30 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 838DD5805A;
        Mon, 20 Feb 2023 20:42:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5496158061;
        Mon, 20 Feb 2023 20:42:30 +0000 (GMT)
Received: from ltcden12-lp3.aus.stglabs.ibm.com (unknown [9.40.195.53])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Feb 2023 20:42:30 +0000 (GMT)
From:   Danny Tsen <dtsen@linux.ibm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, ltcgcw@linux.vnet.ibm.com,
        dtsen@us.ibm.com, Danny Tsen <dtsen@linux.ibm.com>
Subject: [PATCH v4 0/6] crypto: Accelerated AES/GCM stitched implementation
Date:   Mon, 20 Feb 2023 15:42:18 -0500
Message-Id: <20230220204224.4907-1-dtsen@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0hBkHiHPywJ7LGUW2w9t9Q4R_OisFGX6
X-Proofpoint-ORIG-GUID: 0hBkHiHPywJ7LGUW2w9t9Q4R_OisFGX6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_17,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=532 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200190
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
  Update Kconfig and Makefile.
  Glue code for AES/GCM stitched implementation.
  An accelerated AES/GCM stitched implementation.
  Supporting functions for AES.
  Supporting functions for ghash.
  A perl script to process PowerPC assembler source.

 arch/powerpc/crypto/Kconfig            |   17 +
 arch/powerpc/crypto/Makefile           |   13 +
 arch/powerpc/crypto/aes-gcm-p10-glue.c |  345 ++++++
 arch/powerpc/crypto/aes-gcm-p10.S      | 1521 ++++++++++++++++++++++++
 arch/powerpc/crypto/aesp8-ppc.pl       |  585 +++++++++
 arch/powerpc/crypto/ghashp8-ppc.pl     |  370 ++++++
 arch/powerpc/crypto/ppc-xlate.pl       |  229 ++++
 7 files changed, 3080 insertions(+)
 create mode 100644 arch/powerpc/crypto/aes-gcm-p10-glue.c
 create mode 100644 arch/powerpc/crypto/aes-gcm-p10.S
 create mode 100644 arch/powerpc/crypto/aesp8-ppc.pl
 create mode 100644 arch/powerpc/crypto/ghashp8-ppc.pl
 create mode 100644 arch/powerpc/crypto/ppc-xlate.pl

-- 
2.31.1

