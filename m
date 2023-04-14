Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597FD6E250B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDNODX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDNODV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:03:21 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124E7B772
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:02:48 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y35so4153977ljq.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1681480964; x=1684072964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLixTRfjgENcovszATtGl8QPdC0Pd1weyqx+S/unz9w=;
        b=HYr1AJD9m6oRzthxD0R3069MK8VuvZvtWAoQpZlxrFyHMJ4nU/c5FyZKYeOig8uMSj
         uGFMmqbadrconO75X6ztpe44p+Ku6G7jL5DmcgyZ1hq12rZFhpZ6hyVtTplNqNBCzJWu
         XfOR18dwtShwQIar93V5opgVMYaHKJAAYppuruB8+KyzpQPzzM4N+zat0BH2h1IsLCmq
         UMYJwaoRl7kYzee5Fphzl71rnWPD6vbafkgCvs4E0mDq4T8ySmSLUpqwL0LRET4UdM4B
         z/7G1KR9DON5ir3hrOMhn9Sal2JyF3iatNVjX0jZFvvZVnEuhX3iMEH7k8m2fup6CVSj
         mgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681480964; x=1684072964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLixTRfjgENcovszATtGl8QPdC0Pd1weyqx+S/unz9w=;
        b=iHTBAG9Lnvk2zguShDK71ZOvMP36TiG/JWeIPQ+KssRAgMxDOYIPdNVm1GM97CROD7
         bzgcS7yPMtKZ2DzQh4mD4DBWB1yIcLY4DqmSzSvZ2KxYlQv+JtUhOsTSHwlYVWAImOzU
         CuKd2749oyqW+UhUdJN3W0StBT+QmuaUJfLVEPe8toiqiJlyUkRA6MPNTGYcjxrH/4JP
         zNq3SeDDVLTdNEZ+48ysUjmwdvH1pR+QeyJD5NX/SzXGW2taEM1RJcfOvqmMPLfV2OBa
         gj756AeCEdmvQyStGyxGlNnKvPabbbY1BWINdOBzphj/hgwNCAxF+IllciOiGgvdpfpv
         QlNQ==
X-Gm-Message-State: AAQBX9eqDk0ZJpX2EBuEVR6cB5ay3KEBhLRUUMGpt5hg1201G5mlM/ac
        49naU+rYT0t9/Jaj3QKiD/T89g==
X-Google-Smtp-Source: AKy350ZYVGEPLLxfVYu+/HWW1CWF15hmWbDiIZLuRfjxN0aQCDsV6QACgfOZTdQ+VsxwMQxddFYJ+A==
X-Received: by 2002:a05:651c:d5:b0:2a7:6f60:34f2 with SMTP id 21-20020a05651c00d500b002a76f6034f2mr2103167ljr.33.1681480964321;
        Fri, 14 Apr 2023 07:02:44 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-201-26.toya.net.pl. [31.182.201.26])
        by smtp.gmail.com with ESMTPSA id 15-20020a2eb2cf000000b002a76e2dedbcsm828684ljz.139.2023.04.14.07.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:02:44 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH 2/9] dt-bindings: ASoC: Add chv3-i2s
Date:   Fri, 14 Apr 2023 16:01:56 +0200
Message-ID: <20230414140203.707729-3-pan@semihalf.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230414140203.707729-1-pan@semihalf.com>
References: <20230414140203.707729-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for chv3-i2s device.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 .../bindings/sound/google,chv3-i2s.yaml       | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/google,chv3-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/google,chv3-i2s.yaml b/Documentation/devicetree/bindings/sound/google,chv3-i2s.yaml
new file mode 100644
index 000000000000..6f49cf059ac5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/google,chv3-i2s.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/google,chv3-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Chameleon v3 I2S device
+
+maintainers:
+  - Paweł Anikiel <pan@semihalf.com>
+
+description: |
+  I2S device for the Google Chameleon v3. The device handles both RX
+  and TX using a producer/consumer ring buffer design.
+
+properties:
+  compatible:
+    const: google,chv3-i2s
+  reg:
+    items:
+      - description: core registers
+      - description: irq registers
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2s0: i2s@c0060300 {
+        compatible = "google,chv3-i2s";
+        reg = <0xc0060300 0x100>,
+              <0xc0060f00 0x10>;
+        interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.40.0.634.g4ca3ef3211-goog

