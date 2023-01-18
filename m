Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90E76727A7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjARTAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjARS7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:59:45 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4975AB5A;
        Wed, 18 Jan 2023 10:59:37 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id cc13-20020a05683061cd00b00684b8cf2f4dso11981792otb.12;
        Wed, 18 Jan 2023 10:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/w7cp6YVGNbkVTPnnS6fPAfMJMQm9O9TtAZyHYNnBw=;
        b=YbWd6oMylmb27P3pm725nlhUzeHzOBe8RkwIAJKmwOF/fHoloz4UCzzAnIN5kNPIux
         HLGxDlrZe2PSQOIFOd4GrnQL7yVqON5E6t58qTgyR9/A574Zqfhkxiz2+XymLSPVmGpP
         H0ANmWvvqpOC77H/UWU+GO3DW/LACayxNFON3LWD9eqk7EjTsBkGTgKth4BQglKJqQgj
         3zkoxvEwXDodQy6zUr6wfagyz1Uhv7qGsAPDgi2uP6iqYzghzFyLAIhqQwCK9y64jBS9
         nmN9vzb9n6AC6hu1oXXsIP1m2RNx/Gllgpz7HNqCFbOnlvH3Y1ELEfuDFVsufOFuYM/6
         acgg==
X-Gm-Message-State: AFqh2krTo/eIpgdQFFUui7yy9qHMQuRL3gsN4Vl0bHPVDe+DTHQzv9Uu
        1lgr5zzwEdnIKyrcY2tJdw==
X-Google-Smtp-Source: AMrXdXte0bYZFLFpbx1SB+TuluJMNIGkayFObGKl8ktRZeTlQi80dYuVH04jQYvzqTsrgPgipC8SMg==
X-Received: by 2002:a9d:196:0:b0:66e:c736:ef9a with SMTP id e22-20020a9d0196000000b0066ec736ef9amr3720906ote.1.1674068377180;
        Wed, 18 Jan 2023 10:59:37 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id e18-20020a9d6e12000000b00684c5211c58sm10143809otr.60.2023.01.18.10.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 10:59:36 -0800 (PST)
Received: (nullmailer pid 629752 invoked by uid 1000);
        Wed, 18 Jan 2023 18:59:29 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 18 Jan 2023 12:59:26 -0600
Subject: [PATCH v2 4/5] dt-bindings: usb: Convert Marvell Orion EHCI to DT
 schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-dt-usb-v2-4-926bc1260e51@kernel.org>
References: <20230110-dt-usb-v2-0-926bc1260e51@kernel.org>
In-Reply-To: <20230110-dt-usb-v2-0-926bc1260e51@kernel.org>
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
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
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

