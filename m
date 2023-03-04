Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDD36AA9BC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 14:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCDNDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 08:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCDNDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 08:03:10 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEADEC49
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 05:03:06 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id o15so20540447edr.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 05:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677934984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OkSvhC1gVfb8PyCSyQ+RtHNDDmsSooTX9+nQ9I0Jmpg=;
        b=CsMkJGA9hdUF74PfJmmoeCH0DL3C3DQkcn3WbRdCnBbGCyU9OkW+5cJ9QCyhnmmDQG
         ZeSxOGq0vxhK9SIU8zRSIKAklNq2GcSW0uuq+abPjH/dBA/jpBYWsq8vD2FBWEPSRi/6
         i5WUVB4Et5JVJF/lzyw/T9pSIABQC4LlI/SiSHl7Nd/A7qtMD2sb54A0Gd+gb8WLYNbQ
         ZFsBKj8fum5dKIgsxzBFaEYCjNQyUjPRGYjixNwcF7GLfdybvCiXQtAv4175FJtGbAHf
         iUSn4eOUrEaII19HtkVfd8yzWAoFEVPa6ru0QRLIS5vFahcrT9alcWYrnP4JXVipv6F5
         9Q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677934984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OkSvhC1gVfb8PyCSyQ+RtHNDDmsSooTX9+nQ9I0Jmpg=;
        b=7AKD6ej1XXH8tUivAcZngVSEaaoD4rdT5TsMM9I38bs1YcH7M8JZUS8weg6pAphg1Z
         oPz7YCBN9/kBESPGHUNpV93LmxAtshOm1fPU/xs6ZZe53jMRpsTwDz2Yrs0DxQqYyTK0
         FpQ08L+GgkOw0TnlEJjsvuFaFXK/ip3YahF2qJdCVBw34Wgm2O3lTUEVJn6U0DyYepq7
         EWNsGpSoLnxLF6hSWO1A8X4KVewurEsxoyH7wyvVEugvpTvKFUkAdn96O3wLFzMSLxma
         Is0mmkcq3QsucVlp2hYp82OCrUUaDL8cAH0zeAzxxBvGWfjFD0hxBysE2M5Vo5aeRDX2
         /6EQ==
X-Gm-Message-State: AO0yUKV9VDQWyMe/WYBiQIdJyHq1jgKnXKhZjk+nJ2zf6GK6DGPAKmwJ
        tRHslCUn5RsGtVvgRJQkKTLBIw==
X-Google-Smtp-Source: AK7set/bmaqwN4R25kvMcexrvDGMzPZaZh0bC495ArZrsGl7hCUyTreDKEyqyPdHv1z9BivBfzFSvQ==
X-Received: by 2002:a17:906:4cd4:b0:8f8:eded:4254 with SMTP id q20-20020a1709064cd400b008f8eded4254mr5027030ejt.65.1677934984748;
        Sat, 04 Mar 2023 05:03:04 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:b758:6326:1292:e2aa])
        by smtp.gmail.com with ESMTPSA id x8-20020a170906440800b008e8e975e185sm2052734ejo.32.2023.03.04.05.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 05:03:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: usb: snps,dwc3: document extcon property
Date:   Sat,  4 Mar 2023 14:03:02 +0100
Message-Id: <20230304130302.51497-1-krzysztof.kozlowski@linaro.org>
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

The DWC3 USB Linux driver and several DTS use extcon property, so
document it, even though it is deprecated, to fix warnings like:

  sm6125-sony-xperia-seine-pdx201.dtb: usb@4ef8800: usb@4e00000: Unevaluated properties are not allowed ('extcon' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index be36956af53b..cad2efd5f8c9 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -70,6 +70,10 @@ properties:
 
   dma-coherent: true
 
+  extcon:
+    maxItems: 1
+    deprecated: true
+
   iommus:
     maxItems: 1
 
-- 
2.34.1

