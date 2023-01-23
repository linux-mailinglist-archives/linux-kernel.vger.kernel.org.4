Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569E067754A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 07:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjAWGzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 01:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjAWGzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 01:55:17 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB0B193EB;
        Sun, 22 Jan 2023 22:55:13 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r2so9797111wrv.7;
        Sun, 22 Jan 2023 22:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LugQgmyfqJAZM5MfDwY/veKinnwsgbPTEKVFTK+HiPA=;
        b=hfnH8EWTZxl/73vw/86Qzx02JPFf/H9VA4qPbkFVVCxMaKkrnld8AgUnT/Q71LGo+8
         pJwoDDxA/chFkenXnlg2+iv6Of3oqA+vvC85iLnQl24JDALfPmddCIoT/pvDZCmba42e
         aLg0qsV0d/ZcDIzN1caw/7h5OhoZ+J/5900q5WIz9qjhFB/V+3m433Y/C+KeEVXVXfB2
         906RjPZzqT52pA+U95AVEzBXinmEl60QMpJSSTIm0etYag8/HNtvGTUUKcp5+iZRvVGK
         PX2CY6VlxOz6YYPwm+NYD5shLB8q5+170gE38J/O3b9uacxt3zwIVhJsPI9QcqEGPIsO
         5azA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LugQgmyfqJAZM5MfDwY/veKinnwsgbPTEKVFTK+HiPA=;
        b=hi0moXZq0fZHbsMVAL9uIg8TQ10D50ES7aO9gcPMBcZi1i9l0SNbn7WXGbVQjCXb8D
         tL8tlCdx9fXBE62tg5qAm3yhDdZ9URdjFnzLHkWkE3V5zTZXvKwHteXIliw+vc09ikMj
         yRSBybhJQhRXYJkCUuCUZC67X1MGHJFkYLF7TxgsFLC15q8VJxEvA+juZLPNDdtLV+8W
         rGMbReQ25pAUJ+VHvDuuW8XJiA+39s0okFqIB/630X8pnMvJbzyKnVaLvrMa22IK9BDz
         3fJRt+Bv6GbUUW/INiVSE+iO1tZrTTebmpt3awLp4I7x1G75mntoA1z6Iv6rXPrMnyZn
         st5Q==
X-Gm-Message-State: AFqh2kozrY6qtGKm045vNOUrcGdFou+F8WmA5/qlkPivrx/oOD25Lm4i
        kwLc1175jj66kfg6AJLalsE=
X-Google-Smtp-Source: AMrXdXvIp8ELatgU7oKdVRfUKO7qM5zVf4fqydlUFyU9ZXRmcrvc7eR8SpDf/crtuX1Xonz1xqKjaQ==
X-Received: by 2002:a5d:5608:0:b0:2b6:daf8:52ad with SMTP id l8-20020a5d5608000000b002b6daf852admr14347847wrv.52.1674456911675;
        Sun, 22 Jan 2023 22:55:11 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id az22-20020adfe196000000b002bddaea7a0bsm25948365wrb.57.2023.01.22.22.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 22:55:11 -0800 (PST)
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
Subject: [PATCH 1/3] arm64: dts: meson: add Broadcom WiFi to P212 dtsi
Date:   Mon, 23 Jan 2023 06:55:02 +0000
Message-Id: <20230123065504.2669769-2-christianshewitt@gmail.com>
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

The P212 has a combined WiFi/BT module. The BT side is already enabled
in the dtsi but the WiFi side is not. Let's enable the WiFi module.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index 05cb2f5e5c36..7055057d7942 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -125,6 +125,11 @@ &sd_emmc_a {
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
 };
 
 /* SD card */
-- 
2.34.1

