Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223BE649F05
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiLLMoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiLLMof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:44:35 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6745912084
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:44:32 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n9-20020a05600c3b8900b003d0944dba41so4997061wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BcuYqJP5+fj5SQoxNBlxka40ix71bnNCS/22EOHif6c=;
        b=5jCsOLmT84Gpexbwd3LYlscYFmSC0rEy8GV3tJSFjAtHmjIjt4VjGnK46fL+c/SWko
         ATD7rA1A4qLWJXBZhFM6fOAe7uWwF8YRYl0tvgHp+/H4QQjigrwhEOSxW3teF8zlrKMT
         RtORGOYYIn2Z4uwWENQo4rfBXfz1qwkYa/HyOgxvcOoamH9j05Wnd+O4JrSGar2V2K00
         WRP5QrBDIZOss0XvJEadjQmENw0w1xG+LO03xVCGmlPikLB8ZaE87ziVNFyRuG5mb16q
         /fGTehl8qbk/Gjg4xkys9qmI2MZBOw+xRTs5KrhzoPxi0PeiL+J5pdtzP8gt1i/Ekv6R
         VmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BcuYqJP5+fj5SQoxNBlxka40ix71bnNCS/22EOHif6c=;
        b=lPLzUapNz3lyGtJw0yYopSrl9wQDyaxeteiSK9Q3WnIy4vwzltmxPPTIwtG20KZXNB
         7dhfnMUUHA1asZRUR2QAM2YkVxfIyBdARaRh63+lLm+HcFWOy5fX9y6eov0Wu4JMTu0C
         DXQJz+RLfF/6LsgVXcFOmEgMwgQNt0yZmDJErGhwhwJv8Avs9dOYq8LiXbflokwqr9qP
         pVyiWqw9ZCAudztnO8xL9jZ0WbKFhq3umagCxNo8YlgTIyB0KH8VgoS1Jwuk1m18EZkO
         5Rec/nsiBqX3MuFXjqGaY/kieB9EVxsPoBbn504RIscoO+TLJ4KCPGcxT4STpG4chHGQ
         sN7w==
X-Gm-Message-State: ANoB5plSQiCD87/GKes8mcNjzm6SiiM5V4lQ93JL7fvGuIINUaLqvQVo
        7lD8Gfl2Udr7iwUFoAJhY5Pi6A==
X-Google-Smtp-Source: AA0mqf7ZofsvsUMIpaiiaqGaUYm44ZHz7+YLjvSzQ6WLOrlmfcHRI4m9G7pmNFdYrqN3h2+Ly+yLYQ==
X-Received: by 2002:a05:600c:3ac3:b0:3d2:148b:4a26 with SMTP id d3-20020a05600c3ac300b003d2148b4a26mr7598329wms.32.1670849070998;
        Mon, 12 Dec 2022 04:44:30 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j17-20020a05600c1c1100b003cfd42821dasm10198660wms.3.2022.12.12.04.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:44:30 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] arm64: dts: rockchip: rk3399: use correct reset names
Date:   Mon, 12 Dec 2022 12:44:23 +0000
Message-Id: <20221212124423.1239748-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset names does not follow the binding, use the correct ones.

Fixes: 8c701fa6e38c ("arm64: dts: rockchip: rk3399: add crypto node")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 4391aea25984..834d16acb546 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -589,7 +589,7 @@ crypto0: crypto@ff8b0000 {
 		clocks = <&cru HCLK_M_CRYPTO0>, <&cru HCLK_S_CRYPTO0>, <&cru SCLK_CRYPTO0>;
 		clock-names = "hclk_master", "hclk_slave", "sclk";
 		resets = <&cru SRST_CRYPTO0>, <&cru SRST_CRYPTO0_S>, <&cru SRST_CRYPTO0_M>;
-		reset-names = "master", "lave", "crypto";
+		reset-names = "master", "slave", "crypto-rst";
 	};
 
 	crypto1: crypto@ff8b8000 {
@@ -599,7 +599,7 @@ crypto1: crypto@ff8b8000 {
 		clocks = <&cru HCLK_M_CRYPTO1>, <&cru HCLK_S_CRYPTO1>, <&cru SCLK_CRYPTO1>;
 		clock-names = "hclk_master", "hclk_slave", "sclk";
 		resets = <&cru SRST_CRYPTO1>, <&cru SRST_CRYPTO1_S>, <&cru SRST_CRYPTO1_M>;
-		reset-names = "master", "slave", "crypto";
+		reset-names = "master", "slave", "crypto-rst";
 	};
 
 	i2c1: i2c@ff110000 {
-- 
2.37.4

