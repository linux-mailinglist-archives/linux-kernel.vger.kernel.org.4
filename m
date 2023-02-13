Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834416950D4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjBMTlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBMTkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:40:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D567B2D45
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:40:44 -0800 (PST)
Date:   Mon, 13 Feb 2023 19:40:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676317242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1S1Dz0ByLRMsB0U0GV2ttWHCRwrFTBxICcN2ewQNEE=;
        b=Q5YumtOefpPJWoXEgKDGJ1i0Re4rTfEHboH7XB16ambEif7rS6qXNyiCZIXq1XbkPN7thp
        5PT8LKzWviOIKxZEBh8lxxUdsPupfAoocnJS4CWeQz6EIxqNVYfTzEY/W4t0RhcLhsU9y7
        CJAMG6RJT/dz+10OMn/vX1Ol6fTJSE493eSXfZF37EMgzuD/8nYnNR2ovcVL6TIGHUvGnv
        yBoAfQgE+tpvxiR2HGuRu14qWjMoIpGesPGK4IlGr4iHbj2RPvCj5ZiP2aM5pnkVbu8izP
        puJuqJf1Jc3zkaQpo71kTvM4jXZeyBjqjUXj9bav5JdvsFGbn02H6aP2xyNNlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676317242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1S1Dz0ByLRMsB0U0GV2ttWHCRwrFTBxICcN2ewQNEE=;
        b=+CWDFGiFZaQuHl7bEiS12OYauKvFJenA2Jj4kcdzgWP+kHS8D5zqvS1hDtFWSwfWm5n6dq
        o5dyUry6+5unBeAw==
From:   "irqchip-bot for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v2m: Use
 irq_domain_create_hierarchy()
Cc:     philmd@linaro.org, "Hsin-Yi Wang" <hsinyi@chromium.org>,
        "Mark-PK Tsai" <mark-pk.tsai@mediatek.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230213104302.17307-16-johan+linaro@kernel.org>
References: <20230213104302.17307-16-johan+linaro@kernel.org>
MIME-Version: 1.0
Message-ID: <167631724169.4906.3719073247835646249.tip-bot2@tip-bot2>
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

Commit-ID:     e6e8cd62a56f9ed0dcdf8d01147709b59a111418
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/e6e8cd62a56f9ed0dcdf8d01147709b59a111418
Author:        Johan Hovold <johan+linaro@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 11:42:57 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 13 Feb 2023 19:31:25=20

irqchip/gic-v2m: Use irq_domain_create_hierarchy()

Use the irq_domain_create_hierarchy() helper to create the hierarchical
domain, which both serves as documentation and avoids poking at
irqdomain internals.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230213104302.17307-16-johan+linaro@kernel.o=
rg
---
 drivers/irqchip/irq-gic-v2m.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index f4d7eeb..f1e75b3 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -287,15 +287,14 @@ static __init int gicv2m_allocate_domains(struct irq_do=
main *parent)
 	if (!v2m)
 		return 0;
=20
-	inner_domain =3D irq_domain_create_tree(v2m->fwnode,
-					      &gicv2m_domain_ops, v2m);
+	inner_domain =3D irq_domain_create_hierarchy(parent, 0, 0, v2m->fwnode,
+						   &gicv2m_domain_ops, v2m);
 	if (!inner_domain) {
 		pr_err("Failed to create GICv2m domain\n");
 		return -ENOMEM;
 	}
=20
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
-	inner_domain->parent =3D parent;
 	pci_domain =3D pci_msi_create_irq_domain(v2m->fwnode,
 					       &gicv2m_msi_domain_info,
 					       inner_domain);
