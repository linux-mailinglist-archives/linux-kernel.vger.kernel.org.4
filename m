Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EA6643008
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiLESZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiLESZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FB82098A;
        Mon,  5 Dec 2022 10:25:15 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EI8e3+sROLX8uOVQzyPrEeWjNzPPzsZz/BnvJQPCq1A=;
        b=g7ufrmFEE+LeGtLwj+/hfZFEH4l9CrneAEa02n5SYQoEwZsTFIqIhCNNBYvH25Aviz8NjK
        b62uaYeamoYXb4DzbSe2W9DC44vMXj40bYHhbSZaUOJdHPFZd8f9arh1MwoJ+Adx+zE28H
        lB81F7x4JigD1FEhVcPSmJbuWV/NXhnbE3udSycGhR+7YQeR/BuCf0FM4c2uJpJ2sgbULI
        dDVEVewM6fzaMAYEO8ir38OzNlhpFgt7t1HEKx8xLg05SKykiSnESUauV7JeXILGdCvaW7
        Umhv96UanOmKQyz1z/8NnrOM4AW6SmZ3HCrqPmfNPXv0lqe0Q6dYhWSIRR57RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EI8e3+sROLX8uOVQzyPrEeWjNzPPzsZz/BnvJQPCq1A=;
        b=HokrXKXc5VqVC7XC4qfDIDSOglqg7FQtOAB0wrpIePbCyl3hwoIUO/YvnX7DUigp88/5mb
        mU7Iqb0Mf28KraAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] x86/apic/msi: Enable MSI_FLAG_PCI_MSIX_ALLOC_DYN
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232326.787373104@linutronix.de>
References: <20221124232326.787373104@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471147.4906.2795789730317822599.tip-bot2@tip-bot2>
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

Commit-ID:     3ec4b570fe9fbd5ae91d354d7a157a11f7dcf714
Gitweb:        https://git.kernel.org/tip/3ec4b570fe9fbd5ae91d354d7a157a11f7dcf714
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:04 +01:00

x86/apic/msi: Enable MSI_FLAG_PCI_MSIX_ALLOC_DYN

x86 MSI irqdomains can handle MSI-X allocation post MSI-X enable just out
of the box - on the vector domain and on the remapping domains,

Add the feature flag to the supported feature list

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232326.787373104@linutronix.de

---
 arch/x86/include/asm/msi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msi.h b/arch/x86/include/asm/msi.h
index 7702958..935c6d4 100644
--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -63,7 +63,7 @@ struct msi_msg;
 u32 x86_msi_msg_get_destid(struct msi_msg *msg, bool extid);
 
 #define X86_VECTOR_MSI_FLAGS_SUPPORTED					\
-	(MSI_GENERIC_FLAGS_MASK | MSI_FLAG_PCI_MSIX)
+	(MSI_GENERIC_FLAGS_MASK | MSI_FLAG_PCI_MSIX | MSI_FLAG_PCI_MSIX_ALLOC_DYN)
 
 #define X86_VECTOR_MSI_FLAGS_REQUIRED					\
 	(MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS)
