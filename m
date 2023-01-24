Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC912679562
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjAXKfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjAXKen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:34:43 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC5941B40
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:35 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id b7so13418300wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NL6LDV95iKUZ88QALB+Ce5cz9NNofOXuE/jp4Jy9qw=;
        b=xWCpo//8yl7WQy6B4hKsdIkck3nEgqtIZjdp8sjH8WD4jjGVX98v0nBtUNbi5QhZ0m
         +hX1wkilEisWngPsc/sDDIpWwqLnL2KzzvCo2y+JlR4mKfQE/koHINDa+H9MFlF2I8Xf
         DY0tRSLHx/SSm13nKDB21XitbYhuF8kdQS0anj0VYqHyjnJiiCvC0k4ZCt1zQVoRldwC
         1r+mNQjD9JpejtwqTubrPk3IDMstJ/PQGGQNaNLxn51KYeB1jk17UxS22gDDdqncTE3D
         uk0Yb+MIuUNYTgEwRH/679IW3eQyVIPtyUwcQp3K7wNbIJkWAq30/F+egXZ4BpKsN7+M
         WSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NL6LDV95iKUZ88QALB+Ce5cz9NNofOXuE/jp4Jy9qw=;
        b=sFxDyuHDc+Js0cOIevbS93iQfAi/eA0gxXv9pMtvifaLerbFzW6oRq/KWvE2hWcGuV
         v4/JjKWGgz06FJm0v5ltzQktKjnyRcQHEhzKFjRElv0uHO7GlzfhdjwZRPdOqcWEuzTC
         vxffl4geEeBhDLjZfDk1AE/8X4mX6ZxRCWXdZsCJ9z2qbhQNFfPXNdxrlynaFPVXEcmG
         XqSV3qQDs5BnTyh8Zs5/G58V35qQVMqr/Kl27mckNiQgvL/R0/NvQalJ/1Gbh2iO0m+i
         rlW95nqy8gNE4qLZCOmSgz0TxmD9tGPiXz83Krv2zQS81YeceiDk1AGudOXhoOTCCclm
         Tohw==
X-Gm-Message-State: AFqh2kqN2rZeek9Td8JMs92EeviAa5TiSgmDZStfHseIJUkEav4v0Y3x
        +S24H4AkA/GYNLZZjEzGt1yc3w==
X-Google-Smtp-Source: AMrXdXvlr09valTA39LZgwlGfqTP2jevf0EhtZ35RPqMyoekiYwexPBukO4Bade+FoUIUDDAHDi6IQ==
X-Received: by 2002:a5d:660b:0:b0:25d:4dfb:790c with SMTP id n11-20020a5d660b000000b0025d4dfb790cmr23823487wru.13.1674556474226;
        Tue, 24 Jan 2023 02:34:34 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q6-20020adfcd86000000b002bded7da2b8sm1551889wrj.102.2023.01.24.02.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 02:34:33 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 24 Jan 2023 11:34:32 +0100
Subject: [PATCH 11/14] arm64: dts: amlogic: meson-sm1-bananapi-m5: fix adc
 keys node names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230124-b4-amlogic-bindings-fixups-v1-11-44351528957e@linaro.org>
References: <20230124-b4-amlogic-bindings-fixups-v1-0-44351528957e@linaro.org>
In-Reply-To: <20230124-b4-amlogic-bindings-fixups-v1-0-44351528957e@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes:
adc_keys: 'key' does not match any of the regexes: '^button-', 'pinctrl-[0-9]+'

Also fix the invalid "adc_keys" node name.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
index 028220ed45ad..bfc500df9dcb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
@@ -17,13 +17,13 @@ / {
 	compatible = "bananapi,bpi-m5", "amlogic,sm1";
 	model = "Banana Pi BPI-M5";
 
-	adc_keys {
+	adc-keys {
 		compatible = "adc-keys";
 		io-channels = <&saradc 2>;
 		io-channel-names = "buttons";
 		keyup-threshold-microvolt = <1800000>;
 
-		key {
+		button-sw3 {
 			label = "SW3";
 			linux,code = <BTN_3>;
 			press-threshold-microvolt = <1700000>;

-- 
2.34.1

