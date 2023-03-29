Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9816CED28
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjC2PkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjC2Pj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:39:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B99C344A2;
        Wed, 29 Mar 2023 08:39:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C699C2F4;
        Wed, 29 Mar 2023 08:40:36 -0700 (PDT)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDE033F663;
        Wed, 29 Mar 2023 08:39:50 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com, Tushar.Khandelwal@arm.com,
        viresh.kumar@linaro.org, jassisinghbrar@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: mailbox : arm,mhuv2: Allow for more RX interrupts
Date:   Wed, 29 Mar 2023 16:39:35 +0100
Message-Id: <20230329153936.394911-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230329153936.394911-1-cristian.marussi@arm.com>
References: <20230329153936.394911-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM MHUv2 Receiver block can indeed support more interrupts, up to the
maximum number of available channels, but anyway no more than the maximum
number of supported interrupt for an AMBA device.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org

 .../devicetree/bindings/mailbox/arm,mhuv2.yaml      | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
index a4f1fe63659a..5a57f4e2a623 100644
--- a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
+++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
@@ -69,10 +69,15 @@ properties:
 
   interrupts:
     description: |
-      The MHUv2 controller always implements an interrupt in the "receiver"
-      mode, while the interrupt in the "sender" mode was not available in the
-      version MHUv2.0, but the later versions do have it.
-    maxItems: 1
+      The MHUv2 controller always implements at least an interrupt in the
+      "receiver" mode, while the interrupt in the "sender" mode was not
+      available in the version MHUv2.0, but the later versions do have it.
+      In "receiver" mode, beside a single combined interrupt, there could be
+      multiple interrupts, up to the number of implemented channels but anyway
+      no more than the maximum number of interrupts potentially supported by
+      AMBA.
+    minItems: 1
+    maxItems: 9
 
   clocks:
     maxItems: 1
-- 
2.34.1

