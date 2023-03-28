Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5715E6CCB4D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjC1UQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjC1UQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:16:19 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F0E3A99;
        Tue, 28 Mar 2023 13:16:18 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-17683b570b8so13974530fac.13;
        Tue, 28 Mar 2023 13:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680034578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCPFOdIpNQUFJhPrmeiDu2DdLbGsab44HmyQyVjGzEY=;
        b=se0GTU860Zvce3ghTGwaZ6IXAGrmAY2/PGcFwDMpYU55m8AEFR9yUyZScojUD3TEa+
         rBzpX3wqMGCNsPPiTtKz6so1Pq/j6M9oxQv37PYqXnIVkjec0aQsU04312yp2t1iUq4h
         NrbuREUzYHB6li42IIIzjQGD1t2o+wyp1H6sKKvqOqkyM4v4wpH9mj7+dS0hJ9PjLbsQ
         UDWXynq9th0muNLH9YiZkYcJZVWTuU8H9SOI66O8KWJdQPVb67XpHYbHb2XDRGcXfq+e
         U26U4xE0VTu6TX6ULeffVXhGk2iqGsg8sJp16pSW+TcNviqqvU0jnimTvPdSMnH+Dacm
         vjug==
X-Gm-Message-State: AAQBX9c0h0UE6f83ZTMkHS0maIONVY8Y+sWOBz4lZNABMQDl5ufWCibe
        L2UzXc9q5TriOvFbXtJKKA==
X-Google-Smtp-Source: AK7set/9uPgN0yCrXLJT35rq7Qat3QtTAkbocxc8t5r/+YdjprY4iCDY11yfxUH4UdUAQpsUjhc5qg==
X-Received: by 2002:a05:6870:a454:b0:177:c8dc:501f with SMTP id n20-20020a056870a45400b00177c8dc501fmr12122129oal.29.1680034578097;
        Tue, 28 Mar 2023 13:16:18 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v23-20020a056870709700b0017280f7d653sm11129807oae.35.2023.03.28.13.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 13:16:17 -0700 (PDT)
Received: (nullmailer pid 3993737 invoked by uid 1000);
        Tue, 28 Mar 2023 20:16:10 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 28 Mar 2023 15:16:00 -0500
Subject: [PATCH 5/5] of/address: Add of_property_read_reg() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-dt-address-helpers-v1-5-e2456c3e77ab@kernel.org>
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

Add a helper, of_property_read_reg(), to read "reg" entries untranslated
address and size. This function is intended mainly for cases with an
untranslatable "reg" address (i.e. not MMIO). There's also a few
translatable cases such as address cells containing a bus chip-select
number.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c       | 23 +++++++++++++++++++++++
 drivers/of/unittest.c      | 22 ++++++++++++++++++++++
 include/linux/of_address.h |  7 +++++++
 3 files changed, 52 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 8cfae24148e0..fdb15c6fb3b1 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -760,6 +760,29 @@ const __be32 *__of_get_address(struct device_node *dev, int index, int bar_no,
 }
 EXPORT_SYMBOL(__of_get_address);
 
+/**
+ * of_property_read_reg - Retrieve the specified "reg" entry index without translating
+ * @np: device tree node for which to retrieve "reg" from
+ * @idx: "reg" entry index to read
+ * @addr: return value for the untranslated address
+ * @size: return value for the entry size
+ *
+ * Returns -EINVAL if "reg" is not found. Returns 0 on success with addr and
+ * size values filled in.
+ */
+int of_property_read_reg(struct device_node *np, int idx, u64 *addr, u64 *size)
+{
+	const __be32 *prop = of_get_address(np, idx, size, NULL);
+
+	if (!prop)
+		return -EINVAL;
+
+	*addr = of_read_number(prop, of_n_addr_cells(np));
+
+	return 0;
+}
+EXPORT_SYMBOL(of_property_read_reg);
+
 static int parser_init(struct of_pci_range_parser *parser,
 			struct device_node *node, const char *name)
 {
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index eaeb58065acc..e73ecbef977b 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1134,6 +1134,27 @@ static void __init of_unittest_bus_3cell_ranges(void)
 	of_node_put(np);
 }
 
+static void __init of_unittest_reg(void)
+{
+	struct device_node *np;
+	int ret;
+	u64 addr, size;
+
+	np = of_find_node_by_path("/testcase-data/address-tests/bus@80000000/device@1000");
+	if (!np) {
+		pr_err("missing testcase data\n");
+		return;
+	}
+
+	ret = of_property_read_reg(np, 0, &addr, &size);
+	unittest(!ret, "of_property_read_reg(%pOF) returned error %d\n",
+		np, ret);
+	unittest(addr == 0x1000, "of_property_read_reg(%pOF) untranslated address (%llx) incorrect\n",
+		np, addr);
+
+	of_node_put(np);
+}
+
 static void __init of_unittest_parse_interrupts(void)
 {
 	struct device_node *np;
@@ -3772,6 +3793,7 @@ static int __init of_unittest(void)
 	of_unittest_pci_dma_ranges();
 	of_unittest_bus_ranges();
 	of_unittest_bus_3cell_ranges();
+	of_unittest_reg();
 	of_unittest_match_node();
 	of_unittest_platform_populate();
 	of_unittest_overlay();
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 5292f62c1baa..95cb6c5c2d67 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -72,6 +72,8 @@ void __iomem *of_io_request_and_map(struct device_node *device,
 extern const __be32 *__of_get_address(struct device_node *dev, int index, int bar_no,
 				      u64 *size, unsigned int *flags);
 
+int of_property_read_reg(struct device_node *np, int idx, u64 *addr, u64 *size);
+
 extern int of_pci_range_parser_init(struct of_pci_range_parser *parser,
 			struct device_node *node);
 extern int of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
@@ -106,6 +108,11 @@ static inline const __be32 *__of_get_address(struct device_node *dev, int index,
 	return NULL;
 }
 
+static int of_property_read_reg(struct device_node *np, int idx, u64 *addr, u64 *size)
+{
+	return -ENOSYS;
+}
+
 static inline int of_pci_range_parser_init(struct of_pci_range_parser *parser,
 			struct device_node *node)
 {

-- 
2.39.2

