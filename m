Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74A05EEAD2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 03:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiI2BQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 21:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbiI2BQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 21:16:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4499B1138E5;
        Wed, 28 Sep 2022 18:16:05 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n7so4417180plp.1;
        Wed, 28 Sep 2022 18:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=P6xn5k2w04qcw40pGqvk2hfkeCe3OpcAGkUOVnCrECg=;
        b=Mdix1ez2UFJ0v4X3ERTqjEVLBAX9bje7HCmdZdqxkh5iAyyTeZvi3aAqNO/fiNSp7I
         Z/lntDcF6QR+G68aq3MgndSDp+JFIaYFgi8V8DKBTSkBIVFvIaMpX0ABhRkpnGtjawbm
         JGF/8CEIRT28F7knuwnzS3c0SxMMU0YkJmMDKME7+yDrYO8rx2RAa3kEwMjNw4tP9Pnf
         7Uzld5hjUSfayZEz4ZNOZowzPYJ2SqyyjJB+gxysKLzwA9b5Bypd/9wV8g20vpq9hBDW
         eMsBEynGINXNkOt6ExbYa0Y3WjBmAs1BnpYL23BLxmc+GZ4g3IY8nleJPMRg8TGtJjLR
         a8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=P6xn5k2w04qcw40pGqvk2hfkeCe3OpcAGkUOVnCrECg=;
        b=h2huqJpZY6z6sHPgJmPWycGS3rVxSiC8Zor/+OKI0XhwIbEgZKC412ZUYRC0RCf+N5
         ubWPbwlDp5OKA7RqLDM3ofYg6rfqtq1Qs7akHNUqttn55jMXHTzTzEtUzI+ayPxJwAx7
         TRhzRf2D4ulopUS068S3r7uMDlkjTcEBthE8/++EtsXbfP0NK5m4tVCzhVbYPpKBpOhf
         ECQr8HoKj7gUEbPCutwA1sNeqgfKsYdxTXCyjIvs7pfFv35W1qRLQuCGyCYl/poGmNhl
         XpPHt5CRGt7fUIhqCOCjjboMT4ce+yf5cD/d6Q9c92l9HlkGI7zT92BytbT3E1zgBuaL
         T7Aw==
X-Gm-Message-State: ACrzQf1OZsgp+ediO2WbnjXkrM3IYU/1hmU7lakhlxiBvpkJ4ws5Chon
        TNDrAtcwYIqAsc6Ab9aOrNYFfXy/IcM=
X-Google-Smtp-Source: AMsMyM5ChV5LYfzLI0YM2SoghglQe4b1wxlFtJR8tcjNmOWHl+jSTjBmhN/5o3xp/JHVkrc6T/BaUw==
X-Received: by 2002:a17:902:a511:b0:178:9702:7199 with SMTP id s17-20020a170902a51100b0017897027199mr779310plq.155.1664414164652;
        Wed, 28 Sep 2022 18:16:04 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:637c:7f23:f348:a9e6])
        by smtp.gmail.com with ESMTPSA id y16-20020aa78f30000000b00540a3252191sm4737655pfr.28.2022.09.28.18.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 18:16:04 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Krzysztof Opasiak <k.opasiak@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: net: nfc: s3fwrn5: fix polarity of "enable" line of NFC chip
Date:   Wed, 28 Sep 2022 18:15:57 -0700
Message-Id: <20220929011557.4165216-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220929011557.4165216-1-dmitry.torokhov@gmail.com>
References: <20220929011557.4165216-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to s3fwrn5 driver code the "enable" GPIO line is driven "high"
when chip is not in use (mode is S3FWRN5_MODE_COLD), and is driven "low"
when chip is in use.

s3fwrn5_phy_power_ctrl():

	...
	gpio_set_value(phy->gpio_en, 1);
	...
	if (mode != S3FWRN5_MODE_COLD) {
		msleep(S3FWRN5_EN_WAIT_TIME);
		gpio_set_value(phy->gpio_en, 0);
		msleep(S3FWRN5_EN_WAIT_TIME);
	}

Therefore the line described by "en-gpios" property should be annotated
as "active low".

The wakeup gpio appears to have correct polarity (active high).

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml          | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml b/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
index 64995cbb0f97..78e3c13f1acb 100644
--- a/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
@@ -81,7 +81,7 @@ examples:
             interrupt-parent = <&gpa1>;
             interrupts = <3 IRQ_TYPE_EDGE_RISING>;
 
-            en-gpios = <&gpf1 4 GPIO_ACTIVE_HIGH>;
+            en-gpios = <&gpf1 4 GPIO_ACTIVE_LOW>;
             wake-gpios = <&gpj0 2 GPIO_ACTIVE_HIGH>;
 
             clocks = <&rpmcc 20>;
@@ -93,7 +93,7 @@ examples:
         nfc {
             compatible = "samsung,s3fwrn82";
 
-            en-gpios = <&gpio 20 GPIO_ACTIVE_HIGH>;
+            en-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
             wake-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
 
         };
-- 
2.38.0.rc1.362.ged0d419d3c-goog

