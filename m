Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80F1669B77
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjAMPJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjAMPH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:07:57 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B671983CD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:59:03 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id az20so33849241ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XU/dHO8DVmGPpqkb7r01X1pAdFG84fFdf1WtxGiiHvQ=;
        b=ARnoDLgerC10W1udjRPEt/GqBBzqwMsZyw7cRxy9pAmrdaWhWipPNrxDp8DBWRpYG+
         Iea+vxk4XoiUXFG//j9I13kfV+No6IlbMzurvbDOSa8gJIJ7jVIhkQwtRNZC2GtD/WQl
         79tRkeKdEqvkoIvDjk7Eg6qqOwqxqDhh3dkJHf/2TMxpGesmbtrczYR68uFVNXqOd7Mg
         9vvQ/zaF+WdZCC567si2DOhLTihqGrCKEIJ/GpoR+zyrxB4HLBzDz28JUWXMonFTufTi
         tzrEcMZoHzRylV3/dN2XRl+t+JSa6Mg/8+Cn18L2q7Lqr8VfmriCR0tI1KaRlhtW1+L0
         nZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XU/dHO8DVmGPpqkb7r01X1pAdFG84fFdf1WtxGiiHvQ=;
        b=waseYF/EB2xNqDmL8DFPHAyxooogqEccENzJ70BYfNreYR6ocxGLp0qDlMmgwq/yqS
         KQu4GclKvUZWED/oH2rtjpoYVXx/LNWkDd7FeRSLuEijFYs/44mV9Edjnv9NAn7TDRKd
         iC60Y/W7jIEX7temC6Ka3dM3lCHOfW1o5c0+kfLoMu6SlC10mpN6SOvyRKHRO28qEPCw
         Ov4xwl4LcNcAKiciJLObgM6kiNNepbrtkYEqf8enOyFCb4tzep3bV0MsLAKmHLr0A1vj
         +Kp9hK3ogR6Cek0kLwRCxR93nvwQyqy2tAhB6LqWQmzZK5jXX6tD30bEg2pbXSponEZU
         4nVw==
X-Gm-Message-State: AFqh2kq43uz2pfkYxJ6BJVpfKECJFrbmjY1RZ6Nk81oIj2oScpa3dHLw
        +vDZv1pF8wMxHL1d2Fw11Vr5Lw==
X-Google-Smtp-Source: AMrXdXvQMbq4TsL6YlyMhhJSIvA4tsjszzryU1CY+N0v6fsjTiGu3umfQ6d6YPAX7S+tZ+ikL7UVbw==
X-Received: by 2002:a17:906:2813:b0:7c0:f9ef:23a2 with SMTP id r19-20020a170906281300b007c0f9ef23a2mr84066794ejc.30.1673621942178;
        Fri, 13 Jan 2023 06:59:02 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090631c100b007aea1dc1840sm8621468ejf.111.2023.01.13.06.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 06:59:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: clock: qcom,a53pll: drop operating-points-v2
Date:   Fri, 13 Jan 2023 15:58:59 +0100
Message-Id: <20230113145859.82868-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The CPU PLL clock node does not use OPP tables (neither driver).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,a53pll.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
index 525ebaa93c85..6bf70af948d7 100644
--- a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
@@ -35,8 +35,6 @@ properties:
     items:
       - const: xo
 
-  operating-points-v2: true
-
 required:
   - compatible
   - reg
-- 
2.34.1

