Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA21674809
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 01:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjATAbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 19:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjATAbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 19:31:20 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903CEA314C;
        Thu, 19 Jan 2023 16:31:19 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30K0V3QS069171;
        Thu, 19 Jan 2023 18:31:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674174663;
        bh=QI3jGoiKu26FSZ/wdcz1oEu9cF+OA0pEXajTOAXlOro=;
        h=From:To:CC:Subject:Date;
        b=tYnwbXNp+Mea6QtnVNoOHtSf1NKrygtz3W0g225LoJ+d/tjWb6ahfvWbrgJs0WkHt
         tGZHfu2fy9RFR8BC7W1Bkacp1J7QNBSO69vpsWJlLLrNoUxslSAr/TdsFcc9lEFPBj
         Yt4TuPoxukG/IFJeR97hGPbbT7bjn+pfiP6IjY7Q=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30K0V3o3089208
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Jan 2023 18:31:03 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 19
 Jan 2023 18:31:02 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 19 Jan 2023 18:31:02 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30K0V2Qt021515;
        Thu, 19 Jan 2023 18:31:02 -0600
From:   Bryan Brattlof <bb@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keerthy <j-keerthy@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 0/6] add VTM nodes to TI's K3 SoCs
Date:   Thu, 19 Jan 2023 18:30:45 -0600
Message-ID: <20230120003051.9100-1-bb@ti.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2334; i=bb@ti.com; h=from:subject; bh=UAsq2vmkYfexlMtM7q09h820QahEgllfp8q6IGLvVh0=; b=owNCWmg5MUFZJlNZN+sw5wAAXv/////dzzVjX/f1zH7/27mTfemuZd9+++f3f/m42vf95/6wARtr YO1A0AGTQAAPU0BoAAGgBoAAANPU0ABtT1AAAGgAAA09Rp6ENpPU2mk3qiBoaNGmhpoMgDJhAAHqaD QNGEaaZNDEAADQGg9JoA0G1GmQZD1BhGmgNAMRoMUbU9TCDQ00BpoBpoAADIyBpoANABoAAG1MQAaa GgaBoNNHlNBoPUaNDTIaMEFrFKYVi5y1+G8pKJ3HLx9mIaJCDYHqluiu1APYDCooB0kCClN6Hwb54w cHNA52ABcKHUl/JNvsvSIu49tIV3cmEA4b65vZZxzbSqr2MIYTEA3IHfeJ8beIim46dT/CI8AkGN8B pb9LqVQ7nNnBUSpeqfTzSSdeZIZlYmzFGkU7kHEE+rlMPbb7qNwGtOzmlrdmLax0GhRA8SPgQhC04Q bC+gpFEp/oZl9k+ThdUqoiG1W8fjGeiJCzzpJkr6Q4T6jqudFbPFUJ9w/N/AhL1YDO4nEOQjYlf283 rsiAaKB1g3IiXNpDkQny88xFYi2t0vKll2ygFKH9mH2SkGNLSHb6TW1kbzGspYYEmOhWB8lWN4ZC20 +RDUuZ0BH1KFktyi9D93ZjaLDL3jJXy5UYcKDXAkYHlgFAW5xhgYoQVLqIUD/F3JFOFCQN+sw5wA==
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again everyone!

This patch series adds in basic VTM nodes for all of TI's K3 SoCs. As of
right now these do not do much other than add thermal entries into the
sysfs directory and power down the device once it's exceeded a critical
temperature.

Changes from v1:
- Fixed indexing of thermal nodes[0]

[0] https://lore.kernel.org/all/20230119221322.12563-1-bb@ti.com/

Thanks for reviewing!
~Bryan

Bryan Brattlof (6):
  arm64: dts: ti: k3-am64-main: add VTM node
  arm64: dts: ti: k3-am62-wakeup: add VTM node
  arm64: dts: ti: k3-j721e-mcu-wakeup: add VTM node
  arm64: dts: ti: k3-j721s2-mcu-wakeup: add VTM node
  arm64: dts: ti: k3-j7200-mcu-wakeup: add VTM node
  arm64: dts: ti: k3-am62a-wakeup: add VTM node

 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi   |  33 ++++++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi    |   8 ++
 arch/arm64/boot/dts/ti/k3-am62.dtsi           |   6 +-
 arch/arm64/boot/dts/ti/k3-am62a-thermal.dtsi  |  47 ++++++++
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi   |   8 ++
 arch/arm64/boot/dts/ti/k3-am62a.dtsi          |   2 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |   8 ++
 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi   |  33 ++++++
 arch/arm64/boot/dts/ti/k3-am64.dtsi           |   3 +
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |   8 ++
 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi  |  47 ++++++++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi          |   2 +
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |   9 ++
 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi  |  75 +++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |   2 +
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |   8 ++
 arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi | 103 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi         |   2 +
 18 files changed, 403 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi


base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.39.0

