Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71D2606103
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiJTNIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJTNI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:08:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C4C198444
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:08:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a3so34283058wrt.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OTh+ZIjQwPwHMVAfy9H3FuL7YWrhAHg4js/lzlDK/M=;
        b=dPjLmalF4T082X1GAwZDaYuFAMSPpp0aB14UPRgdaK3oGQc/1q4BrzgbFxwyN61ZKU
         U1e00H4orCpimY0WqZV/t9LGcXm04UE9iyNWLrWHOdvrIWV2xsx4LlCkzHT6hK5KzsII
         nvquy01Wo7tMC/c5yV/TbTtTichCO2NtK90Y3dEfHH3GA+uAi7bHThZv41vN7kLSBDVP
         d4kbkSo0XMfWUesBVtYlJ5p9jLiAw1GGo/AvJzFRb2nKinO/sfvGxKRHFaPIlBxs0Zmv
         JxFZ/KWdnf1w8KyOovb2DvVxiyMRAEIJZEGYf4mCbfC7d5hVzcF7yNVFObJYFfPiEifk
         UAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OTh+ZIjQwPwHMVAfy9H3FuL7YWrhAHg4js/lzlDK/M=;
        b=7hdS0AmHRYe1fNDDoQTxHUW0LZsPsCOH8gMZx/2furIpJWDCJi48r13qwTH+VyqrQo
         2ROfEwKafEGFil8NK9+e0VLmK/9IYx/mZ4jXppz4U3ZcVT9p3H7XZFPMmmDHkxJ0dEjL
         P+W6uLQGKUYEtljYlsHWvyegC1VBtkESdX/aVI7zWJ1lsdNwURkgUt1gfr8lKuwdVfbA
         uxoLiT7qYZkwZk+ezvPr44ng3DJCQA+szYyUeqEZ501OmwtMKr3WDnAG6CVuaDmo3ibI
         v6IS3ODDInNvRgDxqyjxUOFLRlnTKRGwDU3weTUkLuIi4ErOtgpNm7tGeJiE4dA6Z9Xt
         4nZw==
X-Gm-Message-State: ACrzQf09eZaSDeuSBG8sZe/b4s4m3Vrm7Q0t2pe3/lJe4FCg8hp+8K5z
        nQFGZipi7uNnZCSMoNTyzXkDdg==
X-Google-Smtp-Source: AMsMyM58z+ASY8UOi2LgUP/AtKbL5GblBy/jUDVZRHLihya/ftcGyEuGo5VmC6hSj04JcLqpHSVyQA==
X-Received: by 2002:a5d:5346:0:b0:235:6c05:6272 with SMTP id t6-20020a5d5346000000b002356c056272mr2786891wrv.332.1666271284107;
        Thu, 20 Oct 2022 06:08:04 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3a82:90b0:2979:1615:9a68:f204])
        by smtp.gmail.com with ESMTPSA id p26-20020a1c741a000000b003c6b70a4d69sm2676080wmc.42.2022.10.20.06.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 06:08:03 -0700 (PDT)
From:   fchiby@baylibre.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        "Zhiyong.Tao" <zhiyong.tao@mediatek.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Sen Chu <sen.chu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/3] dt-bindings: soc: mediatek: pwrap: add MT8365 SoC bindings
Date:   Thu, 20 Oct 2022 15:07:17 +0200
Message-Id: <20221020130721.24866-2-fchiby@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020130721.24866-1-fchiby@baylibre.com>
References: <20221020130721.24866-1-fchiby@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add pwrap binding documentation for

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
index d24e2bc444be..8424b93c432e 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
@@ -30,6 +30,7 @@ Required properties in pwrap device node.
 	"mediatek,mt8186-pwrap" for MT8186 SoCs
 	"mediatek,mt8188-pwrap", "mediatek,mt8195-pwrap" for MT8188 SoCs
 	"mediatek,mt8195-pwrap" for MT8195 SoCs
+	"mediatek,mt8365-pwrap" for MT8365 SoCs
 	"mediatek,mt8516-pwrap" for MT8516 SoCs
 - interrupts: IRQ for pwrap in SOC
 - reg-names: "pwrap" is required; "pwrap-bridge" is optional.
@@ -39,6 +40,8 @@ Required properties in pwrap device node.
 - clock-names: Must include the following entries:
   "spi": SPI bus clock
   "wrap": Main module clock
+  "sys": System module clock (for MT8365 SoC)
+  "tmr": Timer module clock (for MT8365 SoC)
 - clocks: Must contain an entry for each entry in clock-names.
 
 Optional properities:
-- 
2.25.1

