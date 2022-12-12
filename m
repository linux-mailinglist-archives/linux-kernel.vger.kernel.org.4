Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E743649E34
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiLLLzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLLLze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:55:34 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292C4F596;
        Mon, 12 Dec 2022 03:55:31 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so4916580wmb.2;
        Mon, 12 Dec 2022 03:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y2ETDY9kzpY5Fe4txiNeWBSSB7VK4LZqJFu+sI6h0Y=;
        b=gH70gzNKB033u3DNcf3ld6m0ZiprKou8HSdTDvCU/JiGyxFca4JszxlB/f8f4lLRBW
         RQIwl/76kQd/rmS31fLm8s1xOeuidDqBtVdvC0/UgqoI5fTaWHZg1LsCQHXCOHhtGMR1
         RoXTMgEr8ynKXwjr7XZUTrbZTCqAaVw+jfcJ2jul2Awriu4oB+IAUYi9shqju8tKfTPF
         spCmAsT4EbelV0aajBfWNRQQ+V1Qh0q1r+VYLK93JA/mRKgUgBOUI6Q9QQIb5/TGQ2oK
         7+R4RC/Gav/Xhk37MJirl6pQf08yZEbnYf3XICat7eQxHdGOlmAs8H0FaNSkETbuDMZo
         7CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Y2ETDY9kzpY5Fe4txiNeWBSSB7VK4LZqJFu+sI6h0Y=;
        b=Lec3HJHC7E3nZvxvQRaz0jCqOh+DiYJOPQKJZu3VDuOVMavLfBCjYrs6W4Yp0c5DDb
         Yzy9/wTCCk7MLhgneugptQVQ+3nz9yxf7W9uH1E/TIB/aiJjHBWgDKvSh0OR9OighuzZ
         +RFGeR+LKuBMYgxZqG1DSAWFYzuZyckMrKao1vclnwBFSS1rwWCdVbDRXHkDD4Qrq3jH
         2r7TxG+RUdM+bsViQnnL/X+FyeBwzaLEuyZ1uBBMel8Y3siIjNfpjuJ/7euYbLYC/yBu
         /4iqWnSUal0DVywG0cx/bgJvgnGKeKg2SpTAve0y9bJbP5E5ofmVuyFvXWXGRL1Rr9oj
         rWLA==
X-Gm-Message-State: ANoB5plLxVFo/NxXypxqTgMfcH6l4zUG1yQMV2M/sX9MfpljTWZlkl+G
        fsLHNhhh66uA6+YEthejyKM=
X-Google-Smtp-Source: AA0mqf4z6LGIMgMOwSo+HXWPSSjbbH379O4giBDXbmd430wDE24OXOwqIQtSUbCkKitytybI+04Fcw==
X-Received: by 2002:a05:600c:601c:b0:3cf:fc0b:3359 with SMTP id az28-20020a05600c601c00b003cffc0b3359mr12361319wmb.0.1670846129561;
        Mon, 12 Dec 2022 03:55:29 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:1484:ef11:b25c:4612])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b003b4cba4ef71sm9793820wmq.41.2022.12.12.03.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 03:55:28 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 0/6] AX45MP: Add support to non-coherent DMA
Date:   Mon, 12 Dec 2022 11:54:59 +0000
Message-Id: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

On the Andes AX45MP core, cache coherency is a specification option so it
may not be supported. In this case DMA will fail. To get around with this
issue this patch series does the below:

1] Andes alternative ports is implemented as errata which checks if the IOCP
is missing and only then applies to CMO errata. One vendor specific SBI EXT
(RZFIVE_SBI_EXT_IOCP_SW_WORKAROUND) is implemented as part of errata. If we could
access the DTB in errata I can get rid of this EXT ID from OpenSBI. Is there any
approach we can access the DTB in patch callback?

Below are the configs which Andes port provides (and are selected by RZ/Five):
      - ERRATA_ANDES
      - ERRATA_ANDES_CMO

2] Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
block that allows dynamic adjustment of memory attributes in the runtime.
It contains a configurable amount of PMA entries implemented as CSR
registers to control the attributes of memory locations in interest.
OpenSBI configures the PMA regions as required and creates a reserve memory
node and propagates it to the higher boot stack.

An RFC patch for OpenSBI is posted here:
https://patchwork.ozlabs.org/project/opensbi/patch/20221212094421.14556-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

    reserved-memory {
        #address-cells = <2>;
        #size-cells = <2>;
        ranges;

        pma_resv0@58000000 {
            compatible = "shared-dma-pool";
            reg = <0x0 0x58000000 0x0 0x08000000>;
            no-map;
            linux,dma-default;
        };
    };

The above shared DMA pool gets appended to Linux DTB so the DMA memory
requests go through this region.

3] We provide callbacks to synchronize specific content between memory and
cache.

        - arch_sync_dma_for_device()
        - arch_sync_dma_for_cpu()

4] RZ/Five SoC selects the below configs
        - AX45MP_L2_CACHE
        - DMA_GLOBAL_POOL
        - ERRATA_ANDES
        - ERRATA_ANDES_CMO

OpenSBI implementation patches can be found here:
1] https://patchwork.ozlabs.org/project/opensbi/cover/20221210103011.7814-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
2]https://patchwork.ozlabs.org/project/opensbi/patch/20221212094421.14556-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Note,
- This series requires testing on Cores with zibcom and T-Head SoCs
- Ive used GCC 12.2.0 for compilation (tested with allmodconfig)
- Tested all the IP blocks on RZ/Five which use DMA
- Series is dependant on https://patchwork.kernel.org/project/linux-riscv/cover/20221207180821.2479987-1-heiko@sntech.de/

v4 -> v5
* Rebased ALTERNATIVE_3() macro on top of Andrew's patches
* Rebased the changes on top of Heiko's alternative call patches
* Dropped configuring the PMA from Linux
* Dropped configuring the L2 cache from Linux and dropped the binding for same
* Now using runtime patching mechanism instead of compile time config

RFC v3 -> v4
* Implemented ALTERNATIVE_3() macro 
* Now using runtime patching mechanism instead of compile time config
* Added Andes CMO as and errata
* Fixed comments pointed by Geert

RFC v2-> RFC v3
* Fixed review comments pointed by Conor
* Move DT binding into cache folder
* Fixed DT binding check issue
* Added andestech,ax45mp-cache.h header file
* Now passing the flags for the PMA setup as part of andestech,pma-regions
  property.
* Added andestech,inst/data-prefetch and andestech,tag/data-ram-ctl
  properties to configure the L2 cache.
* Registered the cache driver as platform driver

RFC v1-> RFC v2
* Moved out the code from arc/riscv to drivers/soc/renesas
* Now handling the PMA setup as part of the L2 cache
* Now making use of dma-noncoherent.c instead SoC specific implementation.
* Dropped arch_dma_alloc() and arch_dma_free()
* Switched to RISCV_DMA_NONCOHERENT
* Included DT binding doc

RFC v2: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
RFC v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (6):
  riscv: asm: alternative-macros: Introduce ALTERNATIVE_3() macro
  riscv: asm: vendorid_list: Add Andes Technology to the vendors list
  riscv: errata: Add Andes alternative ports
  riscv: mm: dma-noncoherent: Pass direction and operation to
    ALT_CMO_OP()
  dt-bindings: cache: r9a07g043f-l2-cache: Add DT binding documentation
    for L2 cache controller
  soc: renesas: Add L2 cache management for RZ/Five SoC

 .../cache/andestech,ax45mp-cache.yaml         |  81 ++++++
 arch/riscv/Kconfig.erratas                    |  22 ++
 arch/riscv/errata/Makefile                    |   1 +
 arch/riscv/errata/andes/Makefile              |   1 +
 arch/riscv/errata/andes/errata.c              |  93 +++++++
 arch/riscv/include/asm/alternative-macros.h   |  46 +++-
 arch/riscv/include/asm/alternative.h          |   3 +
 arch/riscv/include/asm/cacheflush.h           |  12 +
 arch/riscv/include/asm/errata_list.h          |  41 ++-
 arch/riscv/include/asm/vendorid_list.h        |   1 +
 arch/riscv/kernel/alternative.c               |   5 +
 arch/riscv/mm/dma-noncoherent.c               |  15 +-
 drivers/soc/renesas/Kconfig                   |   6 +
 drivers/soc/renesas/Makefile                  |   2 +
 drivers/soc/renesas/rzfive/Kconfig            |   6 +
 drivers/soc/renesas/rzfive/Makefile           |   3 +
 drivers/soc/renesas/rzfive/ax45mp_cache.c     | 256 ++++++++++++++++++
 17 files changed, 576 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
 create mode 100644 arch/riscv/errata/andes/Makefile
 create mode 100644 arch/riscv/errata/andes/errata.c
 create mode 100644 drivers/soc/renesas/rzfive/Kconfig
 create mode 100644 drivers/soc/renesas/rzfive/Makefile
 create mode 100644 drivers/soc/renesas/rzfive/ax45mp_cache.c

-- 
2.25.1

