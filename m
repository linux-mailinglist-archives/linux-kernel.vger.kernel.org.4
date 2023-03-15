Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069C26BA7BA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjCOGX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjCOGXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:23:25 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D16F30EA8;
        Tue, 14 Mar 2023 23:23:22 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32F6NCrl033939;
        Wed, 15 Mar 2023 01:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678861392;
        bh=aEgd9XPuLQCR59sQocm1j89Ty0kcJwLrMZIDQCf67fQ=;
        h=From:To:CC:Subject:Date;
        b=gykANu25PYJv0FTC/bkyN5pldAFBEJjn4+n9mO3DTk/loMbdJN5L0B0iOoN9sHp/9
         bTManLCL5sCdOg/17uwe4Oiin8l6q1HrH9M7L/4vpVTHZm/J5VNhXZkJxf+YmhMLKN
         0/jdFPBCpV64nTmdyrN8Gkuo1u+OGkuTTxBtyj28=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32F6NCnY104448
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Mar 2023 01:23:12 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 15
 Mar 2023 01:23:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 15 Mar 2023 01:23:11 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32F6N7br024744;
        Wed, 15 Mar 2023 01:23:08 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3 0/4] Add DT support for J721E CPSW9G and J7200 CPSW5G
Date:   Wed, 15 Mar 2023 11:53:03 +0530
Message-ID: <20230315062307.1612220-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds the device-tree nodes for the CPSW9G instance of CPSW
Ethernet Switch on TI's J721E SoC and the CPSW5G instance of CPSW
Ethernet Switch on TI's J7200 SoC. Additionally, overlays are also added
to individually enable CPSW9G on J721E SoC and CPSW5G on J7200 SoC in
QSGMII mode with the Add-On J7 QUAD Port Ethernet expansion QSGMII
daughtercard.

This series combines the v2 series for J721E CPSW9G at:
https://lore.kernel.org/r/20230310103504.731845-1-s-vadapalli@ti.com/
and the v1 series for J7200 CPSW5G at:
https://lore.kernel.org/r/20230310101407.722334-1-s-vadapalli@ti.com/

The suggestions for the v2 series for J721E are implemented for the J7200
series as well in this patch series.

---
Changes from v2 for J721E CPSW9G series:
1. Rename the overlay k3-j721e-quad-port-eth-exp.dtso as
   k3-j721e-evm-quad-port-eth-exp.dtso.
2. Update arch/arm64/boot/dts/ti/Makefile to build k3-j721e-evm.dtb as the
   result of applying k3-j721e-evm-quad-port-eth-exp.dtbo to
   k3-j721e-common-proc-board.dtb.
3. Use the newer "&{/} {" style instead of the "fragments" style in
   k3-j721e-evm-quad-port-eth-exp.dtso.
4. Move the "mdio0_pins_default" pinctrl from cpsw0 node into the
   "cpsw9g_mdio" node.
5. Disable individual "cpsw0_port" nodes in the main.dtsi file, enabling
   only the required nodes in the overlay.
6. Disable the "cpsw9g_mdio" node in the main.dtsi file.

Changes from v1 for J721E CPSW9G series:
1. Rename node name "mdio_pins_default" to "mdio0-pins-default", since
   node names shouldn't contain underscores.
2. Change node label "mdio_pins_default" to "mdio0_pins_default".

Changes from v1 for J7200 CPSW5G series:
1. Rename the overlay k3-j7200-quad-port-eth-exp.dtso as
   k3-j7200-evm-quad-port-eth-exp.dtso.
2. Update arch/arm64/boot/dts/ti/Makefile to build k3-j7200-evm.dtb as the
   result of applying k3-j7200-evm-quad-port-eth-exp.dtbo to
   k3-j7200-common-proc-board.dtb.
3. Use the newer "&{/} {" style instead of the "fragments" style in
   k3-j7200-evm-quad-port-eth-exp.dtso.
4. Move the "mdio0_pins_default" pinctrl from cpsw0 node into the
   "cpsw5g_mdio" node.
5. Disable individual "cpsw0_port" nodes in the main.dtsi file, enabling
   only the required nodes in the overlay.
6. Disable the "cpsw5g_mdio" node in the main.dtsi file.

J721E CPSW9G v2 series:
https://lore.kernel.org/r/20230310103504.731845-1-s-vadapalli@ti.com/
J721E CPSW9G v1 series:
https://lore.kernel.org/r/20230310092804.692303-1-s-vadapalli@ti.com/
J7200 CPSW5G v1 series:
https://lore.kernel.org/r/20230310101407.722334-1-s-vadapalli@ti.com/

Siddharth Vadapalli (4):
  arm64: dts: ti: k3-j721e: Add CPSW9G nodes
  arm64: dts: ti: k3-j721e: Add overlay to enable CPSW9G ports in QSGMII
    mode
  arm64: dts: ti: j7200-main: Add CPSW5G nodes
  arm64: dts: ti: k3-j7200: Add overlay to enable CPSW5G ports in QSGMII
    mode

 arch/arm64/boot/dts/ti/Makefile               |   6 +-
 .../ti/k3-j7200-evm-quad-port-eth-exp.dtso    | 100 +++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  88 ++++++++++++
 .../ti/k3-j721e-evm-quad-port-eth-exp.dtso    | 132 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 116 +++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |   1 +
 6 files changed, 441 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso

-- 
2.25.1

