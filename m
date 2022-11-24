Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C31636F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 01:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiKXAtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 19:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiKXAss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 19:48:48 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E72FBA93
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:48:19 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id v7so273924wmn.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7igFHyhmHKVMXZXEAa2K1RzngdOwodMFmdy9026aRg=;
        b=YEe/hyEyRdcFpHn2Lry6PI9e8vGou4lqu2Uskax8y5DfDT18K9yhn+xY241N5V/tr8
         QhE2JGxzmfNEldWqkV4HG5VxG7cCPaeiEnoHytGpbw/Cr361+rpIzvDQ2QPT8BcnmGoL
         6qLxU5uoWQmqnLXOB0Cvg3JFoG24thWU/tOFbp6bAFLWsow3EikljXNqGwLwVtl+9lzY
         XNN7D1bxz5K5IST/GZo7LfJgnuuPQ9kwrBD05HX7Gr+UXpNxUPEJW7ymqqhbf4hXUTVi
         BCWLREPMRwoQ+2Qnv4NMDHsPENh9DB93FBnqNcizOrZBGIm87lc/UARi108ETS3XXqyw
         rIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7igFHyhmHKVMXZXEAa2K1RzngdOwodMFmdy9026aRg=;
        b=eRB+837u93VDt8mRrTfvzQlnTZKD1DdpJ0xti8VJ49/jylAhpkN9LeYBsWQABzkliT
         MAqHgX3g0Cbz91JCiOZSBpRjK8p+AVgRy7lr3JHLjLmyE+WU2ec+ByncgOsFWPJb+6Vt
         621wdGz4J++jM0IoKOPseF68vdnJaErbzPBAdN9TfNPZcE/tU8ZA1+am0WLrNb212tPP
         Rhl2tjnX+p1gZctzGitjiuKPsq1gPajfBWWkDdZ5Hls7Fb/NeTDbodHAoEkKHSEQk4C3
         tqCdZv4XwitdWJsIw/akeBuT/+ztMW5TaAgdz2iJ5LAkrpuQ12KOO80pOZQQkCDD8Wyh
         xkQw==
X-Gm-Message-State: ANoB5pkglpowcMMs22xQ5HzVhDVM9+l92oF/4skUwPJQIS+Itsx+wAVz
        bJKnnI0onOBE3zq7jSk0OYoXOg==
X-Google-Smtp-Source: AA0mqf5OriOC9F/2TwTB4Y4eYvlM0v1V9cnS9OKowIQTOHik3qyaYvVjqSvphXR3oB61luMGH0dQKQ==
X-Received: by 2002:a05:600c:354d:b0:3cf:45ff:aca with SMTP id i13-20020a05600c354d00b003cf45ff0acamr12885545wmq.53.1669250899212;
        Wed, 23 Nov 2022 16:48:19 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c3ba600b003c6bbe910fdsm5245076wms.9.2022.11.23.16.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 16:48:18 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@chromium.org,
        david@ixit.cz, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@somainline.org,
        agross@kernel.org, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH v3 12/18] arm64: dts: qcom: msm8996: Add compat qcom,msm8996-dsi-ctrl
Date:   Thu, 24 Nov 2022 00:47:55 +0000
Message-Id: <20221124004801.361232-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221124004801.361232-1-bryan.odonoghue@linaro.org>
References: <20221124004801.361232-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add silicon specific compatible qcom,msm8996-dsi-ctrl to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for msm8996 against the yaml documentation.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 081e20a63c610..9f6543579dcf0 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -968,7 +968,8 @@ mdp5_intf2_out: endpoint {
 			};
 
 			dsi0: dsi@994000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,msm8996-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0x00994000 0x400>;
 				reg-names = "dsi_ctrl";
 
@@ -1035,7 +1036,8 @@ dsi0_phy: dsi-phy@994400 {
 			};
 
 			dsi1: dsi@996000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,msm8996-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0x00996000 0x400>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

