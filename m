Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604715FFB0B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJOPfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJOPfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:35:01 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8441EECB
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:34:41 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a6so9244114ljq.5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ihOcqD/n8ZbX79lkXyTkddNqF22IgCuKxZEVGwB7Rsg=;
        b=WxtdSw3RVuokIk3VH0NlorLEv9hGbzMu1BXjJPFPg6tTUBAUACrJhaEons33ymTpay
         fsFTwfQbxQXLaSloPF8amM8JbNWOvBoQDVDLQP4T3JaPpsQauZT0geTwDcC7UyPymBz8
         jnssWruJPe8g8dSeLpOrsbUEq2F3+WhotoQAeYxn0ytN33tQlg/cXg0w2K8+0o7dJ1lQ
         Fw9775uiwSMOsdy4oI1MLmDmKbuLHlD4bukfDsQASTZnmUa4nWgMHliZqbE9lx5bNeLn
         A/CtiP/rcDTETgtCh/oXjOsYxKX/0caViUXXDHU/1f9YJjOsTyTeiIU09NDlUTGoeKfL
         QZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihOcqD/n8ZbX79lkXyTkddNqF22IgCuKxZEVGwB7Rsg=;
        b=tu12Z6DTspMaluQLMQEnh6m0jZNv/cNWSC1m2j0w8VK6ZrmnkhEZuiV66PtAbv5Aw7
         SXvyYJqGzS0lKCuwr14lCDzwOuTQNH7rT8UJ7zteSHLpJZD4XKT1UORb8S49iRMpo0OD
         rODKltJ6RIzLChwg+Fbsab1wdrztEmlgeGZs/dPJUfVMR4tdx/by1PrzgVQEx5e5MwrV
         ueV9nGdb/UlKoxO8pQRDasoYkJLk7XFRtgafTU9Q0FqIqpHoOfjIiA7dq9PRVwgwEm4T
         5BhR9N7fCPuWrWuIvC72NWD25ClHp6SJF9wYTIXSaqNZirUIJyC/9P5AGkyPmLMq6NYq
         cHYw==
X-Gm-Message-State: ACrzQf0wdt2Z+JDRfCxSYnTpPuP/P98U6t3QyDfdxsvDXhfHNJrv/mov
        0njics6RplxWkiqdGnRAmISv+R2OfjV5sw==
X-Google-Smtp-Source: AMsMyM4cTx61Y6kV/OX5Wcl7kFX+mFhoVOm1PT3Oovb9gJ2D7Wkm7T2AtGUh6I1wmhv3Ee7UT1Dz3w==
X-Received: by 2002:a05:651c:158f:b0:26b:dd9c:dca5 with SMTP id h15-20020a05651c158f00b0026bdd9cdca5mr1153297ljq.400.1665848078845;
        Sat, 15 Oct 2022 08:34:38 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id i11-20020a0565123e0b00b00497a3e2a191sm773548lfv.112.2022.10.15.08.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 08:34:38 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH V2] xen/virtio: Handle PCI devices which Host controller is described in DT
Date:   Sat, 15 Oct 2022 18:34:09 +0300
Message-Id: <20221015153409.918775-1-olekstysh@gmail.com>
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

So use generic PCI-IOMMU bindings instead (iommu-map/iommu-map-mask
properties) which allows us to describe relationship between PCI
devices and backend domains ID properly.

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

Previous discussion is at:
https://lore.kernel.org/xen-devel/20221006174804.2003029-1-olekstysh@gmail.com/

Based on:
https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git/log/?h=for-linus-6.1
---
 drivers/xen/grant-dma-ops.c | 87 ++++++++++++++++++++++++++++++++-----
 1 file changed, 76 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index daa525df7bdc..b79d9d6ce154 100644
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
@@ -292,12 +293,55 @@ static const struct dma_map_ops xen_grant_dma_ops = {
 	.dma_supported = xen_grant_dma_supported,
 };
 
+static struct device_node *xen_dt_get_pci_host_node(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_bus *bus = pdev->bus;
+
+	/* Walk up to the root bus to look for PCI Host controller */
+	while (!pci_is_root_bus(bus))
+		bus = bus->parent;
+
+	return of_node_get(bus->bridge->parent->of_node);
+}
+
+static struct device_node *xen_dt_get_node(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return xen_dt_get_pci_host_node(dev);
+
+	return of_node_get(dev->of_node);
+}
+
+static int xen_dt_map_id(struct device *dev, struct device_node **iommu_np,
+			 u32 *sid)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
+	struct device_node *host_np;
+	int ret;
+
+	host_np = xen_dt_get_pci_host_node(dev);
+	if (!host_np)
+		return -ENODEV;
+
+	ret = of_map_id(host_np, rid, "iommu-map", "iommu-map-mask", iommu_np, sid);
+	of_node_put(host_np);
+
+	return ret;
+}
+
 static bool xen_is_dt_grant_dma_device(struct device *dev)
 {
-	struct device_node *iommu_np;
+	struct device_node *iommu_np = NULL;
 	bool has_iommu;
 
-	iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
+	if (dev_is_pci(dev)) {
+		if (xen_dt_map_id(dev, &iommu_np, NULL))
+			return false;
+	} else
+		iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
+
 	has_iommu = iommu_np &&
 		    of_device_is_compatible(iommu_np, "xen,grant-dma");
 	of_node_put(iommu_np);
@@ -307,9 +351,17 @@ static bool xen_is_dt_grant_dma_device(struct device *dev)
 
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
+		ret = xen_is_dt_grant_dma_device(dev);
+		of_node_put(np);
+		return ret;
+	}
 
 	return false;
 }
@@ -325,12 +377,19 @@ bool xen_virtio_mem_acc(struct virtio_device *dev)
 static int xen_dt_grant_init_backend_domid(struct device *dev,
 					   struct xen_grant_dma_data *data)
 {
-	struct of_phandle_args iommu_spec;
+	struct of_phandle_args iommu_spec = { .args_count = 1 };
 
-	if (of_parse_phandle_with_args(dev->of_node, "iommus", "#iommu-cells",
-			0, &iommu_spec)) {
-		dev_err(dev, "Cannot parse iommus property\n");
-		return -ESRCH;
+	if (dev_is_pci(dev)) {
+		if (xen_dt_map_id(dev, &iommu_spec.np, iommu_spec.args)) {
+			dev_err(dev, "Cannot translate ID\n");
+			return -ESRCH;
+		}
+	} else {
+		if (of_parse_phandle_with_args(dev->of_node, "iommus", "#iommu-cells",
+				0, &iommu_spec)) {
+			dev_err(dev, "Cannot parse iommus property\n");
+			return -ESRCH;
+		}
 	}
 
 	if (!of_device_is_compatible(iommu_spec.np, "xen,grant-dma") ||
@@ -354,6 +413,7 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
 void xen_grant_setup_dma_ops(struct device *dev)
 {
 	struct xen_grant_dma_data *data;
+	struct device_node *np;
 
 	data = find_xen_grant_dma_data(dev);
 	if (data) {
@@ -365,8 +425,13 @@ void xen_grant_setup_dma_ops(struct device *dev)
 	if (!data)
 		goto err;
 
-	if (dev->of_node) {
-		if (xen_dt_grant_init_backend_domid(dev, data))
+	np = xen_dt_get_node(dev);
+	if (np) {
+		int ret;
+
+		ret = xen_dt_grant_init_backend_domid(dev, data);
+		of_node_put(np);
+		if (ret)
 			goto err;
 	} else if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT)) {
 		dev_info(dev, "Using dom0 as backend\n");
-- 
2.25.1

