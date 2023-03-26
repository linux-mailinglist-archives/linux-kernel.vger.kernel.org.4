Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C848D6C9667
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjCZP6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjCZP6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:58:01 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEE11BF9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:58:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ek18so26239038edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679846278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9WvnPAgAHl6edUhSeAcvcQ642icv2hUvz+uOkSRs7c=;
        b=s7+0wQpSRbaBqIrCT3t/Ihmc6e+aWJpXPkH7RPZEyF+gbHTRRfLWIf3kQs7D4kxq1v
         CdhinzmiXoae+DMppOthmHWOYloqx6bABC2ytC1ZQ8FCqiKWgLlBR0MZNKKEsgmVBTb+
         jqbWdS8MZX2LHaXVTKQQJ3lQbZkMBLspLcgVeK4adDwbO/PPGZOzFf2g8JoxhEbqnbcX
         v02O5ko4ju7sBJeolBGPhcs/qbKYxxveXdUSSqTjGtQq8ithdO11M76s0cL/WyD1Ob8I
         h6vg/rNCZHoPGAzHTgNujvuRtY+sZ/bH2a/XjfnHUO2OLUzRsDiezV9ZVgqgpTkCIotT
         FlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679846278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9WvnPAgAHl6edUhSeAcvcQ642icv2hUvz+uOkSRs7c=;
        b=XssiKR/Eag0lkisdQHIHVne/lSC31WaBIwrUF/eojHlohOs2cgE6uHRpRvhSveqGBE
         1EHc/W/VUf04SMpeAohyftT/MkBDs2tYyBI/xDmjBK9A4gUSSgrYpTkL3EDcCRFBhXa8
         zX6JXz+6vLadp+7qqQZoSwl4rNv34DyXGqCwc5QthtiTNNpLOsR13FkTHjG4I/7VnMQX
         lHwPlr0NV/0f/n0q5FSXIHrpSz6coK6Rm//KlSQZH6EU2gg8c16emShXsgH0WJWfQgXu
         XndjEAEYDlaGZBRk7jG/zqbWTQfSTqy0hjqrOdPUCCiOVWRK2Xn4RSRgFB2huKxL/9Wm
         8FKQ==
X-Gm-Message-State: AAQBX9fWKcEnHOlNi440ggo418MZzrW+lJIUN9QpjLdMQQ4Uq77mrOWB
        krXgUbVmxA7zbAb3RNeTSKrBSQ==
X-Google-Smtp-Source: AKy350b8fdV8v72bDhJSRxn5kYBYjgnSTln+jQ0VUpRQxMgPgMkMdk/NnBPBSS7O4WQqBwdPtx41kg==
X-Received: by 2002:aa7:d052:0:b0:4fb:999:e052 with SMTP id n18-20020aa7d052000000b004fb0999e052mr8652261edo.33.1679846278852;
        Sun, 26 Mar 2023 08:57:58 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:eca3:3b8f:823b:2669])
        by smtp.gmail.com with ESMTPSA id q3-20020a50cc83000000b004fc86fcc4b3sm13705502edi.80.2023.03.26.08.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 08:57:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 03/11] arm64: dts: qcom: sc8280xp-crd: use just "port" in panel
Date:   Sun, 26 Mar 2023 17:57:45 +0200
Message-Id: <20230326155753.92007-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230326155753.92007-1-krzysztof.kozlowski@linaro.org>
References: <20230326155753.92007-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel bindings expect to have only one port, thus they do not allow
to use "ports" node:

  sc8280xp-crd.dtb: panel: 'ports' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index d7b537284990..6b4e1541ee39 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -413,11 +413,9 @@ panel {
 
 			backlight = <&backlight>;
 
-			ports {
-				port {
-					edp_panel_in: endpoint {
-						remote-endpoint = <&mdss0_dp3_out>;
-					};
+			port {
+				edp_panel_in: endpoint {
+					remote-endpoint = <&mdss0_dp3_out>;
 				};
 			};
 		};
-- 
2.34.1

