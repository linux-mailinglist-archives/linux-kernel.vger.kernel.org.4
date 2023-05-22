Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B79C70B8D0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjEVJWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjEVJWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:22:23 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D0F186;
        Mon, 22 May 2023 02:22:17 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34M9M6E3128330;
        Mon, 22 May 2023 04:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684747326;
        bh=vb+PGl/QRLyo8vcf6KuerjP8yCt+PZJcwqLi0wzNstc=;
        h=From:To:CC:Subject:Date;
        b=Rw6f3I0GkfTE6m5hjSPxaHV7m+w82F078CdSNLh5m4vTkymJK1OqPI6kFtfUrayar
         stDHM1j5b0WVIZvqo08Mr9KRFJlWJ2gk7LVerUBJ7Qi8F2FwptCjryhIxNUKc225xY
         TjlAM17GAfiuVu6TxJ07eaoUuQd1xb6JJoZF7TpU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34M9M6aq091990
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 May 2023 04:22:06 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 May 2023 04:22:06 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 May 2023 04:22:06 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34M9M2e4127198;
        Mon, 22 May 2023 04:22:02 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 0/3] Add CPSW9G DT support for J784S4
Date:   Mon, 22 May 2023 14:51:58 +0530
Message-ID: <20230522092201.127598-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds device-tree nodes for CPSW9G instance of the CPSW
Ethernet Switch on TI's J784S4 SoC. Additionally, two device-tree
overlays are also added:
1. QSGMII mode with the CPSW9G instance via the ENET EXPANSION 1
   connector.
2. USXGMII mode with MAC Ports 1 and 2 of the CPSW9G instance via
   ENET EXPANSION 1 and 2 connectors, configured in fixed-link
   mode of operation at 5Gbps link speed.

This series is based on top of the following series:
https://lore.kernel.org/r/20230425131607.290707-1-j-choudhary@ti.com/

This series also depends on the patch for Serdes Mux Bindings at:
https://lore.kernel.org/r/20230310111630.743023-1-s-vadapalli@ti.com/
for patches 2/3 and 3/3 of this series.

Regards,
Siddharth.

---
RFC series:
https://lore.kernel.org/r/20230425133223.4060752-1-s-vadapalli@ti.com/

Changes since RFC series:
- Rebase on linux-next tagged: next-20230522

Siddharth Vadapalli (3):
  arm64: dts: ti: k3-j784s4-main: Add CPSW9G nodes
  arm64: dts: ti: k3-j784s4: Add overlay to enable QSGMII mode with
    CPSW9G
  arm64: dts: ti: k3-j784s4: Add overlay for dual port USXGMII mode

 arch/arm64/boot/dts/ti/Makefile               |   3 +
 .../ti/k3-j784s4-evm-quad-port-eth-exp1.dtso  | 144 ++++++++++++++++++
 .../ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso   |  72 +++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 114 ++++++++++++++
 4 files changed, 333 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso

-- 
2.25.1

