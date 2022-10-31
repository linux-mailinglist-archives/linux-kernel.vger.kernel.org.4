Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545C76141BB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJaX1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaX13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:27:29 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DED1116F;
        Mon, 31 Oct 2022 16:27:26 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRG2B106682;
        Mon, 31 Oct 2022 18:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667258836;
        bh=jHI/aUgR1+2a2pnP1o8nAy+4Uo7MUyI0XA794KwZzDc=;
        h=From:To:CC:Subject:Date;
        b=aUCQeAJ6u73EtsHbgbsl8EYEJw2zIZiDVCQb0h9/C6UgIld3qxVOfamNW/chbnBN3
         Z0UvlsG84Mw2d5IawyIgKhE+oIIKOnU/iPLpypk9IhnY/T9Gb3SNqkUtijlU2Uq5f2
         dKKLhRh4/Ui97Vw9vs7uv4UHO4mehBxT+FXCY70c=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VNRGBR022956
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 18:27:16 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 18:27:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 18:27:15 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRFrc080580;
        Mon, 31 Oct 2022 18:27:15 -0500
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
Subject: [PATCH v3 00/11] enable VTM node for all TI's K3 SoCs
Date:   Mon, 31 Oct 2022 18:26:51 -0500
Message-ID: <20221031232702.10339-1-bb@ti.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3235; h=from:subject; bh=t48eTWhyQ1Ndm6/aGrh+jMu8C0oPX2tNXAsQQAQZpko=; b=owNCWmg5MUFZJlNZAFsGLgAAZP///n9/N7Wj/87+x34jWn7X6X+63H3s//vvxVvZ+dT7+9ywARmy iHqABo9QA0AGnqANAANAAANqAD1GgDQAAGjRoDRp+qaHqNNHqNAA02pvSYoZBGmgaGgGQaMmmnqNBo yA09Q0GmhkyBoABkBkMgAB6mQ00aZNDEaGhpo0yek0YhoyMRo2oyaMEA0ZDIyAxABoNAxHqBkDJkNB oGENAZAPRBo0DTBGI0yAAgRxCziCNE5BK6EgNv4DjHrKKcFK/aOIARBnc7w3M+FysEnvz8xDo5RE+D Amfc3VYerIQSIVX97CQ7I/U8D3aziK0unGjzVmdC08LRpQjh4ijWReyP+deGC4/VZNIrbhB8fVdGWB DJ38Fql2A83KTs0YK5NvWAS98JagKqyN++AAzolE5R58ArLO+nvIVrwEHoQ3YtamA6qLadYgstRgTt j7GlcU/3+lcbuukjAmyxK33Y7jA6JGQbSxoqyk/gUU4wLb4rAEy84Kjje1FoZajnxg7zgJ39BZF6lc 2S5aODhHFXr+S/i/zvf0an3QYVWAfpp56CIrEEoElzuE3oUSlRrCS0mPf5D4Vi+o8Vjf4bx3bs2hz6 MyqbGvOEVs2w8y7VpTeK8TBekQcw2rG7qxGY8qfqzLoFIDek48sIhCQ8/rVef+LuSKcKEgALYMXA==
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again everyone!

This series enables the VTM nodes for all of Texas Instrument's K3 SoCs

Most of this series updates the k3_j72xx_bandgap driver to conditionally 
map an eFuse region used by the j721e to work around an issue in its VTM 
implementation and allows us to save the SPARE_FUSE region on other SoCs

We can then update the device tree bindings for the driver and finally 
define the VTM nodes for each device

Thanks for reviewing again
~Bryan

****

v2 -> v3 changes[0]:

- removed a errant devm_iounmap() I introduced between patches in v2

- collected tags

v1 -> v2 changes[1]:

- when removing 'fuse_base' from the 'k3_j72xx_bandgap' structure, I 
  forgot to pass 'fuse_base' to get_efuse_values() 

- removed the descriptions to the generic 'power-domains' property

- incorporated Krzysztof's suggestions to the binding description

- refactored binding to use allOf: if: {min,max}Items over what I was 
  doing :) Thanks Krzysztof


[0] https://lore.kernel.org/lkml/20221025191515.9151-1-bb@ti.com/
[1] https://lore.kernel.org/lkml/20221011231727.8090-1-bb@ti.com/

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

