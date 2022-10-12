Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7A85FCE04
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJLWCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiJLWBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:01:30 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E954A58089;
        Wed, 12 Oct 2022 15:00:17 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CL7Xtx016427;
        Wed, 12 Oct 2022 22:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=IHgdcqY57yff1zidfBdTpXQFa6PN/RGQ+7WerJQTk2I=;
 b=H5vD7ecinNIj7w7ZEZzSEMqJ1ASb1KmrQnVhBK0AaEuNmAog6qKRJtznVbURM6OVc5fR
 bz2v6JFOFPMnezZx6/Rp9sjP/i/5/c6znkW5fUgJ68jL8nZ8ahZ2o+UXZUu3EaFqZldD
 2mgIA2JlTgnRLqo8H9uYsg5Phq4KHbEt5QLi0kdnBTuvv/y4n0kpI+JE/S0qDxQBPjQ9
 2Nl/TgPTZWIFMhGDKCRxI0wk38n8hhTtnLHKbAPP+rc1pS62qJudX8/T6ojGk1dQLMx1
 zgNoTte2G05k7JZCIV3+/fd4zcFqPew4yTNE9Rw8aHP8/BK+2TQnlhlE/UJqfLS6w2lo Gw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k657c8aas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 22:00:01 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 11C2B804701;
        Wed, 12 Oct 2022 22:00:01 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id A6C01806B7E;
        Wed, 12 Oct 2022 22:00:00 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 11/19] crypto: x86/crc - load based on CPU features
Date:   Wed, 12 Oct 2022 16:59:23 -0500
Message-Id: <20221012215931.3896-12-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012215931.3896-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MDQZ-3AN4UnDZwqsSrh64-VrKqaaLGYZ
X-Proofpoint-GUID: MDQZ-3AN4UnDZwqsSrh64-VrKqaaLGYZ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_11,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
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
features"), these x86-optimized crypto modules already have
module aliases based on CPU feature bits:
	crc32, crc32c, and crct10dif

Rename the unique device table data structure to a generic name
so the code has the same pattern in all the modules.

Remove the print on a device table mismatch from crc32 that is not
present in the other modules. Modules are not supposed to print
unless they are active.

This commit covers modules that created rcu stall issues
due to kernel_fpu_begin/kernel_fpu_end calls.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/crc32-pclmul_glue.c     | 9 +++------
 arch/x86/crypto/crc32c-intel_glue.c     | 6 +++---
 arch/x86/crypto/crct10dif-pclmul_glue.c | 6 +++---
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/crypto/crc32-pclmul_glue.c b/arch/x86/crypto/crc32-pclmul_glue.c
index 38539c6edfe5..d49a19dcee37 100644
--- a/arch/x86/crypto/crc32-pclmul_glue.c
+++ b/arch/x86/crypto/crc32-pclmul_glue.c
@@ -178,20 +178,17 @@ static struct shash_alg alg = {
 	}
 };
 
-static const struct x86_cpu_id crc32pclmul_cpu_id[] = {
+static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_PCLMULQDQ, NULL),
 	{}
 };
-MODULE_DEVICE_TABLE(x86cpu, crc32pclmul_cpu_id);
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 
 static int __init crc32_pclmul_mod_init(void)
 {
-
-	if (!x86_match_cpu(crc32pclmul_cpu_id)) {
-		pr_info("PCLMULQDQ-NI instructions are not detected.\n");
+	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
-	}
 	return crypto_register_shash(&alg);
 }
 
diff --git a/arch/x86/crypto/crc32c-intel_glue.c b/arch/x86/crypto/crc32c-intel_glue.c
index ece620227057..980c62929256 100644
--- a/arch/x86/crypto/crc32c-intel_glue.c
+++ b/arch/x86/crypto/crc32c-intel_glue.c
@@ -231,15 +231,15 @@ static struct shash_alg alg = {
 	}
 };
 
-static const struct x86_cpu_id crc32c_cpu_id[] = {
+static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_XMM4_2, NULL),
 	{}
 };
-MODULE_DEVICE_TABLE(x86cpu, crc32c_cpu_id);
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int __init crc32c_intel_mod_init(void)
 {
-	if (!x86_match_cpu(crc32c_cpu_id))
+	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 #ifdef CONFIG_X86_64
 	if (boot_cpu_has(X86_FEATURE_PCLMULQDQ)) {
diff --git a/arch/x86/crypto/crct10dif-pclmul_glue.c b/arch/x86/crypto/crct10dif-pclmul_glue.c
index 54a537fc88ee..3b8e9394c40d 100644
--- a/arch/x86/crypto/crct10dif-pclmul_glue.c
+++ b/arch/x86/crypto/crct10dif-pclmul_glue.c
@@ -136,15 +136,15 @@ static struct shash_alg alg = {
 	}
 };
 
-static const struct x86_cpu_id crct10dif_cpu_id[] = {
+static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_PCLMULQDQ, NULL),
 	{}
 };
-MODULE_DEVICE_TABLE(x86cpu, crct10dif_cpu_id);
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int __init crct10dif_intel_mod_init(void)
 {
-	if (!x86_match_cpu(crct10dif_cpu_id))
+	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
 	return crypto_register_shash(&alg);
-- 
2.37.3

