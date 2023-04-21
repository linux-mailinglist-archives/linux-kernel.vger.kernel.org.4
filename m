Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB856EB4E4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDUWdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjDUWcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:32:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE28D2733
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:32:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-956eacbe651so322909966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682116326; x=1684708326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iSeiUFQe/gAEpdjV1hnid7atOwpOqQxCrxD+MmhyxIE=;
        b=LQGuqITsScBbWAnaB4RxKjUYsMetTOXmwB0/09RUkaCjSyOWeIdjHKigqEmtnb4wGY
         bG5miVd1KQZq4x5VUS0OmlJv5lhDP+6H7bgp0fUEHij81iu/K/cW/+IQrk9jV7pNb7FF
         OIQvLuzKFfUCThO60bFbbncYoOiLsTerlOKADD90E4yUU+AHsJPtkE9/VyXSAG8VPmFK
         Vh21wCNh2OmuKu1o61tojwMZ/L2khzZv44NLNnNmWAOWHDeN1kRq9ARrQEuJzfS1D0hg
         /2e2kA/w0wBKf/sjfokxYvDctBUJk9/0rgEhlRUCmVdshDHjvYS8d/nd0EwcKNnx44jy
         XHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682116326; x=1684708326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSeiUFQe/gAEpdjV1hnid7atOwpOqQxCrxD+MmhyxIE=;
        b=H57nKq8X7SVUPMhlgpaI211wwpQffzEuL4/J/tpD3ZrHUhCJ7DnxyAJ7g/ZMNPeCu6
         orCKjE0QWgOh4GOxE3QriAOLXsReekDwqZQDKAWl92ViVWZpEISd/nG/bMwprwNCGE4+
         RC9sq0UyxxhDLhorKE1BcHBHPl5PclcGY5Go2h8fFI/p7OeEgpCPKc1ecodXD7ipsJXc
         ImsIycD9ZNy/U3dyNg9CyNM598/7G32uZPlssJf/1YtXZjmN/DX5BV3UHVae2oi22TJy
         hEHM4ZJM2JNDXsvKpf8YlAeeRMWrOBq1xv8s5PI7AaSLTEIXPe1WMFD9fthhk0XbyEtA
         VZfg==
X-Gm-Message-State: AAQBX9do3xe/XxEinwgcNShETs1fAIbfClsiLWiYprA4MuEjPIMkdhtf
        fzLvG8fKRzBVlcZYtZIVt//p2w==
X-Google-Smtp-Source: AKy350Z6narnfukg7HJQiHbe7fR3Vtv+qabJyazSE6BUgreSdVcTPsGsEK+PgBWEIQs+6bOOpDrJ5Q==
X-Received: by 2002:a17:907:94d1:b0:94f:1c90:cb70 with SMTP id dn17-20020a17090794d100b0094f1c90cb70mr4742301ejc.66.1682116326279;
        Fri, 21 Apr 2023 15:32:06 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id r11-20020a170906280b00b0094f9140ff40sm2559426ejc.37.2023.04.21.15.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:32:05 -0700 (PDT)
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
Subject: [PATCH] arm64: dts: imx: add missing cache properties
Date:   Sat, 22 Apr 2023 00:32:04 +0200
Message-Id: <20230421223204.115500-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As all level 2 and level 3 caches are unified, add required
cache-unified properties to fix warnings like:

  imx8dxl-evk.dtb: l2-cache0: 'cache-unified' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please take the patch via sub-arch SoC tree.
---
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi | 1 +
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
index 70fadd79851a..792b7224ca5b 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
@@ -60,6 +60,7 @@ A35_1: cpu@1 {
 		A35_L2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 32193a43ff49..57627bdaa851 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -52,6 +52,7 @@ A35_1: cpu@1 {
 		A35_L2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
-- 
2.34.1

