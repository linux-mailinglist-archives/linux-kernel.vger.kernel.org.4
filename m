Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EE862DF3A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbiKQPKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239492AbiKQPJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:09:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9009781B0;
        Thu, 17 Nov 2022 07:08:22 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697701;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dHx44bw9gOAKcRiej7C0sHzGPZuS6ci+wmSucl6EQN8=;
        b=gRi9L4gSYIymFdAFxTkx7/fEpeIO57MRGzMQPpJnNgeET/WR2wyneNzk0dw+wc4BVicxjl
        ny4jF+t6qN5zhUvHPQa5ONq5ycc7WttLSMfP4eWulHN9fOEEcCPZPacZOi8+2cRhHa7+V5
        E12JhvGJC4caizs3V77h8AifEmgCBFDuwZf0RCV5Rey7TtaHyo88ejIrSskGCizA6asNMg
        m4R15CISq7yMuvtN02tRIQ7TuzzXYgsriTid3TzyikkiRwUi+TAiJL2U2GMq39W2SlXodA
        ++h0q/bsl5UNYUvvhWabrVFLRxY9RguhUvvDmSZreVrHQsfle6cTc5wtUhrJAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697701;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dHx44bw9gOAKcRiej7C0sHzGPZuS6ci+wmSucl6EQN8=;
        b=E3ScY126KN3X3to8lIb0thA87sip0/+ZlD9M9PLx2KlmBJY3QIiJpqn8kkvMhOY01aI26e
        3PcHUf8nifaandAg==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Use msi_domain_info:: Bus_token
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122014.352437595@linutronix.de>
References: <20221111122014.352437595@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869769975.4906.9057339878445768964.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     38c0c10ae6a3d386c50e182227f606d8243124b8
Gitweb:        https://git.kernel.org/tip/38c0c10ae6a3d386c50e182227f606d8243124b8
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:19 +01:00

PCI/MSI: Use msi_domain_info:: Bus_token

Set the bus token in the msi_domain_info structure and let the core code
handle the update.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122014.352437595@linutronix.de

---
 drivers/pci/msi/irqdomain.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index e9cf318..7766fa6 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -162,8 +162,6 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent)
 {
-	struct irq_domain *domain;
-
 	if (WARN_ON(info->flags & MSI_FLAG_LEVEL_CAPABLE))
 		info->flags &= ~MSI_FLAG_LEVEL_CAPABLE;
 
@@ -178,13 +176,10 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 
 	/* PCI-MSI is oneshot-safe */
 	info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
+	/* Let the core update the bus token */
+	info->bus_token = DOMAIN_BUS_PCI_MSI;
 
-	domain = msi_create_irq_domain(fwnode, info, parent);
-	if (!domain)
-		return NULL;
-
-	irq_domain_update_bus_token(domain, DOMAIN_BUS_PCI_MSI);
-	return domain;
+	return msi_create_irq_domain(fwnode, info, parent);
 }
 EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
 
