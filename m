Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9D55EBCC7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiI0IIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiI0IHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:07:33 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7B5115BD9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:01:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h7so1306789wru.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=k3Uie5pxkgijukjmsxCrYCPs7jEPbo3aKWq5eUqCVmA=;
        b=atrB2K6hZteWnvzbPkbVoOb6uaiXmiR3AyWDp/KoYcRjXAeCmkNgkEscK/WeMsu4B/
         DbnQLJ7+Atl/C9djjI/Z4TBfY33e67mCqc7PoP65Ry1dATFWrYzhG16let04hYYRE1C4
         552SG6rUw2D9uWXZSWWgkVMWsSciEpfO2yArasPWPYahvhA+IUHG2Ys2Sy2T/MM0VwzJ
         1u8vTYqO56bCWIqp0vZSjtPUGicxle0VpFrkLicOXJKZoPr8j9aQBvkJod6gdLTLJjYB
         Sdf6tyirbY/0u5uAqqPJp9tEY9/GS7ec4NTkyzr2mKUhrnTdMKOrkJIoTpTmsbQ0wfy9
         i2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=k3Uie5pxkgijukjmsxCrYCPs7jEPbo3aKWq5eUqCVmA=;
        b=Elxw2M2RAEYaTrOIIxJEgM91fTs/x7YpEyRH8Rx1Rz/qCiPeT9meFa9DkrXq2YPWIi
         gYs6ze7Xewd1y3FOdNreXxLeNoLwR/eLEGXp5ydLpyRXQXG7STyvHUXN6I1NxDx07wg4
         90//YnAF5BKStsdTrR9Zq3QrQAYCCUnOLnUMkwUMvjWbFQ1KjDlVhFZg6yx7KHYoJuvo
         c6CINfmleO4u/9qR2B0qNt1JD4Vfzol1g4jjFoDGg36xX/xn8dLjWetfoKWDpA16j/LJ
         VHqoM/RNHyyInTnqdpBenmA/ljDolasz3X3NdSxaZlcJAxtzFkMuGxcbjogOdN+Mabc+
         rcEw==
X-Gm-Message-State: ACrzQf3XIQnzdi8PZQn5q68EhPoVEmZaFFsoFb3v6U5ou5sRC5IHyQcN
        WMPuZfhr+iquHA3JVI6CklXWeQ==
X-Google-Smtp-Source: AMsMyM7Nsk7GUy0Dn+s5dXjE9WoMQoVO5BreYgsM9yVfqjD93GEr6OzmJ9TbwoNWDiPStSCfSr/OMA==
X-Received: by 2002:a5d:6484:0:b0:226:dd0e:b09c with SMTP id o4-20020a5d6484000000b00226dd0eb09cmr16103248wri.388.1664265671924;
        Tue, 27 Sep 2022 01:01:11 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p4-20020a1c5444000000b003a5c7a942edsm13357199wmi.28.2022.09.27.01.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 01:01:11 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT 5/5] ARM64: dts: rk3568: add crypto node
Date:   Tue, 27 Sep 2022 08:00:48 +0000
Message-Id: <20220927080048.3151911-6-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927080048.3151911-1-clabbe@baylibre.com>
References: <20220927080048.3151911-1-clabbe@baylibre.com>
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

The rk3568 has a crypto IP handled by the rk3588 crypto driver so adds a
node for it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index ba67b58f05b7..62432297f234 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -211,6 +211,20 @@ gmac0_mtl_tx_setup: tx-queues-config {
 		};
 	};
 
+	crypto: crypto@fe380000 {
+		compatible = "rockchip,rk3568-crypto";
+		reg = <0x0 0xfe380000 0x0 0x2000>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_CRYPTO_NS>, <&cru HCLK_CRYPTO_NS>,
+			 <&cru CLK_CRYPTO_NS_CORE>, <&cru CLK_CRYPTO_NS_PKA>;
+		clock-names = "aclk", "hclk", "sclk", "pka";
+		resets = <&cru SRST_CRYPTO_NS_CORE>, <&cru SRST_A_CRYPTO_NS>,
+			<&cru SRST_H_CRYPTO_NS>, <&cru SRST_CRYPTO_NS_RNG>,
+			<&cru SRST_CRYPTO_NS_PKA>;
+		reset-names = "core", "a", "h", "rng,", "pka";
+		status = "okay";
+	};
+
 	combphy0: phy@fe820000 {
 		compatible = "rockchip,rk3568-naneng-combphy";
 		reg = <0x0 0xfe820000 0x0 0x100>;
-- 
2.35.1

