Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2136703E62
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245284AbjEOUQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245275AbjEOUQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:16:17 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46B9E60
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:16:12 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-643aad3bc41so12677319b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684181772; x=1686773772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jqiqb2iWttvdC3HhbyFxiKycIZ3v56zeARkXn2CaIG8=;
        b=BA3eC9fLQ13vqDEGsDHWDDvCuyngMEyna4+dAlzia76PnarszsniqtMipx0u6e/Cgu
         pZhndmlgcmZL7Gzwwo/LJO6pj3Xy+eIAe7K/9wo4PDEpUyEfaxXYbjl62N6VDTzs+HYc
         rEYn7k3sYXQ8wqyaLPlkSZ/xbOOQKI//ZA1iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684181772; x=1686773772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jqiqb2iWttvdC3HhbyFxiKycIZ3v56zeARkXn2CaIG8=;
        b=WVIJhJO/0Jn/90c9YRl+d/vpkrvOrv+/I2kJtX9A/5JUXoOAfqsTViX97EpGhASjLT
         nwMTpnRH69omrr8CAzHzF2xD+6E9RDEIObla+LJXnlDu9xI0TQi9JMS5HjSUBJ/R4L1n
         CbmGpaxCVFbVnx5NFosfPAsRKC4/s7vWeXqvQ4wLKdzAhBJHwMjTwu7pOJtRAd49XZBa
         yUjYGFdRKT1VGBxl4Br5ASC+CtdSxYNZ3Kw2gsYw0EZMmXb/wOViudmFU8reEUONUamz
         0Layfp/XUWO2gZz/QLhmehK/gTXN9n1B9ym89mbJmKNWGvs22KDp06NaSOQJCIfp8UTG
         MZ2Q==
X-Gm-Message-State: AC+VfDyi+YUBWEVPh2iAwXXKaoWCTEpsaE0+2sSDPJYMq7LJQdueJEY0
        Bs9AtLDBH0/Q+gzvoCNixRKH4w==
X-Google-Smtp-Source: ACHHUZ4afNWoz/IHm3+tYuCUS2VKPE/E3iS8LS0IzUgQs4MtgxjGipjnhVX+ILNAtW2aKIz0GlGgLw==
X-Received: by 2002:a05:6a00:2285:b0:643:88b1:9bd1 with SMTP id f5-20020a056a00228500b0064388b19bd1mr45311433pfe.26.1684181772491;
        Mon, 15 May 2023 13:16:12 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9f33:9d98:277a:d4cd])
        by smtp.gmail.com with ESMTPSA id a19-20020a62bd13000000b0063f0c9eadc7sm7981411pff.200.2023.05.15.13.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 13:16:11 -0700 (PDT)
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
        Enric Balletbo i Serra <eballetbo@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] arm64: dts: mediatek: mt8183: Add mediatek,broken-save-restore-fw to kukui
Date:   Mon, 15 May 2023 13:13:52 -0700
Message-ID: <20230515131353.v2.3.I525a2ed4260046d43c885ee1275e91707743df1c@changeid>
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

Firmware shipped on mt8183 Chromebooks is affected by the GICR
save/restore issue as described by the patch ("dt-bindings:
interrupt-controller: arm,gic-v3: Add quirk for Mediatek SoCs w/
broken FW"). Add the quirk property.

Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")
Reviewed-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Changed "Fixes" tag.
- Moved from mt8183.dtsi to mt8183-kukui.dtsi
- mediatek,gicr-save-quirk => mediatek,broken-save-restore-fw

 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 63952c1251df..8892b2f64a0f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -292,6 +292,10 @@ dsi_out: endpoint {
 	};
 };
 
+&gic {
+	mediatek,broken-save-restore-fw;
+};
+
 &gpu {
 	mali-supply = <&mt6358_vgpu_reg>;
 };
-- 
2.40.1.606.ga4b1b128d6-goog

