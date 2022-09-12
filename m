Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1E45B56D5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiILI5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiILI5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:57:24 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A85192BB;
        Mon, 12 Sep 2022 01:57:23 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28C8utVu009416;
        Mon, 12 Sep 2022 03:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662973015;
        bh=sRvNlBh/Ss9x2rZ28t0BBU8aqg7AeYRUVbKpiLO9SGY=;
        h=From:To:CC:Subject:Date;
        b=oEOhWi7mwHVhN5SzOVGqyKqfb4/6G7BggJGPNeb2MXz/WaLD74CgkPCzPrjmSCMZF
         LEACfUC03ZwiLK0xP1ppai7mVglbyRdjN0AZLCeLw8ukqOdwyndQJMEdPlEVESLhoJ
         9IwJgeRdT+FZO8s2zE6xDy+S/l1jZ3WkDmftWwPE=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28C8utm7015771
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Sep 2022 03:56:55 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 12
 Sep 2022 03:56:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 12 Sep 2022 03:56:55 -0500
Received: from uda0492258.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28C8up6u104303;
        Mon, 12 Sep 2022 03:56:51 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <s-vadapalli@ti.com>
Subject: [PATCH v5 0/3] Add support for QSGMII mode
Date:   Mon, 12 Sep 2022 14:26:47 +0530
Message-ID: <20220912085650.83263-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for J7200 CPSW5G.

Add support for QSGMII mode in phy-gmii-sel driver for CPSW5G in J7200.

Change log:

v4 -> v5:
1. Undo cleanup changes in the example in:
   Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml, moving it
   to a separate patch in the same series. The cleanup patch is the first
   patch in this series, with the other patches from previous versions
   following it in the same order.
2. Update $ref to "/schemas/phy/ti,phy-gmii-sel.yaml#" in:
   Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml.
3. Update description for the "phy@[0-9a-f]+$" pattern property.
4. Add blank lines in between IF/THEN statements in:
   Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml.
5. Update the IF/THEN statement corresponding to the property
   "ti,qsgmii-main-ports", disallowing the property for all compatibles
   except "ti,j7200-cpsw5g-phy-gmii-sel" in:
   Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml.
6. Move "maxItems: 1" to the top where "ti,qsgmii-main-ports" property is
   first defined, in:
   Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml.

v3 -> v4:
1. Update $ref to /schemas/phy/phy-provider.yaml in
   Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml.
2. Update commit message for the "phy: ti: gmii-sel: Add support for
   CPSW5G GMII SEL in J7200" patch, describing the reason for defining the
   property "ti,qsgmii-main-ports" as an array.
3. Add a check in drivers/phy/ti/phy-gmii-sel.c to ensure that the value
   of the variable "main_ports" is within bounds. If the property
   "ti,qsgmii-main-ports" is either not mentioned in the devicetree or the
   value of the property is out of bounds, in both these cases,
   "main_ports" defaults to 1.
4. Use the function "of_property_read_u32()" instead of the function
   "of_property_read_u32_array()" in drivers/phy/ti/phy-gmii-sel.c.

v2 -> v3:
1. Add $ref to "phy@[0-9a-f]+$" pattern property in
   Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml.
2. Restrict the optional ti,qsgmii-main-ports property to
   ti,j7200-cpsw5g-phy-gmii-sel property by adding an else statement and
   disallowing it for other compatibles.
3. Move the "items" constraint for the ti,qsgmii-main-ports property to
   the place the property is defined.

v1 -> v2:
1. Rename ti,enet-ctrl-qsgmii as ti,qsgmii-main-ports.
2. Change ti,qsgmii-main-ports property from bitmask to integer.
3. Update commit message with property name as ti,qsgmii-main-ports.

v4: https://lore.kernel.org/r/20220901085506.138633-1-s-vadapalli@ti.com/
v3: https://lore.kernel.org/r/20220822065631.27933-1-s-vadapalli@ti.com/
v2: https://lore.kernel.org/r/20220816055848.111482-1-s-vadapalli@ti.com/
v1: https://lore.kernel.org/r/20220531111221.22963-1-s-vadapalli@ti.com/

Siddharth Vadapalli (3):
  dt-bindings: phy: ti: phy-gmii-sel: Cleanup example
  dt-bindings: phy: ti: phy-gmii-sel: Add bindings for J7200
  phy: ti: gmii-sel: Add support for CPSW5G GMII SEL in J7200

 .../mfd/ti,j721e-system-controller.yaml       |  6 +++
 .../bindings/phy/ti,phy-gmii-sel.yaml         | 27 ++++++++++-
 drivers/phy/ti/phy-gmii-sel.c                 | 47 +++++++++++++++++--
 3 files changed, 76 insertions(+), 4 deletions(-)

-- 
2.25.1

