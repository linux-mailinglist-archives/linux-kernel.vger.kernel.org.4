Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3AA6950D3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjBMTk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjBMTkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:40:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81CA3591
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:40:44 -0800 (PST)
Date:   Mon, 13 Feb 2023 19:40:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676317242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKprd8BMHCT+tZac0C1ZgJOLq3dim93vP8Urh1NVMdA=;
        b=Eg4t4pTYr0G2AJ3R8orkjsHioCr1ydS4joen105gYGt9GmuKrer13XSya7nBVeIxC17DLa
        Pr1WkHewLya+zNnwsujtlp8iWPWkYh3wdRySNdU8PtpjpmCEXJlBmrgpfKscdBkr+gYXnk
        SHN85h6EEzJTeDNxoAceaxZYhY76u46FLTaw5DM2jHEYGFhd2OWQY2RHaRDP+G7Up9O8Dw
        15G9o09hAAn3LvSUsp8kRu9Dsy22mYustSgqNAZlX0DeSoC5MQMpu8Y8N0vu1COV65RNRE
        9zIdQb1wQEQf2dK173Skz5ZTRktrUD+ZXAIY4OT5sygwyAz38ZnSnzWzrs8UXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676317242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKprd8BMHCT+tZac0C1ZgJOLq3dim93vP8Urh1NVMdA=;
        b=9rdlBltYdYLVnSPYDcN/rRNLwKG/37Gn4Kh6QuCVO79h+VKB/mJ5VViXWf+UfZIAXJj7Fe
        +ei21ptgv66vNKAQ==
From:   "irqchip-bot for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/alpine-msi: Use
 irq_domain_add_hierarchy()
Cc:     philmd@linaro.org, "Hsin-Yi Wang" <hsinyi@chromium.org>,
        "Mark-PK Tsai" <mark-pk.tsai@mediatek.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230213104302.17307-15-johan+linaro@kernel.org>
References: <20230213104302.17307-15-johan+linaro@kernel.org>
MIME-Version: 1.0
Message-ID: <167631724209.4906.6344400537372680289.tip-bot2@tip-bot2>
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

Commit-ID:     6c889231e04dffa4b668c1f0fbc26db679600147
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/6c889231e04dffa4b668c1f0fbc26db679600147
Author:        Johan Hovold <johan+linaro@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 11:42:56 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 13 Feb 2023 19:31:25=20

irqchip/alpine-msi: Use irq_domain_add_hierarchy()

Use the irq_domain_add_hierarchy() helper to create the hierarchical
domain, which both serves as documentation and avoids poking at
irqdomain internals.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230213104302.17307-15-johan+linaro@kernel.o=
rg
---
 drivers/irqchip/irq-alpine-msi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-ms=
i.c
index 5ddb8e5..6044593 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -204,16 +204,14 @@ static int alpine_msix_init_domains(struct alpine_msix_=
data *priv,
 		return -ENXIO;
 	}
=20
-	middle_domain =3D irq_domain_add_tree(NULL,
-					    &alpine_msix_middle_domain_ops,
-					    priv);
+	middle_domain =3D irq_domain_add_hierarchy(gic_domain, 0, 0, NULL,
+						 &alpine_msix_middle_domain_ops,
+						 priv);
 	if (!middle_domain) {
 		pr_err("Failed to create the MSIX middle domain\n");
 		return -ENOMEM;
 	}
=20
-	middle_domain->parent =3D gic_domain;
-
 	msi_domain =3D pci_msi_create_irq_domain(of_node_to_fwnode(node),
 					       &alpine_msix_domain_info,
 					       middle_domain);
