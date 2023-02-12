Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126506936BB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 10:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBLJhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 04:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBLJhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 04:37:03 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC95CC27
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 01:37:02 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so9574937pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 01:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nCasqaV98P2Sm+VlCAfJ32cJ/fBQ/6ZKBCND11ne1dY=;
        b=jUryafGdgBrJSoDjHP6PxeLilNLst5mrCdtGYWZwtujCC9k6GLaE1MdAKbVNdYNhGh
         xJbYpPyLOWD3ZrB4snG/UWNxNkROg762fcusMTpJxcP0Rj6KW392ZchizN/I/NjOUSDS
         ihgJdCrPPb4TI9H+FZhc+pgjk9WLttKbvAJRTF3p5Pc6gqxzqnNNwwGxfE8THCKmKT2V
         YKpfY7kBywQZOBl390plDLjxy3yTBRYY7GHVus+ysflEa7cdS3pIH7WgLZ5kATWL4y1m
         +IDn+T05kFLd3dtnSLbK8d2yj10UHHZOPEegaV1/277QHMb4zC+1fFTBL/5g2zIsuFAp
         77qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCasqaV98P2Sm+VlCAfJ32cJ/fBQ/6ZKBCND11ne1dY=;
        b=iOY/HvOY1dzmBRMnjD6VvXDeGAVNy7vklkLSq2ilwTuyQxMlxyMHGR4I+oocgJtTH3
         VCIKoDzibuL/EdLXt/1i7DbzbhPQGVJY699IobmAuBxf9C2+nufImbI3tqe35Pv9D3lQ
         RnyWOrJX8Pm0ocaGkimk41xBq3B3k3aZoU4rrZUT9IT0K69lINUY0bVaWqNZZJEQmP3Z
         6NQzZpZNj6ulmhSb7mwk/eRk5fSOOhvRtDHPgJ7TfYsxk22AQ8X33WY7eK7CYM3fJhSp
         Gip2Shk1VQO9/I1Ikx5kprInNAW5B5ittcJIKcvYIJ8I+PEpw3v0q3thYRlSUrwy4Wvb
         c+qw==
X-Gm-Message-State: AO0yUKX1jwir2alzpXoUxnc7FhjxKduRH3t44Jq/o7qxQY+9bFxubuLP
        1qo+LRsv3T51DSDMcp5LsOhql9LkbDJCxHXMaXE=
X-Google-Smtp-Source: AK7set/lD1ChqR/wwwzu/gr5qjubFRYhoQGaOZ3UaCjhWcXHYJlbOnFQvOPumP2TMrZacnVpN/lxZg==
X-Received: by 2002:a17:902:ebd0:b0:193:1f24:a042 with SMTP id p16-20020a170902ebd000b001931f24a042mr17922922plg.29.1676194621880;
        Sun, 12 Feb 2023 01:37:01 -0800 (PST)
Received: from localhost.localdomain ([222.128.171.180])
        by smtp.gmail.com with ESMTPSA id ix17-20020a170902f81100b0019a91895cdfsm1308717plb.50.2023.02.12.01.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 01:37:01 -0800 (PST)
From:   Ben Dai <ben.dai9703@gmail.com>
To:     tglx@linutronix.de, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Dai <ben.dai9703@gmail.com>
Subject: [PATCH] irqchip/gic-v3: Allow 'dma-noncoherent' property for ITS
Date:   Sun, 12 Feb 2023 17:35:05 +0800
Message-Id: <20230212093505.5754-1-ben.dai9703@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the ITS driver expects the hardware to report whether it is
shareable, but according to the description of the GITS_CBASER register
in the GICv3 architecture specification:
 > It is IMPLEMENTATION DEFINED whether this field has a fixed value or
 > can be programmed by software. Implementing this field with a fixed
 > value is deprecated.

It means that the hardware may expect the software to correctly configure
the access attributes of the ITS. In order to support those designs where
ITS and CPU are not in a coherent domain, allow 'dma-noncoherent' property
for ITS.

Signed-off-by: Ben Dai <ben.dai9703@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de> (maintainer:IRQCHIP DRIVERS)
Cc: Marc Zyngier <maz@kernel.org> (maintainer:IRQCHIP DRIVERS)
Cc: linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS)
---
 drivers/irqchip/irq-gic-v3-its.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 973ede0197e3..794b14b0a6b4 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5009,6 +5009,7 @@ static int __init its_probe_one(struct resource *res,
 	void __iomem *its_base;
 	u64 baser, tmp, typer;
 	struct page *page;
+	bool coherent;
 	u32 ctlr;
 	int err;
 
@@ -5087,15 +5088,25 @@ static int __init its_probe_one(struct resource *res,
 		goto out_free_tables;
 
 	baser = (virt_to_phys(its->cmd_base)	|
-		 GITS_CBASER_RaWaWb		|
-		 GITS_CBASER_InnerShareable	|
 		 (ITS_CMD_QUEUE_SZ / SZ_4K - 1)	|
 		 GITS_CBASER_VALID);
 
+	coherent = of_dma_is_coherent(to_of_node(handle));
+	if (coherent) {
+		baser |= (GITS_CBASER_RaWaWb | GITS_CBASER_InnerShareable);
+	} else {
+		baser |= GITS_CBASER_nC;
+		its->flags |= ITS_FLAGS_CMDQ_NEEDS_FLUSHING;
+	}
+
 	gits_write_cbaser(baser, its->base + GITS_CBASER);
-	tmp = gits_read_cbaser(its->base + GITS_CBASER);
 
-	if ((tmp ^ baser) & GITS_CBASER_SHAREABILITY_MASK) {
+	if (coherent) {
+		tmp = gits_read_cbaser(its->base + GITS_CBASER);
+
+		if ((tmp ^ baser) & GITS_CBASER_SHAREABILITY_MASK)
+			its->flags |= ITS_FLAGS_CMDQ_NEEDS_FLUSHING;
+
 		if (!(tmp & GITS_CBASER_SHAREABILITY_MASK)) {
 			/*
 			 * The HW reports non-shareable, we must
@@ -5107,10 +5118,11 @@ static int __init its_probe_one(struct resource *res,
 			baser |= GITS_CBASER_nC;
 			gits_write_cbaser(baser, its->base + GITS_CBASER);
 		}
-		pr_info("ITS: using cache flushing for cmd queue\n");
-		its->flags |= ITS_FLAGS_CMDQ_NEEDS_FLUSHING;
 	}
 
+	if (its->flags & ITS_FLAGS_CMDQ_NEEDS_FLUSHING)
+		pr_info("ITS: using cache flushing for cmd queue\n");
+
 	gits_write_cwriter(0, its->base + GITS_CWRITER);
 	ctlr = readl_relaxed(its->base + GITS_CTLR);
 	ctlr |= GITS_CTLR_ENABLE;
-- 
2.34.1

