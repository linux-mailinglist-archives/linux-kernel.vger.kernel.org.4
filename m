Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9216C0319
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjCSQcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 12:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCSQcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:32:06 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682F11E1C7;
        Sun, 19 Mar 2023 09:31:57 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id f14so4466706iow.5;
        Sun, 19 Mar 2023 09:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679243516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QnxdeK8jmAChnEpXpFRAFrjxr+t2od26C+e+3a4+JrI=;
        b=Lqf3CDahTOvz12Nn7pxxu6TdnnQSeESMs6yqijotAEjRoCl7QqACXC5w5I4tRFFWHn
         H5KcityLGwk7EUBUTDRRtJvJJvqeKWiwDUewrGmJ8wC3OkpNZrmOS1iN4AJkfpo+VzGL
         e19TfLHYDKlY0VmbxCZBs7kN2yq5omTbVxX2YlbQAv5Ch0wsnfOFHa7q4uAcnkXRzzVT
         ENqeRuD2OJ2NVYWa+YsxGwqmHLrqu0Xn/5Gn9NiXqq8+ri3BfKc9JoZMSc2Y4WHO9PEt
         fCZfUeo45lNb4eFRwSXWKQ8kfQPLYo7o5VSrseumyaxY2neeKcnwpQQfs+It5GHOADF/
         PZjg==
X-Gm-Message-State: AO0yUKWh+UrGyd6MOQX+JEo3S7jCrEI65MgM9MQZ7Tgvm+NKZix0Q5Kg
        JjELNYiG4xKNmdmRnbJUZIeVedlnQQ==
X-Google-Smtp-Source: AK7set+2nEV+ag9v9wlzJthC9w74DvRoCo35IijaZTMW4PqJjzqm04a/bvi3IU7l7G6kkI32Vo1I4g==
X-Received: by 2002:a6b:4f05:0:b0:71e:d132:d08f with SMTP id d5-20020a6b4f05000000b0071ed132d08fmr3310042iob.9.1679243516118;
        Sun, 19 Mar 2023 09:31:56 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80c7:2689:137d:d795:47e4:3de1])
        by smtp.gmail.com with ESMTPSA id t10-20020a6b090a000000b0073df2110f58sm2293143ioi.7.2023.03.19.09.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:31:55 -0700 (PDT)
Received: (nullmailer pid 225554 invoked by uid 1000);
        Sun, 19 Mar 2023 16:31:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: octeon: Use of_address_to_resource()
Date:   Sun, 19 Mar 2023 11:31:48 -0500
Message-Id: <20230319163148.225443-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace of_get_address() and of_translate_address() calls with single
call to of_address_to_resource().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/mips/cavium-octeon/octeon-irq.c | 35 ++++++++++++----------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index fd8043f6ff8a..064e2409377a 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -2290,7 +2290,7 @@ static irqreturn_t octeon_irq_cib_handler(int my_irq, void *data)
 static int __init octeon_irq_init_cib(struct device_node *ciu_node,
 				      struct device_node *parent)
 {
-	const __be32 *addr;
+	struct resource res;
 	u32 val;
 	struct octeon_irq_cib_host_data *host_data;
 	int parent_irq;
@@ -2309,21 +2309,19 @@ static int __init octeon_irq_init_cib(struct device_node *ciu_node,
 		return -ENOMEM;
 	raw_spin_lock_init(&host_data->lock);
 
-	addr = of_get_address(ciu_node, 0, NULL, NULL);
-	if (!addr) {
+	r = of_address_to_resource(ciu_node, 0, &res);
+	if (r) {
 		pr_err("ERROR: Couldn't acquire reg(0) %pOFn\n", ciu_node);
-		return -EINVAL;
+		return r;
 	}
-	host_data->raw_reg = (u64)phys_to_virt(
-		of_translate_address(ciu_node, addr));
+	host_data->raw_reg = (u64)phys_to_virt(res.start);
 
-	addr = of_get_address(ciu_node, 1, NULL, NULL);
-	if (!addr) {
+	r = of_address_to_resource(ciu_node, 1, &res);
+	if (r) {
 		pr_err("ERROR: Couldn't acquire reg(1) %pOFn\n", ciu_node);
-		return -EINVAL;
+		return r;
 	}
-	host_data->en_reg = (u64)phys_to_virt(
-		of_translate_address(ciu_node, addr));
+	host_data->en_reg = (u64)phys_to_virt(res.start);
 
 	r = of_property_read_u32(ciu_node, "cavium,max-bits", &val);
 	if (r) {
@@ -2874,11 +2872,11 @@ static struct irq_chip octeon_irq_chip_ciu3_mbox = {
 static int __init octeon_irq_init_ciu3(struct device_node *ciu_node,
 				       struct device_node *parent)
 {
-	int i;
+	int i, ret;
 	int node;
 	struct irq_domain *domain;
 	struct octeon_ciu3_info *ciu3_info;
-	const __be32 *zero_addr;
+	struct resource res;
 	u64 base_addr;
 	union cvmx_ciu3_const consts;
 
@@ -2888,14 +2886,11 @@ static int __init octeon_irq_init_ciu3(struct device_node *ciu_node,
 	if (!ciu3_info)
 		return -ENOMEM;
 
-	zero_addr = of_get_address(ciu_node, 0, NULL, NULL);
-	if (WARN_ON(!zero_addr))
-		return -EINVAL;
-
-	base_addr = of_translate_address(ciu_node, zero_addr);
-	base_addr = (u64)phys_to_virt(base_addr);
+	ret = of_address_to_resource(ciu_node, 0, &res);
+	if (WARN_ON(ret))
+		return ret;
 
-	ciu3_info->ciu3_addr = base_addr;
+	ciu3_info->ciu3_addr = base_addr = phys_to_virt(res.start);
 	ciu3_info->node = node;
 
 	consts.u64 = cvmx_read_csr(base_addr + CIU3_CONST);
-- 
2.39.2

