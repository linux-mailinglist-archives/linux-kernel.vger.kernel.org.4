Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108546E3BA5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 21:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjDPTrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 15:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDPTra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 15:47:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD76CA;
        Sun, 16 Apr 2023 12:47:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id hg12so8917168pjb.2;
        Sun, 16 Apr 2023 12:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681674449; x=1684266449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8RDYyBWM9aB5+0URoWw6nSww5qd8o7lKOxHtXf6E94=;
        b=DdUz7BsFGLe2B3Dq7ogdYMMVvzVows4H0hFyiX7sf3tlj4jg8vhN03DC7jFcsd3/O7
         H22iD6CIsh5zPgUXEp/vJEKhh9MPqN1p2r6crV6y5tDXDAqvMjIqLOY1efnbAGNF/eZG
         veJMbW6Hm1P5DYi3uOB6E/4mM8J9OjmGNrjorNf8ECFdggetyc8mIJ6k8Spo9omeGofX
         O3/tDJeN5NgE70Ll4zV7PVveZQ63hd371KxWn4J90f7SpV6i3KxogyPjOLQaJPizw4qG
         OkMVIldWv0lqUA0pMXRQX74DbIkQInK+9Whfy8O1nyQV7AjqV8CwMgn5PN9ImndhdYGw
         Zxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681674449; x=1684266449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8RDYyBWM9aB5+0URoWw6nSww5qd8o7lKOxHtXf6E94=;
        b=iqCebffU/70zWc7PTKdfbgPiflM/6DcCdIIvhm31bcKNaRQEqQOfueyHotI9hJrTzZ
         V9OO9SkDqRdf98Ozkb9VqVctQwO06cjDnslCnqB2PsCeqXE+skwH4ZHWe/0OwInSriFz
         G8DTNYUjcA+9peydMbVV3jgUcktr1ujYrHmKgnwXJ6zbFiSreZRWKA0VSWScn2guxM+y
         Y2UHVWGpnxwa2Ghe8YzuegjlLOE1VAKM3K9Vng/lctcb0lgasSlP4dmk6U9JzmpIxIOt
         Esi5ySHZ2ZVrXAndxb0g5uK5EJZ+nXAocMRvSxWsvaIbr5kmgRzlxt8mtPk3n0yULroC
         /7nA==
X-Gm-Message-State: AAQBX9cVt4ue5jEqScubijyM3X1v16ZUywuOZOK+yB6MakBUEKSWCW0s
        9j2/DJ+oRKljSRXafUVhd1Tti6Jpj+1LHUu73CA=
X-Google-Smtp-Source: AKy350antjMDSCJPJLs0I24peNByemlM7dBXeuD4NSTp1JnWY/iEw8+7DIvoiQLR52B+apQlC5gacg==
X-Received: by 2002:a17:902:c40f:b0:1a0:549d:399e with SMTP id k15-20020a170902c40f00b001a0549d399emr13241340plk.21.1681674448739;
        Sun, 16 Apr 2023 12:47:28 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.201])
        by smtp.gmail.com with ESMTPSA id jd9-20020a170903260900b001a69b28f5c5sm4490375plb.222.2023.04.16.12.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 12:47:28 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: clock: Add simple-clock-controller
Date:   Mon, 17 Apr 2023 03:46:19 +0800
Message-Id: <20230416194624.1258860-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230416194624.1258860-1-mmyangfl@gmail.com>
References: <20230416194624.1258860-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings documentation for simple clock controller, just a
contiguous region of multiple clock registers.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 .../clock/simple-clock-controller.yaml        | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/simple-clock-controller.yaml

diff --git a/Documentation/devicetree/bindings/clock/simple-clock-controller.yaml b/Documentation/devicetree/bindings/clock/simple-clock-controller.yaml
new file mode 100644
index 000000000000..3d9b436b0ef9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/simple-clock-controller.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/simple-clock-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Simple clock controller
+
+maintainers:
+  - David Yang <mmyangfl@gmail.com>
+
+description: |
+  A contiguous register region of multiple different clocks. No operations are
+  required to enable or disable the clock controller.
+
+properties:
+  compatible:
+    const: simple-clock-controller
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  '.*clock.*':
+    type: object
+    description: Clock devices.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@ffff000 {
+      compatible = "simple-clock-controller";
+      reg = <0xffff000 0x1000>;
+    };
-- 
2.39.2

