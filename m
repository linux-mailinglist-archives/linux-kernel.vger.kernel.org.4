Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E4B6879D6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjBBKLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjBBKKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:10:52 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94FF875B7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 02:10:46 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v13so1416192eda.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 02:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZ/eU/DKOSJTbU1YDMmaQL1fq94Z2preFzmC+8H/Gjo=;
        b=dlq9Ei+ies+wC8rqHr4+iStcSSd1YBuNlbxPxpucw6pmy9CAs13nEOikZ5BWFHXrSt
         4E383ZAN2OJF0+kvlbvckkXieElTtInDird2S1kQz5ZSa80t4XsOPqaKZGKoPZBCALjM
         5aXtX82oWDSwIyM9l2GGvmx0aD6zoiE5MYwUC6lVHU2vYkKYLJF0Zppnkdp5bmzuMhN3
         6sozw9E9vt4QmVqF5tIYvXPIhbReVYOvJzvOPWmpr16h2SzI8g2E/Xt47NBF3gBRgij3
         rshmwuAwsuWwh/YZt3QOCDWXsnnL2QqwkSXHypFmmQpT5YFDPMjsy73hkk0yTK5KKsKr
         wILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZ/eU/DKOSJTbU1YDMmaQL1fq94Z2preFzmC+8H/Gjo=;
        b=Wnau9GlDqn6UJADjPjt02xyX+AXXRq1IWHAz7EHUGRimP4Q8CfGGYxIP3UsQ3YU85i
         xD6tAzNbszClPMk7kQj9ia9BuGvVprwkNKHjUCvrnojiZQmg81fKtWG+hJ9YzQprX9Uh
         yo2k7/exm+19iYKloTxwJYlRAlF6ZK7GskAL5n2wsiRipvxzG9AS8Wewpnc2PzLOLiPq
         cPRc9o7vlDrfzEgXRhxEL7cxe37m1Y3iQaEXv9rkWpE4XV/V5PFaTHsM4NK4aROb8YYK
         IVmgnJ6WVLP6NXqh48JxKdvuqZg9JGviBuAR0I3PEPjBHPEsAiqNC9JcveEo2vSd3GFX
         tiAw==
X-Gm-Message-State: AO0yUKXJl3hZmbTjWO31uwf/DbYldfKwrcx71I9WLiGkItVpf9lHKEM2
        8BDqdlueheJKQvY3kF7D8dPcvw==
X-Google-Smtp-Source: AK7set/zjGx/vZqFBsdgw8PYe1J4UVTDb+ioEW+bafSh0azWJcgBdFx2BitsblDAuFdFUgD+FLVv/A==
X-Received: by 2002:a05:6402:1504:b0:499:70a8:f91a with SMTP id f4-20020a056402150400b0049970a8f91amr5501371edw.19.1675332645239;
        Thu, 02 Feb 2023 02:10:45 -0800 (PST)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id t13-20020a50d70d000000b00458b41d9460sm11155816edi.92.2023.02.02.02.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 02:10:44 -0800 (PST)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: leds-lp55xx: add ti,charge-pump-mode
Date:   Thu,  2 Feb 2023 11:10:31 +0100
Message-Id: <20230202101032.26737-2-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230202101032.26737-1-maarten.zanders@mind.be>
References: <20230202101032.26737-1-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding to configure the internal charge pump for lp55xx.

Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
---

Notes:
    v1: implement as bool to disable charge pump
    v2: rewrite to use string configuration, supporting all modes
    v3: simplification by replacing string option by u8 constant,
        removing previous Reviewed-by tags as it's a complete
        rewrite of the patch.
    v4: added notes

 .../devicetree/bindings/leds/leds-lp55xx.yaml          |  8 ++++++++
 include/dt-bindings/leds/leds-lp55xx.h                 | 10 ++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 include/dt-bindings/leds/leds-lp55xx.h

diff --git a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
index ae607911f1db..22e63d89d770 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
@@ -66,6 +66,12 @@ properties:
   '#size-cells':
     const: 0
 
+  ti,charge-pump-mode:
+    description:
+      Set the operating mode of the internal charge pump as defined in
+      <dt-bindings/leds/leds-lp55xx.h>. Defaults to auto.
+    $ref: /schemas/types.yaml#/definitions/uint8
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
+            ti,charge-pump-mode = /bits/ 8 <LP55XX_CP_BYPASS>;
 
             led@0 {
                 reg = <0>;
diff --git a/include/dt-bindings/leds/leds-lp55xx.h b/include/dt-bindings/leds/leds-lp55xx.h
new file mode 100644
index 000000000000..8f59c1c12dee
--- /dev/null
+++ b/include/dt-bindings/leds/leds-lp55xx.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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

