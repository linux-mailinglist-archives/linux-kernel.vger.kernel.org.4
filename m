Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA4B6F100E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 03:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344792AbjD1Bhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 21:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjD1Bhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 21:37:42 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCD71989;
        Thu, 27 Apr 2023 18:37:41 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-766692684e1so21721239f.3;
        Thu, 27 Apr 2023 18:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682645861; x=1685237861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PR+EVTmtHegO0AGBugN9Gm1VAL6IOr7NhT+GR8zq4Hc=;
        b=JrRTR4UXe6oHFpaBT2wML/YPLBr/mNDFQUkg+ss99BKWvcOArOTBTZRGZD8+hefLoX
         bewsDiwnLRqNiyLKXr4x/rE2NGl8hW9Mwp/CsmlOcUJydxnpXTxJxJYaHd5xmn8xkfvv
         L+V13iwBo1U3V3B+RxkcaJJYSwxFzuWf7I87Ajd/x7SzvV9ezT0mJWzMKQ6eKwKNKvZ9
         yV3WX5ouwZ8scr+zje2aoXQVxg++hRhKNl23YILUQUxvaDyuhidGFnIS6ca2uhL2KmU2
         KcWMWUysF06FGLg63wurJWxtP+W3QzdwV1IKHOTMfGJkJWKq1bP52WPT/48hEZ/Mlrw5
         X1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682645861; x=1685237861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PR+EVTmtHegO0AGBugN9Gm1VAL6IOr7NhT+GR8zq4Hc=;
        b=K/6nhcT8NpZJD1XVZs2dLS8xxS1cZFitkBhSjby5RQHtz1f0Jfl2JXZW6uU4QSCNic
         9rSuDWJHeWqjX6mk38jRa2edCH5IHSpc7f4teKx0XZfOLdW6asUBovfSCx0RywYtmKo5
         rQjSJ4G8PZiYVFwlbeJNkvnrBSMvvevQRJ+5X2V612MOf/VTqU9+rXZajBttSsiGQ4GX
         rPAhV+qcF5Fw+xFcQ8cH5ZUVe1YtcnE1ThaQfolRAN416lkAPKrZKZBBTCWv2zXH1goL
         JUywR/ZSlAc8CdiBzTJOBfcGADcD0AyAt7sgkckDknaMaCMTSxUUBCAOP62lhRfYfi/2
         0U8w==
X-Gm-Message-State: AC+VfDwAWxtdV7i8mrva3kLqrOck2stsgWzY309oBX0y3WaxnxlImf2V
        iFj+AwNXlvYsSuMtMnTarVg=
X-Google-Smtp-Source: ACHHUZ4pjAXoLo/NcpZLiJSpGoVkQXK1S3II7/9VNR1Z2BIZtAvFAfaeUrAOYa2o1aWzI0BzuFVTtw==
X-Received: by 2002:a5e:a70a:0:b0:763:5ead:f20b with SMTP id b10-20020a5ea70a000000b007635eadf20bmr2287481iod.16.1682645860653;
        Thu, 27 Apr 2023 18:37:40 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id u11-20020a02230b000000b00411a1373aa5sm4985431jau.155.2023.04.27.18.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 18:37:40 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Tianling Shen <cnsztl@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>, Andy Yan <andyshrk@163.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Andrew Lunn <andrew@lunn.ch>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: Add doc for Fastrhino R66S / R68S
Date:   Fri, 28 Apr 2023 09:37:36 +0800
Message-Id: <20230428013738.30735-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Add devicetree binding documentation for the
Lunzn Fastrhino R66S and R68S boards.

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml    | 7 +++++++
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index ec141c937b8b..b1d271778179 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -562,6 +562,13 @@ properties:
           - const: leez,p710
           - const: rockchip,rk3399
 
+      - description: Lunzn FastRhino R66S / R68S
+        items:
+          - enum:
+              - lunzn,fastrhino-r66s
+              - lunzn,fastrhino-r68s
+          - const: rockchip,rk3568
+
       - description: mqmaker MiQi
         items:
           - const: mqmaker,miqi
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 3e29fbd53b6d..20a77b193ed2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -779,6 +779,8 @@ patternProperties:
     description: Loongson Technology Corporation Limited
   "^lsi,.*":
     description: LSI Corp. (LSI Logic)
+  "^lunzn,.*":
+    description: Shenzhen Lunzn Technology Co., Ltd.
   "^lwn,.*":
     description: Liebherr-Werk Nenzing GmbH
   "^lxa,.*":
-- 
2.40.1

