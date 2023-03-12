Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F356B6AF7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjCLUNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjCLUNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:13:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD402007C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:13:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g10so11930718eda.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678652017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QdINFsAdIdQMFx1lXaWVNqaG+TfLU8IkxosIQvOMIK8=;
        b=CermYgm6+ZY4+YXa2Tm3qKTGPJOWwBgCJGRNuCuxodbfwm3uUVgimy4RjAWp1yhFzB
         Q9qHQoiCoZ45Yd1u4VWq9Byc6vo8JYdg+Zdhfft9CoMxsoecaglVJGAygVcgYQgmU7lG
         4yIAVMHXwgSAm3EL1juGNJZZ+yZ5S0NeodWxonkd/T0yweRsLwYSk4ywJghX4sTL8+bz
         ra7Hhl4dsGVtBYL3YbKxHPP44I9JQpJsgXrQFtdI1Bqg1Ki1yNCUxNEa95X1OjMeWfsO
         /tQjV+Mbnt3amt+unqSEOm8+E5XpwM90Jiz6MQSgvYlHn0eUd5cu5nHsL4IoCx264bMu
         RpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678652017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdINFsAdIdQMFx1lXaWVNqaG+TfLU8IkxosIQvOMIK8=;
        b=uBNF6aym+6apXNm8xDBeSc+kKJKN3LHOqOon2Un36nU6S6IGp2RQCvs/3GQOWtJJkg
         oU2EEI95C36zgD+ISGy8wQeIeiDcXfMpVcyNFlKfFyjSIi4yhFYfbFagO0g7SYpl1pE6
         BGlvn50yW+p2VSKbgAkdSIv7WIKfgP/nq8iUeXcpD4CKi1ToFpZcX1LCH8VH7jLklkwe
         21y8ulLM2/BZOMX6lsUI4zVTaAFrKhM88Iz/u/a9zHi/Adg/28MscbUgTsyq5rlPTSJX
         9yf5wwveeNb3wT9nlw7aVU9PUFBiVTGORIfCMoVpHHAJk5Ju6TcBYr+DVfTxIqlVTWLe
         OkQg==
X-Gm-Message-State: AO0yUKVPmG0rS1HaCcWn7e5FlNIaXYHuNaStgJFZq9LZy8nYo47VYoLU
        qCmV34z1SnJSw1sbWRHmiIYzsw==
X-Google-Smtp-Source: AK7set85du23yw6AorKNtSYO0EuGdDQF35xs0ZrsFqTsehuhkU87+Hn+WXx1udLORRtrUjOosq1p4A==
X-Received: by 2002:a17:906:ceca:b0:8c0:386e:6693 with SMTP id si10-20020a170906ceca00b008c0386e6693mr30643881ejb.63.1678652016777;
        Sun, 12 Mar 2023 13:13:36 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090637cb00b00926f89e2213sm855864ejc.190.2023.03.12.13.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:13:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: imx8: align thermal node names with bindings
Date:   Sun, 12 Mar 2023 21:13:35 +0100
Message-Id: <20230312201335.498759-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings expect thermal node names to end with '-thermal':

  imx8qxp-mek.dtb: thermal-zones: 'pmic-thermal0' does not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 2 +-
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi    | 2 +-
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 1bcf228a22b8..57099ac0d773 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -276,7 +276,7 @@ &lsio_gpio5 {
 };
 
 &thermal_zones {
-	pmic-thermal0 {
+	pmic-thermal {
 		polling-delay-passive = <250>;
 		polling-delay = <2000>;
 		thermal-sensors = <&tsens IMX_SC_R_PMIC_0>;
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
index 214f21bd0cb4..97d7df0813a5 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
@@ -188,7 +188,7 @@ timer {
 	};
 
 	thermal_zones: thermal-zones {
-		cpu-thermal0 {
+		cpu-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <2000>;
 			thermal-sensors = <&tsens IMX_SC_R_SYSTEM>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index afa883389456..a56c8d0974ec 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -148,7 +148,7 @@ &scu_key {
 };
 
 &thermal_zones {
-	pmic-thermal0 {
+	pmic-thermal {
 		polling-delay-passive = <250>;
 		polling-delay = <2000>;
 		thermal-sensors = <&tsens IMX_SC_R_PMIC_0>;
-- 
2.34.1

