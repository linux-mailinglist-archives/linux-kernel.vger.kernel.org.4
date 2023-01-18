Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A84672876
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjARTbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjARTbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:31:11 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90EE5529B;
        Wed, 18 Jan 2023 11:31:02 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-15eec491b40so14379fac.12;
        Wed, 18 Jan 2023 11:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0sk6WSE6h2ySUyFVnUkIwye39tqP2uFGs/tVLLc9YM=;
        b=GbUUEGHKYs7yUxTUj2T6CBo45/8GXSZiZEwaS2E8y3Otjfyap5m91qemhsyKvmKd/9
         oGV9GVmm5S/k62QuR63NOkL7Tu5+XU7/I+bTfKwyJaU9d0eNIiB0SUdxAtZBPLbH3zbY
         nyZKiEZlpQshAkJGD3LtUtqnhvFS7JA+epWquLd+U3WcZhVkuGJS7bjXZSIhDW37jZgA
         6wKGyL75NaD2rFVr8DqdVnv0ZhI8NoB63Lkch7fJNScmwadATAA2uU/g0E9tl9V4rJML
         gqBTnE5UA75Ym3ZCIrru9toaTYH8wt3C1NWMf4oqAEcGlILc9JDj8h0U3ghgg0Lppp57
         l6mQ==
X-Gm-Message-State: AFqh2krhcHgVxOQ9vulo7NvNqAOQzL6TqswcbnVaBPfuk3JNqkdKv8hv
        IVRj/0OVDzGfQkRWG1JJDw==
X-Google-Smtp-Source: AMrXdXsAOEkXzjlCDtKORZICvzXTbloceRTTyJ1tdkrIkJ1m0D2pIsRTPrNjsQbT6tvOlUoaFZrhPw==
X-Received: by 2002:a05:6870:bf0d:b0:148:3440:cfde with SMTP id qh13-20020a056870bf0d00b001483440cfdemr4472842oab.28.1674070262146;
        Wed, 18 Jan 2023 11:31:02 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id f18-20020a056871071200b0014f81d27ce3sm18948186oap.55.2023.01.18.11.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 11:31:01 -0800 (PST)
Received: (nullmailer pid 673650 invoked by uid 1000);
        Wed, 18 Jan 2023 19:31:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: usb: snps,dwc3: Allow power-domains property
Date:   Wed, 18 Jan 2023 13:30:55 -0600
Message-Id: <20230118193056.673514-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip RK3399 DWC3 node has 'power-domains' property which isn't
allowed by the schema:

usb@fe900000: Unevaluated properties are not allowed ('power-domains' was unexpected)

Allow DWC3 nodes to have a power-domains entry. We could instead move
the power-domains property to the parent wrapper node, but the could be
an ABI break (Linux shouldn't care). Also, we don't want to encourage
the pattern of wrapper nodes just to define resources such as clocks,
resets, power-domains, etc. when not necessary.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Allow 2 power domains and explain what they are
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 6d78048c4613..be36956af53b 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -91,6 +91,16 @@ properties:
         - usb2-phy
         - usb3-phy
 
+  power-domains:
+    description:
+      The DWC3 has 2 power-domains. The power management unit (PMU) and
+      everything else. The PMU is typically always powered and may not have an
+      entry.
+    minItems: 1
+    items:
+      - description: Core
+      - description: Power management unit
+
   resets:
     minItems: 1
 
-- 
2.39.0

