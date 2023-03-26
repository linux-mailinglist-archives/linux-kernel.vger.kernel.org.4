Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28856C97DE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 22:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjCZUpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 16:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjCZUpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 16:45:33 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9450A5FE1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:45:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w9so28012235edc.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679863524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvZrVpDdfTLeMGJL+heZ69WUSKrchJNCDDAYmYCMphA=;
        b=ZuSKHqc9wHPiA8M5czSgpKnQcYELnVhA9nB6Md8rv7AeorKkIFrZng7Clvi28TIzlp
         dvwqxGXyvJy2UqUophw1hpaK/ZlOE53rmafjDvl2eh0MKZLnOP0fntZ/Ceo0waCbnpRB
         86SRY4r1ZeUg6IKCiUSdtSyPRAUarFDNG824nJxQgLw8W1u6raDS5cAp3mpCslpYb0y2
         jkUGE4fN9i5a5GFNh7yAYg/t0CZ9Jmguoun9FoKJ9XTn7YxHpgW/qNPMYWa1mroJMi/B
         eKPNSKYF2XuIjNe1NOGcdk9F7MXJ80AfPPIn2lE4SPrGxfVr15GfRn7RtPqgoTdvjYD7
         42LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679863524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvZrVpDdfTLeMGJL+heZ69WUSKrchJNCDDAYmYCMphA=;
        b=8G6C6nKyE9WSl9DkAm67hex9qwU2AMqvCekTKjFYecXQaxglGEkrna4G4RL+KR7KQ7
         l7NuIHmPXj1XxINuX01v/+9g7y+uSD82XfP2u2MnEAhqykB2s/yxCI36s2Kk8V1yvQSv
         NCQ7p8RA3fnOArC6z1QnWgIF8Roh/mvSNcH6Azfc0AYqKLM5wnckPVo6katGmIO5W4K1
         fB1vzp1ABDamEXlWABk+35iEpNQTPBhC0K7KQdykjP2k3bzEM++W5nWeD0J8Z83C8x8/
         JtYnOG6tSwufxdFrZsEHRuNCC1ZU8TiM28x9OZmecwgeSy8nT1jlX74F0oqg20XXnp88
         vmBw==
X-Gm-Message-State: AAQBX9dnBzlyica3LlZmWGhQ3lanuerAe5TFejOAp90coB54kYyZXtGy
        shGRg4a6R8PN3roTeFkxtagp0g==
X-Google-Smtp-Source: AKy350afISWMGjqW02mLjl6itx6fdrvMvdaEhMIqaBbv+Rigfq5/tCg+ES9ZBQKvLgaHV+KIqXoVoQ==
X-Received: by 2002:a17:906:dff5:b0:88c:a43d:81bc with SMTP id lc21-20020a170906dff500b0088ca43d81bcmr8568811ejc.58.1679863524094;
        Sun, 26 Mar 2023 13:45:24 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6b51:4748:3f3f:ffcf])
        by smtp.gmail.com with ESMTPSA id ga5-20020a170906b84500b0093e23d03d72sm4090982ejb.177.2023.03.26.13.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 13:45:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] arm64: dts: rockchip: use just "port" in panel on RockPro64
Date:   Sun, 26 Mar 2023 22:45:20 +0200
Message-Id: <20230326204520.80859-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230326204520.80859-1-krzysztof.kozlowski@linaro.org>
References: <20230326204520.80859-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel bindings expect to have only one port, thus they do not allow
to use "ports" node:

  rk3399-rockpro64.dtb: panel@0: 'ports' does not match any of the regexes: 'pinctrl-[0-9]+'

There is only one endpoint, so use simpler form without "reg".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 78157521e944..bca2b50e0a93 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -647,16 +647,10 @@ mipi_panel: panel@0 {
 		avdd-supply = <&avdd>;
 		backlight = <&backlight>;
 		dvdd-supply = <&vcc3v3_s0>;
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
 
-			port@0 {
-				reg = <0>;
-
-				mipi_in_panel: endpoint {
-					remote-endpoint = <&mipi_out_panel>;
-				};
+		port {
+			mipi_in_panel: endpoint {
+				remote-endpoint = <&mipi_out_panel>;
 			};
 		};
 	};
-- 
2.34.1

