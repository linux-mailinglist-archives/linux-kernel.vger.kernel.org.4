Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86D5716FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjE3Vrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbjE3Vrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:47:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8876F3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685483213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kO4HrmMAvzIB24zLmV9JKi88Zlv8JWkZRaktK8Z6cck=;
        b=dHEmpEDMHj94zg7ZzUId3cjxT9LF9rQUlHN/aJYAfTSuGBpzrGBJVrAKX38ln1CWorpLIW
        R0ciF5NKfYJskFekid60TgR11azHR7JmzcPEAKspbcpJDkRVzTpCwcVSVdoHDRNkIWBdTS
        jDqIqfVE8v1PbEPEdeHYwAnEfeRB1B4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-V95T6UtyMda73xeVsM7tvw-1; Tue, 30 May 2023 17:46:52 -0400
X-MC-Unique: V95T6UtyMda73xeVsM7tvw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75cac31d806so680799885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685483212; x=1688075212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kO4HrmMAvzIB24zLmV9JKi88Zlv8JWkZRaktK8Z6cck=;
        b=I8uq4mIh804DxMbdeF440DKunMex9edkObEM/wuLLYN1kwwCPoiRfGBT5nkdePdSZm
         6ZB5utfGdIAcxfi713aj2d5gBHfSjd9GzRxDldQnGJp1KPpYEGqAXO56PEQWhqte/2vh
         uNR9J84Ky3639YjTCnPv4LSrol8uFJ5JtqD58dK3KY+Zb/XEx1utHYxcBwgysVWyeXve
         FsxuKgtDy2y9BE01HwNudv2GyPAY/fNb78Zt2EZgoJzVlPdrtAoW6QsuNjrwrXLgt2Rv
         K05pQU3DKCZSdSx9lE1TRdws/TzeOmtcJstuwv0INoWlL2ERVxDQix/PixwnONs3bZQr
         T+Vw==
X-Gm-Message-State: AC+VfDxgg0ou4hqfLzRVUy1NBF6+mk1SuU8uZ/sWUB7enF1dqzmSvuf1
        yNpAniJN5iBC9UPEhtFKZA6xGscTG507PrI8ldw/3ljXYNQXto77p6jJ+jlQ4xqSTHwKlO6kzt+
        PH4+vrqYl6uTVBTFMKcxhcvnaZD221KrksNe6NRmGy1KVZ/+NfIzlFYvqik0U/d5jffeZw2GLo2
        bBul8+mAo=
X-Received: by 2002:a05:622a:1aa7:b0:3f6:a725:25a1 with SMTP id s39-20020a05622a1aa700b003f6a72525a1mr3933602qtc.6.1685483211600;
        Tue, 30 May 2023 14:46:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7lzkB2UWPHFLtb06YvCGpmh+Kt1MdRddN01szlDEF7jY7DAeFlNcyjMjep14IIklu9GbZlfQ==
X-Received: by 2002:a05:622a:1aa7:b0:3f6:a725:25a1 with SMTP id s39-20020a05622a1aa700b003f6a72525a1mr3933574qtc.6.1685483211078;
        Tue, 30 May 2023 14:46:51 -0700 (PDT)
Received: from thinkpad-p1.kanata.rendec.net (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id w16-20020a05622a191000b003ef13aa5b0bsm5121602qtc.82.2023.05.30.14.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 14:46:50 -0700 (PDT)
From:   Radu Rendec <rrendec@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 3/5] irq: Expose chained interrupt parents in sysfs
Date:   Tue, 30 May 2023 17:45:48 -0400
Message-Id: <20230530214550.864894-4-rrendec@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530214550.864894-1-rrendec@redhat.com>
References: <20230530214550.864894-1-rrendec@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends irq_set_parent() by adding the ability to show the
direct parent of a chained interrupt as a symlink in sysfs. In addition,
the root level interrupt (in a multi-level chained interrupt topology)
will also show all child interrupts. Example:

$ ls -l /sys/kernel/irq/38/muxed_irqs/
total 0
lrwxrwxrwx 1 root root 0 May 24 16:00 41 -> ../../41
lrwxrwxrwx 1 root root 0 May 24 16:00 42 -> ../../42
$ ls -l /sys/kernel/irq/41/parent
lrwxrwxrwx 1 root root 0 May 24 16:00 /sys/kernel/irq/41/parent -> ../38
$ ls -l /sys/kernel/irq/42/parent
lrwxrwxrwx 1 root root 0 May 24 16:18 /sys/kernel/irq/42/parent -> ../38

Chained IRQ chip drivers are expected to call irq_set_parent() in their
.map domain op handler. A few already do (for the purpose of enabling
IRQ-resend support).

An IRQ chip driver may also implement the newer hierarchical domain API
and still use chained interrupts. In that case, irq_set_parent() would
be called in the .alloc domain op handler.

Since most legacy drivers do not implement the .unmap domain op and most
hierarchical drivers use irq_domain_free_irqs_common() as their .free
domain op, the irqdomain core is modified to remove an existing parent
mapping automatically when the interrupt is disassociated with the
domain.

The whole purpose of exposing interrupt topology in sysfs is to be able
to control the SMP affinity of chained interrupts. Since chained IRQ
chips can be stacked and the affinity can be typically controlled only
at the root level, irq_set_parent() will always populate the muxed_irqs
directory of the root interrupt, not the one of the direct parent.
However, the "parent" symlink will always point to the direct parent.

Notes (RFC/draft patch):
* The muxed_irqs directory may not be necessary to control the SMP
  affinity. See the cover letter for details.
* Synchronization around muxed_irqs is likely broken. But since we may
  decide to get rid of muxed_irqs altogether, the implementation here is
  provided as a proof of concept and ground for discussion.

Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 include/linux/irqdesc.h |  1 +
 kernel/irq/internals.h  |  8 ++++
 kernel/irq/irqdesc.c    | 84 +++++++++++++++++++++++++++++++++++------
 kernel/irq/irqdomain.c  | 15 ++++++++
 kernel/irq/manage.c     | 16 ++++++--
 5 files changed, 110 insertions(+), 14 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 844a8e30e6de5..b57450745857f 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -97,6 +97,7 @@ struct irq_desc {
 #ifdef CONFIG_SPARSE_IRQ
 	struct rcu_head		rcu;
 	struct kobject		kobj;
+	struct kobject		*muxed_irqs;
 #endif
 	struct mutex		request_mutex;
 	int			parent_irq;
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 5fdc0b5575797..c75cd836155c9 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -101,6 +101,14 @@ static inline void irq_mark_irq(unsigned int irq) { }
 extern void irq_mark_irq(unsigned int irq);
 #endif
 
+#if defined(CONFIG_SPARSE_IRQ) && defined(CONFIG_SYSFS)
+extern void irq_sysfs_update_parent(struct irq_desc *desc,
+				    struct irq_desc *parent);
+#else
+static inline void irq_sysfs_update_parent(struct irq_desc *desc,
+					   struct irq_desc *parent) { }
+#endif
+
 extern int __irq_get_irqchip_state(struct irq_data *data,
 				   enum irqchip_irq_state which,
 				   bool *state);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index d45c163dbb749..ec52b8b41002e 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -285,17 +285,27 @@ static const struct kobj_type irq_kobj_type = {
 
 static void irq_sysfs_add(int irq, struct irq_desc *desc)
 {
-	if (irq_kobj_base) {
-		/*
-		 * Continue even in case of failure as this is nothing
-		 * crucial and failures in the late irq_sysfs_init()
-		 * cannot be rolled back.
-		 */
-		if (kobject_add(&desc->kobj, irq_kobj_base, "%d", irq))
-			pr_warn("Failed to add kobject for irq %d\n", irq);
-		else
-			desc->istate |= IRQS_SYSFS;
+	if (!irq_kobj_base)
+		return;
+
+	/*
+	 * Continue even in case of failure as this is nothing
+	 * crucial and failures in the late irq_sysfs_init()
+	 * cannot be rolled back.
+	 */
+	if (kobject_add(&desc->kobj, irq_kobj_base, "%d", irq)) {
+		pr_warn("Failed to add kobject for irq %d\n", irq);
+		return;
+	}
+
+	desc->muxed_irqs = kobject_create_and_add("muxed_irqs", &desc->kobj);
+	if (!desc->muxed_irqs) {
+		pr_warn("Failed to add mux kobject for irq %d\n", irq);
+		kobject_del(&desc->kobj);
+		return;
 	}
+
+	desc->istate |= IRQS_SYSFS;
 }
 
 static void irq_sysfs_del(struct irq_desc *desc)
@@ -306,8 +316,10 @@ static void irq_sysfs_del(struct irq_desc *desc)
 	 * sysfs is not initialized yet, and the case of a failed
 	 * kobject_add() invocation.
 	 */
-	if (desc->istate & IRQS_SYSFS)
+	if (desc->istate & IRQS_SYSFS) {
+		kobject_del(desc->muxed_irqs);
 		kobject_del(&desc->kobj);
+	}
 }
 
 static int __init irq_sysfs_init(void)
@@ -333,6 +345,55 @@ static int __init irq_sysfs_init(void)
 }
 postcore_initcall(irq_sysfs_init);
 
+static inline struct irq_desc *irq_find_root_desc(struct irq_desc *desc)
+{
+	while (desc && desc->parent_irq)
+		desc = irq_to_desc(desc->parent_irq);
+
+	return desc;
+}
+
+/*
+ * Update sysfs entries to show that parent_desc is the new parent of desc
+ *
+ * At this point, desc->parent_irq is the old parent, and parent_desc is the
+ * new parent. If no parent has been set yet, desc->parent is 0. If the parent
+ * is being removed, parent_desc is NULL.
+ *
+ * Called with desc->request_mutex locked.
+ */
+void irq_sysfs_update_parent(struct irq_desc *desc, struct irq_desc *parent_desc)
+{
+	unsigned int irq = desc->irq_data.irq;
+	struct irq_desc *root_desc;
+	int err;
+
+	/* First, remove all references to the old parent (if any). */
+	if (desc->parent_irq) {
+		sysfs_remove_link(&desc->kobj, "parent");
+		root_desc = irq_find_root_desc(irq_to_desc(desc->parent_irq));
+		if (!WARN_ON(!root_desc))
+			sysfs_remove_link(root_desc->muxed_irqs, desc->kobj.name);
+	}
+
+	/* Next, create references to the new parent (if any). */
+	if (!parent_desc)
+		return;
+
+	err = sysfs_create_link(&desc->kobj, &parent_desc->kobj, "parent");
+	if (err)
+		pr_warn("Failed to link irq %u parent: %d\n", irq, err);
+
+	root_desc = irq_find_root_desc(parent_desc);
+	if (WARN_ON(!root_desc))
+		return;
+
+	err = sysfs_create_link(root_desc->muxed_irqs, &desc->kobj,
+				desc->kobj.name);
+	if (err)
+		pr_warn("Failed to link irq %u root: %d\n", irq, err);
+}
+
 #else /* !CONFIG_SYSFS */
 
 static const struct kobj_type irq_kobj_type = {
@@ -438,6 +499,7 @@ static void delayed_free_desc(struct rcu_head *rhp)
 {
 	struct irq_desc *desc = container_of(rhp, struct irq_desc, rcu);
 
+	kobject_put(desc->muxed_irqs);
 	kobject_put(&desc->kobj);
 }
 
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index f34760a1e2226..fad1559587c3e 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -553,6 +553,14 @@ static void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
 
 	mutex_lock(&domain->root->mutex);
 
+	/*
+	 * For domains that support it, irq_set_parent() is called in the map()
+	 * op. The reverse operation of removing the parent mapping should be
+	 * done in the unmap() op which is called below. Since most domains do
+	 * not implement unmap(), remove the parent mapping here.
+	 */
+	irq_set_parent(irq, 0);
+
 	irq_set_status_flags(irq, IRQ_NOREQUEST);
 
 	/* remove chip and handler */
@@ -1748,6 +1756,13 @@ void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs)
 	domain = data->domain;
 
 	mutex_lock(&domain->root->mutex);
+	/*
+	 * Typically irq_set_parent() would be called in the alloc() op. The
+	 * reverse operation of removing the parent mapping should be done in
+	 * the free() op which is called indirectly below. Since most domains
+	 * use irq_domain_free_irqs_common(), remove the parent mapping here.
+	 */
+	irq_set_parent(virq, 0);
 	for (i = 0; i < nr_irqs; i++)
 		irq_domain_remove_irq(virq + i);
 	irq_domain_free_irqs_hierarchy(domain, virq, nr_irqs);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 49683e55261eb..eec9b94747439 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1007,14 +1007,24 @@ int __irq_set_trigger(struct irq_desc *desc, unsigned long flags)
 int irq_set_parent(int irq, int parent_irq)
 {
 	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
+	struct irq_desc *desc = irq_to_desc(irq);
+	struct irq_desc *parent_desc = parent_irq ?
+				       irq_to_desc(parent_irq) : NULL;
 
-	if (!desc)
+	if (!desc || (parent_irq && !parent_desc))
 		return -EINVAL;
 
+	mutex_lock(&desc->request_mutex);
+
+	if (desc->parent_irq != parent_irq)
+		irq_sysfs_update_parent(desc, parent_desc);
+
+	raw_spin_lock_irqsave(&desc->lock, flags);
 	desc->parent_irq = parent_irq;
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+
+	mutex_unlock(&desc->request_mutex);
 
-	irq_put_desc_unlock(desc, flags);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(irq_set_parent);
-- 
2.40.1

