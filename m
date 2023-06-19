Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680BC73584F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjFSNRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjFSNQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:16:55 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BB810E4;
        Mon, 19 Jun 2023 06:16:37 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35JDGMDK068789;
        Mon, 19 Jun 2023 08:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687180582;
        bh=3Z2P91KL2E+qTXo1jtnMpvVUcnVeBnGAlUxA+ENl8Sc=;
        h=From:To:CC:Subject:Date;
        b=RGwgGSwy8nYNEqAHLpn9r50uLFEYvh2sVzCP+iLvJd5jt5iSR+R7dNgZoBPq+FS5G
         zlRt16qlS1cdNoSTLfc7vgJ4O4w4NeyZQTsNhOnFKKwYau4Hnoge93SqBPyhZvOEDh
         FGN+jyuTejfPUsLxFj1wlN8Nok1Vdo8hQ6EnCh7Y=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35JDGMxJ002521
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Jun 2023 08:16:22 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Jun 2023 08:16:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Jun 2023 08:16:22 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35JDGMtM048714;
        Mon, 19 Jun 2023 08:16:22 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH V2] arm64: dts: ti: k3-pinctrl: Introduce debounce select mux macros
Date:   Mon, 19 Jun 2023 08:16:20 -0500
Message-ID: <20230619131620.3286650-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the debounce select mux macros to allow folks to setup
debounce configuration for pins. Each configuration selected maps
to a specific timing register as documented in appropriate Technical
Reference Manual (example:[1]).

[1] AM625x TRM (section 6.1.2.2): https://www.ti.com/lit/pdf/spruiv7

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1:
- I have'nt picked up Krystoff's ack since the file modified is now different.
- Changes now applied to k3-pinctrl.h instead of the ABI header that is
  now set up to be deleted in v6.5-rc1.

V1: https://lore.kernel.org/linux-devicetree/20230308084309.396192-1-nm@ti.com/

 arch/arm64/boot/dts/ti/k3-pinctrl.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
index c97548a3f42d..6004e0967ec5 100644
--- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
+++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
@@ -11,6 +11,7 @@
 #define PULLUDEN_SHIFT		(16)
 #define PULLTYPESEL_SHIFT	(17)
 #define RXACTIVE_SHIFT		(18)
+#define DEBOUNCE_SHIFT		(11)
 
 #define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
 #define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
@@ -29,6 +30,14 @@
 #define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
 #define PIN_INPUT_PULLDOWN	(INPUT_EN | PULL_DOWN)
 
+#define PIN_DEBOUNCE_DISABLE	(0 << DEBOUNCE_SHIFT)
+#define PIN_DEBOUNCE_CONF1	(1 << DEBOUNCE_SHIFT)
+#define PIN_DEBOUNCE_CONF2	(2 << DEBOUNCE_SHIFT)
+#define PIN_DEBOUNCE_CONF3	(3 << DEBOUNCE_SHIFT)
+#define PIN_DEBOUNCE_CONF4	(4 << DEBOUNCE_SHIFT)
+#define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
+#define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
+
 #define AM62AX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
 #define AM62AX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
 
-- 
2.40.0

