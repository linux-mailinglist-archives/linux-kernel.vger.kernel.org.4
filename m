Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D03F660806
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbjAFURP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbjAFUQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:16:53 -0500
X-Greylist: delayed 357 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Jan 2023 12:15:00 PST
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69557872B1;
        Fri,  6 Jan 2023 12:15:00 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 60C16C0000E8;
        Fri,  6 Jan 2023 12:09:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 60C16C0000E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1673035743;
        bh=9LfQKQV169LGVKLjK7ivfmkNICEpYuHgT1kmIM5E64A=;
        h=From:To:Cc:Subject:Date:From;
        b=jAOehjOVrzJ6PZbyey61jYHyY9LgZ6Jh8gxtW6k34BrwdwYuUugq0Djcfj+ooekAM
         GhPlaQdcMRXLqD5y5BVhPsaKXwO6KN4N4L27Ze8USYzK7+oSEm6rusPiLDPd/JaGqK
         jk1saE9jjHTAtiuz7xGn6iv7QNQUOBfpM6wYKtG4=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 5DAE218041CAC6;
        Fri,  6 Jan 2023 12:09:03 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 841E8101B33; Fri,  6 Jan 2023 12:08:51 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        William Zhang <william.zhang@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/16] spi: bcm63xx-hsspi: driver and doc updates
Date:   Fri,  6 Jan 2023 12:07:52 -0800
Message-Id: <20230106200809.330769-1-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series include the accumulative updates and fixes for the
driver from Broadcom. It also added a new driver for the updated SPI
controller found in the new BCMBCA SoC. The device tree document is
converted to yaml format and updated accordingly.


William Zhang (16):
  dt-bindings: spi: Convert bcm63xx-hsspi bindings to json-schema
  dt-bindings: spi: Add bcmbca-hsspi controller support
  dt-bindings: spi: Add spi peripheral specific property
  ARM: dts: broadcom: bcmbca: Add spi controller node
  arm64: dts: broadcom: bcmbca: Add spi controller node
  spi: bcm63xx-hsspi: Endianness fix for ARM based SoC
  spi: bcm63xx-hsspi: Add polling mode support
  spi: bcm63xx-hsspi: Handle cs_change correctly
  spi: bcm63xx-hsspi: Fix multi-bit mode setting
  spi: bcm63xx-hsspi: Make dummy cs workaround as an option
  spi: bcm63xx-hsspi: Add prepend feature support
  spi: bcm63xx-hsspi: Add clock gate disable option support
  spi: spi-mem: Allow controller supporting mem_ops without exec_op
  spi: bcm63xx-hsspi: prepend: Disable spi mem dual io read op support
  spi: bcmbca-hsspi: Add driver for newer HSSPI controller
  MAINTAINERS: Add entry for Broadcom Broadband SoC HS SPI drivers

 .../brcm,bcm63xx-hsspi-peripheral-props.yaml  |  27 +
 .../bindings/spi/brcm,bcm63xx-hsspi.yaml      | 124 ++++
 .../bindings/spi/spi-bcm63xx-hsspi.txt        |  33 -
 .../bindings/spi/spi-peripheral-props.yaml    |   1 +
 MAINTAINERS                                   |  12 +
 arch/arm/boot/dts/bcm47622.dtsi               |  17 +
 arch/arm/boot/dts/bcm63138.dtsi               |  17 +
 arch/arm/boot/dts/bcm63148.dtsi               |  17 +
 arch/arm/boot/dts/bcm63178.dtsi               |  18 +
 arch/arm/boot/dts/bcm6756.dtsi                |  18 +
 arch/arm/boot/dts/bcm6846.dtsi                |  17 +
 arch/arm/boot/dts/bcm6855.dtsi                |  18 +
 arch/arm/boot/dts/bcm6878.dtsi                |  18 +
 arch/arm/boot/dts/bcm947622.dts               |   4 +
 arch/arm/boot/dts/bcm963138.dts               |   4 +
 arch/arm/boot/dts/bcm963138dvt.dts            |   4 +
 arch/arm/boot/dts/bcm963148.dts               |   4 +
 arch/arm/boot/dts/bcm963178.dts               |   4 +
 arch/arm/boot/dts/bcm96756.dts                |   4 +
 arch/arm/boot/dts/bcm96846.dts                |   4 +
 arch/arm/boot/dts/bcm96855.dts                |   4 +
 arch/arm/boot/dts/bcm96878.dts                |   4 +
 .../boot/dts/broadcom/bcmbca/bcm4908.dtsi     |  17 +
 .../boot/dts/broadcom/bcmbca/bcm4912.dtsi     |  19 +
 .../boot/dts/broadcom/bcmbca/bcm63146.dtsi    |  18 +
 .../boot/dts/broadcom/bcmbca/bcm63158.dtsi    |  18 +
 .../boot/dts/broadcom/bcmbca/bcm6813.dtsi     |  19 +
 .../boot/dts/broadcom/bcmbca/bcm6856.dtsi     |  17 +
 .../boot/dts/broadcom/bcmbca/bcm6858.dtsi     |  17 +
 .../boot/dts/broadcom/bcmbca/bcm94908.dts     |   4 +
 .../boot/dts/broadcom/bcmbca/bcm94912.dts     |   4 +
 .../boot/dts/broadcom/bcmbca/bcm963146.dts    |   4 +
 .../boot/dts/broadcom/bcmbca/bcm963158.dts    |   4 +
 .../boot/dts/broadcom/bcmbca/bcm96813.dts     |   4 +
 .../boot/dts/broadcom/bcmbca/bcm96856.dts     |   4 +
 .../boot/dts/broadcom/bcmbca/bcm96858.dts     |   4 +
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-bcm63xx-hsspi.c               | 391 ++++++++++-
 drivers/spi/spi-bcmbca-hsspi.c                | 629 ++++++++++++++++++
 drivers/spi/spi-mem.c                         |   2 +-
 drivers/spi/spi.c                             |  13 +-
 42 files changed, 1498 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi-peripheral-props.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
 create mode 100644 drivers/spi/spi-bcmbca-hsspi.c

-- 
2.37.3

