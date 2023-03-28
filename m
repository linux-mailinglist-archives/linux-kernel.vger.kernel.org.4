Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CCC6CCB4A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjC1UQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjC1UQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:16:18 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823653C3F;
        Tue, 28 Mar 2023 13:16:17 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id bi31so9932108oib.9;
        Tue, 28 Mar 2023 13:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680034577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpsM8Gyt+E2oU3DAGA2Cy9raNlOEiWzk+fnJGTbZemI=;
        b=Ax3ex1KHX/0ypZoxKFZlT5QACisbTcVH7G8usW8x8RfetiJg2szV8g03M9jZQoGAEZ
         eDCuHCIbHihTGRAOx4dooSssv6bPtkaAokldqCnUA3PpvsRgW7cfp0HOCMVoEIAGSgbu
         ippLNPcnO8juVoBioA50tU5m04/MybwiluoNfXKTXjaKXGcCjNPBWIGvuzPwiIQ9YRab
         5iwWM/YJ+4WR/Fmwax0NgOlKQ2thTlaneZuMAu8MFDXvI2EIDWsu3r0MQpa7X8gt0BMZ
         2LURSukIuGHr+pev6uWeLUrFdJumPmeSZbU71Vv1I/Kz/hGg3mcboGOqbQ7TW72v8OHW
         +cXA==
X-Gm-Message-State: AO0yUKWNVCHwZ3HeU3OWIGu1xBMbCo0owyHATeDEVDB+EHeNnTxortyq
        10Ddj+7VzUF5dL6L5BMsflw/gV9iVg==
X-Google-Smtp-Source: AK7set9zxFcHUmej6FZI0b/r9kzi7HNM/sTT+QF7paaDfTXpKf0/Bz0qzrUkdUNA414JIRwtcEX/5g==
X-Received: by 2002:a05:6808:de6:b0:387:1a46:8317 with SMTP id g38-20020a0568080de600b003871a468317mr7680846oic.13.1680034576781;
        Tue, 28 Mar 2023 13:16:16 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v7-20020a4aaec7000000b00529cc3986c8sm2696062oon.40.2023.03.28.13.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 13:16:16 -0700 (PDT)
Received: (nullmailer pid 3993710 invoked by uid 1000);
        Tue, 28 Mar 2023 20:16:10 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 28 Mar 2023 15:15:56 -0500
Subject: [PATCH 1/5] of: unittest: Add bus address range parsing tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-dt-address-helpers-v1-1-e2456c3e77ab@kernel.org>
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
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While there are tests for "dma-ranges" helpers, "ranges" is missing any
tests. It's the same underlying code, but for completeness add a test
for "ranges" parsing iterators. This is in preparation to add some
additional "ranges" helpers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/unittest.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index b5a7a31d8bd2..1a45df1f354a 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1008,6 +1008,58 @@ static void __init of_unittest_pci_dma_ranges(void)
 	of_node_put(np);
 }
 
+static void __init of_unittest_bus_ranges(void)
+{
+	struct device_node *np;
+	struct of_range range;
+	struct of_range_parser parser;
+	int i = 0;
+
+	np = of_find_node_by_path("/testcase-data/address-tests");
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
+		unittest(range.flags == IORESOURCE_MEM,
+			"for_each_of_range wrong flags on node %pOF flags=%x (expected %x)\n",
+			np, range.flags, IORESOURCE_MEM);
+		if (!i) {
+			unittest(range.size == 0x40000000,
+				 "for_each_of_range wrong size on node %pOF size=%llx\n",
+				 np, range.size);
+			unittest(range.cpu_addr == 0x70000000,
+				 "for_each_of_range wrong CPU addr (%llx) on node %pOF",
+				 range.cpu_addr, np);
+			unittest(range.bus_addr == 0x70000000,
+				 "for_each_of_range wrong bus addr (%llx) on node %pOF",
+				 range.pci_addr, np);
+		} else {
+			unittest(range.size == 0x20000000,
+				 "for_each_of_range wrong size on node %pOF size=%llx\n",
+				 np, range.size);
+			unittest(range.cpu_addr == 0xd0000000,
+				 "for_each_of_range wrong CPU addr (%llx) on node %pOF",
+				 range.cpu_addr, np);
+			unittest(range.bus_addr == 0x00000000,
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
@@ -3644,6 +3696,7 @@ static int __init of_unittest(void)
 	of_unittest_dma_get_max_cpu_address();
 	of_unittest_parse_dma_ranges();
 	of_unittest_pci_dma_ranges();
+	of_unittest_bus_ranges();
 	of_unittest_match_node();
 	of_unittest_platform_populate();
 	of_unittest_overlay();

-- 
2.39.2

