Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F6E6CCB45
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjC1UQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjC1UQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:16:15 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5C53C24;
        Tue, 28 Mar 2023 13:16:13 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-17aceccdcf6so14004930fac.9;
        Tue, 28 Mar 2023 13:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680034573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WffwCkUrO2QFOwkwd1OwIoPn40+WgwuocFCo25EFRP4=;
        b=nbWDwYydzmyTk6g98A46iCswmTD7o+2WfWVj2CH3Ct2GuwSPliyarfl+1DOmoX7z+5
         2eZMtVOjJ3sAPz1KgYZclBlx/AtAh/W3UE4+VbZClc9aQAQtpb54ncfAfqB6w49ceAaN
         iXWydSvyUox/FnlQX1b0zN8PzPU888dbQZ6ZbiWWuLY8V5vGy6ema/ks51BADeRB+zvm
         A/br8gvjFvA6OEY43EoPcPQSmnNPkbOSsJqARUocCYs3f2Cxr19MS4t28QCpz3AIv70H
         yFckoUA92LCj3M5Vqa47zcPSPKXxuSHcLv6uWFIw1BA4XS2fP6H1OnZ3gae/3VrQzRDN
         qLVw==
X-Gm-Message-State: AAQBX9fMsDFaOGHyc9j2Pb7ceGJMaT8n/o5vD4z2hrrb54NuTDyAqo1K
        5d7lVf51+Aa5Ja9EhuiQCQ==
X-Google-Smtp-Source: AK7set9O95zUO5XPRjY3del1fKAHhbZzd1ayFyAZFIuT0LhS8F1687vY4wmshaSQMXVNhTAnL+nVzg==
X-Received: by 2002:a05:6870:e40d:b0:169:dcba:1ec9 with SMTP id n13-20020a056870e40d00b00169dcba1ec9mr11894631oag.41.1680034573156;
        Tue, 28 Mar 2023 13:16:13 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m9-20020a9d6ac9000000b0069f153bb37asm8467384otq.62.2023.03.28.13.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 13:16:12 -0700 (PDT)
Received: (nullmailer pid 3993719 invoked by uid 1000);
        Tue, 28 Mar 2023 20:16:10 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 28 Mar 2023 15:15:57 -0500
Subject: [PATCH 2/5] of/address: Add of_range_to_resource() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-dt-address-helpers-v1-2-e2456c3e77ab@kernel.org>
References: <20230328-dt-address-helpers-v1-0-e2456c3e77ab@kernel.org>
In-Reply-To: <20230328-dt-address-helpers-v1-0-e2456c3e77ab@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few users need to convert a specific "ranges" entry into a struct
resource. Add a helper to similar to of_address_to_resource(). The
existing of_pci_range_to_resource() helper isn't really PCI specific,
so it can be used with the CONFIG_PCI check dropped.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c       | 31 ++++++++++++++++++++++++++++---
 drivers/of/unittest.c      | 16 +++++++++++++++-
 include/linux/of_address.h |  8 ++++++++
 3 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 4c0b169ef9bf..b79f005834fc 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -229,9 +229,6 @@ int of_pci_range_to_resource(struct of_pci_range *range,
 	res->parent = res->child = res->sibling = NULL;
 	res->name = np->full_name;
 
-	if (!IS_ENABLED(CONFIG_PCI))
-		return -ENOSYS;
-
 	if (res->flags & IORESOURCE_IO) {
 		unsigned long port;
 		err = pci_register_io_range(&np->fwnode, range->cpu_addr,
@@ -263,6 +260,34 @@ int of_pci_range_to_resource(struct of_pci_range *range,
 }
 EXPORT_SYMBOL(of_pci_range_to_resource);
 
+/*
+ * of_range_to_resource - Create a resource from a ranges entry
+ * @np:		device node where the range belongs to
+ * @index:	the 'ranges' index to convert to a resource
+ * @res:	pointer to a valid resource that will be updated to
+ *              reflect the values contained in the range.
+ *
+ * Returns ENOENT if the entry is not found or EINVAL if the range cannot be
+ * converted to resource.
+ */
+int of_range_to_resource(struct device_node *np, int index, struct resource *res)
+{
+	int ret, i = 0;
+	struct of_range_parser parser;
+	struct of_range range;
+
+	ret = of_range_parser_init(&parser, np);
+	if (ret)
+		return ret;
+
+	for_each_of_range(&parser, &range)
+		if (i++ == index)
+			return of_pci_range_to_resource(&range, np, res);
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL(of_range_to_resource);
+
 /*
  * ISA bus specific translator
  */
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 1a45df1f354a..945288d5672f 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1013,7 +1013,8 @@ static void __init of_unittest_bus_ranges(void)
 	struct device_node *np;
 	struct of_range range;
 	struct of_range_parser parser;
-	int i = 0;
+	struct resource res;
+	int ret, i = 0;
 
 	np = of_find_node_by_path("/testcase-data/address-tests");
 	if (!np) {
@@ -1026,6 +1027,19 @@ static void __init of_unittest_bus_ranges(void)
 		return;
 	}
 
+	ret = of_range_to_resource(np, 1, &res);
+	unittest(!ret, "of_range_to_resource returned error (%d) node %pOF\n",
+		ret, np);
+	unittest(resource_type(&res) == IORESOURCE_MEM,
+		"of_range_to_resource wrong resource type on node %pOF res=%pR\n",
+		np, &res);
+	unittest(res.start == 0xd0000000,
+		"of_range_to_resource wrong resource start address on node %pOF res=%pR\n",
+		np, &res);
+	unittest(resource_size(&res) == 0x20000000,
+		"of_range_to_resource wrong resource start address on node %pOF res=%pR\n",
+		np, &res);
+
 	/*
 	 * Get the "ranges" from the device tree
 	 */
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 376671594746..1d005439f026 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -68,6 +68,8 @@ extern int of_pci_address_to_resource(struct device_node *dev, int bar,
 extern int of_pci_range_to_resource(struct of_pci_range *range,
 				    struct device_node *np,
 				    struct resource *res);
+extern int of_range_to_resource(struct device_node *np, int index,
+				struct resource *res);
 extern bool of_dma_is_coherent(struct device_node *np);
 #else /* CONFIG_OF_ADDRESS */
 static inline void __iomem *of_io_request_and_map(struct device_node *device,
@@ -120,6 +122,12 @@ static inline int of_pci_range_to_resource(struct of_pci_range *range,
 	return -ENOSYS;
 }
 
+static inline int of_range_to_resource(struct device_node *np, int index,
+				       struct resource *res)
+{
+	return -ENOSYS;
+}
+
 static inline bool of_dma_is_coherent(struct device_node *np)
 {
 	return false;

-- 
2.39.2

