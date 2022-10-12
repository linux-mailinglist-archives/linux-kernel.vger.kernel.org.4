Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7C85FCDF7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiJLWBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiJLWAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:00:30 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F8C4DF36;
        Wed, 12 Oct 2022 15:00:16 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CLWO6L026058;
        Wed, 12 Oct 2022 22:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=o8FuU3Q+uLfzqaV74fBLQi/WP+5rrgR7yOITBPlHv9o=;
 b=L81HtriDA4ZqbzWE5F/tsLihXXg4BeQt5qvnjLtJXuS1UNmP+ulHHdSDC2awfQ/CLUf5
 o5xSjQbOULwBd+N9+CE2+OibN8bbtyIgWut6F3py4AdA5oztgtJFfl1APsiClotthErQ
 wY+gZtpOUoAR+ftNeksN8Rddo9sWCLNVTqOgaM1hSo5cyG+hWAhUYgdk6zLEx2Oh9Y6l
 NKx9uYJzrB4P2M0YMtKtRXvQXpTrlRPM7BOFssN23S6bwMFeSpy365LhEzpy/IakgeFV
 iGnBjRUmES2QNsGs83FQ9V9lnKTR/T19XqFWKLAD2G8bfeZ/uU+eQ7Eed+epc3Knsq5c HQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k657c8abj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 22:00:05 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 4299213965;
        Wed, 12 Oct 2022 22:00:04 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id D23D28038C2;
        Wed, 12 Oct 2022 22:00:03 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 13/19] crypto: x86/ghash - load based on CPU features
Date:   Wed, 12 Oct 2022 16:59:25 -0500
Message-Id: <20221012215931.3896-14-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012215931.3896-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5USlLj6klF6wOtLmvXZJ3Frf8jg5Io-U
X-Proofpoint-GUID: 5USlLj6klF6wOtLmvXZJ3Frf8jg5Io-U
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
    ghash

Rename the unique device table data structure to a generic name
so the code has the same pattern in all the modules.

This commit covers modules that created rcu stall issues
due to kernel_fpu_begin/kernel_fpu_end calls.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/crypto/ghash-clmulni-intel_glue.c b/arch/x86/crypto/ghash-clmulni-intel_glue.c
index a39fc405c7cf..69945e41bc41 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -327,17 +327,17 @@ static struct ahash_alg ghash_async_alg = {
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
2.37.3

