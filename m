Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E2866C03E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjAPNvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjAPNun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:50:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C2421945;
        Mon, 16 Jan 2023 05:50:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B28DE60FC6;
        Mon, 16 Jan 2023 13:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9767DC43392;
        Mon, 16 Jan 2023 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673877040;
        bh=Sc/MXrEwZaxI4omzYCVHgWpM1c0Ozs8INEgkW+Kkfxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZdwS8bAvdzWN/C6v/U15xmHvbQMQMJusVQTi9CqJfflW/jPFbn3aYdXTST2GS1hv
         ChWtwzHM9Mo6bKs2CLsEmdTjFdL/zEumhE3mzEhXtRCRsHvoeixjPySaA7MX0P6B55
         Vhw9Kbo3g3EM6g0/QTjGYHErVQuIgXI6FpFpnntNtkCY56NtR4870LolZ9+RXwI0eW
         KjvIpJ5o/R9jTF1Dlw9S97JdX8yEZqI9ZaszR6vU9qk3jNFuBgQn5xOBl18KH7oGFb
         x0ft+UcfE6D4hkXHV3EOcU2UDR0XlFd/EaW6NVQItAnk0l2yIvJmHlMp8mS8jkV/Ya
         5tidaNTVroP+Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pHPt5-0003ux-Vi; Mon, 16 Jan 2023 14:51:00 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v4 06/19] irqdomain: Drop revmap mutex
Date:   Mon, 16 Jan 2023 14:50:31 +0100
Message-Id: <20230116135044.14998-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230116135044.14998-1-johan+linaro@kernel.org>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
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

The global irq_domain_mutex is now held in all paths that update the
revmap structures so there is no longer any need for the revmap mutex.

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 include/linux/irqdomain.h |  2 --
 kernel/irq/irqdomain.c    | 13 ++++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 5b2718e1c6de..7fd3939328c2 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -143,7 +143,6 @@ struct irq_domain_chip_generic;
  * Revmap data, used internally by the irq domain code:
  * @revmap_size:	Size of the linear map table @revmap[]
  * @revmap_tree:	Radix map tree for hwirqs that don't fit in the linear map
- * @revmap_mutex:	Lock for the revmap
  * @revmap:		Linear table of irq_data pointers
  */
 struct irq_domain {
@@ -171,7 +170,6 @@ struct irq_domain {
 	irq_hw_number_t			hwirq_max;
 	unsigned int			revmap_size;
 	struct radix_tree_root		revmap_tree;
-	struct mutex			revmap_mutex;
 	struct irq_data __rcu		*revmap[];
 };
 
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 23f5919e58b7..248e6acfafbe 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -214,7 +214,6 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int s
 
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
-	mutex_init(&domain->revmap_mutex);
 	domain->ops = ops;
 	domain->host_data = host_data;
 	domain->hwirq_max = hwirq_max;
@@ -501,30 +500,30 @@ static bool irq_domain_is_nomap(struct irq_domain *domain)
 static void irq_domain_clear_mapping(struct irq_domain *domain,
 				     irq_hw_number_t hwirq)
 {
+	lockdep_assert_held(&irq_domain_mutex);
+
 	if (irq_domain_is_nomap(domain))
 		return;
 
-	mutex_lock(&domain->revmap_mutex);
 	if (hwirq < domain->revmap_size)
 		rcu_assign_pointer(domain->revmap[hwirq], NULL);
 	else
 		radix_tree_delete(&domain->revmap_tree, hwirq);
-	mutex_unlock(&domain->revmap_mutex);
 }
 
 static void irq_domain_set_mapping(struct irq_domain *domain,
 				   irq_hw_number_t hwirq,
 				   struct irq_data *irq_data)
 {
+	lockdep_assert_held(&irq_domain_mutex);
+
 	if (irq_domain_is_nomap(domain))
 		return;
 
-	mutex_lock(&domain->revmap_mutex);
 	if (hwirq < domain->revmap_size)
 		rcu_assign_pointer(domain->revmap[hwirq], irq_data);
 	else
 		radix_tree_insert(&domain->revmap_tree, hwirq, irq_data);
-	mutex_unlock(&domain->revmap_mutex);
 }
 
 static void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
@@ -1511,11 +1510,12 @@ static void irq_domain_fix_revmap(struct irq_data *d)
 {
 	void __rcu **slot;
 
+	lockdep_assert_held(&irq_domain_mutex);
+
 	if (irq_domain_is_nomap(d->domain))
 		return;
 
 	/* Fix up the revmap. */
-	mutex_lock(&d->domain->revmap_mutex);
 	if (d->hwirq < d->domain->revmap_size) {
 		/* Not using radix tree */
 		rcu_assign_pointer(d->domain->revmap[d->hwirq], d);
@@ -1524,7 +1524,6 @@ static void irq_domain_fix_revmap(struct irq_data *d)
 		if (slot)
 			radix_tree_replace_slot(&d->domain->revmap_tree, slot, d);
 	}
-	mutex_unlock(&d->domain->revmap_mutex);
 }
 
 /**
-- 
2.38.2

