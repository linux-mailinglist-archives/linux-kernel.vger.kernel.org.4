Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788C370299C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240845AbjEOJyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239397AbjEOJxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:53:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FFC2102
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:53:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30644c18072so8243811f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684144396; x=1686736396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNxrM+uJIOPJIXwlJJ9sHgzIu9CPqpz39STaOJXSb7w=;
        b=DkGvC8mVh8oZADE18D21T9SvV6J/mZ02Tdnt5MvTcg/fdtFDB/HSJ56UEPUxKiSEzB
         goX9v6WIEirJicxwc/ut8wg/2DE58hU5V6QygpcridmbSq4VJAip//exqYuH/718enpR
         nOLsnMz8G10gwGVjZhHyyTN2lYhdb1t4JC/yot3jFTEpNgHxx4s1Q351r7E8vuDQ1Mpm
         xp1Zhh8fLhKH8INlpKsvsHyvuWEyEcnslfy3dWQYyic0HdGGeBJkaRvT1gxwUw7D/xcI
         WUMqzfEJYUkwtKEVfRRgj544vCDB304mGIDDlDbDBb7v/pNYhtGPwS0OjHoqVT/wazuk
         I/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684144396; x=1686736396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNxrM+uJIOPJIXwlJJ9sHgzIu9CPqpz39STaOJXSb7w=;
        b=DIkhLAS5HkVo1eCX7A26qgH7NInL75nTVdcgn0A3rTGR+/uZ1PRX2GFaXrfeGWFpks
         1IJupq80mzD9t/XydqbwE697jRaEOrZ+mO8TKaIBoAEc1RxS+3LfW4MU7cOQ6UUU7rWK
         6bg2HCw98GaNlzuvTTQ6cXceBIoLsDBpjFXs7AFFbxgsJ00FzrZqahDE01QZRfSTxDH2
         qsi+mBY9qLb2MC6Z0eg9I1Did0fuQH2Z3PfFWnGSY49ovNa5G7QBgx6MlYf89r9zyU7k
         GQohK2UrbyCC6DJJMaMU23jrleNEH0ViJTb21zY/SgHvaGzP5gk1rx4Xi23tn9Hre7V5
         SX0w==
X-Gm-Message-State: AC+VfDwjK50avgnhivfQS/BMxp4szjrVg9iLHxJ3KmvGS4KaF/SMk+Xp
        SaVSlg+fWrHYAklAHTrNbWfpfg==
X-Google-Smtp-Source: ACHHUZ63GBwkSLkmbOUIKbESa7bur7CEitR+NrF25bkHcdMP2Uyf2zY8CPZ2R36wcq8afF6leYpqwQ==
X-Received: by 2002:a05:6000:1370:b0:307:a2bd:5bd5 with SMTP id q16-20020a056000137000b00307a2bd5bd5mr15311892wrz.44.1684144396297;
        Mon, 15 May 2023 02:53:16 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1388:9f6:c7d9:3b77])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600000cc00b0030795b2be15sm24228443wrx.103.2023.05.15.02.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 02:53:15 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/3] dt-bindings: ufs: qcom: add compatible for sa8775p
Date:   Mon, 15 May 2023 11:53:06 +0200
Message-Id: <20230515095308.183424-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515095308.183424-1-brgl@bgdev.pl>
References: <20230515095308.183424-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the compatible string for the UFS on sa8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index c5a06c048389..b1c00424c2b0 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -26,6 +26,7 @@ properties:
           - qcom,msm8994-ufshc
           - qcom,msm8996-ufshc
           - qcom,msm8998-ufshc
+          - qcom,sa8775p-ufshc
           - qcom,sc8280xp-ufshc
           - qcom,sdm845-ufshc
           - qcom,sm6350-ufshc
@@ -105,6 +106,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8998-ufshc
+              - qcom,sa8775p-ufshc
               - qcom,sc8280xp-ufshc
               - qcom,sm8250-ufshc
               - qcom,sm8350-ufshc
-- 
2.39.2

