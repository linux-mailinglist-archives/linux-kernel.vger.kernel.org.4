Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FED651541
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiLSWDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiLSWDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:03:20 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9045A140C7;
        Mon, 19 Dec 2022 14:03:19 -0800 (PST)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJKsZRw018294;
        Mon, 19 Dec 2022 22:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=I6XKT/Pcf2+1kXWaQqbl3UWdCnYWXaqzJLkuul+7CVE=;
 b=D4P6AjoZHDeS94X51/5MPD7RQ8nRac65Iyn+ZTKFVfPanU0/oMOsd8ixWba7jamocAzi
 y38XUKZzvJpszmLjyQ3uQknffSNFQlIrbCvWzuarR/mHjvVQWyQDWo64Dq9+sB1pQtJM
 KjegFI2S18Hbkq05ByYKyB8cSPSYNpD6REA7POOabUZOqP/0fcB+NN2oDkCFWHKo2ClF
 k4l6lEIOgUnMWkeA/mHJfKSYojyU6z5W3JCfvuJ3qr8rZ6DL6p9BDoEhN0xQiyn5RlC1
 MJnbgQtCYZ185A54VHaNlBDGtkUR0y62l8o4iIJtlHEBEgCbsRkK7ZvDa2E/Do+B40cg Ew== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mjyd9rckj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 22:02:44 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id C5288807116;
        Mon, 19 Dec 2022 22:02:43 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id EC3FA805634;
        Mon, 19 Dec 2022 22:02:42 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, Jason@zx2c4.com,
        ardb@kernel.org, ap420073@gmail.com, David.Laight@ACULAB.COM,
        ebiggers@kernel.org, tim.c.chen@linux.intel.com, peter@n8pjl.ca,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 01/13] x86:  protect simd.h header file
Date:   Mon, 19 Dec 2022 16:02:11 -0600
Message-Id: <20221219220223.3982176-2-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219220223.3982176-1-elliott@hpe.com>
References: <20221219220223.3982176-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: k_vQFl1c6KrTHEMMA5Ho4JlnNYZ_Q4NU
X-Proofpoint-GUID: k_vQFl1c6KrTHEMMA5Ho4JlnNYZ_Q4NU
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=926 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190193
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the usual #ifndef/#define construct around the contents of simd.h
so it doesn't confuse the C pre-processor if included by multiple
include files.

Fixes: 801201aa2564 ("crypto: move x86 to the generic version of ablk_helper")
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/include/asm/simd.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/simd.h b/arch/x86/include/asm/simd.h
index a341c878e977..bd9c672a2792 100644
--- a/arch/x86/include/asm/simd.h
+++ b/arch/x86/include/asm/simd.h
@@ -1,4 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SIMD_H
+#define _ASM_X86_SIMD_H
 
 #include <asm/fpu/api.h>
 
@@ -10,3 +12,5 @@ static __must_check inline bool may_use_simd(void)
 {
 	return irq_fpu_usable();
 }
+
+#endif /* _ASM_X86_SIMD_H */
-- 
2.38.1

