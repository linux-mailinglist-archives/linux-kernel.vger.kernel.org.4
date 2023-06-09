Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCCB72A251
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjFISc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjFISc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:32:56 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A704135B3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:32:38 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-33b3cfb9495so9014375ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 11:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335558; x=1688927558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zg65H04iGkdu9WHQxXNVtHvgC9Kx1HBt9MiQibRABa0=;
        b=l2qP6XpV5tnRNcVU5tF0MicDR0Xuew0rlyWk4o0Vzf4TLpW1bKYv/C3sufTbsid0cr
         JMYzPxuQHNR9/OHr6dNuvWOfoVgQOc8ZYVdNNZ+KtHPHvKbUEdv+vPcfaUmsx+5Ukmeu
         wr6YVrDLGAKGBEN+emBRxY5h1i/5z2MqMdR0J/wZxUdOcIGPD+gGU7JMEI1YykxOFuAx
         7dpWvZBPQLL8SiPP99tr6PUfer+ksgU9W1bYp3T1LFezzaphAhlsVn4EwWB/9rrA9ZQT
         wk8UnodV13zfYRGG/qZ5jos4QNGzcA9IamaX2D+sVbIAFhA0T6eQmMZqR6XsUoYH/i3h
         NHOw==
X-Gm-Message-State: AC+VfDyHG3pCrPC8YZy7JkVX79TPs5poZj7DVRa5GmWGjaoOgzOdygka
        kQ0gJjdCJ7OCgsRarp7S+A==
X-Google-Smtp-Source: ACHHUZ5kDT3yQU8Qmg/+XcR/h6SF54Crybnbfhrn4VLslc18TBNNRrE0/68Gu6Mp/XjU8TeFesPn6Q==
X-Received: by 2002:a92:d9c5:0:b0:33a:b6ca:c4d3 with SMTP id n5-20020a92d9c5000000b0033ab6cac4d3mr2237604ilq.12.1686335557918;
        Fri, 09 Jun 2023 11:32:37 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t17-20020a92cc51000000b00325e4c39de8sm1203739ilq.66.2023.06.09.11.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:32:37 -0700 (PDT)
Received: (nullmailer pid 1767148 invoked by uid 1000);
        Fri, 09 Jun 2023 18:32:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Anatolij Gustschin <agust@denx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: mpc512x: Remove open coded "ranges" parsing
Date:   Fri,  9 Jun 2023 12:32:32 -0600
Message-Id: <20230609183232.1767050-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"ranges" is a standard property, and we have common helper functions
for parsing it, so let's use the for_each_of_range() iterator.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c | 46 ++++++-------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
index 04bf6ecf7d55..1bfb29574caa 100644
--- a/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
+++ b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
@@ -373,50 +373,32 @@ static int get_cs_ranges(struct device *dev)
 {
 	int ret = -ENODEV;
 	struct device_node *lb_node;
-	const u32 *addr_cells_p;
-	const u32 *size_cells_p;
-	int proplen;
-	size_t i;
+	size_t i = 0;
+	struct of_range_parser parser;
+	struct of_range range;
 
 	lb_node = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-localbus");
 	if (!lb_node)
 		return ret;
 
-	/*
-	 * The node defined as compatible with 'fsl,mpc5121-localbus'
-	 * should have two address cells and one size cell.
-	 * Every item of its ranges property should consist of:
-	 * - the first address cell which is the chipselect number;
-	 * - the second address cell which is the offset in the chipselect,
-	 *    must be zero.
-	 * - CPU address of the beginning of an access window;
-	 * - the only size cell which is the size of an access window.
-	 */
-	addr_cells_p = of_get_property(lb_node, "#address-cells", NULL);
-	size_cells_p = of_get_property(lb_node, "#size-cells", NULL);
-	if (addr_cells_p == NULL || *addr_cells_p != 2 ||
-				size_cells_p == NULL ||	*size_cells_p != 1) {
-		goto end;
-	}
-
-	proplen = of_property_count_u32_elems(lb_node, "ranges");
-	if (proplen <= 0 || proplen % 4 != 0)
-		goto end;
+	of_range_parser_init(&parser, lb_node);
+	lpbfifo.cs_n = of_range_count(&parser);
 
-	lpbfifo.cs_n = proplen / 4;
 	lpbfifo.cs_ranges = devm_kcalloc(dev, lpbfifo.cs_n,
 					sizeof(struct cs_range), GFP_KERNEL);
 	if (!lpbfifo.cs_ranges)
 		goto end;
 
-	if (of_property_read_u32_array(lb_node, "ranges",
-				(u32 *)lpbfifo.cs_ranges, proplen) != 0) {
-		goto end;
-	}
-
-	for (i = 0; i < lpbfifo.cs_n; i++) {
-		if (lpbfifo.cs_ranges[i].base != 0)
+	for_each_of_range(&parser, &range) {
+		u32 base = lower_32_bits(range.bus_addr);
+		if (base)
 			goto end;
+
+		lpbfifo.cs_ranges[i].csnum = upper_32_bits(range.bus_addr);
+		lpbfifo.cs_ranges[i].base = base;
+		lpbfifo.cs_ranges[i].addr = range.cpu_addr;
+		lpbfifo.cs_ranges[i].size = range.size;
+		i++;
 	}
 
 	ret = 0;
-- 
2.39.2

