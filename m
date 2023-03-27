Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11C16CA6C4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjC0OEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjC0OEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:04:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABFCE1B7;
        Mon, 27 Mar 2023 07:04:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A62E1042;
        Mon, 27 Mar 2023 07:05:08 -0700 (PDT)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 087A93F6C4;
        Mon, 27 Mar 2023 07:04:22 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     sudeep.holla@arm.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, nicola.mazzucato@arm.com,
        cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 1/2] dt-bindings: firmware: arm,scmi: Support mailboxes unidirectional channels
Date:   Mon, 27 Mar 2023 15:03:41 +0100
Message-Id: <20230327140342.222168-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327140342.222168-1-cristian.marussi@arm.com>
References: <20230327140342.222168-1-cristian.marussi@arm.com>
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

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../bindings/firmware/arm,scmi.yaml           | 42 +++++++++++++++++--
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 2f7c51c75e85..9a7dc30e386f 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -63,10 +63,24 @@ properties:
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
@@ -234,7 +248,7 @@ $defs:
 
       mboxes:
         minItems: 1
-        maxItems: 2
+        maxItems: 3
 
       shmem:
         minItems: 1
@@ -393,6 +407,26 @@ examples:
         };
     };
 
+  - |
+    firmware {
+        scmi {
+            compatible = "arm,scmi";
+            mboxes = <&mhu_U_tx 0 0>, <&mhu_U_rx 0 0>;
+            shmem = <&cpu_scp_lpri0>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            scmi_dvfs_2: protocol@13 {
+                reg = <0x13>;
+                #clock-cells = <1>;
+
+                mboxes = <&mhu_U_tx 1 0>, <&mhu_U_rx 1 0>, <&mhu_U_rx 1 1>;
+                shmem = <&cpu_scp_hpri0>, <&cpu_scp_hpri1>;
+            };
+        };
+    };
+
   - |
     firmware {
         scmi {
-- 
2.34.1

