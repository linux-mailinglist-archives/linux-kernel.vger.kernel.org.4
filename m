Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F5C6D7D64
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbjDENI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbjDENIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:08:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413C326B5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:08:51 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335CpVop002581;
        Wed, 5 Apr 2023 13:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YLC5DyLtSVY9Z631MedS+QciMKxQjYi7jR36VQdpBzU=;
 b=iqrD7TW5VTcc/qM5gxuIrwKF1NtLp63KG+l62udZWK8vr3b+9PSMZCVBj9z3dL5uzQvE
 1nps5F5onbudadg1RD2w+Jt4rhDV2pjRRDngzRsbokYFkxfazwfxkqncrZbd6Ju8xB/v
 M+u1PXU9UYWpEJobp2BFbb/9S6ObjezpI+o+p2i/G7aFR9+PnNc/neSmV1Fkh6DuSu8X
 9FKB2HzlGPrS8W3CeF0qkJInEYuyzgYyLBiKHRCNAPP/LJ8LhSG1EVuLEzd8wPE4E4Y5
 811VqdmINVfG/jhCv9tsYwOXuyWtmsP4wrcqtSh05BuBeQgKf7zDWwMCXR831IgDc0G6 lA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps9bu0f0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 13:08:47 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3352efkZ008120;
        Wed, 5 Apr 2023 13:08:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3ppc86thgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 13:08:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335D8gu046465506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 13:08:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4234320040;
        Wed,  5 Apr 2023 13:08:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1982B2004F;
        Wed,  5 Apr 2023 13:08:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Apr 2023 13:08:42 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Popov <alex.popov@linux.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] stackleak: allow to specify arch specific stackleak poison function
Date:   Wed,  5 Apr 2023 15:08:40 +0200
Message-Id: <20230405130841.1350565-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230405130841.1350565-1-hca@linux.ibm.com>
References: <20230405130841.1350565-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Uw8LdDd2vKJJ72mjj2aQiNEsmV92oUUn
X-Proofpoint-ORIG-GUID: Uw8LdDd2vKJJ72mjj2aQiNEsmV92oUUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_08,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304050118
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the code that fills the stack with the stackleak poison value
in order to allow architectures to provide a faster implementation.

Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 kernel/stackleak.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index c2c33d2202e9..34c9d81eea94 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -70,6 +70,18 @@ late_initcall(stackleak_sysctls_init);
 #define skip_erasing()	false
 #endif /* CONFIG_STACKLEAK_RUNTIME_DISABLE */
 
+#ifndef __stackleak_poison
+static __always_inline void __stackleak_poison(unsigned long erase_low,
+					       unsigned long erase_high,
+					       unsigned long poison)
+{
+	while (erase_low < erase_high) {
+		*(unsigned long *)erase_low = poison;
+		erase_low += sizeof(unsigned long);
+	}
+}
+#endif
+
 static __always_inline void __stackleak_erase(bool on_task_stack)
 {
 	const unsigned long task_stack_low = stackleak_task_low_bound(current);
@@ -101,10 +113,7 @@ static __always_inline void __stackleak_erase(bool on_task_stack)
 	else
 		erase_high = task_stack_high;
 
-	while (erase_low < erase_high) {
-		*(unsigned long *)erase_low = STACKLEAK_POISON;
-		erase_low += sizeof(unsigned long);
-	}
+	__stackleak_poison(erase_low, erase_high, STACKLEAK_POISON);
 
 	/* Reset the 'lowest_stack' value for the next syscall */
 	current->lowest_stack = task_stack_high;
-- 
2.37.2

