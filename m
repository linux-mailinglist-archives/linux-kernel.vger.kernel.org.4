Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61D87107A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbjEYIfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240138AbjEYIen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:34:43 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA26E5E
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:34:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3078a3f3b5fso1783052f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685003640; x=1687595640;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h98NoPbHKXaOosD25djs0HPbXqP33JG0leL3y+BahfI=;
        b=UxyMCeppxxJnmucZz1FLlACvQTgpLzOCUWc8f5AtoEyfvRg7qppqR6yJkcTdnpDseK
         z4yKAgiILNgcJ4HhHuZci2cdKii9hlGxNvo76EwmF6mkiV9wXFlj2GG8sOjDuy/CBjNQ
         mHCjQWZZ5BPUlgXn+t/c+jXQ9rlJUkpwpL9gb6Cl6zWaoRsX5/ex9EzlDakvslQikSXq
         JoFhd9ZoobJCG8ebvDqSf+1sWbPB7KRp37JN5tQYxVihClFsVsV+L/hwRtgElA6lNsOS
         C/bk6+A4H97/WPCqkAK0Q81ml9wc7D6sNce6/bUcFaFEyPoPycKIUTChnZ5xymCS6qu6
         o3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685003640; x=1687595640;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h98NoPbHKXaOosD25djs0HPbXqP33JG0leL3y+BahfI=;
        b=Zud/xLw7QfMEs1JjTMgVr0RiA6HHGYy3mTAc7gfl9fPIS6eeIYGyFLgjJ+QmDMzwsb
         p+nR+Woug6/AzpCxo/8thx+y7q+s0z57zX+HSHLFBLKKbq7fsftsU2kEQCQG/LnZzXKl
         4VWDM0ZHbAxpg7O27gYfTOGhTBqg1UYt5JLRTSn+kDpA09K8HrN1qyVX0uxwhiuR9R65
         WC+RXAThWK0KSnrMz98UAqNkJnqLtH6ssGBoTrgErgLpQoL/D4lCvjQiYJi875Y6t3x7
         JjicaPBW1MMziaZ883wBgZZyDYxX8wzoAmNm6OP+ikzTzYkexLCT5K+xOQlxkRYtToye
         LIgg==
X-Gm-Message-State: AC+VfDwleYCjgxaSka4ikB69I7vcrR+3n8d/qhhgf/RKfhqY6AQ4uIeD
        VBtgl345KSU3FhFMrDPind68H8qY/s3Zt/eOiPA=
X-Google-Smtp-Source: ACHHUZ6SbT5rTAhB7t4b3SD2/m++30U2EjYwaKwVJSwGG0uxvdl1Q5lo6ovWbP4+lwnSwI49o56QmA==
X-Received: by 2002:a5d:6a90:0:b0:2f9:61b5:7796 with SMTP id s16-20020a5d6a90000000b002f961b57796mr1968034wru.29.1685003640489;
        Thu, 25 May 2023 01:34:00 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id o3-20020a5d6843000000b003095a329e90sm945809wrw.97.2023.05.25.01.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 01:34:00 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 25 May 2023 10:33:15 +0200
Subject: [PATCH v8 06/10] arm64: dts: mediatek: add usb controller support
 for mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v8-6-7019f3fd0adf@baylibre.com>
References: <20230203-evk-board-support-v8-0-7019f3fd0adf@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v8-0-7019f3fd0adf@baylibre.com>
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
 h=from:subject:message-id; bh=aZ2qXzF7sVxQmHaiJcejpyAZGX7fMTSz7XCiEr1NHZQ=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkbx1v3iOZdwJ03az9WD84/dPhphD2BzdRB0pfrUgc
 8ZcfMhKJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZG8dbwAKCRArRkmdfjHURSOxEA
 Ce12JAxQtwD8/aTHib8tARj0fpDn2KX4fdW+DbYxesXJC0AXt8cbcAVDQp4vcLQfJeTo02JcEdw2x4
 o+NeJj87tKIB0dLhMl6z6M47/izlblgZNi5uK7lZl+Rj+SvlWxcsNGEbNLUaQrfUE4S69Z57VQKA/u
 9B4ArZQF9pzI4vp9B6Iy7MsHxT5PoHbFXqrTWgHnXIACCg7OryHHR6pEcpFhAEN4grPbZKWF/TfLpo
 77FGwe1GKwEhfLUEd+lznvF1MOULzWm9oCJCGQOcicjUO6xSWSp9m8ZYfvIgjCEXMZbOMxIcROXoAE
 CqA+JFY5giDb8rmpyxBhY8vxCyLWNAEA8ILXPWBDV3XsKXVlgRHtW7LJ/v064V1vOqhnttACp1UWZy
 Skj3CXpAUYIe7TRqjtS6i1sJ9iUMF0m7AI8yL21T0AhJENT2kevBuPQ/N4xLtiNEO0DrfwweAtPSfZ
 cWIDsJhvI9B4jjsLktGpYu2c+fxErGvpbAUUbGsvbk60XSkjvy/hhjM9ovgLsQ4QWNZBkqde7g03Ss
 MCN5sAHji3tYyBhEd8HoQBgBbZ/w4zbQ1YDWaV0Z9EOkH0AZUgDdICwR3Qqr6J1gxPavi6vuJYL0xe
 xgal7bfgfbU7e5QYV/ImzgauMpiWJiwp6HVzRUrF42a4fewEVKYeJ5Q2whfQ==
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
index 6e2f3601509e..1a5769c397c2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -309,6 +309,28 @@ &pwm {
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

