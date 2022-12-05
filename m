Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D21A642766
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiLELVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiLELVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:21:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B8817599
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 03:21:06 -0800 (PST)
Date:   Mon, 05 Dec 2022 11:21:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670239265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=THNc2eWNyAUjX46iElhm0cOZLZCKjFqsNGTMEP1GEyk=;
        b=QlPH6/WVhz/TNDTDqBl+rPOblTX8u25oOl77r42kHyL4M4I9bEougg/tvl5+t2WpA8LKgH
        deLlyiOQ+wJz8ifPkrCKqaSIJjnFw/qc5zykNiz0e1HlYrJOEfiuAfcUVde0fbjZLprsZY
        WP3x2UOMcmoNiG27CBkeMjaP4wfEIjKx64RKplNbI8nK56UOx4RtFGbzFnw6FGHPg6qIM5
        iOH4VyAQ3yJwEdM8JWUClz8e7pHvOnsey2PFwDX0a9tkDHIznn5nvxY4jHWxqToT0J+App
        F9bBClQAW+x33LYFEEb81kixszRmulAMAB/phb59e5SYb9CAkrBzOYt2LVqPIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670239265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=THNc2eWNyAUjX46iElhm0cOZLZCKjFqsNGTMEP1GEyk=;
        b=gwTRIEGE4NFxRxJYZUJGhLyQNGXN+UA5CtetPg4rfxk56FQJsZvMMGGAWvcYBglBJAWNv7
        jyfbJtgaQBDoBIDQ==
From:   "irqchip-bot for Sean Anderson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/ls-extirq: Fix endianness detection
Cc:     Sean Anderson <sean.anderson@seco.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221201212807.616191-1-sean.anderson@seco.com>
References: <20221201212807.616191-1-sean.anderson@seco.com>
MIME-Version: 1.0
Message-ID: <167023926482.4906.17012979311813913704.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     3ae977d0e4e3a2a2ccc912ca2d20c9430508ecdd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3ae977d0e4e3a2a2ccc912ca2d20c9430508ecdd
Author:        Sean Anderson <sean.anderson@seco.com>
AuthorDate:    Thu, 01 Dec 2022 16:28:07 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 05 Dec 2022 10:39:52 

irqchip/ls-extirq: Fix endianness detection

parent is the interrupt parent, not the parent of node. Use
node->parent. This fixes endianness detection on big-endian platforms.

Fixes: 1b00adce8afd ("irqchip/ls-extirq: Fix invalid wait context by avoiding to use regmap")
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221201212807.616191-1-sean.anderson@seco.com
---
 drivers/irqchip/irq-ls-extirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index d8d48b1..139f26b 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -203,7 +203,7 @@ ls_extirq_of_init(struct device_node *node, struct device_node *parent)
 	if (ret)
 		goto err_parse_map;
 
-	priv->big_endian = of_device_is_big_endian(parent);
+	priv->big_endian = of_device_is_big_endian(node->parent);
 	priv->is_ls1021a_or_ls1043a = of_device_is_compatible(node, "fsl,ls1021a-extirq") ||
 				      of_device_is_compatible(node, "fsl,ls1043a-extirq");
 	raw_spin_lock_init(&priv->lock);
