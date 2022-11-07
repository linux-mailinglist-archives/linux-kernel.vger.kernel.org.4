Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F0D61F16E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiKGLGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiKGLGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:06:24 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C361839E;
        Mon,  7 Nov 2022 03:06:24 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A7B6CaF086278;
        Mon, 7 Nov 2022 05:06:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667819172;
        bh=H0pLK0kuUXANWglZ2uyviTK3U39iFowcYnUWSPOYs9A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Khq0HMg8mCrvnZCl8xzVNKMxv8yoJpRS4cxgcVk9aH1Lq+TjiDzAPYXd9wj+27JGe
         cs3onm8Q3TsVEXkbpAUw4+p1EcjBT4TT5l/pkyUVN0t3Y+n2qnDSlY3gDfEtIaqxMH
         fmujuVkDqf7Xw8pDNxp4lytwjgn6HA9gBFgryLFo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A7B6CKL095538
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Nov 2022 05:06:12 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 7 Nov
 2022 05:06:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 7 Nov 2022 05:06:11 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A7B6BIR007371;
        Mon, 7 Nov 2022 05:06:11 -0600
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>, <afd@ti.com>,
        <j-keerthy@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-anna@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH v2 2/3] arm64: dts: ti: k3-j721e-main: drop RNG clock
Date:   Mon, 7 Nov 2022 16:36:06 +0530
Message-ID: <20221107110607.59216-3-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107110607.59216-1-j-choudhary@ti.com>
References: <20221107110607.59216-1-j-choudhary@ti.com>
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

The x1-clk used by trng submodule comes directly from the system clock
after a fixed divider. It is always running and has a fixed frequency
that cannot be changed, making it uncontrollable. Hence this property
should be dropped from the rng node.

Fixes: 8ebcaaae8017 ("arm64: dts: ti: k3-j721e-main: Add crypto accelerator node")
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 5c4a0e28cde5..f1403b79e7f5 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -355,7 +355,6 @@ rng: rng@4e10000 {
 			compatible = "inside-secure,safexcel-eip76";
 			reg = <0x0 0x4e10000 0x0 0x7d>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&k3_clks 264 2>;
 		};
 	};
 
-- 
2.25.1

