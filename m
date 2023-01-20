Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83C9675007
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjATI5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjATI5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:57:34 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2C54B483
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:57:32 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id q8so3429820wmo.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLh9gLAmjmKtRy5q73jgqvg8UmN0Ojzfcs9IN4Tn3io=;
        b=HlOp+ZzuuUNGOd5tA2tWo3ZGkj59h25nLkmRpQfVDe/ZosO8xHcnoQ01C9MGhepaP7
         bDAEE7V9bEwWRM+0oWbiCmhFDBGWC+1nI189u+aNX/D2zvjgPY53uxsOpKyL9F2vbFir
         MUH9uJhYEVaUEqQb0cx8MapBMo7SI7xjAlmcs15hZAZIZaC8Mn9tYy1O5BfGHrpOaSAZ
         1zp6nU31KvCYSo+5LW4TkVufRzSyfgkqQ4MwnM3fupwfLfm6hf0DhPMwroyHGlQuwp3V
         9YCJH8sGLi73F8JFOoaNpdWz6qjnolIW9RaSKaonT+Rp7uPzgyw4jTXGDPMHFe7FViYW
         B15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLh9gLAmjmKtRy5q73jgqvg8UmN0Ojzfcs9IN4Tn3io=;
        b=lRcRmn/VXSDKQTl7kEtwd/vJphLa4GpN0BGbUC5EkgskRB2wxzWUKp/Gp7Sn3m2w8x
         1179Vyz6mF6ZHdKFmqYzBY0P1o+69ssa7d7vYD5ClULRRd3AEhgY0nymCrGmhuRbI5le
         0ckezHQTUJMqKKCcalhvE3zrc2vvMpmwaeAM4sSev427V6BCbPW6k8rw1asly83ratJ1
         fPW4DlHT1ztGZXI0DNuaPn9DiM/TrHGZsGTdtb4ybrnyXHUUXmKOjuqXWYLAM4l3syzL
         IhgdMMCnp2Gh3wyYto+pLDNFhn4zPbvagG58kl3gdMcBj6XSb2IdSMvNLfRtpDG4RRiy
         G0Ng==
X-Gm-Message-State: AFqh2kqgc34R2xHiH15F6NouL82cWFSKoskiTuKrewAlEzjpHxGAW/IC
        +fBmE7pjRRINsztFFXt4MavlcA==
X-Google-Smtp-Source: AMrXdXtPATBJIPGHO0muRWjbnexaaMeh6KMlt8hH9FxqJjkYVKtHLyQf4msXY2Ls0rl7zsDWKo4Zcw==
X-Received: by 2002:a05:600c:3b17:b0:3cf:7397:c768 with SMTP id m23-20020a05600c3b1700b003cf7397c768mr13153310wms.30.1674205051416;
        Fri, 20 Jan 2023 00:57:31 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l18-20020a1c7912000000b003db00747fdesm1612040wme.15.2023.01.20.00.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 00:57:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Markus Pargmann <mpa@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: mmc: correct pwrseq node names
Date:   Fri, 20 Jan 2023 09:57:22 +0100
Message-Id: <20230120085722.171965-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120085722.171965-1-krzysztof.kozlowski@linaro.org>
References: <20230120085722.171965-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node names should be generic and should not contain underscores.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml   | 2 +-
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml | 2 +-
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml
index 911a5996e099..588be73168fa 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml
@@ -41,7 +41,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
-    sdhci0_pwrseq {
+    pwrseq {
       compatible = "mmc-pwrseq-emmc";
       reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
     };
diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml
index 3397dbff88c2..b35e00e8c65e 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml
@@ -35,7 +35,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
-    wifi_pwrseq: wifi_pwrseq {
+    pwrseq {
       compatible = "mmc-pwrseq-sd8787";
       powerdown-gpios = <&twl_gpio 0 GPIO_ACTIVE_LOW>;
       reset-gpios = <&twl_gpio 1 GPIO_ACTIVE_LOW>;
diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
index 64e3644eefeb..00feaafc1063 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
@@ -55,7 +55,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
-    sdhci0_pwrseq {
+    pwrseq {
       compatible = "mmc-pwrseq-simple";
       reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
       clocks = <&clk_32768_ck>;
-- 
2.34.1

