Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F053C617593
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiKCEaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiKCE3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:29:04 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8B417A9E;
        Wed,  2 Nov 2022 21:28:35 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A33lamA022598;
        Thu, 3 Nov 2022 04:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=pFdV10oyzrzBVE3PjZw0sbof6MPmvRk1DaLLGOI/Jfk=;
 b=A5ZW/PWm7sX0kYitQhK0h9bebWZ97PqxfzmAUDiULFKvD/r+FlD0CiF1ip3qf4Y2aFRa
 /gAK3LUXdrDYSUnQCTkewzRqEx65T0pSsHGqLQ1xMj20smkWlVhq2rv3JVkoDOUvQ/LA
 8Tscb/KXc7D1qFr67gwuehQIx2PiwcVrM+7TRO+iEzrV7OI7wlk1mEpCrzTkk257FCJU
 e4VhBC6FHM83RNalhZw0yeDKsjjAMme4IGTH9wB3H1tNvfVyr4yqaYKyThYo1E9djCGD
 SvoQ8bRQwvJnDssjkHjaXVXuc27wGDUIbgjhX8dTGSnx7RzIyO1uA0LnNzi+ZaFDJdqI ew== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3km624r8xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 04:28:27 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 82F381397B;
        Thu,  3 Nov 2022 04:28:26 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 0F50080A0FF;
        Thu,  3 Nov 2022 04:28:26 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 16/17] crypto: x86/ghash,polyval - load based on CPU features
Date:   Wed,  2 Nov 2022 23:27:39 -0500
Message-Id: <20221103042740.6556-17-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103042740.6556-1-elliott@hpe.com>
References: <20221012215931.3896-1-elliott@hpe.com>
 <20221103042740.6556-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wZbPMpqOEK5fJkS-qGFPdFllzvutLOuj
X-Proofpoint-GUID: wZbPMpqOEK5fJkS-qGFPdFllzvutLOuj
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
features"), these x86-optimized crypto modules already have
module aliases based on CPU feature bits:
    ghash, polyval

Rename the unique device table data structure to a generic name
so the code has the same pattern in all the modules.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 6 +++---
 arch/x86/crypto/polyval-clmulni_glue.c     | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/crypto/ghash-clmulni-intel_glue.c b/arch/x86/crypto/ghash-clmulni-intel_glue.c
index 0f24c3b23fd2..d19a8e9b34a6 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -325,17 +325,17 @@ static struct ahash_alg ghash_async_alg = {
 	},
 };
 
-static const struct x86_cpu_id pcmul_cpu_id[] = {
+static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_PCLMULQDQ, NULL), /* Pickle-Mickle-Duck */
 	{}
 };
-MODULE_DEVICE_TABLE(x86cpu, pcmul_cpu_id);
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int __init ghash_pclmulqdqni_mod_init(void)
 {
 	int err;
 
-	if (!x86_match_cpu(pcmul_cpu_id))
+	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
 	err = crypto_register_shash(&ghash_alg);
diff --git a/arch/x86/crypto/polyval-clmulni_glue.c b/arch/x86/crypto/polyval-clmulni_glue.c
index de1c908f7412..375c845695a4 100644
--- a/arch/x86/crypto/polyval-clmulni_glue.c
+++ b/arch/x86/crypto/polyval-clmulni_glue.c
@@ -176,15 +176,15 @@ static struct shash_alg polyval_alg = {
 	},
 };
 
-__maybe_unused static const struct x86_cpu_id pcmul_cpu_id[] = {
+__maybe_unused static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_PCLMULQDQ, NULL),
 	{}
 };
-MODULE_DEVICE_TABLE(x86cpu, pcmul_cpu_id);
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int __init polyval_clmulni_mod_init(void)
 {
-	if (!x86_match_cpu(pcmul_cpu_id))
+	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_AVX))
-- 
2.37.3

