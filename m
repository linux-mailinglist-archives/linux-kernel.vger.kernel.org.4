Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9FD643730
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiLEVnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiLEVlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:41:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC2D2CE00;
        Mon,  5 Dec 2022 13:41:54 -0800 (PST)
Date:   Mon, 05 Dec 2022 21:41:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670276509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLhMP5Asx5mSCrOl2a/7yOsTV/2KgEfBxWjPjSR9Fsc=;
        b=KmgZVcNbQJY5DGW8wQZ15wZa3ZDOIjAMJ5UKp4wNKB7r0HmsPlqv+JeRXkmTwpOXDwXqCw
        fZYxVRFsXkyPANMpu0RH/aOWULtiVrQ1r9NaSzAXv6k1FhMT0ivWasAQi6krVEP6OXYF27
        BeDdbjMllgAd5QkRX7TdqjFwetmwEyozSBxK31ymYrTBHuRKi1iziCvxJ0luOq8+iESVCj
        +RGs4V1WWIhfQgub9fIwZyPc4mEkcwKTHYleqdb/txoQfDm0GolTJ+ZtmwQBiCsEUWAm4L
        2gwKrMV2LveLAc0vJddUeh84HmZJIY9DDpv8sgls81noaKwhWYMLKqEXLJAaWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670276509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLhMP5Asx5mSCrOl2a/7yOsTV/2KgEfBxWjPjSR9Fsc=;
        b=dHvKe14zTf/+4TzUqk8cJCWx/y92LL9WsKBCeMQM3BRY/fSqevaW8j91rGYT3YbBoDEjC4
        k/6fLILJ8RW+vuBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Provide BUS_DEVICE_PCI_MSI[X]
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232325.917219885@linutronix.de>
References: <20221124232325.917219885@linutronix.de>
MIME-Version: 1.0
Message-ID: <167027650962.4906.16480071733692228693.tip-bot2@tip-bot2>
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

Commit-ID:     bd141a3db40c877e01de8e981edb57c03199d876
Gitweb:        https://git.kernel.org/tip/bd141a3db40c877e01de8e981edb57c03199d876
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:02 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 22:22:32 +01:00

genirq/msi: Provide BUS_DEVICE_PCI_MSI[X]

Provide new bus tokens for the upcoming per device PCI/MSI and PCI/MSIX
interrupt domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232325.917219885@linutronix.de

---
 include/linux/irqdomain_defs.h | 2 ++
 kernel/irq/msi.c               | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/irqdomain_defs.h b/include/linux/irqdomain_defs.h
index 69035b4..b3f4b7e 100644
--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -21,6 +21,8 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_TI_SCI_INTA_MSI,
 	DOMAIN_BUS_WAKEUP,
 	DOMAIN_BUS_VMD_MSI,
+	DOMAIN_BUS_PCI_DEVICE_MSI,
+	DOMAIN_BUS_PCI_DEVICE_MSIX,
 };
 
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index ae58692..0749e66 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1118,6 +1118,8 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
 
 	switch(domain->bus_token) {
 	case DOMAIN_BUS_PCI_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
 	case DOMAIN_BUS_VMD_MSI:
 		break;
 	default:
@@ -1143,6 +1145,8 @@ static int msi_handle_pci_fail(struct irq_domain *domain, struct msi_desc *desc,
 {
 	switch(domain->bus_token) {
 	case DOMAIN_BUS_PCI_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
 	case DOMAIN_BUS_VMD_MSI:
 		if (IS_ENABLED(CONFIG_PCI_MSI))
 			break;
