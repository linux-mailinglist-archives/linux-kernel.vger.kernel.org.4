Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7860615EB8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiKBJC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiKBJCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:02:07 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB01286DE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 02:01:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso820163wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 02:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxLf9y7woLTGZWQ/1COhhq7B5uoXCRxWOXrKftkdqiQ=;
        b=o0jQjlRg6J1wa2XuGeOfg7m0FhkffKfSKeyrijbIT6CcU3cLCJC36MijXCtavSv/rs
         2UonvwClMLIB7600BObtqyeSQIhUQadwTl2NAETYRdr1n+1Zn9B167NAEA5I/03UibPW
         FL9POj/23RC/cy8/Ajhxc2rQXY1dW4N1lBbtfbYXeMCZtj1kSxv1WmlmHaZd4+vDdN4h
         wnz+2wNCDZFyIVy6hJLqoa9rGAiE4j/7KhoyplqlUfFXqjHmdYNh346LYRoJS3ENt+lE
         xKwT4CgwShnxpP5DkiiZwKQD1IQQdmuMmoEyor23uLhT+17F5LARZWo4qoSuU8dvQRWv
         t0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxLf9y7woLTGZWQ/1COhhq7B5uoXCRxWOXrKftkdqiQ=;
        b=vg7CsMUmNut1gSakqjVs1m9fQJ9tPGbf8vP4EyuHSQ8qYQdFx+NM6A5PjKOKEayGzW
         dhPejuuu34FoPJHF2b54WQbYjeW7UETJ8G4p4JgnwFrq9nbLKEvsmbdOkajBqDXn8U1D
         KQuRgaDhxm89uKcvceBOTvbuObxE18Yez89TnIW4nPqNCZSzP4qDLriT1mLZjXEx8SMV
         N0WjnpWICzh9m/gXJwKzzKZiD+5ogM5x/tasbvh+aqjMchzGT4Ow6AZZ1Sx+5Xl+bd4z
         PoW8aQTa+Jzfmv0horCVFIrTZuiUYGfeHlaNLoxglIzkKN33RZVWmqtbNcShlcZPdEKA
         U7Hg==
X-Gm-Message-State: ACrzQf1quXUZUBqwHKf5Lh3cgU+IvDk22UvtLIZiT45t3f270QgfpVAT
        WWcb2QDz5G4725KlPAp9g9cvMg==
X-Google-Smtp-Source: AMsMyM7ayCKvyTqjAq7DvFb+MHshBo/YCnHNBlGdn3Z+Y0m0ln+f+/26P0G06KW0+1GcKvzdo+i0Gw==
X-Received: by 2002:a05:600c:1987:b0:3c6:fd37:7776 with SMTP id t7-20020a05600c198700b003c6fd377776mr25389526wmq.72.1667379709992;
        Wed, 02 Nov 2022 02:01:49 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id bd26-20020a05600c1f1a00b003cf6c2f9513sm1425322wmb.2.2022.11.02.02.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:01:49 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        dmitry.baryshkov@linaro.org, Jonathan Marek <jonathan@marek.ca>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/5] dt-bindings: clock: dispcc-sm8250: Add EDP_LINK_DIV_CLK_SRC index
Date:   Wed,  2 Nov 2022 10:01:38 +0100
Message-Id: <20221102090140.965450-4-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102090140.965450-1-robert.foss@linaro.org>
References: <20221102090140.965450-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add this previously missing index, since it is supported by the SoCs
targeted by the dispcc-sm8250 driver.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/clock/qcom,dispcc-sm8250.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/qcom,dispcc-sm8250.h b/include/dt-bindings/clock/qcom,dispcc-sm8250.h
index ce001cbbc27f..767fdb27e514 100644
--- a/include/dt-bindings/clock/qcom,dispcc-sm8250.h
+++ b/include/dt-bindings/clock/qcom,dispcc-sm8250.h
@@ -64,6 +64,7 @@
 #define DISP_CC_MDSS_EDP_LINK_INTF_CLK		54
 #define DISP_CC_MDSS_EDP_PIXEL_CLK		55
 #define DISP_CC_MDSS_EDP_PIXEL_CLK_SRC		56
+#define DISP_CC_MDSS_EDP_LINK_DIV_CLK_SRC	57
 
 /* DISP_CC Reset */
 #define DISP_CC_MDSS_CORE_BCR			0
-- 
2.34.1

