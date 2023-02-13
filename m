Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F7D6950CE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjBMTko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBMTkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:40:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2FA40F3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:40:42 -0800 (PST)
Date:   Mon, 13 Feb 2023 19:40:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676317240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8PziP73urOkveqr8d0J8Qe0rv+ffjkFUHyRQ0oY9LE=;
        b=FpxbEwvxMVz1TcdBXh1o0lKIYi4HTYJseaBbMvn5Uhoe1PaAsMEIoFQTL7mw6j5XIQ+RA+
        65JBTc1uDLSyQLbQAK9m+4pO61V84b1n5PXiQswU7tXIDEdmU/VSyXOhtI+e18dsda7gX/
        8ddkaHi94GjvEWcG7AsSKMNePciQ13wvjJpkoS9NAwcriuSnZHLqu8yxDldGz973Xwc0h5
        RJ2m1owGgNo88Ux/J65SBNCHtxneLNm+f6ZRHeO0oc2TkIQb2IP+Gs3ZsP7lNQUv0sltjE
        4ggHOOWFyhE3e2/qZgYXOFbSlDeKnsEDyEHylDTCOGiE/zBYl6xPuy8AkN49Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676317240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8PziP73urOkveqr8d0J8Qe0rv+ffjkFUHyRQ0oY9LE=;
        b=ZymUIJZFoLOsEgVWheioMHPGm8k5XVCxIdvvtBim+/pHUz2IjJ3yUgNyLygghshD+xqk7x
        90TkCVyOq5PHfgCg==
From:   "irqchip-bot for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-pch-msi: Use
 irq_domain_create_hierarchy()
Cc:     philmd@linaro.org, "Hsin-Yi Wang" <hsinyi@chromium.org>,
        "Mark-PK Tsai" <mark-pk.tsai@mediatek.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230213104302.17307-19-johan+linaro@kernel.org>
References: <20230213104302.17307-19-johan+linaro@kernel.org>
MIME-Version: 1.0
Message-ID: <167631724043.4906.10036207360902032588.tip-bot2@tip-bot2>
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

Commit-ID:     6159c470f812eab0a2f1900c70acbb3ca7b9e14a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/6159c470f812eab0a2f1900c70acbb3ca7b9e14a
Author:        Johan Hovold <johan+linaro@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 11:43:00 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 13 Feb 2023 19:31:25=20

irqchip/loongson-pch-msi: Use irq_domain_create_hierarchy()

Use the irq_domain_create_hierarchy() helper to create the hierarchical
domain, which both serves as documentation and avoids poking at
irqdomain internals.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230213104302.17307-19-johan+linaro@kernel.o=
rg
---
 drivers/irqchip/irq-loongson-pch-msi.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loo=
ngson-pch-msi.c
index a72ede9..6e1e1f0 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -163,16 +163,15 @@ static int pch_msi_init_domains(struct pch_msi_data *pr=
iv,
 {
 	struct irq_domain *middle_domain, *msi_domain;
=20
-	middle_domain =3D irq_domain_create_linear(domain_handle,
-						priv->num_irqs,
-						&pch_msi_middle_domain_ops,
-						priv);
+	middle_domain =3D irq_domain_create_hierarchy(parent, 0, priv->num_irqs,
+						    domain_handle,
+						    &pch_msi_middle_domain_ops,
+						    priv);
 	if (!middle_domain) {
 		pr_err("Failed to create the MSI middle domain\n");
 		return -ENOMEM;
 	}
=20
-	middle_domain->parent =3D parent;
 	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
=20
 	msi_domain =3D pci_msi_create_irq_domain(domain_handle,
