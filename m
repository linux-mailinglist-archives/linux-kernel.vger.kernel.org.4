Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C436271F25D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjFAStr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjFAStp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:49:45 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FE9184;
        Thu,  1 Jun 2023 11:49:45 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 351InaYB107569;
        Thu, 1 Jun 2023 13:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685645376;
        bh=H4gTEVA2dIW7ap2i7wvkZjECbengmZntBXhdaY4IHd0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ps5kBof5K3BRXD3nyx49L+O+O9qxcARpB5C2KYjv0M+9W3J0l8HgaTZk9C2yh4S6T
         xmAJ40COaJSWFlKg7lR6FcAfsmBjSZaG6uVV8C38KM4xH7H01fWdTcMM4PYNwQfHvc
         I5o96MxEMWAPefqpxPygYt8l3i9O8ggtsCvzN3zA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 351InasH031966
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Jun 2023 13:49:36 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Jun 2023 13:49:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Jun 2023 13:49:36 -0500
Received: from fllv0040.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 351InYGl073938;
        Thu, 1 Jun 2023 13:49:35 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Wadim Egorov <w.egorov@phytec.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am64: Use phandle to stdout UART node
Date:   Thu, 1 Jun 2023 13:49:33 -0500
Message-ID: <20230601184933.358731-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601184933.358731-1-afd@ti.com>
References: <20230601184933.358731-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a phandle makes it clear which UART we are choosing without needing
to resolve through an alias first.

Especially useful for boards like the TI J721s2-EVM where the alias is
"serial2" but it actually resolves to the 8th UART instance(main_uart8).

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 2 +-
 arch/arm64/boot/dts/ti/k3-am642-sk.dts  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 2b7373207cb71..2760e2b5d6481 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -17,7 +17,7 @@ / {
 	model = "Texas Instruments AM642 EVM";
 
 	chosen {
-		stdout-path = "serial2:115200n8";
+		stdout-path = &main_uart0;
 	};
 
 	aliases {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index cab5fe9e7a784..7e67dcf66539e 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -17,7 +17,7 @@ / {
 	model = "Texas Instruments AM642 SK";
 
 	chosen {
-		stdout-path = "serial2:115200n8";
+		stdout-path = &main_uart0;
 	};
 
 	aliases {
-- 
2.39.2

