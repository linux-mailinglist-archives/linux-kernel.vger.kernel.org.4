Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B58664303B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiLES1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiLESZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5919520F50;
        Mon,  5 Dec 2022 10:25:18 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264716;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xy/eY7p8ZnxfrkLJSoH2eLIlIdhmT47Syyb1yfoOsOI=;
        b=RcQgM4gVr72xhN3aWYc7EnlxQz/RFLGYZea2iklTlev+1bApitfjDKoS/s63kuFAN+JLgW
        ctURZr2frrCYTT1GhrSv8Ow9o3Dw6eFWgf4CuQqSTRCNkhZmkfKUosUGSrTWmLRgnR86bD
        2QOlJITe9B+QCBMT3DOSD7cIWyijsZYKk7lcPFbRGHx66N6tfE87E2CgHT9wtQxWIYDUx6
        qwDG0UWHjtvy+TnW4JfYL+mdx5QI32Wi5TdiaiBzNXZRm43/dAZrcWsQKqU1tuYGtDSO9E
        i68SXq2NCKIw6b47jXGjTy5zRHz4rWjLwq/QLY1o6FUDmlMtTlPF7aPwpYrw6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264716;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xy/eY7p8ZnxfrkLJSoH2eLIlIdhmT47Syyb1yfoOsOI=;
        b=qetfbYlthlN+KdRxWTX522QTWHB/Bs3h020D+N8rML9IW5rII1DNhnILwHRJIeAjwayhIu
        aKG2uhYBLkmjOdCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Add size info to struct msi_domain_info
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232325.501144862@linutronix.de>
References: <20221124232325.501144862@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471647.4906.14532697826610598504.tip-bot2@tip-bot2>
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

Commit-ID:     61bf992fc618503c910416f28afa0b015838b72b
Gitweb:        https://git.kernel.org/tip/61bf992fc618503c910416f28afa0b015838b72b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:25:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:01 +01:00

genirq/msi: Add size info to struct msi_domain_info

To allow proper range checking especially for dynamic allocations add a
size field to struct msi_domain_info. If the field is 0 then the size is
unknown or unlimited (up to MSI_MAX_INDEX) to provide backwards
compability.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232325.501144862@linutronix.de

---
 include/linux/msi.h |  5 +++++
 kernel/irq/msi.c    | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 7fb8737..08a0e2a 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -422,6 +422,10 @@ struct msi_domain_ops {
  * struct msi_domain_info - MSI interrupt domain data
  * @flags:		Flags to decribe features and capabilities
  * @bus_token:		The domain bus token
+ * @hwsize:		The hardware table size or the software index limit.
+ *			If 0 then the size is considered unlimited and
+ *			gets initialized to the maximum software index limit
+ *			by the domain creation code.
  * @ops:		The callback data structure
  * @chip:		Optional: associated interrupt chip
  * @chip_data:		Optional: associated interrupt chip data
@@ -433,6 +437,7 @@ struct msi_domain_ops {
 struct msi_domain_info {
 	u32				flags;
 	enum irq_domain_bus_token	bus_token;
+	unsigned int			hwsize;
 	struct msi_domain_ops		*ops;
 	struct irq_chip			*chip;
 	void				*chip_data;
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index c368116..0a38905 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -772,6 +772,17 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 {
 	struct irq_domain *domain;
 
+	if (info->hwsize > MSI_XA_DOMAIN_SIZE)
+		return NULL;
+
+	/*
+	 * Hardware size 0 is valid for backwards compatibility and for
+	 * domains which are not backed by a hardware table. Grant the
+	 * maximum index space.
+	 */
+	if (!info->hwsize)
+		info->hwsize = MSI_XA_DOMAIN_SIZE;
+
 	msi_domain_update_dom_ops(info);
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		msi_domain_update_chip_ops(info);
