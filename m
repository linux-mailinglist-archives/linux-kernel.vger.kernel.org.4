Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF53F6AF8A8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjCGW2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjCGW1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:27:46 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B4AAF77E;
        Tue,  7 Mar 2023 14:27:05 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id a25so58707954edb.0;
        Tue, 07 Mar 2023 14:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678228023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReUzQTPrVvG5iby/h9m+/R0jY9DDZJr5kroiPbP9VlI=;
        b=cYU4TMzZdmqPqI5Bu/OyoS+YivWNYKc5Db6vGbYpDkZON/UKHT0kW8l5+M1gJGJSuy
         ovQ3G+LSB/FefY8jf2s3iqH772fBWzSwZ6lrgOWZmjC3mWXl2KTAUNztegaeSoX8MKV7
         5bOqpDLr87hhzJ6CdpMGWIfw7OGMBDGLsD5acBrRf2qh5COyMabfMIj2aMLVVE6Bi/LT
         agzH6dXWnuNk9uYrCo0eOKQtFnGproh76TcOoCj58XGvog5v+nf5ndq668auPAMRfX/k
         tORQ+QamXruKaVFVg2xLW9k3luspGvEUEBZmH9M7r90658qO4r0YICMo0eK61Mmfyi3d
         fs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678228023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReUzQTPrVvG5iby/h9m+/R0jY9DDZJr5kroiPbP9VlI=;
        b=OH9nn9hfjRJGKrI88eh+TYLuYmSzyJCNEjUSq8J91kFG49wR9R2maJE/ShR4Bvih3g
         5wc/EFxXRxAb3NDAlNB7xCR5hbueicGCwyl0xFn+YrGeh/w/aYWd63Md/gjN1HXsgxy0
         CEowWgvxTeELr7zaaWDRL65arQSfMw4f0Pi4zcYARICt6nd1UBZTiI+bZ8k0KQ1Qwhen
         BGF+GU9nZBUQr3bswsD/hfpWe/56Hcz6KawJ1D1KdSUy290uyWbNqscgJU/Ux8BN4rlX
         gkVAqGFoAIiTyARjRjzB9LzIbelEhHG97CEax5ySbZr43McWnlK7NfcEW3aohvETJKEF
         IRIw==
X-Gm-Message-State: AO0yUKUEXJzZ0Gfda77e+uzNjus0X5Zy1Hxqqtd6yf8HIxXBgQZ7a/kC
        O89+WCkAdhKvxCREMRLm8PQ=
X-Google-Smtp-Source: AK7set90bv5W4k0vkQtEyMMJeUJVKAtudDQCtnPoIM/WgyMwR4FeOENO0NtjA/+I6emRet/kB7wS8Q==
X-Received: by 2002:a17:906:4e15:b0:883:3299:91c8 with SMTP id z21-20020a1709064e1500b00883329991c8mr15786241eju.55.1678228022566;
        Tue, 07 Mar 2023 14:27:02 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c485-ef00-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c485:ef00::e63])
        by smtp.googlemail.com with ESMTPSA id t19-20020a170906065300b008be996c1630sm6669412ejb.39.2023.03.07.14.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:27:02 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jirislaby@kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 1/3] dt-bindings: serial: amlogic,meson-uart: Add compatible string for G12A
Date:   Tue,  7 Mar 2023 23:26:49 +0100
Message-Id: <20230307222651.2106615-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307222651.2106615-1-martin.blumenstingl@googlemail.com>
References: <20230307222651.2106615-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic G12A SoCs gained a new "divide XTAL by 2" bit. Everything else
(we know about) is identical to the UART IP on GX (GXBB/GXL/GXM) SoCs.
Add a new compatible string for this SoC so this new bit can be managed
accordingly while keeping "amlogic,meson-gx-uart" as fallback compatible
string.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Changes from v1 -> v2:
- make meson-gx-uart a valid compatible string for meson-g12a-uart

Changes from v2 -> v3:
- don't add extra oneOf as all of the entries are enclosed in oneOf
  already
- don't allow amlogic,meson-g12a-uart as standalone compatible string
  (which slipped through in v2 due to all of the formatting changes
  that the extra oneOf required)


 .../devicetree/bindings/serial/amlogic,meson-uart.yaml   | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 3cbdde85ed71..22656efe8ddc 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -34,6 +34,11 @@ properties:
               - amlogic,meson-gx-uart
               - amlogic,meson-s4-uart
           - const: amlogic,meson-ao-uart
+      - description: Always-on power domain UART controller on G12A SoCs
+        items:
+          - const: amlogic,meson-g12a-uart
+          - const: amlogic,meson-gx-uart
+          - const: amlogic,meson-ao-uart
       - description: Everything-Else power domain UART controller
         enum:
           - amlogic,meson6-uart
@@ -41,6 +46,10 @@ properties:
           - amlogic,meson8b-uart
           - amlogic,meson-gx-uart
           - amlogic,meson-s4-uart
+      - description: Everything-Else power domain UART controller on G12A SoCs
+        items:
+          - const: amlogic,meson-g12a-uart
+          - const: amlogic,meson-gx-uart
 
   reg:
     maxItems: 1
-- 
2.39.2

