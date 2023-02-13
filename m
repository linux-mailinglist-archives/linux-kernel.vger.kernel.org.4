Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1E26950CF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjBMTkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBMTkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:40:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1107B2D45
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:40:42 -0800 (PST)
Date:   Mon, 13 Feb 2023 19:40:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676317240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L5Rhtrf0D3p15rnvgYR/8EbYl0yHziBxK81V30P0MDg=;
        b=rfi3o/lCRFMKDorA+GLnqsaSnh/XDqNUqJm7lh4+JldLfO3YOqE1TOD4FoyaUPjugyGC12
        MXiWbKl4oOyE8kEN6+dmxSwKYuW9m/XJCV13j+6TH+dqGrmTAc2k/gdlzQDYxnJOxSwr8x
        /AKtcTZOAAirLUO2J++mx6pur8uhzy6zocfdo/h4PbCoiiBA9DNcGXpMpsE5UYJgmoXOyv
        sZfcA/VPeMca6ZobXBYQQz/kOMgkHrv5FigVNztvh19ptQmcDo1RNaI0lCKIA7JLnaqL3P
        TLtVCcpggeTafCPFX2tV6zzNVgtL9SoL7VDn0Whf71SlKKR36McKDgLF4MJndA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676317240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L5Rhtrf0D3p15rnvgYR/8EbYl0yHziBxK81V30P0MDg=;
        b=wpR4eQ/qAKYRIZskmFzR3scZrfKPPdXvbLp2Ya6el2GniqobqG72A2c69LhZdgo7bR55XJ
        H7ICr6WH8SgtmWAg==
From:   "irqchip-bot for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/mvebu-odmi: Use
 irq_domain_create_hierarchy()
Cc:     philmd@linaro.org, "Hsin-Yi Wang" <hsinyi@chromium.org>,
        "Mark-PK Tsai" <mark-pk.tsai@mediatek.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230213104302.17307-20-johan+linaro@kernel.org>
References: <20230213104302.17307-20-johan+linaro@kernel.org>
MIME-Version: 1.0
Message-ID: <167631724001.4906.10785773178715748748.tip-bot2@tip-bot2>
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

Commit-ID:     f743f54fa8d2bcb3f2891b783687d91b76a144f5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/f743f54fa8d2bcb3f2891b783687d91b76a144f5
Author:        Johan Hovold <johan+linaro@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 11:43:01 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 13 Feb 2023 19:31:25=20

irqchip/mvebu-odmi: Use irq_domain_create_hierarchy()

Use the irq_domain_create_hierarchy() helper to create the hierarchical
domain, which both serves as documentation and avoids poking at
irqdomain internals.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230213104302.17307-20-johan+linaro@kernel.o=
rg
---
 drivers/irqchip/irq-mvebu-odmi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odm=
i.c
index dc4145a..1080915 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -161,7 +161,7 @@ static struct msi_domain_info odmi_msi_domain_info =3D {
 static int __init mvebu_odmi_init(struct device_node *node,
 				  struct device_node *parent)
 {
-	struct irq_domain *inner_domain, *plat_domain;
+	struct irq_domain *parent_domain, *inner_domain, *plat_domain;
 	int ret, i;
=20
 	if (of_property_read_u32(node, "marvell,odmi-frames", &odmis_count))
@@ -197,16 +197,17 @@ static int __init mvebu_odmi_init(struct device_node *n=
ode,
 		}
 	}
=20
-	inner_domain =3D irq_domain_create_linear(of_node_to_fwnode(node),
-						odmis_count * NODMIS_PER_FRAME,
-						&odmi_domain_ops, NULL);
+	parent_domain =3D irq_find_host(parent);
+
+	inner_domain =3D irq_domain_create_hierarchy(parent_domain, 0,
+						   odmis_count * NODMIS_PER_FRAME,
+						   of_node_to_fwnode(node),
+						   &odmi_domain_ops, NULL);
 	if (!inner_domain) {
 		ret =3D -ENOMEM;
 		goto err_unmap;
 	}
=20
-	inner_domain->parent =3D irq_find_host(parent);
-
 	plat_domain =3D platform_msi_create_irq_domain(of_node_to_fwnode(node),
 						     &odmi_msi_domain_info,
 						     inner_domain);
