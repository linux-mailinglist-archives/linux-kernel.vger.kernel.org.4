Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C4E69D25B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjBTRtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjBTRtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:49:47 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714371EBF8;
        Mon, 20 Feb 2023 09:49:42 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id u15so3007718ljo.5;
        Mon, 20 Feb 2023 09:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFDJegi5uTYwdkZXr42aNBwxRD/vvuGUyK4suapHfLE=;
        b=pNp4F+WC3OYbrn5ogI5MzgDCG/M7DsThUP1JveuJQchDIP5pr5gJjrONCAEm5MCqJ6
         0mBiEWGY46umgI+IlFdYRaS5MTRSpJUFNUe+xvnDAl+8vDi99y8Q2A1AZG1xHQzYz2x3
         hR6HOaZ1fdpqnGjv9Sm46+HtmEffVa4Be2BeaVcJw/5LHmzf61gj0dY+KkLayoJkSyNa
         oyfyQCi+vLKoWyAqNd6ZSxZ6+z2jrLoW9p3dBXdVm+zc6ddqsGfAp8zkX7utEKpQ4MIp
         KpYDrFrUx4v9+fRGS/N3FEAHWFq1KIKJ9pr6VVjYuhjomasoHeKG0VDVwE94iWwKTEMh
         QHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFDJegi5uTYwdkZXr42aNBwxRD/vvuGUyK4suapHfLE=;
        b=qVswGQXkdPrisN07Wf5/Pne/rsAxnN/4m2H5JhVXr8m1l80tVNuhPUHmvfmwRgQyiN
         lJjaKD8YOiKW+J4qSHXGD2M/XjdE5187TtvmUZDWQk0oxecx84S5wbxvf4bDJyCvOpCn
         5lg0R4GB0ZNNkdanKAvIl6hUj4ITvt1Y1MwePiaZJj5VnyJobXssDwbLBNoTJO2tkEQ6
         +cmrIrKdWQN3hVyCuOdMv3NZ9qkjDWConViukkdyNp6jd1/AhB2v5+LfjX5SmpMZkmqw
         vi/vXOV0eOHz9YcyUkQ4Z8jbGAzdAe8tadmgY+HAGHOqDbrjLc13XLWZjqav0ZYwFOrU
         xNhA==
X-Gm-Message-State: AO0yUKXMCCu04YnOl9GGcIlBw58wpwMNPbVl7tN2fRv805i6zihFXja5
        oFz6bvoQyCWUVCyBeFI/y5c=
X-Google-Smtp-Source: AK7set+Sh6RcNPNBI8AkSmYzzOk7NOMz/GoQ61Hr+5GGqp7LrngcaXhxl712WiDfdg5IZOKgCEhe0w==
X-Received: by 2002:a05:651c:10aa:b0:28e:a8aa:6f95 with SMTP id k10-20020a05651c10aa00b0028ea8aa6f95mr832063ljn.8.1676915380580;
        Mon, 20 Feb 2023 09:49:40 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id u22-20020a2e9f16000000b0029353491df6sm294695ljk.48.2023.02.20.09.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 09:49:40 -0800 (PST)
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
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3 1/2] dt-bindings: nvmem: mmio: new binding for MMIO accessible NVMEM devices
Date:   Mon, 20 Feb 2023 18:49:29 +0100
Message-Id: <20230220174930.7440-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220174930.7440-1-zajec5@gmail.com>
References: <20230220174930.7440-1-zajec5@gmail.com>
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

