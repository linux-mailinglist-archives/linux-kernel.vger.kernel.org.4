Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA585F66C1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiJFMtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiJFMsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:48:39 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89513A347C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:47:42 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y5so2547187lfl.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/EE1Ip8I+ofqDBVJqXho2Z/r0isQpGAos6HBYPM6Nis=;
        b=cUTFviL34cqGc/X2o4VkCi7T9e6Qf86CPkkX3daR1ENPwefXS0rY+jaMY2zBFRChPz
         MWYhX1SReZ00V9GH0/cXBacnFCtdrd00dAScXNXb6lS7VBngEUPqdd2W8fXBK1dD6+Ck
         Z7b/N6ImxOUVBb1QJu8VmlNh5A8xOOa7xVpnIiImxexumD6wyKIM0I7l12vSPbIc/uLX
         K8hsWFlmxwEe1lleb/Qkmtd7PQCXzKqi2Lm/l87c9Hehwb4xGBcRZdm+LOlKH2ImmF+m
         aRL65CSBfVXISa/IyJ9IFtv9bV5q5+bzHSmbHOZQFrlpZYrirCn32/8JiH5ESlXuu4D+
         OhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/EE1Ip8I+ofqDBVJqXho2Z/r0isQpGAos6HBYPM6Nis=;
        b=Huy9FElgTjdTAgzRzggYH2sTl6DeAygUFduiLf/lNKmLMV4rz3wc3YC2Ef1Hs2mZRF
         WrovPdoN+0OsPcgsLt3qMgJ6kvw1dEmwUDEY0GSC6pJ0iq6CUV3O5OFK5xmRS8psHdiG
         0p1V2kZpDvioIPi9hBpkhFE2i7zJhOFJZwQJuFgLSKHqw09iZSWb/EPlSmS5WanfA8G9
         KSSqHRaRpdj2KCdqZorItHBk+K/YndSAdFMkcWlJNDAGKR7s6s11xApTfF7g7ewvxb7x
         QQr/k0pGnYvXj4T9Sp2cNEVbG9EpvIQn2Rt/+0/aaHM6au2FlO/FVNQz6kBYi2GJNRzS
         5h9g==
X-Gm-Message-State: ACrzQf2Z3B8AxSSeI1S3C4ThWdCJ/ZAlhsDBeB+U+o/Kz2lfkiLukAMz
        2TG7djPPA7r2t8LKzbTBtniq4g==
X-Google-Smtp-Source: AMsMyM5QdUCRf1dx57oNE0IpLCbEpeqWOA3YeMPuLuwB73SLXGQpFF28XyOQrYeamDNU8b+Q9+PE+g==
X-Received: by 2002:a19:5047:0:b0:4a2:5c53:8b5d with SMTP id z7-20020a195047000000b004a25c538b5dmr1917545lfj.453.1665060461734;
        Thu, 06 Oct 2022 05:47:41 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b00497a3e2a191sm2687659lfb.112.2022.10.06.05.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:47:41 -0700 (PDT)
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
Subject: [PATCH v4 34/34] dt-bindings: pinctrl: qcom,sc8280xp: fix indentation in example (remaining piece)
Date:   Thu,  6 Oct 2022 14:46:59 +0200
Message-Id: <20221006124659.217540-35-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006124659.217540-1-krzysztof.kozlowski@linaro.org>
References: <20221006124659.217540-1-krzysztof.kozlowski@linaro.org>
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

Bindings example should be indented with 4-spaces.  Previous adjustment
missefd one spot.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
index b9ab130cd558..0b251caaebf2 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
@@ -139,8 +139,8 @@ examples:
         gpio-ranges = <&tlmm 0 0 230>;
 
         gpio-wo-subnode-state {
-                pins = "gpio1";
-                function = "gpio";
+            pins = "gpio1";
+            function = "gpio";
         };
 
         uart-w-subnodes-state {
-- 
2.34.1

