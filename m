Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EF1721DD6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjFEGFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFEGFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:05:46 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB874E9
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:05:42 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b1fa5a03daso111348a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 23:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1685945142; x=1688537142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQr3RN9zgUO2hKzzgYpy0fgrqaq999hm2iLdMsuMThM=;
        b=JE30JrNqKbf4xUGygx7fVV3lfLIqR3UPFTmY0GoQcNzHtdtDM7oOjTxkrydVol5jRy
         w9YjjSg9GVY9ACBMvfUwisSRUKEG6ah7dEAVIQQRg+77bQzx71ZZwlf+XrmaUFgQeCKy
         aIixFZceH8qZZK12miyGeIN5fZK08zAI3AhPFnjYggnIEA7j/Xac+OTn9LiXRgJUhg3F
         q3veSpHwEICOQgPGFZVof1XtcxikKJF5CaIxvnZ6RO81WritspgXO5dd376/UxPICyb0
         8PIU7m/hoDf9IexltnPZS32MyMOEiDi6pMSlPcVuW8+Ki7sXE5Fubdhbw8IM0FjGt5j9
         8nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685945142; x=1688537142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQr3RN9zgUO2hKzzgYpy0fgrqaq999hm2iLdMsuMThM=;
        b=U1cN7doUDXqNKArql0/UZOzoBIe30C3P3e5oaPQXnaxNCewXjzCgyq+DpgftdMqJHs
         P23TTmgnFLhviktSM52SuXIsaUh/jmluvGiIe5i33dW0b5ws8KDKf5TVgVQfwC1qAVkQ
         uwh+JFCY5PK8gQm/T6Bfu0lGooZagVKJhyjqbq+u5Eg3HtrqLUX6F7R7FXvbRykrkFOb
         g008KGPTDyzWb0XurG0DJRF5yqoEZRpPeQhXXLps2Q1DRrjSoSU2GSuyumjxAD8WVB1P
         fWsOrM1dned30ej0E3dAkIqtEwcGn7HEMtESK+/IoCgG+P5ITtpzbTHU220qRsZwN7cS
         na1g==
X-Gm-Message-State: AC+VfDz+MWii8kplaFBAarU02JBN6iYuMsLzyYIdh1xDkVIAZIeGDzlH
        zA+iT+71QbMWwTtyjb8VD5UimA==
X-Google-Smtp-Source: ACHHUZ7ZL45qJ975qyVztmAiMuU/lrIoc/un/GgTY0x9EsXC5DkEwcHIFdCuL5lAWgtIjjd2Mx1+Ng==
X-Received: by 2002:a9d:624d:0:b0:6af:7fed:1fd3 with SMTP id i13-20020a9d624d000000b006af7fed1fd3mr5679813otk.31.1685945141936;
        Sun, 04 Jun 2023 23:05:41 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id 128-20020a630786000000b0053ba104c113sm5031379pgh.72.2023.06.04.23.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 23:05:41 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v2 1/2] dt-bindings: input: touchscreen: Add ilitek 9882T touchscreen chip
Date:   Mon,  5 Jun 2023 14:05:23 +0800
Message-Id: <20230605060524.1178164-2-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605060524.1178164-1-yangcong5@huaqin.corp-partner.google.com>
References: <20230605060524.1178164-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an ilitek touch screen chip ili9882t.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 .../bindings/input/elan,ekth6915.yaml         | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
index 05e6f2df604c..f0e7ffdce605 100644
--- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
+++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
@@ -15,11 +15,14 @@ description:
 
 properties:
   compatible:
-    items:
-      - const: elan,ekth6915
+    enum:
+      - elan,ekth6915
+      - ilitek,ili9882t
 
   reg:
-    const: 0x10
+    enum:
+      - 0x10
+      - 0x41
 
   interrupts:
     maxItems: 1
@@ -29,11 +32,13 @@ properties:
 
   vcc33-supply:
     description: The 3.3V supply to the touchscreen.
+                 If using ili9882t then this supply will not be needed.
 
   vccio-supply:
     description:
       The IO supply to the touchscreen. Need not be specified if this is the
       same as the 3.3V supply.
+      If using ili9882t, the IO supply is required.
 
 required:
   - compatible
@@ -41,6 +46,18 @@ required:
   - interrupts
   - vcc33-supply
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: ilitek,ili9882t
+then:
+  required:
+    - compatible
+    - reg
+    - interrupts
+    - vccio-supply
+
 additionalProperties: false
 
 examples:
-- 
2.25.1

