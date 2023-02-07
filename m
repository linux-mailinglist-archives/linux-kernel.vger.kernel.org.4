Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2922768CFE6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjBGG7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjBGG7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:59:03 -0500
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA70523C47;
        Mon,  6 Feb 2023 22:58:59 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 3AB52C0000F1;
        Mon,  6 Feb 2023 22:58:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 3AB52C0000F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1675753139;
        bh=jE7c1dPLcvlI1LKoj2DHekUT3pKHSXYImFUa2hckSa0=;
        h=From:To:Cc:Subject:Date:From;
        b=nrw/0wudd5qdfefuOh86vIQTRAqLf2LVMPmRkKLo8tNxJVIjEPlZDM1sQkGS8m81r
         QZVJ7srzXNrOC9qZ1MfgDONPV5XJHV/y/nY3MjRR8VJ9TUKLWmccwFw56vvOHoBl+K
         CECv2r9VGjJFZo+ES+f7p5RqHLpF4nJAaQ4lkUkc=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 2F3C218041CAC6;
        Mon,  6 Feb 2023 22:58:59 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 4E4E0101B35; Mon,  6 Feb 2023 22:58:47 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, dregan@mail.com, f.fainelli@gmail.com,
        joel.peshkin@broadcom.com, jonas.gorski@gmail.com,
        tomer.yacoby@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/15] spi: bcm63xx-hsspi: driver and doc updates
Date:   Mon,  6 Feb 2023 22:58:11 -0800
Message-Id: <20230207065826.285013-1-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Changes in v3:
- Clean up spi-controller.yaml and update the example
- Drop the generic compatible string brcm,bcmbca-hsspi from the document 
  and dts files
- Port the cs_change and cs_off logic from SPI core 
  spi_transfer_one_message function to both controller drivers.
- Factor dummy cs workaround into a function, adjust the logic for
  different xfer modes and fine tune message level in bcm63xx-hsspi 
  controller driver
- Replace hard-coded opcode with SPINOR_OP definition
- Add a new patch to export export spi_transfer_cs_change_delay_exec 
  function in the spi core
- Add a new patch to include compatible string brcm,bcmbca-hsspi-v1.0 in 
  bcm63xx-hsspi controller driver
- Minor coding style fix in bcmbca-hsspi controller driver
- Add Acked-by and Reviewed-by tag

Changes in v2:
- Update the dts yaml document and all the related dtsi/dts accordingly
- Fix build error for Alpha platform
- Add a new patch for bcm63xx-hsspi driver to support the new compatible
string
- Make interrupt mode required but keep polling mode as default. Also
add a sysfs option wait_mode for run-time mode change
- Remove use_cs_workaround option and change the transfer logic to try
prepend mode first and if not prependable, switch to dummy cs mode with
clock limit at the 25MHz. Add driver sysfs node xfer_mode for run-time
configuration to dummy cs or prepend mode.
- Withdraw SPI device specific clock gate option patch for now

William Zhang (15):
  dt-bindings: spi: Convert bcm63xx-hsspi bindings to json-schema
  dt-bindings: spi: Add bcmbca-hsspi controller support
  ARM: dts: broadcom: bcmbca: Add spi controller node
  arm64: dts: broadcom: bcmbca: Add spi controller node
  spi: bcm63xx-hsspi: Add new compatible string support
  spi: bcm63xx-hsspi: Endianness fix for ARM based SoC
  spi: bcm63xx-hsspi: Add polling mode support
  spi: export spi_transfer_cs_change_delay_exec function
  spi: bcm63xx-hsspi: Handle cs_change correctly
  spi: bcm63xx-hsspi: Fix multi-bit mode setting
  spi: bcm63xx-hsspi: Add prepend mode support
  spi: spi-mem: Allow controller supporting mem_ops without exec_op
  spi: bcm63xx-hsspi: Disable spi mem dual io read op support
  spi: bcmbca-hsspi: Add driver for newer HSSPI controller
  MAINTAINERS: Add entry for Broadcom Broadband SoC HS SPI drivers

 .../bindings/spi/brcm,bcm63xx-hsspi.yaml      | 134 ++++
 .../bindings/spi/spi-bcm63xx-hsspi.txt        |  33 -
 MAINTAINERS                                   |  12 +
 arch/arm/boot/dts/bcm47622.dtsi               |  18 +
 arch/arm/boot/dts/bcm63138.dtsi               |  18 +
 arch/arm/boot/dts/bcm63148.dtsi               |  18 +
 arch/arm/boot/dts/bcm63178.dtsi               |  19 +
 arch/arm/boot/dts/bcm6756.dtsi                |  19 +
 arch/arm/boot/dts/bcm6846.dtsi                |  18 +
 arch/arm/boot/dts/bcm6855.dtsi                |  19 +
 arch/arm/boot/dts/bcm6878.dtsi                |  19 +
 arch/arm/boot/dts/bcm947622.dts               |   4 +
 arch/arm/boot/dts/bcm963138.dts               |   4 +
 arch/arm/boot/dts/bcm963138dvt.dts            |   4 +
 arch/arm/boot/dts/bcm963148.dts               |   4 +
 arch/arm/boot/dts/bcm963178.dts               |   4 +
 arch/arm/boot/dts/bcm96756.dts                |   4 +
 arch/arm/boot/dts/bcm96846.dts                |   4 +
 arch/arm/boot/dts/bcm96855.dts                |   4 +
 arch/arm/boot/dts/bcm96878.dts                |   4 +
 .../boot/dts/broadcom/bcmbca/bcm4908.dtsi     |  18 +
 .../boot/dts/broadcom/bcmbca/bcm4912.dtsi     |  20 +
 .../boot/dts/broadcom/bcmbca/bcm63146.dtsi    |  19 +
 .../boot/dts/broadcom/bcmbca/bcm63158.dtsi    |  19 +
 .../boot/dts/broadcom/bcmbca/bcm6813.dtsi     |  20 +
 .../boot/dts/broadcom/bcmbca/bcm6856.dtsi     |  18 +
 .../boot/dts/broadcom/bcmbca/bcm6858.dtsi     |  18 +
 .../boot/dts/broadcom/bcmbca/bcm94908.dts     |   4 +
 .../boot/dts/broadcom/bcmbca/bcm94912.dts     |   4 +
 .../boot/dts/broadcom/bcmbca/bcm963146.dts    |   4 +
 .../boot/dts/broadcom/bcmbca/bcm963158.dts    |   4 +
 .../boot/dts/broadcom/bcmbca/bcm96813.dts     |   4 +
 .../boot/dts/broadcom/bcmbca/bcm96856.dts     |   4 +
 .../boot/dts/broadcom/bcmbca/bcm96858.dts     |   4 +
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-bcm63xx-hsspi.c               | 488 ++++++++++++-
 drivers/spi/spi-bcmbca-hsspi.c                | 651 ++++++++++++++++++
 drivers/spi/spi-mem.c                         |   2 +-
 drivers/spi/spi.c                             |  20 +-
 include/linux/spi/spi.h                       |   5 +-
 41 files changed, 1620 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
 create mode 100644 drivers/spi/spi-bcmbca-hsspi.c

-- 
2.37.3

