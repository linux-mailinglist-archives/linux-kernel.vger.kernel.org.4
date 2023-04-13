Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A236E1564
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjDMTrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDMTrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:47:01 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBBC65BA;
        Thu, 13 Apr 2023 12:47:00 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DJkdeS010136;
        Thu, 13 Apr 2023 19:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UtfWhfePeY3iT6Yd0gWI/Qu25dAx2vch014M/4BoIJI=;
 b=c6hUfGDs4UW/GIJTOW9Pllpg99UqzQGz3xRDkYoqv10iMuUOf1kG7MxFsrI8TZSJKUje
 62lQvyAumY29QjNu9XzVmpDxLPnf8PMdNqz6IqDRgDgirLfKo7SQBqjvyltphFqHTJsS
 soHvFIS6JbaFcMB3xmUzVzsJpg46id6TyiTg1d/hp9HjGTBfLkq6pljSBYtoQBFD8gZw
 29PXZxNHn1P/OOLGP3qqR/5XfXKgYji8AfCJmQAZ53Tbxm8KaI+BM6hj197wq8ak+CzW
 7zOMUg8neLDcLKDEtXkcN9v6DRX2MYGT6iapsY3kxdSVFxiiTaQGjh3rQfz3l2PmAQ/n 5w== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pxmf6hrxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 19:46:47 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33DHiFs2029810;
        Thu, 13 Apr 2023 19:46:46 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3pu0fqvad3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 19:46:46 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33DJkjH112255912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 19:46:45 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E80FA58054;
        Thu, 13 Apr 2023 19:46:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B5795803F;
        Thu, 13 Apr 2023 19:46:44 +0000 (GMT)
Received: from ltcden12-lp3.aus.stglabs.ibm.com (unknown [9.40.195.53])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 13 Apr 2023 19:46:44 +0000 (GMT)
From:   Danny Tsen <dtsen@linux.ibm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com,
        Danny Tsen <dtsen@linux.ibm.com>
Subject: [PATCH v2 2/2] Move Power10 feature, PPC_MODULE_FEATURE_P10.
Date:   Thu, 13 Apr 2023 15:46:25 -0400
Message-Id: <20230413194625.10631-3-dtsen@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230413194625.10631-1-dtsen@linux.ibm.com>
References: <20230413194625.10631-1-dtsen@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _8sKyKnqj3QIYZrqgbZvE0vIdD2ph8Nm
X-Proofpoint-ORIG-GUID: _8sKyKnqj3QIYZrqgbZvE0vIdD2ph8Nm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_14,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=783
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130174
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move Power10 feature, PPC_MODULE_FEATURE_P10, definition to be in
arch/powerpc/include/asm/cpufeature.h.

Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
---
 arch/powerpc/crypto/aes-gcm-p10-glue.c | 1 -
 arch/powerpc/include/asm/cpufeature.h  | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/crypto/aes-gcm-p10-glue.c b/arch/powerpc/crypto/aes-gcm-p10-glue.c
index 1533c8cdd26f..bd3475f5348d 100644
--- a/arch/powerpc/crypto/aes-gcm-p10-glue.c
+++ b/arch/powerpc/crypto/aes-gcm-p10-glue.c
@@ -22,7 +22,6 @@
 #include <linux/module.h>
 #include <linux/types.h>
 
-#define PPC_MODULE_FEATURE_P10	(32 + ilog2(PPC_FEATURE2_ARCH_3_1))
 #define	PPC_ALIGN		16
 #define GCM_IV_SIZE		12
 
diff --git a/arch/powerpc/include/asm/cpufeature.h b/arch/powerpc/include/asm/cpufeature.h
index f6f790a90367..2dcc66225e7f 100644
--- a/arch/powerpc/include/asm/cpufeature.h
+++ b/arch/powerpc/include/asm/cpufeature.h
@@ -22,6 +22,7 @@
  */
 
 #define PPC_MODULE_FEATURE_VEC_CRYPTO			(32 + ilog2(PPC_FEATURE2_VEC_CRYPTO))
+#define PPC_MODULE_FEATURE_P10				(32 + ilog2(PPC_FEATURE2_ARCH_3_1))
 
 #define cpu_feature(x)		(x)
 
-- 
2.31.1

