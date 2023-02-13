Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155346950D1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjBMTkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjBMTko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:40:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F26B40FD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:40:42 -0800 (PST)
Date:   Mon, 13 Feb 2023 19:40:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676317241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yejs4r5Jd11TylWqptUJ2acsbmgTrASwGGRsqi9QYT0=;
        b=akOwMFnCqPFdcNK6HgMPZhXYNk5qpkp1pB/RNfiyf/5vkt4l5BpyNU+4r8GVLzo6YrCT50
        KCeV/l0oAaxZaGvx53FEH4r50b4st2dTHvys5lRHnljL9wnIYZKCm1FrQ7KogVdK/Rk8Ha
        k+ovn80pqhS2sfsHN7SmCWeSiASQ18NS1oP1wADP8yS5oJbJpk+WOaQedy+hmnNscPZOfI
        zlpTqINogOntAyRebCYadD80BJEvf4ir2gym+U9WTxqQm+Pgdgi9cMLwPyhkYsG8oZ0fxz
        nc6NJQ2fRwZyk/tvAXU+m8PcXCYsu+m3SqrNg28Hgu6solTp6VzfJCPNuR7lvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676317241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yejs4r5Jd11TylWqptUJ2acsbmgTrASwGGRsqi9QYT0=;
        b=YtNTfiyAZKjiAdHq33iCzS64AQgR7J/cvS1lfDWmke2pLVwMbXAhMvblmZyqIYiNochnFZ
        sGFwJ6yxxAWFdoBA==
From:   "irqchip-bot for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3-mbi: Use
 irq_domain_create_hierarchy()
Cc:     philmd@linaro.org, "Hsin-Yi Wang" <hsinyi@chromium.org>,
        "Mark-PK Tsai" <mark-pk.tsai@mediatek.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230213104302.17307-18-johan+linaro@kernel.org>
References: <20230213104302.17307-18-johan+linaro@kernel.org>
MIME-Version: 1.0
Message-ID: <167631724086.4906.11073030505305528659.tip-bot2@tip-bot2>
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

Commit-ID:     331f9aac03267f76a15776260eda4f47b81731f7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/331f9aac03267f76a15776260eda4f47b81731f7
Author:        Johan Hovold <johan+linaro@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 11:42:59 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 13 Feb 2023 19:31:25=20

irqchip/gic-v3-mbi: Use irq_domain_create_hierarchy()

Use the irq_domain_create_hierarchy() helper to create the hierarchical
domain, which both serves as documentation and avoids poking at
irqdomain internals.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230213104302.17307-18-johan+linaro@kernel.o=
rg
---
 drivers/irqchip/irq-gic-v3-mbi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mb=
i.c
index e1efdec..dbb8b1e 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -233,13 +233,12 @@ static int mbi_allocate_domains(struct irq_domain *pare=
nt)
 	struct irq_domain *nexus_domain, *pci_domain, *plat_domain;
 	int err;
=20
-	nexus_domain =3D irq_domain_create_tree(parent->fwnode,
-					      &mbi_domain_ops, NULL);
+	nexus_domain =3D irq_domain_create_hierarchy(parent, 0, 0, parent->fwnode,
+						   &mbi_domain_ops, NULL);
 	if (!nexus_domain)
 		return -ENOMEM;
=20
 	irq_domain_update_bus_token(nexus_domain, DOMAIN_BUS_NEXUS);
-	nexus_domain->parent =3D parent;
=20
 	err =3D mbi_allocate_pci_domain(nexus_domain, &pci_domain);
=20
