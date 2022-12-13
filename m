Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FADB64B6E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbiLMOJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbiLMOI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:08:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CF820F42
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:08:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2E4EB811DA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 14:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A5EC433D2;
        Tue, 13 Dec 2022 14:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670940521;
        bh=M2Je/haA40Wu9LCU1PfMEDvXGneFkuJ8iybnSPHk2oI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UxWcVgkZrWmEEJ8Ao51oMyMe+heeIkwUihFgxIgb0XlgHRs/hGIVJLR2uV9H8XQDz
         6UqQMpJIgarzttGleoBAESwIMUpxmpUdiwD6CYSZA0XgMAM5o6AWnP5zwY9HrrcaAG
         wWstqE9uA1p3UZGVG5jzl3t3kDy4xsUkllpUnKSmYQFxKeFhogvbNQruMP5TqX9dd6
         DJ8nI6WYU66GdYR24n4yaKBP8bEbuEA2eYhAgLxujnmsKl++3Cg/hIop0ZBS75cQKC
         dHxcoyVPrNAaQXGTYvnLo3raoDCUFQcRVlcCWWPfv3fSuw8xHje3l4aQTt7G8mxAmJ
         TlgBjeRHXMwaQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p55xz-00042N-Hl; Tue, 13 Dec 2022 15:09:07 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] genirq/irqdomain/msi: Add irq_domain_alloc_irqs_affinity() wrapper
Date:   Tue, 13 Dec 2022 15:08:44 +0100
Message-Id: <20221213140844.15470-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221213140844.15470-1-johan+linaro@kernel.org>
References: <20221213140844.15470-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The full __irq_domain_alloc_irqs() interface was initially only intended
for some legacy (x86) use cases while most callers should use the
irq_domain_alloc_irqs() wrapper.

Add a matching irq_domain_alloc_irqs_affinity() wrapper that can be used
when an affinity hint needs to be provided and use it for MSI
allocations.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 include/linux/irqdomain.h | 15 +++++++++++++++
 kernel/irq/msi.c          |  6 +++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index cad47737a052..b1b06d75d31a 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -507,6 +507,14 @@ static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 				       NULL);
 }
 
+static inline int irq_domain_alloc_irqs_affinity(struct irq_domain *domain,
+			unsigned int nr_irqs, int node, void *arg,
+			const struct irq_affinity_desc *affinity)
+{
+	return __irq_domain_alloc_irqs(domain, -1, nr_irqs, node, arg, false,
+				       affinity);
+}
+
 extern int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
 					   unsigned int irq_base,
 					   unsigned int nr_irqs, void *arg);
@@ -585,6 +593,13 @@ static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 	return -1;
 }
 
+static inline int irq_domain_alloc_irqs_affinity(struct irq_domain *domain,
+			unsigned int nr_irqs, int node, void *arg,
+			const struct irq_affinity_desc *affinity)
+{
+	return -1;
+}
+
 static inline void irq_domain_free_irqs(unsigned int virq,
 					unsigned int nr_irqs) { }
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index bd4d4dd626b4..01f7f3c8d77a 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1272,9 +1272,9 @@ static int __msi_domain_alloc_irqs(struct device *dev, struct irq_domain *domain
 
 		ops->set_desc(&arg, desc);
 
-		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
-					       dev_to_node(dev), &arg, false,
-					       desc->affinity);
+		virq = irq_domain_alloc_irqs_affinity(domain, desc->nvec_used,
+						      dev_to_node(dev), &arg,
+						      desc->affinity);
 		if (virq < 0)
 			return msi_handle_pci_fail(domain, desc, allocated);
 
-- 
2.37.4

