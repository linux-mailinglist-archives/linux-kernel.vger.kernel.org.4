Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C693164304A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiLES2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiLESZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12568209AE;
        Mon,  5 Dec 2022 10:25:20 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264718;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pX2/qOgZq5Yg08sJdrujsquSTuwr0j4Kdkeg8SlK+tc=;
        b=OAq93nUYn3iXhUm91fRg4mHKvCzeQ9EBF0lUlgjXAASF8+W4ohc6DLpb4PGYEgOyyKuG7A
        sinHvqVjvsqAEwqm+3B3edrYd3dmLC+0IJ/sT5DmlfgXypmGVUjXqJVG5eBOxRIyuIMvya
        HL5fAv1ae0w9M/YzzxbalAZ/eXbE/KpIJDu+GDoPtF2NOuoeLT64qGlUOvsFMegr4FxTc+
        X39K39UUwdiIxFxlOtvyGquglStFOjCHwji3iAM75DbD511XJhSv+1T008AX7SyZn1YtNp
        4WhNqKjHCHBhI78bQQZramqfAC4MnZaQxvM1wfg+p8EG06bK2AfYCjH/raCp2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264718;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pX2/qOgZq5Yg08sJdrujsquSTuwr0j4Kdkeg8SlK+tc=;
        b=5IuFpocrQQphNNlNMHLLBp1hPk97Hw46WliL0LE8vfWl7LhZ8DoOeSVO1IZ8ON47LoS6fY
        Qp7I/1m+cuIqIlAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Use msi_domain_alloc/free_irqs_all_locked()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230314.455168748@linutronix.de>
References: <20221124230314.455168748@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471835.4906.6881064994595629521.tip-bot2@tip-bot2>
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

Commit-ID:     d3a11dee9f946daa6e66aca1bf8db93e9d4e02ec
Gitweb:        https://git.kernel.org/tip/d3a11dee9f946daa6e66aca1bf8db93e9d4e02ec
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:00 +01:00

PCI/MSI: Use msi_domain_alloc/free_irqs_all_locked()

Switch to the new domain id aware interfaces to phase out the previous
ones. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230314.455168748@linutronix.de

---
 drivers/pci/msi/irqdomain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index dea2e8c..f4338fb 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -14,7 +14,7 @@ int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 
 	domain = dev_get_msi_domain(&dev->dev);
 	if (domain && irq_domain_is_hierarchy(domain))
-		return msi_domain_alloc_irqs_descs_locked(domain, &dev->dev, nvec);
+		return msi_domain_alloc_irqs_all_locked(&dev->dev, MSI_DEFAULT_DOMAIN, nvec);
 
 	return pci_msi_legacy_setup_msi_irqs(dev, nvec, type);
 }
@@ -25,7 +25,7 @@ void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
 
 	domain = dev_get_msi_domain(&dev->dev);
 	if (domain && irq_domain_is_hierarchy(domain)) {
-		msi_domain_free_irqs_descs_locked(domain, &dev->dev);
+		msi_domain_free_irqs_all_locked(&dev->dev, MSI_DEFAULT_DOMAIN);
 	} else {
 		pci_msi_legacy_teardown_msi_irqs(dev);
 		msi_free_msi_descs(&dev->dev);
