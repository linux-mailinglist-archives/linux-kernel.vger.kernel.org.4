Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3056562EDCD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbiKRGlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241266AbiKRGkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:40:19 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158A39A5E6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:40:08 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p16so2970050wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPPUT8OZcdGbmcOje0alVHTjcSJCdi3sbLbXmwtpADc=;
        b=nL31WEo0j8ZhjFDmWbk581z8F16Fa09DKKwG1YDv9xsgtWcG+9YyX4jojZzmGzMnUS
         w84Gum5iz+cO5zFGHz9y+Zpmm/cA2ucdRlNg7u8CL6svjJoN93Jgy4rCWeegjfpBpLLJ
         k6QdVHdWaDF4mYstAor6DErTRaArVuvxgmOrjrAsZX3+T2c69iHAVXFwNGs/QhQWRAFL
         6cQyWOGMACclqNEUEO1QX1DloRKyJiQJe/0JkQs6yrBpVJOOaY+XmqoX/GBVl9LK3GHh
         NPMwffl+ofcZfXsefpiI7yo7dzO9V9bEU9vV77i3NtSoAkMian1Ra2UXdDNI9F+CGWq/
         BdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPPUT8OZcdGbmcOje0alVHTjcSJCdi3sbLbXmwtpADc=;
        b=g7EXp6wkhSUwM4VNuBryQn2PREjc+DjuKvj/uFSUOeoIazZokGm+wJpmyYeCp/19ZZ
         m9pIsFU+8Qsn7mdi+IQh28wO+ENtDhcHhp3n7QiBKZ/SQOKVHbEydMmBlUGPg5vuQn1e
         gKIycP2YlLbR2rtCOFvOPylH7Ks26Xtc4xnbiAJRkzokbn02klfBK1E+ePDq/uJk+ElH
         AaD2/XltoCy5IR0YxocztyWuIy13XppVm/MqbvyysQtLDDRzieiEX9i1YvOlin4X2Wcu
         /voOA3c2ZbUoUgzeLXVFh5vKx4IffAwalJ0o/VWmiavZ1qfpVWa+oK4itNeeFxu/gTdM
         M8Iw==
X-Gm-Message-State: ANoB5pkp3P8kxdjJfzLLv27EfmVrBBPTE8c/e4OJs3EP+bUB5Al2xduN
        bnVFW5/Hi4n7mjo8sN1KmkrxNw==
X-Google-Smtp-Source: AA0mqf6rai2ezEjEtk+bgJY1yscUazH7fX5+WW4Ted38vOsTErgh9xqXLWXm9M6txtf7aMw95oCG8w==
X-Received: by 2002:a05:600c:384d:b0:3cf:7217:d5fa with SMTP id s13-20020a05600c384d00b003cf7217d5famr3883323wmr.191.1668753606601;
        Thu, 17 Nov 2022 22:40:06 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id j13-20020adff54d000000b0023655e51c33sm2785902wrp.4.2022.11.17.22.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:40:05 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 11/13] dt-bindings: nvmem: add YAML schema for the sl28 vpd layout
Date:   Fri, 18 Nov 2022 06:39:30 +0000
Message-Id: <20221118063932.6418-12-srinivas.kandagatla@linaro.org>
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

From: Michael Walle <michael@walle.cc>

Add a schema for the NVMEM layout on Kontron's sl28 boards.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../nvmem/layouts/kontron,sl28-vpd.yaml       | 64 +++++++++++++++++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |  3 +
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
new file mode 100644
index 000000000000..c713e23819f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/layouts/kontron,sl28-vpd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVMEM layout of the Kontron SMARC-sAL28 vital product data
+
+maintainers:
+  - Michael Walle <michael@walle.cc>
+
+description:
+  The vital product data (VPD) of the sl28 boards contains a serial
+  number and a base MAC address. The actual MAC addresses for the
+  on-board ethernet devices are derived from this base MAC address by
+  adding an offset.
+
+select: false
+
+properties:
+  compatible:
+    const: kontron,sl28-vpd
+
+  serial-number:
+    type: object
+    description: The board's serial number
+
+    additionalProperties: false
+
+  base-mac-address:
+    type: object
+    description:
+      Base MAC address for all on-module network interfaces. The first
+      argument of the phandle will be treated as an offset.
+
+    properties:
+      "#nvmem-cell-cells":
+        const: 1
+
+    additionalProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+      otp-1 {
+          compatible = "user-otp";
+
+          nvmem-layout {
+              compatible = "kontron,sl28-vpd";
+
+              serial_number: serial-number {
+              };
+
+              base_mac_address: base-mac-address {
+                  #nvmem-cell-cells = <1>;
+              };
+          };
+      };
+
+...
diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
index ecc7c37cbc1f..f64ea2fa362d 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
@@ -17,6 +17,9 @@ description: |
   define and might require dynamic reading of the NVMEM device in order to
   perform their parsing. The nvmem-layout container is here to describe these.
 
+oneOf:
+  - $ref: kontron,sl28-vpd.yaml
+
 properties:
   compatible: true
 
-- 
2.25.1

