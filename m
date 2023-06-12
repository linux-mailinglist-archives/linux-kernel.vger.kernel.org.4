Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6A272C339
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbjFLLjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjFLLij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:38:39 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D04C6583
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:31:08 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f6255ad8aeso4949045e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686569466; x=1689161466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yg+ZdBpNlgvOVT9Mel57yzibQ4IWXPPH7Y7NoiRxgV8=;
        b=B7Fc5rs8l+9HatWL8qTZTKeUxSAhd/s0ahGyNZAoMi0LB1cmD7eWnTI573PL3J5PwY
         TPfEKiIAh1lyhuAV9Dcj4IVDw1BYb7kuRmglZEqct4uwgeR93b0+mxCTlkNBDESVw+eL
         AjL3ycniFVHhzfAU2EVnqNOKPOEGPXXhFSYlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686569466; x=1689161466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yg+ZdBpNlgvOVT9Mel57yzibQ4IWXPPH7Y7NoiRxgV8=;
        b=SmepOS7n1MrTwjysOrKu1jpugmyABjJgnke2g30YGyeVPnHWx+oVTL3bWo+8z1Hf/4
         dSCHpTXNAuTOajusM+dfwBVAQWsuc0fJ10UEDgdhiFcAdc7n9B9V5D6hlUcSmibj/iKa
         NytIrYGucZgD07mVKPwEugnF0WTNAlZEYZCeasZR+kReX0FwHEtRWIRWHl7ZHrRNjT9m
         MDcDqJ4SV65IFnDhcQO2Zx7d6lqa16t2aThX+yop199IMVXfVsrdx7fAJm+8VCxRwsmE
         238fjFJA50N2zn9asqLzc5VDietrbCKrX0ooq4uwfct0X85GPEP8Q21xJ+FvksodSeWS
         dsgg==
X-Gm-Message-State: AC+VfDwn3pIdYNGvTcZLiOS0dMVxEqWM7J3EP6JttRP/DsqtqAGG0LCg
        pzutCknzn7+qe9Uh0o/zEc/W+ABRSlxZZh436QXi9A==
X-Google-Smtp-Source: ACHHUZ6wSCynoIgW6K8OwvJAGylvueLACSd7ZTlBmVVHf1hvXbDrA/tV5u3JevmTNcOUlIYEHkjBtw==
X-Received: by 2002:a05:6512:551:b0:4ee:e0c7:434d with SMTP id h17-20020a056512055100b004eee0c7434dmr3622544lfl.51.1686569466584;
        Mon, 12 Jun 2023 04:31:06 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id w26-20020a19c51a000000b004edb8fac1cesm1399320lfe.215.2023.06.12.04.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 04:31:06 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] dt-bindings: rtc: isl12022: add bindings for battery alarm trip levels
Date:   Mon, 12 Jun 2023 13:30:53 +0200
Message-Id: <20230612113059.247275-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 899c5edc72e4..1e85a9c8945b 100644
--- a/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
+++ b/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
@@ -19,6 +19,18 @@ properties:
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
@@ -36,6 +48,8 @@ examples:
             compatible = "isil,isl12022";
             reg = <0x6f>;
             interrupts-extended = <&gpio1 5 IRQ_TYPE_LEVEL_LOW>;
+            isil,trip-level85-microvolt = <2550000>;
+            isil,trip-level75-microvolt = <2250000>;
         };
     };
 
-- 
2.37.2

