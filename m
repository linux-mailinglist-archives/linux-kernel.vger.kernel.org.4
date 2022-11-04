Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0183F619D98
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiKDQr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKDQrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:47:23 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9AB31EF9;
        Fri,  4 Nov 2022 09:47:21 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9AD7D40004;
        Fri,  4 Nov 2022 16:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667580440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JVHJnIjQenCiYS8Jaz1TWTuaFGmhqgjBAHy/v89XFgU=;
        b=K2G93D/O4SlzXAEdnU5HJuO8hHroT3mKZ+/QuoONqiZHPbDTUPPw++zybZ5t9Nnt0GgbMB
        FJmZ54iy9U4JTAOXHaBpooX/EiQZAnqKlma/QT205tNPQIV1DIZzT7LgFP2wY/uuxBn15p
        gxfiei9dorueyv7aAWJhggRZ296gogWkCUViRVTaNFihKYTdPouFmDj/4QkgHuRqh6ZsDK
        CqsJb//my5JrlU//iXgcvf7xH+sQ15YNrdzBrvggDAAzH+gz+YA9nZ+MuHhIEh9Hk0G1cG
        ++G7n5ksikEZ4YT87ES05ZuYwlt26NSdpHvYZlFU4OUP5tSa+MfZ4uAEM4d8Sw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 00/17] Improve MTD bindings
Date:   Fri,  4 Nov 2022 17:47:01 +0100
Message-Id: <20221104164718.1290859-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

During a yaml conversion review, Krzysztof opened the discussion about
the links and references made between the different files in the mtd
bindings. I figured out some minimal changes might be needed to properly
reference everything correctly and ensure we constrain as much as
possible the existing bindings. That is what I tried to do here.

The idea is:
* partition.yaml defines one MTD partition
* parsers/*.yaml define partition parsers (mainly compatibles)
* mtd.yaml contains the generic definition of any mtd device (nand,
  spi-nand, spi-nor, nor, sram, etc), in particular, it defines the
  various partition formats (legacy and current) and references
  partition.yaml as well as a list of all the possible parsers within a
  "partitions" node.
* nand-chip.yaml, jedec,spi-nor, mtd-physmap.yaml all describe real
  instances of mtd device, each of them with a different underlying
  technology, they reference mtd.yaml 
* nand-controller.yaml has subnodes which reference nand-chip.yaml.
* Specific NAND controller bindings reference nand-controller.yaml.

I've tested each and every patch with the following command and it
worked fine:
$ make dt_binding_check -j10 DT_CHECKER_FLAG=-m DT_SCHEMA_FILES=mtd/

Comments welcome of course :-)

Cheers,
Miquèl

Changes in v2:
* Fixed all the missing references to partitions.txt.
* Created a proper partitions.yaml file to cut the logic
* Constrained #{address,size}-cells to 1 or 2.
* Used the description advised by Rob to list all the possible partition
  parsers without having to actually duplicate the compatibles.
* Deprecated the #{address,size}-cells properties when relevant.
* Fixed a regex pattern to match all sram device node names (including
  ones defined under memory-controllers.
* Added a comment on another "additionalProperties: true" situation.
* Dropped even more duplicated properties.
* Fixed a few typos (like s/phymap/physmap/).
* Changed qcom,smem-part partition type.
* Standardized the style in the various examples.
* Improved the nvmem-cells file as well.
* Added an example to the sunxi-nand bindings.

Miquel Raynal (17):
  dt-bindings: mtd: Clarify all partition subnodes
  dt-bindings: mtd: Remove useless file about partitions
  dt-bindings: mtd: nand-chip: Reference mtd.yaml
  dt-bindings: mtd: nand: Drop common properties already defined in
    generic files
  dt-bindings: mtd: nand: Standardize the child node name
  dt-bindings: mtd: ingenic: Mark partitions in the controller node as
    deprecated
  dt-bindings: mtd: onenand: Mention the expected node name
  dt-bindings: mtd: sunxi-nand: Add an example to validate the bindings
  dt-bindings: mtd: spi-nor: Drop common properties
  dt-bindings: mtd: physmap: Reuse the generic definitions
  dt-bindings: mtd: partitions: Constrain the list of parsers
  dt-bindings: mtd: partitions: Change qcom,smem-part partition type
  dt-bindings: mtd: nvmem-cells: Fix example
  dt-bindings: mtd: nvmem-cells: Inherit from MTD partitions
  dt-bindings: mtd: Argue in favor of keeping additionalProperties set
    to true
  dt-bindings: mtd: Drop object types when referencing other files
  dt-bindings: mtd: Standardize the style in the examples

 .../mtd/allwinner,sun4i-a10-nand.yaml         |  34 +++--
 .../bindings/mtd/arasan,nand-controller.yaml  |   5 +-
 .../bindings/mtd/arm,pl353-nand-r2p1.yaml     |  30 ++---
 .../devicetree/bindings/mtd/atmel-nand.txt    |   6 +-
 .../bindings/mtd/brcm,brcmnand.yaml           |  80 ++++++------
 .../devicetree/bindings/mtd/denali,nand.yaml  |   2 +-
 .../devicetree/bindings/mtd/ingenic,nand.yaml | 116 ++++++++---------
 .../bindings/mtd/intel,lgm-ebunand.yaml       |  48 +++----
 .../bindings/mtd/jedec,spi-nor.yaml           |  14 ---
 .../devicetree/bindings/mtd/lpc32xx-mlc.txt   |   2 +-
 .../devicetree/bindings/mtd/lpc32xx-slc.txt   |   2 +-
 .../bindings/mtd/microchip,mchp48l640.yaml    |  14 +--
 .../devicetree/bindings/mtd/mtd-physmap.yaml  |   7 +-
 .../devicetree/bindings/mtd/mtd.yaml          |  24 +++-
 .../devicetree/bindings/mtd/mtk-nand.txt      |   2 +-
 .../devicetree/bindings/mtd/nand-chip.yaml    |   4 +
 .../bindings/mtd/nand-controller.yaml         |   2 +-
 .../devicetree/bindings/mtd/partition.txt     |  33 -----
 .../partitions/arm,arm-firmware-suite.yaml    |   2 +
 .../partitions/brcm,bcm4908-partitions.yaml   |   2 +
 .../brcm,bcm947xx-cfe-partitions.yaml         |   2 +
 .../mtd/partitions/linksys,ns-partitions.yaml |   2 +
 .../bindings/mtd/partitions/nvmem-cells.yaml  |   4 +-
 .../bindings/mtd/partitions/partition.yaml    |   1 +
 .../bindings/mtd/partitions/partitions.yaml   |  41 ++++++
 .../mtd/partitions/qcom,smem-part.yaml        |  32 ++---
 .../bindings/mtd/partitions/redboot-fis.yaml  |   6 +
 .../devicetree/bindings/mtd/qcom,nandc.yaml   | 117 +++++++++---------
 .../bindings/mtd/st,stm32-fmc2-nand.yaml      |  47 +++----
 .../bindings/mtd/ti,am654-hbmc.yaml           |  36 +++---
 .../bindings/mtd/ti,gpmc-onenand.yaml         |   3 +
 drivers/mtd/parsers/Kconfig                   |   2 +-
 32 files changed, 380 insertions(+), 342 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/partition.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partitions.yaml

-- 
2.34.1

