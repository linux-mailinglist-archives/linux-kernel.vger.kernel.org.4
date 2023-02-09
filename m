Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23138690A3A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjBINbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjBINav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:30:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343BF5EBF3;
        Thu,  9 Feb 2023 05:30:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61315B8213E;
        Thu,  9 Feb 2023 13:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA5AC43335;
        Thu,  9 Feb 2023 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675949443;
        bh=icdD0oWFhuqEZPe3gw5UIs0Haoy0s/gzVx8NhI+aF/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMIxVlgD0oK4YLxtOUZXM+2SCNRAM5LyhzGpegT3ZIaEgLDeC80s1NUtW2VsMCF9A
         XX6o4bV7ej76HO5QSFFMm/QXSzehtQJYNrvQuk3ygjMnp2+jSUIDgHWFamM6N0ei4D
         28Hr83OWltvUSwulKWbw6R8WAaxuMtcFt7D3VTRbe2VLQSW3VGG1KPKG2vJKaOJzJW
         +e3Cfq/P7GjUo4Uh+zoU0QhPGTcJyNDD4B2JvNZ6O7KDAK0A/2/5elffd/IlrfQqjk
         FEKVO/on54UrAOy8FTXWUTv4B3zLN4tLDynsdCiS5shKU8kqy/JKCiVo5gPQTooZjn
         USe8nTvGGuC1w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pQ71G-0001L7-Uq; Thu, 09 Feb 2023 14:31:22 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v5 10/19] irqdomain: Clean up irq_domain_push/pop_irq()
Date:   Thu,  9 Feb 2023 14:23:14 +0100
Message-Id: <20230209132323.4599-11-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209132323.4599-1-johan+linaro@kernel.org>
References: <20230209132323.4599-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq_domain_push_irq() interface is used to add a new (outmost) level
to a hierarchical domain after IRQs have been allocated.

Possibly due to differing mental images of hierarchical domains, the
names used for the irq_data variables make these functions much harder
to understand than what they need to be.

Rename the struct irq_data pointer to the data embedded in the
descriptor as simply 'irq_data' and refer to the data allocated by this
interface as 'parent_irq_data' so that the names reflect how
hierarchical domains are implemented.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 kernel/irq/irqdomain.c | 65 +++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index a1c6e01b395e..804d316329c8 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1571,8 +1571,8 @@ static void irq_domain_fix_revmap(struct irq_data *d)
  */
 int irq_domain_push_irq(struct irq_domain *domain, int virq, void *arg)
 {
-	struct irq_data *child_irq_data;
-	struct irq_data *root_irq_data = irq_get_irq_data(virq);
+	struct irq_data *irq_data = irq_get_irq_data(virq);
+	struct irq_data *parent_irq_data;
 	struct irq_desc *desc;
 	int rv = 0;
 
@@ -1597,45 +1597,44 @@ int irq_domain_push_irq(struct irq_domain *domain, int virq, void *arg)
 	if (WARN_ON(!irq_domain_is_hierarchy(domain)))
 		return -EINVAL;
 
-	if (!root_irq_data)
+	if (!irq_data)
 		return -EINVAL;
 
-	if (domain->parent != root_irq_data->domain)
+	if (domain->parent != irq_data->domain)
 		return -EINVAL;
 
-	child_irq_data = kzalloc_node(sizeof(*child_irq_data), GFP_KERNEL,
-				      irq_data_get_node(root_irq_data));
-	if (!child_irq_data)
+	parent_irq_data = kzalloc_node(sizeof(*parent_irq_data), GFP_KERNEL,
+				       irq_data_get_node(irq_data));
+	if (!parent_irq_data)
 		return -ENOMEM;
 
 	mutex_lock(&irq_domain_mutex);
 
 	/* Copy the original irq_data. */
-	*child_irq_data = *root_irq_data;
+	*parent_irq_data = *irq_data;
 
 	/*
-	 * Overwrite the root_irq_data, which is embedded in struct
-	 * irq_desc, with values for this domain.
+	 * Overwrite the irq_data, which is embedded in struct irq_desc, with
+	 * values for this domain.
 	 */
-	root_irq_data->parent_data = child_irq_data;
-	root_irq_data->domain = domain;
-	root_irq_data->mask = 0;
-	root_irq_data->hwirq = 0;
-	root_irq_data->chip = NULL;
-	root_irq_data->chip_data = NULL;
+	irq_data->parent_data = parent_irq_data;
+	irq_data->domain = domain;
+	irq_data->mask = 0;
+	irq_data->hwirq = 0;
+	irq_data->chip = NULL;
+	irq_data->chip_data = NULL;
 
 	/* May (probably does) set hwirq, chip, etc. */
 	rv = irq_domain_alloc_irqs_hierarchy(domain, virq, 1, arg);
 	if (rv) {
 		/* Restore the original irq_data. */
-		*root_irq_data = *child_irq_data;
-		kfree(child_irq_data);
+		*irq_data = *parent_irq_data;
+		kfree(parent_irq_data);
 		goto error;
 	}
 
-	irq_domain_fix_revmap(child_irq_data);
-	irq_domain_set_mapping(domain, root_irq_data->hwirq, root_irq_data);
-
+	irq_domain_fix_revmap(parent_irq_data);
+	irq_domain_set_mapping(domain, irq_data->hwirq, irq_data);
 error:
 	mutex_unlock(&irq_domain_mutex);
 
@@ -1653,8 +1652,8 @@ EXPORT_SYMBOL_GPL(irq_domain_push_irq);
  */
 int irq_domain_pop_irq(struct irq_domain *domain, int virq)
 {
-	struct irq_data *root_irq_data = irq_get_irq_data(virq);
-	struct irq_data *child_irq_data;
+	struct irq_data *irq_data = irq_get_irq_data(virq);
+	struct irq_data *parent_irq_data;
 	struct irq_data *tmp_irq_data;
 	struct irq_desc *desc;
 
@@ -1676,37 +1675,37 @@ int irq_domain_pop_irq(struct irq_domain *domain, int virq)
 	if (domain == NULL)
 		return -EINVAL;
 
-	if (!root_irq_data)
+	if (!irq_data)
 		return -EINVAL;
 
 	tmp_irq_data = irq_domain_get_irq_data(domain, virq);
 
 	/* We can only "pop" if this domain is at the top of the list */
-	if (WARN_ON(root_irq_data != tmp_irq_data))
+	if (WARN_ON(irq_data != tmp_irq_data))
 		return -EINVAL;
 
-	if (WARN_ON(root_irq_data->domain != domain))
+	if (WARN_ON(irq_data->domain != domain))
 		return -EINVAL;
 
-	child_irq_data = root_irq_data->parent_data;
-	if (WARN_ON(!child_irq_data))
+	parent_irq_data = irq_data->parent_data;
+	if (WARN_ON(!parent_irq_data))
 		return -EINVAL;
 
 	mutex_lock(&irq_domain_mutex);
 
-	root_irq_data->parent_data = NULL;
+	irq_data->parent_data = NULL;
 
-	irq_domain_clear_mapping(domain, root_irq_data->hwirq);
+	irq_domain_clear_mapping(domain, irq_data->hwirq);
 	irq_domain_free_irqs_hierarchy(domain, virq, 1);
 
 	/* Restore the original irq_data. */
-	*root_irq_data = *child_irq_data;
+	*irq_data = *parent_irq_data;
 
-	irq_domain_fix_revmap(root_irq_data);
+	irq_domain_fix_revmap(irq_data);
 
 	mutex_unlock(&irq_domain_mutex);
 
-	kfree(child_irq_data);
+	kfree(parent_irq_data);
 
 	return 0;
 }
-- 
2.39.1

