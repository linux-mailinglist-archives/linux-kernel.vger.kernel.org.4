Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97F66C6095
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjCWHYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCWHYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:24:02 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D880DD314;
        Thu, 23 Mar 2023 00:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1679556237;
  x=1711092237;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SvXAG2jDNuLCJnrfLAviQ8j1hoAX9mmEncQJwxlEACw=;
  b=Eqt+OyVxzUyDqxDmnHAWClEllrOlWq+Zm/tYjYYAdgQjQ0Ruh+snSilw
   whAWKu7i8Z2RuU/elIQfXq6wrcXDbYrF2Hi7jLbCX7chboxciLtH43Tdb
   5Yjkpcgk9WZEUc/9LOikUzuTHK+8Na8IIC961xe79aYNnAvOrFEoLjg5Z
   hNHewz8NsgzYVoWWJoLUmO7n0u829IHOdJ3Pktoxtz4LEzJNQGNBxOE+u
   HwsAfvjkg5dwwzPzjHFLxbcTVAjiHw6DkiRzlc76J5Tj192/h9e1YnCPL
   lcDg30A3aQjP/kj/dHLxoOauJAYamqiM5aJUfwLfj9nt2FZP0m8vNM0Eo
   A==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Davis <afd@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: power: supply: bq256xx: Add ti,no-thermistor property
Date:   Thu, 23 Mar 2023 15:23:46 +0800
Message-ID: <20230323072347.438932-1-chenhuiz@axis.com>
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

    v3: drop "|" in property description

 .../bindings/power/supply/bq256xx.yaml         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
index 82f382a7ffb3..4fe9c3705265 100644
--- a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
@@ -68,11 +68,29 @@ properties:
       Interrupt sends an active low, 256 μs pulse to host to report the charger
       device status and faults.
 
+  ti,no-thermistor:
+    type: boolean
+    description: Indicates that no thermistor is connected to the TS pin
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

