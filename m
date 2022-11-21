Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DE363211E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiKULrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiKULrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:47:18 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B783899;
        Mon, 21 Nov 2022 03:47:16 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id f7so15854343edc.6;
        Mon, 21 Nov 2022 03:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uJJXhf0ZouG6Lq8s9N2QMo51VNGYLGy26YpCtzoJ2sk=;
        b=OMnwEgxNbalqU/91dk07RZKyJeY3LIN8hoJUoyi4ZUcDCO+SznDrmQyTrPKMwZ+6Wl
         Qx6cuVY6MXEr6ldwwjhpkfF4DIr4risDwAoafJ8GuvHjrmIOZZoeOWz6sO48LUNvANFD
         MqRyS29A1kTIVBC28vvCAw0lsAzuf9x7BfmPloqQ+vlgtaYm+mYM9h/RFXx5yW4CaF8M
         9ROox944URXG6anEIGWGT4Ezw/LNG+Q24qfIP/fPe0SW7ms7CHGfVC0+iHDwsw/YpU2H
         xO7Oo+mcOi0t2DpeAC8c7jJhjSId5Um7B0OqFN2SguJ8z+8Gar9OMea5VVmTWxIw9l8Y
         S2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJJXhf0ZouG6Lq8s9N2QMo51VNGYLGy26YpCtzoJ2sk=;
        b=5HXyZM4hHfu1T04WNQFR6Qp+tQkZeb7Rbi8/A8XQLbb6cNoJUIPsOhOXR2nRV7CTVJ
         TB1EqQjroi14TbvhFXpFNRHg51kbXrlimzrr+KMedM/dNu1D3UqNL842TLuZ7S1BDPoa
         s0s/FE7O9M9EWDRo+NwxTLB0D+ycxPRujW1EMryDclPFZLpsuWtYj7sq222DctKv8p1I
         S36ghXNw6c63Bu9HCyPuKFAUnBr4yjruYe/PZY3Gjst7qSwkcp15Tlp2m8JmjhQFzLmo
         DpjXLOarUNH8noleh2V+gOoY0XiKs7tnL4PFgsQTdw7aNqsszXuq6PqTB7iZfPKjEemn
         Vtmw==
X-Gm-Message-State: ANoB5pl9tM71OBOQRKbdBtMA4G12W0TlTBIw/eRNQwyvIQX4CTBuHBgU
        UuMqt/IcJayXVY02H+vk4eY=
X-Google-Smtp-Source: AA0mqf4aDDhBcDN72x3wx/EDR7Z7QMMR9UBxCv5euJ+PDL5gyJvUvP5LZEM7gvGXLJvBRYzMteJtaw==
X-Received: by 2002:aa7:d3c9:0:b0:459:aa70:d4b6 with SMTP id o9-20020aa7d3c9000000b00459aa70d4b6mr16023510edr.224.1669031235224;
        Mon, 21 Nov 2022 03:47:15 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id ay12-20020a170907900c00b00780982d77d1sm4913753ejc.154.2022.11.21.03.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 03:47:14 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 dt-schema.git] schemas: add NVMEM cell with #nvmem-cell-cells
Date:   Mon, 21 Nov 2022 12:47:08 +0100
Message-Id: <20221121114708.10161-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Some NVMEM cells may provide more than 1 value. An example can be base
MAC address that is used for calculating multiple MACs (for few
different devices). For specifying value to read phandle needs to be
used with an argument.

Cc: Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>
Cc: Michael Walle <michael@walle.cc>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Drop redundant quotes (thanks Krzysztof)

Please note there is ongoing work by Michael who chose to modify
meta-schema in his work: https://github.com/devicetree-org/dt-schema/pull/89

This bit is required for moving forward with the
[PATCH v2 00/20] nvmem: core: introduce NVMEM layouts
https://lore.kernel.org/linux-arm-kernel/20220901221857.2600340-1-michael@walle.cc/

As pointed out by Rob #nvmem-cell-cells should be added to the dt-schema
and not a Linux binding:
Re: [PATCH v2 15/20] dt-bindings: nvmem: add YAML schema for the sl28 vpd layout
https://lore.kernel.org/linux-arm-kernel/20220912192038.GA1661550-robh@kernel.org/

sl28 is one example that needs #nvmem-cell-cells
u-boot,env is another one
---
 dtschema/schemas/nvmem/nvmem-cell.yaml | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 dtschema/schemas/nvmem/nvmem-cell.yaml

diff --git a/dtschema/schemas/nvmem/nvmem-cell.yaml b/dtschema/schemas/nvmem/nvmem-cell.yaml
new file mode 100644
index 0000000..1a1741d
--- /dev/null
+++ b/dtschema/schemas/nvmem/nvmem-cell.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: BSD-2-Clause
+$id: http://devicetree.org/schemas/nvmem/nvmem-cell.yaml#
+$schema: http://devicetree.org/meta-schemas/base.yaml#
+
+title: NVMEM Cell Common Properties
+description: Schema for NVMEM cell devicetree bindings
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+# always select the core schema
+select: true
+
+properties:
+  "#nvmem-cell-cells":
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: >
+      Some NVMEM cells may consist of raw data that requires some extra
+      processing. They may provide more than 1 value.
+
+      Passing extra argument(s) allows selecting data to access.
+
+additionalProperties: true
-- 
2.34.1

