Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6BE703E68
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245346AbjEOUQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245300AbjEOUQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:16:24 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD521161B
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:16:17 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6436e004954so13729578b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684181777; x=1686773777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KM/irCXkCORVs1tf0J/YTFzQeu/14yX91bXMA72ZW5U=;
        b=K0+Zkz4GdFPHRuwRz6zdEsbA+lXj9VAwwuAFNi/uqRKAzSyUQ3GEPrRLWI8PkADOkI
         lGqIQ901J1tMCxacLaXJZC6XFLvMELhtxu9QDf3Qq/XiptE0pMNQC9PZbXPqib6VGrM0
         DGcwlS8gGGj9LRADnOkCvYBwy1d//nqfUOBLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684181777; x=1686773777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KM/irCXkCORVs1tf0J/YTFzQeu/14yX91bXMA72ZW5U=;
        b=deAm3YqbOO+M9We7l77G3EPo36lVkjy0SVkcd3wBPGN+4iciIsWRAyq6EEkOGxZKGH
         bpfFiXCaaIQRNnGZsj82zNiM1OFIEnJvOXVye6VoD+9QLugxhzHHd8RrdDu/niIAcrb4
         7gBLWmJL6wXVrkO0OALza4MOtfmHMw1PQs+elVjPMG355PC6R9FALE00KxA2tORG1foT
         hKTsicdhzeSdKZiVVXDL0jj70OcR2RBBGf51rdhie0IInmBRApfWO9Y9vmDr3ANwwy56
         mbguZypeBpglg0iOooQmAcyFMN/KShF073VKi0PJlwQBk/y+aJL3OuX7XKQPBPeiZtqV
         gtBA==
X-Gm-Message-State: AC+VfDz1okZo/YZVoyHC7CUb9QH686Ooz1U4+zLDp+R+5k83suLil3gv
        bEduttIL9J7cm+681iSY4r8wzA==
X-Google-Smtp-Source: ACHHUZ5ivSNt4ORDYSAE06hFa+3QjYHpxRE1M4IEyYc28jIBV7ZY1zm248z55ssOvgBip8+BrELm7A==
X-Received: by 2002:a05:6a00:1828:b0:643:6f76:f9ba with SMTP id y40-20020a056a00182800b006436f76f9bamr49643580pfa.29.1684181776830;
        Mon, 15 May 2023 13:16:16 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9f33:9d98:277a:d4cd])
        by smtp.gmail.com with ESMTPSA id a19-20020a62bd13000000b0063f0c9eadc7sm7981411pff.200.2023.05.15.13.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 13:16:16 -0700 (PDT)
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
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] arm64: dts: mediatek: mt8195: Add mediatek,broken-save-restore-fw to cherry
Date:   Mon, 15 May 2023 13:13:54 -0700
Message-ID: <20230515131353.v2.5.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230515131353.v2.cover@dianders>
References: <20230515131353.v2.cover@dianders>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware shipped on mt8195 Chromebooks is affected by the GICR
save/restore issue as described by the patch ("dt-bindings:
interrupt-controller: arm,gic-v3: Add quirk for Mediatek SoCs w/
broken FW"). Add the quirk property.

Fixes: 5eb2e303ec6b ("arm64: dts: mediatek: Introduce MT8195 Cherry platform's Tomato")
Reviewed-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Changed "Fixes" tag.
- Moved from mt8195.dtsi to mt8195-cherry.dtsi
- mediatek,gicr-save-quirk => mediatek,broken-save-restore-fw

 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 8ac80a136c37..f2d0726546c7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -255,6 +255,10 @@ dptx_out: endpoint {
 	};
 };
 
+&gic {
+	mediatek,broken-save-restore-fw;
+};
+
 &gpu {
 	status = "okay";
 	mali-supply = <&mt6315_7_vbuck1>;
-- 
2.40.1.606.ga4b1b128d6-goog

