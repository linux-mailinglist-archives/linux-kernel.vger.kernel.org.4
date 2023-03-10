Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DD66B3C6F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjCJKg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCJKg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:36:27 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FFF22C81;
        Fri, 10 Mar 2023 02:36:05 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32AAZ8Da112563;
        Fri, 10 Mar 2023 04:35:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678444508;
        bh=D0330RTbUy7abXczlK7a38OBmVYfwKLOPLSgs9FRwnQ=;
        h=From:To:CC:Subject:Date;
        b=LTaETDYmpbXpl/oQ3MnxuF02I3bTfYl+V9VUedh51MMs5yKT6SpwC2ZGFZKBWJ01L
         //0yDYALG8kfnlpNJD7vtxstKHS878r7SnPLiwVFwC/UcAw+e4VCN3LiTSYnUUQNuE
         FPwldcXSxu7/YrOjFBDz/UAWUTb07+7PTh/Evjwo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32AAZ8qX055216
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Mar 2023 04:35:08 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 10
 Mar 2023 04:35:08 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 10 Mar 2023 04:35:08 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32AAZ4Pf088652;
        Fri, 10 Mar 2023 04:35:05 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2 0/2] Add device-tree support for CPSW9G on J721E SoC
Date:   Fri, 10 Mar 2023 16:05:02 +0530
Message-ID: <20230310103504.731845-1-s-vadapalli@ti.com>
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

This series adds the device-tree nodes for CPSW9G instance of CPSW
Ethernet Switch on TI's J721E SoC. Additionally, an overlay file is also
added to enable CPSW9G nodes in QSGMII mode with the Add-On J7 QUAD Port
Ethernet expansion QSGMII daughtercard.

---
Changes from v1:
1. Rename node name "mdio_pins_default" to "mdio0-pins-default", since
   node names shouldn't contain underscores.
2. Change node label "mdio_pins_default" to "mdio0_pins_default".

The reason for adding 0 after mdio with the above changes, is to indicate
the association of the cpsw0 instance of CPSW with this instance of MDIO.

v1:
https://lore.kernel.org/r/20230310092804.692303-1-s-vadapalli@ti.com

Siddharth Vadapalli (2):
  arm64: dts: ti: k3-j721e: Add CPSW9G nodes
  arm64: dts: ti: k3-j721e: Add overlay to enable CPSW9G ports in QSGMII
    mode

 arch/arm64/boot/dts/ti/Makefile               |   4 +
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 107 +++++++++++++
 .../dts/ti/k3-j721e-quad-port-eth-exp.dtso    | 148 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |   1 +
 4 files changed, 260 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-quad-port-eth-exp.dtso

-- 
2.25.1

