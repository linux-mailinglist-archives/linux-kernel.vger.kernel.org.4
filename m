Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A183F6052B9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiJSWC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiJSWCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:02:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C761BFBBA;
        Wed, 19 Oct 2022 15:02:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f11so31305207wrm.6;
        Wed, 19 Oct 2022 15:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tnzQJseoXg0993O/jYRru0Ddht5bYo8gE2zFXRgP2o=;
        b=ePupxn0zNCvRCwps62nYVtsb1ZuBj23fKYYGb68vZHgB3Rh99LYV4+IAj6cfZWtnmb
         Nhr8l3KQ1qj/nzsP/yU4yLNY8NK6KJztGk+XJ/Y0jAB9n1xDfWvC6rT4Ii4cUomKsdBg
         fl7NUQl/PiRLnCSmbmDp+URxNESLdS1c+WtKz6toPomXjGN21RUfJ79durQiClsZqVih
         7EoENcTji7lEVPZHYQYGVvFGsRY46psYoTaq0kSkiv0oL88TM+vKVJ5IuYLOUUVLiHda
         EEH1Z3uaK8RM89b0qe/36Ddgk+f6RhhlJYlObN8sjrUqCw1Hmn2CwghMaVVhhJqAw3Vf
         lF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tnzQJseoXg0993O/jYRru0Ddht5bYo8gE2zFXRgP2o=;
        b=fdsvQdCUyfATyv5WtJSmIYFl4kQpuokScNYMLffUHnjGAUj7FW2X8GFQoZqx4RmmL0
         ymgsXexPqhPsOA9kEbPbkqNlJNYm6OunzQtObORytiN8ztvB3lBmGmldywYe/ZHtNQjr
         j3yWnjgaXmhougSOPKUvsHqlzO2wGTbDk2WFitteCd8YxQxAXMwikDZ0PzicjAWTTGWj
         gkoXtOgFmGb9CNhu+abRqj5KzIiIBoPOQw62T6jNVaGcoKOlUy/Gm1iFZJS3XWNbztk/
         qPJDQvN36gks3gqDxVXZ4D10LFE/lyR6C1IF3H0xQ4FSX2L8J0/X4bO8ro7Y00E3fydh
         Hwvw==
X-Gm-Message-State: ACrzQf2Z8l6q7H3vOKZCgJJSkKQdm8IPMrQ09uLOpwHtwK9FkYrq9GAR
        V6TT6D43rLmXn8bewizhewY=
X-Google-Smtp-Source: AMsMyM5b3L8ebsxgMLETpnWx2040/FzLzVBU782drufE0IhUyvBoI3BIcRp4Zcp8QIlNWRRAUCzSKw==
X-Received: by 2002:a5d:4c44:0:b0:22e:3503:41bf with SMTP id n4-20020a5d4c44000000b0022e350341bfmr6690210wrt.0.1666216972763;
        Wed, 19 Oct 2022 15:02:52 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d8c7:b527:b960:aa04])
        by smtp.gmail.com with ESMTPSA id m7-20020a5d6247000000b0022c906ffedasm14807824wrv.70.2022.10.19.15.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:02:52 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.co>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH v3 0/2] AX45MP: Add support to non-coherent DMA
Date:   Wed, 19 Oct 2022 23:02:40 +0100
Message-Id: <20221019220242.4746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

1] Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
block that allows dynamic adjustment of memory attributes in the runtime.
It contains a configurable amount of PMA entries implemented as CSR
registers to control the attributes of memory locations in interest. PMA
regions are passed from the l2 node which are configured as
non-cacheable + bufferable with the SBI call.

        l2cache: cache-controller@13400000 {
                ....
                andestech,pma-regions = <0x0 0x58000000 0x0 0x08000000 0x0
                                         (AX45MP_PMACFG_ETYP_NAPOT |
                                          AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF)>;
                ....
        };

2] We provide callbacks to synchronize specific content between memory and
cache.

        - arch_sync_dma_for_device()
        - arch_sync_dma_for_cpu()

Below are the configs that are enabled:

        - DMA_GLOBAL_POOL
        - RISCV_DMA_NONCOHERENT

3] We reserve the shared DMA pool, so the DMA memory requests go through
   this pool:

        reserved-memory {
                #address-cells = <2>;
                #size-cells = <2>;
                ranges;

                reserved: linux,cma@58000000 {
                        compatible = "shared-dma-pool";
                        no-map;
                        linux,dma-default;
                        reg = <0x0 0x58000000 0x0 0x08000000>;
                };
        };


Below is the L2 cache DT node:

        l2cache: cache-controller@13400000 {
                compatible = "andestech,ax45mp-cache", "cache";
                cache-size = <0x40000>;
                cache-line-size = <64>;
                cache-sets = <1024>;
                cache-unified;
                reg = <0x0 0x13400000 0x0 0x100000>;
                andestech,pma-regions = <0x0 0x58000000 0x0 0x08000000 0x0
                                         (AX45MP_PMACFG_ETYP_NAPOT |
                                          AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF)>;
                andestech,inst-prefetch = <0x3>;
                andestech,data-prefetch = <0x3>;
                andestech,tag-ram-ctl = /bits/ 8 <0x1 0x0>;
                andestech,data-ram-ctl = /bits/ 8 <0x1 0x0>;
                interrupts = <SOC_PERIPHERAL_IRQ(476, IRQ_TYPE_LEVEL_HIGH)>;
        };

Due to the above approach custom SBI calls have been implemented. The
above implementation is in preparation for adding support for Renesas
RZ/Five SoC which uses the AX45MP core. As with the above approach the
kernel image might not be generic so that it can be used on other
platforms, so sending it as an RFC (without DT binding patches).

OpenSBI implementation isn't upstreamed yet, public repo for access is
available at [0].

[0] https://github.com/renesas-rz/rz_opensbi/tree/work/OpenSBI-PMA

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

Sending this as an RFC as CONFIG_ERRATA_THEAD_CMO/CONFIG_AX45MP_L2_CACHE
is used for determining the CMO to call it would better if we could do
this runtime instead.

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: cache: r9a07g043f-l2-cache: Add DT binding documentation
    for L2 cache controller
  soc: renesas: Add L2 cache management for RZ/Five SoC

 .../cache/andestech,ax45mp-cache.yaml         | 125 +++++
 arch/riscv/include/asm/cacheflush.h           |   8 +
 arch/riscv/include/asm/errata_list.h          |   2 +
 arch/riscv/mm/dma-noncoherent.c               |  20 +
 drivers/soc/renesas/Kconfig                   |   5 +
 drivers/soc/renesas/Makefile                  |   4 +
 drivers/soc/renesas/rzf/Kconfig               |   6 +
 drivers/soc/renesas/rzf/Makefile              |   3 +
 drivers/soc/renesas/rzf/ax45mp_cache.c        | 431 ++++++++++++++++++
 drivers/soc/renesas/rzf/ax45mp_sbi.h          |  29 ++
 .../cache/andestech,ax45mp-cache.h            |  38 ++
 11 files changed, 671 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
 create mode 100644 drivers/soc/renesas/rzf/Kconfig
 create mode 100644 drivers/soc/renesas/rzf/Makefile
 create mode 100644 drivers/soc/renesas/rzf/ax45mp_cache.c
 create mode 100644 drivers/soc/renesas/rzf/ax45mp_sbi.h
 create mode 100644 include/dt-bindings/cache/andestech,ax45mp-cache.h

-- 
2.25.1

