Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CE565153E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiLSWD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiLSWDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:03:20 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D42F140C6;
        Mon, 19 Dec 2022 14:03:19 -0800 (PST)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJL5BJ4004423;
        Mon, 19 Dec 2022 22:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=DUz+WsoLUu9ZHA+z71TaCHVliVtTYVa80yxAm1HKF4g=;
 b=RW6sKc9BEWBI+rYS8eckIaK7NhIc+uCvrxlgKBPBVyU17Ir5g1ATwZVhFr8RV4hy2IO1
 pNjJM+Kkt1DlUldQ3RS3phZwXdOUnoRSP2yxdAloCK0r5p3BhHgYhIakYGlriIvCUVuG
 hYKeXIivWtOcwMRDjovRrbjxQv3P3qRNTp7HFo6GK+smWP5+aaPh8lRwWG+O6cPG/9Kh
 YBUq2metVJc6XBwcbOmp4ASPSh4IonJD7FVC3DmsiFE7aMxcb3T11YvD7gsrQekRZHli
 A9KcA1NuAHJVzUho6WNoSqc6Dozkwlw3OLwLcVNgbFJdRmwpjJxiotcUtvghs8rDjdv7 Lg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3mjyd5rcwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 22:02:47 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 3735731099;
        Mon, 19 Dec 2022 22:02:46 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 5F9DF8061BF;
        Mon, 19 Dec 2022 22:02:45 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, Jason@zx2c4.com,
        ardb@kernel.org, ap420073@gmail.com, David.Laight@ACULAB.COM,
        ebiggers@kernel.org, tim.c.chen@linux.intel.com, peter@n8pjl.ca,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 02/13] x86: add yield FPU context utility function
Date:   Mon, 19 Dec 2022 16:02:12 -0600
Message-Id: <20221219220223.3982176-3-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219220223.3982176-1-elliott@hpe.com>
References: <20221219220223.3982176-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Gvjh4KDpMzFEWSzZRj7nTCTBt22lX88l
X-Proofpoint-ORIG-GUID: Gvjh4KDpMzFEWSzZRj7nTCTBt22lX88l
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 malwarescore=0 clxscore=1015 mlxlogscore=709 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190193
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function that may be called to avoid hogging the CPU
between kernel_fpu_begin() and kernel_fpu_end() calls.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/include/asm/simd.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/include/asm/simd.h b/arch/x86/include/asm/simd.h
index bd9c672a2792..2c887dec95a2 100644
--- a/arch/x86/include/asm/simd.h
+++ b/arch/x86/include/asm/simd.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_SIMD_H
 
 #include <asm/fpu/api.h>
+#include <linux/sched.h>
 
 /*
  * may_use_simd - whether it is allowable at this time to issue SIMD
@@ -13,4 +14,22 @@ static __must_check inline bool may_use_simd(void)
 	return irq_fpu_usable();
 }
 
+/**
+ * kernel_fpu_relax - pause FPU preemption if scheduler wants
+ *
+ * Call this periodically during long loops between kernel_fpu_begin()
+ * and kernel_fpu_end() calls to avoid hogging the CPU if the
+ * scheduler wants to use the CPU for another thread
+ *
+ * Return: none
+ */
+static inline void kernel_fpu_yield(void)
+{
+	if (need_resched()) {
+		kernel_fpu_end();
+		cond_resched();
+		kernel_fpu_begin();
+	}
+}
+
 #endif /* _ASM_X86_SIMD_H */
-- 
2.38.1

