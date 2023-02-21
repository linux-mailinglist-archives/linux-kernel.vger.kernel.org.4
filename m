Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4928369DB3D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjBUHc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBUHcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:32:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630D2469D;
        Mon, 20 Feb 2023 23:32:54 -0800 (PST)
Date:   Tue, 21 Feb 2023 07:32:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676964772;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sK/GFG6TYUaoyd+Hu4W1xz3mUYUg+OSib2U1QooR/hU=;
        b=pgpVmXPLBaBQMKI1dxvWTGgMUL5JDGJGErOJihDeN0RU6+b3/jAPpSMxRa8ZD6/yv0y/h6
        yt7C/Y5A1ZMR1p3BzYErhsy5ohWSDyVATx7W6V0/oKKjxWTOvhQ6NELuWd7gRrdDb54y2O
        2yFCxQgP173S40t57TVuNgTrqYUR0bc5cmgWvlouab5RUx6o+FxGMlCe+Jp7rmqAGrfyi+
        WZYXPA8zCGHra5z5UstPuNgeuPJ1Q+1gS4iLFSpPuXHQw6v4hgrdJ8YhLFT/ZikvEqWq7q
        ivZMjDtET3oZEUkPqlPREO7AxsUv3+UiQiGy866lUmc5iDwQctKQLzl2wAP8Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676964772;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sK/GFG6TYUaoyd+Hu4W1xz3mUYUg+OSib2U1QooR/hU=;
        b=xl0ROWaldX359j0Ubv2eha0jFK6LXedn7duiUmuUnIQck/YDxzGrRbr1hn6IMybJvIQhqy
        XD4bNyd2kRkk8FBw==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] PCI/MSI: Clarify usage of pci_msix_free_irq()
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <87r0xsd8j4.ffs@tglx>
References: <87r0xsd8j4.ffs@tglx>
MIME-Version: 1.0
Message-ID: <167696477130.387.8165200996017804708.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     e6cc6f175566dd21a3f6e384c24593b1c751dd74
Gitweb:        https://git.kernel.org/tip/e6cc6f175566dd21a3f6e384c24593b1c751dd74
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 14 Feb 2023 13:13:20 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 21 Feb 2023 08:25:14 +01:00

PCI/MSI: Clarify usage of pci_msix_free_irq()

pci_msix_free_irq() is used to free an interrupt on a PCI/MSI-X interrupt
domain.

The API description specifies that the interrupt to be freed was allocated
via pci_msix_alloc_irq_at().  This description limits the usage of
pci_msix_free_irq() since pci_msix_free_irq() can also be used to free
MSI-X interrupts allocated with, for example, pci_alloc_irq_vectors().

Remove the text stating that the interrupt to be freed had to be allocated
with pci_msix_alloc_irq_at(). The needed struct msi_map need not be from
pci_msix_alloc_irq_at() but can be created from scratch using
pci_irq_vector() to obtain the Linux IRQ number. Highlight that
pci_msix_free_irq() cannot be used to disable MSI-X to guide users that,
for example, pci_free_irq_vectors() remains to be needed.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/lkml/87r0xsd8j4.ffs@tglx
Link: https://lore.kernel.org/r/4c3e7a50d6e70f408812cd7ab199c6b4b326f9de.1676408572.git.reinette.chatre@intel.com
---
 drivers/pci/msi/api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index b8009aa..be679aa 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -163,11 +163,11 @@ EXPORT_SYMBOL_GPL(pci_msix_alloc_irq_at);
 
 /**
  * pci_msix_free_irq - Free an interrupt on a PCI/MSIX interrupt domain
- *		      which was allocated via pci_msix_alloc_irq_at()
  *
  * @dev:	The PCI device to operate on
  * @map:	A struct msi_map describing the interrupt to free
- *		as returned from the allocation function.
+ *
+ * Undo an interrupt vector allocation. Does not disable MSI-X.
  */
 void pci_msix_free_irq(struct pci_dev *dev, struct msi_map map)
 {
