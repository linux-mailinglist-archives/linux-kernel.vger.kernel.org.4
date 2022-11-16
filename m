Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCAF62B232
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiKPEP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiKPEOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:25 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A28E31DEC;
        Tue, 15 Nov 2022 20:14:21 -0800 (PST)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG3RlJv014105;
        Wed, 16 Nov 2022 04:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=6SZmW+gWgFMHc7MDMy56h8QMVAgK51dtPijJjTSczbQ=;
 b=nvNEjlnSt/zEG6vEC+p5CU74HwPGCMynUh3pRF0tdqv09LK8BZDuit0odSNONEkyhBDv
 0KPA2FI7Q2XecXCoz28zVLRsxf98gZi5t8UjG6WQ8n6fibRzvilrjz7kXOMUU8F+Rmqt
 Ak72nShCrcY3HR9lRhEbvpK31KqgGNxVa8cZ+IIpj6ct8fONYVMsYNsurzhYRxEf8E8q
 +miA/EzZ6iYvghZFxKOkWkhgS5va5IqGdRzYH4Qz/DcqRAjDOaBynU8i0JouQlbo+JjM
 OWiZMyxWD92HnHqxZwWxg6MZPynGha1T6SHU2BgXrP2P1Lrj4x/vwvgmLgmZ2xHDpxxa hg== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kvqyfr9jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:14:11 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id EFC37809F54;
        Wed, 16 Nov 2022 04:14:10 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 79FA88058DE;
        Wed, 16 Nov 2022 04:14:10 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 15/24] crypto: x86/crc - load based on CPU features
Date:   Tue, 15 Nov 2022 22:13:33 -0600
Message-Id: <20221116041342.3841-16-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JLbth3PE-M5wIDPE3_GTv_qHBXz7tZW6
X-Proofpoint-ORIG-GUID: JLbth3PE-M5wIDPE3_GTv_qHBXz7tZW6
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211160029
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

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/crc32-pclmul_glue.c     | 10 ++++------
 arch/x86/crypto/crc32c-intel_glue.c     |  6 +++---
 arch/x86/crypto/crct10dif-pclmul_glue.c |  6 +++---
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/x86/crypto/crc32-pclmul_glue.c b/arch/x86/crypto/crc32-pclmul_glue.c
index df3dbc754818..d5e889c24bea 100644
--- a/arch/x86/crypto/crc32-pclmul_glue.c
+++ b/arch/x86/crypto/crc32-pclmul_glue.c
@@ -182,20 +182,18 @@ static struct shash_alg alg = {
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
+
 	return crypto_register_shash(&alg);
 }
 
diff --git a/arch/x86/crypto/crc32c-intel_glue.c b/arch/x86/crypto/crc32c-intel_glue.c
index f08ed68ec93d..aff132e925ea 100644
--- a/arch/x86/crypto/crc32c-intel_glue.c
+++ b/arch/x86/crypto/crc32c-intel_glue.c
@@ -240,15 +240,15 @@ static struct shash_alg alg = {
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
index 4f6b8c727d88..a26dbd27da96 100644
--- a/arch/x86/crypto/crct10dif-pclmul_glue.c
+++ b/arch/x86/crypto/crct10dif-pclmul_glue.c
@@ -139,15 +139,15 @@ static struct shash_alg alg = {
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
2.38.1

