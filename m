Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BA6725321
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjFGFAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbjFGFAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:00:39 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1558E198C;
        Tue,  6 Jun 2023 22:00:37 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-62b3b505961so23674706d6.3;
        Tue, 06 Jun 2023 22:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686114036; x=1688706036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InNCRBFCVMAHRg7WiAegvwd5G8nBYWhLOZCACH97Qks=;
        b=NjQQi6X5A0njTI5DDSxjm0LWsJUyKKR3vJn9jnNOMjq+JnQWy0citPCe7DoOZxbWg/
         jenX6DtpOzlBSu+C4vPZl+MQdwP5EzCHnLNU1bHv79xUm+4Rvj+U0koigf90P1B6RFvv
         imwFm8/60luDl6DYFGpko6+kWbk8o+ubeQF6vGgtljOc7bTAHjVuaMbT9Iipax0xH/Ze
         p88qsHXfLdaWgpjjiaU6Vkxm2xVv8AkaurWJeCFUgAinIPNmibHFHd7ZfFq/xwYXaJVE
         S3K+QibqojhUy00hTBT/rpieqZxAwrKAbNw8/VF1fGUrnASi/Lf86aKB59GFfeufKHWC
         cJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686114036; x=1688706036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InNCRBFCVMAHRg7WiAegvwd5G8nBYWhLOZCACH97Qks=;
        b=bSV5If4zb0AhsTTEFAcwHi6u2TUeHcyPBZXeFKd0mfy0gIMpQp/Z6yV6+RT3HsgSYG
         oQOP6DklS2MDLZlOtGIc/zJ/Zz0gPAdWaCE0UsV6ZEqz41XcNXzJi1SXnsfu1lkl+746
         JGDsxJk7yyjR85FCZn9EV5oMQRfhKhn+qrkgs2pLJNBf3X6+CGv8rAyXyYO+QubF1Uim
         BrxPyzQtNwRuehXXHxCjkpspK1BwQ/smDQlsNCYkexFb6xrHa2XEJcck7N1ixXsBwJ0+
         cxXd+T+N6iTEpVcDjBEZNSzOr3E3UexzTGh0UNyZon5jTcCLqBATQkOHqC4Mqo6qHSYD
         M6FA==
X-Gm-Message-State: AC+VfDz6wVNzbvFJxfFlxMntX04auUtJ8Y2d5/wyAi5P96w3mY3TFt/4
        +NUWyYjH6PHK+Oxmu810Ehc=
X-Google-Smtp-Source: ACHHUZ67ua4QqB8D/EpRugVFld375BJ7JpcXkvv7idb/0bZDgZBksaFRzAEA9X39AnUcgtAbqa9wTQ==
X-Received: by 2002:a05:6214:2124:b0:61b:6fcd:34ab with SMTP id r4-20020a056214212400b0061b6fcd34abmr2570897qvc.0.1686114035697;
        Tue, 06 Jun 2023 22:00:35 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:c358:f4f2:89b6:ca7d])
        by smtp.gmail.com with ESMTPSA id m1-20020ad44481000000b00621430707f7sm5848980qvt.83.2023.06.06.22.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 22:00:35 -0700 (PDT)
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
Subject: [PATCH v5 2/4] dt-bindings: phy: qcom,usb-hs-phy: Add compatible
Date:   Wed,  7 Jun 2023 01:00:21 -0400
Message-Id: <20230607050025.86636-3-guptarud@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607050025.86636-1-guptarud@gmail.com>
References: <20230607050025.86636-1-guptarud@gmail.com>
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
index aa97478dd016..f042d6af1594 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
@@ -13,7 +13,9 @@ if:
   properties:
     compatible:
       contains:
-        const: qcom,usb-hs-phy-apq8064
+        enum:
+          - qcom,usb-hs-phy-apq8064
+          - qcom,usb-hs-phy-msm8960
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

