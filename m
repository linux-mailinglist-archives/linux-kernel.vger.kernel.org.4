Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8895F655D00
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 12:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiLYL6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 06:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiLYL6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 06:58:50 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5992709
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:58:49 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id o6so12891352lfi.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yC00rd5T02wIJphR43PoEyeNsBoek3d63T6Rp4jCNKc=;
        b=toFKYB79ijRWHbuF1t13TgEAxY03wX6AYgM7h7YkAd1p5xp9278Po+xKWJDMVMFLZ5
         tRc8upmWrhpJn/CEI9SjuGf1P8Yno/XC5VXQ/qFp+F9XW/qFXcRyJ13Yf3Fg6qQnLQtY
         NCFajW0ctQ1SN54x7635+NnT9SSQBdbfzByiFMOBBDhp6gft5E0/BB1bm0NPFae2fS1d
         EL+B1les0HQRYiXDMHRLgD8uMMw1w64G6Q9c9gfgtBN+Rwb2fNjSUX9VLqor5kCeV6y+
         atflFPlJ2tcRH87YVE1sKr5+X6fT59Aj+WWiiaaajcRd1rBXk8f6PzjJZ8fnjNHQRlrp
         2chQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yC00rd5T02wIJphR43PoEyeNsBoek3d63T6Rp4jCNKc=;
        b=q24aJ2434ZrG34K3l0ojIxphoR/PYO6mMrpz/GUkda68S2xmmoOEV0FoArceiJjKIK
         ykul0YGxNzXClzByjVkAJu1nuFaMEOsk8Tgs3iCe6n+h1TT6KXak6Zu7MzkoR4QjD7fD
         4o7I3k7hXTEU2aYY7FT/G97Ar33zEL23/cHuefRcxnBxNQWXu4SkgsFKLdbixtg0Wf6R
         GSoqPYTV7HPiHmS4CyLMCjtYd7P0Wl4p2FsEMiYiThYX4plJPK4H9ITdsBmONtCb+e20
         Yqj9IHEpSe+sdfXsonoWKZINQ7a+7xGOs41aE5CX1XK0Kiknj9MKuVS4tgIcTCVb6d5a
         ea2w==
X-Gm-Message-State: AFqh2koAysIKuXNDEPO5qNuWD0wQ/2+cfifQu9z4Mx3GvPR1QR7IQwUd
        76SO+MGFvr/nNn4ABLCM/eLfzw==
X-Google-Smtp-Source: AMrXdXv9YS3mr7UwwKAyhljjzSi64Kc3pVInM8cgvLBbg4QbXq8ffeKk7QodSOso3WwjODgWXhwWqw==
X-Received: by 2002:a05:6512:3c89:b0:4b6:fddc:1fcd with SMTP id h9-20020a0565123c8900b004b6fddc1fcdmr6385022lfv.23.1671969527736;
        Sun, 25 Dec 2022 03:58:47 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c1-20020ac25301000000b004b5901b8011sm1318141lfh.105.2022.12.25.03.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 03:58:47 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] ARM: dts: qcom: align OPP table node name with DT schema
Date:   Sun, 25 Dec 2022 12:58:41 +0100
Message-Id: <20221225115844.55126-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Bindings expect OPP tables to start with "opp-table".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 2 +-
 arch/arm/boot/dts/qcom-sdx65.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 5408ff715fbf..c64088c12c89 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -62,7 +62,7 @@ cpu0: cpu@0 {
 		};
 	};
 
-	cpu_opp_table: cpu-opp-table {
+	cpu_opp_table: opp-table-cpu {
 		compatible = "operating-points-v2";
 		opp-shared;
 
diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index d3c661d7650d..aa6439d8763a 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -61,7 +61,7 @@ cpu0: cpu@0 {
 		};
 	};
 
-	cpu_opp_table: cpu-opp-table {
+	cpu_opp_table: opp-table-cpu {
 		compatible = "operating-points-v2";
 		opp-shared;
 
-- 
2.34.1

