Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EA56FF752
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbjEKQak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbjEKQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:30:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1AB7DA9
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:30:08 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-965ddb2093bso1258838566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683822606; x=1686414606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=px/CxXTCmKMmC2DtIG43QR1JFGJikIefzXWxaCFHoxA=;
        b=3KicUe34xmlEeHQcSF65ph3MOrdKA29zYQqKZ3pSZY1EAkIjwvTVoXHfjODz7UmsIr
         nK4tyA73ncLYyVwUNFy9kR1rj5pWHiNh7fSEEpgHlDwMiyhBfgW3sZ/7LxfDk7c+6Qpz
         3dDxfZL+xg71x4KysZwPz7154KsqFyBJLj9VjDSNKywfNt/X4B2huSRsU+sNlzjKbWbX
         mPbWFTSej8Rica4Bm7F7nplf0Ymd8hr5PWNsEFw2koCOvaQrnvDioAAjG17bfdwcwyeX
         L3UK/IbsE8TlDKzRBAZyOl716akXFE6T+dyo4gNYkg2innsi/TNEwcfs9jV4ReYWGw43
         171w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822606; x=1686414606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=px/CxXTCmKMmC2DtIG43QR1JFGJikIefzXWxaCFHoxA=;
        b=MoUT2pTOORU8I06nPel+8N/9On/rxJUzWifBaVbhLLCP/1EeSpnR2euhmpXXZsvsuX
         MQ0g8h1DEI+MZUh23QeqaqsbHWuns/IlZG7pAiJ5AbWUP/6UZaVYA03pFRkPXTcPyhBT
         ydR8VMkp2sedCkLvqN9oyYanctZ2cgf+ZuUQX5ud/XJML3Gso16qLemQRsXLcBOdrwsi
         aeuiWuox7y85nELlmIycw/w7gFe8Ag3PPlgUBiDHpH55Y70G0SU8pck39/jNsZD3j+cS
         vPUWoZ2vTa6GvEpczgGLqg8V1zZZVYnMyU8KQBmJE+cvk1bZvh9kmraXEs2cpBxslxkH
         sNrQ==
X-Gm-Message-State: AC+VfDwS4vG6UIQgVfhK7TEfC2SH7fdWNg4OWiE3wZZH+N9FzwatLbLx
        yV8rlbes94lYGL+sjwndUnlQTphY8qVLSWHNMbI=
X-Google-Smtp-Source: ACHHUZ79BGYI/b+wGlY7M4CXS1R2qYAwJZgwhUs0WwwXbYFkHcQhHwrSfvijlKlf5GiuBtWTlkRFww==
X-Received: by 2002:a17:906:5d16:b0:960:f1a6:69df with SMTP id g22-20020a1709065d1600b00960f1a669dfmr24047805ejt.36.1683822606489;
        Thu, 11 May 2023 09:30:06 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id v9-20020a170906338900b0094ee99eeb01sm4209935eja.150.2023.05.11.09.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:30:05 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 11 May 2023 18:29:27 +0200
Subject: [PATCH v7 07/11] arm64: dts: mediatek: add usb controller support
 for mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v7-7-98cbdfac656e@baylibre.com>
References: <20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=oZbGnh0AF7O5vKAvETFcbZmSMeU6k+oaLr1YtFhDeGw=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkXRgEJVLUMNrCtvulo4P32pcT3Od+6Jn7RABhZ1oP
 XOd3Dw2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZF0YBAAKCRArRkmdfjHURf8vD/
 9c8d0pFkg+B/LMM7Um+nQUi/dPdBdYrWqou9Enbj+Ca6nAgBRs7hPgRacy1xHIWCotGVzkz7FEYiFb
 AYyJ24CZUhHpkfVSl3Nb4Zfd8LMEGgF9t+/eocu+YdkHNSVAPp/jZKZ5CRfiOzke4l2elvOit/y2MM
 l3bs3mFK1mFLU64/A2S0tCmtkFdgu9yCC2xLDV/eMjXc2+nbC6AqDk5Pf/IeAxlipzaasbRlBdrWAr
 sJQtlpWdlF75hpx9M+JI6pKSdyd9lfncJ13aTQl6xdUbJTQbZZltCoNM4dx4yTb7rfnWzd2MEgU5lH
 R20uRGV4Gs5dwenEDUwHqW+Q6mMgHzaBK7xvHer1Ae5tGVdHDpc6XFBBDfgMmBnyuBHzug3DoWRz7x
 OXuey043E1uQenboG/IqJnOyhRaITrzZgIJdxj9W2BPA7rL6dDlGdDf84RqMgYhsFjmITPdhPb/g9J
 CaaPCzTebSa1jKHBJfgSjT3FWVYWUp5aiWajckfCECyok936hA0O+nvP2P3C2FDGdnH3LWybCszVNn
 7gXkwTXeo93jjo7sDzMaI6vw40C/hQgoQWCqnaNO2xdR5XzJbA1D5HVSgCSzdV/f95hX6fkN/09HV5
 aniOe7wPCo+pjHTD5OPIF9dwy45DSpwZKuG6EmuU0m5RBwXqh3+PnVayVFQg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for SuperSpeed USB, in OTG mode, on micro connector.
It also add support for the Extensible Host Controller Interface USB.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 5d69b39c8746..3a472f620ac0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -314,6 +314,28 @@ &pwm {
 	status = "okay";
 };
 
+&ssusb {
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
+	pinctrl-0 = <&usb_pins>;
+	pinctrl-names = "default";
+	usb-role-switch;
+	vusb33-supply = <&mt6357_vusb33_reg>;
+	status = "okay";
+
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		id-gpios = <&pio 17 GPIO_ACTIVE_HIGH>;
+		type = "micro";
+		vbus-supply = <&usb_otg_vbus>;
+	};
+};
+
+&usb_host {
+	vusb33-supply = <&mt6357_vusb33_reg>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0_pins>;
 	pinctrl-names = "default";

-- 
2.25.1

