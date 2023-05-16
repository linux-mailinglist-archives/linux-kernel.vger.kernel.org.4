Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23823704A63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjEPKWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjEPKWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:22:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7310C35AE;
        Tue, 16 May 2023 03:22:39 -0700 (PDT)
Date:   Tue, 16 May 2023 10:22:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684232557;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJ71UFwUGW1XXqTAk35MZr6o6B5VIiNS0mmzaMOE5UY=;
        b=j+kyH2+/B3siM08d+fgKHCAv+TQFWKfUioX37OZnOD+SlI+LMp58mxh6Sd/ewa6vxU3rUY
        IUuUO1ptjOGqGXIshA6sS0mvmdo3uVqkB/x0skEO3/Lu2+ihLuu2yQeyxVib0qCur2n8Vh
        CrrA19wHKrjI8vLdJWNQ30yqQys5obcobw1JAfZTm3pEomE1JMLNnBghwZfX33iNmN+PRB
        0f1bKeZOK1kxs9DWMXh1vZGTorfEzVS7KoLQGeeFo70JvRIv6y2SQTsDmbnRfu54DWZLNC
        UGAcB54oeO+ndRSXKX8pPxXHUZNLOgtdQbTrI0faN1jUNE64K9az+1Hs5W290Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684232557;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJ71UFwUGW1XXqTAk35MZr6o6B5VIiNS0mmzaMOE5UY=;
        b=l5vxn1ux3JBxOf31MM3BNyunoVYnp7mrcsgANeun7KDI6E4eHxF5CYVCFnogQGnOp2gX/C
        BTrR2P3OeiiieZBQ==
From:   "irqchip-bot for Jiaxun Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/mips-gic: Don't touch vl_map if
 a local interrupt is not routable
Cc:     stable@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230424103156.66753-2-jiaxun.yang@flygoat.com>
References: <20230424103156.66753-2-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Message-ID: <168423255748.404.10699109053196675106.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     2c6c9c049510163090b979ea5f92a68ae8d93c45
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/2c6c9c049510163090b979ea5f92a68ae8d93c45
Author:        Jiaxun Yang <jiaxun.yang@flygoat.com>
AuthorDate:    Mon, 24 Apr 2023 11:31:55 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 16 May 2023 10:59:28 +01:00

irqchip/mips-gic: Don't touch vl_map if a local interrupt is not routable

When a GIC local interrupt is not routable, it's vl_map will be used
to control some internal states for core (providing IPTI, IPPCI, IPFDC
input signal for core). Overriding it will interfere core's intetrupt
controller.

Do not touch vl_map if a local interrupt is not routable, we are not
going to remap it.

Before dd098a0e0319 (" irqchip/mips-gic: Get rid of the reliance on
irq_cpu_online()"), if a local interrupt is not routable, then it won't
be requested from GIC Local domain, and thus gic_all_vpes_irq_cpu_online
won't be called for that particular interrupt.

Fixes: dd098a0e0319 (" irqchip/mips-gic: Get rid of the reliance on irq_cpu_online()")
Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230424103156.66753-2-jiaxun.yang@flygoat.com
---
 drivers/irqchip/irq-mips-gic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 046c355..b568d55 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -399,6 +399,8 @@ static void gic_all_vpes_irq_cpu_online(void)
 		unsigned int intr = local_intrs[i];
 		struct gic_all_vpes_chip_data *cd;
 
+		if (!gic_local_irq_is_routable(intr))
+			continue;
 		cd = &gic_all_vpes_chip_data[intr];
 		write_gic_vl_map(mips_gic_vx_map_reg(intr), cd->map);
 		if (cd->mask)
