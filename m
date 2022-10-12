Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9B45FCDFA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJLWBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJLWAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:00:32 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3AE4D4EC;
        Wed, 12 Oct 2022 15:00:15 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CL8Ert016464;
        Wed, 12 Oct 2022 22:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=bap2tNZolRwbU8NuMuLdrUdY6VmdGzhFwpmbpTsze4k=;
 b=bMqiADQ4M2zeZi+iNQEQd7DsQIboatGHMck+sBlj2TK8XhtdBeaau7ek5GrtMar0Tpaa
 RB3T0q3TwQwDelJC5xiBxFv+OGDNgMjTlAfzR4W08HiF8DYrPxBoMSS/shqcV2jdeNLK
 OKN/rVXlguzEOYKj8rzmmCK7L0oqUzsRhvTQnaf2AV8/dVwhu6AuXWmchPM7OtgGYuKe
 LeZorWzqpNCYeW+GknksbJZ5TzBftFPAESOMSAPCEdqEbEXJ2ugyqZCZuzEAZr533+6Z
 Gaiy/+X5iFJc6h/2NLgnhFEKUMNeeQ+j+Acj+ikcKDKIalzUcIfHyvm20DT1g/YmWI8M CA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k657j8a5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 22:00:03 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 6E5FD13964;
        Wed, 12 Oct 2022 22:00:02 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 0FB92805032;
        Wed, 12 Oct 2022 22:00:02 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 12/19] crypto: x86/sm3 - load based on CPU features
Date:   Wed, 12 Oct 2022 16:59:24 -0500
Message-Id: <20221012215931.3896-13-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012215931.3896-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qJn0nosD52Bi6Md1qaiHmCNMvlHY8Xfb
X-Proofpoint-GUID: qJn0nosD52Bi6Md1qaiHmCNMvlHY8Xfb
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_11,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120138
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

This commit covers a module that created rcu stall issues
due to kernel_fpu_begin/kernel_fpu_end calls.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/sm3_avx_glue.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/crypto/sm3_avx_glue.c b/arch/x86/crypto/sm3_avx_glue.c
index ffb6d2f409ef..475b9637a06d 100644
--- a/arch/x86/crypto/sm3_avx_glue.c
+++ b/arch/x86/crypto/sm3_avx_glue.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <crypto/sm3.h>
 #include <crypto/sm3_base.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 #define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
@@ -115,10 +116,19 @@ static struct shash_alg sm3_avx_alg = {
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
 
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (!boot_cpu_has(X86_FEATURE_AVX)) {
 		pr_info("AVX instruction are not detected.\n");
 		return -ENODEV;
-- 
2.37.3

