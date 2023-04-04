Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C0B6D5F81
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbjDDLvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbjDDLvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:51:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5CB530C1;
        Tue,  4 Apr 2023 04:50:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CEDAFEC;
        Tue,  4 Apr 2023 04:51:37 -0700 (PDT)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 282F83F762;
        Tue,  4 Apr 2023 04:50:51 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     sudeep.holla@arm.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, nicola.mazzucato@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: firmware: arm,scmi: Support mailboxes unidirectional channels
Date:   Tue,  4 Apr 2023 12:50:25 +0100
Message-Id: <20230404115026.2828149-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404115026.2828149-1-cristian.marussi@arm.com>
References: <20230404115026.2828149-1-cristian.marussi@arm.com>
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

SCMI defines two kinds of communication channels between the agent and the
platform: one bidirectional 'a2p' channel used by the agent to send SCMI
commands and synchronously receive the related replies, and an optional
'p2a' unidirectional channel used to asynchronously receive delayed
responses and notifications emitted from the platform.

When configuring an SCMI transport based on mailboxes, the current binding
supports only mailboxes providing bidirectional channels: in such a case
one mailbox channel can be easily assigned to each SCMI channel as above
described.

In case, instead, to have to deal with mailboxes providing only distinct
unidirectional channels, it becomes necessary to extend the binding in
order to be able to bind 2 distinct unidirectional mailbox channels to the
same SCMI 'a2p' channel.

Bidirectional and unidirectional channels support for the SCMI mailbox
transport can coexist by carefully considering the effective combination
of defined 'mboxes' and 'shmem' descriptors.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org

v2 --> v3
- coalesced oneOf entries using proper minItems
- removed unidirectional channels example
v1 --> v2
- added mbox-names unidirectional definitions and example
---
 .../bindings/firmware/arm,scmi.yaml           | 48 +++++++++++++++----
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 2f7c51c75e85..5824c43e9893 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -56,17 +56,38 @@ properties:
     description:
       Specifies the mailboxes used to communicate with SCMI compliant
       firmware.
-    items:
-      - const: tx
-      - const: rx
+    oneOf:
+      - items:
+          - const: tx
+          - const: rx
+        minItems: 1
+      - items:
+          - const: tx
+          - const: tx_reply
+          - const: rx
+        minItems: 2
 
   mboxes:
     description:
       List of phandle and mailbox channel specifiers. It should contain
-      exactly one or two mailboxes, one for transmitting messages("tx")
-      and another optional for receiving the notifications("rx") if supported.
+      exactly one, two or three mailboxes; the first one or two for transmitting
+      messages ("tx") and another optional ("rx") for receiving notifications
+      and delayed responses, if supported by the platform.
+      The number of mailboxes needed for transmitting messages depends on the
+      type of channels exposed by the specific underlying mailbox controller;
+      one single channel descriptor is enough if such channel is bidirectional,
+      while two channel descriptors are needed to represent the SCMI ("tx")
+      channel if the underlying mailbox channels are of unidirectional type.
+      The effective combination in numbers of mboxes and shmem descriptors let
+      the SCMI subsystem determine unambiguosly which type of SCMI channels are
+      made available by the underlying mailbox controller and how to use them.
+       1 mbox / 1 shmem => SCMI TX over 1 mailbox bidirectional channel
+       2 mbox / 2 shmem => SCMI TX and RX over 2 mailbox bidirectional channels
+       2 mbox / 1 shmem => SCMI TX over 2 mailbox unidirectional channels
+       3 mbox / 2 shmem => SCMI TX and RX over 3 mailbox unidirectional channels
+      Any other combination of mboxes and shmem is invalid.
     minItems: 1
-    maxItems: 2
+    maxItems: 3
 
   shmem:
     description:
@@ -228,13 +249,20 @@ $defs:
         maxItems: 1
 
       mbox-names:
-        items:
-          - const: tx
-          - const: rx
+        oneOf:
+          - items:
+              - const: tx
+              - const: rx
+            minItems: 1
+          - items:
+              - const: tx
+              - const: tx_reply
+              - const: rx
+            minItems: 2
 
       mboxes:
         minItems: 1
-        maxItems: 2
+        maxItems: 3
 
       shmem:
         minItems: 1
-- 
2.34.1

