Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7146918DC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjBJG43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjBJG40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:56:26 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9A320064;
        Thu,  9 Feb 2023 22:56:26 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so5572847wmb.2;
        Thu, 09 Feb 2023 22:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8W95yo1auDtSb8FRaJVq8qHTIzQlIIiJTRKxHWk0HJM=;
        b=LD4fiN3r8S6ZAum7n1fqQjIJL/buQFVPxgG9wjik/3OLKLw34xr/zaNZ6xnNR7PsP6
         0mz/pA9CWEamB9U+5N5jqRWUMVNKRBrYwhb0GpbkdwGSViwvcC2aUedSpcc1Dcp1nInD
         nRxlXniEF3OtvUc+6oTvEH3zd8JmEnPQWNxTIR1MeD65ngb8m/09wiiOGd3iLIs3h0qO
         blnWxSvTvT57yZCc6gjZYyjcmq+8ykHCHxMUhpsmm6YY89D/nDfnInh3P9dEJKrmP4QW
         E49JB062CNsdgBBpbe9dBZcKAY8otUhLNIZW+dPh7HB4AXTBBJzcbHYqNGqRs+TIDTC1
         5IWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8W95yo1auDtSb8FRaJVq8qHTIzQlIIiJTRKxHWk0HJM=;
        b=e2gS87WdDkTQTkHA3Udbzvnq64MeVY0ccTikIGAXjEk5lePSEPO+ZWmobQCHWJVJuZ
         dOOKhVi0tuQNJUDY9S8si5UPX9ipftovqdnw8Y4V+okXpyoONMJ5JFHJTowfv4jr3Eb9
         SNefF9cJv4P6gjI3INmNv1PuerZK3k6a4TWVrsmJjNJCY4iD8ObvWpc+78572xHBMt8B
         vnA9dGVOMxYSVD6yqnf6HXsXfe2BThFmA4x4zUdmiFLvk38ehmX4z95qwRN8/ZGHOgLs
         gXNLZGMHQGTbrC4mAwLZ15SyV7hPwgQrotEA0753R1dmFwe2YtQ1xI+CBtUiXyABJNiu
         Q9fg==
X-Gm-Message-State: AO0yUKVbQ3BPw82s2HDPy+umB9QPFPi99/hVLkKFrlCBARSPOVFEXuqc
        N/6DaeQUByr/KUByULPsUEwU2nzjLyk=
X-Google-Smtp-Source: AK7set9SPCvePfmmDkifOw75l2tfnd+RrGPtYmfzP0N2ukUwgB8wQFgEHT4wy1E/DEpWsUV0TiHNwg==
X-Received: by 2002:a05:600c:4383:b0:3dc:d5b:5f73 with SMTP id e3-20020a05600c438300b003dc0d5b5f73mr11794204wmn.19.1676012184338;
        Thu, 09 Feb 2023 22:56:24 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c468d00b003e001afa274sm4385612wmo.2.2023.02.09.22.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 22:56:23 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: watchdog: mt7621-wdt: add phandle to access system controller registers
Date:   Fri, 10 Feb 2023 07:56:19 +0100
Message-Id: <20230210065621.598120-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210065621.598120-1-sergio.paracuellos@gmail.com>
References: <20230210065621.598120-1-sergio.paracuellos@gmail.com>
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
Add a phandle to this node to avoid using MIPS related arch operations and
includes in watchdog driver code.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../bindings/watchdog/mediatek,mt7621-wdt.yaml       | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
index b2b17fdf4..3c545065f 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
@@ -14,11 +14,18 @@ allOf:
 
 properties:
   compatible:
-    const: mediatek,mt7621-wdt
+    items:
+      - const: mediatek,mt7621-wdt
+      - const: syscon
 
   reg:
     maxItems: 1
 
+  ralink,sysctl:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle of syscon used to control system registers
+
 required:
   - compatible
   - reg
@@ -28,6 +35,7 @@ additionalProperties: false
 examples:
   - |
     watchdog@100 {
-      compatible = "mediatek,mt7621-wdt";
+      compatible = "mediatek,mt7621-wdt", "syscon";
       reg = <0x100 0x100>;
+      ralink,sysctl = <&sysc>;
     };
-- 
2.25.1

