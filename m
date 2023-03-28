Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938606CCB47
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjC1UQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjC1UQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:16:16 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC713C34;
        Tue, 28 Mar 2023 13:16:15 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id n6-20020a4abd06000000b0053b59893660so2098392oop.0;
        Tue, 28 Mar 2023 13:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680034574;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wq9MleJbVtyTb3QrV3Xlq0I3I3gqQWPoavFTMvWxBWU=;
        b=cjCaxNPhDjCYwxKd1vlh0gNPer9LikdolCMHsUUQJa4pl4wq63n8tukJlBSfn3i3cM
         YB2XlZLRDavSZnIpoHOTik1HFKyFmVobMALFFXrcwahHn+1yJgdoY9xbOgSUYifEDRp5
         4P/rJ2Iwvz7q0bweboHXR7gyCAje0e1kQgRsmT3cE/xzkLlxVmN1efaK6Tn02JtH7cUL
         hvecglhyw6v1jT4M2gaz7tPIxB8FxQ0j+XNIqjYpT7eL+J0L5wmPW93AxsUmEVrOaNG/
         fBKN/QPq/DsEqFb1KX0N1SLIVV1C/yZzfBdoaPN1n67YoeRD2rBuSIZ8fltVuvyOIWsd
         g7ZQ==
X-Gm-Message-State: AO0yUKVds1V6NScy2sqtAbahWd2f1dPNsiLppAl8V6Y2lkv3TsYVjCg9
        JKCsZ84eSwUlWgiHIaL50Q==
X-Google-Smtp-Source: AK7set9De6XnycHJIQgLEMSB8BvrDZtnx3/knyjsjlWaCorjvDtfznD+X/H4ZPT08mbWWvY4Eor3wg==
X-Received: by 2002:a4a:4f83:0:b0:53b:4b94:45bf with SMTP id c125-20020a4a4f83000000b0053b4b9445bfmr8745156oob.3.1680034574395;
        Tue, 28 Mar 2023 13:16:14 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c192-20020a4a4fc9000000b0053b88b03e24sm7136185oob.18.2023.03.28.13.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 13:16:13 -0700 (PDT)
Received: (nullmailer pid 3993734 invoked by uid 1000);
        Tue, 28 Mar 2023 20:16:10 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 28 Mar 2023 15:15:59 -0500
Subject: [PATCH 4/5] of/address: Add of_range_count() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-dt-address-helpers-v1-4-e2456c3e77ab@kernel.org>
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

Some users need a count of the number of ranges entries before
iterating over the entries. Typically this is for allocating some data
structure based on the size. Add a helper, of_range_count(), to get the
count. The helper must be called with an struct of_range_parser
initialized by of_range_parser_init().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/unittest.c      |  7 ++++++-
 include/linux/of_address.h | 16 ++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 29066ecbed47..eaeb58065acc 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1014,7 +1014,7 @@ static void __init of_unittest_bus_ranges(void)
 	struct of_range range;
 	struct of_range_parser parser;
 	struct resource res;
-	int ret, i = 0;
+	int ret, count, i = 0;
 
 	np = of_find_node_by_path("/testcase-data/address-tests");
 	if (!np) {
@@ -1040,6 +1040,11 @@ static void __init of_unittest_bus_ranges(void)
 		"of_range_to_resource wrong resource start address on node %pOF res=%pR\n",
 		np, &res);
 
+	count = of_range_count(&parser);
+	unittest(count == 2,
+		"of_range_count wrong size on node %pOF count=%d\n",
+		np, count);
+
 	/*
 	 * Get the "ranges" from the device tree
 	 */
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 1d005439f026..5292f62c1baa 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -35,6 +35,22 @@ struct of_pci_range {
 	for (; of_pci_range_parser_one(parser, range);)
 #define for_each_of_range for_each_of_pci_range
 
+/*
+ * of_range_count - Get the number of "ranges" or "dma-ranges" entries
+ * @parser:	Parser state initialized by of_range_parser_init()
+ *
+ * Returns the number of entries or 0 if none.
+ *
+ * Note that calling this within or after the for_each_of_range() iterator will
+ * be inaccurate giving the number of entries remaining.
+ */
+static inline int of_range_count(const struct of_range_parser *parser)
+{
+	if (!parser || !parser->node || !parser->range || parser->range == parser->end)
+		return 0;
+	return (parser->end - parser->range) / (parser->na + parser->pna + parser->ns);
+}
+
 /* Translate a DMA address from device space to CPU space */
 extern u64 of_translate_dma_address(struct device_node *dev,
 				    const __be32 *in_addr);

-- 
2.39.2

