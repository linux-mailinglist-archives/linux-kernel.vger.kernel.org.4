Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEDE6C7C35
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCXKGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCXKGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:06:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE211B2F8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679652395; x=1711188395;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=htACZM7UlhSwkOQstbGQxtdxCYSPTGxE1Ea6gOWEefY=;
  b=XxQ6QUciyX9sSfnoQBrw4ot0anmP/F4HsnVFJiAIp1WH+zx6JVVhMrMu
   cttue8adNtwYYJpT4cte4d7zqshoe6b77XUBodR4bYej5peQoGVngbnD6
   LyHyoZ2tEYxjVykMZDxWe06yHYl44Xxkb6xlq/mLkBFTOqJ4Gvu6Nnd4a
   92oKPbAx5/XN3LkvIwkqGikulh8QEf7AFGx7QA2gXkrmfTBvar6y8YGPV
   MThVgNtexbclcuubRL/HxQpyn0ErJ6Zif69NzRIj/EKrYsfgdLKsszc4a
   1ghfZ84NsWAEV1pNrCmwwv1YltPMZdcChd5hlCDanXn0KeCB3aHOIimFU
   A==;
X-IronPort-AV: E=Sophos;i="5.98,287,1673938800"; 
   d="scan'208";a="207071497"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Mar 2023 03:06:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 03:06:30 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 24 Mar 2023 03:06:28 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <palmer@dabbelt.com>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] RISC-V: Fixes for riscv_has_extension[un]likely()'s alternative dependency
Date:   Fri, 24 Mar 2023 10:05:37 +0000
Message-ID: <20230324100538.3514663-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2362; i=conor.dooley@microchip.com; h=from:subject; bh=htACZM7UlhSwkOQstbGQxtdxCYSPTGxE1Ea6gOWEefY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmypS92qRYZn+/YlrjG1sNGZr34v4z95suYXz++czb4TPqu CFeZjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExEVImR4eHLHNk3rpevrGdmW7vnjd H5wBD+vRMavs5abMKx67HCvUBGhu/lbb3nd1vNtrNOMVC5eefqYzVxUY/eXbGPF+48a7ViMz8A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's my attempt at fixing both the use of an FPU on XIP kernels and
the issue that Jason ran into where CONFIG_FPU, which needs the
alternatives frame work for has_fpu() checks, could be enabled without
the alternatives actually being present.

For the former, a "slow" fallback that does not use alternatives is
added to riscv_has_extension_[un]likely() that can be used with XIP.
Obviously, we want to make use of Jisheng's alternatives based approach
where possible, so any users of riscv_has_extension_[un]likely() will
want to make sure that they select RISCV_ALTERNATIVE.
If they don't however, they'll hit the fallback path which (should,
sparing a silly mistake from me!) behave in the same way, thus
succeeding silently. Sounds like a

To prevent "depends on !XIP_KERNEL; select RISCV_ALTERNATIVE" spreading
like the plague through the various places that want to check for the
presence of extensions, and sidestep the potential silent "success"
mentioned above, all users RISCV_ALTERNATIVE are converted from selects
to dependencies, with the option being selected for all !XIP_KERNEL
builds.

I know that the VDSO was a key place that Jisheng wanted to use the new
helper rather than static branches, and I think the fallback path
should not cause issues there.

See the thread at [1] for the prior discussion.

Cheers,
Conor.

1 - https://lore.kernel.org/linux-riscv/20230128172856.3814-1-jszhang@kernel.org/T/#m21390d570997145d31dd8bb95002fd61f99c6573

CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Heiko Stuebner <heiko.stuebner@vrull.eu>
CC: Andrew Jones <ajones@ventanamicro.com>
CC: Anup Patel <apatel@ventanamicro.com>
CC: Jisheng Zhang <jszhang@kernel.org>
CC: Andrew Jones <ajones@ventanamicro.com>
CC: Jason A. Donenfeld <Jason@zx2c4.com>
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (2):
  RISC-V: add non-alternative fallback for
    riscv_has_extension_[un]likely()
  RISC-V: always select RISCV_ALTERNATIVE for non-xip kernels

 arch/riscv/Kconfig             | 12 ++++----
 arch/riscv/Kconfig.erratas     |  6 ++--
 arch/riscv/include/asm/hwcap.h | 50 ++++++++++++++++++++--------------
 3 files changed, 38 insertions(+), 30 deletions(-)

-- 
2.39.2

