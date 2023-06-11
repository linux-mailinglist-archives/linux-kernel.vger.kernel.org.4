Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A3A72B225
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjFKODs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFKODp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:03:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13956E77
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f7353993cbso24871565e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492222; x=1689084222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6A2V4qKLe8T/VXqvvnb9FBk43tee1zTCPBfprROqi5s=;
        b=GzHAvusyBmRKM3RvqaBI4hYspxe+QdwLIJHLyedQdZ+Y6TakR/DMbn/a0DJhuBjm7S
         sRhTrbx6i/b8HWjxvWyaD0Mxex4phXbAWpE3bqmPqCMCvBS69+vJj8lWukuIo3sqp2M7
         fBmsyX5Cs92TPP7copRxKILvQDqDeo/dD2d+vIpttarggwsMxmCBuxWQpdVcDi5m4lO0
         /bvtTCoAeJ+8OxQB/fsSKxCP/b8xntxjLkmyWopW+HKR5B9ejD2pL7E6xmrhgCY6TeDM
         j4pq2EIHoM9GSx7U5gem+V0NYX755gSR+Jtcg17iqXkS3UrmuNRml3kal3Zgg1jvI3Y+
         ZD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492222; x=1689084222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6A2V4qKLe8T/VXqvvnb9FBk43tee1zTCPBfprROqi5s=;
        b=bZ5OuoXcn+7jti0jb/xqBkolxwYqJrZit9sgDq2iw93E/xlCJtQfRULbyZhOcEKHY1
         nt0e28D/xXAKDUYLQyhk8gQfKGQQ/5btGinngxYoA6UvQ+C7eGxJ+MeubcVzZmLJiFES
         +G8Qe6csXxm0Tvw05O/gT13XmMUQHT6uUrxfJ2pUIH2fGTZY+DJizSuGJInkBly128Cs
         bdBSoIjjdekhhBb1jSr6UhxSpB6qNzHILUQKhI2AbAXIkvfLVumV4QOgsLTqESQ97iH4
         CdWa2bgVebUq+LwJ0Cv1iiJ966aNAvVi+8CQf2YgITFNdA7rxb03mPLZ73Wafc4vgvaD
         K8Wg==
X-Gm-Message-State: AC+VfDzgJ0rzqM18II+MPHFFw5xdmxjhQmXD1EiSYTz++DTjy+H53c2e
        6RYXdUA+7YwGLxl0FFC5OsnHoFJEanUEO4wKKsU=
X-Google-Smtp-Source: ACHHUZ7Q9D791KRNJF6Eio6TnAShf5BBDi4KQaaDS4gxGDk57XCtXe8fcRACT98AGjaIRDbw+xLo5g==
X-Received: by 2002:a05:600c:1656:b0:3f7:f302:161 with SMTP id o22-20020a05600c165600b003f7f3020161mr8221939wmn.8.1686492222307;
        Sun, 11 Jun 2023 07:03:42 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:03:41 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/26] nvmem: patches for 6.5
Date:   Sun, 11 Jun 2023 15:03:04 +0100
Message-Id: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches slightly more than usual for 6.5 that includes

- add support for rockchip-otp, mediatek mt7986 and imx i.MX93 provider.
- Support for nvmem fixed layouts thanks to Miquel for being patience and driving this effort.
- various trivial cleanups in bindings by Krzysztof.
- few minor fixes and cleanups across providers drivers.

Can you please queue them up for 6.5.

Thanks,
Srini


MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Alexander Stein (1):
  nvmem: imx-ocotp: Reverse MAC addresses on all i.MX derivates

Cristian Ciocaltea (7):
  dt-bindings: nvmem: Convert rockchip-otp.txt to dt-schema
  dt-bindings: nvmem: rockchip,otp: Add compatible for RK3588
  nvmem: rockchip-otp: Add clks and reg_read to rockchip_data
  nvmem: rockchip-otp: Generalize rockchip_otp_wait_status()
  nvmem: rockchip-otp: Use devm_reset_control_array_get_exclusive()
  nvmem: rockchip-otp: Improve probe error handling
  nvmem: rockchip-otp: Add support for RK3588

Frank Wunderlich (1):
  dt-bindings: nvmem: mediatek: efuse: add support for mt7986

Ivan T. Ivanov (1):
  dt-bindings: nvmem: rmem: Add raspberrypi,bootloader-public-key

Krzysztof Kozlowski (6):
  dt-bindings: nvmem: mxs-ocotp: drop unneeded address/size-cells
  dt-bindings: nvmem: qcom,qfprom: drop unneeded address/size-cells
  dt-bindings: nvmem: qcom,spmi-sdam: drop unneeded address/size-cells
  dt-bindings: nvmem: socionext,uniphier-efuse: drop unneeded
    address/size-cells
  dt-bindings: nvmem: sunplus,sp7021-ocotp: drop unneeded
    address/size-cells
  dt-bindings: nvmem: imx-ocotp: drop unneeded address/size-cells and
    children

Michal Simek (1):
  nvmem: zynqmp: Switch @xilinx.com emails to @amd.com

Peng Fan (2):
  dt-bindings: nvmem: imx-ocotp: support i.MX93
  nvmem: imx: support i.MX93 OCOTP

Phil Elwell (1):
  nvmem: rmem: Use NVMEM_DEVID_AUTO

Rafał Miłecki (5):
  dt-bindings: nvmem: brcm,nvram: add #nvmem-cell-cells for MACs
  nvmem: brcm_nvram: add .read_post_process() for MACs
  dt-bindings: nvmem: layouts: add fixed-layout
  dt-bindings: nvmem: convert base example to use NVMEM fixed cells
    layout
  nvmem: core: add support for fixed cells *layout*

Tom Rix (1):
  nvmem: imx-ocotp: set varaiable imx_ocotp_layout
    storage-class-specifier to static

 .../devicetree/bindings/nvmem/brcm,nvram.yaml |  15 ++
 .../devicetree/bindings/nvmem/imx-ocotp.yaml  |  26 +--
 .../bindings/nvmem/layouts/fixed-cell.yaml    |  31 +++
 .../bindings/nvmem/layouts/fixed-layout.yaml  |  50 +++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |   5 +-
 .../bindings/nvmem/mediatek,efuse.yaml        |   1 +
 .../devicetree/bindings/nvmem/mxs-ocotp.yaml  |   8 +-
 .../devicetree/bindings/nvmem/nvmem.yaml      |  61 +++---
 .../bindings/nvmem/qcom,qfprom.yaml           |   6 -
 .../bindings/nvmem/qcom,spmi-sdam.yaml        |   6 -
 .../devicetree/bindings/nvmem/rmem.yaml       |   1 +
 .../bindings/nvmem/rockchip,otp.yaml          | 122 +++++++++++
 .../bindings/nvmem/rockchip-otp.txt           |  25 ---
 .../nvmem/socionext,uniphier-efuse.yaml       |   3 -
 .../bindings/nvmem/sunplus,sp7021-ocotp.yaml  |   6 -
 drivers/nvmem/Kconfig                         |  10 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/brcm_nvram.c                    |  28 +++
 drivers/nvmem/core.c                          |  32 ++-
 drivers/nvmem/imx-ocotp-ele.c                 | 175 ++++++++++++++++
 drivers/nvmem/imx-ocotp.c                     |  10 +-
 drivers/nvmem/rmem.c                          |   1 +
 drivers/nvmem/rockchip-otp.c                  | 191 +++++++++++++-----
 drivers/nvmem/zynqmp_nvmem.c                  |   2 +-
 24 files changed, 643 insertions(+), 174 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/rockchip-otp.txt
 create mode 100644 drivers/nvmem/imx-ocotp-ele.c

-- 
2.25.1

