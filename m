Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBF6638A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiKYMhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiKYMhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:37:00 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105544EC0C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:36:57 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id x17so6573802wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7igFHyhmHKVMXZXEAa2K1RzngdOwodMFmdy9026aRg=;
        b=qIQj1rChUOkQZjWDMxlU73xldn7u4j/v5sjrq+HQcMJKXNE4uwrP4FIMNJn2J27oPO
         PVr35ZfJiCoSEC2bHtyRB+O55hhFLOm4c72fvkSIXiFDheQbQ5xIXeRD0RITOUymq0rQ
         rv4r67/F9KnclaA4AdP7U/D4uZxJRAHkQotBizzrCz0yb3naCnP8gBFg9Eu8S/G7zODn
         3hnP5oZHH5l+vX2Jt3WTC+Pzc6yjlwd6S1mX8vqnrFzxqnBJ6FmWzZvsd121H8LH35yC
         h3bowhIietdxPCWQuRxN6BfP68rqU+UWE0qLcV9ptrwIcoQ8vEkBKUdnyNBtusRpMial
         pz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7igFHyhmHKVMXZXEAa2K1RzngdOwodMFmdy9026aRg=;
        b=Ob9nCKkKwzMQiWsqp5m8jocBS2PFqEDmfQmGFEaTfYCWYszDvmZFC3iQIKT1iqr5N5
         Wc0/CBfiDPxA+J4Pc8bo++WTLgRhynDNYQHkae+yYSXvUzyDzqnpRNmDveZOTTgCaFwc
         XJuS7qEnkNNQUUPl6nziDB4k5OUuta1EWTJAkEtzFZVNQ5FsmUpEf3X4s1WpmTgTXubX
         8ACbIWDNCeFDY73R1SrMklV6g+U/2ful+Glmak4wShsMlkYczhtXZfve+kSF0F8tgyzi
         NF6/F+K5kK+oNy8VzI31xhZkIdFspbNTsJhtJRxGJQjSKYRs2Zt1RZWruTMC30i/GWjk
         RR6A==
X-Gm-Message-State: ANoB5pk1WxiQXLvi5UppzCSwMezYSCxXqA7h2c9v9FNN9vp9ggp/G3eb
        MUXek72eRTj2xV0BwbqoN2Wtwg==
X-Google-Smtp-Source: AA0mqf4ziz7oDoP4wPCNbQed9BXD0t4XuAwT5713VZQX5l2QBzJFnL6s1/gE5DY8Oo7HGNZ/7E6isg==
X-Received: by 2002:a5d:5187:0:b0:242:5ef:ce32 with SMTP id k7-20020a5d5187000000b0024205efce32mr1869897wrv.260.1669379816659;
        Fri, 25 Nov 2022 04:36:56 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d6d4f000000b002366dd0e030sm3574111wri.68.2022.11.25.04.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 04:36:56 -0800 (PST)
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
Subject: [PATCH v4 12/18] arm64: dts: qcom: msm8996: Add compat qcom,msm8996-dsi-ctrl
Date:   Fri, 25 Nov 2022 12:36:32 +0000
Message-Id: <20221125123638.823261-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
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

