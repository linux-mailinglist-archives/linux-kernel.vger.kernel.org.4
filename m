Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E1F6C6117
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCWHro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjCWHrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:47:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FD718B1B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:47:38 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N6J9I4022965;
        Thu, 23 Mar 2023 07:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=TUYXsmxji0YN0qAboJerESDzRT8zPmIKsQ4n4Ur9ibA=;
 b=s2PLPXT6GtkSiVlIlwHDzKJsxgfggLuCAoxZfjeQ92fwGZmF5KzZ1tE/7r7JhURVLcmF
 rgAIIawWsQfX+OHoHmOeq3ohvMokUR2hbPkCpKJ3Eb5sTTBSwxgnxdY/GfSM0YQgBtsi
 3jUGUL4PCvaCsxLgapYCPLKAOy3yO+k403SYBccMcDnN1+J+KhLqJ+Rm8bLVQWm3J6o9
 sEUEm3oEjKBezmNTWqLr2grbuu3Uu/qHIwjJ80hNd4Arn7NqGEgnbFg9DYDxrdpRad5F
 DMCivBmIt4a09WU/EB9JeRqwk1CwHPLF9q82mlEa2WUvehoq0YnEfFVG0aq7/5+QSHjJ 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pge77dpxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 07:47:29 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32N6g4jF029094;
        Thu, 23 Mar 2023 07:47:29 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pge77dpwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 07:47:29 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32MGBhjm029417;
        Thu, 23 Mar 2023 07:47:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3pd4jff16v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 07:47:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32N7lODu23462444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 07:47:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B88720043;
        Thu, 23 Mar 2023 07:47:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D10C20040;
        Thu, 23 Mar 2023 07:47:23 +0000 (GMT)
Received: from r223l.aus.stglabs.ibm.com (unknown [9.3.109.14])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Mar 2023 07:47:22 +0000 (GMT)
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Fabiano Rosas <farosas@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kautuk Consul <kconsul@linux.vnet.ibm.com>
Subject: [PATCH] arch/powerpc/kvm: kvmppc_core_vcpu_create_hv: check for kzalloc failure
Date:   Thu, 23 Mar 2023 03:47:18 -0400
Message-Id: <20230323074718.2810914-1-kconsul@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IyPP7A4fa8iYMef587CjzLjDnLJwINAH
X-Proofpoint-ORIG-GUID: DHrc5KlRSNEB_noN4oDiBoBXr4_5AQRx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230057
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvmppc_vcore_create() might not be able to allocate memory through
kzalloc. In that case the kvm->arch.online_vcores shouldn't be
incremented.
Add a check for kzalloc failure and return with -ENOMEM from
kvmppc_core_vcpu_create_hv().

Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 6ba68dd6190b..e29ee755c920 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2968,13 +2968,17 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
 			pr_devel("KVM: collision on id %u", id);
 			vcore = NULL;
 		} else if (!vcore) {
+			vcore = kvmppc_vcore_create(kvm,
+					id & ~(kvm->arch.smt_mode - 1));
+			if (unlikely(!vcore)) {
+				mutex_unlock(&kvm->lock);
+				return -ENOMEM;
+			}
+
 			/*
 			 * Take mmu_setup_lock for mutual exclusion
 			 * with kvmppc_update_lpcr().
 			 */
-			err = -ENOMEM;
-			vcore = kvmppc_vcore_create(kvm,
-					id & ~(kvm->arch.smt_mode - 1));
 			mutex_lock(&kvm->arch.mmu_setup_lock);
 			kvm->arch.vcores[core] = vcore;
 			kvm->arch.online_vcores++;
-- 
2.39.2

