Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E6671F0EC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjFARiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjFARit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:38:49 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B34C136;
        Thu,  1 Jun 2023 10:38:48 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 351HcZSl080117;
        Thu, 1 Jun 2023 12:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685641115;
        bh=eTqaoWdBnubYt8g2HfY5tipV6+UjftnHfJskSCfl15g=;
        h=From:To:CC:Subject:Date;
        b=GkeyLZ1jepVLvzXjeN5yswtJwkHfufw6//9Fb2DWbdw2S+7d2Yz+aE4XvKiTLpxTF
         C7r+OqbCuLayey2j+vepWmhpY1HYWhhdVvMYlrBnkyMAue8LlGKhbxfhoTvHBtKD7a
         L+NG1BHKwWcSqE17i+uF2K/ebv4Hur7v5sp/BBqI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 351HcZf9007663
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Jun 2023 12:38:35 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Jun 2023 12:38:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Jun 2023 12:38:35 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 351HcYIP016395;
        Thu, 1 Jun 2023 12:38:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: pinctrl: Drop k3
Date:   Thu, 1 Jun 2023 12:38:31 -0500
Message-ID: <20230601173831.982429-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
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

For convenience (less code duplication), the pin controller pin
configuration register values were defined in the bindings header.
These are not some IDs or other abstraction layer but raw numbers used
in the registers.

These constants do not fit the purpose of bindings. They do not
provide any abstraction, any hardware and driver independent ID. In
fact, the Linux pinctrl-single driver actually do not use the bindings
header at all.

Commit f2de003e1426 ("dt-bindings: pinctrl: k3: Deprecate header with
register constants") already moved users to the local header, so, drop
the binding header. See background discussion in [1].

While at it, clean up the MAINTAINERS file which is the only reference
left.

[1]: https://lore.kernel.org/linux-arm-kernel/71c7feff-4189-f12f-7353-bce41a61119d@linaro.org/
Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Linus,

If you could pick this up for the next 6.5 kernel window now that we have kept the
old header around for one cycle.

Ref: https://lore.kernel.org/linux-arm-kernel/20230313160019.vask6atfs6qwphml@twerp/

 MAINTAINERS                      |  1 -
 include/dt-bindings/pinctrl/k3.h | 60 --------------------------------
 2 files changed, 61 deletions(-)
 delete mode 100644 include/dt-bindings/pinctrl/k3.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 16ee982ce8cf..d25a463fd6a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2948,7 +2948,6 @@ F:	Documentation/devicetree/bindings/arm/ti/k3.yaml
 F:	Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
 F:	arch/arm64/boot/dts/ti/Makefile
 F:	arch/arm64/boot/dts/ti/k3-*
-F:	include/dt-bindings/pinctrl/k3.h
 
 ARM/TOSHIBA VISCONTI ARCHITECTURE
 M:	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
diff --git a/include/dt-bindings/pinctrl/k3.h b/include/dt-bindings/pinctrl/k3.h
deleted file mode 100644
index b5aca149664e..000000000000
--- a/include/dt-bindings/pinctrl/k3.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This header provides constants for pinctrl bindings for TI's K3 SoC
- * family.
- *
- * Copyright (C) 2018-2021 Texas Instruments Incorporated - https://www.ti.com/
- */
-#ifndef _DT_BINDINGS_PINCTRL_TI_K3_H
-#define _DT_BINDINGS_PINCTRL_TI_K3_H
-
-/*
- * These bindings are deprecated, because they do not match the actual
- * concept of bindings but rather contain pure register values.
- * Instead include the header in the DTS source directory.
- */
-#warning "These bindings are deprecated. Instead, use the header in the DTS source directory."
-
-#define PULLUDEN_SHIFT		(16)
-#define PULLTYPESEL_SHIFT	(17)
-#define RXACTIVE_SHIFT		(18)
-
-#define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
-#define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
-
-#define PULL_UP			(1 << PULLTYPESEL_SHIFT | PULL_ENABLE)
-#define PULL_DOWN		(0 << PULLTYPESEL_SHIFT | PULL_ENABLE)
-
-#define INPUT_EN		(1 << RXACTIVE_SHIFT)
-#define INPUT_DISABLE		(0 << RXACTIVE_SHIFT)
-
-/* Only these macros are expected be used directly in device tree files */
-#define PIN_OUTPUT		(INPUT_DISABLE | PULL_DISABLE)
-#define PIN_OUTPUT_PULLUP	(INPUT_DISABLE | PULL_UP)
-#define PIN_OUTPUT_PULLDOWN	(INPUT_DISABLE | PULL_DOWN)
-#define PIN_INPUT		(INPUT_EN | PULL_DISABLE)
-#define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
-#define PIN_INPUT_PULLDOWN	(INPUT_EN | PULL_DOWN)
-
-#define AM62AX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define AM62AX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#define AM62X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define AM62X_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#define AM64X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define AM64X_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#define AM65X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define AM65X_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#define J721E_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define J721E_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#define J721S2_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define J721S2_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#define J784S4_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define J784S4_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#endif
-- 
2.40.0

