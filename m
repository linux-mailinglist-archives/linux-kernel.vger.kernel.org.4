Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9C06E09BE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjDMJIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjDMJIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:08:18 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87DE180;
        Thu, 13 Apr 2023 02:08:09 -0700 (PDT)
X-UUID: b2b2697ed9da11edb6b9f13eb10bd0fe-20230413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9RlUHcwmASbOr8nBNERP6xk9ihOcrJHrMLiKF4qH658=;
        b=eylvL7/VBIQbkmG/kRjMrWJ9YFz3VZ5F4fULPgoMVuE+41L9X2dkQn74vcX9VTjb+TPSXS9BhpXKsGDfTrney/l/XhNUXFPFmYCRt3fSL6hi0N478WnQcy0w2BmM6lyq9mOIPh2LPs4GfHcJrielzmV8cC4USFK8YjShYi0GgzE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:552df493-f27a-4950-b576-797a2644279c,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.22,REQID:552df493-f27a-4950-b576-797a2644279c,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:120426c,CLOUDID:80cb34a1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:2304131708060ZN9MV0D,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: b2b2697ed9da11edb6b9f13eb10bd0fe-20230413
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2139487939; Thu, 13 Apr 2023 17:08:04 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
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
Subject: [PATCH v1 5/6] soc: mediatek: virt: geniezone: Add ioeventfd support
Date:   Thu, 13 Apr 2023 17:07:34 +0800
Message-ID: <20230413090735.4182-6-yi-de.wu@mediatek.com>
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

ioeventfd leverages eventfd to provide asynchronous notification mechanism
for VMM. VMM can register a mmio address and bind with an eventfd. Once a
mmio trap occurs on this registered region, its corresponding eventfd will
be notified.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 drivers/soc/mediatek/virt/geniezone/Makefile  |   2 +-
 drivers/soc/mediatek/virt/geniezone/gzvm.h    |  10 +
 .../mediatek/virt/geniezone/gzvm_eventfd.c    | 252 ++++++++++++++++++
 .../soc/mediatek/virt/geniezone/gzvm_vcpu.c   |  26 +-
 drivers/soc/mediatek/virt/geniezone/gzvm_vm.c |  14 +
 include/uapi/linux/gzvm_common.h              |  24 ++
 6 files changed, 326 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soc/mediatek/virt/geniezone/gzvm_eventfd.c

diff --git a/drivers/soc/mediatek/virt/geniezone/Makefile b/drivers/soc/mediatek/virt/geniezone/Makefile
index d2302a3a93fc..dc6c760231e2 100644
--- a/drivers/soc/mediatek/virt/geniezone/Makefile
+++ b/drivers/soc/mediatek/virt/geniezone/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-gzvm-y := gzvm_main.o gzvm_vm.o gzvm_vcpu.o gzvm_irqchip.o
+gzvm-y := gzvm_main.o gzvm_vm.o gzvm_vcpu.o gzvm_irqchip.o gzvm_eventfd.o
 
 obj-$(CONFIG_MTK_GZVM) += gzvm.o
diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm.h b/drivers/soc/mediatek/virt/geniezone/gzvm.h
index 89cea5441a2d..b0edf56c2832 100644
--- a/drivers/soc/mediatek/virt/geniezone/gzvm.h
+++ b/drivers/soc/mediatek/virt/geniezone/gzvm.h
@@ -37,6 +37,7 @@ struct gzvm {
 	struct list_head devices;
 	gzvm_id_t vm_id;
 
+	struct list_head ioevents;
 	struct {
 		spinlock_t        lock;
 		struct list_head  items;
@@ -98,6 +99,10 @@ int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1, unsigned long a2,
 #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
 #define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
 
+int gzvm_init_ioeventfd(struct gzvm *gzvm);
+int gzvm_ioeventfd(struct gzvm *gzvm, struct gzvm_ioeventfd *args);
+bool gzvm_ioevent_write(struct gzvm_vcpu *vcpu, __u64 addr, int len,
+			const void *val);
 void gzvm_sync_vgic_state(struct gzvm_vcpu *vcpu);
 int gzvm_vgic_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx, u32 irq_type,
 			 u32 irq, bool level);
@@ -105,4 +110,9 @@ int gzvm_vgic_inject_spi(struct gzvm *gzvm, unsigned int vcpu_idx,
 			 u32 spi_irq, bool level);
 int gz_err_to_errno(unsigned long err);
 
+#include <linux/eventfd.h>
+void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
+struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr);
+void add_wait_queue_priority(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry);
+
 #endif /* __GZVM_H__ */
diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm_eventfd.c b/drivers/soc/mediatek/virt/geniezone/gzvm_eventfd.c
new file mode 100644
index 000000000000..63f042fefbe5
--- /dev/null
+++ b/drivers/soc/mediatek/virt/geniezone/gzvm_eventfd.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <linux/eventfd.h>
+#include <linux/file.h>
+#include <linux/syscalls.h>
+#include <linux/wait.h>
+#include <linux/poll.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include "gzvm.h"
+
+struct gzvm_ioevent {
+	struct list_head list;
+	__u64 addr;
+	__u32 len;
+	struct eventfd_ctx  *evt_ctx;
+	__u64 datamatch;
+	bool wildcard;
+};
+
+/* assumes gzvm->slots_lock held */
+static bool
+ioeventfd_check_collision(struct gzvm *gzvm, struct gzvm_ioevent *p)
+{
+	struct gzvm_ioevent *_p;
+
+	list_for_each_entry(_p, &gzvm->ioevents, list)
+		if (_p->addr == p->addr &&
+		    (!_p->len || !p->len ||
+		     (_p->len == p->len &&
+		      (_p->wildcard || p->wildcard ||
+		       _p->datamatch == p->datamatch))))
+			return true;
+
+	return false;
+}
+
+static void gzvm_ioevent_release(struct gzvm_ioevent *p)
+{
+	eventfd_ctx_put(p->evt_ctx);
+	list_del(&p->list);
+	kfree(p);
+}
+
+static bool
+gzvm_ioevent_in_range(struct gzvm_ioevent *p, __u64 addr, int len,
+		      const void *val)
+{
+	u64 _val;
+
+	if (addr != p->addr)
+		/* address must be precise for a hit */
+		return false;
+
+	if (!p->len)
+		/* length = 0 means only look at the address, so always a hit */
+		return true;
+
+	if (len != p->len)
+		/* address-range must be precise for a hit */
+		return false;
+
+	if (p->wildcard)
+		/* all else equal, wildcard is always a hit */
+		return true;
+
+	/* otherwise, we have to actually compare the data */
+
+	WARN_ON_ONCE(!IS_ALIGNED((unsigned long)val, len));
+
+	switch (len) {
+	case 1:
+		_val = *(u8 *)val;
+		break;
+	case 2:
+		_val = *(u16 *)val;
+		break;
+	case 4:
+		_val = *(u32 *)val;
+		break;
+	case 8:
+		_val = *(u64 *)val;
+		break;
+	default:
+		return false;
+	}
+
+	return _val == p->datamatch;
+}
+
+static int gzvm_deassign_ioeventfd(struct gzvm *gzvm,
+				   struct gzvm_ioeventfd *args)
+{
+	struct gzvm_ioevent *p, *tmp;
+	struct eventfd_ctx *evt_ctx;
+	int ret = -ENOENT;
+	bool wildcard;
+
+	evt_ctx = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(evt_ctx))
+		return PTR_ERR(evt_ctx);
+
+	wildcard = !(args->flags & GZVM_IOEVENTFD_FLAG_DATAMATCH);
+
+	mutex_lock(&gzvm->lock);
+
+	list_for_each_entry_safe(p, tmp, &gzvm->ioevents, list) {
+		if (p->evt_ctx != evt_ctx  ||
+		    p->addr != args->addr  ||
+		    p->len != args->len ||
+		    p->wildcard != wildcard)
+			continue;
+
+		if (!p->wildcard && p->datamatch != args->datamatch)
+			continue;
+
+		gzvm_ioevent_release(p);
+		ret = 0;
+		break;
+	}
+
+	mutex_unlock(&gzvm->lock);
+
+	/* got in the front of this function */
+	eventfd_ctx_put(evt_ctx);
+
+	return ret;
+}
+
+static int gzvm_assign_ioeventfd(struct gzvm *gzvm, struct gzvm_ioeventfd *args)
+{
+	struct eventfd_ctx *evt_ctx;
+	struct gzvm_ioevent *evt;
+	int ret;
+
+	evt_ctx = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(evt_ctx))
+		return PTR_ERR(evt_ctx);
+
+	evt = kmalloc(sizeof(*evt), GFP_KERNEL);
+	if (!evt)
+		return -ENOMEM;
+	*evt = (struct gzvm_ioevent) {
+		.addr = args->addr,
+		.len = args->len,
+		.evt_ctx = evt_ctx,
+	};
+	if (args->flags & GZVM_IOEVENTFD_FLAG_DATAMATCH) {
+		evt->datamatch = args->datamatch;
+		evt->wildcard = false;
+	} else {
+		evt->wildcard = true;
+	}
+
+	if (ioeventfd_check_collision(gzvm, evt)) {
+		ret = -EEXIST;
+		goto err_free;
+	}
+
+	mutex_lock(&gzvm->lock);
+	list_add_tail(&evt->list, &gzvm->ioevents);
+	mutex_unlock(&gzvm->lock);
+
+	return 0;
+
+err_free:
+	kfree(evt);
+	eventfd_ctx_put(evt_ctx);
+	return ret;
+}
+
+/**
+ * @brief Check user arguments is valid
+ *
+ * @param args
+ * @retval true valid arguments
+ * @retval false invalid arguments
+ */
+static bool gzvm_ioeventfd_check_valid(struct gzvm_ioeventfd *args)
+{
+	/* must be natural-word sized, or 0 to ignore length */
+	switch (args->len) {
+	case 0:
+	case 1:
+	case 2:
+	case 4:
+	case 8:
+		break;
+	default:
+		return false;
+	}
+
+	/* check for range overflow */
+	if (args->addr + args->len < args->addr)
+		return false;
+
+	/* check for extra flags that we don't understand */
+	if (args->flags & ~GZVM_IOEVENTFD_VALID_FLAG_MASK)
+		return false;
+
+	/* ioeventfd with no length can't be combined with DATAMATCH */
+	if (!args->len && (args->flags & GZVM_IOEVENTFD_FLAG_DATAMATCH))
+		return false;
+
+	/* gzvm does not support pio bus ioeventfd */
+	if (args->flags & GZVM_IOEVENTFD_FLAG_PIO)
+		return false;
+
+	return true;
+}
+
+/**
+ * @brief GZVM_IOEVENTFD, register ioevent to ioevent list
+ */
+int gzvm_ioeventfd(struct gzvm *gzvm, struct gzvm_ioeventfd *args)
+{
+	if (gzvm_ioeventfd_check_valid(args) == false)
+		return -EINVAL;
+
+	if (args->flags & GZVM_IOEVENTFD_FLAG_DEASSIGN)
+		return gzvm_deassign_ioeventfd(gzvm, args);
+	return gzvm_assign_ioeventfd(gzvm, args);
+}
+
+/**
+ * @brief Travers this vm's registered ioeventfd to see if need notifying it
+ * @retval true if this io is already sent to ioeventfd's listner
+ * @retval false if we cannot find any ioeventfd registering this mmio write
+ */
+bool gzvm_ioevent_write(struct gzvm_vcpu *vcpu, __u64 addr, int len,
+			const void *val)
+{
+	struct gzvm_ioevent *e;
+
+	list_for_each_entry(e, &vcpu->gzvm->ioevents, list) {
+		if (gzvm_ioevent_in_range(e, addr, len, val)) {
+			eventfd_signal(e->evt_ctx, 1);
+			return true;
+		}
+	}
+	return false;
+}
+
+int gzvm_init_ioeventfd(struct gzvm *gzvm)
+{
+	INIT_LIST_HEAD(&gzvm->ioevents);
+
+	return 0;
+}
diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm_vcpu.c b/drivers/soc/mediatek/virt/geniezone/gzvm_vcpu.c
index 5f2e24d13c41..14a9fe14e79d 100644
--- a/drivers/soc/mediatek/virt/geniezone/gzvm_vcpu.c
+++ b/drivers/soc/mediatek/virt/geniezone/gzvm_vcpu.c
@@ -72,6 +72,29 @@ static void gzvm_sync_hwstate(struct gzvm_vcpu *vcpu)
 	gzvm_sync_vgic_state(vcpu);
 }
 
+/**
+ * @brief try to handle mmio in kernel space
+ *
+ * @param vcpu
+ * @return true this mmio exit has been processed.
+ * @return false this mmio exit has not been processed, require userspace.
+ */
+static bool gzvm_vcpu_handle_mmio(struct gzvm_vcpu *vcpu)
+{
+	__u64 addr;
+	__u32 len;
+	const void *val_ptr;
+
+	/* So far, we don't have in-kernel mmio read handler */
+	if (!vcpu->run->mmio.is_write)
+		return false;
+	addr = vcpu->run->mmio.phys_addr;
+	len = vcpu->run->mmio.size;
+	val_ptr = &vcpu->run->mmio.data;
+
+	return gzvm_ioevent_write(vcpu, addr, len, val_ptr);
+}
+
 /**
  * @brief Handle vcpu run ioctl, entry point to guest and exit point from guest
  *
@@ -97,7 +120,8 @@ static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void * __user argp)
 				     0, &res);
 		switch (res.a1) {
 		case GZVM_EXIT_MMIO:
-			need_userspace = true;
+			if (!gzvm_vcpu_handle_mmio(vcpu))
+				need_userspace = true;
 			break;
 		/*
 		 * geniezone's responsibility to fill corresponding data
diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm_vm.c b/drivers/soc/mediatek/virt/geniezone/gzvm_vm.c
index 7895f40b23eb..cceaa532c2ce 100644
--- a/drivers/soc/mediatek/virt/geniezone/gzvm_vm.c
+++ b/drivers/soc/mediatek/virt/geniezone/gzvm_vm.c
@@ -377,6 +377,15 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 		ret = gzvm_vm_ioctl_create_device(gzvm, argp);
 		break;
 	}
+	case GZVM_IOEVENTFD: {
+		struct gzvm_ioeventfd data;
+
+		ret = -EFAULT;
+		if (copy_from_user(&data, argp, sizeof(data)))
+			goto out;
+		ret = gzvm_ioeventfd(gzvm, &data);
+		break;
+	}
 	case GZVM_ENABLE_CAP: {
 		struct gzvm_enable_cap cap;
 
@@ -481,6 +490,11 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 	mutex_init(&gzvm->lock);
 	INIT_LIST_HEAD(&gzvm->devices);
 	mutex_init(&gzvm->irq_lock);
+	ret = gzvm_init_ioeventfd(gzvm);
+	if (ret) {
+		pr_err("Failed to initialize ioeventfd\n");
+		goto err;
+	}
 	pr_info("VM-%u is created\n", gzvm->vm_id);
 
 	mutex_lock(&gzvm_list_lock);
diff --git a/include/uapi/linux/gzvm_common.h b/include/uapi/linux/gzvm_common.h
index 6808cfe59450..6dbaddd77ec7 100644
--- a/include/uapi/linux/gzvm_common.h
+++ b/include/uapi/linux/gzvm_common.h
@@ -193,6 +193,30 @@ struct gzvm_irq_level {
 #define GZVM_IRQ_LINE              _IOW(GZVM_IOC_MAGIC,  0x61, \
 					struct gzvm_irq_level)
 
+enum {
+	gzvm_ioeventfd_flag_nr_datamatch,
+	gzvm_ioeventfd_flag_nr_pio,
+	gzvm_ioeventfd_flag_nr_deassign,
+	gzvm_ioeventfd_flag_nr_max,
+};
+
+#define GZVM_IOEVENTFD_FLAG_DATAMATCH (1 << gzvm_ioeventfd_flag_nr_datamatch)
+#define GZVM_IOEVENTFD_FLAG_PIO       (1 << gzvm_ioeventfd_flag_nr_pio)
+#define GZVM_IOEVENTFD_FLAG_DEASSIGN  (1 << gzvm_ioeventfd_flag_nr_deassign)
+#define GZVM_IOEVENTFD_VALID_FLAG_MASK  ((1 << gzvm_ioeventfd_flag_nr_max) - 1)
+
+struct gzvm_ioeventfd {
+	__u64 datamatch;
+	__u64 addr;        /* legal pio/mmio address */
+	__u32 len;         /* 1, 2, 4, or 8 bytes; or 0 to ignore length */
+	__s32 fd;
+	__u32 flags;
+	__u8  pad[36];
+};
+
+#define GZVM_IOEVENTFD             _IOW(GZVM_IOC_MAGIC,  0x79, \
+					struct gzvm_ioeventfd)
+
 enum gzvm_device_type {
 	GZVM_DEV_TYPE_ARM_VGIC_V3_DIST,
 	GZVM_DEV_TYPE_ARM_VGIC_V3_REDIST,
-- 
2.18.0

