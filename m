Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4E16CA278
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjC0Ldo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0Ldm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:33:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E884B3C03
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:33:40 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RB9SfA025655;
        Mon, 27 Mar 2023 11:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=/W5deOdsFgWeGXmULFNjF9JgASqMyj1Umh0xpdv/GbQ=;
 b=FXpAm1QimbrfNyg8gHVofQhA757h+b8L65e4cwEqsGWTW2vZcJ5GE5iPmUI3w2cwMDqC
 Rrhf5iRB3d8HVCjoxWJdu9eS7H8HWxAlxCg7qr7pR5xEvUa8U8JTM2yJU9EHqLT+6y2n
 M9Af1SHU/AW2FJZcSd5WT+ry+8E32grCGL39Aqna6yM3bjpBEvcVXQ6fQBG0U9W6Srqn
 msUB9qXAMrp3PF9HPr+UHgDdGkCqEtPyl4S12YH8Kt+XoI+RMsa6aMa/CiuXNOCVi0aY
 8Wm9Vpdo+mWBwjcxu6TQqJZYDICtCa9Xm1Qhw3L6FEN59+/8lhn8Ye3EHiJWFJ+FH+qo cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pjadkxnvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 11:33:31 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32RACUF2004747;
        Mon, 27 Mar 2023 11:33:30 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pjadkxnuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 11:33:30 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32QJfqfx017824;
        Mon, 27 Mar 2023 11:33:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3phrk6tb7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 11:33:28 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32RBXOtk56164720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 11:33:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82E142004B;
        Mon, 27 Mar 2023 11:33:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3DC020043;
        Mon, 27 Mar 2023 11:33:22 +0000 (GMT)
Received: from r223l.aus.stglabs.ibm.com (unknown [9.3.109.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 27 Mar 2023 11:33:22 +0000 (GMT)
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Fabiano Rosas <farosas@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kautuk Consul <kconsul@linux.vnet.ibm.com>
Subject: [PATCH v5] KVM: PPC: Book3S HV: kvmppc_hv_entry: remove .global scope
Date:   Mon, 27 Mar 2023 07:33:20 -0400
Message-Id: <20230327113320.3407491-1-kconsul@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FmLFMqzSdOazMwgFKgpoP-5yWvgqnjBV
X-Proofpoint-ORIG-GUID: C1IwOKotwJ3PLKy910W3rSAwwFlW26L-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270090
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvmppc_hv_entry isn't called from anywhere other than
book3s_hv_rmhandlers.S itself. Removing .global scope for
this function and annotating it with SYM_CODE_START_LOCAL
and SYM_CODE_END.

Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index acf80915f406..0a9781192b86 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -502,8 +502,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
  *                                                                            *
  *****************************************************************************/
 
-.global kvmppc_hv_entry
-kvmppc_hv_entry:
+SYM_CODE_START_LOCAL(kvmppc_hv_entry)
 
 	/* Required state:
 	 *
@@ -940,6 +939,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ld	r4, VCPU_GPR(R4)(r4)
 	HRFI_TO_GUEST
 	b	.
+SYM_CODE_END(kvmppc_hv_entry)
 
 secondary_too_late:
 	li	r12, 0
-- 
2.39.2

