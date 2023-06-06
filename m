Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E3A723609
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 06:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjFFEF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 00:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjFFEFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 00:05:50 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8230A1B4;
        Mon,  5 Jun 2023 21:05:48 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6261a25e9b6so47732036d6.0;
        Mon, 05 Jun 2023 21:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686024347; x=1688616347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9dG+oN5uOmuQYXLewl1nCF0/Os/UQTTZl0+MY2RxWE=;
        b=hLyGyWV/wGxIlyRivBrflbF+AQbpydmNAc8eXG3Gavq7XrHayn3xuwfSjthktb+cCM
         UAyKKLnEcETGMR93/halHxRTijsVfyFbeGRzssPjqJpm4LIcSKXZ7Isz0rf6oa7//Kg4
         uGdPt1yAyTDjUUdKbFU4GAbwbfyaoJJwIY6LjdVwEm+VPdWMjax1S7EG5AkQAtVE552s
         o5LeamESV6p7DCgXRG5L09p7ttxy9VmayHhhNRkcqE7iyl//4gbjvM3873i6bcmgj7vd
         JqM2/bp4s6ZfoG4edNR/IqVeP4Pds6B3CEhhcrqUXQzcga8AQ0ISPePQB1pROM2jSxGU
         C0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686024347; x=1688616347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9dG+oN5uOmuQYXLewl1nCF0/Os/UQTTZl0+MY2RxWE=;
        b=QMZO+x6RwKvVEYZNH7hlAuY95xSzm/WUjWZ8OkB/egcS2bGFaREpn3GH00gSehncZd
         o6e4Ffr6SjYWid8PiOVO/zXxje8IMLAVQajs+l5/sm//S1dRrh9o/AuOcR/rc8qYSLKr
         JgD9xAo+1eyPoqCKNQOFlRM5MFyhq3K8NLdqhA1uzYGmuD/MmQFph1PHNNEnDVDALhrf
         tpSUoJcL6xfCyupI6+AM/eOencn/YBps2A3qqa+gQ6fDDfy0ZjQZTa3iKc4BESxdRRBW
         giPwn1T5Hc/xPVZxpvHcmGbfklaaF8cIL5NGxxhi/0s1y+g3cXrkDzqZo6gUegJRUSby
         A/pA==
X-Gm-Message-State: AC+VfDxeQcvdH89MRn2sQdeYhu1gKCmqM6IVLwzC9mDEtDsE0gdP0fcP
        f8K0xf6irQ9Oi5Z5CVSok5M=
X-Google-Smtp-Source: ACHHUZ7495EQIEA7GLHtQNJCW54CYVAnY5RakUHE5KqDf/3f8O1Dz+WFkoCSBwsXmG5zveMkh5TTKA==
X-Received: by 2002:a05:6214:d4e:b0:623:4ca9:5b25 with SMTP id 14-20020a0562140d4e00b006234ca95b25mr1017669qvr.31.1686024347531;
        Mon, 05 Jun 2023 21:05:47 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:aac8:d62:35cc:958c])
        by smtp.gmail.com with ESMTPSA id e2-20020ac84b42000000b003e388264753sm382980qts.65.2023.06.05.21.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 21:05:47 -0700 (PDT)
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
        Conor Dooley <conor.dooley@microchip.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/4] dt-bindings: arm: qcom: Add Samsung Galaxy Express
Date:   Tue,  6 Jun 2023 00:05:24 -0400
Message-Id: <20230606040529.122433-2-guptarud@gmail.com>
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

Add a compatible for Samsung Galaxy Express SGH-I437.

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d9dd25695c3d..133d69b2b73d 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -191,6 +191,7 @@ properties:
       - items:
           - enum:
               - qcom,msm8960-cdp
+              - samsung,expressatt
           - const: qcom,msm8960
 
       - items:
-- 
2.34.1

