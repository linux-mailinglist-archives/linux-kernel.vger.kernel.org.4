Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DD8654AF1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiLWCLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbiLWCKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:10:52 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1877C278
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:10:41 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o15so2751421wmr.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7tCG2RVp+L8qHK6ZCOnqZpsqAhvGiGNti+CNMhR8tY=;
        b=XpO2l27EmfKRAdLkoWUa00n8PEcJtoqnibEi5ihkSxeCznmTcPkWe4dfL8DtIZJbdN
         OUWXZUHSpHmG20JOQwr50XRBeiZOEUMVfOScyxZGKREqSG+Z8HbD8cPTItcozsgrpNsW
         S4ghDUZWp9GB9FIYrGF26agID3pR32qgUA7RBMYloQvlnUAQ0yC4dFyY/Snn+W0Ff7YW
         Ulf+TODP/cQ/pZXRR9q2OlbDWzb0LLRPP1A79vCAICpAPCGpkorYW8xLHPFzcuurx17V
         7okyIRYbI1Hx2EeS3Cp9eJtpD5bdH4sAqGkxyQKNuCvE6f9HrWd5tK/YD9hOaFW//qAM
         vawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7tCG2RVp+L8qHK6ZCOnqZpsqAhvGiGNti+CNMhR8tY=;
        b=eN0XDxojZvjfx9O/Kyuepx/sStCZQOtgd5Q3zaxrq/mBlO6+HgJ0cP9KOGGoGRjTcw
         YT/ldAERcI/VV4wKo7Rhxm4AF5Zzl/Crm+3weUnskNR301DnV8OHLY7O+4XZjbV/UZQW
         qH9j3KsOnrSe2NBcisMzRvC2TdbMuZXbjZ6Dd9vy+sIe52ll+sAxBTS67xQ+Elr1zuB1
         Mc2uYnHHAXdXRbs1W3RTidcTzT5yFEX20I+Zt2dW2ZDl6s5l6mqz+s5N5FxwC9sWcQFm
         w/2Mdg0FXtNTfH3s2t5XdCK/f0PBWE6R6tXP+7aBFEV6mHnHSjG2jrAL9SMfs+5jpUoM
         5T2g==
X-Gm-Message-State: AFqh2krRpMsK4swjjduTlsNvdqK8hk3yOLsUb7aaBVX6zRO9/I0hy3IG
        d7Y/z7XmkPELs+rkHyR8xSd8Pw==
X-Google-Smtp-Source: AMrXdXscQ2YCy04SKsOId4OsLJX5iBr6uNz1PZSH8I+aVEvdWEBlVGq1TELm/MLSb5gDqbXCFv6ODA==
X-Received: by 2002:a05:600c:512a:b0:3cf:8957:a441 with SMTP id o42-20020a05600c512a00b003cf8957a441mr5868404wms.12.1671761440308;
        Thu, 22 Dec 2022 18:10:40 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d452b000000b0022cc0a2cbecsm1849725wra.15.2022.12.22.18.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 18:10:39 -0800 (PST)
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
Subject: [PATCH v6 11/18] arm64: dts: qcom: msm8953: Add compat qcom,msm8953-dsi-ctrl
Date:   Fri, 23 Dec 2022 02:10:18 +0000
Message-Id: <20221223021025.1646636-12-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221223021025.1646636-1-bryan.odonoghue@linaro.org>
References: <20221223021025.1646636-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add silicon specific compatible qcom,msm8953-dsi-ctrl to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for msm8953 against the yaml documentation.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 32349174c4bd9..acbe100d9b5be 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -797,7 +797,7 @@ mdp5_intf2_out: endpoint {
 			};
 
 			dsi0: dsi@1a94000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,msm8953-dsi-ctrl", "qcom,mdss-dsi-ctrl";
 				reg = <0x1a94000 0x400>;
 				reg-names = "dsi_ctrl";
 
@@ -867,7 +867,7 @@ dsi0_phy: phy@1a94400 {
 			};
 
 			dsi1: dsi@1a96000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,msm8953-dsi-ctrl", "qcom,mdss-dsi-ctrl";
 				reg = <0x1a96000 0x400>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

