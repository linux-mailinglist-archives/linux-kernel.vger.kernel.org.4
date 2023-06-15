Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E83C7318AF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344890AbjFOMQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344811AbjFOMPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:15:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034382729
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:15:03 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f8c74af64fso17308125e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686831301; x=1689423301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVlJCvybdeYjvv8ryzmcQEkNwtr78sKz5e8xX8tuWYs=;
        b=VtZQthxXkJ6Gl3Gr0Rxhxkj4r7xw8xSfqcyo9Ro9BTEa73QgC5ovx5U8VkkMLcJFIT
         dOOekEovMOtoZ7L5ZHlpSTlLUk0AXaEd3ozCrfIK3bZ8wMuapEV4saO+zeZ2vz1MEjxl
         nRTNWBc8b48QbHDddC/7qEExOcUIAe8i2thkfeIzzQwjXqroTLFDoGb1jpHWjTGQ3ytO
         z1VEcPtNOi/O9Yi8JqETNIHYJ262elgduM1jcv0VLPk9QGlmYs48fY4aMnx5KyJ6lPWb
         51Zs6aJ8EuAUBbzhlgigq7j57hfdcnfwCViI9jPL3AaeVeboRN0uGYzOmD/rrzwBsw7N
         kASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686831301; x=1689423301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVlJCvybdeYjvv8ryzmcQEkNwtr78sKz5e8xX8tuWYs=;
        b=emKKxB7tbOSoEcQMAlQJka1wGTmy90VD8QlN+apLoKls1wytQXUfZ6iK91mxWYB09j
         6jJhWp1Teb/gYLuhdGx3mRSkW1o2GRk9F+7UOMt0/3y5bN1cCMjLVAoEpd7mNs15BRIa
         U/ukd57mH6vuhjB5bbkdzPsBvYe5pBiWEmiHOLzdwrbWz5PqqjQvS47Dj/sBKGmRMGLG
         3aBJEAcTW363W8G5SeKzhkJwOviZfu3lExTsqZ2QQGyHC85K9mHbYq9Fzi0PLHDhwqLx
         kOUqZDc1Hm+Kb4q+GgTLGNluLq2kL131/IjsBrWQgSmw1dz+LzsZm2ldjoSRLk8pYwDg
         GBFg==
X-Gm-Message-State: AC+VfDzbK94Bm8sAw4Oo+ri1PVEGVzscoS0J7K2fCiRF/T8zvLYjrfjs
        ioo/p9HLVAtKwgdaLpbk84o06g==
X-Google-Smtp-Source: ACHHUZ5fGl2Bmi5j9EaSiuWzDcHUl/220qF10Rg89YYxqATkMANkXIIxOxpidvYKUgDJ7K0JFIeqiA==
X-Received: by 2002:a1c:7213:0:b0:3f7:2638:9691 with SMTP id n19-20020a1c7213000000b003f726389691mr13309387wmc.41.1686831301121;
        Thu, 15 Jun 2023 05:15:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2ad4:65a7:d9f3:a64e])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d4291000000b003047ea78b42sm20918012wrq.43.2023.06.15.05.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 05:15:00 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 21/23] arm64: dts: qcom: sa8775p-ride: enable the SerDes PHY
Date:   Thu, 15 Jun 2023 14:14:17 +0200
Message-Id: <20230615121419.175862-22-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615121419.175862-1-brgl@bgdev.pl>
References: <20230615121419.175862-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the internal PHY on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index ab767cfa51ff..9f39ab59c283 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -355,6 +355,11 @@ &qupv3_id_2 {
 	status = "okay";
 };
 
+&serdes0 {
+	phy-supply = <&vreg_l5a>;
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32764>;
 };
-- 
2.39.2

