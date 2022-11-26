Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2B1639626
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 14:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiKZNek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 08:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiKZNed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:34:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E767A19021
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:34:32 -0800 (PST)
Date:   Sat, 26 Nov 2022 13:34:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669469671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtKvSRodCD4bDELoD6KWMF2NZFkks97o1d6spmf95xk=;
        b=MXW/ZWuABsqdDLMLlb2+/i0C6W4rYwTJgmWXumjf8OrTGndigjjy1RtYucYG23W4TYyeXI
        fyKtd5tKLPfGpkFomTGpHC6Q3nPMenqpPMvrJVU/YkMjNTpC1DvbpneOEE/6r6DTVWuKUk
        XDZWBWkauuuSxp35rvQPJThYUWL0KSSjnl/5TGlV9t/Ndz+VqpjLmnegFv9toB5lwnAok+
        Trk68aTIQ3AqBkaSkO6fd0xbleOszKsoZjcnhBRLhx/KXLnLxRO4C8S1LtcAFOBrWEVgfg
        nprii3M5yygjywfLoFi8AH1jed3yht49HH8YkCGuALq1Y42wNADLuWn5TMak2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669469671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtKvSRodCD4bDELoD6KWMF2NZFkks97o1d6spmf95xk=;
        b=f88uVwfqe6jADfJ4zDJxhh9BYHgzwwAiq1oOM+lvT2r5la7gwV7BW/F8e2u55sqlXO+fDN
        2uN/x1kZvT10hVAA==
From:   "irqchip-bot for ye xingchen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/st: Use device_get_match_data()
 to simplify the code
Cc:     ye xingchen <ye.xingchen@zte.com.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <202211171916504943604@zte.com.cn>
References: <202211171916504943604@zte.com.cn>
MIME-Version: 1.0
Message-ID: <166946967037.4906.1264875949138742444.tip-bot2@tip-bot2>
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

Commit-ID:     4e08a286b1f7a0a32828d6411255296e4ef51fa6
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4e08a286b1f7a0a32828d6411255296e4ef51fa6
Author:        ye xingchen <ye.xingchen@zte.com.cn>
AuthorDate:    Thu, 17 Nov 2022 19:16:50 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 26 Nov 2022 13:29:42 

irqchip/st: Use device_get_match_data() to simplify the code

Directly get the match data with device_get_match_data().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/202211171916504943604@zte.com.cn
---
 drivers/irqchip/irq-st.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-st.c b/drivers/irqchip/irq-st.c
index 801551e..1b83512 100644
--- a/drivers/irqchip/irq-st.c
+++ b/drivers/irqchip/irq-st.c
@@ -153,18 +153,13 @@ static int st_irq_syscfg_enable(struct platform_device *pdev)
 static int st_irq_syscfg_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *match;
 	struct st_irq_syscfg *ddata;
 
 	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
 
-	match = of_match_device(st_irq_syscfg_match, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
-	ddata->syscfg = (unsigned int)match->data;
+	ddata->syscfg = (unsigned int) device_get_match_data(&pdev->dev);
 
 	ddata->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
 	if (IS_ERR(ddata->regmap)) {
