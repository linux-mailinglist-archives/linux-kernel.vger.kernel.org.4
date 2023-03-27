Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A956CAD68
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjC0Snn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjC0Sn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:43:29 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB564233;
        Mon, 27 Mar 2023 11:43:23 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id bk5so7113435oib.6;
        Mon, 27 Mar 2023 11:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679942603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pE6BrZSZEIfHJZnlEnBPUpJidRJVROMBg6S+6nxssKs=;
        b=ZACpH1ZMacEp/TxE9cfU6Laq6ZIhQrEM923Er/7LuS2OO8lj84a0fDCFzAvl+H3INl
         dl0LdhLJcdymjCJbAILUAU01b0i+6Sc+MFI6Zb/smco1l4O8NbvVXLLI45dK7JQ8jMAD
         Dt61h3hZT+WrP6a3DR23FRwWZRbh6lEUN9mmRJk6Qd/6Yz3MIfL5BHK6LBlAmnVR16Ic
         IWPO0VAOyX52S1k/M58Nc4pBu45z1khk2dE6dHzzNF5/nhiVpzkKh0aVxw43gFCtlguL
         h+0AY9hfNlwddx1LBDpi2+pJPL7DZFNU7bdnzcT6PqK/XcBRIeWCB13ltFNjuoUXoN3w
         1ovw==
X-Gm-Message-State: AAQBX9dauqxDY5yHUM+6pUiEF6Svg6BD/7uVzSj0kj9UvuTB7/4YcNUo
        Zv3/r/yOhODKEBx1DrXvwQ==
X-Google-Smtp-Source: AKy350Yoe4hgpUKbCUxvQlP6BHpmdYrkR/97D44BpHvO6gg9kj9r4j/ALflcwvzpNOeozVL7I6D0Jw==
X-Received: by 2002:aca:919:0:b0:388:f3b6:edb0 with SMTP id 25-20020aca0919000000b00388f3b6edb0mr3671558oij.51.1679942602755;
        Mon, 27 Mar 2023 11:43:22 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q204-20020a4a33d5000000b0053853156b5csm11154922ooq.8.2023.03.27.11.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 11:43:22 -0700 (PDT)
Received: (nullmailer pid 250781 invoked by uid 1000);
        Mon, 27 Mar 2023 18:43:19 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 27 Mar 2023 13:43:20 -0500
Subject: [PATCH 3/3] clk: mvebu: Iterate over possible CPUs instead of DT
 CPU nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230327-mvebu-clk-fixes-v1-3-438de1026efd@kernel.org>
References: <20230327-mvebu-clk-fixes-v1-0-438de1026efd@kernel.org>
In-Reply-To: <20230327-mvebu-clk-fixes-v1-0-438de1026efd@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
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

Rework iterating over DT CPU nodes to iterate over possible CPUs
instead. There's no need to walk the DT CPU nodes again. Possible CPUs
is equal to the number of CPUs defined in the DT. Using the "reg" value
for an array index is fragile as it assumes "reg" is 0-N which often is
not the case.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/clk/mvebu/clk-cpu.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
index c2af3395cf13..db2b38c21304 100644
--- a/drivers/clk/mvebu/clk-cpu.c
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -168,8 +168,8 @@ static void __init of_cpu_clk_setup(struct device_node *node)
 	struct cpu_clk *cpuclk;
 	void __iomem *clock_complex_base = of_iomap(node, 0);
 	void __iomem *pmu_dfs_base = of_iomap(node, 1);
-	int ncpus = 0;
-	struct device_node *dn;
+	int ncpus = num_possible_cpus();
+	int cpu;
 
 	if (clock_complex_base == NULL) {
 		pr_err("%s: clock-complex base register not set\n",
@@ -181,9 +181,6 @@ static void __init of_cpu_clk_setup(struct device_node *node)
 		pr_warn("%s: pmu-dfs base register not set, dynamic frequency scaling not available\n",
 			__func__);
 
-	for_each_of_cpu_node(dn)
-		ncpus++;
-
 	cpuclk = kcalloc(ncpus, sizeof(*cpuclk), GFP_KERNEL);
 	if (WARN_ON(!cpuclk))
 		goto cpuclk_out;
@@ -192,19 +189,14 @@ static void __init of_cpu_clk_setup(struct device_node *node)
 	if (WARN_ON(!clks))
 		goto clks_out;
 
-	for_each_of_cpu_node(dn) {
+	for_each_possible_cpu(cpu) {
 		struct clk_init_data init;
 		struct clk *clk;
 		char *clk_name = kzalloc(5, GFP_KERNEL);
-		int cpu, err;
 
 		if (WARN_ON(!clk_name))
 			goto bail_out;
 
-		err = of_property_read_u32(dn, "reg", &cpu);
-		if (WARN_ON(err))
-			goto bail_out;
-
 		sprintf(clk_name, "cpu%d", cpu);
 
 		cpuclk[cpu].parent_name = of_clk_get_parent_name(node, 0);

-- 
2.39.2

