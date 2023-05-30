Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DAD716FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjE3Vrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbjE3Vrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:47:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB25C7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685483217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tqxh8RwR0SLkelcDFbazXgBZl6jZFQi1SW6VSeth23s=;
        b=HVok3aIfylnD6NvpwishC7Gs0+RaAmtWmSsd5zSvxBZjLx6+6JkzBfgfCm7mEUaoFMO/fO
        1i3pLhqrowuSKl13TC13X6NuMOZuLQY7m8t9zXeCXnc0knsHUg7sy/mpG2mNi9Gpg3i0V0
        TbUnizsmhKENp+WBKX/+Fh9caGkigcI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-mJGqZ-pkMFiXSDovd4REFQ-1; Tue, 30 May 2023 17:46:56 -0400
X-MC-Unique: mJGqZ-pkMFiXSDovd4REFQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f6c9fef4beso34421771cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685483215; x=1688075215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tqxh8RwR0SLkelcDFbazXgBZl6jZFQi1SW6VSeth23s=;
        b=fKXPGOtM5AZGMGXYiy2B/WF9/Ddceh3/6ZHO8hZYAAqZmahtZNw5VGFiLjsV9UK/Pl
         Ku1CM58pbxc5i+1v56j2P2ldJmKI14+lSscRv0ipeiOoaAPvqs4cPbT0SrZe/tvxpT7M
         PbiBEuA1JGQVX4I7m2DWqkO3i7fuyi8wiisYaZ2eGx47BVEYWES7SB9WVR4UFFdlnuBO
         LO3vdYQa1vl7D8iIdMRfn+2RkFHyvxTY/0KkO5OsLVnjnntePvDfgmVEbKg0gIuPUu4D
         jwac5+woOf61MhV4UcTlD/2SNaLIp5K4e4DVN02vjH4BoPQQd2gqVtwr5cVu4QpOv3HO
         bZbw==
X-Gm-Message-State: AC+VfDxw4llYmDtmgbuaCRXM17E6cBzWdDKj2t0peUkYnb3kIyY3lqQD
        VLVzCHVQrRJB3i7tUReo3oZy8x9GgFjHcbLXGag/ndjzRx9788fT5LIVsRbe9fpswEyD1zQrZJi
        JHC8o9tlYTfNz+9euBVC9NsPOmbZkPsdIx/GW5xQdCSoXAD8Iigd2Srm2qgnSHt60p1WBohskAr
        VL7NDePpg=
X-Received: by 2002:a05:622a:489:b0:3f5:456b:d565 with SMTP id p9-20020a05622a048900b003f5456bd565mr4276916qtx.24.1685483215026;
        Tue, 30 May 2023 14:46:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5sVCstOadQ3lvyLpuXD2JCAzbScKi5fJ0RtGpdAet/ZxrWfXxKbD2DB4wvPuKP1yEMB5h43A==
X-Received: by 2002:a05:622a:489:b0:3f5:456b:d565 with SMTP id p9-20020a05622a048900b003f5456bd565mr4276895qtx.24.1685483214683;
        Tue, 30 May 2023 14:46:54 -0700 (PDT)
Received: from thinkpad-p1.kanata.rendec.net (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id w16-20020a05622a191000b003ef13aa5b0bsm5121602qtc.82.2023.05.30.14.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 14:46:54 -0700 (PDT)
From:   Radu Rendec <rrendec@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 4/5] irq: Move SMP affinity write handler out of proc.c
Date:   Tue, 30 May 2023 17:45:49 -0400
Message-Id: <20230530214550.864894-5-rrendec@redhat.com>
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

This patch prepares the ground for setting the SMP affinity from sysfs.
The bulk of the code is identical for procfs and sysfs, except for the
cpumask parsing functions, where procfs requires the _user variants.

Summary of changes:
- irq_select_affinity_usr() and write_irq_affinity() are moved from
  from proc.c to irqdesc.c
- write_irq_affinity() is slightly modified to allow using the other
  variant of cpumask parsing functions
- the definition of no_irq_affinity is moved from proc.c to manage.c
  and available only when CONFIG_SMP is enabled
- the declaration of no_irq_affinity is available only when CONFIG_SMP
  is enabled

Note that all existing use cases of no_irq_affinity were already
confined within CONFIG_SMP preprocessor conditionals.

Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 include/linux/irq.h    |  2 ++
 kernel/irq/internals.h |  2 ++
 kernel/irq/irqdesc.c   | 67 +++++++++++++++++++++++++++++++++++++++
 kernel/irq/manage.c    |  2 ++
 kernel/irq/proc.c      | 72 +++---------------------------------------
 5 files changed, 78 insertions(+), 67 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 7710f157e12de..0393fc02cfd46 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -639,7 +639,9 @@ static inline void irq_move_masked_irq(struct irq_data *data) { }
 static inline void irq_force_complete_move(struct irq_desc *desc) { }
 #endif
 
+#ifdef CONFIG_SMP
 extern int no_irq_affinity;
+#endif
 
 int irq_set_parent(int irq, int parent_irq);
 
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index c75cd836155c9..381a0b4c1d381 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -147,6 +147,8 @@ extern int irq_do_set_affinity(struct irq_data *data,
 
 #ifdef CONFIG_SMP
 extern int irq_setup_affinity(struct irq_desc *desc);
+extern ssize_t write_irq_affinity(unsigned int irq, const char __user *buffer,
+				  size_t count, bool is_list, bool is_user);
 #else
 static inline int irq_setup_affinity(struct irq_desc *desc) { return 0; }
 #endif
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index ec52b8b41002e..a46a76c29b8d1 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -133,6 +133,73 @@ EXPORT_SYMBOL_GPL(nr_irqs);
 static DEFINE_MUTEX(sparse_irq_lock);
 static DECLARE_BITMAP(allocated_irqs, IRQ_BITMAP_BITS);
 
+#ifdef CONFIG_SMP
+
+#ifndef CONFIG_AUTO_IRQ_AFFINITY
+static inline int irq_select_affinity_usr(unsigned int irq)
+{
+	/*
+	 * If the interrupt is started up already then this fails. The
+	 * interrupt is assigned to an online CPU already. There is no
+	 * point to move it around randomly. Tell user space that the
+	 * selected mask is bogus.
+	 *
+	 * If not then any change to the affinity is pointless because the
+	 * startup code invokes irq_setup_affinity() which will select
+	 * a online CPU anyway.
+	 */
+	return -EINVAL;
+}
+#else
+/* ALPHA magic affinity auto selector. Keep it for historical reasons. */
+static inline int irq_select_affinity_usr(unsigned int irq)
+{
+	return irq_select_affinity(irq);
+}
+#endif
+
+ssize_t write_irq_affinity(unsigned int irq, const char __user *buffer,
+			   size_t count, bool is_list, bool is_user)
+{
+	cpumask_var_t mask;
+	int err;
+
+	if (!irq_can_set_affinity_usr(irq) || no_irq_affinity)
+		return -EIO;
+
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	if (is_user)
+		err = is_list ? cpumask_parselist_user(buffer, count, mask) :
+				cpumask_parse_user(buffer, count, mask);
+	else
+		err = is_list ? cpulist_parse(buffer, mask) :
+				cpumask_parse(buffer, mask);
+	if (err)
+		goto free_cpumask;
+
+	/*
+	 * Do not allow disabling IRQs completely - it's a too easy
+	 * way to make the system unusable accidentally :-) At least
+	 * one online CPU still has to be targeted.
+	 */
+	if (!cpumask_intersects(mask, cpu_online_mask)) {
+		/*
+		 * Special case for empty set - allow the architecture code
+		 * to set default SMP affinity.
+		 */
+		err = irq_select_affinity_usr(irq) ? -EINVAL : count;
+	} else {
+		err = irq_set_affinity(irq, mask) ?: count;
+	}
+
+free_cpumask:
+	free_cpumask_var(mask);
+	return err;
+}
+#endif
+
 #ifdef CONFIG_SPARSE_IRQ
 
 static void irq_kobj_release(struct kobject *kobj);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index eec9b94747439..91cee7270d221 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -143,6 +143,8 @@ EXPORT_SYMBOL(synchronize_irq);
 #ifdef CONFIG_SMP
 cpumask_var_t irq_default_affinity;
 
+int no_irq_affinity;
+
 static bool __irq_can_set_affinity(struct irq_desc *desc)
 {
 	if (!desc || !irqd_can_balance(&desc->irq_data) ||
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 623b8136e9af3..76f0dda1f26b8 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -100,7 +100,6 @@ static int irq_affinity_hint_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-int no_irq_affinity;
 static int irq_affinity_proc_show(struct seq_file *m, void *v)
 {
 	return show_irq_affinity(AFFINITY, m);
@@ -111,81 +110,20 @@ static int irq_affinity_list_proc_show(struct seq_file *m, void *v)
 	return show_irq_affinity(AFFINITY_LIST, m);
 }
 
-#ifndef CONFIG_AUTO_IRQ_AFFINITY
-static inline int irq_select_affinity_usr(unsigned int irq)
-{
-	/*
-	 * If the interrupt is started up already then this fails. The
-	 * interrupt is assigned to an online CPU already. There is no
-	 * point to move it around randomly. Tell user space that the
-	 * selected mask is bogus.
-	 *
-	 * If not then any change to the affinity is pointless because the
-	 * startup code invokes irq_setup_affinity() which will select
-	 * a online CPU anyway.
-	 */
-	return -EINVAL;
-}
-#else
-/* ALPHA magic affinity auto selector. Keep it for historical reasons. */
-static inline int irq_select_affinity_usr(unsigned int irq)
-{
-	return irq_select_affinity(irq);
-}
-#endif
-
-static ssize_t write_irq_affinity(int type, struct file *file,
+static ssize_t irq_affinity_proc_write(struct file *file,
 		const char __user *buffer, size_t count, loff_t *pos)
 {
 	unsigned int irq = (int)(long)pde_data(file_inode(file));
-	cpumask_var_t new_value;
-	int err;
-
-	if (!irq_can_set_affinity_usr(irq) || no_irq_affinity)
-		return -EIO;
-
-	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
-		return -ENOMEM;
-
-	if (type)
-		err = cpumask_parselist_user(buffer, count, new_value);
-	else
-		err = cpumask_parse_user(buffer, count, new_value);
-	if (err)
-		goto free_cpumask;
 
-	/*
-	 * Do not allow disabling IRQs completely - it's a too easy
-	 * way to make the system unusable accidentally :-) At least
-	 * one online CPU still has to be targeted.
-	 */
-	if (!cpumask_intersects(new_value, cpu_online_mask)) {
-		/*
-		 * Special case for empty set - allow the architecture code
-		 * to set default SMP affinity.
-		 */
-		err = irq_select_affinity_usr(irq) ? -EINVAL : count;
-	} else {
-		err = irq_set_affinity(irq, new_value);
-		if (!err)
-			err = count;
-	}
-
-free_cpumask:
-	free_cpumask_var(new_value);
-	return err;
-}
-
-static ssize_t irq_affinity_proc_write(struct file *file,
-		const char __user *buffer, size_t count, loff_t *pos)
-{
-	return write_irq_affinity(0, file, buffer, count, pos);
+	return write_irq_affinity(irq, buffer, count, false, true);
 }
 
 static ssize_t irq_affinity_list_proc_write(struct file *file,
 		const char __user *buffer, size_t count, loff_t *pos)
 {
-	return write_irq_affinity(1, file, buffer, count, pos);
+	unsigned int irq = (int)(long)pde_data(file_inode(file));
+
+	return write_irq_affinity(irq, buffer, count, true, true);
 }
 
 static int irq_affinity_proc_open(struct inode *inode, struct file *file)
-- 
2.40.1

