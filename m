Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A4362B240
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiKPEQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiKPEO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:56 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E1131EF2;
        Tue, 15 Nov 2022 20:14:29 -0800 (PST)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG4CbvL022259;
        Wed, 16 Nov 2022 04:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=4jOIa0LKBXHh2Ll5Fgpe6Cbe58VzxCQ8HYLa+/r8boU=;
 b=nxQ1HgbNaQZ0NUphmOGWelg5sN6A15ZiJGA8Jh8h8pyHkU2ENSkM+qi2ZcnfmNhxTIte
 lawV4R+MdIwMBEPWi3R5sPK3FPS1kZ0p3WunbzrX/wqb52k/sHCjlPKfHbTqoerqgpF/
 WQlV2HvR2nd3nD8ELmhSb63BpZT5w3AEHgYcfGmra5ABXlO0D/a3v34zdarI75AhXCH6
 P4lwrZl5R1nKcGCX9V/Uo8l5sGZi3YUGyuXRcRQb3LIWos5mjgqKWPtQQXPldmSkifpo
 FL/bQBBe5XtJESiMWixDjawiyrlBJTepuMNqwpyqJJI0l+vzkgqQ6eA1l18brN5JXSnu EQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kvrmng09p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:14:17 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 4A03D4B5E0;
        Wed, 16 Nov 2022 04:14:15 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id C1C548058DE;
        Wed, 16 Nov 2022 04:14:14 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 18/24] crypto: x86/ghash - load based on CPU features
Date:   Tue, 15 Nov 2022 22:13:36 -0600
Message-Id: <20221116041342.3841-19-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: flpUPOjh0lI0Hb5cDcS50prqvbbal9Qx
X-Proofpoint-ORIG-GUID: flpUPOjh0lI0Hb5cDcS50prqvbbal9Qx
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
features"), these x86-optimized crypto modules already have
module aliases based on CPU feature bits:
    ghash

Rename the unique device table data structure to a generic name
so the code has the same pattern in all the modules.

Signed-off-by: Robert Elliott <elliott@hpe.com>

---
v4 move polyval into a separate patch
---
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
-- 
2.38.1

