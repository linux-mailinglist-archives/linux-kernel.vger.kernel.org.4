Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C1C6B01CF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCHInn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCHIni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:43:38 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02015CC06;
        Wed,  8 Mar 2023 00:43:34 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3288hM9o043151;
        Wed, 8 Mar 2023 02:43:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678265002;
        bh=S07v7k5mCnE4jl7fW0F3g0GwSSRhhAnlA8v1QkX1zOE=;
        h=From:To:CC:Subject:Date;
        b=UZwRXR74f9mPJ9JtahS+iOPmnLDtcBNJjul2mWsIhMHr0dkp2/5aLgpTq6/y6ldOA
         zVx1EhHpOC2xP2OjopGgKbBTSYdlkYuTUY2Jf5ooRJw9mFKua8vVzhYkt/ySuV95Rh
         JDqTaCQzK8xNc5eCJqvGoRjVb3ptPBa2gpbVZBTg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3288hMsd017502
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Mar 2023 02:43:22 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 8
 Mar 2023 02:43:21 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 8 Mar 2023 02:43:21 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3288hLem092779;
        Wed, 8 Mar 2023 02:43:21 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH] dt-bindings: pinctrl: k3: Introduce debounce select mux macros
Date:   Wed, 8 Mar 2023 02:43:09 -0600
Message-ID: <20230308084309.396192-1-nm@ti.com>
X-Mailer: git-send-email 2.31.1
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

Introduce the debounce select mux macros to allow folks to setup
debounce configuration for pins. Each configuration selected maps
to a specific timing register as documented in appropriate Technical
Reference Manual (example:[1]).

[1] AM625x TRM (section 6.1.2.2): https://www.ti.com/lit/pdf/spruiv7
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 include/dt-bindings/pinctrl/k3.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/dt-bindings/pinctrl/k3.h b/include/dt-bindings/pinctrl/k3.h
index 6bb9df1a264d..469bd29651db 100644
--- a/include/dt-bindings/pinctrl/k3.h
+++ b/include/dt-bindings/pinctrl/k3.h
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
2.31.1

