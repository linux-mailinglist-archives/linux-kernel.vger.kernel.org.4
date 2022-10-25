Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3B260D477
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiJYTPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiJYTPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:15:31 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B4D7E018;
        Tue, 25 Oct 2022 12:15:30 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29PJFJmJ096764;
        Tue, 25 Oct 2022 14:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666725319;
        bh=hg7ZEAuCPP4IUgifrwlR+W9vs9ouPnFxVaoin0/vvoI=;
        h=From:To:CC:Subject:Date;
        b=fayku1QzORZvI9ZA2SE7XxcDxca9+uekQfEMVkXi8B+Z8RlGAZdiu11jve2WndgNN
         /iuak+LVphT55WHA1sfbA0ESLlEVHnFg/RSP0hShUwXiJ0Q68v4hTZcIUwlJkzDAYH
         837VYPKvPXex63y4RwDAvoQ1oCXxhx/ciECLdTjY=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29PJFJTm058276
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Oct 2022 14:15:19 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 25
 Oct 2022 14:15:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 25 Oct 2022 14:15:19 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29PJFJIm056990;
        Tue, 25 Oct 2022 14:15:19 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Keerthy <j-keerthy@ti.com>, Linux PM <linux-pm@vger.kernel.org>,
        Device Trees <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LKML ARM <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 00/11] enable VTM node for all TI's K3 SoCs
Date:   Tue, 25 Oct 2022 14:15:04 -0500
Message-ID: <20221025191515.9151-1-bb@ti.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3044; h=from:subject; bh=5IGQUfa5WkW1F5uf6fTrPTCINIM+ArcMQX8aqPbUe9o=; b=owNCWmg5MUFZJlNZ+HR/kwAAZX/////tiz3tz7fuw/v73Yc3Pua/+97D6v8/323vm9nN9/8wARms EPU0aAaAAaBo9QD0gANAaAA0ZADQABoABoAAPUaGmgAaGj1PKaBo9R5M1RBo0DQGgaaAMhoBpoDCaB pkyA0ABgjJpgAjEwgNDRo00GmjJo0BkyaBoADKaND1HqD1GagANNA0MgGjRoAaGjQBp6j1AAAPU9QM 1ABkGgDQAHlDT1ABpoGg2bWhJ6VwGBFtX4E4qDESVaJYfBUBmEsWCkPZfHYBrmywJY1KF4emrbxlyB l3NDOSRJ4Fs8DghfWkF1/yNVYgxRA/UhWAiy5B4qigGB/xR8aYzAAu2a7OnUR1BQzWx6aitikYlLmB abI7sjJsBun+jraQGHd55Z/89iWFBfHMl6hrDS0NeyU6I9IRqpn/dy55i+qeb47ysEK2Qk76876o71 zPKGS+FOmokcxBxLaDn1lYQj39E/ZVBte6Dn4dJ/EHoQ9wlamvfXKVn92KrUxJY42yp/k6vrPozAhg aiK2SHEpgrV4+TewhDjzjLj1cQuYvzIoLshFHBSrcQYqaB5nk7AmZIo0h3fKCFBj6K8LpQqnJeYdSl kxxiAJFxLFPYj48/81XqzZxwywYSEWdotABpQDTWKopYFJ5JBgcMIaDojf8XckU4UJD4dH+TA=
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again everyone!

This series enabled the VTM nodes for all of Texas Instruments K3 SoCs

Most of this series updates the k3_j72xx_bandgap driver to conditionally 
map an eFuse region used by the j721e to work around an issue in its VTM 
implementation and allows us to save the SPARE_FUSE region on other SoCs

We can then update the device tree bindings for the driver and finally 
define the VTM nodes for each device

Thanks for reviewing!
~Bryan

****

v1 -> v2 changes[0]:

- when removing 'fuse_base' from the 'k3_j72xx_bandgap' structure, I 
  forgot to pass 'fuse_base' to get_efuse_values() 

- removed the descriptions to the generic 'power-domains' property

- incorporated Krzysztof's suggestions to the binding description

- refactored binding to use allOf: if: {min,max}Items over what I was 
  doing :) Thanks Krzysztof

[0] https://lore.kernel.org/lkml/20221011231727.8090-1-bb@ti.com/

Bryan Brattlof (11):
  thermal: k3_j72xx_bandgap: simplify k3_thermal_get_temp() function
  thermal: k3_j72xx_bandgap: use bool for i2128 erratum flag
  thermal: k3_j72xx_bandgap: remove fuse_base from structure
  thermal: k3_j72xx_bandgap: map fuse_base only for erratum workaround
  dt-bindings: thermal: k3-j72xx: elaborate on binding description
  dt-bindings: thermal: k3-j72xx: conditionally require efuse reg range
  arm64: dts: ti: k3-am64-main: add VTM node
  arm64: dts: ti: k3-am62-wakeup: add VTM node
  arm64: dts: ti: k3-j721e-mcu-wakeup: add VTM node
  arm64: dts: ti: k3-j721s2-mcu-wakeup: add VTM node
  arm64: dts: ti: k3-j7200-mcu-wakeup: add VTM node

 .../bindings/thermal/ti,j72xx-thermal.yaml    |  35 +++++-
 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi   |  33 ++++++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi    |   8 ++
 arch/arm64/boot/dts/ti/k3-am62.dtsi           |   7 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |   8 ++
 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi   |  33 ++++++
 arch/arm64/boot/dts/ti/k3-am64.dtsi           |   4 +
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |   8 ++
 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi  |  47 ++++++++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi          |   3 +
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |   9 ++
 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi  |  75 +++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |   3 +
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |   8 ++
 arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi | 103 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi         |   3 +
 drivers/thermal/k3_j72xx_bandgap.c            |  67 ++++++------
 17 files changed, 420 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi

-- 
2.38.1

