Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8606364885F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiLISUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiLISUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:20:34 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7531F9EF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 10:20:33 -0800 (PST)
Received: from jupiter.universe (dyndsl-091-096-062-166.ewe-ip-backbone.de [91.96.62.166])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C87716602C09;
        Fri,  9 Dec 2022 18:20:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670610031;
        bh=dUh/Ph4fvUhmzsNP/St5yPq0TjbFbpyNp2w94uqPWdk=;
        h=From:To:Cc:Subject:Date:From;
        b=i3trOqmhJEtirX/bwAaFKM1+5BzRDoER59nrYIU/ihIvVpzE5hZ6gag1eapcVNy3P
         hrVr9PoKNOYUF8POuElFPqtHVF8t+xDgnfcSE2cbAfmapBBe/jsYWLX80nUvvKKTsq
         x34w7oUBKHUHscNOlE/2ecvzzeciW4/cqMhDIGFwYVKf0214zClY4s2x6+HrWWJOHO
         7OF4TelMOKzjEWeq+fWLgVDPGGx3yLeEeOLc0gT5sVcelmZcJQYh98OTPhAhBFBm6a
         QR740xzBO6+WFUkazE27cVeJydd1wNu5sHfUm3I2DsFNWqG2jGyL1S4tPVplBlnYyJ
         LiLHpp+fO9vEQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 09EB44829FD; Fri,  9 Dec 2022 19:20:30 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [RFC 1/1] ARM: Drop !ARCH_MULTIPLATFORM dependency from Cortex A8/9 erratas
Date:   Fri,  9 Dec 2022 19:20:00 +0100
Message-Id: <20221209182000.549179-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.38.1
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

All the erratas for more recent CPUs (Cortex A15/A12/A17) do not
require !ARCH_MULTIPLATFORM, since there is runtime detection of
effected CPUs in arch/arm/mm/proc-v7.S.

Errata config options for the older Cortex A8/A9 CPUs have the
!ARCH_MULTIPLATFORM dependency, but the CPUs are also runtime
detected. Since there is runtime detection, it should be fine
to enable the erratas for a multi platform kernel.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
For me the most likely explanation that this has not yet happened is
me missing an important detail, so I sent it as RFC. If you point it
out I will try to document the reason.
---
 arch/arm/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a08c9d092a33..fafb02e38507 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -647,7 +647,6 @@ config ARM_ERRATA_430973
 config ARM_ERRATA_458693
 	bool "ARM errata: Processor deadlock when a false hazard is created"
 	depends on CPU_V7
-	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables the workaround for the 458693 Cortex-A8 (r2p0)
 	  erratum. For very specific sequences of memory operations, it is
@@ -661,7 +660,6 @@ config ARM_ERRATA_458693
 config ARM_ERRATA_460075
 	bool "ARM errata: Data written to the L2 cache can be overwritten with stale data"
 	depends on CPU_V7
-	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables the workaround for the 460075 Cortex-A8 (r2p0)
 	  erratum. Any asynchronous access to the L2 cache may encounter a
@@ -674,7 +672,6 @@ config ARM_ERRATA_460075
 config ARM_ERRATA_742230
 	bool "ARM errata: DMB operation may be faulty"
 	depends on CPU_V7 && SMP
-	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables the workaround for the 742230 Cortex-A9
 	  (r1p0..r2p2) erratum. Under rare circumstances, a DMB instruction
@@ -687,7 +684,6 @@ config ARM_ERRATA_742230
 config ARM_ERRATA_742231
 	bool "ARM errata: Incorrect hazard handling in the SCU may lead to data corruption"
 	depends on CPU_V7 && SMP
-	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables the workaround for the 742231 Cortex-A9
 	  (r2p0..r2p2) erratum. Under certain conditions, specific to the
@@ -725,7 +721,6 @@ config ARM_ERRATA_720789
 config ARM_ERRATA_743622
 	bool "ARM errata: Faulty hazard checking in the Store Buffer may lead to data corruption"
 	depends on CPU_V7
-	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables the workaround for the 743622 Cortex-A9
 	  (r2p*) erratum. Under very rare conditions, a faulty
@@ -739,7 +734,6 @@ config ARM_ERRATA_743622
 config ARM_ERRATA_751472
 	bool "ARM errata: Interrupted ICIALLUIS may prevent completion of broadcasted operation"
 	depends on CPU_V7
-	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables the workaround for the 751472 Cortex-A9 (prior
 	  to r3p0) erratum. An interrupted ICIALLUIS operation may prevent the
-- 
2.38.1

