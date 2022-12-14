Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05FC64CEFF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 18:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbiLNRxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 12:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238257AbiLNRxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 12:53:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9014813D51
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:53:36 -0800 (PST)
Received: from jupiter.universe (dyndsl-095-033-169-234.ewe-ip-backbone.de [95.33.169.234])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6BE2F6600358;
        Wed, 14 Dec 2022 17:53:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671040414;
        bh=lh2jZqSbCvS5f9nm4Fgd9vprbjcQVIH6HrkGVhAfOoM=;
        h=From:To:Cc:Subject:Date:From;
        b=C3CDTdU8fsEVnqbSqp/bimvPADiKVuAZvXn+/JPlJfA0jMa+IPqCKR39uEp3p6D+L
         42Ek4wm7igf4aebhzTxPgux0Nvk9cisJDXieJAhhMZtURGUWOs7ru5F8e78+bnbjBt
         wgAX8TDjkmI3sT8Ooj7Dx/ZbnedBbp3FBUjyQeTuulQYGGCMw/bx4jF7597OEEdIgM
         OaKF3DDkqPfXOtmUs9G6XJa6m2dyDbflNqip9ltSHSUG/+7PMn6n4Wmek3nMdm+LIX
         09rpbZQ/LYPASRxkvy3E1f0DbMUkv0B4d3Tzs0p5u6bAG+5kzJ1U47TtDbftadDi/a
         zBs2cfXNvIJqg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 1F9B0480116; Wed, 14 Dec 2022 18:53:32 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 1/1] ARM: improve Cortex A8/A9 errata help text
Date:   Wed, 14 Dec 2022 18:53:27 +0100
Message-Id: <20221214175327.57703-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Docuemnt that !ARCH_MULTIPLATFORM is necessary because accessing
the the errata workaround registers may not work in non-secure
mode and mention that these erratas should be applied by the
bootloader instead.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Changes since RFCv1
 * https://lore.kernel.org/all/20221209182000.549179-1-sebastian.reichel@collabora.com/
 * update help text instead of removing !ARCH_MULTIPLATFORM
---
 arch/arm/Kconfig | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a08c9d092a33..f81426422df4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -656,7 +656,9 @@ config ARM_ERRATA_458693
 	  hazard might then cause a processor deadlock. The workaround enables
 	  the L1 caching of the NEON accesses and disables the PLD instruction
 	  in the ACTLR register. Note that setting specific bits in the ACTLR
-	  register may not be available in non-secure mode.
+	  register may not be available in non-secure mode and thus is not
+	  available on a multiplatform kernel. This should be applied by the
+	  bootloader instead.
 
 config ARM_ERRATA_460075
 	bool "ARM errata: Data written to the L2 cache can be overwritten with stale data"
@@ -669,7 +671,9 @@ config ARM_ERRATA_460075
 	  and overwritten with stale memory contents from external memory. The
 	  workaround disables the write-allocate mode for the L2 cache via the
 	  ACTLR register. Note that setting specific bits in the ACTLR register
-	  may not be available in non-secure mode.
+	  may not be available in non-secure mode and thus is not available on
+	  a multiplatform kernel. This should be applied by the bootloader
+	  instead.
 
 config ARM_ERRATA_742230
 	bool "ARM errata: DMB operation may be faulty"
@@ -682,7 +686,10 @@ config ARM_ERRATA_742230
 	  ordering of the two writes. This workaround sets a specific bit in
 	  the diagnostic register of the Cortex-A9 which causes the DMB
 	  instruction to behave as a DSB, ensuring the correct behaviour of
-	  the two writes.
+	  the two writes. Note that setting specific bits in the diagnostics
+	  register may not be available in non-secure mode and thus is not
+	  available on a multiplatform kernel. This should be applied by the
+	  bootloader instead.
 
 config ARM_ERRATA_742231
 	bool "ARM errata: Incorrect hazard handling in the SCU may lead to data corruption"
@@ -697,7 +704,10 @@ config ARM_ERRATA_742231
 	  replaced from one of the CPUs at the same time as another CPU is
 	  accessing it. This workaround sets specific bits in the diagnostic
 	  register of the Cortex-A9 which reduces the linefill issuing
-	  capabilities of the processor.
+	  capabilities of the processor. Note that setting specific bits in the
+	  diagnostics register may not be available in non-secure mode and thus
+	  is not available on a multiplatform kernel. This should be applied by
+	  the bootloader instead.
 
 config ARM_ERRATA_643719
 	bool "ARM errata: LoUIS bit field in CLIDR register is incorrect"
@@ -734,7 +744,9 @@ config ARM_ERRATA_743622
 	  register of the Cortex-A9 which disables the Store Buffer
 	  optimisation, preventing the defect from occurring. This has no
 	  visible impact on the overall performance or power consumption of the
-	  processor.
+	  processor. Note that setting specific bits in the diagnostics register
+	  may not be available in non-secure mode and thus is not available on a
+	  multiplatform kernel. This should be applied by the bootloader instead.
 
 config ARM_ERRATA_751472
 	bool "ARM errata: Interrupted ICIALLUIS may prevent completion of broadcasted operation"
@@ -746,6 +758,10 @@ config ARM_ERRATA_751472
 	  completion of a following broadcasted operation if the second
 	  operation is received by a CPU before the ICIALLUIS has completed,
 	  potentially leading to corrupted entries in the cache or TLB.
+	  Note that setting specific bits in the diagnostics register may
+	  not be available in non-secure mode and thus is not available on
+	  a multiplatform kernel. This should be applied by the bootloader
+	  instead.
 
 config ARM_ERRATA_754322
 	bool "ARM errata: possible faulty MMU translations following an ASID switch"
-- 
2.39.0

