Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED80703E64
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245213AbjEOUQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245280AbjEOUQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:16:17 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2783811B54
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:16:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-643990c5373so13581731b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684181774; x=1686773774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSFZLbNpPgEje16hneDjcdrQcGQsPzQHluB44E8FHjY=;
        b=NzeeeyMk/hpNF9RAIv4WS+B4v3mYCs9HKMq562nfambK4GSGTB0CGnrcK2r+VFo780
         HOrS4BGRvf+d3B4kDMaLMX4m2Mw73l4go1EcX5Ax9aT0LcH8ZWquW7hE67EC5SC5ZbyG
         BFfEo7608Jp0pE+46I0xG19lunTRA96KvfVhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684181774; x=1686773774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSFZLbNpPgEje16hneDjcdrQcGQsPzQHluB44E8FHjY=;
        b=cvYnTN/L7/FN6xluCxFc1LpuNwz4owFsBDQywdNxE0ZFPeRue515YF/FP4FLM2bGLD
         /ehNeM/13q7FGvrTW/G3EXtOue6StN8vWN7Div8ZtJmq98wa+4lvTYQoCUL1olphqtIK
         HPxYCfHO4qfK9BxmSXEZXSa9TWgHwTMViTaizpomZzi779AP9of5G/UvCJCiG/W7Kbdz
         5rWsf0Suo77BzXzz3s7ancG0CBOOwXXDEpWwt8FPUwfLZJm9T9lZRpfMMCnYFzuMFKAC
         5QR7DJXF7KOXthpQihxgL+lXnceOy1UtdhFH5uArlR8E5/8K3Faxviko/AATloZCLaef
         Dwmw==
X-Gm-Message-State: AC+VfDzKmQZjYLTSI0fYop4uSJ8DHV6e0ovR0DrBNkDES/GEGKiBPbwH
        LeOgBUipmkp6gfqZh3oc1RnEyA==
X-Google-Smtp-Source: ACHHUZ6AiGghtlJlsLLlfd1VuDZv1nQaPFrstBdAfKOZ49IsIsdqeqYgi0pnJ00tpX1ojW99Y/UVeg==
X-Received: by 2002:a05:6a00:188f:b0:63b:8eeb:77b8 with SMTP id x15-20020a056a00188f00b0063b8eeb77b8mr50708074pfh.13.1684181774645;
        Mon, 15 May 2023 13:16:14 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9f33:9d98:277a:d4cd])
        by smtp.gmail.com with ESMTPSA id a19-20020a62bd13000000b0063f0c9eadc7sm7981411pff.200.2023.05.15.13.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 13:16:14 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Eddie Huang <eddie.huang@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, wenst@chromium.org,
        yidilin@chromium.org, Tinghan Shen <tinghan.shen@mediatek.com>,
        jwerner@chromium.org, Weiyi Lu <weiyi.lu@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Douglas Anderson <dianders@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] arm64: dts: mediatek: mt8192: Add mediatek,broken-save-restore-fw to asurada
Date:   Mon, 15 May 2023 13:13:53 -0700
Message-ID: <20230515131353.v2.4.Ie7e600278ffbed55a1e5a58178203787b1449b35@changeid>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230515131353.v2.cover@dianders>
References: <20230515131353.v2.cover@dianders>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware shipped on mt8192 Chromebooks is affected by the GICR
save/restore issue as described by the patch ("dt-bindings:
interrupt-controller: arm,gic-v3: Add quirk for Mediatek SoCs w/
broken FW"). Add the quirk property.

Fixes: 331fae2fc922 ("arm64: dts: mediatek: Introduce MT8192-based Asurada board family")
Reviewed-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Changed "Fixes" tag.
- Moved from mt8192.dtsi to mt8192-asurada.dtsi
- mediatek,gicr-save-quirk => mediatek,broken-save-restore-fw

 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 5a440504d4f9..0e8b34117090 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -275,6 +275,10 @@ &dsi_out {
 	remote-endpoint = <&anx7625_in>;
 };
 
+&gic {
+	mediatek,broken-save-restore-fw;
+};
+
 &gpu {
 	mali-supply = <&mt6315_7_vbuck1>;
 	status = "okay";
-- 
2.40.1.606.ga4b1b128d6-goog

