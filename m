Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19CE6E09C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjDMJIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjDMJIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:08:21 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9284222;
        Thu, 13 Apr 2023 02:08:11 -0700 (PDT)
X-UUID: b2cfbb5ad9da11edb6b9f13eb10bd0fe-20230413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RlFwX5X9kVFzvo1JT9dIiD06WWwxoGOYHnal8lHLeOU=;
        b=DxkF9jIiSb7/oTS5nZlhU9XmFSyuveh9xM9HyHNtfS4vUD8h/2rnCftPX0o8xZbK+p2R4Wr3rf8GY1UGyS3QpgUDlSYxaNeCLlN3veuTRfDPJCPOBKgPWuKn7FjeqxzRAITGmjHAPmsYXfGqvvgLROuUbR5ZMWZLpHzvAUANDMc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:943ebe18-d2ba-47be-b6fc-c1172fbd780c,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.22,REQID:943ebe18-d2ba-47be-b6fc-c1172fbd780c,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:120426c,CLOUDID:3fcfef83-cd9c-45f5-8134-710979e3df0e,B
        ulkID:230413170806J4LRT3NC,BulkQuantity:0,Recheck:0,SF:28|17|19|48|38|29,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: b2cfbb5ad9da11edb6b9f13eb10bd0fe-20230413
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 954268287; Thu, 13 Apr 2023 17:08:04 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 13 Apr 2023 17:08:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 13 Apr 2023 17:08:03 +0800
From:   Yi-De Wu <yi-de.wu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yingshiuan Pan <yingshiuan.pan@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Jades Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Yi-De Wu <yi-de.wu@mediatek.com>
Subject: [PATCH v1 6/6] soc: mediatek: virt: geniezone: Add irqfd support
Date:   Thu, 13 Apr 2023 17:07:35 +0800
Message-ID: <20230413090735.4182-7-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230413090735.4182-1-yi-de.wu@mediatek.com>
References: <20230413090735.4182-1-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>

irqfd enables other threads than vcpu threads to inject virtual interrupt
through irqfd asynchronously rather through ioctl interface. This interface
is necessary for VMM which creates separated thread for IO handling or uses
vhost devices.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 drivers/soc/mediatek/virt/geniezone/gzvm.h    |   8 +
 .../mediatek/virt/geniezone/gzvm_eventfd.c    | 497 ++++++++++++++++++
 .../mediatek/virt/geniezone/gzvm_irqchip.c    |  13 +
 drivers/soc/mediatek/virt/geniezone/gzvm_vm.c |  18 +-
 include/uapi/linux/gzvm_common.h              |  18 +
 5 files changed, 553 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm.h b/drivers/soc/mediatek/virt/geniezone/gzvm.h
index b0edf56c2832..c79f84c17bb1 100644
--- a/drivers/soc/mediatek/virt/geniezone/gzvm.h
+++ b/drivers/soc/mediatek/virt/geniezone/gzvm.h
@@ -99,6 +99,14 @@ int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1, unsigned long a2,
 #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
 #define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
 
+#define GZVM_USERSPACE_IRQ_SOURCE_ID		0
+#define GZVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID	1
+
+void gzvm_notify_acked_irq(struct gzvm *gzvm, unsigned int gsi);
+int gzvm_irqfd(struct gzvm *gzvm, struct gzvm_irqfd *args);
+int gzvm_irqfd_init(void);
+void gzvm_irqfd_exit(void);
+int gzvm_init_irqfd(struct gzvm *gzvm);
 int gzvm_init_ioeventfd(struct gzvm *gzvm);
 int gzvm_ioeventfd(struct gzvm *gzvm, struct gzvm_ioeventfd *args);
 bool gzvm_ioevent_write(struct gzvm_vcpu *vcpu, __u64 addr, int len,
diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm_eventfd.c b/drivers/soc/mediatek/virt/geniezone/gzvm_eventfd.c
index 63f042fefbe5..d8eea6c1a2d6 100644
--- a/drivers/soc/mediatek/virt/geniezone/gzvm_eventfd.c
+++ b/drivers/soc/mediatek/virt/geniezone/gzvm_eventfd.c
@@ -12,6 +12,503 @@
 #include <linux/slab.h>
 #include "gzvm.h"
 
+struct gzvm_irq_ack_notifier {
+	struct hlist_node link;
+	unsigned int gsi;
+	void (*irq_acked)(struct gzvm_irq_ack_notifier *ian);
+};
+
+/*
+ * Resampling irqfds are a special variety of irqfds used to emulate
+ * level triggered interrupts.  The interrupt is asserted on eventfd
+ * trigger.  On acknowledgment through the irq ack notifier, the
+ * interrupt is de-asserted and userspace is notified through the
+ * resamplefd.  All resamplers on the same gsi are de-asserted
+ * together, so we don't need to track the state of each individual
+ * user.  We can also therefore share the same irq source ID.
+ */
+struct gzvm_kernel_irqfd_resampler {
+	struct gzvm *gzvm;
+	/*
+	 * List of resampling struct _irqfd objects sharing this gsi.
+	 * RCU list modified under gzvm->irqfds.resampler_lock
+	 */
+	struct list_head list;
+	struct gzvm_irq_ack_notifier notifier;
+	/*
+	 * Entry in list of gzvm->irqfd.resampler_list.  Use for sharing
+	 * resamplers among irqfds on the same gsi.
+	 * Accessed and modified under gzvm->irqfds.resampler_lock
+	 */
+	struct list_head link;
+};
+
+struct gzvm_kernel_irqfd {
+	struct gzvm *gzvm;
+	wait_queue_entry_t wait;
+	/* Used for level IRQ fast-path */
+	int gsi;
+	/* The resampler used by this irqfd (resampler-only) */
+	struct gzvm_kernel_irqfd_resampler *resampler;
+	/* Eventfd notified on resample (resampler-only) */
+	struct eventfd_ctx *resamplefd;
+	/* Entry in list of irqfds for a resampler (resampler-only) */
+	struct list_head resampler_link;
+	/* Used for setup/shutdown */
+	struct eventfd_ctx *eventfd;
+	struct list_head list;
+	poll_table pt;
+	struct work_struct shutdown;
+};
+
+static struct workqueue_struct *irqfd_cleanup_wq;
+
+/**
+ * @brief irqfd to inject virtual interrupt
+ * @param irq This is spi interrupt number (starts from 0 instead of 32)
+ */
+static void irqfd_set_spi(struct gzvm *gzvm, int irq_source_id, u32 irq,
+			  int level, bool line_status)
+{
+	if (level)
+		gzvm_vgic_inject_spi(gzvm, 0, irq, level);
+}
+
+/*
+ * Since resampler irqfds share an IRQ source ID, we de-assert once
+ * then notify all of the resampler irqfds using this GSI.  We can't
+ * do multiple de-asserts or we risk racing with incoming re-asserts.
+ */
+static void
+irqfd_resampler_ack(struct gzvm_irq_ack_notifier *ian)
+{
+	struct gzvm_kernel_irqfd_resampler *resampler;
+	struct gzvm *gzvm;
+	struct gzvm_kernel_irqfd *irqfd;
+	int idx;
+
+	resampler = container_of(ian,
+			struct gzvm_kernel_irqfd_resampler, notifier);
+	gzvm = resampler->gzvm;
+
+	irqfd_set_spi(gzvm, GZVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID,
+		      resampler->notifier.gsi, 0, false);
+
+	idx = srcu_read_lock(&gzvm->irq_srcu);
+
+	list_for_each_entry_srcu(irqfd, &resampler->list, resampler_link,
+	    srcu_read_lock_held(&gzvm->irq_srcu)) {
+		eventfd_signal(irqfd->resamplefd, 1);
+	}
+
+	srcu_read_unlock(&gzvm->irq_srcu, idx);
+}
+
+static void gzvm_register_irq_ack_notifier(struct gzvm *gzvm,
+					   struct gzvm_irq_ack_notifier *ian)
+{
+	mutex_lock(&gzvm->irq_lock);
+	hlist_add_head_rcu(&ian->link, &gzvm->irq_ack_notifier_list);
+	mutex_unlock(&gzvm->irq_lock);
+}
+
+static void gzvm_unregister_irq_ack_notifier(struct gzvm *gzvm,
+					     struct gzvm_irq_ack_notifier *ian)
+{
+	mutex_lock(&gzvm->irq_lock);
+	hlist_del_init_rcu(&ian->link);
+	mutex_unlock(&gzvm->irq_lock);
+	synchronize_srcu(&gzvm->irq_srcu);
+}
+
+static void
+irqfd_resampler_shutdown(struct gzvm_kernel_irqfd *irqfd)
+{
+	struct gzvm_kernel_irqfd_resampler *resampler = irqfd->resampler;
+	struct gzvm *gzvm = resampler->gzvm;
+
+	mutex_lock(&gzvm->irqfds.resampler_lock);
+
+	list_del_rcu(&irqfd->resampler_link);
+	synchronize_srcu(&gzvm->irq_srcu);
+
+	if (list_empty(&resampler->list)) {
+		list_del(&resampler->link);
+		gzvm_unregister_irq_ack_notifier(gzvm, &resampler->notifier);
+		irqfd_set_spi(gzvm, GZVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID,
+			      resampler->notifier.gsi, 0, false);
+		kfree(resampler);
+	}
+
+	mutex_unlock(&gzvm->irqfds.resampler_lock);
+}
+
+/*
+ * Race-free decouple logic (ordering is critical)
+ */
+static void
+irqfd_shutdown(struct work_struct *work)
+{
+	struct gzvm_kernel_irqfd *irqfd =
+		container_of(work, struct gzvm_kernel_irqfd, shutdown);
+	struct gzvm *gzvm = irqfd->gzvm;
+	u64 cnt;
+
+	/* Make sure irqfd has been initialized in assign path. */
+	synchronize_srcu(&gzvm->irq_srcu);
+
+	/*
+	 * Synchronize with the wait-queue and unhook ourselves to prevent
+	 * further events.
+	 */
+	eventfd_ctx_remove_wait_queue(irqfd->eventfd, &irqfd->wait, &cnt);
+
+	if (irqfd->resampler) {
+		irqfd_resampler_shutdown(irqfd);
+		eventfd_ctx_put(irqfd->resamplefd);
+	}
+
+	/*
+	 * It is now safe to release the object's resources
+	 */
+	eventfd_ctx_put(irqfd->eventfd);
+	kfree(irqfd);
+}
+
+
+/* assumes gzvm->irqfds.lock is held */
+static bool
+irqfd_is_active(struct gzvm_kernel_irqfd *irqfd)
+{
+	return list_empty(&irqfd->list) ? false : true;
+}
+
+/*
+ * Mark the irqfd as inactive and schedule it for removal
+ *
+ * assumes gzvm->irqfds.lock is held
+ */
+static void
+irqfd_deactivate(struct gzvm_kernel_irqfd *irqfd)
+{
+	if (!irqfd_is_active(irqfd))
+		return;
+
+	list_del_init(&irqfd->list);
+
+	queue_work(irqfd_cleanup_wq, &irqfd->shutdown);
+}
+
+/**
+ * @brief Wake up irqfd to do virtual interrupt injection
+ */
+static int
+irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode, int sync, void *key)
+{
+	struct gzvm_kernel_irqfd *irqfd =
+		container_of(wait, struct gzvm_kernel_irqfd, wait);
+	__poll_t flags = key_to_poll(key);
+	struct gzvm *gzvm = irqfd->gzvm;
+
+	if (flags & EPOLLIN) {
+		u64 cnt;
+
+		eventfd_ctx_do_read(irqfd->eventfd, &cnt);
+		/* gzvm's irq injection is not blocked, don't need workq */
+		irqfd_set_spi(gzvm, GZVM_USERSPACE_IRQ_SOURCE_ID, irqfd->gsi, 1,
+			      false);
+	}
+
+	if (flags & EPOLLHUP) {
+		/* The eventfd is closing, detach from GZVM */
+		unsigned long iflags;
+
+		spin_lock_irqsave(&gzvm->irqfds.lock, iflags);
+
+		/*
+		 * Do more check if someone deactivated the irqfd before
+		 * we could acquire the irqfds.lock.
+		 */
+		if (irqfd_is_active(irqfd))
+			irqfd_deactivate(irqfd);
+
+		spin_unlock_irqrestore(&gzvm->irqfds.lock, iflags);
+	}
+
+	return 0;
+}
+
+static void
+irqfd_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh,
+			poll_table *pt)
+{
+	struct gzvm_kernel_irqfd *irqfd =
+		container_of(pt, struct gzvm_kernel_irqfd, pt);
+	add_wait_queue_priority(wqh, &irqfd->wait);
+}
+
+static int
+gzvm_irqfd_assign(struct gzvm *gzvm, struct gzvm_irqfd *args)
+{
+	struct gzvm_kernel_irqfd *irqfd, *tmp;
+	struct fd f;
+	struct eventfd_ctx *eventfd = NULL, *resamplefd = NULL;
+	int ret;
+	__poll_t events;
+	int idx;
+
+	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL_ACCOUNT);
+	if (!irqfd)
+		return -ENOMEM;
+
+	irqfd->gzvm = gzvm;
+	irqfd->gsi = args->gsi;
+	irqfd->resampler = NULL;
+	INIT_LIST_HEAD(&irqfd->list);
+	INIT_WORK(&irqfd->shutdown, irqfd_shutdown);
+
+	f = fdget(args->fd);
+	if (!f.file) {
+		ret = -EBADF;
+		goto out;
+	}
+
+	eventfd = eventfd_ctx_fileget(f.file);
+	if (IS_ERR(eventfd)) {
+		ret = PTR_ERR(eventfd);
+		goto fail;
+	}
+
+	irqfd->eventfd = eventfd;
+
+	if (args->flags & GZVM_IRQFD_FLAG_RESAMPLE) {
+		struct gzvm_kernel_irqfd_resampler *resampler;
+
+		resamplefd = eventfd_ctx_fdget(args->resamplefd);
+		if (IS_ERR(resamplefd)) {
+			ret = PTR_ERR(resamplefd);
+			goto fail;
+		}
+
+		irqfd->resamplefd = resamplefd;
+		INIT_LIST_HEAD(&irqfd->resampler_link);
+
+		mutex_lock(&gzvm->irqfds.resampler_lock);
+
+		list_for_each_entry(resampler,
+				    &gzvm->irqfds.resampler_list, link) {
+			if (resampler->notifier.gsi == irqfd->gsi) {
+				irqfd->resampler = resampler;
+				break;
+			}
+		}
+
+		if (!irqfd->resampler) {
+			resampler = kzalloc(sizeof(*resampler),
+					    GFP_KERNEL_ACCOUNT);
+			if (!resampler) {
+				ret = -ENOMEM;
+				mutex_unlock(&gzvm->irqfds.resampler_lock);
+				goto fail;
+			}
+
+			resampler->gzvm = gzvm;
+			INIT_LIST_HEAD(&resampler->list);
+			resampler->notifier.gsi = irqfd->gsi;
+			resampler->notifier.irq_acked = irqfd_resampler_ack;
+			INIT_LIST_HEAD(&resampler->link);
+
+			list_add(&resampler->link, &gzvm->irqfds.resampler_list);
+			gzvm_register_irq_ack_notifier(gzvm,
+						       &resampler->notifier);
+			irqfd->resampler = resampler;
+		}
+
+		list_add_rcu(&irqfd->resampler_link, &irqfd->resampler->list);
+		synchronize_srcu(&gzvm->irq_srcu);
+
+		mutex_unlock(&gzvm->irqfds.resampler_lock);
+	}
+
+	/*
+	 * Install our own custom wake-up handling so we are notified via
+	 * a callback whenever someone signals the underlying eventfd
+	 */
+	init_waitqueue_func_entry(&irqfd->wait, irqfd_wakeup);
+	init_poll_funcptr(&irqfd->pt, irqfd_ptable_queue_proc);
+
+	spin_lock_irq(&gzvm->irqfds.lock);
+
+	ret = 0;
+	list_for_each_entry(tmp, &gzvm->irqfds.items, list) {
+		if (irqfd->eventfd != tmp->eventfd)
+			continue;
+		/* This fd is used for another irq already. */
+		pr_err("already used: gsi=%d fd=%d\n", args->gsi, args->fd);
+		ret = -EBUSY;
+		spin_unlock_irq(&gzvm->irqfds.lock);
+		goto fail;
+	}
+
+	idx = srcu_read_lock(&gzvm->irq_srcu);
+
+	list_add_tail(&irqfd->list, &gzvm->irqfds.items);
+
+	spin_unlock_irq(&gzvm->irqfds.lock);
+
+	/*
+	 * Check if there was an event already pending on the eventfd
+	 * before we registered, and trigger it as if we didn't miss it.
+	 */
+	events = vfs_poll(f.file, &irqfd->pt);
+
+	/* In case there is already a pending event */
+	if (events & EPOLLIN)
+		irqfd_set_spi(gzvm, GZVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID,
+			      irqfd->gsi, 1, false);
+
+	srcu_read_unlock(&gzvm->irq_srcu, idx);
+
+	/*
+	 * do not drop the file until the irqfd is fully initialized, otherwise
+	 * we might race against the EPOLLHUP
+	 */
+	fdput(f);
+	return 0;
+
+fail:
+	if (irqfd->resampler)
+		irqfd_resampler_shutdown(irqfd);
+
+	if (resamplefd && !IS_ERR(resamplefd))
+		eventfd_ctx_put(resamplefd);
+
+	if (eventfd && !IS_ERR(eventfd))
+		eventfd_ctx_put(eventfd);
+
+	fdput(f);
+
+out:
+	kfree(irqfd);
+	return ret;
+}
+
+static void gzvm_notify_acked_gsi(struct gzvm *gzvm, int gsi)
+{
+	struct gzvm_irq_ack_notifier *gian;
+
+	hlist_for_each_entry_srcu(gian, &gzvm->irq_ack_notifier_list,
+				  link, srcu_read_lock_held(&gzvm->irq_srcu))
+		if (gian->gsi == gsi)
+			gian->irq_acked(gian);
+}
+
+void gzvm_notify_acked_irq(struct gzvm *gzvm, unsigned int gsi)
+{
+	int idx;
+
+	idx = srcu_read_lock(&gzvm->irq_srcu);
+	gzvm_notify_acked_gsi(gzvm, gsi);
+	srcu_read_unlock(&gzvm->irq_srcu, idx);
+}
+
+/*
+ * shutdown any irqfd's that match fd+gsi
+ */
+static int gzvm_irqfd_deassign(struct gzvm *gzvm, struct gzvm_irqfd *args)
+{
+	struct gzvm_kernel_irqfd *irqfd, *tmp;
+	struct eventfd_ctx *eventfd;
+
+	eventfd = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(eventfd))
+		return PTR_ERR(eventfd);
+
+	spin_lock_irq(&gzvm->irqfds.lock);
+
+	list_for_each_entry_safe(irqfd, tmp, &gzvm->irqfds.items, list) {
+		if (irqfd->eventfd == eventfd && irqfd->gsi == args->gsi)
+			irqfd_deactivate(irqfd);
+	}
+
+	spin_unlock_irq(&gzvm->irqfds.lock);
+	eventfd_ctx_put(eventfd);
+
+	/*
+	 * Block until we know all outstanding shutdown jobs have completed
+	 * so that we guarantee there will not be any more interrupts on this
+	 * gsi once this deassign function returns.
+	 */
+	flush_workqueue(irqfd_cleanup_wq);
+
+	return 0;
+}
+
+int gzvm_irqfd(struct gzvm *gzvm, struct gzvm_irqfd *args)
+{
+	if (args->flags &
+	    ~(GZVM_IRQFD_FLAG_DEASSIGN | GZVM_IRQFD_FLAG_RESAMPLE))
+		return -EINVAL;
+
+	if (args->flags & GZVM_IRQFD_FLAG_DEASSIGN)
+		return gzvm_irqfd_deassign(gzvm, args);
+
+	return gzvm_irqfd_assign(gzvm, args);
+}
+
+/*
+ * This function is called as the gzvm VM fd is being released. Shutdown all
+ * irqfds that still remain open
+ */
+void gzvm_irqfd_release(struct gzvm *gzvm)
+{
+	struct gzvm_kernel_irqfd *irqfd, *tmp;
+
+	spin_lock_irq(&gzvm->irqfds.lock);
+
+	list_for_each_entry_safe(irqfd, tmp, &gzvm->irqfds.items, list)
+		irqfd_deactivate(irqfd);
+
+	spin_unlock_irq(&gzvm->irqfds.lock);
+
+	/*
+	 * Block until we know all outstanding shutdown jobs have completed.
+	 */
+	flush_workqueue(irqfd_cleanup_wq);
+}
+
+/*
+ * create a host-wide workqueue for issuing deferred shutdown requests
+ * aggregated from all vm* instances. We need our own isolated
+ * queue to ease flushing work items when a VM exits.
+ */
+int gzvm_irqfd_init(void)
+{
+	irqfd_cleanup_wq = alloc_workqueue("gzvm-irqfd-cleanup", 0, 0);
+	if (!irqfd_cleanup_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void gzvm_irqfd_exit(void)
+{
+	destroy_workqueue(irqfd_cleanup_wq);
+}
+
+int gzvm_init_irqfd(struct gzvm *gzvm)
+{
+	spin_lock_init(&gzvm->irqfds.lock);
+	INIT_LIST_HEAD(&gzvm->irqfds.items);
+	INIT_LIST_HEAD(&gzvm->irqfds.resampler_list);
+	if (init_srcu_struct(&gzvm->irq_srcu))
+		return -EINVAL;
+	INIT_HLIST_HEAD(&gzvm->irq_ack_notifier_list);
+	mutex_init(&gzvm->irqfds.resampler_lock);
+
+	return 0;
+}
+
 struct gzvm_ioevent {
 	struct list_head list;
 	__u64 addr;
diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm_irqchip.c b/drivers/soc/mediatek/virt/geniezone/gzvm_irqchip.c
index 7aa5868a221c..134fa5e5715e 100644
--- a/drivers/soc/mediatek/virt/geniezone/gzvm_irqchip.c
+++ b/drivers/soc/mediatek/virt/geniezone/gzvm_irqchip.c
@@ -8,6 +8,12 @@
 
 #include "gzvm.h"
 
+static bool lr_signals_eoi(uint64_t lr_val)
+{
+	return !(lr_val & ICH_LR_STATE) && (lr_val & ICH_LR_EOI) &&
+	       !(lr_val & ICH_LR_HW);
+}
+
 /**
  * @brief check all LRs synced from gz hypervisor
  * Traverse all LRs, see if any EOIed vint, notify_acked_irq if any.
@@ -20,10 +26,17 @@ void gzvm_sync_vgic_state(struct gzvm_vcpu *vcpu)
 	int i;
 
 	for (i = 0; i < vcpu->hwstate->nr_lrs; i++) {
+		uint32_t vintid;
 		uint64_t lr_val = vcpu->hwstate->lr[i];
 		/* 0 means unused */
 		if (!lr_val)
 			continue;
+
+		vintid = lr_val & ICH_LR_VIRTUAL_ID_MASK;
+		if (lr_signals_eoi(lr_val)) {
+			gzvm_notify_acked_irq(vcpu->gzvm,
+					      vintid - VGIC_NR_PRIVATE_IRQS);
+		}
 	}
 }
 
diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm_vm.c b/drivers/soc/mediatek/virt/geniezone/gzvm_vm.c
index cceaa532c2ce..e4bea025e45e 100644
--- a/drivers/soc/mediatek/virt/geniezone/gzvm_vm.c
+++ b/drivers/soc/mediatek/virt/geniezone/gzvm_vm.c
@@ -386,6 +386,15 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 		ret = gzvm_ioeventfd(gzvm, &data);
 		break;
 	}
+	case GZVM_IRQFD: {
+		struct gzvm_irqfd data;
+
+		ret = -EFAULT;
+		if (copy_from_user(&data, argp, sizeof(data)))
+			goto out;
+		ret = gzvm_irqfd(gzvm, &data);
+		break;
+	}
 	case GZVM_ENABLE_CAP: {
 		struct gzvm_enable_cap cap;
 
@@ -490,13 +499,20 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 	mutex_init(&gzvm->lock);
 	INIT_LIST_HEAD(&gzvm->devices);
 	mutex_init(&gzvm->irq_lock);
+
 	ret = gzvm_init_ioeventfd(gzvm);
 	if (ret) {
 		pr_err("Failed to initialize ioeventfd\n");
 		goto err;
 	}
-	pr_info("VM-%u is created\n", gzvm->vm_id);
 
+	ret = gzvm_init_irqfd(gzvm);
+	if (ret) {
+		pr_err("Failed to initialize irqfd\n");
+		goto err;
+	}
+
+	pr_info("VM-%u is created\n", gzvm->vm_id);
 	mutex_lock(&gzvm_list_lock);
 	list_add(&gzvm->vm_list, &gzvm_list);
 	mutex_unlock(&gzvm_list_lock);
diff --git a/include/uapi/linux/gzvm_common.h b/include/uapi/linux/gzvm_common.h
index 6dbaddd77ec7..3af9d148042f 100644
--- a/include/uapi/linux/gzvm_common.h
+++ b/include/uapi/linux/gzvm_common.h
@@ -193,6 +193,24 @@ struct gzvm_irq_level {
 #define GZVM_IRQ_LINE              _IOW(GZVM_IOC_MAGIC,  0x61, \
 					struct gzvm_irq_level)
 
+#define GZVM_IRQFD_FLAG_DEASSIGN (1 << 0)
+/*
+ * GZVM_IRQFD_FLAG_RESAMPLE indicates resamplefd is valid and specifies
+ * the irqfd to operate in resampling mode for level triggered interrupt
+ * emulation.
+ */
+#define GZVM_IRQFD_FLAG_RESAMPLE (1 << 1)
+
+struct gzvm_irqfd {
+	__u32 fd;
+	__u32 gsi;
+	__u32 flags;
+	__u32 resamplefd;
+	__u8  pad[16];
+};
+#define GZVM_IRQFD                 _IOW(GZVM_IOC_MAGIC,  0x76, \
+					struct gzvm_irqfd)
+
 enum {
 	gzvm_ioeventfd_flag_nr_datamatch,
 	gzvm_ioeventfd_flag_nr_pio,
-- 
2.18.0

