Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D1A673ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjASQ3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjASQ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:29:01 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F13C196AC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:28:59 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t5so2422487wrq.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DozicllB5aSf0NJHXLU7ZCZpto2E7CIim3OCyCfRck=;
        b=NHXZRJW2r4Eea2Fq6bbn8bqBLj9R38yAdJ3SNzksX6KCwk9YGSukNefWB037D/S9Ic
         Bj/Z0732mvGk6au5utPQNri0zxflXaEyfBvWPJKYD2n4FRT4/6UG8bt/6/y/wylPSko8
         bkmn+lB9UF4UJISdFP24udMcqk7qhrzjlVOn3xHTjUuZ07EFmYCFfik2sfEvHRJGN9Ee
         oykgK5BrHI9zNDO0gTIYKZHqrY7fOdqv0IafXGWFVsmWQXpP8azkJYf3zQP2tKq+7wUF
         m931tr3gf84kLiTXi+Kw9GASoQFOWH2DeOo2cw8RO+vhxN+TJKm+SDZ8jFV9TeeTrNmj
         6dwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DozicllB5aSf0NJHXLU7ZCZpto2E7CIim3OCyCfRck=;
        b=3gqE2WeeimkNOuFeB4IF/jA8Gbhpfi8IH4zQeVIDxnK5wSs6hMnmK0SzNGM/aR2u9X
         eW3XA0oMzKPC8UHueWLwCL3dQA25zqIe52u8HoD0nYErk/CTkuuDWM1YRFqm3hNFF1mV
         zyGcO2Iw3xdr2VCgex2XGAJosxJHyFxaGrxkOXyWk8PY+1CLHbRUTl8lxjJ6Kx0Z2aMK
         rXCSdMaTRNcky3tGhh+bJYhGTBNRmMbyUgFIjPKH+mzWFXcIRuQAqFe4m6QSwmTmjP5c
         cYWlSIzpwrvZHw/UrmHm0IHOaOBpisJb5aqdYZycGNzH21l9felpI/F6Rp0gRM8rw3kL
         U/9A==
X-Gm-Message-State: AFqh2kpRT+o+Mv6oKauPR8pT4VHrftEhAvrWXmlnLi45YDoxnOXeRGDo
        IA+FWWJ5SQoH7I+wMWf3xUJsIVANze7dp0pY
X-Google-Smtp-Source: AMrXdXtiiCW9cPmJt+sOqlVLAk1K/QrcT5OPbQKlsBELKwCUcAl8ZoaemX+z+i/8HaYMBi8jl/YQXQ==
X-Received: by 2002:a5d:5708:0:b0:2bd:bf4d:9a1a with SMTP id a8-20020a5d5708000000b002bdbf4d9a1amr17640458wrv.25.1674145737828;
        Thu, 19 Jan 2023 08:28:57 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f7-20020a5d6647000000b002bbeb700c38sm29008771wrw.91.2023.01.19.08.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 08:28:57 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 19 Jan 2023 17:28:49 +0100
Subject: [PATCH 1/2] arm64: dts: mediatek: add spidev support for mt8365-evk board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230118-mt8365-spi-support-v1-1-842a21e50494@baylibre.com>
References: <20230118-mt8365-spi-support-v1-0-842a21e50494@baylibre.com>
In-Reply-To: <20230118-mt8365-spi-support-v1-0-842a21e50494@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=pU0kgdkxC01dKg9iYuR4AqxL5UqzT7jxF+KQ4Hjq0X4=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjyW/GhA2jsFlKrwNu/Bq0D8txpeMfuIPSs3hrK73I
 B4V8yCyJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY8lvxgAKCRArRkmdfjHURfvDD/
 4i14e/xp86ZD2uYjBWq4E6Nj46bAdjD9o5SMPDYvQaIQMJ83yt09xTMFnE/gc1qgANCoAGJb7KUQy9
 IVpTdu9YQnOkeop9yleZ/9XMvxFSjZ7sEHkgqr5qL7lAau+T1OTallxCdKqiyXb5/GJznZhBhRGGWo
 4JXaf/1X1ocVjq61PMzIZhXgR8baULiQ2IVA8nMSj09uNAmO16VBo2oRVdUqNp06S9G7f+rB6dM0d6
 gflxlcFbRd5OBFWGEeu5QSqL3AAcFa+1/BeWNxYCDNhsTsbiNc44FEae6wmF5jGnmszlG5QVH8wTg2
 yaUvfQ+f4Q1IsMzHBoUGz1CjxicgkAd3MaS4/zr3Uesu3Wr6LDG4hUGNQg5Pdl43IA0S007QZqvjDY
 Le8PbAoEp+VqZ55fJNkZd+/rLQk15c8Fbhnlp3OiHMos+r8cxl0/SHtq7MsUwvAYyCDSFbF49JFzhz
 wgZ+z42rU2dmokL6NI6H7kf+F1QTO0hJYjeruj4Nq1zihygPAtNv1nUZhI3sbGcspTBVQB2pCfgr2L
 QxA2IgjCgOla7ObMRInASVXX87mbUa6hBt+O2AQI/n/P8zxE+Gjne0H4DMycweSNyzFKytSrPaFK9j
 5PkK0DIhpfZuVsyOp69smzuzAk1SwDc9vqS2QQq+ULl9cSFojjZDMwnyNrsw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPI pins and spidev support for mt8365-evk.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 275ea3a0e708..c1d603cb129a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -142,6 +142,17 @@ pins {
 				 <MT8365_PIN_116_I2S_BCK__FUNC_PWM_C>;
 		};
 	};
+
+	spi_pins: spi-pins {
+		pins {
+			pinmux = <MT8365_PIN_26_SPI_CS__FUNC_SPI_CSB>,
+				 <MT8365_PIN_27_SPI_CK__FUNC_SPI_CLK>,
+				 <MT8365_PIN_28_SPI_MI__FUNC_SPI_MI>,
+				 <MT8365_PIN_29_SPI_MO__FUNC_SPI_MO>;
+			bias-disable;
+		};
+	};
+
 };
 
 &pwm {
@@ -150,6 +161,19 @@ &pwm {
 	status = "okay";
 };
 
+&spi {
+	pinctrl-0 = <&spi_pins>;
+	pinctrl-names = "default";
+	mediatek,pad-select = <0>;
+	status = "okay";
+
+	spidev@0 {
+		compatible = "mediatek,genio";
+		spi-max-frequency = <5000000>;
+		reg = <0>;
+	};
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0_pins>;
 	pinctrl-names = "default";

-- 
b4 0.10.1
