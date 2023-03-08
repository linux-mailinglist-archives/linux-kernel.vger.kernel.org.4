Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4216B017B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCHIby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCHIbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:31:15 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5497B0B81;
        Wed,  8 Mar 2023 00:30:48 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 49FEB24E143;
        Wed,  8 Mar 2023 16:28:03 +0800 (CST)
Received: from EXMBX071.cuchost.com (172.16.6.81) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 8 Mar
 2023 16:28:02 +0800
Received: from ubuntu.localdomain (183.27.97.46) by EXMBX071.cuchost.com
 (172.16.6.81) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 8 Mar
 2023 16:28:02 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v2 0/3] Add JH7110 USB driver support
Date:   Wed, 8 Mar 2023 16:27:57 +0800
Message-ID: <20230308082800.3008-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.46]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX071.cuchost.com
 (172.16.6.81)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds USB driver for the StarFive JH7110 SoC.
USB work mode is peripheral and using USB 2.0 PHY in VisionFive 2 board.
The patch has been tested on the VisionFive 2 board.

This patchset should be applied after the patchset [1] and patch [2]:
[1] https://lore.kernel.org/all/20230221083323.302471-1-xingyu.wu@starfivetech.com/
[2] https://lore.kernel.org/all/20230215113249.47727-4-william.qiu@starfivetech.com/

This patchset is base on v6.3-rc1

patch 1 is usb phy dt-binding document.
patch 2 is the glue layer of Cadence USB3 and USB phy setting. USB controller IP is Cadence USB3.
patch 3 is USB device tree configuration.

previous version
---
v1: https://patchwork.kernel.org/project/linux-usb/patch/20230306095339.26006-1-minda.chen@starfivetech.com/

changes
v2
  1. (patch 1) dt-binding check test pass and no warning. The document example is the same as dts config.
  2. (patch 2) using dev_err_probe and syscon_regmap_lookup_by_phandle_args function. Some formats changes
  3. (patch 3) dts nodes sorted by the address after @

Minda Chen (3):
  dt-bindings: phy: Add StarFive JH7110 USB dt-binding
  usb: cdns3: add StarFive JH7110 USB glue layer
  dts: usb: add StarFive JH7110 USB dts configuration.

 .../bindings/phy/starfive,jh7110-usb-phy.yaml | 158 ++++++++
 MAINTAINERS                                   |   7 +
 .../jh7110-starfive-visionfive-2.dtsi         |   6 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  38 ++
 drivers/usb/cdns3/Kconfig                     |  11 +
 drivers/usb/cdns3/Makefile                    |   1 +
 drivers/usb/cdns3/cdns3-starfive.c            | 374 ++++++++++++++++++
 7 files changed, 595 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
 create mode 100644 drivers/usb/cdns3/cdns3-starfive.c


base-commit: 8ca09d5fa3549d142c2080a72a4c70ce389163cd
prerequisite-patch-id: 0e6d1df3ba9aecd925a0c604b9d91f7143be88ca
prerequisite-patch-id: ac150a8c622e858e088df8121093d448df49c245
prerequisite-patch-id: 044263ef2fb9f1e5a586edbf85d5f67814a28430
prerequisite-patch-id: 74390c129b92fb35a7088e2e5c869632c4cb3d06
prerequisite-patch-id: de93ebec041625e940f195403069b46ec17fc99c
prerequisite-patch-id: 1b2d0982b18da060c82134f05bf3ce16425bac8d
prerequisite-patch-id: 090ba4b78d47bc19204916e76fdbc70021785388
prerequisite-patch-id: a5d9e0f7d4f8163f566678894cf693015119f2d9
prerequisite-patch-id: f01a78c30f6f1970b4db7758c339bd4e5c882b16
prerequisite-patch-id: 417736eb958e1158c60a5ed74bc2350394321a80
prerequisite-patch-id: ff9fe0b043a5f7f74a1f6af5cebc4793c6f14ce7
prerequisite-patch-id: 290602062703e666191c20ca02f2840471a6bf4f
prerequisite-patch-id: f0b29adbb18edffbfeec7292c5f33e2bbeb30945
prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
prerequisite-patch-id: dbb0c0151b8bdf093e6ce79fd2fe3f60791a6e0b
prerequisite-patch-id: ea9a6d0313dd3936c8de0239dc2072c3360a2f6b
prerequisite-patch-id: d57e95d31686772abc4c4d5aa1cadc344dc293cd
prerequisite-patch-id: 27197d69922ad1f33a193dfe0a8cc2b27d67982d
prerequisite-patch-id: f9ce88e490c2473c3c94ad63fa26bc91829ce2cc
prerequisite-patch-id: 7acbc9c924e802712d3574dd74a6b3576089f78c
prerequisite-patch-id: b9b8fda5e8cd2dd4c9101ec03f4c8fb8e8caa573
prerequisite-patch-id: 63a6de4511f1a7ae974551e7097af9bb91db1b0d
prerequisite-patch-id: aaff99c0bdd1604048d0713b44084ad4604816e1
-- 
2.17.1

