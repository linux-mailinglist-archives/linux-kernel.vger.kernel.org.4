Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57FF60F167
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbiJ0HrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbiJ0HrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:47:02 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B86169109;
        Thu, 27 Oct 2022 00:47:01 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id i3so695625pfc.11;
        Thu, 27 Oct 2022 00:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNeVhpUWigJ0TSEw9v1gskADVF9vSoyCLj/DbDWPyvw=;
        b=aLf1WN+OTqiapPTDJDt06711S12QC7GnpNR/POKcQV+vCSpXvP/xt2qSjKz/b1L4i6
         2ZbElVSDtU2DrJRj1VbvayP3Y2Tsw39vNsoXudiJx44ul4iis90tV3AAHaX889+x7xkm
         9XSVtmJxsqtLOrbZMolwm7kQYmtQAdJmQhmUNFMUkO13a35VhiMc2XyCkYuHNxVn/4EP
         sWNfx2vHJZqt4a7uPobPQVrlIDIJp6lpAEb9RHTHnj1JClbKkc1gzTjCcfxvzPYbTlfa
         HlY/R8LP4evMxZk0pMUmhhS3L0JKNwMRXlMWgltMNYxLCauCJJYyq49+qWgzZvraywKZ
         86Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNeVhpUWigJ0TSEw9v1gskADVF9vSoyCLj/DbDWPyvw=;
        b=x9oJccrHC1r/TZgWX8fX6bcdyUuNIuQ1ty4VvAoiTXVqimJ3/rEvZ/NUcFuLRUfB0/
         0WcvuERY8RJrIXRdXGBG9D33ovOdouf1gGK2gI0KrM7j46FysMRLFbhTqTtNb4r+qVtq
         JomppbyfMZjXg+uldztjrxIeIaUD3WXzT1VY5nN6umwIth9JhMdRhiDq9Qtkq1yGc95R
         nkD2IawzQK1zzeGjBiQTD+8hXVzbYhn8aD4bT++5bwmFOLEL2D39r5cquL8Wx+uIskmR
         ixw8B4ZzLfT9Adfc9rqqbqqwTMM2nOWWsRX1FhPRQMC1atbso0dIuhEnxB3ZIOtfx2GJ
         yICA==
X-Gm-Message-State: ACrzQf2To9KdICkkBFvHP94ZiPubJE5dJvUkPdrTAuAVeOa8dS8jfUEp
        3BLDfWdHVUk5cFUBZesZmsQ=
X-Google-Smtp-Source: AMsMyM5COSKcA1pb6K1bZX1nY6ZH+4sijV88DOEzK6lbU+36HEmAcwE4T7AC0viUrAh68Ejc9bh+lw==
X-Received: by 2002:a63:5a26:0:b0:463:7ca2:653b with SMTP id o38-20020a635a26000000b004637ca2653bmr41647808pgb.352.1666856820864;
        Thu, 27 Oct 2022 00:47:00 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:99d6:ae15:f9aa:1819])
        by smtp.gmail.com with ESMTPSA id i4-20020a056a00004400b0056ba02feda1sm611386pfk.94.2022.10.27.00.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 00:47:00 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] arm64: dts: qcom: sc7280: fix codec reset line polarity for CRD 3.0/3.1
Date:   Thu, 27 Oct 2022 00:46:50 -0700
Message-Id: <20221027074652.1044235-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221027074652.1044235-1-dmitry.torokhov@gmail.com>
References: <20221027074652.1044235-1-dmitry.torokhov@gmail.com>
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

The driver for the codec, when resetting the chip, first drives the line
low, and then high. This means that the line is active low. Change the
annotation in the DTS accordingly.

Fixes: 0a3a56a93fd9 ("arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 3.0/3.1")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index a42b5878a75f..df49564ae6dc 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -37,7 +37,7 @@ wcd9385: audio-codec-1 {
 		pinctrl-0 = <&wcd_reset_n>, <&us_euro_hs_sel>;
 		pinctrl-1 = <&wcd_reset_n_sleep>, <&us_euro_hs_sel>;
 
-		reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&tlmm 83 GPIO_ACTIVE_LOW>;
 		us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
 
 		qcom,rx-device = <&wcd_rx>;
-- 
2.38.0.135.g90850a2211-goog

