Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F201B6CCB4B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjC1UQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjC1UQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:16:18 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8F33C24;
        Tue, 28 Mar 2023 13:16:16 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id k14-20020a9d700e000000b0069faa923e7eso7047280otj.10;
        Tue, 28 Mar 2023 13:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680034575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPV83Ku05eVtYDdjByFRpdT6sBQBYt8mDRN3PCU3Qec=;
        b=Nllb4I47NftUFjJbkHf+VDUOMpj/TZFcHe1fGut2oXqOGcU93wb3xYweH3rwFeeWW/
         qSQIgikaMCwq4tt9qb0Eoy06MupkBcDknpE5DodGw2HNaK2KHLhlB/wN3LhLsc83lipK
         wyLeJfliUnM0lX7pK1n8eHLhGxpYJCzV1707pW7dfn1lJfZxkn8rNplhmEuJqPEzGpf8
         MNk5Zk/OT0XJdKKv1nU8wVsIRjnyeszsVEcKomCegkf5pMhsDVCnJPEQc1n8KetaH7qs
         6PhEpQ2J65jIlbieUyLRmJZGvEGQ0lGB/c0LHV/S11zF0KdskueUPt1LofMOD96/Djjs
         Z/Qw==
X-Gm-Message-State: AAQBX9e6pD1O6IF+7oWxGSUOUymNNVyeRT+ad06b0A/4G2WYoGRVOn8O
        HHD/BP0TOKH+WrtCz2E8PTrkUf3NQQ==
X-Google-Smtp-Source: AKy350Yvh7h3jcQs0qnOEKMeNpdXqJbdelh/CYaGEedZYqt4AXoReTYyPgoYdksvfizCTRrhxzbqJg==
X-Received: by 2002:a9d:6c93:0:b0:69f:b065:7716 with SMTP id c19-20020a9d6c93000000b0069fb0657716mr8330440otr.11.1680034575472;
        Tue, 28 Mar 2023 13:16:15 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d11-20020a05683018eb00b0069f1774cde8sm6583848otf.71.2023.03.28.13.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 13:16:15 -0700 (PDT)
Received: (nullmailer pid 3993727 invoked by uid 1000);
        Tue, 28 Mar 2023 20:16:10 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 28 Mar 2023 15:15:58 -0500
Subject: [PATCH 3/5] of/address: Add support for 3 address cell bus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-dt-address-helpers-v1-3-e2456c3e77ab@kernel.org>
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

There's a few custom bus bindings (e.g. fsl,qoriq-mc) which use a
3 cell format with custom flags in the high cell. We can match these
buses as a fallback if we didn't match on PCI bus which is the only
standard bus binding with 3 address cells.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c                        | 22 +++++++++++
 drivers/of/unittest-data/tests-address.dtsi |  9 ++++-
 drivers/of/unittest.c                       | 58 ++++++++++++++++++++++++++++-
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index b79f005834fc..8cfae24148e0 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -95,11 +95,17 @@ static int of_bus_default_translate(__be32 *addr, u64 offset, int na)
 	return 0;
 }
 
+static unsigned int of_bus_default_flags_get_flags(const __be32 *addr)
+{
+	return of_read_number(addr, 1);
+}
+
 static unsigned int of_bus_default_get_flags(const __be32 *addr)
 {
 	return IORESOURCE_MEM;
 }
 
+
 #ifdef CONFIG_PCI
 static unsigned int of_bus_pci_get_flags(const __be32 *addr)
 {
@@ -344,6 +350,11 @@ static unsigned int of_bus_isa_get_flags(const __be32 *addr)
 	return flags;
 }
 
+static int of_bus_default_flags_match(struct device_node *np)
+{
+	return of_bus_n_addr_cells(np) == 3;
+}
+
 /*
  * Array of bus specific translators
  */
@@ -373,6 +384,17 @@ static struct of_bus of_busses[] = {
 		.has_flags = true,
 		.get_flags = of_bus_isa_get_flags,
 	},
+	/* Default with flags cell */
+	{
+		.name = "default-flags",
+		.addresses = "reg",
+		.match = of_bus_default_flags_match,
+		.count_cells = of_bus_default_count_cells,
+		.map = of_bus_default_map,
+		.translate = of_bus_default_translate,
+		.has_flags = true,
+		.get_flags = of_bus_default_flags_get_flags,
+	},
 	/* Default */
 	{
 		.name = "default",
diff --git a/drivers/of/unittest-data/tests-address.dtsi b/drivers/of/unittest-data/tests-address.dtsi
index 6604a52bf6cb..bc0029cbf8ea 100644
--- a/drivers/of/unittest-data/tests-address.dtsi
+++ b/drivers/of/unittest-data/tests-address.dtsi
@@ -14,7 +14,7 @@ address-tests {
 			#size-cells = <1>;
 			/* ranges here is to make sure we don't use it for
 			 * dma-ranges translation */
-			ranges = <0x70000000 0x70000000 0x40000000>,
+			ranges = <0x70000000 0x70000000 0x50000000>,
 				 <0x00000000 0xd0000000 0x20000000>;
 			dma-ranges = <0x0 0x20000000 0x40000000>;
 
@@ -43,6 +43,13 @@ pci@90000000 {
 					     <0x42000000 0x0 0xc0000000 0x20000000 0x0 0x10000000>;
 			};
 
+			bus@a0000000 {
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0xf00baa 0x0 0x0 0xa0000000 0x0 0x100000>,
+					 <0xf00bee 0x1 0x0 0xb0000000 0x0 0x200000>;
+			};
+
 		};
 	};
 };
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 945288d5672f..29066ecbed47 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1048,7 +1048,7 @@ static void __init of_unittest_bus_ranges(void)
 			"for_each_of_range wrong flags on node %pOF flags=%x (expected %x)\n",
 			np, range.flags, IORESOURCE_MEM);
 		if (!i) {
-			unittest(range.size == 0x40000000,
+			unittest(range.size == 0x50000000,
 				 "for_each_of_range wrong size on node %pOF size=%llx\n",
 				 np, range.size);
 			unittest(range.cpu_addr == 0x70000000,
@@ -1074,6 +1074,61 @@ static void __init of_unittest_bus_ranges(void)
 	of_node_put(np);
 }
 
+static void __init of_unittest_bus_3cell_ranges(void)
+{
+	struct device_node *np;
+	struct of_range range;
+	struct of_range_parser parser;
+	int i = 0;
+
+	np = of_find_node_by_path("/testcase-data/address-tests/bus@a0000000");
+	if (!np) {
+		pr_err("missing testcase data\n");
+		return;
+	}
+
+	if (of_range_parser_init(&parser, np)) {
+		pr_err("missing ranges property\n");
+		return;
+	}
+
+	/*
+	 * Get the "ranges" from the device tree
+	 */
+	for_each_of_range(&parser, &range) {
+		if (!i) {
+			unittest(range.flags == 0xf00baa,
+				 "for_each_of_range wrong flags on node %pOF flags=%x\n",
+				 np, range.flags);
+			unittest(range.size == 0x100000,
+				 "for_each_of_range wrong size on node %pOF size=%llx\n",
+				 np, range.size);
+			unittest(range.cpu_addr == 0xa0000000,
+				 "for_each_of_range wrong CPU addr (%llx) on node %pOF",
+				 range.cpu_addr, np);
+			unittest(range.bus_addr == 0x0,
+				 "for_each_of_range wrong bus addr (%llx) on node %pOF",
+				 range.pci_addr, np);
+		} else {
+			unittest(range.flags == 0xf00bee,
+				 "for_each_of_range wrong flags on node %pOF flags=%x\n",
+				 np, range.flags);
+			unittest(range.size == 0x200000,
+				 "for_each_of_range wrong size on node %pOF size=%llx\n",
+				 np, range.size);
+			unittest(range.cpu_addr == 0xb0000000,
+				 "for_each_of_range wrong CPU addr (%llx) on node %pOF",
+				 range.cpu_addr, np);
+			unittest(range.bus_addr == 0x100000000,
+				 "for_each_of_range wrong bus addr (%llx) on node %pOF",
+				 range.pci_addr, np);
+		}
+		i++;
+	}
+
+	of_node_put(np);
+}
+
 static void __init of_unittest_parse_interrupts(void)
 {
 	struct device_node *np;
@@ -3711,6 +3766,7 @@ static int __init of_unittest(void)
 	of_unittest_parse_dma_ranges();
 	of_unittest_pci_dma_ranges();
 	of_unittest_bus_ranges();
+	of_unittest_bus_3cell_ranges();
 	of_unittest_match_node();
 	of_unittest_platform_populate();
 	of_unittest_overlay();

-- 
2.39.2

