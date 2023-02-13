Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9116950D5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjBMTlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjBMTkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:40:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C6640FD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:40:45 -0800 (PST)
Date:   Mon, 13 Feb 2023 19:40:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676317243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bMoSI9lBoZIk1jDphkMK/y9E/cpGLC8SwZdmQ+X+vUE=;
        b=qbvd/oKosRCh8muKdQE7Hu9U2+Tm/IA64ut8B4KoZ3WRyfiD7dynHKAm97bJOxn9O7nzDK
        s7UtgmEJfVIxY+m9enICc3PJXsKje7ugivyjdqrjW1qOV3yVQK6wvHKcFinFosqr9uJ//a
        /z/1NAD0nldpd6wLvlYp3iy0hk8b+qoUzE9VPTqpvZu5eZkKAuPND+K3IEHEoIHmUEXaLy
        RLCnwf1aE11GStSz5Exkgp5RXUztH/Ye5yn5vQgRVo+8CZNQ2EAt/11HfGFI164/xZw1BK
        SC++lYJTetaZcm1glS7DC9pyKWJUtd/VXF0I0Wje00n9+ho+zb/Vz4L9vr9m9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676317243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bMoSI9lBoZIk1jDphkMK/y9E/cpGLC8SwZdmQ+X+vUE=;
        b=5xfC302NkT77P2SSIbkBHYUtbBDSgbaStSJ6R2Cov2eYQ4VtWr+Bfww9m66kXGtr2SHwzi
        g9Zqf9PFPXKj6EBA==
From:   "irqchip-bot for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] x86/ioapic: Use irq_domain_create_hierarchy()
Cc:     philmd@linaro.org, "Hsin-Yi Wang" <hsinyi@chromium.org>,
        "Mark-PK Tsai" <mark-pk.tsai@mediatek.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230213104302.17307-13-johan+linaro@kernel.org>
References: <20230213104302.17307-13-johan+linaro@kernel.org>
MIME-Version: 1.0
Message-ID: <167631724340.4906.2367219782505743568.tip-bot2@tip-bot2>
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

Commit-ID:     bc1bc1b309b42ff3faea957df7ac9382366c5eef
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/bc1bc1b309b42ff3faea957df7ac9382366c5eef
Author:        Johan Hovold <johan+linaro@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 11:42:54 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 13 Feb 2023 19:31:24=20

x86/ioapic: Use irq_domain_create_hierarchy()

Use the irq_domain_create_hierarchy() helper to create the hierarchical
domain, which both serves as documentation and avoids poking at
irqdomain internals.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230213104302.17307-13-johan+linaro@kernel.o=
rg
---
 arch/x86/kernel/apic/io_apic.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index a868b76..1f83b05 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2364,9 +2364,8 @@ static int mp_irqdomain_create(int ioapic)
 		return -ENODEV;
 	}
=20
-	ip->irqdomain =3D irq_domain_create_linear(fn, hwirqs, cfg->ops,
-						 (void *)(long)ioapic);
-
+	ip->irqdomain =3D irq_domain_create_hierarchy(parent, 0, hwirqs, fn, cfg->o=
ps,
+						    (void *)(long)ioapic);
 	if (!ip->irqdomain) {
 		/* Release fw handle if it was allocated above */
 		if (!cfg->dev)
@@ -2374,8 +2373,6 @@ static int mp_irqdomain_create(int ioapic)
 		return -ENOMEM;
 	}
=20
-	ip->irqdomain->parent =3D parent;
-
 	if (cfg->type =3D=3D IOAPIC_DOMAIN_LEGACY ||
 	    cfg->type =3D=3D IOAPIC_DOMAIN_STRICT)
 		ioapic_dynirq_base =3D max(ioapic_dynirq_base,
