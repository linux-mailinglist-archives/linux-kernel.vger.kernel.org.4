Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C9B5FBE3F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJKXST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiJKXSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:18:15 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51BF5F22F;
        Tue, 11 Oct 2022 16:18:11 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29BNHsbr005669;
        Tue, 11 Oct 2022 18:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665530274;
        bh=A8dS9/Ug1cxgweRrfQs+7nxXXnAB6NP6Uhn428JWf0U=;
        h=From:To:CC:Subject:Date;
        b=wPD1redbeblidZdiMkLeNBH5lqfxqwu9uBFfR2sQT4YQ8StA6hqv8xKY22HAMPBLq
         ZqXiVZGKfHq4zTXkwxE5Fv30qJqC72+RjrK0B++s4ddTstSt+s9FbGxB6j/L5wCRWP
         NKGMBYdHWHqt6CVBORgZXhaH+drqExcKqyxy8A/M=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29BNHsRo081639
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Oct 2022 18:17:54 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 11
 Oct 2022 18:17:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 11 Oct 2022 18:17:54 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29BNHslx058885;
        Tue, 11 Oct 2022 18:17:54 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Linux Thermal <linux-pm@vger.kernel.org>,
        Linux Device Tree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 00/11] enable VTM node of all TI's K3 SoCs
Date:   Tue, 11 Oct 2022 18:17:16 -0500
Message-ID: <20221011231727.8090-1-bb@ti.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2575; h=from:subject; bh=3qkE5Yuh4qE7h4E5kCAmjX6jv14KmSHohX8Sh9DTsNo=; b=owNCWmg5MUFZJlNZqREc9AAAZn////7v+3+v/tK7Jf/YWs3+uvf7f/Yu2/Z3f+tp73f+3/ewARrR SGQA0ABo0aA0Bo00aAZNABo0AaAADEAGhoBoDRoyaNDTIyaaGmmTamE0D0Ah2oaBk0GjJoDQGIaaaD Q00AANBpoBkyaaAMgBkMg0AaaMg00A00000aA0aA0NoiGh6mjQNNGQ00DQNBoyNDENDTI00BoAAaaA ABoyYEaYjQ0AAAGmRoDTTATQAAFy+U7xgUgEcGfTNUHIR4MtmY8AS7n8RAulfDdYLsCZSXaiwxm7L+ AIHbkFPJoupgngscwUoiTS9pRIieUMStdhOS7CNPXSDAMhTibYs/orsErOoLA/7hxCMEsc67k3f5uA iW1z7mBNjQ31WTd5y5Hr9Q5GeLYOK1XFuZL4HSEqixkNN+sErR2Y/DV+Zg88waTIc+sh0k4Xj2yLLV DXFogMCm/4FkzhvvBXFh/se10ZUiwTVVCkOq0F+oSjm2p2vtKPlTJBYNa5Ol6kXyWRKgFPmXPr2Si9 0yX0OzSgZuEZmAFIgWUlClyrccq1WsXxS0LM/0GLnmTGAXFjYkfonUBBkH/SbydKGdwazd20J0RgDI I0PHAM9UpKl8v8QRQW8bAOc1t/ViPm9w8wpP7lMNwXBfRYuIls5QswCCyqwIAI3rXBkQA3zhjj/F3J FOFCQqREc9A=
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everyone!

This series enables the VTM nodes for all of Texas Instruments K3 SoCs

Most of this series updates the k3_j72xx_bandgap driver to conditionally 
map an eFuse region used by the j721e to work around an issue in its VTM 
implementation and allows us to save the SPARE_FUSE region on other SoCs

We can then update the device tree bindings for the driver and finally 
define the VTM nodes for each device.

Thanks for reviewing!
~Bryan


Bryan Brattlof (11):
  thermal: k3_j72xx_bandgap: simplify k3_thermal_get_temp() function
  thermal: k3_j72xx_bandgap: use bool for i2128 erratum flag
  thermal: k3_j72xx_bandgap: remove fuse_base from structure
  thermal: k3_j72xx_bandgap: map fuse_base only for erratum workaround
  dt-bindings: thermal: k3-j72xx: elaborate on binding descriptions
  dt-bindings: thermal: k3-j72xx: conditionally require efuse reg range
  arm64: dts: ti: k3-am64-main: add VTM node
  arm64: dts: ti: k3-am62-wakeup: add VTM node
  arm64: dts: ti: k3-j721e-mcu-wakeup: add VTM node
  arm64: dts: ti: k3-j721s2-mcu-wakeup: add VTM node
  arm64: dts: ti: k3-j7200-mcu-wakeup: add VTM node

 .../bindings/thermal/ti,j72xx-thermal.yaml    |  51 ++++++++-
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
 drivers/thermal/k3_j72xx_bandgap.c            |  65 +++++------
 17 files changed, 430 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi

-- 
2.38.0

