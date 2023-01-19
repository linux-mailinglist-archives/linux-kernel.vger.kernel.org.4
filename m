Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A41E672F92
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 04:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjASDny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 22:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjASDmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:42:17 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0943B6CCC5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:39:55 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so617254pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kudYK68TKVp96VTs/Z2G9y6K9uac1w5PwvTjxWPWhog=;
        b=VuUym+QbQ/y7/+6BcQS8DraTXW0ibrEYQipwh9a7+P7xuu/wdp+8A+vNbebgvwHupn
         81y3Kpx+KKNati4Kz4YYzUFNQLZ5PAU9K6V+dJu8JXG/BtDooSPje7hajOMylLRaS5UA
         HX0F8E0xPsCjEWn6IDMLcQHxkc4NuH9bPmUQPkpU1n3V0reinnD6ioQnLpqcM9PxGIMO
         675PfHIS/8Dco0Es9RlfXwTVLl8M26C7/mKeN6r1HVBGMNa98EjsxGF6KgYnBIYLVNbf
         gkKQLYKnNWGYWaXziAgJqyjEWsoGxvvofDTjszVnx8Td2k5cdplTtmhMS52mQQWT/otG
         wonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kudYK68TKVp96VTs/Z2G9y6K9uac1w5PwvTjxWPWhog=;
        b=Bzet/FMyf6A0rjQfk/Pu21xEIwMXmgTn0J3n8dxBVlh5Y7/LTsUFAHqUju4cLl8ure
         WjgMb1ApIs7KWGm3wqpVasHesw/yovqKdeO+AIvG+9ty4d5KYSDyT4UOXadjcXDCrJBL
         oyAM5RQkWscBznqIkUX7HBjLmuQjdKZ7Ymxl/yh2ZUFnf4Ny8I3hEaj2YtKGGbmLBFxM
         6OVWf8aIFrccG3LJho6iALKhCmWl434L3hI0XF1t9pyMFLnyYWP+UDq43tBvrduz4iwM
         x5iiV8lgUQLAZ5x4JTUXFem1WlpVPVFGytnc9ncopX7YztgMkZOXPfniolm2KKrr1+V/
         cdoQ==
X-Gm-Message-State: AFqh2ko985JHhE9HzyclImyB0RH4Ow6+gM88Kw8e6o8XqOcoV/Wk0SXu
        pXRjhjMcYeHaeEhCVkm+OICrXAMi6rTRd0XRhGmbvw==
X-Google-Smtp-Source: AMrXdXsH5evpf5+gOZqFAYVG0372ZyN0AxzV0HyzUFqbfAnXJurzGZqH5wa5o5+lRTWDLC++WhKydA==
X-Received: by 2002:a05:6a20:c21a:b0:b8:cb15:d6db with SMTP id bt26-20020a056a20c21a00b000b8cb15d6dbmr8192063pzb.23.1674099594760;
        Wed, 18 Jan 2023 19:39:54 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id f13-20020aa7968d000000b0056b4c5dde61sm11097879pfk.98.2023.01.18.19.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 19:39:54 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
X-Google-Original-From: Brad Larson <blarson@amd.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brad@pensando.io, blarson@amd.com, brendan.higgins@linux.dev,
        briannorris@chromium.org, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, davidgow@google.com, gsomlo@gmail.com,
        gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v9 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
Date:   Wed, 18 Jan 2023 19:39:05 -0800
Message-Id: <20230119033918.44117-3-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119033918.44117-1-blarson@amd.com>
References: <20230119033918.44117-1-blarson@amd.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
explicitly controls byte-lane enables.

Signed-off-by: Brad Larson <blarson@amd.com>

---

Changes since v6:
- Add reset-names and resets properties
- Add if/then on property amd,pensando-elba-sd4hc to set reg property
  values for minItems and maxItems

---
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index 8b1a0fdcb5e3..f7dd6f990f96 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -16,12 +16,14 @@ properties:
   compatible:
     items:
       - enum:
+          - amd,pensando-elba-sd4hc
           - microchip,mpfs-sd4hc
           - socionext,uniphier-sd4hc
       - const: cdns,sd4hc
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     maxItems: 1
@@ -111,12 +113,36 @@ properties:
     minimum: 0
     maximum: 0x7f
 
+  reset-names:
+    items:
+      - const: hw
+
+  resets:
+    description:
+      optional. phandle to the system reset controller with line index
+      for mmc hw reset line if exists.
+    maxItems: 1
+
 required:
   - compatible
   - reg
   - interrupts
   - clocks
 
+if:
+  properties:
+    compatible:
+      const: amd,pensando-elba-sd4hc
+then:
+  properties:
+    reg:
+      minItems: 2
+else:
+  properties:
+    reg:
+      minItems: 1
+      maxItems: 2
+
 unevaluatedProperties: false
 
 examples:
-- 
2.17.1

