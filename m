Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B496A6CB1D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 00:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjC0WbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 18:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjC0WbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:31:15 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D9340C7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:31:08 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id r14so1917395oiw.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679956268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3T4tQPH6yseYq9tiKoc4A725qEg2InFFgK6PxJmKvk=;
        b=N6l0CF7pIfDlAtFDkJSwuW9nDLKad4N0AgrW3Ws4V/AOX+D0wcntRoXmo8Jjc92Oe/
         mSVR4hMGIpPf8oSCnfZo5S70jetj66rd7ev4yECz00vu91e7vi2Ex+IoMJ7qEZrSIpIj
         NoBF5FMbTuDgIawrmuOQQayRsfwI6gYwL1dDVEQ0eD6nT7Vut652OEjkYyoYgMOR66qH
         MuuO4dg9Ap+Y09MW33nSjFqV7fbrW4Vf9UM81rSQAubdEuWQtWYGHrmEs1pDyebVmxU8
         M57VPSfO5muaKfgkyaaswcVOPrLCwBIAAjQBmY0ZGhfOmpQZ95ftNUWABkXyOqJZYOcK
         nghQ==
X-Gm-Message-State: AAQBX9eBZNHFTd15lfgBVJhbyZC9ya5C1fIuFpZm06aPxa1s+ttxcwPV
        56/YYujq8liOQQ0cb7PQXA==
X-Google-Smtp-Source: AKy350Zk9fdx957ft/lyOlvqpU79gtOtq2UNqXZUoynnWg3RzYArt60S35ZSNIz1Ifyt7mV6ni1VUw==
X-Received: by 2002:a05:6808:305:b0:388:f4de:b656 with SMTP id i5-20020a056808030500b00388f4deb656mr2981361oie.27.1679956267718;
        Mon, 27 Mar 2023 15:31:07 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z6-20020a4aae06000000b0051763d6497fsm11625480oom.38.2023.03.27.15.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 15:31:07 -0700 (PDT)
Received: (nullmailer pid 820323 invoked by uid 1000);
        Mon, 27 Mar 2023 22:31:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: fsl_rio: Use of_iomap()
Date:   Mon, 27 Mar 2023 17:31:02 -0500
Message-Id: <20230327223103.820229-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace of_address_to_resource()+ioremap() with a call to of_iomap()
which does both of those steps.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/sysdev/fsl_rio.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index c8f044d62fe2..f8e492ee54cc 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -450,7 +450,6 @@ int fsl_rio_setup(struct platform_device *dev)
 	int rc = 0;
 	const u32 *dt_range, *cell, *port_index;
 	u32 active_ports = 0;
-	struct resource regs, rmu_regs;
 	struct device_node *np, *rmu_node;
 	int rlen;
 	u32 ccsr;
@@ -465,17 +464,7 @@ int fsl_rio_setup(struct platform_device *dev)
 		return -ENODEV;
 	}
 
-	rc = of_address_to_resource(dev->dev.of_node, 0, &regs);
-	if (rc) {
-		dev_err(&dev->dev, "Can't get %pOF property 'reg'\n",
-				dev->dev.of_node);
-		return -EFAULT;
-	}
-	dev_info(&dev->dev, "Of-device full name %pOF\n",
-			dev->dev.of_node);
-	dev_info(&dev->dev, "Regs: %pR\n", &regs);
-
-	rio_regs_win = ioremap(regs.start, resource_size(&regs));
+	rio_regs_win = of_iomap(dev->dev.of_node, 0);
 	if (!rio_regs_win) {
 		dev_err(&dev->dev, "Unable to map rio register window\n");
 		rc = -ENOMEM;
@@ -509,15 +498,9 @@ int fsl_rio_setup(struct platform_device *dev)
 		rc = -ENOENT;
 		goto err_rmu;
 	}
-	rc = of_address_to_resource(rmu_node, 0, &rmu_regs);
-	if (rc) {
-		dev_err(&dev->dev, "Can't get %pOF property 'reg'\n",
-				rmu_node);
-		of_node_put(rmu_node);
-		goto err_rmu;
-	}
+	rmu_regs_win = of_iomap(rmu_node, 0);
+
 	of_node_put(rmu_node);
-	rmu_regs_win = ioremap(rmu_regs.start, resource_size(&rmu_regs));
 	if (!rmu_regs_win) {
 		dev_err(&dev->dev, "Unable to map rmu register window\n");
 		rc = -ENOMEM;
-- 
2.39.2

