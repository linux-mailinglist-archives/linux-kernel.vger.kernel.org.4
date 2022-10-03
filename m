Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C2C5F391A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJCWcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJCWcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:32:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79DF558E7;
        Mon,  3 Oct 2022 15:32:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso6563275wms.5;
        Mon, 03 Oct 2022 15:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=0tMQzYjbaLsCweYjpM8n0zpd8PrCu0Lk7bNxjno/MYg=;
        b=YpfI3BvwLzUzZT8AxK4Fy83CrWDoIqpJvkmiMCUhYoNXFAMJILcu/6XrQGf6/IH/cN
         3OiBOdUgv7UBULMF1qoWVtKVa2gg7lCtGCT9nPtHNXll+QpN5NLx1smTWdNCy3oXWQDf
         nGE29uinV6ltUsnRKRFhhJilWuK5eFsb1978oaEz/YP92Y+Cy7GrEi+QVjgtupARRjN7
         DHYiQYP8y3q/1xVGZauGn7esikf03cSEpm8yC57qj1nfHqi/OwNTVhqB81WXOvsENYNN
         2SYfyAveTq1QpLyCNyyk3d7kAG1klLg9LRsyIVkes4OE27/pke2IqBn86Rk3kr5aa5/p
         lK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=0tMQzYjbaLsCweYjpM8n0zpd8PrCu0Lk7bNxjno/MYg=;
        b=uClMK5r88Ony06w5An7NnJrySB1VGrbCi1lZx5r5ApXg2zjEvgdnUEpzP3ysegantP
         UHrVrLTxZZ1mIlFStMFcKmZHQXndaN8dRDwRNHaX92gz0DTz+VWO/q3M5K6Upnyt1Wab
         /dOpQkh7gwMzbXC3e1wXFUqe1RaoW9t/jMoakuXUr2tKA4QwoZmdSQz8PWbRgYzyHy6+
         ntf6bgduMIb1goph8TtKyPnvOGmJuUoxGzx1enMOaFZlaoin2hKwILaUy2o9VqAEoyET
         bnAnThr+mvCx/HJOtfa/4p28mJk36JwXiE89Ub037HZbamMA4+txLsrkqoM0wAGmLo/m
         MWiQ==
X-Gm-Message-State: ACrzQf3K3iUH3MrNsjooNM8kiniL0c2IrPZ3jkHVsnSh66MtwT91YDko
        iho1JqOLZ+wRChSlthbVROeQFdff/Lsl5Q==
X-Google-Smtp-Source: AMsMyM4NJ+peHG8KO0QpBjrEY85xQCl64YMPRI3dJ6cmcmu8BoQyKJV5tsNB2kw9Yp+MV3edWkc3FQ==
X-Received: by 2002:a05:600c:221a:b0:3b4:75b8:3f7f with SMTP id z26-20020a05600c221a00b003b475b83f7fmr7962580wml.175.1664836363255;
        Mon, 03 Oct 2022 15:32:43 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c8:2501:c701:34b9:36fa:3827:d20])
        by smtp.gmail.com with ESMTPSA id m64-20020a1ca343000000b003a6125562e1sm12884871wme.46.2022.10.03.15.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 15:32:42 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH v2 0/2] AX45MP: Add support to non-coherent DMA
Date:   Mon,  3 Oct 2022 23:32:20 +0100
Message-Id: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
non-cacheable and bufferable with the SBI call.

        l2cache: cache-controller@13400000 {
                ....
                pma-regions = <0x0 0x00000000 0x0 0x14000000>,
                              <0x0 0x20000000 0x0 0x10000000>,
                              <0x0 0x58000000 0x0 0x08000000>;
                ....
        };

2] We provide callbacks to synchronize specific content between memory and
cache.

        - arch_sync_dma_for_device()
        - arch_sync_dma_for_cpu()

Below are the configs that are enabled:

        - DMA_GLOBAL_POOL
        - RISCV_DMA_NONCOHERENT

Below is the L2 cache DT node:

        l2cache: cache-controller@13400000 {
                compatible = "andestech,ax45mp-cache", "cache";
                cache-size = <0x40000>;
                cache-line-size = <64>;
                cache-sets = <1024>;
                cache-unified;
                reg = <0x0 0x13400000 0x0 0x100000>;
                pma-regions = <0x0 0x00000000 0x0 0x10000000>,
                              <0x0 0x10000000 0x0 0x04000000>,
                              <0x0 0x20000000 0x0 0x10000000>,
                              <0x0 0x58000000 0x0 0x08000000>;
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

RFC v1-> RFC v2
* Moved out the code from arc/riscv to drivers/soc/renesas
* Now handling the PMA setup as part of the L2 cache
* Now making use of dma-noncoherent.c instead SoC specific implementation.
* Dropped arch_dma_alloc() and arch_dma_free()
* Switched to RISCV_DMA_NONCOHERENT
* Included DT binding doc

RFC v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Sending this as an RFC as CONFIG_ERRATA_THEAD_CMO/CONFIG_ARCH_R9A07G043
is used for determining the CMO to call it would better if we could do
this runtime instead.

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: soc: renesas: r9a07g043f-l2-cache: Add DT binding
    documentation for L2 cache controller
  soc: renesas: Add L2 cache management for RZ/Five SoC

 .../soc/renesas/r9a07g043f-l2-cache.yaml      |  82 ++++
 arch/riscv/include/asm/cacheflush.h           |   8 +
 arch/riscv/include/asm/errata_list.h          |   2 +
 arch/riscv/include/asm/sbi.h                  |   1 +
 arch/riscv/mm/dma-noncoherent.c               |  20 +
 drivers/soc/renesas/Makefile                  |   4 +
 drivers/soc/renesas/rzf/Makefile              |   3 +
 drivers/soc/renesas/rzf/ax45mp_cache.c        | 365 ++++++++++++++++++
 drivers/soc/renesas/rzf/rzf_sbi.h             |  27 ++
 9 files changed, 512 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/r9a07g043f-l2-cache.yaml
 create mode 100644 drivers/soc/renesas/rzf/Makefile
 create mode 100644 drivers/soc/renesas/rzf/ax45mp_cache.c
 create mode 100644 drivers/soc/renesas/rzf/rzf_sbi.h

-- 
2.25.1

