Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65382745CC9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjGCND2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjGCND0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:03:26 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83636DD;
        Mon,  3 Jul 2023 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1688389405;
  x=1719925405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KbvtwpanuwW6qJCP+fYqUb+ooGXEb/YS8TqTqotN8+8=;
  b=gr9kcHuQAoHVpCDeS9o3cqK8KHu4TtGi07N1D6zea6vVl6FA54wDGMYp
   c+ywtsIZz38HT144FCfz8tK9RUONDgAXhZ2TOC5RzC9GtMVjkJT9SeHoc
   cXsAn4tP29FocAAVh0rrPyu7FaRDPSxMDgzao89b1k3I3WK97O2i2BSM+
   Hcn7U425UC1Iqpun7l+bwNy1/MR1AI6P5+iUfbnIY1LLUWH4Th8wirboN
   t936FRDnIRBOrp/KQsK7MpK4lzEfAl9rYype3wOkZiqLZztLdUFY1yXuD
   jLAE9F6AGaNgLbyLiTzZ11Q6Y0MSM1N94v52kIdfzMfIpVW7xp6XeEqKY
   w==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Jacek Anaszewski" <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Lee Jones" <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <kernel@axis.com>, Astrid Rost <astrid.rost@axis.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: leds: Read max-brightness from devicetree
Date:   Mon, 3 Jul 2023 15:03:12 +0200
Message-ID: <20230703130313.548519-2-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230703130313.548519-1-astrid.rost@axis.com>
References: <20230703130313.548519-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally, the maximum brightness is determined by the hardware, and this
property is not required. This property is used to set a software limit.
It could happen that an LED is made so bright that it gets damaged or
causes damage due to restrictions in a specific system, such as mounting
conditions.
Note that this flag is mainly used for PWM-LEDs, where it is not possible
to map brightness to current. Drivers for other controllers should use
led-max-microamp.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 Documentation/devicetree/bindings/leds/common.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index 11aedf1650a1..16f08d0939ce 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -160,6 +160,18 @@ properties:
       For flash LED controllers with configurable current this property is
       mandatory for the LEDs in the non-flash modes (e.g. torch or indicator).
 
+  max-brightness:
+    description:
+      Normally, the maximum brightness is determined by the hardware, and this
+      property is not required. This property is used to set a software limit.
+      It could happen that an LED is made so bright that it gets damaged or
+      causes damage due to restrictions in a specific system, such as mounting
+      conditions.
+      Note that this flag is mainly used for PWM-LEDs, where it is not possible
+      to map brightness to current. Drivers for other controllers should use
+      led-max-microamp.
+    $ref: /schemas/types.yaml#definitions/uint32
+
   panic-indicator:
     description:
       This property specifies that the LED should be used, if at all possible,
-- 
2.30.2

