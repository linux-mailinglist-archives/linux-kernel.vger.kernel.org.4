Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A394872152C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 08:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjFDGbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 02:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjFDGbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 02:31:07 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365B11A7;
        Sat,  3 Jun 2023 23:31:04 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f6c81cc112so40426791cf.2;
        Sat, 03 Jun 2023 23:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685860263; x=1688452263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxOPjAsaZ9AVOYNeDf20wz37OzM0ix4j2H0BVngyGV4=;
        b=dGai88tpFQCWZH9NL/nX18vad8F+5nyE967geRtVAerQHgbGJ/f4XWn5ITBdwjMPle
         AX1Ix8ZB99kfBhkeYbioSWtNIs7pwW4/uEN10K+Hs4RRCq1VLVV0y4+7PhYad+F+W57L
         XITPUjBIAZbIpvKO2+Y4+YanoLV9017GtMWsgA4Epm9WEAK8oO0twy2V0K77ms5Y6gYH
         J7T1cUAEn9dbCE9MdTBaYYZva0L2zH/4R+FuIg0L/a1j9fcbaYatFlObQfwYRvDSIb2v
         DFoCFF+0OSXImFykY/sSnnGMCV3VkUyibYclbwd3RD8i5kQcZ1YiGGyvYmVPNYjSA81z
         KmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685860263; x=1688452263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxOPjAsaZ9AVOYNeDf20wz37OzM0ix4j2H0BVngyGV4=;
        b=cJX3asZSRSqbr+dVNllis8pxNvHPFkta0seBE4R7Ok7F9PNloNkHnKBT63DJsJ91v6
         UChOojQczoWdJ31bkzcpmtpyJmeJcolu/ZGojPJRk7Y9J6Ie5yj8eAgMIO84t6Zb2ZrG
         FqnPYXamEtLoHDDCAP83astXsH0l4Clq3O7HFO2TjNVazKxrzbZF7z8vLWLPybvGJ3s6
         N5OrM1QSdTen5hJaLaVbQgJNiq9cc90YTovb5DebmPzIF5j7kgnGCNuzlUgk6TzV13zr
         H9SM6LVILcEIDPh5PYcEYQVQVx3zgl4ZAoJTtKypGry/cZklcegGzJ3HV3Aa7lUGhDuc
         +etw==
X-Gm-Message-State: AC+VfDx8jeAc2fNVDqVPyZuA6R+Y1J9y91mGaRxk+8Syq6FUQDrGNlJm
        fhWpObTeMmMoFrJvT3KpMWU=
X-Google-Smtp-Source: ACHHUZ4dL3Kz5HI5I6+ui9aifYxduaqhbMhmWcsOwaUA1rvniBFUb6e0+QHmq2UCq8Dtvsc4Mx8Jzg==
X-Received: by 2002:a05:622a:1801:b0:3f6:c52e:21b7 with SMTP id t1-20020a05622a180100b003f6c52e21b7mr4214480qtc.17.1685860263240;
        Sat, 03 Jun 2023 23:31:03 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:ab78:dd77:aea4:8d1a])
        by smtp.gmail.com with ESMTPSA id e10-20020ac85dca000000b003f018e18c35sm3044163qtx.27.2023.06.03.23.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 23:31:02 -0700 (PDT)
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
Subject: [PATCH v3 2/4] dt-bindings: phy: qcom,usb-hs-phy: Add compatible
Date:   Sun,  4 Jun 2023 02:30:19 -0400
Message-Id: <20230604063032.365775-3-guptarud@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230604063032.365775-1-guptarud@gmail.com>
References: <20230604063032.365775-1-guptarud@gmail.com>
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
index aa97478dd016..63b6914993fe 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
@@ -13,7 +13,9 @@ if:
   properties:
     compatible:
       contains:
-        const: qcom,usb-hs-phy-apq8064
+        items:
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

