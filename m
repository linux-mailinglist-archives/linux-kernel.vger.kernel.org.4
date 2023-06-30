Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A91974383D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjF3JXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjF3JWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:22:55 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F97535AF;
        Fri, 30 Jun 2023 02:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1688116975;
  x=1719652975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jp23SoY0A89Wy3Z2zA4/6qa4NlchrQutGkx1p0uuPYk=;
  b=qLirsg7ufImVJ9OJleQz85WTnEKRlIG5N/akCRiU2OnciJB7vsPPRFfT
   tFrx2djsweiz+M5+dP5iZakxZpARNU9XyvKT9JdBaSiPNorkT+BR2NeFK
   5ZFBR7wFoHWRSPhg8ukemSoO1/oA4Xq0efgKR+GtEVURpcv6rHTVYSC13
   uwlX4HvGFIgTy+MP/ZlllUlgymZcd8X3Ac8BjCyVtxf09hUANUMq1iYQM
   g9O7TX3kF3UDiflzOUnnGUaciTadi7JV1ltcDpnwjdh3/NeGxl5bh54gd
   uLFG3KZ0AeFrJQNEh+MfkJMz2A5ELm/GDPhZqQLu44HQfL2RMwqAhYeQi
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
Subject: [PATCH v2 2/2] dt-bindings: leds: Read max-brightness from devicetree
Date:   Fri, 30 Jun 2023 11:22:47 +0200
Message-ID: <20230630092248.4146169-3-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230630092248.4146169-1-astrid.rost@axis.com>
References: <20230630092248.4146169-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add max-brightness in order to reduce the current on the connected LEDs.
Normally, the maximum brightness is determined by the hardware, and this
property is not required. This property is used to set a software limit.
It could happen that an LED is made so bright that it gets damaged or
causes damage due to restrictions in a specific system, such as mounting
conditions. Note that led-max-microamp should be preferably used, if it
is supported by the controller.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 Documentation/devicetree/bindings/leds/common.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index 11aedf1650a1..603a5630fc3d 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -160,6 +160,16 @@ properties:
       For flash LED controllers with configurable current this property is
       mandatory for the LEDs in the non-flash modes (e.g. torch or indicator).
 
+  max-brightness:
+    description:
+      Normally, the maximum brightness is determined by the hardware, and
+      this property is not required. This property is used to set a software
+      limit. It could happen that an LED is made so bright that it gets damaged
+      or causes damage due to restrictions in a specific system, such as
+      mounting conditions. Note that led-max-microamp should be preferably used,
+      if it is supported by the controller.
+    $ref: /schemas/types.yaml#definitions/uint32
+
   panic-indicator:
     description:
       This property specifies that the LED should be used, if at all possible,
-- 
2.30.2

