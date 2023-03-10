Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64D86B47E5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjCJO40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjCJOyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:54:49 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B545F12C73C;
        Fri, 10 Mar 2023 06:50:20 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-176d93cd0daso6080626fac.4;
        Fri, 10 Mar 2023 06:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmtctEeDb3ppifp5NomE6kdEpcIqenZR0+DZDZHuGYY=;
        b=Odw92fzub4dal7uybV59Gu9KnIbYM7APnc1imcmYOEmkOcd/P0SARJa8ezrhdn0qBM
         JRR2gpxQNvJu0ockf7H6SQWoVJ22s9eRg5K2Lakn3oGyq2Mao5Z6cApGhWJd8FIsuyyH
         jc07D4OhBCdEK19F1ciSRX8Bimajxob/rLEFOLOY9f0VWpr+l1c0hbXo4i2qKdfSs0jY
         Yv4tVr8WjrK2WN1R7n3fMB06/EZgItjxGhdQ+GhR5LBXeeZdBvMs9W7cslo2J8TFAuF8
         5ozstHrzBE/WU32GPoa3Rtxb2JHVvUaVrPu6qBOWt+DdR13cAMxOSRxYaS2WC/f84gjw
         JJBw==
X-Gm-Message-State: AO0yUKVjYNkCY18hI3xw3C407V5tnqZORDaQlGnRO5/o4thj/IFqX9j6
        du1KTXyKL+MaeExZwrcB+3ih8iyWxg==
X-Google-Smtp-Source: AK7set9Xe8s2Zk7Un7yKSStpf7vMjAfknMbxWORFUi9dXdv+Wk4SenfGgVZi0dZN6CjGkL85QOnRxQ==
X-Received: by 2002:a05:6871:546:b0:16e:49fb:f78a with SMTP id t6-20020a056871054600b0016e49fbf78amr15408436oal.39.1678459692624;
        Fri, 10 Mar 2023 06:48:12 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ds26-20020a0568705b1a00b0017243edbe5bsm68629oab.58.2023.03.10.06.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:04 -0800 (PST)
Received: (nullmailer pid 1543096 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org
Subject: [PATCH] irqchip: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:10 -0600
Message-Id: <20230310144710.1543070-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/irqchip/irq-csky-apb-intc.c | 2 +-
 drivers/irqchip/irq-gic-v2m.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
index 42d8a2438ebc..6710691e4c25 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -68,7 +68,7 @@ static void __init ck_set_gc(struct device_node *node, void __iomem *reg_base,
 	gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
 	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;
 
-	if (of_find_property(node, "csky,support-pulse-signal", NULL))
+	if (of_property_read_bool(node, "csky,support-pulse-signal"))
 		gc->chip_types[0].chip.irq_unmask = irq_ck_mask_set_bit;
 }
 
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index f1e75b35a52a..f2ff4387870d 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -421,7 +421,7 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 		u32 spi_start = 0, nr_spis = 0;
 		struct resource res;
 
-		if (!of_find_property(child, "msi-controller", NULL))
+		if (!of_property_read_bool(child, "msi-controller"))
 			continue;
 
 		ret = of_address_to_resource(child, 0, &res);
-- 
2.39.2

