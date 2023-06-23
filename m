Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0497273B65B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjFWLdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjFWLdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:33:37 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C2CD3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:33:35 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b45bc83f26so9558211fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1687520014; x=1690112014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItH4Pg7jxqco9mS/zUwcLIsvKjoWsb65kGsf9QvB3Qs=;
        b=UOJiSnXVBXDwtiw7hkY3RS495zKUvrRo3305RzR5u/Ea5HWCNy8TZb6T2DYp45BYc1
         7Eli8yLXnwF7pmC4Cm253Z1VzQId5Xov5p6hhPu/OO5TXM5rg7pmqSzogWxG5pO0rDs3
         RdqUvzIoMuw1zQDKcNCcu2d7pZKca19joPPcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687520014; x=1690112014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItH4Pg7jxqco9mS/zUwcLIsvKjoWsb65kGsf9QvB3Qs=;
        b=IIobY1wXd0qDX+ashm1PiYGXMTqgLwh9HSlV6JNqzc43R92XcwBbQ2WnQvROgtJ1Py
         6N/YYixgo9g6LUMwsApv+dCIhK0q5QvhC7Wq2Yr3sfsQalubs1l7LDQT7cGUpu13OpaM
         VQCR0zAXPernF7h4d3+tDEk3lbTelixRzz5abL5bb2urG4sCr+tOs2lEULpOsXE6hnuG
         Hkoa9PMfZSeoQIJy6oXkwapE6gD/FluzHVlvIzSj/Nh81hcRSiXyHmUbQJ4DCoZuxcRP
         2Bc2AJiA5TrG05KQOEYrSGckMwgUe+rbFuW09+f1dMnNUTtEoNAQjvbYpNaRY5Y/luie
         PWfg==
X-Gm-Message-State: AC+VfDz2sUHmUh67czrD4Cz4LpPQyElmXljv1NwTZ30VqWnj2DCIjzF+
        Z7eZiZrA5FRvldlbxrxjwnxiyDWY0/Gy8CGYG57VaA==
X-Google-Smtp-Source: ACHHUZ7qO4OC1EC6XyojwSPlB9l6hMdD419uyQ/ieDUyzzt51BVNpsgYqiGk9wLIVRh9KzDWj6AWow==
X-Received: by 2002:a2e:961a:0:b0:2b5:7af9:f390 with SMTP id v26-20020a2e961a000000b002b57af9f390mr7940759ljh.47.1687520014000;
        Fri, 23 Jun 2023 04:33:34 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id n10-20020a2e720a000000b002b471efb253sm1711605ljc.46.2023.06.23.04.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 04:33:33 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: ad74413r: add binding for digital input threshold
Date:   Fri, 23 Jun 2023 13:33:25 +0200
Message-Id: <20230623113327.1062170-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230623113327.1062170-1-linux@rasmusvillemoes.dk>
References: <20230623113327.1062170-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow specifying the threshold for which the channels configured as
digital input change state.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---

Running dt_binding_check on this with a too small or large value in
the example does give me an error, but the multipleOf does not seem to
be enforced; the value 1234567 is not flagged. I don't know if that's
expected (maybe I have too old versions of something).


 .../devicetree/bindings/iio/addac/adi,ad74413r.yaml    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
index 590ea7936ad7..1f90ce3c7932 100644
--- a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
@@ -51,6 +51,14 @@ properties:
       Shunt (sense) resistor value in micro-Ohms.
     default: 100000000
 
+  digital-input-threshold-microvolt:
+    description:
+      Comparator threshold used by the channels configured to use the
+      digital input function.
+    minimum: 500000
+    maximum: 16000000
+    multipleOf: 500000
+
   reset-gpios:
     maxItems: 1
 
@@ -143,6 +151,8 @@ examples:
         refin-supply = <&ad74413r_refin>;
         reset-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
 
+        digital-input-threshold-microvolt = <4000000>;
+
         channel@0 {
           reg = <0>;
 
-- 
2.37.2

