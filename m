Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163B7713748
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 02:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjE1AK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 20:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjE1AKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 20:10:53 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD565113;
        Sat, 27 May 2023 17:10:50 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f80cd74c63so20798821cf.3;
        Sat, 27 May 2023 17:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685232650; x=1687824650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlLPGYxNqRLcO0iwNntzpwA4a9ygAShxKuuHe4rrdxY=;
        b=O8OBZDfJldx3WjGaMSWA209tbN2ud5V/ZxpbdgnY06AL5QkHNzuDKshoDnTm4UGSha
         8wrfuCpJdfMbi/ii+ZrcaRuHfhb1sjs/4e2OgIPT2Lwxq/Dd2KTfIuz23bXEHCvPt/KY
         g1pJoDlxPNDNo1rLwgLjjA3twk6gS4QpNls3xiF2Uc5ZaKDnUCMtRUPigtNLt+L04hl7
         ssgg68y+CtGn3IiMXAqYW6THuxpwwK22EXPW4tSo7dCR8HCnNKDfY6ZSpkz5Aih7DcDr
         rOgjw71PXUhLVR003yNrUqp+aEpMbkT70jAYuUvYiPrGtZB45AygoC+qnV19sp/PEsrk
         iFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685232650; x=1687824650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlLPGYxNqRLcO0iwNntzpwA4a9ygAShxKuuHe4rrdxY=;
        b=OhxmMi1NB3AAYBZn0L9oEyFYOpz3hoz0ZV7XBgv7i5+mWhgK8xkHHdWzfhwL+1Ptl9
         rgaQ5SaryC129BWYHGhcpG1bHJneeajCiI8yYUHe09963drGkwunVxrUIbsonqLliI4a
         YeCA5imvEypQgsDfO3brRzvXBBqXEy3dwjHhmbPWQYFsbn+C/Bse4MvivGfWtTAC3oUH
         7hF8BBEyVtjxVbcLPGT+JIEL/sjENfyABcT6uE8cvqTPaORAvWNjRs7W1heTtblM69Ii
         /l5CswUYAQ4wJviSiRFSeXb057emf9Jrp3N1vv9+2TZuS1W+VPf1z3lEntimkwdzukp+
         9L2w==
X-Gm-Message-State: AC+VfDxhQQADSeXWZe5XrzppYVpQpwcQjjW7OzJeuG1PYiPoUMq1FLFf
        /G7+SELm6jdBQGrbWWNEkaw=
X-Google-Smtp-Source: ACHHUZ48t/aUfi2p8Ea4j28BZnaKxNFrtgKFnDSLOZlkMiUl6JjTR/leIIiFiv0of4//m3yyejA/mg==
X-Received: by 2002:ac8:5811:0:b0:3f5:1f9c:5b35 with SMTP id g17-20020ac85811000000b003f51f9c5b35mr5909777qtg.63.1685232649723;
        Sat, 27 May 2023 17:10:49 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:28b2:2867:6311:b7d0])
        by smtp.gmail.com with ESMTPSA id t18-20020ac865d2000000b003f6a7ab1450sm2518454qto.30.2023.05.27.17.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 17:10:49 -0700 (PDT)
From:   Rudraksha Gupta <guptarud@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rudraksha Gupta <guptarud@gmail.com>
Subject: [PATCH v2 2/4] dt-bindings: Add qcom,usb-hs-phy-msm8960
Date:   Sat, 27 May 2023 20:10:07 -0400
Message-Id: <20230528001010.47868-3-guptarud@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230527040905.stmnoshkdqgiaex6@ripper>
References: <20230527040905.stmnoshkdqgiaex6@ripper>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds qcom,usb-hs-phy-msm8960 compatible

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
index aa97478dd016..6309c8e9d0b0 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
@@ -40,6 +40,7 @@ properties:
           - qcom,usb-hs-phy-apq8064
           - qcom,usb-hs-phy-msm8226
           - qcom,usb-hs-phy-msm8916
+          - qcom,usb-hs-phy-msm8960
           - qcom,usb-hs-phy-msm8974
       - const: qcom,usb-hs-phy
 
-- 
2.34.1

