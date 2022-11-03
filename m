Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1385C61758E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiKCE3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiKCE3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:29:02 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B1F17892;
        Wed,  2 Nov 2022 21:28:32 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2IbpgP003176;
        Thu, 3 Nov 2022 04:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=0VtZpM3sw0WQAP/42QlXXg/Ajq3gvlmtNRK3M9uOdwI=;
 b=VMXvlTDiDdbUwdiNbuutK2cOzwUihsKShnZp+oPa3OWXEA27pXoKKGa06JfF6T/o3M0i
 MR9mMnAWls/WR6rpS8W4I/Z9DJb5dBaXohKHHguStKARZUkaWi8NbuFTFKyusg1PCLOe
 lnHJvnhYSkacLjnNn2i0/a2s24awGGbvVZAU+QOR2uzUnRNnqR+/KD/jNXswR7MV4xLP
 U3oWuo7FzP24RvuYNtc+HPhp+c3P8TH9D0R7NoS25mE886N3gB5zJeVcUbVmrVaWAlZT
 /2EzgkEm8Fa6ycsd2ZsFMaAup8Iw+b0750KtqOBopww+ox/ryoKqXLqkCvLlgk7Hy/7e EQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kksmrwmug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 04:28:25 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id D271CD25B;
        Thu,  3 Nov 2022 04:28:24 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 53984808EB4;
        Thu,  3 Nov 2022 04:28:24 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 15/17] crypto: x86/sm3 - load based on CPU features
Date:   Wed,  2 Nov 2022 23:27:38 -0500
Message-Id: <20221103042740.6556-16-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103042740.6556-1-elliott@hpe.com>
References: <20221012215931.3896-1-elliott@hpe.com>
 <20221103042740.6556-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RW3ZDgvQIWwSwfAR1Rb_rXBOKDDhFYV4
X-Proofpoint-ORIG-GUID: RW3ZDgvQIWwSwfAR1Rb_rXBOKDDhFYV4
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030031
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 arch/x86/crypto/sm3_avx_glue.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/crypto/sm3_avx_glue.c b/arch/x86/crypto/sm3_avx_glue.c
index 483aaed996ba..26256cc0cbb6 100644
--- a/arch/x86/crypto/sm3_avx_glue.c
+++ b/arch/x86/crypto/sm3_avx_glue.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <crypto/sm3.h>
 #include <crypto/sm3_base.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
@@ -119,10 +120,19 @@ static struct shash_alg sm3_avx_alg = {
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

