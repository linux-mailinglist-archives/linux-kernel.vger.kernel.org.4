Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE7064302B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiLES0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiLESZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440C620F45;
        Mon,  5 Dec 2022 10:25:18 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264715;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mS2z3b1y3oW5O40MVtW9w5wdKrzGp1O/sZM27wOFk5Q=;
        b=C15yrtmrQ9pgiKsmzajfvnnQVojxw/4ut3qjQnrf1DgW0GPXRzfpt5Es0G11NUsgCwItsp
        uJihySnM3eGpwRWH2AE2OkTH/YTf/hKA1CHt1MJyFa2oOp9Q2vafNn62hNyVcJ6cTLowEG
        Q1/KUt3/n46wMYaPW2IyrtKsrFNVUY0FEpLI8kVaniJf1DTbiSph+C0X+aAr3m8/CfRf+v
        RqB5z5lLv9H3fnoX6J84XtqFP6X2jAO+r3cnt0svhcwjqxpYKi1Nr9gv1jFdkcExY40H/+
        ctL/p879IRPWJIFd6j8RbjJyJUsmee61wsMsdN4uKpXDz/vdqGKVK9jv6fvOkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264715;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mS2z3b1y3oW5O40MVtW9w5wdKrzGp1O/sZM27wOFk5Q=;
        b=2rBB+mQ+tyRcL1GpeP4z4pGPLAhX1GZUTDD4T2O8w03ZuDZN0De0jG0ECgiTV2Pv9zsRvS
        pEnZIAvZQWSb9JDA==
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
Message-ID: <167026471489.4906.12113430843446895413.tip-bot2@tip-bot2>
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

Commit-ID:     29b2f2cfd3f1fd3638799671c3a6758e13943875
Gitweb:        https://git.kernel.org/tip/29b2f2cfd3f1fd3638799671c3a6758e13943875
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:02 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:02 +01:00

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
index 21a7452..0536db7 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1121,6 +1121,8 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
 
 	switch(domain->bus_token) {
 	case DOMAIN_BUS_PCI_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
 	case DOMAIN_BUS_VMD_MSI:
 		break;
 	default:
@@ -1146,6 +1148,8 @@ static int msi_handle_pci_fail(struct irq_domain *domain, struct msi_desc *desc,
 {
 	switch(domain->bus_token) {
 	case DOMAIN_BUS_PCI_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
 	case DOMAIN_BUS_VMD_MSI:
 		if (IS_ENABLED(CONFIG_PCI_MSI))
 			break;
