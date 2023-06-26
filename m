Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CA173DD3B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjFZLUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjFZLUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:20:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB89E7D;
        Mon, 26 Jun 2023 04:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687778447; x=1719314447;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GKLHsJxKMBm+j/FpObibxtnIG6RkgGJwaNujazCwvSU=;
  b=rgrFHyA+5CMHJbRkW/KDaC0tk1LCSRc14BXDZNd7Rl1FckV4khhBJvDD
   J2/1FGweXTXR3rFd5QhnAI8E4ryGYBilcIdj8s+bjdQrYoiYG1QvZSOdn
   HtEC4K8H4tJXwgFSe1boqfwCaVSI/6MkgO9uhSY2gTTBTLrqhzW+wD62u
   JFgh5MzQnVStyAhNAc7aHJDGSNht/GPsCYhkKw2SH302CEDORiYiphX1H
   ARpr98DEaK8l38/FjWAwtK65RcZ7Xsqp08Ph4E+vx273053FeLE4WpsLU
   oyj1/VJgqEjRtPKvkAtAK53PIAqairjRMMplguwqcG+JWU0QoNdCDEuEH
   w==;
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="232170729"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2023 04:20:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 26 Jun 2023 04:20:45 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 26 Jun 2023 04:20:43 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <palmer@dabbelt.com>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        "Evan Green" <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/9] RISC-V: Probe DT extension support using riscv,isa-extensions & riscv,isa-base
Date:   Mon, 26 Jun 2023 12:19:38 +0100
Message-ID: <20230626-provable-angrily-81760e8c3cc6@wendy>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2680; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=GKLHsJxKMBm+j/FpObibxtnIG6RkgGJwaNujazCwvSU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCkzS3yepB+9L2HW+6B+6qJ0C9NpSx9ns6mVy/959a3WdMY1 DfG4jlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzk605GhlUrDlxYbLIxU9zubE4rj3 Zql6Bnsvcs1c63LGX6T13ubGL4p9ZTfrHwWI92m8vetdLG1w5zfpyeeDZF48KSh5a78+2YeQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Based on my latest iteration of deprecating riscv,isa [1], here's an
implementation of the new properties for Linux. The first few patches,
up to "RISC-V: split riscv_fill_hwcap() in 3", are all prep work that
further tames some of the extension related code, on top of my already
applied series that cleans up the ISA string parser.
Perhaps "RISC-V: shunt isa_ext_arr to cpufeature.c" is a bit gratuitous,
but I figured a bit of coalescing of extension related data structures
would be a good idea. I certainly would not be against putting this
stuff in hwcap.h instead.

Note that riscv,isa will still be used in the absence of the new
properties:
	if (!acpi_disabled) {
		riscv_fill_hwcap_from_isa_string(isa2hwcap);
	} else {
		int ret = riscv_fill_hwcap_new(isa2hwcap);
		if (ret) {
			pr_info("Falling back to deprecated \"riscv,isa\"\n");
			riscv_fill_hwcap_from_isa_string(isa2hwcap);
		}
	}

Also, I could not come up with a good name for the new function,
suggestions welcome on that front for sure.

Cheers,
Conor.

As a side note, I tried some macro fiddling to remove the need for a
\#define for each extension that ends up conflicting a bunch between
different people, but didn't come up with anything I was happy with that
worked. I'll keep tinkering with that.

[1] https://lore.kernel.org/all/20230626-unmarked-atom-70b4d624a386@wendy/

CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Albert Ou <aou@eecs.berkeley.edu>
CC: Andrew Jones <ajones@ventanamicro.com>
CC: Heiko Stuebner <heiko.stuebner@vrull.eu>
CC: Evan Green <evan@rivosinc.com>
CC: Sunil V L <sunilvl@ventanamicro.com>
CC: linux-riscv@lists.infradead.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (8):
  RISC-V: drop a needless check in print_isa_ext()
  RISC-V: shunt isa_ext_arr to cpufeature.c
  RISC-V: repurpose riscv_isa_ext array in riscv_fill_hwcap()
  RISC-V: add missing single letter extension definitions
  RISC-V: add single letter extensions to riscv_isa_ext
  RISC-V: split riscv_fill_hwcap() in 3
  RISC-V: enable extension detection from new properties
  RISC-V: try new extension properties in of_early_processor_hartid()

Heiko Stuebner (1):
  RISC-V: don't parse dt/acpi isa string to get rv32/rv64

 arch/riscv/include/asm/hwcap.h |  16 +-
 arch/riscv/kernel/cpu.c        | 149 +++-------
 arch/riscv/kernel/cpufeature.c | 508 +++++++++++++++++++++------------
 3 files changed, 379 insertions(+), 294 deletions(-)

-- 
2.40.1

