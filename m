Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D546B46F3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjCJOrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjCJOrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:22 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D76122094;
        Fri, 10 Mar 2023 06:47:04 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id m25-20020a05683026d900b006941a2838caso3031703otu.7;
        Fri, 10 Mar 2023 06:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNmb/TU4MrbdaOBmVF+wvUxlcZKHT5rfTWDJ0uhdhJQ=;
        b=PvAm+EHBjDospe45liQQpr2wk1k7xs5MgFpz2e4X0WAaxkCp6lmMIgVtzbvQbAohlp
         3dSt5b1o9/ghwL0gZMAMm+zm2I/Z3EdFrEPuPaTMrf25pmuXnyVAYMUC3+wy6kceccip
         sljW5oMPm93hhj4trIy7z8m4LU+ioR403RvcbFXZr7uYlhh/eZ4f9yZ/NmZH3E/OCpNz
         eQR00EeTUwpa2S7sNEzTzcSAdhpNwkDq7iiq46w9Qfepw7GyTOHpSRIVLpiRiAsF2ZQj
         MzrnNtBATUfQmMT/3DrosVGY4/Ll3GBGmQuaA+5bENoepEv11st2tCgThYeaIJ1shnG+
         FBaQ==
X-Gm-Message-State: AO0yUKVYxQOxPZv/QZZONZYCjNVFHPqiFiMjObtSh8a78Gyeg2qbQfE8
        wQxt0TvbLwM9IUg+uIH6eLiI+aaVhg==
X-Google-Smtp-Source: AK7set+NK9d+M5vMwTgqBG1J+1RkmSdiAVSYaCouKZp3M7CYP3O4y6ayRLdRmXZLCQH5nB64+2O0mA==
X-Received: by 2002:a05:6830:3142:b0:68b:e4e6:cc9c with SMTP id c2-20020a056830314200b0068be4e6cc9cmr15090992ots.33.1678459620760;
        Fri, 10 Mar 2023 06:47:00 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t18-20020a9d7292000000b0068bc476d777sm130792otj.13.2023.03.10.06.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:00 -0800 (PST)
Received: (nullmailer pid 1540976 invoked by uid 1000);
        Fri, 10 Mar 2023 14:46:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mips: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:46:56 -0600
Message-Id: <20230310144656.1540950-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
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

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/mips/pci/pci-lantiq.c | 2 +-
 arch/mips/pci/pci-rt3883.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index d967e4c0cf24..79e29bf42a24 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -118,7 +118,7 @@ static int ltq_pci_startup(struct platform_device *pdev)
 
 	/* and enable the clocks */
 	clk_enable(clk_pci);
-	if (of_find_property(node, "lantiq,external-clock", NULL))
+	if (of_property_read_bool(node, "lantiq,external-clock"))
 		clk_enable(clk_external);
 	else
 		clk_disable(clk_external);
diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index d59888aaed81..4ac68a534e4f 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -419,7 +419,7 @@ static int rt3883_pci_probe(struct platform_device *pdev)
 
 	/* find the interrupt controller child node */
 	for_each_child_of_node(np, child) {
-		if (of_get_property(child, "interrupt-controller", NULL)) {
+		if (of_property_read_bool(child, "interrupt-controller")) {
 			rpc->intc_of_node = child;
 			break;
 		}
-- 
2.39.2

