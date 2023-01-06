Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7616606AF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 19:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjAFS4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 13:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjAFS4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 13:56:08 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D84377D0B;
        Fri,  6 Jan 2023 10:56:07 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso1726431wmq.1;
        Fri, 06 Jan 2023 10:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3sUwYegRtAIb+OCTW5mqCGhd7voccHEpdVjTByrjOi8=;
        b=mvN0mjmHwx/VFu46rg+zvq7VV2GQiEAzy4dIgGeV0yIXxsZrUwYalmgLGt3hYA9c+K
         mICCY5cg/L9CRr1mMdCiPpsWIVAN13S6u2Cl/VL7fYIgCRxdq6HaBqXEqQd/j3Rk43ku
         MdnZE/bTw0vfeRKDrDz+1AXCRaHow8HjAjICsrs/UMyI4AM2mK4/KpSVybyepQtbfbVB
         n0fytKUNYyLxQhud+p3RURKhXkI3bzdSbteZPjnpodGBjtLpZP7H/kR8kh1fUaK4JYon
         GzHHSm7kHUqUKkpAL+G6reEebXt7y1p84rTANDi1WpYk2V+B1sXpXhFY9UuZxlm0Cv+b
         Hylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3sUwYegRtAIb+OCTW5mqCGhd7voccHEpdVjTByrjOi8=;
        b=Wle7gDgUTCvyzMDMQmVahw+HyHkUvHUgQJlVHA7eVmh7R5bN5ERdtjnL27vHDFxT7n
         zRTfwKQoeCEHBo2sJuo5Z1GSh7ua6cX+BAnhVwzxIQNNy1+OtXfSqNUfL8RiNFCyXWKA
         Yv/I6vO22EEQB/t+ulcwIa2TlAKVN5uvOl+iRVMLuj1a4kZQ7BBR96T++kww3Vb9ekOE
         /CPIFQZEYN1J8OBRxpGC4faUaUAxDyaW332Ot0WQoa7/Aox5tPmtbCuaUq/x2jts+cR7
         xkUExpooQMT/a+t/rD+MfcDfTTj6sLsE2q0TkI+jL1PeT5ejlawnFecTMREipr7uUbCd
         bMnw==
X-Gm-Message-State: AFqh2krpBGau9GKWZ2JTxfLyp13v99giUJqv8CfXmxcNCcJszvV+p3Oj
        ETDfKBSONX1lymxbkN0x6+A=
X-Google-Smtp-Source: AMrXdXuzXHmK258HUVix6YG0pfb9Dmn1BifmbLfB1D03lJT7QadJIixWYT9Yd+fUM8OQlMJid4SkkQ==
X-Received: by 2002:a05:600c:3d0e:b0:3d1:ee97:980 with SMTP id bh14-20020a05600c3d0e00b003d1ee970980mr49682190wmb.7.1673031365518;
        Fri, 06 Jan 2023 10:56:05 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:79e8:5b4e:615a:91cd])
        by smtp.gmail.com with ESMTPSA id d8-20020a05600c34c800b003c5571c27a1sm3162773wmq.32.2023.01.06.10.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 10:56:04 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE)
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v6 0/6] RISC-V non-coherent function pointer based cache management operations + non-coherent DMA support for AX45MP
Date:   Fri,  6 Jan 2023 18:55:20 +0000
Message-Id: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

RISC-V non-coherent function pointer based cache management operations
=======================================================================
As based on the previous discussion [0]. [1], It was suggested upon the below:
* Move out cache drivers from drivers/soc/folder
* Implement function pointers for CMO instead of ALTERNATIVE_x() macro
* Add cache drivers to drivers/cache folder

[0] https://lore.kernel.org/all/43aee000-5b89-4d94-98d2-b37b1a18a83e@app.fastmail.com/
[1] https://lore.kernel.org/linux-riscv/Y62nOqzyuUKqYDpq@spud/#R

This v6 version of the patch series add support to use function pointers for CMO
and switches the current CMO implementations for zicbom and T-HEAD to use function
pointers.

Note, with the above approach we might see some performance degradation due to additional
checks.

----------x---------------------x--------------------x---------------x--------------


non-coherent DMA support for AX45MP
====================================

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
----------x---------------------x--------------------x---------------x--------------

Note,
- This series requires testing on Cores with zicbom and T-Head SoCs
- Ive used GCC 12.2.0 for compilation (tested with allmodconfig)
- Tested all the IP blocks on RZ/Five which use DMA

v5.1 -> v6
* Dropped use of ALTERNATIVE_x() macro
* Now switched to used function pointers for CMO
* Moved driver to drivers/cache folder

v5 -> v5.1
* https://patchwork.kernel.org/project/linux-riscv/list/?series=708610&state=%2A&archive=both

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
  riscv: mm: dma-noncoherent: Switch using function pointers for cache
    management
  riscv: asm: vendorid_list: Add Andes Technology to the vendors list
  riscv: errata: Add Andes alternative ports
  dt-bindings: cache: r9a07g043f-l2-cache: Add DT binding documentation
    for L2 cache controller
  cache: Add L2 cache management for Andes AX45MP RISC-V core
  soc: renesas: Kconfig: Select the required configs for RZ/Five SoC

 .../cache/andestech,ax45mp-cache.yaml         |  81 +++++
 arch/riscv/Kconfig.erratas                    |  22 ++
 arch/riscv/errata/Makefile                    |   1 +
 arch/riscv/errata/andes/Makefile              |   1 +
 arch/riscv/errata/andes/errata.c              |  71 +++++
 arch/riscv/errata/thead/errata.c              |  71 +++++
 arch/riscv/include/asm/alternative.h          |   3 +
 arch/riscv/include/asm/dma-noncoherent.h      |  83 ++++++
 arch/riscv/include/asm/errata_list.h          |  53 ----
 arch/riscv/include/asm/vendorid_list.h        |   1 +
 arch/riscv/kernel/alternative.c               |   5 +
 arch/riscv/kernel/cpufeature.c                |   2 +
 arch/riscv/mm/dma-noncoherent.c               |  94 +++++-
 arch/riscv/mm/pmem.c                          |  18 +-
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/cache/Kconfig                         |  10 +
 drivers/cache/Makefile                        |   3 +
 drivers/cache/ax45mp_cache.c                  | 279 ++++++++++++++++++
 drivers/soc/renesas/Kconfig                   |   4 +
 20 files changed, 744 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
 create mode 100644 arch/riscv/errata/andes/Makefile
 create mode 100644 arch/riscv/errata/andes/errata.c
 create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
 create mode 100644 drivers/cache/Kconfig
 create mode 100644 drivers/cache/Makefile
 create mode 100644 drivers/cache/ax45mp_cache.c

-- 
2.25.1

