Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5EA6D1911
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjCaHxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjCaHxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:53:13 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42915191C1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:52:38 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by laurent.telenet-ops.be with bizsmtp
        id evsc290061C8whw01vsci5; Fri, 31 Mar 2023 09:52:36 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pi9Y6-00FTC2-IG;
        Fri, 31 Mar 2023 09:52:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pi9Yp-008Ra7-U0;
        Fri, 31 Mar 2023 09:52:35 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] of: address: Reshuffle to remove forward declarations
Date:   Fri, 31 Mar 2023 09:52:30 +0200
Message-Id: <b8701c04d27e51618444a747c4f4be5cc889ce28.1680248888.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1680248888.git.geert+renesas@glider.be>
References: <cover.1680248888.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reshuffle the code to get rid of the forward declarations, which
improves readability.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/of/address.c | 271 +++++++++++++++++++++----------------------
 1 file changed, 133 insertions(+), 138 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index bd965d104c83a1ac..80b36dfdb69c24c8 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -24,11 +24,6 @@
 #define OF_CHECK_ADDR_COUNT(na)	((na) > 0 && (na) <= OF_MAX_ADDR_CELLS)
 #define OF_CHECK_COUNTS(na, ns)	(OF_CHECK_ADDR_COUNT(na) && (ns) > 0)
 
-static struct of_bus *of_match_bus(struct device_node *np);
-static int __of_address_to_resource(struct device_node *dev, int index,
-		int bar_no, struct resource *r);
-static bool of_mmio_is_nonposted(struct device_node *np);
-
 /* Debug utility */
 #ifdef DEBUG
 static void of_dump_addr(const char *s, const __be32 *addr, int na)
@@ -198,17 +193,6 @@ static int of_bus_pci_translate(__be32 *addr, u64 offset, int na)
 }
 #endif /* CONFIG_PCI */
 
-int of_pci_address_to_resource(struct device_node *dev, int bar,
-			       struct resource *r)
-{
-
-	if (!IS_ENABLED(CONFIG_PCI))
-		return -ENOSYS;
-
-	return __of_address_to_resource(dev, -1, bar, r);
-}
-EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
-
 /*
  * of_pci_range_to_resource - Create a resource from an of_pci_range
  * @range:	the PCI range that describes the resource
@@ -837,128 +821,6 @@ static u64 of_translate_ioport(struct device_node *dev, const __be32 *in_addr,
 	return port;
 }
 
-static int __of_address_to_resource(struct device_node *dev, int index, int bar_no,
-		struct resource *r)
-{
-	u64 taddr;
-	const __be32	*addrp;
-	u64		size;
-	unsigned int	flags;
-	const char	*name = NULL;
-
-	addrp = __of_get_address(dev, index, bar_no, &size, &flags);
-	if (addrp == NULL)
-		return -EINVAL;
-
-	/* Get optional "reg-names" property to add a name to a resource */
-	if (index >= 0)
-		of_property_read_string_index(dev, "reg-names",	index, &name);
-
-	if (flags & IORESOURCE_MEM)
-		taddr = of_translate_address(dev, addrp);
-	else if (flags & IORESOURCE_IO)
-		taddr = of_translate_ioport(dev, addrp, size);
-	else
-		return -EINVAL;
-
-	if (taddr == OF_BAD_ADDR)
-		return -EINVAL;
-	memset(r, 0, sizeof(struct resource));
-
-	if (of_mmio_is_nonposted(dev))
-		flags |= IORESOURCE_MEM_NONPOSTED;
-
-	r->start = taddr;
-	r->end = taddr + size - 1;
-	r->flags = flags;
-	r->name = name ? name : dev->full_name;
-
-	return 0;
-}
-
-/**
- * of_address_to_resource - Translate device tree address and return as resource
- * @dev:	Caller's Device Node
- * @index:	Index into the array
- * @r:		Pointer to resource array
- *
- * Returns -EINVAL if the range cannot be converted to resource.
- *
- * Note that if your address is a PIO address, the conversion will fail if
- * the physical address can't be internally converted to an IO token with
- * pci_address_to_pio(), that is because it's either called too early or it
- * can't be matched to any host bridge IO space
- */
-int of_address_to_resource(struct device_node *dev, int index,
-			   struct resource *r)
-{
-	return __of_address_to_resource(dev, index, -1, r);
-}
-EXPORT_SYMBOL_GPL(of_address_to_resource);
-
-/**
- * of_iomap - Maps the memory mapped IO for a given device_node
- * @np:		the device whose io range will be mapped
- * @index:	index of the io range
- *
- * Returns a pointer to the mapped memory
- */
-void __iomem *of_iomap(struct device_node *np, int index)
-{
-	struct resource res;
-
-	if (of_address_to_resource(np, index, &res))
-		return NULL;
-
-	if (res.flags & IORESOURCE_MEM_NONPOSTED)
-		return ioremap_np(res.start, resource_size(&res));
-	else
-		return ioremap(res.start, resource_size(&res));
-}
-EXPORT_SYMBOL(of_iomap);
-
-/*
- * of_io_request_and_map - Requests a resource and maps the memory mapped IO
- *			   for a given device_node
- * @device:	the device whose io range will be mapped
- * @index:	index of the io range
- * @name:	name "override" for the memory region request or NULL
- *
- * Returns a pointer to the requested and mapped memory or an ERR_PTR() encoded
- * error code on failure. Usage example:
- *
- *	base = of_io_request_and_map(node, 0, "foo");
- *	if (IS_ERR(base))
- *		return PTR_ERR(base);
- */
-void __iomem *of_io_request_and_map(struct device_node *np, int index,
-				    const char *name)
-{
-	struct resource res;
-	void __iomem *mem;
-
-	if (of_address_to_resource(np, index, &res))
-		return IOMEM_ERR_PTR(-EINVAL);
-
-	if (!name)
-		name = res.name;
-	if (!request_mem_region(res.start, resource_size(&res), name))
-		return IOMEM_ERR_PTR(-EBUSY);
-
-	if (res.flags & IORESOURCE_MEM_NONPOSTED)
-		mem = ioremap_np(res.start, resource_size(&res));
-	else
-		mem = ioremap(res.start, resource_size(&res));
-
-	if (!mem) {
-		release_mem_region(res.start, resource_size(&res));
-		return IOMEM_ERR_PTR(-ENOMEM);
-	}
-
-	return mem;
-}
-EXPORT_SYMBOL(of_io_request_and_map);
-
 #ifdef CONFIG_HAS_DMA
 /**
  * of_dma_get_range - Get DMA range info and put it into a map array
@@ -1155,3 +1017,136 @@ static bool of_mmio_is_nonposted(struct device_node *np)
 	of_node_put(parent);
 	return nonposted;
 }
+
+static int __of_address_to_resource(struct device_node *dev, int index, int bar_no,
+		struct resource *r)
+{
+	u64 taddr;
+	const __be32	*addrp;
+	u64		size;
+	unsigned int	flags;
+	const char	*name = NULL;
+
+	addrp = __of_get_address(dev, index, bar_no, &size, &flags);
+	if (addrp == NULL)
+		return -EINVAL;
+
+	/* Get optional "reg-names" property to add a name to a resource */
+	if (index >= 0)
+		of_property_read_string_index(dev, "reg-names",	index, &name);
+
+	if (flags & IORESOURCE_MEM)
+		taddr = of_translate_address(dev, addrp);
+	else if (flags & IORESOURCE_IO)
+		taddr = of_translate_ioport(dev, addrp, size);
+	else
+		return -EINVAL;
+
+	if (taddr == OF_BAD_ADDR)
+		return -EINVAL;
+	memset(r, 0, sizeof(struct resource));
+
+	if (of_mmio_is_nonposted(dev))
+		flags |= IORESOURCE_MEM_NONPOSTED;
+
+	r->start = taddr;
+	r->end = taddr + size - 1;
+	r->flags = flags;
+	r->name = name ? name : dev->full_name;
+
+	return 0;
+}
+
+/**
+ * of_address_to_resource - Translate device tree address and return as resource
+ * @dev:	Caller's Device Node
+ * @index:	Index into the array
+ * @r:		Pointer to resource array
+ *
+ * Returns -EINVAL if the range cannot be converted to resource.
+ *
+ * Note that if your address is a PIO address, the conversion will fail if
+ * the physical address can't be internally converted to an IO token with
+ * pci_address_to_pio(), that is because it's either called too early or it
+ * can't be matched to any host bridge IO space
+ */
+int of_address_to_resource(struct device_node *dev, int index,
+			   struct resource *r)
+{
+	return __of_address_to_resource(dev, index, -1, r);
+}
+EXPORT_SYMBOL_GPL(of_address_to_resource);
+
+int of_pci_address_to_resource(struct device_node *dev, int bar,
+			       struct resource *r)
+{
+
+	if (!IS_ENABLED(CONFIG_PCI))
+		return -ENOSYS;
+
+	return __of_address_to_resource(dev, -1, bar, r);
+}
+EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
+
+/**
+ * of_iomap - Maps the memory mapped IO for a given device_node
+ * @np:		the device whose io range will be mapped
+ * @index:	index of the io range
+ *
+ * Returns a pointer to the mapped memory
+ */
+void __iomem *of_iomap(struct device_node *np, int index)
+{
+	struct resource res;
+
+	if (of_address_to_resource(np, index, &res))
+		return NULL;
+
+	if (res.flags & IORESOURCE_MEM_NONPOSTED)
+		return ioremap_np(res.start, resource_size(&res));
+	else
+		return ioremap(res.start, resource_size(&res));
+}
+EXPORT_SYMBOL(of_iomap);
+
+/*
+ * of_io_request_and_map - Requests a resource and maps the memory mapped IO
+ *			   for a given device_node
+ * @device:	the device whose io range will be mapped
+ * @index:	index of the io range
+ * @name:	name "override" for the memory region request or NULL
+ *
+ * Returns a pointer to the requested and mapped memory or an ERR_PTR() encoded
+ * error code on failure. Usage example:
+ *
+ *	base = of_io_request_and_map(node, 0, "foo");
+ *	if (IS_ERR(base))
+ *		return PTR_ERR(base);
+ */
+void __iomem *of_io_request_and_map(struct device_node *np, int index,
+				    const char *name)
+{
+	struct resource res;
+	void __iomem *mem;
+
+	if (of_address_to_resource(np, index, &res))
+		return IOMEM_ERR_PTR(-EINVAL);
+
+	if (!name)
+		name = res.name;
+	if (!request_mem_region(res.start, resource_size(&res), name))
+		return IOMEM_ERR_PTR(-EBUSY);
+
+	if (res.flags & IORESOURCE_MEM_NONPOSTED)
+		mem = ioremap_np(res.start, resource_size(&res));
+	else
+		mem = ioremap(res.start, resource_size(&res));
+
+	if (!mem) {
+		release_mem_region(res.start, resource_size(&res));
+		return IOMEM_ERR_PTR(-ENOMEM);
+	}
+
+	return mem;
+}
+EXPORT_SYMBOL(of_io_request_and_map);
-- 
2.34.1

