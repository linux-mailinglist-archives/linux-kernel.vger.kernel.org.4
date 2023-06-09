Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3C272A1E8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjFISOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjFISO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:14:29 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEB33586;
        Fri,  9 Jun 2023 11:14:28 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-33b22221da6so8724675ab.1;
        Fri, 09 Jun 2023 11:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686334467; x=1688926467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pE6BrZSZEIfHJZnlEnBPUpJidRJVROMBg6S+6nxssKs=;
        b=NaavfIeun7ZQYhiKE7CJnbTTUp25hokJDnU9YN02pQbxBnF0PCeZTfFveeZH5SszAK
         Z+BNB0gPub4i+lbXVzwQ9w5+Y/V8GOffiVud413F2jZU9fqWAAJBKa+rCmGIUOCFmU8r
         kcbIZu8cWiZZ6TRz7BRhS9HRLlsAUbMYx2mA1Ym7xMNJr+UU38iOmHSFNmHZTicZQ7J+
         KWOunWTQGcAnXckTZ6MQTkxgqORGI+N2PsZme85ciDiYYQc9Bbk1iaXcXFH4P1iQtD1W
         ixc0XCe9XNdPBMXwHSKRnFzXDgFQNCXrR3dLykRCLoX5E24lhvVHs3z3P0k639/SoCpd
         WX8Q==
X-Gm-Message-State: AC+VfDytDToXLrXzRlC+7DdGFSBp6hsJ4UsHZkgKHcO1e4jZUlMryWb6
        riGLn5Z4Qwi1mczgjOW5qQ==
X-Google-Smtp-Source: ACHHUZ79dCkknd9S8Dmk8waSkwLRk4KiJg4v0cTkG2Eo4R+dz6RcXvl1Z+9Kd2mqw/rD2ad51NDMAA==
X-Received: by 2002:a92:cd43:0:b0:33e:6837:c5fe with SMTP id v3-20020a92cd43000000b0033e6837c5femr2257114ilq.9.1686334467190;
        Fri, 09 Jun 2023 11:14:27 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z9-20020a92cec9000000b0033a6e7ee4e3sm1223860ilq.1.2023.06.09.11.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:14:26 -0700 (PDT)
Received: (nullmailer pid 1681133 invoked by uid 1000);
        Fri, 09 Jun 2023 18:14:15 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 09 Jun 2023 12:13:47 -0600
Subject: [PATCH v2 3/4] clk: mvebu: Iterate over possible CPUs instead of
 DT CPU nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230327-mvebu-clk-fixes-v2-3-8333729ee45d@kernel.org>
References: <20230327-mvebu-clk-fixes-v2-0-8333729ee45d@kernel.org>
In-Reply-To: <20230327-mvebu-clk-fixes-v2-0-8333729ee45d@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
X-Mailer: b4 0.13-dev
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

