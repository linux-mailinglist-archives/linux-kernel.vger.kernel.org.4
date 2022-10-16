Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9066001CD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiJPRDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJPRCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:02:53 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B743913C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:13 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id i12so6268806qvs.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTMl2+XQJgPvX0+G4LvEbz7FpuBsUNstSWfbNW6//dY=;
        b=B3ZerCYVISjPAWzyPiEQ5AwAqgX2ynLVeV+XIPCdh/F/jNaj1uiFPl93NqV/OXfXhk
         N9UVE1v2hnoEsigCEMnOabRtKQTJt41gICXsbDp8QPVYfs/PNyL4KFOcGrHmdMPezKP8
         WPbD4x1fEh3AhDyup7E+6crkbOrQWH2XZtFtDLUj1ytwstXxvOPAqOlYHOj0WALas6tY
         FBh+j8HsIojVpP0HyWk8rU6aZuhFskCfkhrmG1AHmJZkIZXc7a7QVAoA0NSTUBFISoJ0
         iwQoJrU/Oi2nacczUMLT3znu+BM7QOdQrxiIC1CH4Oe+5bMQFBGRvP/5zMXIpIFiH3jj
         vsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTMl2+XQJgPvX0+G4LvEbz7FpuBsUNstSWfbNW6//dY=;
        b=y40AP//XedqMYzqbqLn3nlOvWYTd1ZZb4JjJ/vWDONf8OCzQVWrL8bOxly738ObS0w
         rA7hVcFX50mAprbDaBhS679ah3uXisrUp3nalDnm1eM91HnPiOe7Ok7UVkldqt0SWcKO
         2lchInx0dnM65sWrRLbosR3zTSQXijHXHn/4PtFj3920YjvMCo4h+j2E/OK3dLIuPdZk
         suVMM8fk78/9KwKoRoiStHHLpKRN7nl9hmgVtRF0m6NSNfiE9D5R4jjjVdLOGpw6teX6
         SMTi/gUfp7sAq0+BkqBeDQIR5U/hjIyMLJnbIvq5k8vgIiSbA4jOhjSb3mNoHVrBJrYT
         ZjoA==
X-Gm-Message-State: ACrzQf2bKC9foWePzzY//JR2ewV/BWgZjWAbm9pi2xH7MUmOCcwByJH4
        gcLl6jfjueo83a5i+cM3Ke2f1g==
X-Google-Smtp-Source: AMsMyM7upk90rxEnRz5MsGmYm2MpY2Ccq1XPQGAIdzW/r8s4oAl1rXrzdYQGc2JmLBIqhpGqMjfvEw==
X-Received: by 2002:a05:6214:5088:b0:4b1:bf18:9212 with SMTP id kk8-20020a056214508800b004b1bf189212mr5776095qvb.108.1665939732868;
        Sun, 16 Oct 2022 10:02:12 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006ce7bb8518bsm7539967qkl.5.2022.10.16.10.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:02:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 19/34] dt-bindings: pinctrl: qcom,msm8909-tlmm: do not require function on non-GPIOs
Date:   Sun, 16 Oct 2022 13:00:20 -0400
Message-Id: <20221016170035.35014-20-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
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

Certain pins, like SDcard related, do not have functions and such should
not be required.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
index b1735918fa90..08e2dd5cbebe 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
@@ -113,7 +113,6 @@ $defs:
 
     required:
       - pins
-      - function
 
     additionalProperties: false
 
-- 
2.34.1

