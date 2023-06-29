Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2B97427A9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjF2Nre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjF2Nrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:47:32 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AB5358A;
        Thu, 29 Jun 2023 06:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1688046452;
  x=1719582452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mRwhJbcypJGWdkrQyemMfvhuOL1PFCUxpQrwdJedum4=;
  b=dKfXCQCN2vA5NEY0E47gha8oEDzuiNiCFHsPSfN3jPSzYzSOfvULH5j+
   idHpzxvVV4ZxWhzB98MDKPoZ6mZNAvcgZp6bqleGXFNQ19ZQ+45cfwq+3
   oIanOoHxfW/sEmP4viFSyLRqUvDdfILDwXEyvFuhh7GK0fhZgNYi6WZUO
   5pOjo1gLEAg/xzuE6em4X8yzV4IwuTUXOj6nlX6J5kv4btfC4LWsWdn1i
   CSZ/StfhRuDHZkKllnA6zqsNrIXIRFkyi4dBfRZjIcIXxP3vsO94A9dRW
   XHwUINOonQ1nvRAlGlswzILMAv+up10G6yUsjbgAEbwhjc29vzwNtaIqr
   Q==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Dan Murphy <dmurphy@ti.com>, Andrew Davis <afd@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <kernel@axis.com>, Astrid Rost <astrid.rost@axis.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] dt: bindings: lp50xx: Add max-brightness as in leds-pwm
Date:   Thu, 29 Jun 2023 15:47:22 +0200
Message-ID: <20230629134722.3908637-3-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230629134722.3908637-1-astrid.rost@axis.com>
References: <20230629134722.3908637-1-astrid.rost@axis.com>
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

Add max-brightness in order to reduce the current on the connected LEDs.
Normally, the maximum brightness is determined by the hardware, and this
property is not required. This property is used to set a software limit.
It could happen that an LED is made so bright that it gets damaged or
causes damage due to restrictions in a specific system, such as mounting
conditions.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 Documentation/devicetree/bindings/leds/leds-lp50xx.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
index 402c25424525..6a1425969cb4 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
@@ -73,6 +73,15 @@ patternProperties:
       '#size-cells':
         const: 0
 
+      max-brightness:
+        description:
+          Normally, the maximum brightness is determined by the hardware, and
+          this property is not required. This property is used to set a software
+          limit. It could happen that an LED is made so bright that it gets
+          damaged or causes damage due to restrictions in a specific system,
+          such as mounting conditions.
+        $ref: /schemas/types.yaml#definitions/uint32
+
     patternProperties:
       "^led@[0-9a-f]+$":
         type: object
-- 
2.30.2

