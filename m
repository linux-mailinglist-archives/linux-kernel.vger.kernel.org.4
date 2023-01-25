Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B7B67BFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbjAYWOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbjAYWOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:14:38 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74DA5D104;
        Wed, 25 Jan 2023 14:14:31 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id p133so17577745oig.8;
        Wed, 25 Jan 2023 14:14:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFTW9AeEl9auo+eW7ZvUvSOTVl1w+nwD/7bsv4md7y8=;
        b=WRieDTYe/a8CGR0txqBxMYcSPCcYTvwa1h4NQePdZ+fD7v+fxgmeYjYJubf84c+D4m
         bVDml2EZ4XhA0XX4d2HZZd7EK4e7fff92UrFivBhvve0eEGtBseJKigJk3PGk65CTnxh
         6fq7TkPPQzd3/tJnzsQl3LStXhjbpvXnTYGXXKG7+7QLt9CinydiSAeIVoOEceTxZz4c
         ap9cAzUoFuHW2+QjwSPyZ6f5Ekr6SluPb2NgocZ+FD35fiOJh1IABlS/XDNLHXp7I/lX
         PqllQEri0CPB6apETN+5GcGl1awEDRzu7SzfXfie+e+OpUgMW4e0No7HQcV3P+OcvsfH
         mk/w==
X-Gm-Message-State: AFqh2koVpP9v1fhD1FnkRfnJ0JRxi7+0KOm77PkZ6gZML4MKZEle16lr
        jn0/yLcpSceGivt1Fc2fU342kZmmeg==
X-Google-Smtp-Source: AMrXdXv84uFYFJUSfoRVCtF9OXmO3s+RbvzjYzq9qvVBa1rJQkaqiQ6UYH2evGjwU86HXUtzb2Uykg==
X-Received: by 2002:a05:6808:220e:b0:364:914b:2f02 with SMTP id bd14-20020a056808220e00b00364914b2f02mr21714118oib.40.1674684870884;
        Wed, 25 Jan 2023 14:14:30 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 22-20020a9d0316000000b006864b75be16sm2685740otv.19.2023.01.25.14.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 14:14:30 -0800 (PST)
Received: (nullmailer pid 3058348 invoked by uid 1000);
        Wed, 25 Jan 2023 22:14:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: interrupt-controller: brcm,bcm7120-l2-intc: Fix 'brcm,int-fwd-mask' differing type
Date:   Wed, 25 Jan 2023 16:14:23 -0600
Message-Id: <20230125221423.3058221-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'brcm,int-fwd-mask' is also defined in brcm,bcm7038-l1-intc.yaml as a
'uint32-array', so unify the type definition.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml    | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
index 46b2eb3c43ee..c680de1cbd56 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
@@ -109,7 +109,8 @@ properties:
       for system suspend/resume.
 
   brcm,int-fwd-mask:
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 1
     description: >
       if present, a bit mask to configure the interrupts which have a mux gate,
       typically UARTs. Setting these bits will make their respective interrupt
-- 
2.39.0

