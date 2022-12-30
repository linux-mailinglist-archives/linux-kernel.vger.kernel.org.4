Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B5A659927
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbiL3N53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiL3N5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:57:00 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E20B1B9E2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:56:54 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bq39so24043226lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8C21JgsRq8We33ogBeV/rQDmgY9/P+1Xx2T/At689kg=;
        b=IN8DRvlV6Jjl78NZmV4AMKXYG800BnDrcicSTXybaOdQEqsWGMuJc0s7Vwj4T7ejzI
         Zfvg7FEEjdX0VKZErRGJFNQ9K5MbcI4IdDCD36aZ96UTkFEzcpZzeSi+nwL0g/dcSHgz
         RZpMf76/T8v+xT2KwR/86o3wnhzxB/qp0tGuoBKtIvHiH4un9AHlK8b26SrvwANfDGUN
         Lihpse71gFre/3D+rkgjVl5buw9fmtfjGqgj95m/Cf8DaqR0KZMnsLbgxXZkUqikeWNz
         dziRnup4CqfhDLa1m/Yhodk8HGR3n5F+V6dZ7ToTWHDW0Y9/9SX6m979D6oc26wIAJxW
         vlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8C21JgsRq8We33ogBeV/rQDmgY9/P+1Xx2T/At689kg=;
        b=E4Nz+STiCDX8WyRImp77O+dCSi3HlOnjk8bsLYDCbh1i6b3j5DQkQ3aVXPyBYy8bJW
         FFvJLezVbg2r1KCeJ7kS7itdL7s9sP9MA7e+6gBSqhiYsHYgl35WHl4eeWnPE9FYbFDQ
         GXs2qnUsUF+jL8Kyo1J3qVwVdeJjy+0jV5HbCRkVENzxJRbtsPJAlZhBt8EIHYvnexb0
         Bj+2++UqSVq+c+zghEayqO9dcc06akC0RQ2hBbrt+zdE6AtLNSrdZQwA7TzSlqrk7Luk
         OYZwwEXQdV1GnqOPS0Uw3Mh3cFW5fH6o3NxpODVZwmkXvXf/kNPTYGblmnyAeinROLLO
         agcA==
X-Gm-Message-State: AFqh2kqVBtpfMsni+FxzyT3yzxTsgQhPTOs189JlPDztdgwu8c+ytXsc
        fK/oSR3pxnEng22W/aATuGLGpw==
X-Google-Smtp-Source: AMrXdXvkfzbEdlKGGdIinYHLSkuZwfN32ix2T6HU7RmtFfmh9gy6uHd22GyKKCQPeP+4Dcl3dU7aXA==
X-Received: by 2002:a05:6512:79:b0:4b5:43ef:a555 with SMTP id i25-20020a056512007900b004b543efa555mr8984284lfo.69.1672408613855;
        Fri, 30 Dec 2022 05:56:53 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d9-20020a056512368900b004a26ba3458fsm3454787lfs.62.2022.12.30.05.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 05:56:53 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/9] dt-bindings: pinctrl: qcom,sm6350-tlmm: correct pins pattern
Date:   Fri, 30 Dec 2022 14:56:41 +0100
Message-Id: <20221230135645.56401-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
References: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
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

SM6350 TLMM pin controller has GPIOs 0-155.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml
index b099649e58f7..39f3ec5b7187 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml
@@ -68,7 +68,7 @@ $defs:
           subnode.
         items:
           oneOf:
-            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9]|15[0-7])$"
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9]|15[0-5])$"
             - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk, sdc2_cmd, sdc2_data ]
         minItems: 1
         maxItems: 36
-- 
2.34.1

