Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A4962402A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiKJKmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiKJKmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:42:11 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9E1BF66;
        Thu, 10 Nov 2022 02:42:09 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VUSnXkt_1668076925;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VUSnXkt_1668076925)
          by smtp.aliyun-inc.com;
          Thu, 10 Nov 2022 18:42:07 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        kernel test robot <lkp@intel.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] crypto: arm64 - Fix unused variable compilation warnings of cpu_feature
Date:   Thu, 10 Nov 2022 18:42:04 +0800
Message-Id: <20221110104204.85493-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu feature defined by MODULE_DEVICE_TABLE is only referenced when
compiling as a module, and the warning of unused variable will be
encountered when compiling with intree. The warning can be removed by
adding the __maybe_unused flag.

Fixes: 03c9a333fef1 ("crypto: arm64/ghash - add NEON accelerated fallback for 64-bit PMULL")
Fixes: ae1b83c7d572 ("crypto: arm64/sm4 - add CE implementation for GCM mode")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/arm64/crypto/ghash-ce-glue.c   | 2 +-
 arch/arm64/crypto/sm4-ce-gcm-glue.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/crypto/ghash-ce-glue.c b/arch/arm64/crypto/ghash-ce-glue.c
index 15794fe21a0b..e5e9adc1fcf4 100644
--- a/arch/arm64/crypto/ghash-ce-glue.c
+++ b/arch/arm64/crypto/ghash-ce-glue.c
@@ -508,7 +508,7 @@ static void __exit ghash_ce_mod_exit(void)
 		crypto_unregister_shash(&ghash_alg);
 }
 
-static const struct cpu_feature ghash_cpu_feature[] = {
+static const struct cpu_feature __maybe_unused ghash_cpu_feature[] = {
 	{ cpu_feature(PMULL) }, { }
 };
 MODULE_DEVICE_TABLE(cpu, ghash_cpu_feature);
diff --git a/arch/arm64/crypto/sm4-ce-gcm-glue.c b/arch/arm64/crypto/sm4-ce-gcm-glue.c
index e90ea0f17beb..c450a2025ca9 100644
--- a/arch/arm64/crypto/sm4-ce-gcm-glue.c
+++ b/arch/arm64/crypto/sm4-ce-gcm-glue.c
@@ -271,7 +271,7 @@ static void __exit sm4_ce_gcm_exit(void)
 	crypto_unregister_aead(&sm4_gcm_alg);
 }
 
-static const struct cpu_feature sm4_ce_gcm_cpu_feature[] = {
+static const struct cpu_feature __maybe_unused sm4_ce_gcm_cpu_feature[] = {
 	{ cpu_feature(PMULL) },
 	{}
 };
-- 
2.24.3 (Apple Git-128)

