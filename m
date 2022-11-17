Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E764462DF37
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbiKQPKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbiKQPJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:09:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456FF781AA;
        Thu, 17 Nov 2022 07:08:21 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697700;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=22RMjeZ9ETKCP9UZiZ2z3rOsKYgMh4RjNDTkJH0aR3c=;
        b=Mp/a9P6LVFh0takYrqkM4/abV5yexzDPwHvVRU3sYX/Yb/13ktZscNF8aL8sJiOHuA4B6F
        yqev8qnBVuBVFKE3jv8JUBymuL1pQeEyAWwGvJj4OQgDuJrDON3yNwQOB4n9hxNG8R2S0t
        MIEKMa4TC2MOxVPJ/yyL+nX1nq3L9TrIlgVxM+CFxKLVXR6/p2DW6Ws/flIvc+tf3fcNH+
        EloEKNfsJ2aZKj66ghRjcsZNyJURI+1PRkUU4RJ5+7KWmpyTOpLwPDM6h5el6+wOrBJ8qt
        KeQBtO4mj1RZwvCdZeOYxn1R1G4SQ7G9Qb5Mpj81Jg7A0QjuYlXo1ooMFiVqsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697700;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=22RMjeZ9ETKCP9UZiZ2z3rOsKYgMh4RjNDTkJH0aR3c=;
        b=3gwOjgQ1N3Sp+hKyG7CNtBiNWlCUngZNHKRPmN3wWRy4ti4IGWWxzEwfL0cB6Ql/6kOAqc
        lbkKFwScxlFK9DBQ==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Let the MSI core free descriptors
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122014.409654736@linutronix.de>
References: <20221111122014.409654736@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869769869.4906.16348702206591791978.tip-bot2@tip-bot2>
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

Commit-ID:     b2bdda205c0c256d6483231d0afe58a6d68fd3ed
Gitweb:        https://git.kernel.org/tip/b2bdda205c0c256d6483231d0afe58a6d68fd3ed
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:19 +01:00

PCI/MSI: Let the MSI core free descriptors

Let the core do the freeing of descriptors and just keep it around for the
legacy case.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122014.409654736@linutronix.de

---
 drivers/pci/msi/irqdomain.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 7766fa6..edd0cc2 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -24,11 +24,12 @@ void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
 	struct irq_domain *domain;
 
 	domain = dev_get_msi_domain(&dev->dev);
-	if (domain && irq_domain_is_hierarchy(domain))
+	if (domain && irq_domain_is_hierarchy(domain)) {
 		msi_domain_free_irqs_descs_locked(domain, &dev->dev);
-	else
+	} else {
 		pci_msi_legacy_teardown_msi_irqs(dev);
-	msi_free_msi_descs(&dev->dev);
+		msi_free_msi_descs(&dev->dev);
+	}
 }
 
 /**
@@ -170,6 +171,9 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		pci_msi_domain_update_chip_ops(info);
 
+	/* Let the core code free MSI descriptors when freeing interrupts */
+	info->flags |= MSI_FLAG_FREE_MSI_DESCS;
+
 	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS;
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
 		info->flags |= MSI_FLAG_MUST_REACTIVATE;
