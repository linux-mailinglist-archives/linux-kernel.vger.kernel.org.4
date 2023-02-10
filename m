Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28DF6924A6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjBJRix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjBJRit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:38:49 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FE434F55;
        Fri, 10 Feb 2023 09:38:48 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f23-20020a05600c491700b003dff4480a17so5733906wmp.1;
        Fri, 10 Feb 2023 09:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnXrkD6mC1X9wvYtsECorUK6F5CsiEFkvfTGl5Os3Dw=;
        b=iPgPTDYO2Ay92Hea++NHzSXGW3gZOjxG1nkOgA8Awp1gUIfV0gbewJxnduW7lAaLU1
         GW03L/PvBFDfA5oF2hFAECaSoPDyL5dYtxI5XHFQd+aKRHByYk4t8SEyvPL4CV0VVwO1
         eCy9xOsmcvq2Dgw0VuAc6XJURlo51VuPcznEsFlq5ItkpONAtAPP0gp0g27FtNI6F0fI
         3mJlQ98PurpaYcUAxJ1AoR2ZhXDLBBqBGpXIEVVyvxwI5KiWVP0e9McR4w4Sow5ntSG9
         o2AgE/QNmtE0b5YHvzop45Sw5meH1AusWMbwADTGnSJ6zsDoJtRcH9AmbOXeCz1B0JpW
         izMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnXrkD6mC1X9wvYtsECorUK6F5CsiEFkvfTGl5Os3Dw=;
        b=OG2xpWx7BYNxxYK9hTHlGQlAe1FA2UinsDBkbCqLurppvhFZZsG/CFnW7btSWu3Dgr
         FT07mCiPcRkcVKbuObvHv2U1LDcy8ZXcbAskOVctFRxyYhwk+XZVCGpqW9Z0+SPM3Rjj
         mbjON97EbX8Fn9hBcYDEIpJKDZELe+ZhaPSZulDK3ruwqB0m2lHYqL/jBfK/aCLZ2Uus
         DY8MJ5iYgshZekghh+6a4SQvbvmjjnFyRjgywUgl0FGckp4uWtAgcN8iTnbdpenED5mk
         XDHh90/jvddgB5ksuTb0yGzY6//cum5hECZ3nfQyarPUQm5ZbDiwRP4xT6VjlCI0SoyL
         mp+Q==
X-Gm-Message-State: AO0yUKVZb36/QKUKUll0IGyweZnJkouUk27uySMyW+ybtDsMwsqdrvYi
        HXh6WAwm0GzwCYSg9mLvGTSJRyxPQTA=
X-Google-Smtp-Source: AK7set+xRVV4i5HZDKgxWBRd1Yo6qxEkshf/bLoHKTn9oFGCAh7VbbMtKcc3lS+sBHEUOIeYNM4CJA==
X-Received: by 2002:a05:600c:2e88:b0:3da:acb1:2f09 with SMTP id p8-20020a05600c2e8800b003daacb12f09mr13551762wmn.19.1676050726123;
        Fri, 10 Feb 2023 09:38:46 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id t2-20020a0560001a4200b002c3ef7e74bdsm4024184wry.73.2023.02.10.09.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 09:38:45 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: watchdog: mt7621-wdt: add phandle to access system controller registers
Date:   Fri, 10 Feb 2023 18:38:38 +0100
Message-Id: <20230210173841.705783-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210173841.705783-1-sergio.paracuellos@gmail.com>
References: <20230210173841.705783-1-sergio.paracuellos@gmail.com>
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

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
index b2b17fdf4..a668d0c2f 100644
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

