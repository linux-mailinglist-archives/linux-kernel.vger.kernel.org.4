Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4BE60275C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiJRIoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiJRIn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:43:58 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B534C631;
        Tue, 18 Oct 2022 01:43:54 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29I8hbZ3040046;
        Tue, 18 Oct 2022 03:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666082617;
        bh=QmDZI3TBEjPeKNZilh+9aFh3Fur9k+LaiSQR5pUzem8=;
        h=From:To:CC:Subject:Date;
        b=r/9k2rtbuN3htvghYmuj8nXP4urgbY4jvhXNaktKO3OG21ova2uWLHMDeu1p9l8q4
         WrqcDMcJ8rEjsyv+KwhFpLm/3taZDC85pCpuieH/1kyKkq129mEYS9bmsqdhsrrXv6
         Y59TBDTEsfkIfiowWzpG6jBIFzrX0qzz/8gzBe7E=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29I8hbnf022532
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Oct 2022 03:43:37 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 18
 Oct 2022 03:43:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 18 Oct 2022 03:43:37 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29I8hXCP076871;
        Tue, 18 Oct 2022 03:43:34 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <robh+dt@kernel.org>, <lee@kernel.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@kernel.org>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>, <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <s-vadapalli@ti.com>
Subject: [PATCH v2 0/3] Add support to PHY GMII SEL for J721e CPSW9G QSGMII
Date:   Tue, 18 Oct 2022 14:13:30 +0530
Message-ID: <20221018084333.149790-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for J721e CPSW9G, which contains 8 external ports and 1
internal host port.

Update existing approach of using compatible to differentiate between
devices that support QSGMII mode and those that don't. The new
approach involves storing the number of qsgmii main ports for the device
in the num_qsgmii_main_ports member of the "struct phy_gmii_sel_soc_data".
This approach makes it scalable for newer devices.

=========
Changelog
=========
v1 -> v2:
1. Drop all patches corresponding to SGMII mode. This is done since I do
   not have a method to test SGMII in the standard mode which uses an
   SGMII PHY. The previous series used SGMII in a fixed-link mode,
   bypassing the SGMII PHY. I will post the SGMII patches in a future
   series after testing them.
2. Update description for the property "ti,qsgmii-main-ports", to describe
   it in a unified way across the compatibles.
3. Add minItems, maxItems, and items at the top, where the property
   "ti,qsgmii-main-ports" is first defined. Modify them later
   appropriately, based on the compatible.
4. Update the method to fetch the property "ti,qsgmii-main-ports" from the
   device-tree, to make it scalable.
5. Use dev_err() when the value(s) provided in the device-tree for the
   property "ti,qsgmii-main-ports" is/are invalid.

v1:
https://lore.kernel.org/r/20220914093911.187764-1-s-vadapalli@ti.com/

Siddharth Vadapalli (3):
  dt-bindings: phy: ti: phy-gmii-sel: Add bindings for J721e
  phy: ti: gmii-sel: Update methods for fetching and using qsgmii main
    port
  phy: ti: gmii-sel: Add support for CPSW9G GMII SEL in J721e

 .../bindings/phy/ti,phy-gmii-sel.yaml         | 48 +++++++++++++++----
 drivers/phy/ti/phy-gmii-sel.c                 | 42 +++++++++++++---
 2 files changed, 75 insertions(+), 15 deletions(-)

-- 
2.25.1

