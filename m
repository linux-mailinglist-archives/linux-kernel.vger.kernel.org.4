Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC086D6A5F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbjDDRWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbjDDRWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:22:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2BE55AB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id eg48so133476716edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qzrmrsnSm/BbmnOLi1/MJr2qxujsBwUfkqfpZwv0p58=;
        b=oIVp7n6PQMz+57+fil+I3xidTmKbQDEDtjhOjb5oqrn3q2/Pm3oyHUMsSpNdFkUG1W
         gop6fXk/fB5m3y+ohJS7w9cWzgBnjhktdXJO640VJ1YvdWW2c4CtcmsuJh0VxTLIQo3H
         aDy6Zt9ISRiXTsMOjgtXJKwTkCsSSVd/LD58fSNzqjR1eViNcPqlxDIL5lTXUB6NLL0n
         6FFRkJPyO/E8w0M0VHKqZgOwIvOg5QQzUkch+st+zr3z/NbZwmlrZOUjIPzfBfyiL2m4
         OPLb6ZZWpzFPUuykTu+f9gF5pHowXGaWjoCIp44EP9sU5QDRDVw28VQt1wlfCDXKqAUx
         pJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzrmrsnSm/BbmnOLi1/MJr2qxujsBwUfkqfpZwv0p58=;
        b=WHVxuNh5QmnS1R1/bJB1JebA02c//rW091yW6mP9cjY2sEGEWkjM98HrLFFw9Btmt7
         m1UT732ng/+EFICuuW26/5UyjLG682ZU3G19Sz54znmT8CX4WmCZBKUstG1MMmVJbdiP
         Ffde2T+hMLG18oHeTBDT+IDYt5l5d4cAIz1VZEal/dUAtXBIrSb1YdHMCi8o3Ihg47tz
         OuT1KAcPtcJ8DbhImaONAZG3W7OJ+wHrlAyFVglLJp8DYsNmuxN+F2IKxE25ZDIxLGf2
         G1rGbjOkotusGgQtJ53mjJ8fR39CnN55UrSvp/QdjeDXka19i541/rDfS1RsrhBpfVYP
         Ezpw==
X-Gm-Message-State: AAQBX9ez6TMHNTz6HOYt27o7QfTA1J6JZpe1Q0xlJ2gDTyB0NKe+Ctqs
        chMk8utiEk/XYKfg0O+kIpXLZQ==
X-Google-Smtp-Source: AKy350YX8ofjdm0N6OKE5TRKi06EJk9lF5ilD+qVHn8mhpqjOSAzT3nJEqfNt5uhVsO2pa6oxct8fg==
X-Received: by 2002:a17:906:1810:b0:948:ce3e:8660 with SMTP id v16-20020a170906181000b00948ce3e8660mr261285eje.53.1680628940554;
        Tue, 04 Apr 2023 10:22:20 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:19 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/40] nvmem: patches for 6.4
Date:   Tue,  4 Apr 2023 18:21:08 +0100
Message-Id: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches bit more than usual for 6.4 that includes

- Support for nvmem layouts modules, post-processing, thanks to Michael and
 Miquel for being patience and driving this effort.
- Enhancements in dt core to support nvmem layout modules and some
  changes in other drivers to support this enhancements. All of these
 are acked/reviwed by respective maintainers.
- Updated to qfprom bindings to include various Qualcomm SoCs.
- sl28vpd and onie layout providers.
- u-boot-env post processing support.
- move imx provider to use new layout apis
- few minor fixes across core and providers drivers.

Can you please queue them up for 6.4.

Thanks,
Srini

AngeloGioacchino Del Regno (1):
  nvmem: mtk-efuse: Support postprocessing for GPU speed binning data

Colin Ian King (1):
  dt-bindings: nvmem: Fix spelling mistake "platforn" -> "platform"

Johan Hovold (1):
  dt-bindings: nvmem: qcom,spmi-sdam: fix example 'reg' property

Konrad Dybcio (2):
  dt-bindings: nvmem: Add compatible for SM6350
  dt-bindings: nvmem: Add compatible for SM6375

Krzysztof Kozlowski (1):
  nvmem: stm32-romem: mark OF related data as maybe unused

Michael Walle (8):
  nvmem: core: introduce NVMEM layouts
  nvmem: core: add per-cell post processing
  nvmem: core: allow to modify a cell before adding it
  nvmem: imx-ocotp: replace global post processing with layouts
  nvmem: cell: drop global cell_post_process
  nvmem: core: provide own priv pointer in post process callback
  nvmem: layouts: sl28vpd: Add new layout driver
  MAINTAINERS: add myself as sl28vpd nvmem layout driver

Miquel Raynal (15):
  of: Fix modalias string generation
  of: Update of_device_get_modalias()
  of: Rename of_modalias_node()
  of: Move of_modalias() to module.c
  of: Move the request module helper logic to module.c
  usb: ulpi: Use of_request_module()
  of: device: Kill of_device_request_module()
  nvmem: core: handle the absence of expected layouts
  nvmem: core: request layout modules loading
  nvmem: layouts: onie-tlv: Add new layout driver
  MAINTAINERS: Add myself as ONIE tlv NVMEM layout maintainer
  nvmem: Add macro to register nvmem layout drivers
  nvmem: layouts: sl28vpd: Use module_nvmem_layout_driver()
  nvmem: layouts: onie-tlv: Use module_nvmem_layout_driver()
  nvmem: layouts: onie-tlv: Drop wrong module alias

Neil Armstrong (2):
  dt-bindings: nvmem: convert amlogic-meson-mx-efuse.txt to dt-schema
  dt-bindings: nvmem: convert amlogic-efuse.txt to dt-schema

Nick Alcock (1):
  nvmem: xilinx: zynqmp: make modular

Rafał Miłecki (3):
  dt-bindings: nvmem: u-boot,env: add MAC's #nvmem-cell-cells
  nvmem: core: support specifying both: cell raw data & post read
    lengths
  nvmem: u-boot-env: post-process "ethaddr" env variable

Rob Herring (1):
  dt-bindings: nvmem: Drop unneeded quotes

Tom Rix (1):
  nvmem: layouts: sl28vpd: set varaiable sl28vpd_layout
    storage-class-specifier to static

Yang Li (3):
  nvmem: bcm-ocotp: Use devm_platform_ioremap_resource()
  nvmem: nintendo-otp: Use devm_platform_ioremap_resource()
  nvmem: vf610-ocotp: Use devm_platform_get_and_ioremap_resource()

 .../nvmem/allwinner,sun4i-a10-sid.yaml        |   2 +-
 .../nvmem/amlogic,meson-gxbb-efuse.yaml       |  57 ++++
 .../bindings/nvmem/amlogic,meson6-efuse.yaml  |  57 ++++
 .../bindings/nvmem/amlogic-efuse.txt          |  48 ----
 .../bindings/nvmem/amlogic-meson-mx-efuse.txt |  22 --
 .../bindings/nvmem/apple,efuses.yaml          |   2 +-
 .../devicetree/bindings/nvmem/brcm,nvram.yaml |   2 +-
 .../bindings/nvmem/fsl,layerscape-sfp.yaml    |   2 +-
 .../devicetree/bindings/nvmem/imx-iim.yaml    |   2 +-
 .../devicetree/bindings/nvmem/imx-ocotp.yaml  |   2 +-
 .../bindings/nvmem/ingenic,jz4780-efuse.yaml  |   2 +-
 .../nvmem/layouts/onie,tlv-layout.yaml        |   2 +-
 .../bindings/nvmem/mediatek,efuse.yaml        |   2 +-
 .../nvmem/microchip,sama7g5-otpc.yaml         |   2 +-
 .../devicetree/bindings/nvmem/mxs-ocotp.yaml  |   2 +-
 .../bindings/nvmem/nintendo-otp.yaml          |   2 +-
 .../bindings/nvmem/qcom,qfprom.yaml           |   4 +-
 .../bindings/nvmem/qcom,spmi-sdam.yaml        |  33 ++-
 .../devicetree/bindings/nvmem/rmem.yaml       |   2 +-
 .../bindings/nvmem/rockchip-efuse.yaml        |   2 +-
 .../nvmem/socionext,uniphier-efuse.yaml       |   2 +-
 .../bindings/nvmem/st,stm32-romem.yaml        |   2 +-
 .../bindings/nvmem/sunplus,sp7021-ocotp.yaml  |   2 +-
 .../devicetree/bindings/nvmem/u-boot,env.yaml |   7 +-
 Documentation/driver-api/nvmem.rst            |  15 ++
 MAINTAINERS                                   |  12 +
 drivers/acpi/bus.c                            |   7 +-
 drivers/gpu/drm/drm_mipi_dsi.c                |   2 +-
 drivers/hsi/hsi_core.c                        |   2 +-
 drivers/i2c/busses/i2c-powermac.c             |   2 +-
 drivers/i2c/i2c-core-of.c                     |   2 +-
 drivers/nvmem/Kconfig                         |   7 +-
 drivers/nvmem/Makefile                        |   1 +
 drivers/nvmem/bcm-ocotp.c                     |   4 +-
 drivers/nvmem/core.c                          | 169 +++++++++++-
 drivers/nvmem/imx-ocotp.c                     |  30 ++-
 drivers/nvmem/layouts/Kconfig                 |  23 ++
 drivers/nvmem/layouts/Makefile                |   7 +
 drivers/nvmem/layouts/onie-tlv.c              | 244 ++++++++++++++++++
 drivers/nvmem/layouts/sl28vpd.c               | 153 +++++++++++
 drivers/nvmem/mtk-efuse.c                     |  53 +++-
 drivers/nvmem/nintendo-otp.c                  |   4 +-
 drivers/nvmem/stm32-romem.c                   |   2 +-
 drivers/nvmem/u-boot-env.c                    |  26 ++
 drivers/nvmem/vf610-ocotp.c                   |   3 +-
 drivers/of/Makefile                           |   2 +-
 drivers/of/base.c                             |  18 +-
 drivers/of/device.c                           |  75 +-----
 drivers/of/module.c                           |  74 ++++++
 drivers/spi/spi.c                             |   4 +-
 drivers/usb/common/ulpi.c                     |   2 +-
 include/linux/nvmem-consumer.h                |   7 +
 include/linux/nvmem-provider.h                |  74 +++++-
 include/linux/of.h                            |  18 +-
 include/linux/of_device.h                     |   6 -
 55 files changed, 1081 insertions(+), 229 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
 delete mode 100644 Documentation/devicetree/bindings/nvmem/amlogic-meson-mx-efuse.txt
 create mode 100644 drivers/nvmem/layouts/Kconfig
 create mode 100644 drivers/nvmem/layouts/Makefile
 create mode 100644 drivers/nvmem/layouts/onie-tlv.c
 create mode 100644 drivers/nvmem/layouts/sl28vpd.c
 create mode 100644 drivers/of/module.c

-- 
2.25.1

