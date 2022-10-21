Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC33607D71
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJURYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJURYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:24:16 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7142F3AF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:24:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bv10so6064383wrb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUDQoD3HFruzS+T2pXmbko4NFchZqtcIPSOZUX4d550=;
        b=ITMQlOUOpKIaUb753f69rhurvrbbWWrVSvFktbbmPh7tmWLRF3eR/90Ui4xQ3sf6lg
         T3UjNTi4gbpv3zs0ziHMJJeyBWb9EX3bXKB51VtEwdWQDA21roxTplZ1zU5VylENRoGv
         WXiq7x9aKTkqpEvuhsK82qZb0LuoD0/ge38Sm1QQd4hX7zYe7oShFlwyjTGEP07ZAaiK
         /n5U6w2CZ7/qShG4kFFFTgiBGK+2BRJfn94qsmg84ASr97i1cuY+0llqZmRwQ+skjjfk
         bIZGPME2oS53l46ziNYQ8BsuWyX9mzAALAb2X99LkS0ku++bKL0cZptXG+deegNOQWr6
         oXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUDQoD3HFruzS+T2pXmbko4NFchZqtcIPSOZUX4d550=;
        b=5/iwSAYtTm6vVYn5NzFYFsJmf88qgYfqmMFDIQRp3onuXVaKXgN4dUHfgORH/W+bbB
         /85MtXK6IGC3diTP5sDeIICSftt8bGjzzqecT9D/jDtLhw8QMKJKGfbwIT9JMVo2xX0e
         cShawVgt8tgwY/U2EAI+0jkBZfIZWXqReeuN+HYya6f17DgM3I+GfmeOvDo9f1AeO0/B
         lNCKctESGmyvBNtO6rWqWn4RSIUFlrg4QifhwL2fSacX3keh5/vQjUcPRdTTbKeLt7NF
         UH0A6Y3XqOvEOp0Jbzaf5/5SZ4E3F4uYYzT93PRSjOcNbd7hMRT9DBskcNVdIdMR6M5h
         NaJg==
X-Gm-Message-State: ACrzQf1uMmqwWuD9zW2yJS16Q+ip2l2GooAV5ZBTxinJbf+7ScAjZgyS
        rnN1flDyE9WWStMAsRAqWgXgWMrPI5E=
X-Google-Smtp-Source: AMsMyM7cpK0FOcQrHC09rUmFCtFtUK6wzLIOLlA1V3/FyhaQt9J57gGebYe6YylFQ+DmvNp+rMG5eg==
X-Received: by 2002:adf:cf06:0:b0:236:4c12:47a7 with SMTP id o6-20020adfcf06000000b002364c1247a7mr4878514wrj.543.1666373052898;
        Fri, 21 Oct 2022 10:24:12 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6e82000000b0022ccae2fa62sm19434778wrz.22.2022.10.21.10.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 10:24:12 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>
Subject: [PATCH V3] xen/virtio: Handle PCI devices which Host controller is described in DT
Date:   Fri, 21 Oct 2022 20:24:08 +0300
Message-Id: <20221021172408.77397-1-olekstysh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Use the same "xen-grant-dma" device concept for the PCI devices
behind device-tree based PCI Host controller, but with one modification.
Unlike for platform devices, we cannot use generic IOMMU bindings
(iommus property), as we need to support more flexible configuration.
The problem is that PCI devices under the single PCI Host controller
may have the backends running in different Xen domains and thus have
different endpoints ID (backend domains ID).

Add ability to deal with generic PCI-IOMMU bindings (iommu-map/
iommu-map-mask properties) which allows us to describe relationship
between PCI devices and backend domains ID properly.

To avoid having to look up for the PCI Host bridge twice and reduce
the amount of checks pass an extra struct device_node *np to both
xen_dt_grant_init_backend_domid() and xen_is_dt_grant_dma_device().
While at it also pass domid_t *backend_domid instead of
struct xen_grant_dma_data *data to the former.

So with current patch the code expects iommus property for the platform
devices and iommu-map/iommu-map-mask properties for PCI devices.

The example of generated by the toolstack iommu-map property
for two PCI devices 0000:00:01.0 and 0000:00:02.0 whose
backends are running in different Xen domains with IDs 1 and 2
respectively:
iommu-map = <0x08 0xfde9 0x01 0x08 0x10 0xfde9 0x02 0x08>;

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
Slightly RFC. This is needed to support Xen grant mappings for virtio-pci devices
on Arm at some point in the future. The Xen toolstack side is not completely ready yet.
Here, for PCI devices we use more flexible way to pass backend domid to the guest
than for platform devices.

Changes V1 -> V2:
   - update commit description
   - rebase
   - rework to use generic PCI-IOMMU bindings instead of generic IOMMU bindings

Changes V2 -> V3:
   - update commit description, add an example
   - drop xen_dt_map_id() and squash xen_dt_get_pci_host_node() with
     xen_dt_get_node()
   - pass struct device_node *np to xen_is_dt_grant_dma_device() and
     xen_dt_grant_init_backend_domid()
   - pass domid_t *backend_domid instead of struct xen_grant_dma_data *data
     to xen_dt_grant_init_backend_domid()

Previous discussion is at:
https://lore.kernel.org/xen-devel/20221006174804.2003029-1-olekstysh@gmail.com/
https://lore.kernel.org/xen-devel/20221015153409.918775-1-olekstysh@gmail.com/

Based on:
https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git/log/?h=for-linus-6.1
---
 drivers/xen/grant-dma-ops.c | 80 ++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 14 deletions(-)

diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index daa525df7bdc..76b29d20aeee 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/dma-map-ops.h>
 #include <linux/of.h>
+#include <linux/pci.h>
 #include <linux/pfn.h>
 #include <linux/xarray.h>
 #include <linux/virtio_anchor.h>
@@ -292,12 +293,37 @@ static const struct dma_map_ops xen_grant_dma_ops = {
 	.dma_supported = xen_grant_dma_supported,
 };
 
-static bool xen_is_dt_grant_dma_device(struct device *dev)
+static struct device_node *xen_dt_get_node(struct device *dev)
 {
-	struct device_node *iommu_np;
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		struct pci_bus *bus = pdev->bus;
+
+		/* Walk up to the root bus to look for PCI Host controller */
+		while (!pci_is_root_bus(bus))
+			bus = bus->parent;
+
+		return of_node_get(bus->bridge->parent->of_node);
+	}
+
+	return of_node_get(dev->of_node);
+}
+
+static bool xen_is_dt_grant_dma_device(struct device *dev,
+					struct device_node *np)
+{
+	struct device_node *iommu_np = NULL;
 	bool has_iommu;
 
-	iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
+
+		if (of_map_id(np, rid, "iommu-map", "iommu-map-mask", &iommu_np, NULL))
+			return false;
+	} else
+		iommu_np = of_parse_phandle(np, "iommus", 0);
+
 	has_iommu = iommu_np &&
 		    of_device_is_compatible(iommu_np, "xen,grant-dma");
 	of_node_put(iommu_np);
@@ -307,9 +333,17 @@ static bool xen_is_dt_grant_dma_device(struct device *dev)
 
 bool xen_is_grant_dma_device(struct device *dev)
 {
+	struct device_node *np;
+
 	/* XXX Handle only DT devices for now */
-	if (dev->of_node)
-		return xen_is_dt_grant_dma_device(dev);
+	np = xen_dt_get_node(dev);
+	if (np) {
+		bool ret;
+
+		ret = xen_is_dt_grant_dma_device(dev, np);
+		of_node_put(np);
+		return ret;
+	}
 
 	return false;
 }
@@ -323,14 +357,26 @@ bool xen_virtio_mem_acc(struct virtio_device *dev)
 }
 
 static int xen_dt_grant_init_backend_domid(struct device *dev,
-					   struct xen_grant_dma_data *data)
+					   struct device_node *np,
+					   domid_t *backend_domid)
 {
-	struct of_phandle_args iommu_spec;
+	struct of_phandle_args iommu_spec = { .args_count = 1 };
 
-	if (of_parse_phandle_with_args(dev->of_node, "iommus", "#iommu-cells",
-			0, &iommu_spec)) {
-		dev_err(dev, "Cannot parse iommus property\n");
-		return -ESRCH;
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
+
+		if (of_map_id(np, rid, "iommu-map", "iommu-map-mask", &iommu_spec.np,
+				iommu_spec.args)) {
+			dev_err(dev, "Cannot translate ID\n");
+			return -ESRCH;
+		}
+	} else {
+		if (of_parse_phandle_with_args(np, "iommus", "#iommu-cells",
+				0, &iommu_spec)) {
+			dev_err(dev, "Cannot parse iommus property\n");
+			return -ESRCH;
+		}
 	}
 
 	if (!of_device_is_compatible(iommu_spec.np, "xen,grant-dma") ||
@@ -346,7 +392,7 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
 	 * The endpoint ID here means the ID of the domain where the
 	 * corresponding backend is running
 	 */
-	data->backend_domid = iommu_spec.args[0];
+	*backend_domid = iommu_spec.args[0];
 
 	return 0;
 }
@@ -354,6 +400,7 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
 void xen_grant_setup_dma_ops(struct device *dev)
 {
 	struct xen_grant_dma_data *data;
+	struct device_node *np;
 
 	data = find_xen_grant_dma_data(dev);
 	if (data) {
@@ -365,8 +412,13 @@ void xen_grant_setup_dma_ops(struct device *dev)
 	if (!data)
 		goto err;
 
-	if (dev->of_node) {
-		if (xen_dt_grant_init_backend_domid(dev, data))
+	np = xen_dt_get_node(dev);
+	if (np) {
+		int ret;
+
+		ret = xen_dt_grant_init_backend_domid(dev, np, &data->backend_domid);
+		of_node_put(np);
+		if (ret)
 			goto err;
 	} else if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT)) {
 		dev_info(dev, "Using dom0 as backend\n");
-- 
2.25.1

