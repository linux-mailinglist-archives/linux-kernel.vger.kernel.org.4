Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83C762B234
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiKPEPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiKPEO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:26 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C8931FA7;
        Tue, 15 Nov 2022 20:14:22 -0800 (PST)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG4CaG2022245;
        Wed, 16 Nov 2022 04:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=D3DfJIKsHFauPuLg8l8zt1cOt0x3vTUhVteBJZCL2WE=;
 b=I3h47jtyqI1/uAdnG6Dz8OOmpP4hcRv8bH3lW9oFuC6iVijpCQUTG+5UNJyBGHxfHcSZ
 trzNAFvQWAcHVqoO7W/b0Hw3qNCF17MTYuMm/EhEwSND/wwqiqlEB/r3m6exupj63cpZ
 nebvWBO6rO7VPl8WJ1/+0LsXMTSONzTjG1DPQjiHPZxa34U7MLIiiSiyS+ICtnji2UXY
 w4L9FNtVa3NvLgh9XsLOgtIOhwfbtA6c2429DmF2hyi9TijCpVPRcxFZPcGFxYOmAiU2
 FPwzneU8cvjqRla8oJ5fwEV0nGbgY4K5yBBG5fRSExpx+lddMlHnvthY5FSeeacqcE8n Lg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kvrmng09e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:14:13 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 944162EECF;
        Wed, 16 Nov 2022 04:14:12 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 1F7FD808B9A;
        Wed, 16 Nov 2022 04:14:12 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 16/24] crypto: x86/sm3 - load based on CPU features
Date:   Tue, 15 Nov 2022 22:13:34 -0600
Message-Id: <20221116041342.3841-17-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0lkMSIZrD6OBxDlNv6JZ2MeDy4pF3oRr
X-Proofpoint-ORIG-GUID: 0lkMSIZrD6OBxDlNv6JZ2MeDy4pF3oRr
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like commit aa031b8f702e ("crypto: x86/sha512 - load based on CPU
features"), add module aliases for x86-optimized crypto modules:
        sm3
based on CPU feature bits so udev gets a chance to load them later in
the boot process when the filesystems are all running.

Signed-off-by: Robert Elliott <elliott@hpe.com>

---
v4 removed second AVX check that is unreachable
---
 arch/x86/crypto/sm3_avx_glue.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/crypto/sm3_avx_glue.c b/arch/x86/crypto/sm3_avx_glue.c
index 483aaed996ba..c7786874319c 100644
--- a/arch/x86/crypto/sm3_avx_glue.c
+++ b/arch/x86/crypto/sm3_avx_glue.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <crypto/sm3.h>
 #include <crypto/sm3_base.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
@@ -119,14 +120,18 @@ static struct shash_alg sm3_avx_alg = {
 	}
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int __init sm3_avx_mod_init(void)
 {
 	const char *feature_name;
 
-	if (!boot_cpu_has(X86_FEATURE_AVX)) {
-		pr_info("AVX instruction are not detected.\n");
+	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
-	}
 
 	if (!boot_cpu_has(X86_FEATURE_BMI2)) {
 		pr_info("BMI2 instruction are not detected.\n");
-- 
2.38.1

