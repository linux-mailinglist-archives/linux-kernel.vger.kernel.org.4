Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AB96EF2AB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbjDZKuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240444AbjDZKto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:49:44 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC541BD6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:49:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-2f9b9aa9d75so4389952f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682506181; x=1685098181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDMAZYC6PlfAvsYSrf+M4iyNDJFAF/AM883C7PrISNc=;
        b=NiEogC6rbyFJM1FSnl/FadpIxfug9RR3ut5ke27eotswvuUD9tQ+ZPJnmwSClqSspI
         fiOKARPv2qxgl7E917M9JrviRwIK8bkkuyAOsDgKWAtn3z8nr9nkZiabEmc81LKtGKMd
         Cj5wv3w8A1Id7aYOKxzU4fki/G5rs/rQwthN/4AjQ4PWBCbGOKqz5fpRB47U9FrNIvZS
         txF5En/9GWm7rNxSNlltDsQDgPhudCTXxd58kIrPiEcLFyHVXS8JL6AFIiPr1y7C8iIm
         GfO67v8qK8Tf/XJVi3a6Mi9s0MtXeV7Kh6juhhi9GQDm3DxhfCcdL6t+aadbsnAUkZ5Z
         plUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682506181; x=1685098181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDMAZYC6PlfAvsYSrf+M4iyNDJFAF/AM883C7PrISNc=;
        b=fjRg2rWZ4cegEy3FA6HJMs7jxcqQkkx0oopywMQ3oJhZOWMU2jMyF7S5uvkcPzYl6V
         j2ZS8OiUEI3q7SscYfNdIfp+JR69IS96mxIL3VUN6K882TbIhQtlYQR1OOL4NQ8Yqz4v
         ceV+0kN7iwClURJlMPddYoclh/1iKWCxWE681JkxbkgzDVhzGZ2CSSGboYuQt86DUUI7
         UV8I22DytzkkItFjPRm/iEIYTYKqSUcuBDq5nug1sZbiuz+HJGAAAhtUXR+zAGq5yPkD
         d+vZ/96UYUwZ8JSBaXfNkZVLwtl9nmtREk/JvfRyV7ThWILsr0akEaN1ewlDp/CUzPUe
         HKaw==
X-Gm-Message-State: AAQBX9eihO3fnT5cNdT6v5ZqztxeEp6L98wmThyoZDrnDWumwh1y4wPK
        n+UVTduu67ZGdwpodXkmthw52g==
X-Google-Smtp-Source: AKy350bKZiYHUtnWnoZ/S+mQWOjCDaBV8/pXElR7HzrGZxI91UvC4qjfknWCal1E/D79mT5NQhIeGA==
X-Received: by 2002:adf:ce0c:0:b0:2f2:1fb6:7b0c with SMTP id p12-20020adfce0c000000b002f21fb67b0cmr14157207wrn.49.1682506181105;
        Wed, 26 Apr 2023 03:49:41 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 25-20020a05600c025900b003ed2c0a0f37sm17601988wmj.35.2023.04.26.03.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 03:49:40 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 26 Apr 2023 12:49:04 +0200
Subject: [PATCH v6 04/12] arm64: dts: mediatek: add watchdog support for
 mt8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v6-4-8d6b1cfe7f29@baylibre.com>
References: <20230203-evk-board-support-v6-0-8d6b1cfe7f29@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v6-0-8d6b1cfe7f29@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=940; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=9yZG6Lt2sYetnfjl+HHfU8vcDGstMCEZ7QfVbikE4Lw=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkSQG/9dRLMit9NDtAeVEHD4K8h7SA0jlkRUAkyK7c
 vhslhDaJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZEkBvwAKCRArRkmdfjHUReltD/
 96zwsIpIprtKIFhuSZKMpzQzb0vDdpAYbF8n1sVod99junEYGKg2rISq32DZ9oXBSB0KYfC2pvxMkH
 skByJa1ebTo/ELlMp7pGhekvGFazgU/LEawPKmIfPHmG0O6LtigrQnYnM87d9ARcoKmnhnW7mmuUvX
 RvQKLH1tFj8oQNzik21hfmG2G5UjdASP6KeB/7ZG7aMF4uAWjUqjC9ezg8dD/DpKNobHTiNzi4sOZY
 3HgQywmf64FxsHQXlrAlvMPqz1/yz0D82Ov1xwiJC8w4XIb0GXHwYrgs4gOx1ahixnxJsSW0q6b2qz
 ibvBJTWftnxAUFeZLybrj+xj/b2ePi93SU2ztGgzTVDwurKnFXChuIBIAPEp/Y7hy92MeI4JGDW7mZ
 X38XEYjIAxEvtu4v2qrzUcEEaLdAGDP4c1tAlN4qfehl/8rVUCHPy2c2Kg9UU/IdUmcV+sPQ4j31dC
 CBZJ2IP+61XAmN/NfE4osSuCCExR5Hv4WN18KOvYcRtFdBXLQemtd8wyoGRTRq9S+9ixUlmGDzL54Y
 XR0yxyRJnf2roHJK8Z1Cvv8Evfm7A20DKpSvJ1uvbkjOGdX08EYh2Fzxz1sttowPpOODCyxVAEhRPf
 wXczUxs2nd2M7tZO4I/lWlY4yz1o5/J+mS/p77zvo9GSUC0agPwfQATwF09w==
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

Add watchdog support.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
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

