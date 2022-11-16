Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C992762BC7B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiKPLtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238393AbiKPLsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:48:53 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE4C23E94
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:35:42 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so2671499wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S+UI06IPOgRMVIESi3GLzjOf40d1AmEV9uLkRiNjtuo=;
        b=A9czFxYmv+BrypnMBUkyh8Km4vBg5EYc3a+R5rTDIjUWdBLVYgfLfl2c7zq0YzPk9E
         bJO3PXnpIcJR8mgyRCG7qu11VLmwZSGpge6Z5EdDsLxiSZPsnZTnGwymBG5rLxV8ldUm
         M0+gWt/po+z4FURRmoiiTwgNFWbRCl72xqC4TnW854oz5Laz9XNI0vmzs+BNWe+lrefi
         m9Sz9mTuNAiNyHKK1qBZevAf+STycNiQc/B3D1tMbps4cpKDetViziShfm9ABDKueIVZ
         uar0sCJOQXNDwqQHBdKHvhnw6ggRF9S2lGpsW6Op1ecj+kK0f3aNVWOpEX3yybH2HwKU
         Xt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S+UI06IPOgRMVIESi3GLzjOf40d1AmEV9uLkRiNjtuo=;
        b=SMVx/Agfj2c9v+9PI5WPtwtqQrppfhuOHeY2kHREFCvssuZpkhpgD9S9STERQ0jqBS
         hdc/N/HTkUJVCkbQTLWfu1D6AIL71qzcAaXUmqxZSVSDuKuVWnMlWF+aBBJQFy368pym
         H1Urx5nerUVspKC/ev5ltB3olwD90CCNChsIxBt2AzwKeEh9WmW23zXCUkiN1N7s+Dzi
         lnWIhLAxGO+jhJb6uiASrIPO09f3p8bWPBtfzlO4XGwWJwSQTe/oRcWx88i+r6r6XQ6w
         yCrvc65K6hpM3utjYIB+pQhOyoP3gZcvwGZLUHBUc1nsSpFemF0BQ+hRQgnM+ccOyqFN
         shJQ==
X-Gm-Message-State: ANoB5pkPR+p4UxR2obEYfq+/nmaeEEibNb3ObSsdVB/fAXX+L0XvWAF2
        XNRTMv89tSoxAswQKVqzG+tAlQ==
X-Google-Smtp-Source: AA0mqf6Rixak2ZCNitFJXBnK2HRRKmAOj5RoEvpudtMQVbDetXo+M4SVJ3/FSuwo5CQh5LGPHI2VQw==
X-Received: by 2002:a1c:7c15:0:b0:3cf:a85d:2ab2 with SMTP id x21-20020a1c7c15000000b003cfa85d2ab2mr1851326wmc.43.1668598541441;
        Wed, 16 Nov 2022 03:35:41 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id f23-20020a1c6a17000000b003c65c9a36dfsm1665325wmc.48.2022.11.16.03.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:35:41 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] dt-bindings: mailbox: qcom-ipcc: Add compatible for SM8550
Date:   Wed, 16 Nov 2022 13:34:57 +0200
Message-Id: <20221116113457.2660792-1-abel.vesa@linaro.org>
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

Document the compatible for SM8550 mailbox.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index baca4786ff94..0e0706ad2cb0 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@ -29,6 +29,7 @@ properties:
           - qcom,sm8250-ipcc
           - qcom,sm8350-ipcc
           - qcom,sm8450-ipcc
+          - qcom,sm8550-ipcc
           - qcom,sc7280-ipcc
       - const: qcom,ipcc
 
-- 
2.34.1

