Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232BF72360C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 06:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjFFEGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 00:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjFFEFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 00:05:55 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7953E40;
        Mon,  5 Jun 2023 21:05:53 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f767eec104so54949751cf.1;
        Mon, 05 Jun 2023 21:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686024353; x=1688616353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kT0moiiobscuB0+NsDGuf/3XRp74J+Z+JV9UAE5BGPo=;
        b=OKQ/uXf9JJggxqFYM381S1YpMl5oMCXwRkIIQCP56TCZKw3J7MxAZx5gk6kHbvpyJE
         GdNOg1HWKFVAhGBRwre3MZKpSzbyyi5lRu5+Cc3TpGV4B6uF0verXrao0AoLb20u/+bZ
         361O3Q7fW0e/xUTL0PClQLK+XBnagwxjMmThespktOkXbh6gidNU8XOb2BEnDLfnkIqM
         bvhjLDeWWzzmGae+f8J0i0sga4dM7hThrVRL+A7XqVCg4C75PX36TMdoMf5lSwg9oHCb
         r2Hw4d2M+GZp+6DWVDzhy2lAwvyMSOwfqKIQTMGETBO8cehcELWGaLOQh4AeTDxTca83
         zOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686024353; x=1688616353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kT0moiiobscuB0+NsDGuf/3XRp74J+Z+JV9UAE5BGPo=;
        b=WZqnwOWsiWI30Sl4ixDCa6mSVF7C4s7xGnRU46K9isxla2FpsPITsWhkn5fAyWHz3H
         9wMYbjOFbTmXipBmyqB7FGxjFUSUnLLa66HlkBQte2UM8VJi2apFaCpYcM4Zlo/TDVbA
         d4UVq+ttthgigjQm7vxsXLPZ4jYxL81k4X85c5POBtnTS6sMl98BJezxaIhkuK35Dd8j
         ci8PG3p9AViBZRRMKLpCW7SQjKbeBWvltzs/5FoPOr3E7dqkdfhwOOFms7vsZrBIvuJQ
         TUegDz1Ff7v/S1QYe1Sg9ehjWnCEJ/Ri4exrN14KhfDtwG62oBpxrGTlwvOP/caPTiDs
         AkMQ==
X-Gm-Message-State: AC+VfDwrkjlqwbpApilUIi7gsqilCBeLfB8ohFbPSYWuBJuYFfSWK/5+
        +zZK2rEkOkma/sonzMqiZug=
X-Google-Smtp-Source: ACHHUZ7F7AbVrX/UOcT19MIL6WBTFBpTWsjGYcUZEY36uwH1cqqPWN7oyyxvyVw4oDoQxZFPNs5Hlw==
X-Received: by 2002:ac8:7f07:0:b0:3f9:af04:e9e5 with SMTP id f7-20020ac87f07000000b003f9af04e9e5mr743482qtk.57.1686024352689;
        Mon, 05 Jun 2023 21:05:52 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:aac8:d62:35cc:958c])
        by smtp.gmail.com with ESMTPSA id e2-20020ac84b42000000b003e388264753sm382980qts.65.2023.06.05.21.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 21:05:52 -0700 (PDT)
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
Cc:     Rudraksha Gupta <guptarud@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/4] dt-bindings: phy: qcom,usb-hs-phy: Add compatible
Date:   Tue,  6 Jun 2023 00:05:25 -0400
Message-Id: <20230606040529.122433-3-guptarud@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606040529.122433-1-guptarud@gmail.com>
References: <20230606040529.122433-1-guptarud@gmail.com>
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
 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
index aa97478dd016..bdeffb52340b 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
@@ -13,7 +13,9 @@ if:
   properties:
     compatible:
       contains:
-        const: qcom,usb-hs-phy-apq8064
+        anyOf:
+          - const: qcom,usb-hs-phy-apq8064
+          - const: qcom,usb-hs-phy-msm8960
 then:
   properties:
     resets:
@@ -40,6 +42,7 @@ properties:
           - qcom,usb-hs-phy-apq8064
           - qcom,usb-hs-phy-msm8226
           - qcom,usb-hs-phy-msm8916
+          - qcom,usb-hs-phy-msm8960
           - qcom,usb-hs-phy-msm8974
       - const: qcom,usb-hs-phy
 
-- 
2.34.1

