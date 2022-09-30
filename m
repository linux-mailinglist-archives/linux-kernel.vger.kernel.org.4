Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AEB5F15BE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiI3WGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiI3WGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:06:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D3CE9CD7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:06:22 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d1-20020a17090a6a4100b002095b319b9aso4413532pjm.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Y9VRjEp6QontmBk9Z592SXIXMq9CUDCevIUJ0jwzSh0=;
        b=R0t5iSNNcaOpVO8qkmSY95uwo2sZ+1kmSpsGW6vxM9AoIIf4FvJLnyn0nBApjMnphD
         kpCOHcn/oRcS8CV3F8zLEeGFUPi+bh7D1+4W57O9+ksRfWPUavndDDbG8lZVhMj7QDla
         xKxrJlmO6CNUWD+vHohQHRRg0ecSpx93rWwo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Y9VRjEp6QontmBk9Z592SXIXMq9CUDCevIUJ0jwzSh0=;
        b=Zz9k7bpWeAju1vXxHHlCwY8fbMf/hrYmQ6/LlUL+DM5t6FnVLAW1ebq/kp+fn/xHLE
         bTDHl3FbIyv/NiV7yW7UctduQQPRbaqKH1k2gwtMvwlUBtvkKXdOZZWlEbZRKIGECbpU
         BYhdeBLJcmcSecanx/loFz7woMn2jKT2grzpWzEGmkRWw1vbP9tOKh6jUav0n7dh9kWx
         3pm3XVkFZtHeKa6JIfpKC8kj0KdTX8qI+6Wca98vb+0iH/NUget0HkBOTz8SQ3XLjXBm
         B1kR330qUcHBzEwU++wK/Mw95I7QzMN9C4xDDw5YhQUP4/zPf/eMrT65tcdLut+zTk0d
         zfWg==
X-Gm-Message-State: ACrzQf1C8LjvlVTejJkFajskYxrGoV4GimxPltdoI2VLFM0a05Nx90FY
        a5UzZAzci5Xs0nePiia4hTZ1vg==
X-Google-Smtp-Source: AMsMyM4LobKNX8w6hhUeaEfj4mrd3Fqg0x0hN2O10AMON0R7ueZcQPlMiKj8E3ZDzAPWSlMhShFwUA==
X-Received: by 2002:a17:902:db11:b0:17d:5e67:c51c with SMTP id m17-20020a170902db1100b0017d5e67c51cmr1217124plx.64.1664575576803;
        Fri, 30 Sep 2022 15:06:16 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:9d:2:ab9d:610e:ee54:d4ca])
        by smtp.gmail.com with ESMTPSA id f91-20020a17090a706400b001facf455c91sm5769364pjk.21.2022.09.30.15.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 15:06:16 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH 4/4 v5] dt-bindings: memory: Add jedec,lpddrX-channel binding
Date:   Fri, 30 Sep 2022 15:06:06 -0700
Message-Id: <20220930220606.303395-4-jwerner@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220930220606.303395-1-jwerner@chromium.org>
References: <20220930220606.303395-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new device tree binding for an LPDDR channel to serve
as a top-level organizing node for LPDDR part nodes nested below it. An
LPDDR channel needs to have an "io-width" property to describe its width
(this is important because this width does not always match the io-width
of the part number, indicating that multiple parts are wired in parallel
on the same channel), as well as one or more nested "rank@X" nodes.
Those represent information about the individual ranks of each LPDDR
part connected on that channel and should match the existing
"jedec,lpddrX" bindings for individual LPDDR parts.

New platforms should be using this node -- the existing practice of
providing a raw, toplevel "jedec,lpddrX" node without indication of how
many identical parts are in the system should be considered deprecated.

Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 .../ddr/jedec,lpddr-channel.yaml              | 146 ++++++++++++++++++
 .../ddr/jedec,lpddr-props.yaml                |  10 +-
 2 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml

Changelog:

- v2:
  - changed $ref for rank subnode to specifically match LPDDR type in
    compatible string
  - moved `reg` up to be listed right below `compatible`
- v3:
  - no changes
- v4:
  - no changes
- v5:
  - no changes

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml
new file mode 100644
index 00000000000000..34b5bd153f63e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr-channel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPDDR channel with chip/rank topology description
+
+description:
+  An LPDDR channel is a completely independent set of LPDDR pins (DQ, CA, CS,
+  CK, etc.) that connect one or more LPDDR chips to a host system. The main
+  purpose of this node is to overall LPDDR topology of the system, including the
+  amount of individual LPDDR chips and the ranks per chip.
+
+maintainers:
+  - Julius Werner <jwerner@chromium.org>
+
+properties:
+  compatible:
+    enum:
+      - jedec,lpddr2-channel
+      - jedec,lpddr3-channel
+      - jedec,lpddr4-channel
+      - jedec,lpddr5-channel
+
+  io-width:
+    description:
+      The number of DQ pins in the channel. If this number is different
+      from (a multiple of) the io-width of the LPDDR chip, that means that
+      multiple instances of that type of chip are wired in parallel on this
+      channel (with the channel's DQ pins split up between the different
+      chips, and the CA, CS, etc. pins of the different chips all shorted
+      together).  This means that the total physical memory controlled by a
+      channel is equal to the sum of the densities of each rank on the
+      connected LPDDR chip, times the io-width of the channel divided by
+      the io-width of the LPDDR chip.
+    enum:
+      - 8
+      - 16
+      - 32
+      - 64
+      - 128
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^rank@[0-9]+$":
+    type: object
+    description:
+      Each physical LPDDR chip may have one or more ranks. Ranks are
+      internal but fully independent sub-units of the chip. Each LPDDR bus
+      transaction on the channel targets exactly one rank, based on the
+      state of the CS pins. Different ranks may have different densities and
+      timing requirements.
+    required:
+      - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: jedec,lpddr2-channel
+    then:
+      patternProperties:
+        "^rank@[0-9]+$":
+          $ref: /schemas/memory-controllers/ddr/jedec,lpddr2.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: jedec,lpddr3-channel
+    then:
+      patternProperties:
+        "^rank@[0-9]+$":
+          $ref: /schemas/memory-controllers/ddr/jedec,lpddr3.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: jedec,lpddr4-channel
+    then:
+      patternProperties:
+        "^rank@[0-9]+$":
+          $ref: /schemas/memory-controllers/ddr/jedec,lpddr4.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: jedec,lpddr5-channel
+    then:
+      patternProperties:
+        "^rank@[0-9]+$":
+          $ref: /schemas/memory-controllers/ddr/jedec,lpddr5.yaml#
+
+required:
+  - compatible
+  - io-width
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    lpddr-channel0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      compatible = "jedec,lpddr3-channel";
+      io-width = <32>;
+
+      rank@0 {
+        compatible = "lpddr3-ff,0100", "jedec,lpddr3";
+        reg = <0>;
+        density = <8192>;
+        io-width = <16>;
+        revision-id = <1 0>;
+      };
+    };
+
+    lpddr-channel1 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      compatible = "jedec,lpddr4-channel";
+      io-width = <32>;
+
+      rank@0 {
+        compatible = "lpddr4-05,0301", "jedec,lpddr4";
+        reg = <0>;
+        density = <4096>;
+        io-width = <32>;
+        revision-id = <3 1>;
+      };
+
+      rank@1 {
+        compatible = "lpddr4-05,0301", "jedec,lpddr4";
+        reg = <1>;
+        density = <2048>;
+        io-width = <32>;
+        revision-id = <3 1>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
index 92ef660888f318..30267ce701249a 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
@@ -9,7 +9,8 @@ title: Common properties for LPDDR types
 description:
   Different LPDDR types generally use the same properties and only differ in the
   range of legal values for each. This file defines the common parts that can be
-  reused for each type.
+  reused for each type. Nodes using this schema should generally be nested under
+  an LPDDR channel node.
 
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
@@ -25,6 +26,13 @@ properties:
       The latter form can be useful when LPDDR nodes are created at runtime by
       boot firmware that doesn't have access to static part number information.
 
+  reg:
+    description:
+      The rank number of this LPDDR rank when used as a subnode to an LPDDR
+      channel.
+    minimum: 0
+    maximum: 3
+
   revision-id:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description:
-- 
2.31.0

