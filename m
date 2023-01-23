Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D1467754C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 07:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjAWGzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 01:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjAWGzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 01:55:21 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCDC1A480;
        Sun, 22 Jan 2023 22:55:15 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h16so9784686wrz.12;
        Sun, 22 Jan 2023 22:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GVWHT8LMHCj7WTIetB8Hze7sdYKVKxQsoEuu2SrhJE=;
        b=XYLWS3YFEemtqCVqYvM+uFf+TWff8nPVApRa7jMz/b/taJLSCSVYCHPr5muYSsjEer
         yAX+Po4PAqBqDPGE4EeE0oIFRLz49C/sILJE2fUo5TEc57fRZt9qRgGUebHthw1rHD7g
         CA2cepQCzWVemGn6gkj5duDYJyslnjuU0m/2Ga0NnG966D5mkKAV1aJ00x7+Ob1mi2qZ
         kmIzIR25q3usNIRY0XRD8n/D9/XvXUWTTWt0EQ62XS2jjRSBPpNFKqpuXnvVFUsM4fKN
         jV8OHEJn6Z8YSGE+qTuFYtQPYGHd6FEnBzuXmjfL5CphB7i9dHQ2Fu4THz6hklSapUC5
         ft9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GVWHT8LMHCj7WTIetB8Hze7sdYKVKxQsoEuu2SrhJE=;
        b=X1KWbz1K0msn46rJaqxaToEIXtDuMJQuAvV+AdLODXPrDFUyuZQg7tT/z2fKpyffeu
         dADx65VG++x7xz734oeRmqVKEPu0EArvGSQKW5OdUBERS45v/Q9yjs57Fwp2EvTpNSP4
         iAYi3Aawn5BPHVEL5yVmUgT8oxGvPSFbF6ov1mkwovX24fjoGFuNOVut8o0xUcFBu2q+
         232j4ZBe58FpjK+t3TBAzS6BWfoAWfqs7rBeYPh3CE1vpBnCmUa8xHMIupHVKu2F5YRG
         sRUySoy198wmuxRw2kZL1wcKc/LWGYBsw22Dgl+uLn2HsyaUs0YelhmFfaY8Y6PBSdSw
         cQbQ==
X-Gm-Message-State: AFqh2kp1m512EUcif+ztenc/MdOoa9TPvTU7qAEQmcSHfeI6uGhmY86o
        5pm+ITQAWzERmMrIkmzUok0=
X-Google-Smtp-Source: AMrXdXt4pawslOEzxLqt8MDlQM4SuQ81Y2SJGvh8/1Fha6HZzFFYlcbi2z8s0Nn/a8ickF4mkNbOhw==
X-Received: by 2002:a5d:6702:0:b0:2bd:e009:79cc with SMTP id o2-20020a5d6702000000b002bde00979ccmr27714202wru.53.1674456914067;
        Sun, 22 Jan 2023 22:55:14 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id az22-20020adfe196000000b002bddaea7a0bsm25948365wrb.57.2023.01.22.22.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 22:55:13 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/3] arm64: dts: meson: move pwm_ef node in P212 dtsi
Date:   Mon, 23 Jan 2023 06:55:03 +0000
Message-Id: <20230123065504.2669769-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123065504.2669769-1-christianshewitt@gmail.com>
References: <20230123065504.2669769-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cosmetic-only change to alpha-sort the pwm_ef node.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index 7055057d7942..a150cc0e18ff 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -97,6 +97,14 @@ &ir {
 	pinctrl-names = "default";
 };
 
+&pwm_ef {
+	status = "okay";
+	pinctrl-0 = <&pwm_e_pins>;
+	pinctrl-names = "default";
+	clocks = <&clkc CLKID_FCLK_DIV4>;
+	clock-names = "clkin0";
+};
+
 &saradc {
 	status = "okay";
 	vref-supply = <&vddio_ao18>;
@@ -170,14 +178,6 @@ &sd_emmc_c {
 	vqmmc-supply = <&vddio_boot>;
 };
 
-&pwm_ef {
-	status = "okay";
-	pinctrl-0 = <&pwm_e_pins>;
-	pinctrl-names = "default";
-	clocks = <&clkc CLKID_FCLK_DIV4>;
-	clock-names = "clkin0";
-};
-
 /* This is connected to the Bluetooth module: */
 &uart_A {
 	status = "okay";
-- 
2.34.1

