Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CF06CFBF3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjC3GwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjC3GwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:52:15 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB4F19F;
        Wed, 29 Mar 2023 23:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1680159132;
  x=1711695132;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GUkfkVjjfUh4Vh4vq6xCLs2XptKtdvQVMMQaabfQcpw=;
  b=aIJEA355ewMBlrdd6tYZHwXR0/rhkVhONW9NGBGusTo/lZs+Q/mH2xmz
   tywP9/xi0/R/ovzo+C49aJ2ZacV4obyswiLOyaX3zSfb/eqoTrYmvcKM5
   nU/XTf0WFjnvne+lVCoO6yIR9FrrYprb0VzY203fwSIVGZGe8lkygZQYO
   pKAWJv1Koc/xnZQpHJ7CvYOAOiSO6yqL0jtUl82DpfJalFA4DnmzvlAfY
   kj19x6nsyvOF/qRfNJVgy2/7Qe7gU0ArfvMvgZqW1E7wPkKjvXC69dvxG
   JIeaPc4guMXveDnzMw0IIK+T0d4qvG4E6gLk06oJ7kdzRVnf4JI71HnHi
   Q==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Davis <afd@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: power: supply: bq256xx: Add ti,no-thermistor property
Date:   Thu, 30 Mar 2023 14:52:01 +0800
Message-ID: <20230330065202.1349948-1-chenhuiz@axis.com>
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

    v4: rebase bq256xx_charger.c

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

