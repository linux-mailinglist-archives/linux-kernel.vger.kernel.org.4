Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9544A74874E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjGEPCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbjGEPBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:01:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA7519A3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:01:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-992dcae74e0so663934366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688569272; x=1691161272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6pSVP0j4BwFCAxVUlqE3COG74tlmcXjbS/vLgEZMCBs=;
        b=NwXMUtSzMz6/O8d2bAxzW2jAp8/9Ru1c+udeSfS9oAYZugEQSg28skBck2psXrOlDv
         oDUULODQQpPBUqOR6GtgrX13A5eHpTKiH4uGz4rBHDUBOXbA0CpAVnYxG7OcAGSYbKu5
         z2yLpp28zmFiT+o2cGAnRDtQWqCDlumrkjNFjL1jn/avMkRoTVTxAjODXAKTRp/6x/kd
         OyEiJw9W+OM1dc1lAesuEyvifn80VL8NgZMbDzDHIOS1feK0Mrr553CfXUDetEdQvYxQ
         LYDEdnAfDGpP09FgMPxNgyB0iDkJPNsJTAoTRjLi7FdtC+W5bif52jN4pFzdGlRIqLW1
         xILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569272; x=1691161272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pSVP0j4BwFCAxVUlqE3COG74tlmcXjbS/vLgEZMCBs=;
        b=CYw/9MVb0gN4l/7Y+89k5B2PMOpVXLaw4SHmlZPoSHTJrBFhpCAxxnTlTCnjR9Ds5f
         WxwfwUMJoIUhff6ZP8d3JCXCzRvRfMUyCFSlcFpXHMjeUCYAdy0SXFq/w6nTp50e4X5B
         yQghy7VrWxvZJNXIMUGIi6z2diQTfMfOm+jvE5Suw+t9YoqDeJJPdKdkmIk3uxDZ5tyl
         2gOWYgkJUXSjD2SIwFl8ftclAzjkRKa9OUJP4tEEJhWpn6eaEzEC3+P+IOHicSsKH+uM
         SEfKGBsxGZTXRD1L5TnM0p+dMup96L2By7rov5b7w9AUWYwTLD/bxoTIfVeoVvL3Ic0v
         eH9Q==
X-Gm-Message-State: ABy/qLaEYW5YsTSfYytBHzwmRY+B2Kpa67FMiL89FfL4a0FE9FJq9lpq
        7M7qppaq9HxYfvZjjC0xFD/E8A==
X-Google-Smtp-Source: ACHHUZ747xlYZVUjg6VLD8cpv9qJbYan6Wv31e9Y+GT3VkaMYvO7GY5L7doaQgDv4a7vFJKzg3XAZA==
X-Received: by 2002:a17:906:254b:b0:992:a2fe:757e with SMTP id j11-20020a170906254b00b00992a2fe757emr12425262ejb.31.1688569272390;
        Wed, 05 Jul 2023 08:01:12 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709064b5900b009929d998ab6sm9001667ejv.131.2023.07.05.08.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 08:01:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        William Zhang <william.zhang@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: broadcom: add missing space before {
Date:   Wed,  5 Jul 2023 17:01:07 +0200
Message-Id: <20230705150108.293999-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing whitespace between node name/label and opening {.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/broadcom/bcm47094-linksys-panamera.dts | 2 +-
 arch/arm/boot/dts/broadcom/bcm47094-phicomm-k3.dts       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/broadcom/bcm47094-linksys-panamera.dts
index 8036c04d81cb..2b5c80d835e9 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-linksys-panamera.dts
+++ b/arch/arm/boot/dts/broadcom/bcm47094-linksys-panamera.dts
@@ -279,7 +279,7 @@ partition@80000 {
 			reg = <0x080000 0x0100000>;
 		};
 
-		partition@180000{
+		partition@180000 {
 			label = "devinfo";
 			reg = <0x0180000 0x080000>;
 		};
diff --git a/arch/arm/boot/dts/broadcom/bcm47094-phicomm-k3.dts b/arch/arm/boot/dts/broadcom/bcm47094-phicomm-k3.dts
index 3bf6e24978ac..bb1bc4e61bc2 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-phicomm-k3.dts
+++ b/arch/arm/boot/dts/broadcom/bcm47094-phicomm-k3.dts
@@ -55,7 +55,7 @@ partition@80000 {
 			reg = <0x0080000 0x0100000>;
 		};
 
-		partition@180000{
+		partition@180000 {
 			label = "phicomm";
 			reg = <0x0180000 0x0280000>;
 			read-only;
-- 
2.34.1

