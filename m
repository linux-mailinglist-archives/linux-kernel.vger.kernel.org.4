Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C055E6A53AD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjB1HaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjB1H3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:29:50 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D96EFAC;
        Mon, 27 Feb 2023 23:29:48 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id k14so11885364lfj.7;
        Mon, 27 Feb 2023 23:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anJfvBlE+shc2bmOxourHefmds/BtxwdudHBi4fTMDE=;
        b=EJeNyNiEouLJCSo+lYCJumat2GRI7N0vyjv8gKfz5S/MY6+HDt6Sh5XFI1LczHt3oV
         X1jKFx3jWBMjMIJJmSe4+pF73SGPCR4t3n/DQmb7XpDsQJt7V4YywVYSHV2bpn4fgIef
         w35lEOCB1eeUBYKpsjlbUtjBvceAB7+sgHaOHs3WqLIrdQ4Xx6XfscB0G6d5MFDgqZEi
         RLDJnDfPsaLqDq10l1EHb/c4XEgrORIJ+WnLIiCb/WdGCobFNM5tghacSO7jXxSiOuw5
         hIcpqxXeoZ6HkP/HY1YdRx5P2EMtTwXJnlb5r3ZIF29YHB1KRrff4r2KnvwwKXgnEHse
         xPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anJfvBlE+shc2bmOxourHefmds/BtxwdudHBi4fTMDE=;
        b=e+HqO/FxUGSzyH5xV2mbyJsukeM1KSYpIwjXNkLzf7T4qYNnYM56a+xmWucSkZDo0k
         L7JAWyQqezysXxPD2hpKopWKd69c01q4mW2lbIaoQBz4YSYrRmv6YD+HsERAGHNxyHet
         fuzT78TbijYqItPHrDU2Ds1iKEz0iVx8MPGSxuEkwXYbSVoCFhjTDhTdL1bTT09soTwi
         Gx/Eq9gnNmxmlHpvTvruEvATut1gS1D60O+rhq8QPAxZUkq231kVia5ePdrp1RvpyumY
         /CFBfpudabe4Hc6PhVRiChLrvtXJF4y6DjL+doWsGO4/1O5CMrziZoolRcFVne71rO4m
         m9qA==
X-Gm-Message-State: AO0yUKUCyfY84g8x4V2lbDd+/i/ni2wsfdFVi7SO/xvjQqBjemu3TX+N
        gR4QgTedwvld5fUgN/sjgzw=
X-Google-Smtp-Source: AK7set/QtguLI5ukTkiUykG2VdzDxDgGFtQnX9xt1e+GexfGmgk3wXArPR+umYOM4/Qgy/igZSM+Sg==
X-Received: by 2002:ac2:5215:0:b0:4e1:7209:c09f with SMTP id a21-20020ac25215000000b004e17209c09fmr476595lfl.66.1677569386447;
        Mon, 27 Feb 2023 23:29:46 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id l2-20020ac25542000000b004d85a7e8b17sm1229550lfk.269.2023.02.27.23.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 23:29:46 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V4 1/2] dt-bindings: nvmem: mmio: new binding for MMIO accessible NVMEM devices
Date:   Tue, 28 Feb 2023 08:29:35 +0100
Message-Id: <20230228072936.1108-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228072936.1108-1-zajec5@gmail.com>
References: <20230228072936.1108-1-zajec5@gmail.com>
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

Content of some NVMEM devices can be read using MMIO. Some of them
(probably very few though) may be also programmable that way. Add
generic binding to allow describing such hardware.

This *doesn't* apply to any more complicated devices that need more
complex interface e.g. for writing. While such devices could be
supported for reading purposes by the same driver - they should get
their own binding.

This binding will gain even more usability once we fully support NVMEM
layouts (describing content of NVMEM devices in an independent way).

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V3: Make it clear this binding should NOT be used for more complex devices
---
 .../devicetree/bindings/nvmem/mmio.yaml       | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/mmio.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/mmio.yaml b/Documentation/devicetree/bindings/nvmem/mmio.yaml
new file mode 100644
index 000000000000..9ca96b7a4856
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/mmio.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/mmio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MMIO access based NVMEM
+
+description: |
+  This binding describes simple NVMEM devices with content that can be accessed
+  using MMIO (memory-mapped I/O access).
+
+  More complex devices that support any other access than a simple memory
+  mapping should use a custom binding. In such cases this binding's compatible
+  should NOT be used even as a fallback.
+
+  This binding is designed to describe just an NVMEM content access method. The
+  way of handling actual content should be described independently (on top of
+  this binding).
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    const: mmio-nvmem
+
+  reg:
+    maxItems: 1
+
+  reg-io-width:
+    description: |
+      The size (in bytes) of the IO accesses that should be performed
+      on the device.
+    enum: [1, 2, 4, 8]
+
+required:
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    nvmem@10000 {
+        compatible = "mmio-nvmem";
+        reg = <0x10000000 0x10000>;
+    };
-- 
2.34.1

