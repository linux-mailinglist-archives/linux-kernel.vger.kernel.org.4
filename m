Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E689560179E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiJQT1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiJQT0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:26:20 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559CF47BBE;
        Mon, 17 Oct 2022 12:26:08 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPXpI121467;
        Mon, 17 Oct 2022 14:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666034733;
        bh=7jOUAMv92Rk7rkSCCELQ2bcifDnelzdjh7IDy43UWkc=;
        h=From:To:CC:Subject:Date;
        b=U7cc6Adj0DKGFQe8Fn+ej/0g/Ff5h1LnCUdPIy2ZvFfhcMSGAWIZMb0kq3vdYvYS5
         kW/UaAXLBDaosDfsSuzKHy8NwOMhRe+tchZvdO2fA2eqrkUcH5toUCcm76tqmbqbVV
         T5wtbTkcouuVw7+4NZmOzQJPDOtrl1Gu1kqNGX+s=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29HJPXaE026070
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Oct 2022 14:25:33 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 17
 Oct 2022 14:25:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 17 Oct 2022 14:25:33 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPWXH026106;
        Mon, 17 Oct 2022 14:25:32 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 00/10] AM64x Disable Incomplete DT Nodes
Date:   Mon, 17 Oct 2022 14:25:22 -0500
Message-ID: <20221017192532.23825-1-afd@ti.com>
X-Mailer: git-send-email 2.37.3
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

Hello all,

This series goes through the AM64x dtsi and disables the set of nodes
that are not functional without additional board level information.
This is usually pinmux data, but can also be inernal device resources.

Only when the node is completed in the board file should the node be
enabled. This helps prevents nodes that represent IP that are not
pinned-out on a given board from being left enabled.

This also reduces the effort needed to add a new board, one no longer
needs to manually disable all the extra IP. For instance TI J784s4 has
20(!) MCAN instances. It is much easier to enable the one you pin out,
vs disabling the 19 that you did not.

Thanks,
Andrew

Andrew Davis (10):
  arm64: dts: ti: k3-am64: Enable UART nodes at the board level
  arm64: dts: ti: k3-am64: Enable I2C nodes at the board level
  arm64: dts: ti: k3-am64: Enable SPI nodes at the board level
  arm64: dts: ti: k3-am64: Enable EPWM nodes at the board level
  arm64: dts: ti: k3-am64: Enable ECAP nodes at the board level
  arm64: dts: ti: k3-am64: Enable PCIe nodes at the board level
  arm64: dts: ti: k3-am64: MDIO pinmux should belong to the MDIO node
  arm64: dts: ti: k3-am64: Enable MDIO nodes at the board level
  arm64: dts: ti: k3-am64: Enable MCAN nodes at the board level
  arm64: dts: ti: k3-am64: Enable GPMC and ELM nodes at the board level

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi |  37 ++++++
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi  |   6 +
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 119 ++-----------------
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   | 142 ++---------------------
 4 files changed, 63 insertions(+), 241 deletions(-)

-- 
2.37.3

