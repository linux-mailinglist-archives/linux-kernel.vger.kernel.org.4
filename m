Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E956ABA61
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCFJwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCFJwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:52:20 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03468E054;
        Mon,  6 Mar 2023 01:52:17 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C283D24E01A;
        Mon,  6 Mar 2023 17:52:15 +0800 (CST)
Received: from EXMBX071.cuchost.com (172.16.6.81) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Mar
 2023 17:52:15 +0800
Received: from ubuntu.localdomain (183.27.97.46) by EXMBX071.cuchost.com
 (172.16.6.81) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Mar
 2023 17:52:14 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Peter Chen" <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        "Aswath Govindraju" <a-govindraju@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH 0/3] Add JH7110 USB driver support
Date:   Mon, 6 Mar 2023 17:52:12 +0800
Message-ID: <20230306095212.25840-1-minda.chen@starfivetech.com>
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

patch 1 is usb phy dt-binding document.
patch 2 is the glue layer of Cadence USB3 and USB phy
setting. USB controller IP is Cadence USB3. 
patch 3 is USB device tree configuration.

Minda Chen (3):
  dt-bindings: phy: Add StarFive JH7110 USB dt-binding
  usb: cdns3: add StarFive JH7110 USB glue layer
  dts: usb: add StarFive JH7110 USB dts configuration.

 .../bindings/phy/starfive,jh7110-usb-phy.yaml | 116 +++++
 MAINTAINERS                                   |   7 +
 .../jh7110-starfive-visionfive-2.dtsi         |   6 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  39 ++
 drivers/usb/cdns3/Kconfig                     |  11 +
 drivers/usb/cdns3/Makefile                    |   1 +
 drivers/usb/cdns3/cdns3-starfive.c            | 399 ++++++++++++++++++
 7 files changed, 579 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
 create mode 100644 drivers/usb/cdns3/cdns3-starfive.c


base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
prerequisite-patch-id: 54ce870d6ea747466474b5d4105cfbc05e1b01ab
prerequisite-patch-id: ac150a8c622e858e088df8121093d448df49c245
prerequisite-patch-id: 044263ef2fb9f1e5a586edbf85d5f67814a28430
prerequisite-patch-id: 057fa35870d8d7d22a57c13362588ffb9e9df316
prerequisite-patch-id: 848332ca483b026a755639b9eefb0bf8f3fcf8be
prerequisite-patch-id: 1b2d0982b18da060c82134f05bf3ce16425bac8d
prerequisite-patch-id: 090ba4b78d47bc19204916e76fdbc70021785388
prerequisite-patch-id: a5d9e0f7d4f8163f566678894cf693015119f2d9
prerequisite-patch-id: 87cb528acd9a7f1ffe7475d7261553f6a4de5753
prerequisite-patch-id: 417736eb958e1158c60a5ed74bc2350394321a80
prerequisite-patch-id: ff9fe0b043a5f7f74a1f6af5cebc4793c6f14ce7
prerequisite-patch-id: 290602062703e666191c20ca02f2840471a6bf4f
prerequisite-patch-id: f0b29adbb18edffbfeec7292c5f33e2bbeb30945
prerequisite-patch-id: fccfad539d8455777988b709171ad97729e1a97c
prerequisite-patch-id: 929ebaffab0df158ea801661d0da74e8b5ef138c
prerequisite-patch-id: 0d9ddcaa8a867fcbc790b41d6d0349796e0c44b0
prerequisite-patch-id: 5f539ac7c96023b36489c6da7c70c31eaf64a25b
prerequisite-patch-id: 65f2aed865d88e6fa468d2923527b523d4313857
prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
prerequisite-patch-id: e3b986b9c60b2b93b7812ec174c9e1b4cfb14c97
prerequisite-patch-id: 2e03eeb766aefd5d38f132d091618e9fa19a37b6
prerequisite-patch-id: dbb0c0151b8bdf093e6ce79fd2fe3f60791a6e0b
prerequisite-patch-id: ea9a6d0313dd3936c8de0239dc2072c3360a2f6b
prerequisite-patch-id: d57e95d31686772abc4c4d5aa1cadc344dc293cd
prerequisite-patch-id: 602c3cf8f42c8c88125defa0a8a301da51f8af49
prerequisite-patch-id: 82d2d2bc302045505a51f4ab2bf607a904d4b2d1
prerequisite-patch-id: a6df0f7d8fc2d534c06d85f17578c9134913d01b
prerequisite-patch-id: 2ddada18ab6ea5cd1da14212aaf59632f5203d40
prerequisite-patch-id: b9b8fda5e8cd2dd4c9101ec03f4c8fb8e8caa573
prerequisite-patch-id: 7acbc9c924e802712d3574dd74a6b3576089f78c
prerequisite-patch-id: f9ce88e490c2473c3c94ad63fa26bc91829ce2cc
prerequisite-patch-id: ce8a6557564ba04bd90bb41d34f520347f399887
prerequisite-patch-id: 9f71c539a241baf1e73c7e7dfde5b0b04c66a502
prerequisite-patch-id: 378a6ccc643a8bf51918cdd61876af813564c638
prerequisite-patch-id: bb8e071ed43998874b9d98292c0dcdeedc0760ca
prerequisite-patch-id: 0c04762f1d20f09cd2a1356334a86e520907d111
prerequisite-patch-id: 8867ef35e4d555491a97106db7834149309426b7
prerequisite-patch-id: bab410c96a073b6f9f66f4934a3d9ac4d5b93398
prerequisite-patch-id: 2bc43b375b470f7e8bbe937b78678ba3856e3b8f
prerequisite-patch-id: 9b423b2a1f371b8b18eac9e3280ebb556f329bbd
prerequisite-patch-id: dd3a3e086a7532fe99d46fec4d4938e9bcdb7d1f
-- 
2.17.1

