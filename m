Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463A361F1BE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiKGLW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiKGLWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:22:53 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49D3192BE;
        Mon,  7 Nov 2022 03:22:52 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A7BMkFw020072;
        Mon, 7 Nov 2022 05:22:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667820166;
        bh=YBd8AEWY8tSN4C006kwwfXguJrkOGDAiu3t3jsuQKf4=;
        h=From:To:CC:Subject:Date;
        b=RmFqbC6k6IEgTpg098QZJ2J15W2ycci310lvjLLhDlrp7L3/mP7c4w24rvoQXdE9W
         g2hYAN0lsp9JzsrHQWIQ8DswFzj6v9E/X8k7dN6rmn7PmJBMuyBU8KjiGzZa1DuzlS
         fZLsTf4+NLunDRgmCc+/IUaGQNlAIXbBkx3Ci99o=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A7BMk7s103394
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Nov 2022 05:22:46 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 7 Nov
 2022 05:22:45 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 7 Nov 2022 05:22:45 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A7BMiJU032407;
        Mon, 7 Nov 2022 05:22:45 -0600
From:   Bhavya Kapoor <b-kapoor@ti.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <piyali_g@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j721e-main: Remove ti,strobe-sel property
Date:   Mon, 7 Nov 2022 16:52:46 +0530
Message-ID: <20221107112246.69242-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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

According to latest errata of J721e [1], HS400 mode is not supported
in MMCSD0 subsystem (i2024) .  Speed modes supported has been already
updated in PATCH eb8f6194e807. 'ti,strobe-sel' property is only
required by HS400 speed mode and thus needs to be removed from kernel
dtsi for J721e soc.

'ti,strobe-sel' is read in sdhci_am654.c line 733 and gets stored in
sdhci_am654->strb_sel. This sdhci_am654->strb_sel is used at only one
place in sdhci_am654.c line 291 which will only get used if HS400
is enabled.

Thus, drop 'ti,strobe-sel' property from kernel dtsi for J721e soc.

[.] https://www.ti.com/lit/er/sprz455/sprz455.pdf

Fixes: eb8f6194e807 ("arm64: dts: ti: k3-j721e-main: Update the speed modes supported and their itap delay values for MMCSD subsystems")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 917c9dc99efa..e4748a838d83 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1094,7 +1094,6 @@
 		ti,itap-del-sel-mmc-hs = <0xa>;
 		ti,itap-del-sel-ddr52 = <0x3>;
 		ti,trm-icp = <0x8>;
-		ti,strobe-sel = <0x77>;
 		dma-coherent;
 	};
 
-- 
2.20.1

