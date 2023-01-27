Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0A567E847
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjA0Oaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjA0Oah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:30:37 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24548FF0E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674829835;
  x=1706365835;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=RL1TVR8JpwDGXzhk2Xp/sjq8b+rwzvFYVEYMjlPcCWk=;
  b=MvvpGXs7wDRDCxf5t1CPJbD0jSxY3jdzdAZO9frq+TXILOn6yR1Mb3Dr
   ChsM+EMLPuB3a7HrDbmp/p+DOE6zwy7+ppOtpXyevgIuy3X817LjfHJvH
   b/Oc/zd/t/p8X60cZqGerf1SGVZBy/5IBVNO1y6nuNceRtcI4BX+9AUhc
   auSTsp8lwZ07yhJITRuPVM+ylFt1TH9QTv9AlHvW0HaIknwVZGGtD1rms
   AFQt7VqxlYdQ5zQrJ//C6PQSjr6ZgRKM9H2XoCOJ2y+WVVTIGlSfSsVIL
   9WgSuHc8xi88TfqmtLB8XRwHlUMyhyGk1Q2t0BfbjzB2xVA6m5vPC39yx
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Fri, 27 Jan 2023 15:30:27 +0100
Subject: [PATCH] virt-pci: add platform bus support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230127-uml-pci-platform-v1-1-ec6b45d2829f@axis.com>
X-B4-Tracking: v=1; b=H4sIAALg02MC/x2NQQqDMBAAvyJ77kKSIkq/UnrYxE1dMDFsbCmIf
 zf2OAPD7FBZhSs8uh2Uv1JlzQ3srYMwU34zytQYnHF3Y92An7RgCYJloS2umpDj2FtPQx9HAy3
 zVBm9Ug7zFW6pXLYoR/n9R8/XcZyN11SoeAAAAA==
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     <robh@kernel.org>, <devicetree@lists.infradead.org>,
        <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver registers PCI busses, but the underlying virtio protocol
could just as easily be used to provide a platform bus instead.  If the
virtio device node in the devicetree indicates that it's compatible with
simple-bus, register platform devices instead of handling it as a PCI
bus.

Only one platform bus is allowed and the logic MMIO region for the
platform bus is placed at an arbitrarily-chosen address away from the
PCI region.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
My first approach to getting platform drivers working on UML was by
adding a minimal PCI-to-platform bridge driver, which worked without
modifications to virt-pci, but that got shot down:

 https://lore.kernel.org/lkml/20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com/
---
 arch/um/drivers/virt-pci.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 3ac220dafec4..0ff69d6ad253 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -8,6 +8,7 @@
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/logic_iomem.h>
+#include <linux/of_platform.h>
 #include <linux/irqdomain.h>
 #include <linux/virtio_pcidev.h>
 #include <linux/virtio-uml.h>
@@ -39,6 +40,8 @@ struct um_pci_device {
 	unsigned long status;
 
 	int irq;
+
+	bool platform;
 };
 
 struct um_pci_device_reg {
@@ -48,6 +51,7 @@ struct um_pci_device_reg {
 
 static struct pci_host_bridge *bridge;
 static DEFINE_MUTEX(um_pci_mtx);
+static struct um_pci_device *um_pci_platform_device;
 static struct um_pci_device_reg um_pci_devices[MAX_DEVICES];
 static struct fwnode_handle *um_pci_fwnode;
 static struct irq_domain *um_pci_inner_domain;
@@ -480,6 +484,9 @@ static void um_pci_handle_irq_message(struct virtqueue *vq,
 	struct virtio_device *vdev = vq->vdev;
 	struct um_pci_device *dev = vdev->priv;
 
+	if (!dev->irq)
+		return;
+
 	/* we should properly chain interrupts, but on ARCH=um we don't care */
 
 	switch (msg->op) {
@@ -561,6 +568,55 @@ static int um_pci_init_vqs(struct um_pci_device *dev)
 	return 0;
 }
 
+static void __um_pci_virtio_platform_remove(struct virtio_device *vdev,
+					    struct um_pci_device *dev)
+{
+	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
+
+	mutex_lock(&um_pci_mtx);
+	um_pci_platform_device = NULL;
+	mutex_unlock(&um_pci_mtx);
+
+	kfree(dev);
+}
+
+static int um_pci_virtio_platform_probe(struct virtio_device *vdev,
+					struct um_pci_device *dev)
+{
+	int ret;
+
+	dev->platform = true;
+
+	mutex_lock(&um_pci_mtx);
+
+	if (um_pci_platform_device) {
+		mutex_unlock(&um_pci_mtx);
+		ret = -EBUSY;
+		goto out_free;
+	}
+
+	ret = um_pci_init_vqs(dev);
+	if (ret) {
+		mutex_unlock(&um_pci_mtx);
+		goto out_free;
+	}
+
+	um_pci_platform_device = dev;
+
+	mutex_unlock(&um_pci_mtx);
+
+	ret = of_platform_default_populate(vdev->dev.of_node, NULL, &vdev->dev);
+	if (ret)
+		__um_pci_virtio_platform_remove(vdev, dev);
+
+	return ret;
+
+out_free:
+	kfree(dev);
+	return ret;
+}
+
 static int um_pci_virtio_probe(struct virtio_device *vdev)
 {
 	struct um_pci_device *dev;
@@ -574,6 +630,9 @@ static int um_pci_virtio_probe(struct virtio_device *vdev)
 	dev->vdev = vdev;
 	vdev->priv = dev;
 
+	if (of_device_is_compatible(vdev->dev.of_node, "simple-bus"))
+		return um_pci_virtio_platform_probe(vdev, dev);
+
 	mutex_lock(&um_pci_mtx);
 	for (i = 0; i < MAX_DEVICES; i++) {
 		if (um_pci_devices[i].dev)
@@ -623,6 +682,12 @@ static void um_pci_virtio_remove(struct virtio_device *vdev)
 	struct um_pci_device *dev = vdev->priv;
 	int i;
 
+	if (dev->platform) {
+		of_platform_depopulate(&vdev->dev);
+		__um_pci_virtio_platform_remove(vdev, dev);
+		return;
+	}
+
         /* Stop all virtqueues */
         virtio_reset_device(vdev);
         vdev->config->del_vqs(vdev);
@@ -860,6 +925,30 @@ void *pci_root_bus_fwnode(struct pci_bus *bus)
 	return um_pci_fwnode;
 }
 
+static long um_pci_map_platform(unsigned long offset, size_t size,
+				const struct logic_iomem_ops **ops,
+				void **priv)
+{
+	if (!um_pci_platform_device)
+		return -ENOENT;
+
+	*ops = &um_pci_device_bar_ops;
+	*priv = &um_pci_platform_device->resptr[0];
+
+	return 0;
+}
+
+static const struct logic_iomem_region_ops um_pci_platform_ops = {
+	.map = um_pci_map_platform,
+};
+
+static struct resource virt_platform_resource = {
+	.name = "platform",
+	.start = 0x10000000,
+	.end = 0x1fffffff,
+	.flags = IORESOURCE_MEM,
+};
+
 static int __init um_pci_init(void)
 {
 	int err, i;
@@ -868,6 +957,8 @@ static int __init um_pci_init(void)
 				       &um_pci_cfgspace_ops));
 	WARN_ON(logic_iomem_add_region(&virt_iomem_resource,
 				       &um_pci_iomem_ops));
+	WARN_ON(logic_iomem_add_region(&virt_platform_resource,
+				       &um_pci_platform_ops));
 
 	if (WARN(CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID < 0,
 		 "No virtio device ID configured for PCI - no PCI support\n"))

---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230127-uml-pci-platform-ef851ba75f80

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

