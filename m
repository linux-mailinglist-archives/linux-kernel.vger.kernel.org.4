Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31E96D1F63
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 13:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjCaLqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 07:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjCaLq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:46:27 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B1E191FA
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 04:46:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id s13so12700026wmr.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 04:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1680263183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tp0bQBGHYjKTuRic3MsMDsz+T3FR9akl0OtuVCzd3i4=;
        b=JedSWSOfZZ24OTE4VJks/iYjrqIdejInO2k/lAoN8EmAtHt8c5tBwqAyCYDsPMNgZP
         KoHrGpJo9aDHSFmHh1aiByqEfpcBXPlkj3hbFX+lWAXNiTal41v6St+3e8qdKOPZwVi0
         FgU1TtlH/rXf/iwMgaY7kDX+qP1LIwWAG6K8CEs8d/g2BekLhVnTmWBcG9koHiI43240
         epCM1eMNfvYtrmoa+82xO2Pblw6xwGPIGT4vsIICQ9efDFNbRUlPAT2a101oB7MJMW8j
         /cg0229nrzv4qAQ73hzA171fOahp6upneR9ImT4lcnf5FqXCuezkdQLhhtEVm97aI34r
         tiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680263183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tp0bQBGHYjKTuRic3MsMDsz+T3FR9akl0OtuVCzd3i4=;
        b=STv1kLO3Y9i9xZoV3U1fkAq0a2PGR4rqxxd1zTstinWAYI4A+awH6o7biQkqxsWBWY
         nvtn9Do16ujVXX5csZNB8R2s6pLty8eXcNuRr+RyBU702TGG0jRbzBCh1jhruOmHLik0
         CAhoi4UccjxxWoY7jGekpsFY0qVBfX6YycaYHuNz+bbazT9WHyVoeQeACOxb04ceYxIw
         L0Z4eHkHTxDAzq+a/uIu32fDjWVBwn04z1eeUdp+gou2FO84VWPmkk/gVs6/x/aXEyjy
         A9hPGi/6HmyOdIWIoBuKaXmSHHO5qmS+wegz21DQoW8L0cHGyfLTC3Z6RSkX9RDsZiVn
         qJmQ==
X-Gm-Message-State: AO0yUKVlmNDjqWbTiuT5ls+RNWJ9+7Y83+dKo8rW7ZkwIKWw+mx6Glpj
        BrvIzAyHFw2Z13Y+K5usGpOc8g==
X-Google-Smtp-Source: AK7set9zfciG1AVfHJnlG1MQ7hAvTulifoxLjTy5rrmaqLodSY17MQXtxHB75C+UTkto5RdQWThAyw==
X-Received: by 2002:a05:600c:2214:b0:3ee:289a:43a7 with SMTP id z20-20020a05600c221400b003ee289a43a7mr23073173wml.22.1680263183009;
        Fri, 31 Mar 2023 04:46:23 -0700 (PDT)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id s17-20020a7bc391000000b003edef091b17sm2404017wmj.37.2023.03.31.04.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 04:46:22 -0700 (PDT)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/2] dt-bindings: leds-lp55xx: add ti,charge-pump-mode
Date:   Fri, 31 Mar 2023 13:46:09 +0200
Message-Id: <20230331114610.48111-2-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230331114610.48111-1-maarten.zanders@mind.be>
References: <20230331114610.48111-1-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding to configure the internal charge pump for lp55xx.

Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Notes:
    v1: implement as bool to disable charge pump
    v2: rewrite to use string configuration, supporting all modes
    v3: simplification by replacing string option by u8 constant,
        removing previous Reviewed-by tags as it's a complete
        rewrite of the patch.
    v4: added notes
    v5: dual license, change property type to u32
    v6: change license type for leds-lp-55xx.h to preferred tag

 .../devicetree/bindings/leds/leds-lp55xx.yaml          |  8 ++++++++
 include/dt-bindings/leds/leds-lp55xx.h                 | 10 ++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 include/dt-bindings/leds/leds-lp55xx.h

diff --git a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
index ae607911f1db..ede9cb9ca175 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
@@ -66,6 +66,12 @@ properties:
   '#size-cells':
     const: 0
 
+  ti,charge-pump-mode:
+    description:
+      Set the operating mode of the internal charge pump as defined in
+      <dt-bindings/leds/leds-lp55xx.h>. Defaults to auto.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 patternProperties:
   '^multi-led@[0-8]$':
     type: object
@@ -152,6 +158,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/leds/common.h>
+    #include <dt-bindings/leds/leds-lp55xx.h>
 
     i2c {
         #address-cells = <1>;
@@ -164,6 +171,7 @@ examples:
             reg = <0x32>;
             clock-mode = /bits/ 8 <2>;
             pwr-sel = /bits/ 8 <3>;	/* D1~9 connected to VOUT */
+            ti,charge-pump-mode = <LP55XX_CP_BYPASS>;
 
             led@0 {
                 reg = <0>;
diff --git a/include/dt-bindings/leds/leds-lp55xx.h b/include/dt-bindings/leds/leds-lp55xx.h
new file mode 100644
index 000000000000..e2256312714b
--- /dev/null
+++ b/include/dt-bindings/leds/leds-lp55xx.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef _DT_BINDINGS_LEDS_LP55XX_H
+#define _DT_BINDINGS_LEDS_LP55XX_H
+
+#define LP55XX_CP_OFF		0
+#define LP55XX_CP_BYPASS	1
+#define LP55XX_CP_BOOST		2
+#define LP55XX_CP_AUTO		3
+
+#endif /* _DT_BINDINGS_LEDS_LP55XX_H */
-- 
2.37.3

