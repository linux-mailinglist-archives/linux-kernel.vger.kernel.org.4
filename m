Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68F871252C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 13:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbjEZLAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 07:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242650AbjEZLA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 07:00:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076D4101
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 04:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685098827; x=1716634827;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qWz9IuIpPGye3RBkjnvRNmgujqz6lziLZvgBzgEKyBY=;
  b=kdqLORZNSZjjksd/CgJpQjg1YK0ow5q7sYod3wNwXjJVTT28HkdIg1Z8
   2UH4Nvg2Cim0BuP53XaDRMzLwdyCcifhFfnUHzUL2mhxOqBH7Zc7jPGVc
   pER3UvjaECrS/A+1wsP5BgFaMG4ufpGCGPXA5MqT/cOhiHeo1BrfWaqNQ
   JOxabuaocypBKY5R67nnp9DMMP8t4die9vRbqFpv1wQEW082Oc1Uu/LyA
   RwYhW9QJ8raYjtMz4q14spiMwM1rfEZyE0yiRhhXK7Km0RDa5v5UQrJuq
   PsyosBQ9JVF5SF7+GuyzPBedymCk2/NHUtoMnplqOpnjz7KKLHbb+zMV1
   g==;
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="154080381"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 May 2023 04:00:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 26 May 2023 04:00:25 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 26 May 2023 04:00:23 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <palmer@dabbelt.com>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        <atishp@atishpatra.org>, <anup@brainfault.org>, <alex@ghiti.fr>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <paul.walmsley@sifive.com>, Song Shuai <suagrfillet@gmail.com>,
        JeeHeng Sia <jeeheng.sia@starfivetech.com>
Subject: [PATCH v1] RISC-V: mark hibernation as nonportable
Date:   Fri, 26 May 2023 11:59:08 +0100
Message-ID: <20230526-astride-detonator-9ae120051159@wendy>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2441; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=qWz9IuIpPGye3RBkjnvRNmgujqz6lziLZvgBzgEKyBY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCkFE34mJVWE3Z62p3fJyeAU8+8Tch+9/fhGYOqlY+arPNXf ppppdZSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiUVMZGdorIjPO1p/et/Cw9f6D3g EuEo/jfPVmsYto/rD++8xagYuRYR5HqfLMG5Uciyex710809pLNI3rYUX7mqvZUrHzxauecgIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hibernation support depends on firmware marking its reserved/PMP
protected regions as not accessible from Linux.
The latest versions of the de-facto SBI implementation (OpenSBI) do
not do this, having dropped the no-map property to enable 1 GiB huge
page mappings by the kernel.
This was exposed by commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages
for the linear mapping"), which made the first 2 MiB of DRAM (where SBI
typically resides) accessible by the kernel.
Attempting to hibernate with either OpenSBI, or other implementations
following its lead, will lead to a kernel panic ([1], [2]) as the
hibernation process will attempt to save/restore any mapped regions,
including the PMP protected regions in use by the SBI implementation.

Mark hibernation as depending on "NONPORTABLE", as only a small subset
of systems are capable of supporting it, until such time that an SBI
implementation independent way to communicate what regions are in use
has been agreed on.

As hibernation support landed in v6.4-rc1, disabling it for most
platforms does not constitute a regression. The alternative would have
been reverting commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for
the linear mapping").
Doing so would permit hibernation on platforms with these SBI
implementations, but would limit the options we have to solve the
protection of the region without causing a regression in hibernation
support.

Reported-by: Song Shuai <suagrfillet@gmail.com>
Link: https://lore.kernel.org/all/CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com/ [1]
Reported-by: JeeHeng Sia <jeeheng.sia@starfivetech.com>
Link: https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/ITXwaKfA6z8 [2]
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 13f058490608..117d53785560 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -800,8 +800,11 @@ menu "Power management options"
 
 source "kernel/power/Kconfig"
 
+# Hibernation is only possible on systems where the SBI implementation has
+# marked its reserved memory as not accessible from, or does not run
+# from the same memory as, Linux
 config ARCH_HIBERNATION_POSSIBLE
-	def_bool y
+	def_bool NONPORTABLE
 
 config ARCH_HIBERNATION_HEADER
 	def_bool HIBERNATION
-- 
2.39.2

