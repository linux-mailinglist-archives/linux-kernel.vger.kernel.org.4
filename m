Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CD5704A90
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjEPKbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjEPKa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:30:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528472115
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:30:58 -0700 (PDT)
Date:   Tue, 16 May 2023 10:30:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684233057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+c4JJvREZ+ry2RQubPPKenPgjrnm6wLOyGS5iUdMgo=;
        b=bwiMbxzSgmU2lgHkMNmeHLuU1yQScs7FBt6pYsZhRQw1IMnlb9l8WchPVu41OKvfNZXyrW
        XHzMwb48UOLCG6yuWZJPuUmrsc+Dg9ifuiLg2gRoCXqarUwblPTph/CBNN04eYtpOgwi/2
        G5jDQ74rpcUMat6+f3PioQT1l5zL5J3baz2FqBPmSmzhttLII7tRxZup+RU63nqkVRcmQU
        3BI8lyisaJdlElp51oQp8zYr/TTi26wHsY/WEemLonjbTEMaYk8S0MeWmCP65vyVn17chS
        b+NOccYvvLR09jHL9nvwEfQtVqyrj+mVhUxiH1MD/cjrXXisSjwui0+S+nMfnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684233057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+c4JJvREZ+ry2RQubPPKenPgjrnm6wLOyGS5iUdMgo=;
        b=qc6g+YDGLGlOJbCk23czPQUcrFOHYqvhXe9Zz4i9Md/cioobFqTEy0nWHaF939jNb4rJcc
        lWgWfoqa5qe6QQBA==
From:   "irqchip-bot for Kefeng Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/mbigen: Unify the error handling
 in mbigen_of_create_domain()
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230505090654.12793-1-wangkefeng.wang@huawei.com>
References: <20230505090654.12793-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Message-ID: <168423305640.404.14948493018092002475.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     cddb536a73ef2c82ce04059dc61c65e85a355561
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/cddb536a73ef2c82ce04059dc61c65e85a355561
Author:        Kefeng Wang <wangkefeng.wang@huawei.com>
AuthorDate:    Fri, 05 May 2023 17:06:54 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 16 May 2023 11:19:29 +01:00

irqchip/mbigen: Unify the error handling in mbigen_of_create_domain()

Dan Carpenter reported that commit fea087fc291b "irqchip/mbigen: move
to use bus_get_dev_root()" leads to the following Smatch static checker
warning:

	drivers/irqchip/irq-mbigen.c:258 mbigen_of_create_domain()
	error: potentially dereferencing uninitialized 'child'.

It should not cause a problem on real hardware, but better to fix the
warning, let's move the bus_get_dev_root() out of the loop, and unify
the error handling to silence it.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230505090654.12793-1-wangkefeng.wang@huawei.com
---
 drivers/irqchip/irq-mbigen.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index eada5e0..5101a3f 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -240,26 +240,27 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
 	struct irq_domain *domain;
 	struct device_node *np;
 	u32 num_pins;
+	int ret = 0;
+
+	parent = bus_get_dev_root(&platform_bus_type);
+	if (!parent)
+		return -ENODEV;
 
 	for_each_child_of_node(pdev->dev.of_node, np) {
 		if (!of_property_read_bool(np, "interrupt-controller"))
 			continue;
 
-		parent = bus_get_dev_root(&platform_bus_type);
-		if (parent) {
-			child = of_platform_device_create(np, NULL, parent);
-			put_device(parent);
-			if (!child) {
-				of_node_put(np);
-				return -ENOMEM;
-			}
+		child = of_platform_device_create(np, NULL, parent);
+		if (!child) {
+			ret = -ENOMEM;
+			break;
 		}
 
 		if (of_property_read_u32(child->dev.of_node, "num-pins",
 					 &num_pins) < 0) {
 			dev_err(&pdev->dev, "No num-pins property\n");
-			of_node_put(np);
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
 
 		domain = platform_msi_create_device_domain(&child->dev, num_pins,
@@ -267,12 +268,16 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
 							   &mbigen_domain_ops,
 							   mgn_chip);
 		if (!domain) {
-			of_node_put(np);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			break;
 		}
 	}
 
-	return 0;
+	put_device(parent);
+	if (ret)
+		of_node_put(np);
+
+	return ret;
 }
 
 #ifdef CONFIG_ACPI
