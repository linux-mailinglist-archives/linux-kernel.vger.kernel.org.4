Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878406C5D41
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCWDad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjCWDab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:30:31 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD1F2596C;
        Wed, 22 Mar 2023 20:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1679542229;
  x=1711078229;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gq0qyZKNaLBz1ZipLKUy2zilo/3yGKq4flu6j9JgEcA=;
  b=iRriFXrUbG8ZFhqeHZ1uVjNW+tOz93Ig1Z+TqoibcufxsZlVNH7JOWPC
   AVosds7ex1B0xjxtBpjWWZDrUsSG9gGrHuTS8WbilIL5uJ0nyXfq+HJ+P
   0LX9k5I7eEVhLl42X0h1bGNw38NXxxw+00dRLUOqayyiJCthmV8jVqp8c
   1XTTOPScPqUu5gBD/WvDkLsNwwFcOEg4VwTdEHe0KECRCFhZQ7btfBK+9
   QU0UxPSV2emv6M3Skcil225+IaJdyN12BcfKnpfSpHAmRvB/fxypMguwL
   JQ4hVefIsMNkyNPbTHTREEmbQOshZJdByLcn3VgUxdgqD8Lhz/tr37o/G
   Q==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Davis <afd@ti.com>
CC:     <kernel@axis.com>, Hermes Zhang <chenhuiz@axis.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: power: supply: bq256xx: Add ti,no-thermistor property
Date:   Thu, 23 Mar 2023 11:30:11 +0800
Message-ID: <20230323033012.416953-1-chenhuiz@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new property ti,no-thermistor to indicate that no thermistor is
connected to the TS pin of the chip.

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
---

Notes:
    v2: change property name to ti,no-thermistor

 .../bindings/power/supply/bq256xx.yaml        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
index 82f382a7ffb3..ab9ae6ca7700 100644
--- a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
@@ -68,11 +68,30 @@ properties:
       Interrupt sends an active low, 256 μs pulse to host to report the charger
       device status and faults.
 
+  ti,no-thermistor:
+    type: boolean
+    description: |
+      Indicates that no thermistor is connected to the TS pin
+
 required:
   - compatible
   - reg
   - monitored-battery
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,bq25600
+              - ti,bq25601
+              - ti,bq25600d
+              - ti,bq25601d
+    then:
+      properties:
+        ti,no-thermistor: false
+
 additionalProperties: false
 
 examples:
-- 
2.30.2

