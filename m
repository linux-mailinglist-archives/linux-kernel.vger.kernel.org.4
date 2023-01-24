Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B916678EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 04:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjAXDFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 22:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjAXDFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:05:30 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7053B0D9;
        Mon, 23 Jan 2023 19:05:28 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id u13-20020a056830118d00b00686def09868so1164437otq.7;
        Mon, 23 Jan 2023 19:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/w7cp6YVGNbkVTPnnS6fPAfMJMQm9O9TtAZyHYNnBw=;
        b=GvOgIiWUn3BqGIM5PPHhRje9Oj+0jj0NoZCSgvSnKviCtSA0NFh7Wpb9JRHwjw/ii/
         pM2aU2erZAq0XLwy8IP+WKID7xKc/QaVa3u43f9PYlj6aFqxjrrmY7c5RzUzTcfFF/Qq
         O4L4AynyOWtE0WdzRtDXxIVKbW69EmUdfcHeTuePCLZSvZcR9nxpD0Gq1VgpahhZa34U
         sydrdmsMdxmwgqmlqAvom9XaENLJ/9fdriYki8ZRMveJ3mgZwWKmMjF0e0iaXMPJw7rh
         k7d4Q/TJxfm8iUWcWpyHh72T0Oo7yj/vY/TojrllzGbPV/4ArPuzqyRGDDugXzSOl6le
         VWcA==
X-Gm-Message-State: AFqh2kpVPn06FDMVjKF6P6WKI2+B5d/9V/6OHIcI2d4hXCFfPJRPTkq3
        YxCFsqNM+NKvo7XGsYvEKA==
X-Google-Smtp-Source: AMrXdXvQH0sqj/L9JBEQUzQ6OMqA602/d6xDzeDJd2iqRHh2295yqrVgSM/VJdjsM0K9Fx0dwIY4/A==
X-Received: by 2002:a05:6830:670a:b0:684:e1cb:df87 with SMTP id cr10-20020a056830670a00b00684e1cbdf87mr15320609otb.8.1674529528074;
        Mon, 23 Jan 2023 19:05:28 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cr11-20020a056830670b00b00661a3f4113bsm419338otb.64.2023.01.23.19.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 19:05:27 -0800 (PST)
Received: (nullmailer pid 3266346 invoked by uid 1000);
        Tue, 24 Jan 2023 03:05:20 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 23 Jan 2023 21:05:18 -0600
Subject: [PATCH v3 4/5] dt-bindings: usb: Convert Marvell Orion EHCI to DT
 schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-dt-usb-v3-4-5af0541fcf8c@kernel.org>
References: <20230110-dt-usb-v3-0-5af0541fcf8c@kernel.org>
In-Reply-To: <20230110-dt-usb-v3-0-5af0541fcf8c@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Lee Jones <lee@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        openbmc@lists.ozlabs.org
X-Mailer: b4 0.12-dev
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

The Marvell Orion EHCI binding is just some compatible strings, so add it
to the generic-ehci.yaml schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/ehci-orion.txt         | 22 ----------------------
 .../devicetree/bindings/usb/generic-ehci.yaml      |  2 ++
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ehci-orion.txt b/Documentation/devicetree/bindings/usb/ehci-orion.txt
deleted file mode 100644
index 2855bae79fda..000000000000
--- a/Documentation/devicetree/bindings/usb/ehci-orion.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-* EHCI controller, Orion Marvell variants
-
-Required properties:
-- compatible: must be one of the following
-	"marvell,orion-ehci"
-	"marvell,armada-3700-ehci"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: The EHCI interrupt
-
-Optional properties:
-- clocks: reference to the clock
-- phys: reference to the USB PHY
-- phy-names: name of the USB PHY, should be "usb"
-
-Example:
-
-	ehci@50000 {
-		compatible = "marvell,orion-ehci";
-		reg = <0x50000 0x1000>;
-		interrupts = <19>;
-	};
diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index 2d382ae424da..ebbb01b39a92 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -74,6 +74,8 @@ properties:
           - const: usb-ehci
       - enum:
           - generic-ehci
+          - marvell,armada-3700-ehci
+          - marvell,orion-ehci
           - ti,ehci-omap
           - usb-ehci
 

-- 
2.39.0

