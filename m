Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120BF69BA6D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 15:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBRO2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 09:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBRO2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 09:28:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C1315CBA
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 06:28:36 -0800 (PST)
Date:   Sat, 18 Feb 2023 14:28:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676730513;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYf8cdQX1+qWLhAT0OWbBu0XyR2VvktlZhwh5Ldum5I=;
        b=cZcwsny+fQZgJoMJ4M3Ps4x1/u/Fki14JvAiARAyJ7vB7fkasRfqhtEVol3mO9W6xPnePn
        3Gpl2XYGZPCpztbTrUHI/4WSq8mUpsHINFDiQdcC+edmKOzuvrNOSQ4n642nu85vkHAPtp
        VpEWt4Na+dpxDtcFkrFvsQxZAoVGo6PbEKJ/sGLnmTG//bAilL1EFyT6KyhV5p+yOUzcng
        QYMUh+HE6sQPqY9Zeq125XQ2dDpo9Mf7ZYKfjiLdxVamG/kCgKwrbmQSJqezeEwNkX2tbP
        PX9ySlMZWE3Srx9GJnZ4XiftBDKa6mOpLOBpet6kKS25xeIFLRkMZDAGk1IonQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676730513;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYf8cdQX1+qWLhAT0OWbBu0XyR2VvktlZhwh5Ldum5I=;
        b=LQK6ToFdPcEwQ/Hje+PZDkWeSuPReN23GQkeHcvIsFAjk/sBc9JW3g973uBKbLMDr7Bjqi
        vHxAtuekm5kgWHDg==
From:   "irqchip-bot for Florian Fainelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-brcmstb-l2: Set IRQ_LEVEL for
 level triggered interrupts
Cc:     Florian Fainelli <f.fainelli@gmail.com>, philmd@linaro.org,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221216230934.2478345-2-f.fainelli@gmail.com>
References: <20221216230934.2478345-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <167673051321.4906.7043097380956478723.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqc=
hip:

Commit-ID:     94debe03e8afa1267f95a9001786a6aa506b9ff3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/94debe03e8afa1267f95a9001786a6aa506b9ff3
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Fri, 16 Dec 2022 15:09:33 -08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 18 Feb 2023 14:23:41=20

irqchip/irq-brcmstb-l2: Set IRQ_LEVEL for level triggered interrupts

When support for the level triggered interrupt controller flavor was
added with c0ca7262088e, we forgot to update the flags to be set to
contain IRQ_LEVEL. While the flow handler is correct, the output from
/proc/interrupts does not show such interrupts as being level triggered
when they are, correct that.

Fixes: c0ca7262088e ("irqchip/brcmstb-l2: Add support for the BCM7271 L2 cont=
roller")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221216230934.2478345-2-f.fainelli@gmail.com
---
 drivers/irqchip/irq-brcmstb-l2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l=
2.c
index e4efc08..091b0fe 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -161,6 +161,7 @@ static int __init brcmstb_l2_intc_of_init(struct device_n=
ode *np,
 					  *init_params)
 {
 	unsigned int clr =3D IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
+	unsigned int set =3D 0;
 	struct brcmstb_l2_intc_data *data;
 	struct irq_chip_type *ct;
 	int ret;
@@ -208,9 +209,12 @@ static int __init brcmstb_l2_intc_of_init(struct device_=
node *np,
 	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
 		flags |=3D IRQ_GC_BE_IO;
=20
+	if (init_params->handler =3D=3D handle_level_irq)
+		set |=3D IRQ_LEVEL;
+
 	/* Allocate a single Generic IRQ chip for this node */
 	ret =3D irq_alloc_domain_generic_chips(data->domain, 32, 1,
-			np->full_name, init_params->handler, clr, 0, flags);
+			np->full_name, init_params->handler, clr, set, flags);
 	if (ret) {
 		pr_err("failed to allocate generic irq chip\n");
 		goto out_free_domain;
