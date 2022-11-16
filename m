Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A8C62B241
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiKPEQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbiKPEO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:56 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10B431EE3;
        Tue, 15 Nov 2022 20:14:29 -0800 (PST)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG41wRm017677;
        Wed, 16 Nov 2022 04:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=B/wYDw1cSUgG16tdEg26Rduz4xQRfTooo+shmZDe7Zs=;
 b=BzId7/TthXq5b8M91Cl8rsjkrS3kAGNB+aBvte5zURpGAuSuH+++irmQ+lkgfo5QKeX/
 bRN95Pd2vOwBUvvXuBE5aaAxInwoRnyUH3PKJeGiIsJs6agBdQSbY5egGFn4/0rdh6P+
 PSbGxsNfOk/bPCda2vLzyulejsqZO6sDRMe0nP7KG0rlm1rYbOnozFjkwNdolphDVU3z
 oLXJ92JxdaUEqVAHqS1ZQiPtEg7M2qjMCujj1CAMkopIZCzEKE9axnLenSRzqswohWsH
 0GeRJU/aVgsPLu7CqzgKiRyaN6pRM5VWlnIODyUbioB+h1OQmUnXD+fRAcdLu4coJ7mA zg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kvqkbregu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:14:22 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 6C8FD295AF;
        Wed, 16 Nov 2022 04:14:21 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id F174D802A17;
        Wed, 16 Nov 2022 04:14:20 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 23/24] crypto: x86 - report suboptimal CPUs via module parameters
Date:   Tue, 15 Nov 2022 22:13:41 -0600
Message-Id: <20221116041342.3841-24-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bqSaqtYq4Ek-oxxDAz7wPD-x9ZVWMeIg
X-Proofpoint-ORIG-GUID: bqSaqtYq4Ek-oxxDAz7wPD-x9ZVWMeIg
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211160029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't refuse to load modules on certain CPUs and print a message
to the console. Instead, load the module but don't register the
crypto functions, and report this condition via a new module
suboptimal_x86 module parameter with this description:
	Crypto driver not registered because performance on this CPU would be suboptimal

Reword the descriptions of the existing force module parameter
to match this modified behavior:
	force: Force crypto driver registration on suboptimal CPUs

Make the new module parameters readable via sysfs:
	/sys/module/blowfish_x86_64/parameters/suboptimal_x86:0
	/sys/module/camellia_x86_64/parameters/suboptimal_x86:0
	/sys/module/des3_ede_x86_64/parameters/suboptimal_x86:1
	/sys/module/twofish_x86_64_3way/parameters/suboptimal_x86:1

If the module has been loaded and is reporting suboptimal_x86=1,
remove it to try loading again:
	modprobe -r blowfish_x86_64
	modprobe blowfish_x86_64 force=1

or specify it on the kernel command line:
	blowfish_x86_64.force=1

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/blowfish_glue.c     | 29 +++++++++++++++++------------
 arch/x86/crypto/camellia_glue.c     | 27 ++++++++++++++++-----------
 arch/x86/crypto/des3_ede_glue.c     | 26 +++++++++++++++++---------
 arch/x86/crypto/twofish_glue_3way.c | 26 +++++++++++++++-----------
 4 files changed, 65 insertions(+), 43 deletions(-)

diff --git a/arch/x86/crypto/blowfish_glue.c b/arch/x86/crypto/blowfish_glue.c
index 4c0ead71b198..8e4de7859e34 100644
--- a/arch/x86/crypto/blowfish_glue.c
+++ b/arch/x86/crypto/blowfish_glue.c
@@ -283,7 +283,7 @@ static struct skcipher_alg bf_skcipher_algs[] = {
 	},
 };
 
-static bool is_blacklisted_cpu(void)
+static bool is_suboptimal_cpu(void)
 {
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return false;
@@ -292,7 +292,7 @@ static bool is_blacklisted_cpu(void)
 		/*
 		 * On Pentium 4, blowfish-x86_64 is slower than generic C
 		 * implementation because use of 64bit rotates (which are really
-		 * slow on P4). Therefore blacklist P4s.
+		 * slow on P4).
 		 */
 		return true;
 	}
@@ -302,7 +302,12 @@ static bool is_blacklisted_cpu(void)
 
 static int force;
 module_param(force, int, 0);
-MODULE_PARM_DESC(force, "Force module load, ignore CPU blacklist");
+MODULE_PARM_DESC(force, "Force crypto driver registration on suboptimal CPUs");
+
+static int suboptimal_x86;
+module_param(suboptimal_x86, int, 0444);
+MODULE_PARM_DESC(suboptimal_x86,
+		 "Crypto driver not registered because performance on this CPU would be suboptimal");
 
 static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_ANY, NULL),
@@ -317,12 +322,9 @@ static int __init blowfish_init(void)
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
-	if (!force && is_blacklisted_cpu()) {
-		printk(KERN_INFO
-			"blowfish-x86_64: performance on this CPU "
-			"would be suboptimal: disabling "
-			"blowfish-x86_64.\n");
-		return -ENODEV;
+	if (!force && is_suboptimal_cpu()) {
+		suboptimal_x86 = 1;
+		return 0;
 	}
 
 	err = crypto_register_alg(&bf_cipher_alg);
@@ -339,9 +341,12 @@ static int __init blowfish_init(void)
 
 static void __exit blowfish_fini(void)
 {
-	crypto_unregister_alg(&bf_cipher_alg);
-	crypto_unregister_skciphers(bf_skcipher_algs,
-				    ARRAY_SIZE(bf_skcipher_algs));
+	if (!suboptimal_x86) {
+		crypto_unregister_alg(&bf_cipher_alg);
+		crypto_unregister_skciphers(bf_skcipher_algs,
+					    ARRAY_SIZE(bf_skcipher_algs));
+	}
+	suboptimal_x86 = 0;
 }
 
 module_init(blowfish_init);
diff --git a/arch/x86/crypto/camellia_glue.c b/arch/x86/crypto/camellia_glue.c
index a3df1043ed73..2cb9b24d9437 100644
--- a/arch/x86/crypto/camellia_glue.c
+++ b/arch/x86/crypto/camellia_glue.c
@@ -1356,7 +1356,7 @@ static struct skcipher_alg camellia_skcipher_algs[] = {
 	}
 };
 
-static bool is_blacklisted_cpu(void)
+static bool is_suboptimal_cpu(void)
 {
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return false;
@@ -1376,7 +1376,12 @@ static bool is_blacklisted_cpu(void)
 
 static int force;
 module_param(force, int, 0);
-MODULE_PARM_DESC(force, "Force module load, ignore CPU blacklist");
+MODULE_PARM_DESC(force, "Force crypto driver registration on suboptimal CPUs");
+
+static int suboptimal_x86;
+module_param(suboptimal_x86, int, 0444);
+MODULE_PARM_DESC(suboptimal_x86,
+		 "Crypto driver not registered because performance on this CPU would be suboptimal");
 
 static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_ANY, NULL),
@@ -1391,12 +1396,9 @@ static int __init camellia_init(void)
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
-	if (!force && is_blacklisted_cpu()) {
-		printk(KERN_INFO
-			"camellia-x86_64: performance on this CPU "
-			"would be suboptimal: disabling "
-			"camellia-x86_64.\n");
-		return -ENODEV;
+	if (!force && is_suboptimal_cpu()) {
+		suboptimal_x86 = 1;
+		return 0;
 	}
 
 	err = crypto_register_alg(&camellia_cipher_alg);
@@ -1413,9 +1415,12 @@ static int __init camellia_init(void)
 
 static void __exit camellia_fini(void)
 {
-	crypto_unregister_alg(&camellia_cipher_alg);
-	crypto_unregister_skciphers(camellia_skcipher_algs,
-				    ARRAY_SIZE(camellia_skcipher_algs));
+	if (!suboptimal_x86) {
+		crypto_unregister_alg(&camellia_cipher_alg);
+		crypto_unregister_skciphers(camellia_skcipher_algs,
+					    ARRAY_SIZE(camellia_skcipher_algs));
+	}
+	suboptimal_x86 = 0;
 }
 
 module_init(camellia_init);
diff --git a/arch/x86/crypto/des3_ede_glue.c b/arch/x86/crypto/des3_ede_glue.c
index 168cac5c6ca6..a4cac5129148 100644
--- a/arch/x86/crypto/des3_ede_glue.c
+++ b/arch/x86/crypto/des3_ede_glue.c
@@ -334,7 +334,7 @@ static struct skcipher_alg des3_ede_skciphers[] = {
 	}
 };
 
-static bool is_blacklisted_cpu(void)
+static bool is_suboptimal_cpu(void)
 {
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return false;
@@ -343,7 +343,7 @@ static bool is_blacklisted_cpu(void)
 		/*
 		 * On Pentium 4, des3_ede-x86_64 is slower than generic C
 		 * implementation because use of 64bit rotates (which are really
-		 * slow on P4). Therefore blacklist P4s.
+		 * slow on P4).
 		 */
 		return true;
 	}
@@ -353,7 +353,12 @@ static bool is_blacklisted_cpu(void)
 
 static int force;
 module_param(force, int, 0);
-MODULE_PARM_DESC(force, "Force module load, ignore CPU blacklist");
+MODULE_PARM_DESC(force, "Force crypto driver registration on suboptimal CPUs");
+
+static int suboptimal_x86;
+module_param(suboptimal_x86, int, 0444);
+MODULE_PARM_DESC(suboptimal_x86,
+		 "Crypto driver not registered because performance on this CPU would be suboptimal");
 
 static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_ANY, NULL),
@@ -368,9 +373,9 @@ static int __init des3_ede_x86_init(void)
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
-	if (!force && is_blacklisted_cpu()) {
-		pr_info("des3_ede-x86_64: performance on this CPU would be suboptimal: disabling des3_ede-x86_64.\n");
-		return -ENODEV;
+	if (!force && is_suboptimal_cpu()) {
+		suboptimal_x86 = 1;
+		return 0;
 	}
 
 	err = crypto_register_alg(&des3_ede_cipher);
@@ -387,9 +392,12 @@ static int __init des3_ede_x86_init(void)
 
 static void __exit des3_ede_x86_fini(void)
 {
-	crypto_unregister_alg(&des3_ede_cipher);
-	crypto_unregister_skciphers(des3_ede_skciphers,
-				    ARRAY_SIZE(des3_ede_skciphers));
+	if (!suboptimal_x86) {
+		crypto_unregister_alg(&des3_ede_cipher);
+		crypto_unregister_skciphers(des3_ede_skciphers,
+					    ARRAY_SIZE(des3_ede_skciphers));
+	}
+	suboptimal_x86 = 0;
 }
 
 module_init(des3_ede_x86_init);
diff --git a/arch/x86/crypto/twofish_glue_3way.c b/arch/x86/crypto/twofish_glue_3way.c
index 790e5a59a9a7..8db2f23b3056 100644
--- a/arch/x86/crypto/twofish_glue_3way.c
+++ b/arch/x86/crypto/twofish_glue_3way.c
@@ -103,7 +103,7 @@ static struct skcipher_alg tf_skciphers[] = {
 	},
 };
 
-static bool is_blacklisted_cpu(void)
+static bool is_suboptimal_cpu(void)
 {
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return false;
@@ -118,8 +118,7 @@ static bool is_blacklisted_cpu(void)
 		 * storing blocks in 64bit registers to allow three blocks to
 		 * be processed parallel. Parallel operation then allows gaining
 		 * more performance than was trade off, on out-of-order CPUs.
-		 * However Atom does not benefit from this parallelism and
-		 * should be blacklisted.
+		 * However Atom does not benefit from this parallelism.
 		 */
 		return true;
 	}
@@ -139,7 +138,12 @@ static bool is_blacklisted_cpu(void)
 
 static int force;
 module_param(force, int, 0);
-MODULE_PARM_DESC(force, "Force module load, ignore CPU blacklist");
+MODULE_PARM_DESC(force, "Force crypto driver registration on suboptimal CPUs");
+
+static int suboptimal_x86;
+module_param(suboptimal_x86, int, 0444);
+MODULE_PARM_DESC(suboptimal_x86,
+		 "Crypto driver not registered because performance on this CPU would be suboptimal");
 
 static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_ANY, NULL),
@@ -152,12 +156,9 @@ static int __init twofish_3way_init(void)
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
-	if (!force && is_blacklisted_cpu()) {
-		printk(KERN_INFO
-			"twofish-x86_64-3way: performance on this CPU "
-			"would be suboptimal: disabling "
-			"twofish-x86_64-3way.\n");
-		return -ENODEV;
+	if (!force && is_suboptimal_cpu()) {
+		suboptimal_x86 = 1;
+		return 0;
 	}
 
 	return crypto_register_skciphers(tf_skciphers,
@@ -166,7 +167,10 @@ static int __init twofish_3way_init(void)
 
 static void __exit twofish_3way_fini(void)
 {
-	crypto_unregister_skciphers(tf_skciphers, ARRAY_SIZE(tf_skciphers));
+	if (!suboptimal_x86)
+		crypto_unregister_skciphers(tf_skciphers, ARRAY_SIZE(tf_skciphers));
+
+	suboptimal_x86 = 0;
 }
 
 module_init(twofish_3way_init);
-- 
2.38.1

