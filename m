Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264C462EDCE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241312AbiKRGlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241204AbiKRGkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:40:21 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B37D9B38F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:40:05 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v7so2992026wmn.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwqZ6bHe38ejHWFsTDNDVxTBbmVwhf5JNKrEtYz9FZA=;
        b=as20voiLmig+25kU6r0QcNApNi30Fh7mJu8u03k5/fd/EdT2zwCmG2Qwj2ozSqqBZR
         PqRROQEElPFMq//UtDqmY9FCSYMIUTP6LM8A+mdiKNxy5eSSWRha20xDVMj6dl4j5Ods
         7FbdTP+U3yczFp5zD4nBClQ2hDXKqIWOV/CE/geNhE8XMD5bE4+rkHSxLjlZkRa1SDG1
         Ot/1du0t1BPWE8HvDbJ5D01k80WjfsAsNyENl9hntN5M6gFGPpFjofQLuNZ/ElSMFV0h
         rnmiAzijK5yW6xYqcL9xQ1Z7nlJv0ryiCnpB19R/ZNqHJM/PN029amUuZn/DOedAcZ99
         exJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwqZ6bHe38ejHWFsTDNDVxTBbmVwhf5JNKrEtYz9FZA=;
        b=Neq5R7kAW4gAO400tcOVUoAAcUGtzYOP+ir55Ee73YbeTDGLyP1gnJxXM8Uci0Xr70
         Pd3j8LuSt+GHnqlAd/N/m4tOgx2N0XO8qMZhzR46lAO95Aypcmn/48h6dGFBIWvv09gp
         UEXkB5NahonNN+w6rqhiJUlJeyUY9Htu1fJ6bcrREG2B54RmXnSyTedXcR57s4xe0zsi
         k66xM1yPof57aXtJvycu8CO3/GJuXmDYmhMTrODntJjJpRfbbO8+pleVLNERoHesU1JQ
         xsN4O2fk2OS0Um79gbICwEml5M1ziLVAWt7djMpwerQn8EQyVfRA4ltydxyhwDQywRj4
         hZIQ==
X-Gm-Message-State: ANoB5pm4iUbNlgmjh1wLvkSljYRCc/3JsxfmQGwX0OCzlC2tkCC50MVg
        WIBcXmygyLpFo9iO0ppRuQiO4w==
X-Google-Smtp-Source: AA0mqf6k+mv9SZe8bzyBXgZ0LCeo3iX4JCk0LGAjsldK73qlhYdInn9s7+ztH8/+QU6JexUxCMSCBQ==
X-Received: by 2002:a05:600c:3587:b0:3cf:a9c2:2b04 with SMTP id p7-20020a05600c358700b003cfa9c22b04mr3804222wmq.152.1668753603926;
        Thu, 17 Nov 2022 22:40:03 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id j13-20020adff54d000000b0023655e51c33sm2785902wrp.4.2022.11.17.22.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:40:03 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/13] dt-bindings: nvmem: Introduce the nvmem-layout container
Date:   Fri, 18 Nov 2022 06:39:28 +0000
Message-Id: <20221118063932.6418-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
References: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

The nvmem devices description works like this:

* Most cases (EEPROM & co):

eeprom@x {
	 compatible = "<eeprom-compatible>";
	 ...
};

* MTD case:

flash@y {
	compatible = "<flash-compatible>";
	...
	otp {
		compatible = "user-otp"; /* or "factory-otp" */
		...
	};
};

In the former case, the nvmem device is "eeprom@x", while in the latter
case the nvmem device is "otp".

Nvmem devices can produce nvmem cells. The current way to describe nvmem
cells is to locate them by providing their static byte and bit offset
and length. These information are stored in subnodes of the nvmem
device.

It is now a fact that such description does not fit more advanced use
cases where the location or the size of the cells may vary. There are
currently three known situations which require being described
differently: Kontron's SL28 VPD, ONIE's TLV table and U-Boot's
environment variables.

Hence, we need a way to describe the parsers that must be used in order
to make the dynamic discovery of the nvmem cells. This new description
must fit both use cases (the generic situation and the MTD case).

Let's create in both cases a container node named nvmem-layout whose
content will depend on the parser. Right now nvmem-layout.yaml is
"empty", but references to additional layout parser bindings will be
inserted in the near future. The final goal being something that looks
like:

* Most cases (EEPROM & co):

eeprom@x {
	compatible = "<eeprom-compatible>";
	...
	nvmem-layout {
		compatible = "<parser-compatible>";
		...
	};
};

* MTD case:

flash@y {
	compatible = "<flash-compatible>";
	...
	otp {
		compatible = "user-otp"; /* or "factory-otp" */
		...
		nvmem-layout {
			compatible = "<parser-compatible>";
			...
		};
	};
};

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/layouts/nvmem-layout.yaml  | 30 +++++++++++++++++++
 .../devicetree/bindings/nvmem/nvmem.yaml      |  7 +++++
 2 files changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
new file mode 100644
index 000000000000..ecc7c37cbc1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/layouts/nvmem-layout.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVMEM (Non Volatile Memory) layouts
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+  - Michael Walle <michael@walle.cc>
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+description: |
+  Most NVMEM layouts are static and thus do not require additional description
+  besides the bytes/bits offset and length. Other layouts can be less statically
+  define and might require dynamic reading of the NVMEM device in order to
+  perform their parsing. The nvmem-layout container is here to describe these.
+
+properties:
+  compatible: true
+
+  '#address-cells': false
+
+  '#size-cells': false
+
+required:
+  - compatible
+
+unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 0455506fc30f..75bb93dda9df 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -39,6 +39,13 @@ properties:
       when it's driven low (logical '0') to allow writing.
     maxItems: 1
 
+  nvmem-layout:
+    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
+    description:
+      Alternative to the statically defined nvmem cells, this
+      container may reference more advanced (dynamic) layout
+      parsers.
+
 patternProperties:
   "@[0-9a-f]+(,[0-7])?$":
     type: object
-- 
2.25.1

