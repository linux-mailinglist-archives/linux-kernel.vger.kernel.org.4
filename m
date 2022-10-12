Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5955A5FCDFE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiJLWBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJLWAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:00:43 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F58C7654B;
        Wed, 12 Oct 2022 15:00:22 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CL88dt016394;
        Wed, 12 Oct 2022 22:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=cA+jiT1Ykbspsq4IfGAHBDwf5ujiMklaMuWz0ZTfqho=;
 b=JlnPlMbr7D+Jfwij5Q+naBSj+gztLGJQaolsbe0LmM+o9uGUjg4ry5uzr5m8YzyFwqCf
 qx07bS3/uudkyA1gfyVaZR9/evrdk/TEibHa9bHD7Oe/eyY3zxcOdxTqe7d1iFnfwxhf
 /KQJixQ7fDJY+XGT243GGKAMBGtI5DIaLFOF7sLcp63FNp24x1urqOoksGnmJKTMKlWa
 2O1RNDHJk0hMqr+HwI2DfOpx+y5TgTjJrv8Wfgncvlqdu5AyKGWdH2eDULjQHS5ZaS2v
 GYt29VIX/q2dCrO0c8qRwNh9v6a7Tth+z53OmFhSzST/E5vzV8kdGrLcSk0EZTn72VQx 0g== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k657j8a7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 22:00:10 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 90B3713970;
        Wed, 12 Oct 2022 22:00:09 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 1E63D807DA5;
        Wed, 12 Oct 2022 22:00:09 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 17/19] crypto: x86 - standardize suboptimal prints
Date:   Wed, 12 Oct 2022 16:59:29 -0500
Message-Id: <20221012215931.3896-18-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012215931.3896-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XKLvG6nOYC17q4IoVPFq8vnXPAREF7v6
X-Proofpoint-GUID: XKLvG6nOYC17q4IoVPFq8vnXPAREF7v6
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

Reword prints that the module is not being loaded (although
it otherwise qualifies) because performance would be suboptimal
on the particular CPU model.

Although modules are not supposed to print unless they're loaded
and active, this is an existing exception.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/blowfish_glue.c     | 5 +----
 arch/x86/crypto/camellia_glue.c     | 5 +----
 arch/x86/crypto/des3_ede_glue.c     | 2 +-
 arch/x86/crypto/twofish_glue_3way.c | 5 +----
 4 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/x86/crypto/blowfish_glue.c b/arch/x86/crypto/blowfish_glue.c
index 27b7aed9a488..8d4ecf406dee 100644
--- a/arch/x86/crypto/blowfish_glue.c
+++ b/arch/x86/crypto/blowfish_glue.c
@@ -320,10 +320,7 @@ static int __init blowfish_init(void)
 		return -ENODEV;
 
 	if (!force && is_blacklisted_cpu()) {
-		printk(KERN_INFO
-			"blowfish-x86_64: performance on this CPU "
-			"would be suboptimal: disabling "
-			"blowfish-x86_64.\n");
+		pr_info("CPU-optimized crypto module not loaded, crypto optimization performance on this CPU would be suboptimal\n");
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/camellia_glue.c b/arch/x86/crypto/camellia_glue.c
index 94dd2973bb47..002a1e84b277 100644
--- a/arch/x86/crypto/camellia_glue.c
+++ b/arch/x86/crypto/camellia_glue.c
@@ -1394,10 +1394,7 @@ static int __init camellia_init(void)
 		return -ENODEV;
 
 	if (!force && is_blacklisted_cpu()) {
-		printk(KERN_INFO
-			"camellia-x86_64: performance on this CPU "
-			"would be suboptimal: disabling "
-			"camellia-x86_64.\n");
+		pr_info("CPU-optimized crypto module not loaded, crypto optimization performance on this CPU would be suboptimal\n");
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/des3_ede_glue.c b/arch/x86/crypto/des3_ede_glue.c
index 7b4dd02007ed..b38ad3ec38e2 100644
--- a/arch/x86/crypto/des3_ede_glue.c
+++ b/arch/x86/crypto/des3_ede_glue.c
@@ -371,7 +371,7 @@ static int __init des3_ede_x86_init(void)
 		return -ENODEV;
 
 	if (!force && is_blacklisted_cpu()) {
-		pr_info("des3_ede-x86_64: performance on this CPU would be suboptimal: disabling des3_ede-x86_64.\n");
+		pr_info("CPU-optimized crypto module not loaded, crypto optimization performance on this CPU would be suboptimal\n");
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/twofish_glue_3way.c b/arch/x86/crypto/twofish_glue_3way.c
index 2fde637b40c8..29c35d2aaeba 100644
--- a/arch/x86/crypto/twofish_glue_3way.c
+++ b/arch/x86/crypto/twofish_glue_3way.c
@@ -157,10 +157,7 @@ static int __init twofish_3way_init(void)
 		return -ENODEV;
 
 	if (!force && is_blacklisted_cpu()) {
-		printk(KERN_INFO
-			"twofish-x86_64-3way: performance on this CPU "
-			"would be suboptimal: disabling "
-			"twofish-x86_64-3way.\n");
+		pr_info("CPU-optimized crypto module not loaded, crypto optimization performance on this CPU would be suboptimal\n");
 		return -ENODEV;
 	}
 
-- 
2.37.3

