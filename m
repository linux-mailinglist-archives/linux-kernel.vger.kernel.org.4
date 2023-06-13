Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463BC72E3A9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242513AbjFMNB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242431AbjFMNBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:01:09 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA451996
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:01:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f649db9b25so6691029e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686661265; x=1689253265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TLZqf6X/lOVmCq6dcL8fAW/4Qa2W1ozlpyLia0p++0=;
        b=Cc8C3RlOC4doOxWhwCDaBv2LKpIC/95gqH2EsIhJxCZmXm6n004MXOc77OlF8ACOnN
         pGrI7hefBn7Lkk3Rx68bnltrYEC2lzph4N1MRE/Gnmnjly/E9Yu8ikMsNjKRAY7ipBX2
         hHYLwgxdfRz0yCu/5ZzTCFG1DZ0urz4I/2eq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686661265; x=1689253265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TLZqf6X/lOVmCq6dcL8fAW/4Qa2W1ozlpyLia0p++0=;
        b=AbXELxUUgUiyCIvvYJK8jCLKTnuT8Ksx1cENxpJjg4iDvu5N08zEkf8l6wPJ7D6t5r
         z07suxNAuTO6nW4sC++h3EsUNaqDbarsmjP99RFJSLGSO0nyS8V36rcGj+wnKo3J+MHL
         FIpzznDMNXhqoziZzhYSiyPxBiQZb9BlCks97hzXG+eUbPY9/+E97eBuJYPLsk0oWGDn
         Q4dVOXoBKzeNRVz0Jx5GqBAvbXZw0l2I9vHAll5CYbXaF2bb6hgqhMf9Q0zWfbW86AXK
         MakEhIGj45rifEi3rW9h+dDRQIIyr5N0S+0QLW599+p/NotoIef6cszmkcjs1OlfVeql
         XuyA==
X-Gm-Message-State: AC+VfDyYoxW/SIE72FTOnEHZRcKG3ijZVtilqq/jnFKhFw+bl6mKXI47
        TWm2aoFyst1KmzlHEcZZvu+DbQ==
X-Google-Smtp-Source: ACHHUZ4a+7/6S+KwcMX6eDYPTBlFQ+4k9K0mqeAmugHESM4BCX5ZT18ky3mzRqeYaSY3kjrMe/qckg==
X-Received: by 2002:a19:6d1c:0:b0:4f6:424c:4fa8 with SMTP id i28-20020a196d1c000000b004f6424c4fa8mr5216464lfc.17.1686661265065;
        Tue, 13 Jun 2023 06:01:05 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u24-20020ac243d8000000b004f14ae5ded8sm1793786lfl.28.2023.06.13.06.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 06:01:04 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] dt-bindings: rtc: isl12022: add bindings for battery alarm trip levels
Date:   Tue, 13 Jun 2023 15:00:05 +0200
Message-Id: <20230613130011.305589-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230613130011.305589-1-linux@rasmusvillemoes.dk>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The isl12022 has a built-in support for monitoring the voltage of the
backup battery, and setting bits in the status register when that
voltage drops below two predetermined levels (usually 85% and 75% of
the nominal voltage). However, since it can operate at wide range of
battery voltages (2.5V - 5.5V), one must configure those trip levels
according to which battery is used on a given board.

Add bindings for defining these two trip levels. While the register
and bit names suggest that they should correspond to 85% and 75% of
the nominal battery voltage, the data sheet also says

  There are total of 7 levels that could be selected for the first
  alarm. Any of the of levels could be selected as the first alarm
  with no reference as to nominal Battery voltage level.

Hence this provides the hardware designer the ability to choose values
based on the discharge characteristics of the battery chosen for the
given product, rather than just having one battery-microvolt property
and having the driver choose levels close to 0.85/0.75 times that.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 .../devicetree/bindings/rtc/intersil,isl12022.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml b/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
index 7c1e638d657a..d5d3a687a34d 100644
--- a/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
+++ b/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
@@ -22,6 +22,18 @@ properties:
   interrupts:
     maxItems: 1
 
+  isil,trip-level85-microvolt:
+    description: |
+      The battery voltage at which the first alarm should trigger
+      (normally ~85% of nominal V_BAT).
+    enum: [2125000, 2295000, 2550000, 2805000, 3060000, 4250000, 4675000]
+
+  isil,trip-level75-microvolt:
+    description: |
+      The battery voltage at which the second alarm should trigger
+      (normally ~75% of nominal V_BAT).
+    enum: [1875000, 2025000, 2250000, 2475000, 2700000, 3750000, 4125000]
+
 required:
   - compatible
   - reg
@@ -39,6 +51,8 @@ examples:
             compatible = "isil,isl12022";
             reg = <0x6f>;
             interrupts-extended = <&gpio1 5 IRQ_TYPE_LEVEL_LOW>;
+            isil,trip-level85-microvolt = <2550000>;
+            isil,trip-level75-microvolt = <2250000>;
         };
     };
 
-- 
2.37.2

