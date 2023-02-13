Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205D86950DB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjBMTlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjBMTkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:40:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7387713538
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:40:45 -0800 (PST)
Date:   Mon, 13 Feb 2023 19:40:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676317244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pUZ8DY1X6mipS81KMMM93WRvzcBoTcY1XAr45mGjkts=;
        b=11cfAxuVdZKzuVhYqBXVr2ctsoiYyZ1xLeAE7ba3Lu/lODccaZZdrsm5WHpI+p2Kgaebsa
        gWhzg1TUP67tiN18Bsb580O9QTziyvN5qJZ7r9UJux/Fhdu9ZkQ+NQ40aVChCrHiXc5ER5
        bNa3ixHiDnjxxHVJUeuTwFZJxxh8PliQr+2bGV3miBEVILaNzuqfaiGiCiCWT/uVrVJemf
        1v7jQk0qFWMKTf2BzG2NXuuwFW87EDVLftlNnCfkK4chF5OlhN/ifxuYP11cgVgnnM6eer
        s06hehAdSbxo8seM+F2tWulTvOaELOzVYrh2Bdzo/ScUtZymxtRbSCXpFl+QDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676317244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pUZ8DY1X6mipS81KMMM93WRvzcBoTcY1XAr45mGjkts=;
        b=Tgm+h9w+1WaeJMXb1WuEXq7EysocE2B/peBU5LDGloTvyPEitQglzOm+mN/C+wlRIkPiI5
        obPNs4Pz1xoXuCDA==
From:   "irqchip-bot for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Clean up irq_domain_push/pop_irq()
Cc:     philmd@linaro.org, "Hsin-Yi Wang" <hsinyi@chromium.org>,
        "Mark-PK Tsai" <mark-pk.tsai@mediatek.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230213104302.17307-12-johan+linaro@kernel.org>
References: <20230213104302.17307-12-johan+linaro@kernel.org>
MIME-Version: 1.0
Message-ID: <167631724376.4906.5660868139142354177.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqc=
hip:

Commit-ID:     930a1bbbef01cdcd682d9c2b4bc9e36b9618fed3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/930a1bbbef01cdcd682d9c2b4bc9e36b9618fed3
Author:        Johan Hovold <johan+linaro@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 11:42:53 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 13 Feb 2023 19:31:24=20

irqdomain: Clean up irq_domain_push/pop_irq()

The irq_domain_push_irq() interface is used to add a new (outmost) level
to a hierarchical domain after IRQs have been allocated.

Possibly due to differing mental images of hierarchical domains, the
names used for the irq_data variables make these functions much harder
to understand than what they need to be.

Rename the struct irq_data pointer to the data embedded in the
descriptor as simply 'irq_data' and refer to the data allocated by this
interface as 'parent_irq_data' so that the names reflect how
hierarchical domains are implemented.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230213104302.17307-12-johan+linaro@kernel.o=
rg
---
 kernel/irq/irqdomain.c | 65 ++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3a3213d..6d480dc 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1598,8 +1598,8 @@ static void irq_domain_fix_revmap(struct irq_data *d)
  */
 int irq_domain_push_irq(struct irq_domain *domain, int virq, void *arg)
 {
-	struct irq_data *child_irq_data;
-	struct irq_data *root_irq_data =3D irq_get_irq_data(virq);
+	struct irq_data *irq_data =3D irq_get_irq_data(virq);
+	struct irq_data *parent_irq_data;
 	struct irq_desc *desc;
 	int rv =3D 0;
=20
@@ -1624,45 +1624,44 @@ int irq_domain_push_irq(struct irq_domain *domain, in=
t virq, void *arg)
 	if (WARN_ON(!irq_domain_is_hierarchy(domain)))
 		return -EINVAL;
=20
-	if (!root_irq_data)
+	if (!irq_data)
 		return -EINVAL;
=20
-	if (domain->parent !=3D root_irq_data->domain)
+	if (domain->parent !=3D irq_data->domain)
 		return -EINVAL;
=20
-	child_irq_data =3D kzalloc_node(sizeof(*child_irq_data), GFP_KERNEL,
-				      irq_data_get_node(root_irq_data));
-	if (!child_irq_data)
+	parent_irq_data =3D kzalloc_node(sizeof(*parent_irq_data), GFP_KERNEL,
+				       irq_data_get_node(irq_data));
+	if (!parent_irq_data)
 		return -ENOMEM;
=20
 	mutex_lock(&irq_domain_mutex);
=20
 	/* Copy the original irq_data. */
-	*child_irq_data =3D *root_irq_data;
+	*parent_irq_data =3D *irq_data;
=20
 	/*
-	 * Overwrite the root_irq_data, which is embedded in struct
-	 * irq_desc, with values for this domain.
+	 * Overwrite the irq_data, which is embedded in struct irq_desc, with
+	 * values for this domain.
 	 */
-	root_irq_data->parent_data =3D child_irq_data;
-	root_irq_data->domain =3D domain;
-	root_irq_data->mask =3D 0;
-	root_irq_data->hwirq =3D 0;
-	root_irq_data->chip =3D NULL;
-	root_irq_data->chip_data =3D NULL;
+	irq_data->parent_data =3D parent_irq_data;
+	irq_data->domain =3D domain;
+	irq_data->mask =3D 0;
+	irq_data->hwirq =3D 0;
+	irq_data->chip =3D NULL;
+	irq_data->chip_data =3D NULL;
=20
 	/* May (probably does) set hwirq, chip, etc. */
 	rv =3D irq_domain_alloc_irqs_hierarchy(domain, virq, 1, arg);
 	if (rv) {
 		/* Restore the original irq_data. */
-		*root_irq_data =3D *child_irq_data;
-		kfree(child_irq_data);
+		*irq_data =3D *parent_irq_data;
+		kfree(parent_irq_data);
 		goto error;
 	}
=20
-	irq_domain_fix_revmap(child_irq_data);
-	irq_domain_set_mapping(domain, root_irq_data->hwirq, root_irq_data);
-
+	irq_domain_fix_revmap(parent_irq_data);
+	irq_domain_set_mapping(domain, irq_data->hwirq, irq_data);
 error:
 	mutex_unlock(&irq_domain_mutex);
=20
@@ -1680,8 +1679,8 @@ EXPORT_SYMBOL_GPL(irq_domain_push_irq);
  */
 int irq_domain_pop_irq(struct irq_domain *domain, int virq)
 {
-	struct irq_data *root_irq_data =3D irq_get_irq_data(virq);
-	struct irq_data *child_irq_data;
+	struct irq_data *irq_data =3D irq_get_irq_data(virq);
+	struct irq_data *parent_irq_data;
 	struct irq_data *tmp_irq_data;
 	struct irq_desc *desc;
=20
@@ -1703,37 +1702,37 @@ int irq_domain_pop_irq(struct irq_domain *domain, int=
 virq)
 	if (domain =3D=3D NULL)
 		return -EINVAL;
=20
-	if (!root_irq_data)
+	if (!irq_data)
 		return -EINVAL;
=20
 	tmp_irq_data =3D irq_domain_get_irq_data(domain, virq);
=20
 	/* We can only "pop" if this domain is at the top of the list */
-	if (WARN_ON(root_irq_data !=3D tmp_irq_data))
+	if (WARN_ON(irq_data !=3D tmp_irq_data))
 		return -EINVAL;
=20
-	if (WARN_ON(root_irq_data->domain !=3D domain))
+	if (WARN_ON(irq_data->domain !=3D domain))
 		return -EINVAL;
=20
-	child_irq_data =3D root_irq_data->parent_data;
-	if (WARN_ON(!child_irq_data))
+	parent_irq_data =3D irq_data->parent_data;
+	if (WARN_ON(!parent_irq_data))
 		return -EINVAL;
=20
 	mutex_lock(&irq_domain_mutex);
=20
-	root_irq_data->parent_data =3D NULL;
+	irq_data->parent_data =3D NULL;
=20
-	irq_domain_clear_mapping(domain, root_irq_data->hwirq);
+	irq_domain_clear_mapping(domain, irq_data->hwirq);
 	irq_domain_free_irqs_hierarchy(domain, virq, 1);
=20
 	/* Restore the original irq_data. */
-	*root_irq_data =3D *child_irq_data;
+	*irq_data =3D *parent_irq_data;
=20
-	irq_domain_fix_revmap(root_irq_data);
+	irq_domain_fix_revmap(irq_data);
=20
 	mutex_unlock(&irq_domain_mutex);
=20
-	kfree(child_irq_data);
+	kfree(parent_irq_data);
=20
 	return 0;
 }
