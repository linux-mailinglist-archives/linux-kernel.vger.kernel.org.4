Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D19F6D273B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjCaRzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjCaRzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:55:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BB610265
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:55:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j36-20020a05600c1c2400b003f04057c152so2274470wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680285337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwase7lH/pIQ+fdUHX1Peydgp8rdPYou8E/famXpXaM=;
        b=vNDOaHRl2Kj/oqm2a+ZOvkVthke3hcEOsa1gShhrWY9pdOR4+1HnzUCEPpsAJwcG6i
         GfxmnUN9mHXe9yKlMkkLpUzj4EIULrAVlJfxYJKS3e6mFrQwIWWSUfUCOWknKnm4//Vb
         EuDdmwgw8XY4OBR+NB0ofqeh2lyl7XQ79uZiiHQC5/mB0uPcg+rcqUY3m1L5VlF8rO6W
         BjLQLPyP1Fjyl/QvTXcrQxJMgK5EmWldvEyRbsICGU+sz7bntwOQZDF2SuBQ8NX4HSzC
         8BOVPNlbv0Lo8bIKYvZPFKIw8lTYppLDhqG2OJ+yjrwBH/kLzaWxoWwVjm0qXRp/LtBh
         nV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680285337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwase7lH/pIQ+fdUHX1Peydgp8rdPYou8E/famXpXaM=;
        b=H73Y5TkO5/nwnTyyUgvPaqBTSxUYsqdu8sWHA8jpj3OVXvvkU2xiAoxJio6IUU5lNv
         tGth7YGGrqg5TOIzSd3NnGcaO1iW0PHiwb7h0DmdPxdBuD6B9aHXdLMVGG2tRcfqMQWB
         RSyBNEH9/zA5iuu9klj5Ez8bkkg5LhEOxSKwSOGgw6Bg4Rmz3mEIcSF0XhW04NaOpmTR
         Quwci4TLnWgtprcra/P3ibNzHkLhC0M0YFkiC0zaxJphL0KteeFGH+erhfmTQvuoRF7w
         5xpwkEJs1c3+pfW4CsHL72jm57HE/tJyDfaJOER0ZflQBDCsp76SXUUf5zlk1jDV2IXy
         Aj3w==
X-Gm-Message-State: AO0yUKUMHpyepzkd378UTm9AddBXJ8WqzAp8y310SgZt1/Jm+R3nf7ss
        ZB7GWNMw8sGMQzTxXWD7lM611A==
X-Google-Smtp-Source: AK7set/7YiR+6uvInKBDF5U3X3vbS3p5pTgCtbpBCrUfqHWCLuMaRSiB0t9TdM3aAcsKlki7PIML2w==
X-Received: by 2002:a7b:cd0b:0:b0:3ed:2f1a:883c with SMTP id f11-20020a7bcd0b000000b003ed2f1a883cmr22924076wmj.14.1680285336932;
        Fri, 31 Mar 2023 10:55:36 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 1-20020a05600c22c100b003eeb1d6a470sm3370171wmg.13.2023.03.31.10.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:55:36 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 31 Mar 2023 19:54:47 +0200
Subject: [PATCH v4 03/11] arm64: dts: mediatek: add watchdog support for
 mt8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v4-3-5cffe66a38c0@baylibre.com>
References: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=892; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=sanLlORy8ZXQl/7pqZ+xOL9pEwEsbTjvO/nq6i79rEI=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkJx6TZlgIokDKg08GNEP70+ShS8iKpqmXUqsh1Ucb
 brcDys2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCcekwAKCRArRkmdfjHURY/AEA
 DCtwg3eRbv65f68/nKU0XXQL0jBa7Jmnsq1oE1w1oxBQXjWEbAlUceHhnFOiTnI02gs66zMgRJVaQA
 Bwn0bsRRebmE69Qdcv4qsuM8OsRy+hRFfEsaE5M+xNrD8zCw2Lrq/ywasJfn8B03OV6vb3KK7P0DEE
 R1e9eKbiyrf7xtnnU9bPMTyh1OBU8fzrzFpywsYfwh1LWhoMUusddFDpSGkF5APkissQxh2lvG1GWu
 IlPTxT0vdsfrSyaG9ytUtuPdVImYf35/NFym4xAGVElPSLYgeYdqgvNMCgb7wnRJ9OQfc0pYmJXDAH
 SsOllDF5506DJOOH5cQktSjuEX7svelefHuOIDIJYtZqv/1iarRy9TDiIKejaSHqJ8+uSGzatyqRyi
 KASvjPttRvVetoTUThLaXQ/ZmI0wPqV+9OmLACBc8DYaN/+uHTqbaB7CVEOzdqiQEMt4T8ymqMZgzT
 AAojcoN6b9GgbiAYBMPeLdt9LzD2wJ0ktVfz48i/M+kuLx6ab6qodgYYK4mXhMShcmMag5+fUkPAV9
 Fnl3ARBpMGsEnkybKwHIPspNMuBJ5EqevRAhhhzDhkDy4soWGmBMCLvfMlo1HteUCgcztc58C7Gqio
 nIZYREGCOXarfxBpLqJzXfpcp4eiTavD+40+Hd007I2vivYSCG7ZTjAL9SjA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add watchdog support.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 1f6b48359115..bb45aab2e6a9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -162,6 +162,12 @@ syscfg_pctl: syscfg-pctl@10005000 {
 			reg = <0 0x10005000 0 0x1000>;
 		};
 
+		watchdog: watchdog@10007000 {
+			compatible = "mediatek,mt8365-wdt", "mediatek,mt6589-wdt";
+			reg = <0 0x10007000 0 0x100>;
+			#reset-cells = <1>;
+		};
+
 		pio: pinctrl@1000b000 {
 			compatible = "mediatek,mt8365-pinctrl";
 			reg = <0 0x1000b000 0 0x1000>;

-- 
2.25.1

