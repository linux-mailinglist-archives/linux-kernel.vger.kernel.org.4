Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F40C678EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 04:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjAXDAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 22:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjAXC7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:59:49 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB2CE3BB;
        Mon, 23 Jan 2023 18:59:48 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id c145-20020a4a4f97000000b004f505540a20so2447317oob.1;
        Mon, 23 Jan 2023 18:59:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGNJQjFUyuZvmkIoGERVkBfMmL0DNPi68xB4vE/bRfM=;
        b=oNBpxVejY4qhkcCF0XJ1vpxZz9Zfn27vaU9jbA6E+rHFC6EUo4uhN5Gu4wluZVYjPZ
         9+tV2iOkn2A1dj0xxs46BdQDEW7t6yMDnW3rVrE09WUcb+QK2WGEMVlF30g1N6smLfpn
         XH2pc7DSd/GsNkOHqlzT9I5s4MAipfIAJaJyO+NfFWeemUPz8nqyZsyN7/3ZlTJGu0ua
         QXbCETqQHkFeqIENbCcxvupJOZICBEZH7Jt1cnh6nLzLY4r/YEvSGD9BtpJaOjGLmf1Z
         4UJn7UYiuVv3AJ6eyH8Jv52NzLfkIRsyTTbvZGylHsrvdv9CDvLEG5cwg+F+DOekOBIK
         +CeA==
X-Gm-Message-State: AFqh2krtvWZsLvEkQyPwRhitvJwRobb68ylHOy5I80c7bu3injmY+Uyn
        MS4+x+f8jQ4hu1E4vK6ZWKY3/+gnZQ==
X-Google-Smtp-Source: AMrXdXsy8VYyeApDqS2BO+ZeFMwaXPQDPGeou/tPuPrLGNZualIHyjPyWrEiBt0ilgk2UDvrHQ2tcA==
X-Received: by 2002:a4a:4f95:0:b0:4f1:f375:c240 with SMTP id c143-20020a4a4f95000000b004f1f375c240mr12803378oob.6.1674529187418;
        Mon, 23 Jan 2023 18:59:47 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j5-20020a4ad185000000b004a8eb1d8f1bsm296067oor.39.2023.01.23.18.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 18:59:47 -0800 (PST)
Received: (nullmailer pid 3256463 invoked by uid 1000);
        Tue, 24 Jan 2023 02:59:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: usb: snps,dwc3: Allow power-domains property
Date:   Mon, 23 Jan 2023 20:59:35 -0600
Message-Id: <20230124025936.3256213-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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

Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
 - No change
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

