Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE39962B63C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiKPJRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238581AbiKPJQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:16:56 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139F6DF12;
        Wed, 16 Nov 2022 01:16:53 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AG9GfGg024520;
        Wed, 16 Nov 2022 03:16:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668590201;
        bh=ICuUjo/GPVBR5jB6ykuDqxm43B+egfVXj21Q8bu9JD0=;
        h=From:To:CC:Subject:Date;
        b=x2wUmwc9PmN8pbvYxbBjR+TJuBOuf/BFUj/3UFq8VHAx3y6A3maYyPOP0zHLxDbyh
         ySWYiFWO93AzlLk6GRfAb9fx8aY7eQ9kR75XmEW/m0az9WUgTl1kplIPt78xAA41FU
         xYbKvloI6gfC6/Up4XeEN+jlxCkjRhp7tyk4ZGtA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AG9Gfww095560
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Nov 2022 03:16:41 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 16
 Nov 2022 03:16:41 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 16 Nov 2022 03:16:40 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AG9GeW5057725;
        Wed, 16 Nov 2022 03:16:40 -0600
From:   Bhavya Kapoor <b-kapoor@ti.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <piyali_g@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-j721e-main: Remove ti,strobe-sel property
Date:   Wed, 16 Nov 2022 14:46:52 +0530
Message-ID: <20221116091652.112620-1-b-kapoor@ti.com>
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
updated in commit eb8f6194e807 ("arm64: dts: ti: k3-j721e-main: Update the speed modes supported and their itap delay values for MMCSD subsystems")
but it missed dropping 'ti,strobe-sel' property which is
only required by HS400 speed mode.

Thus, drop 'ti,strobe-sel' property from kernel dtsi for J721e SoC.

[1] https://www.ti.com/lit/er/sprz455/sprz455.pdf

Fixes: eb8f6194e807 ("arm64: dts: ti: k3-j721e-main: Update the speed modes supported and their itap delay values for MMCSD subsystems")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---

Changelog v1 -> v2 :
	- Updated Commit Message based on what Nishanth Menon has told
		in https://lore.kernel.org/all/20221115034324.6qpxl2774bzwbl3t@acorn/

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

