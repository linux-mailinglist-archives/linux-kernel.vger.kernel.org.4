Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C25367B137
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbjAYL3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbjAYL3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:29:14 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5452372A1;
        Wed, 25 Jan 2023 03:29:13 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i65so13224872pfc.0;
        Wed, 25 Jan 2023 03:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Brsbq1Lv+VKoJkUJMRBwphPkNmZ937GSrjGfpdCV4ds=;
        b=N234N6tHXN6869JbOVsuHAc7ZBQzqqlWp5zayAmIVqkUEi1SQCy5KKJAXgAOuBSy5H
         LwJV8DCPrJod2qessT8ts88gq+ZazAWhdAjpwk9h1i2ewBz0Q3Fpv8D6Uho4ToC6avTE
         UKY/LEfhEKr5fta3ITAAPGHun2K+KJNQggqqmViANKQkY4W9gbLxJnwz56ZXIMJC6wOJ
         3FTTXhOhTwMR0AlHJ5UmDq+5zAvPbko4dpvfZxgbMg9woMX3U7xYNSR9f7LxlE5X+DMm
         sG5Vpe6Ur7gOxQYwjjx1NW+TXHU4Th/QKj9CUPmPQUb5Q5jtYfFt5G+k9u4DZRRCGub2
         FUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Brsbq1Lv+VKoJkUJMRBwphPkNmZ937GSrjGfpdCV4ds=;
        b=iaJLMW2izEwlWA6C0oFrq/iRvCZnJGMuYHjo2BtFatmeYo5vniHR0/edozWNjWKql6
         kFP6Gn3QPjgOe5J6G/EzqNnsXestwkCoLx1IU8D6DZj76YS3Q5YMfAxI5xdVHS0b/b4/
         S/Jv7BbIedL52ucbJMAlOfDYIAd+6xctsbCi8aOn6NNXozeOWRH1Atcz9Wxt8F8wczH8
         jyHx2olE6YHge9c3wfuxiaJ2UVVefF9Oxb6lZEfra2HERGvrADFTGM3Mqftz3SnP8u5I
         CWhBiQ47FUnyb0NycZTcTDiyXcncKqxKinoKrcFPVMoNRQZWRx/YKzbAIr2jvLBIMUYH
         KRHQ==
X-Gm-Message-State: AFqh2kqMAZE0akV//gKEXGXT8PwKMWCrhnAbbQbxplEDrpnQHlbBm72K
        OpoCBE2Fa2jVqbDy8vhI2MY=
X-Google-Smtp-Source: AMrXdXtheOC1DaQUBGB7WFc/s0dAMAH2fV2z784by3ddKYCHxzP9HVIKDHQncwbz4GPsb1/PpwZrpw==
X-Received: by 2002:a05:6a00:328b:b0:577:1c59:a96c with SMTP id ck11-20020a056a00328b00b005771c59a96cmr34326811pfb.2.1674646152891;
        Wed, 25 Jan 2023 03:29:12 -0800 (PST)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id l19-20020a056a0016d300b0058d92ff8a31sm3333390pfc.187.2023.01.25.03.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 03:29:12 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Add Xiaomi Mi Pad 5 Pro (xiaomi-elish)
Date:   Wed, 25 Jan 2023 19:29:02 +0800
Message-Id: <20230125112903.10710-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for Xiaomi Mi Pad 5 Pro.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
Changes in v2:
  - Move compatible "xiaomi-elish" down.

 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 22553637c519..398ff26e6e0e 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -875,6 +875,7 @@ properties:
               - qcom,sm8250-mtp
               - sony,pdx203-generic
               - sony,pdx206-generic
+              - xiaomi,elish
           - const: qcom,sm8250
 
       - items:
-- 
2.39.1

