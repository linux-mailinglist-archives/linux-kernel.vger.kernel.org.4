Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F70E60D182
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiJYQUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiJYQUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:20:16 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1686A80F77
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:20:14 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id o4so12808760ljp.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPiIK7IlsJ7E5VINPN3ej70LIynHg49PxYxMULv6O+g=;
        b=Mcz2WFP8uCN+2nT+Y2LCXeXAkKPmjH58QmfnmrZDOcN5K+WTU1Mcmjc/sFiQ90Bg/t
         iXNEQCCA+E/XCB83vWVHG0V6MPAib92POhRWkYfk5ka1gkSSEt+bQpjEWq/8lbYkIU47
         Qs6eTgoLMfjLQlEgA0MhoYBOoKGLl1E/5LpfAyhxMTJBUIZSjejfGvCjir8IMkmKJ0Kp
         hMc/y55iOxg9vqAcs2CTMCZNI+Vxr0Pwzx00U42fhwCvw8zAFp4qDdkLj+YdFzQCuhQp
         mbrxa+MAlZEHS/+kprmjC+KVPUcTjOvZTzB2rAWsHtjgStKg5yumkz3HxKOEOf2ahil3
         Yy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPiIK7IlsJ7E5VINPN3ej70LIynHg49PxYxMULv6O+g=;
        b=qldfRPAfU6mognP68yYx16MRIoiPXdvt7BOUd+IrVBkOECqsYZWed9CB8+Eln8Is+x
         iICsL3ZC/5WJHRmzo8GZOCj6UTpVvod1VPefJFqsTU1h/t+FI5uGzkayzyEbOnGD9sNr
         c8dpNQVb3NePPnEnwkLveY/2zBj9KJ5qd3Q6PM6OD5SoCss8hV7wkaNrlPjlG90xfsPj
         yS9LMaiHxRcniTt2EazVbJYsOyyffFKmcxaAnVuU4rjSF7yJlu7BxVR08lLxFORv7M2F
         SSn18qn5jlhx02pTdGi39buFMkuxzjJjNc58uSKj05QPHBxlvS++qWZj8OcPkDnm6zAN
         77Wg==
X-Gm-Message-State: ACrzQf39EX8yRO0IOKIXuYY/boCqJBKdfiFYvMU5VULoZnkcHKiL3Isv
        zUU/UmDJPfGTyglYg9XiNkc=
X-Google-Smtp-Source: AMsMyM62fltFfmb8eUA4lFmsFonT3s3D9baIIhB+ZUg06Ktu/2pzGx7vkhjbjBeMjDCfkQWNML2TEg==
X-Received: by 2002:a05:651c:33c:b0:277:e2b:de4a with SMTP id b28-20020a05651c033c00b002770e2bde4amr3738346ljp.55.1666714812379;
        Tue, 25 Oct 2022 09:20:12 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id a16-20020a2eb550000000b002770302bdffsm540136ljn.105.2022.10.25.09.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 09:20:11 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>
Subject: [PATCH V4 2/2] xen/virtio: Handle PCI devices which Host controller is described in DT
Date:   Tue, 25 Oct 2022 19:20:04 +0300
Message-Id: <20221025162004.8501-3-olekstysh@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025162004.8501-1-olekstysh@gmail.com>
References: <20221025162004.8501-1-olekstysh@gmail.com>
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
the amount of checks pass an extra struct device_node *np to
xen_dt_grant_init_backend_domid().

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

Changes V3 -> V4:
   - just rebase on new prereq patch
     "xen/virtio: Optimize the setup of "xen-grant-dma" devices"

Previous discussion is at:
https://lore.kernel.org/xen-devel/20221006174804.2003029-1-olekstysh@gmail.com/
https://lore.kernel.org/xen-devel/20221015153409.918775-1-olekstysh@gmail.com/
https://lore.kernel.org/xen-devel/20221021172408.77397-1-olekstysh@gmail.com/

Based on:
https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git/log/?h=for-linus-6.1
---
---
 drivers/xen/grant-dma-ops.c | 46 +++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index 1e797a043980..9784a77fa3c9 100644
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
@@ -292,15 +293,43 @@ static const struct dma_map_ops xen_grant_dma_ops = {
 	.dma_supported = xen_grant_dma_supported,
 };
 
+static struct device_node *xen_dt_get_node(struct device *dev)
+{
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
 static int xen_dt_grant_init_backend_domid(struct device *dev,
+					   struct device_node *np,
 					   domid_t *backend_domid)
 {
-	struct of_phandle_args iommu_spec;
+	struct of_phandle_args iommu_spec = { .args_count = 1 };
 
-	if (of_parse_phandle_with_args(dev->of_node, "iommus", "#iommu-cells",
-			0, &iommu_spec)) {
-		dev_dbg(dev, "Cannot parse iommus property\n");
-		return -ESRCH;
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
+
+		if (of_map_id(np, rid, "iommu-map", "iommu-map-mask", &iommu_spec.np,
+				iommu_spec.args)) {
+			dev_dbg(dev, "Cannot translate ID\n");
+			return -ESRCH;
+		}
+	} else {
+		if (of_parse_phandle_with_args(np, "iommus", "#iommu-cells",
+				0, &iommu_spec)) {
+			dev_dbg(dev, "Cannot parse iommus property\n");
+			return -ESRCH;
+		}
 	}
 
 	if (!of_device_is_compatible(iommu_spec.np, "xen,grant-dma") ||
@@ -324,10 +353,13 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
 static int xen_grant_init_backend_domid(struct device *dev,
 					domid_t *backend_domid)
 {
+	struct device_node *np;
 	int ret = -ENODEV;
 
-	if (dev->of_node) {
-		ret = xen_dt_grant_init_backend_domid(dev, backend_domid);
+	np = xen_dt_get_node(dev);
+	if (np) {
+		ret = xen_dt_grant_init_backend_domid(dev, np, backend_domid);
+		of_node_put(np);
 	} else if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT) || xen_pv_domain()) {
 		dev_info(dev, "Using dom0 as backend\n");
 		*backend_domid = 0;
-- 
2.25.1

