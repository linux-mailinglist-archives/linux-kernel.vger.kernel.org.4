Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1A4696109
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjBNKjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjBNKjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:39:42 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F8522790;
        Tue, 14 Feb 2023 02:39:41 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id co8so11381255wrb.1;
        Tue, 14 Feb 2023 02:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3sle6vuJ5ZYj6zgwI9CIQN7irdJcOFiW2OuMgXb4rs=;
        b=JxplB8Ky26UGe9loBVHiSx1XcBVzieiq3QSgtjF7xy0DSxcQnqZ1TkWA8n4MMR4u9k
         uJqZejYgwkWBA/hwIOyz5xuzyo0pqpK4dXY4hw+MC2iJUO9p+bUCmuAK4PDVFuMcU5fv
         JmN540jx4AuwmCxprANzwDqJaVNEfYxIs9vtuOCulCJFp62+amMAMNxReFVQtViUscG9
         K2trPT6ImGChkD2Z83ZYgSVhzIvDsClycKo2ereoqDT5znNUuF9Y7lZ5DX92Y9bNoL7m
         o23V34pYg44pRPYrWwHbrJmfXtN0Qe7wOeoKCx9aKKmHJf5DzjLDhZunQMuH/IEv5Vl9
         4IFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3sle6vuJ5ZYj6zgwI9CIQN7irdJcOFiW2OuMgXb4rs=;
        b=x3duznDXrtoBMXI2DctkuWEl9TCmk0uVUUwTLZC8G9EAOgQgBVlh8PbLjkKhY10DIJ
         31JxU0AppaAuj3ttgKht1cHYXYGd+br6M9nPrF4OHQGFUkh69tPwwWRvud8znvggAPck
         7Q4PlAFhOd8+1T6k/joneC33O+buSw7iiTEFYHegLpX9cZRLUvSQPkEK6tTdWecAatDE
         E/kB2TBT2vda12oSqkJhSYBA3BU69er0roEwLSturWqN1+iK/ciReeuo3t63FFbVd7Zh
         1XKu+37E+rgttTKzk497jCigkGgDpkHI4fHN3UYQ/JIp6FfP10Kegx6K5wtTk9SsJrml
         1LPA==
X-Gm-Message-State: AO0yUKW1r4AZov2n9G8z3454RAsLKhzJ2VIu9U99QzJIt5jZ2SBlzQak
        +/b7zI9SG6qZcD2K6XG/2NTqB7IOLDE=
X-Google-Smtp-Source: AK7set/O59WS6Lcp7zvlgmIQ639/Lvnj3eaoEDyNx7m9GscQZTM+/ZeQHkNP5GJFlBurI62NTl7hoQ==
X-Received: by 2002:adf:f643:0:b0:2bf:1ec:a068 with SMTP id x3-20020adff643000000b002bf01eca068mr1803480wrp.53.1676371180095;
        Tue, 14 Feb 2023 02:39:40 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d6102000000b002be5bdbe40csm12693241wrt.27.2023.02.14.02.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 02:39:39 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/5] dt-bindings: watchdog: mt7621-wdt: add phandle to access system controller registers
Date:   Tue, 14 Feb 2023 11:39:32 +0100
Message-Id: <20230214103936.1061078-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
References: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
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

MT7621 SoC provides a system controller node for accessing to some registers.
Add a phandle in this node to avoid using MIPS related arch operations and
includes in watchdog driver code.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
index b2b17fdf4e39..a668d0c2f14b 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
@@ -19,6 +19,12 @@ properties:
   reg:
     maxItems: 1
 
+  mediatek,sysctl:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to system controller 'sysc' syscon node which
+      controls system registers
+
 required:
   - compatible
   - reg
@@ -30,4 +36,5 @@ examples:
     watchdog@100 {
       compatible = "mediatek,mt7621-wdt";
       reg = <0x100 0x100>;
+      mediatek,sysctl = <&sysc>;
     };
-- 
2.25.1

