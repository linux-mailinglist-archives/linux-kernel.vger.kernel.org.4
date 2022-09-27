Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50A55EC49F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiI0NhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiI0NhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:37:22 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FDA7E301
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:37:20 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:d95b:5c9b:4085:7c0d])
        by albert.telenet-ops.be with bizsmtp
        id R1dJ2800R3Qogd1061dJc1; Tue, 27 Sep 2022 15:37:19 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1odAly-006QeR-5E; Tue, 27 Sep 2022 15:37:18 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1odAlx-000vnq-Jy; Tue, 27 Sep 2022 15:37:17 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Neng Chen <nengchen@linux.alibaba.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Hongbo Yao <yaohongbo@linux.alibaba.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drivers/perf: ALIBABA_UNCORE_DRW_PMU should depend on ACPI
Date:   Tue, 27 Sep 2022 15:37:16 +0200
Message-Id: <2a4407bb598285660fa5e604e56823ddb12bb0aa.1664285774.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Alibaba T-Head Yitian 710 DDR Sub-system Driveway PMU driver relies
solely on ACPI for matching.  Hence add a dependency on ACPI, to prevent
asking the user about this driver when configuring a kernel without ACPI
support.

Fixes: cf7b61073e4526ca ("drivers/perf: add DDR Sub-System Driveway PMU driver for Yitian 710 SoC")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/perf/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 44c07ea487f4482a..341010f20b777905 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -185,7 +185,7 @@ config APPLE_M1_CPU_PMU
 
 config ALIBABA_UNCORE_DRW_PMU
 	tristate "Alibaba T-Head Yitian 710 DDR Sub-system Driveway PMU driver"
-	depends on ARM64 || COMPILE_TEST
+	depends on (ARM64 && ACPI) || COMPILE_TEST
 	help
 	  Support for Driveway PMU events monitoring on Yitian 710 DDR
 	  Sub-system.
-- 
2.25.1

