Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B46964302C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiLES0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiLESZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F0A20BE6;
        Mon,  5 Dec 2022 10:25:18 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264715;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZedNHhsprNUnD/Sk//bQ8/DcxPxO0/K/n0mXz7RnHI=;
        b=gbGT6SYpiivaOGvBy7n9gXAuyKh3ISL1G3Bs3JuaoPYDp6RvFYhTdRnFHOyqjAsaP3IqF7
        uxhgmHz/4O/FZEuXsHbYy4IyD3DzoF2R6YqatImSg+8JewL+wMni5ip9Q16p/K0shGjJWk
        ibOaa6ChWKsTiBO1ZRYyf+CIbns8cpKNhzf7Xe3SqGTjHfht12+SnsaGAoS6TrQUJ6V/dG
        QOVYQIbV4swHv9AoTMEPLJ84og+rKBKF9V2+rib2VGJ4s4O8Wc1HbiSzTPDV8QBhK30L5A
        7XgTBcVljKospJl39yoa/IZLDIVex9tiYYYudTkpyGotKuzpFMEPd6l457t4+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264715;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZedNHhsprNUnD/Sk//bQ8/DcxPxO0/K/n0mXz7RnHI=;
        b=xP7s9XOJ0LFSeiXt+AJIUKGhsGF3KI6ZU6DirD3tEjvX96BVxZqPoHAxMV8xsZJsSqIjCU
        Ifhpu2kLnfQ9mnBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Provide msi_match_device_domain()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232325.738047902@linutronix.de>
References: <20221124232325.738047902@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471551.4906.2567791541055402967.tip-bot2@tip-bot2>
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

Commit-ID:     26e91b75bf6108550035355c835bf0c93c885b61
Gitweb:        https://git.kernel.org/tip/26e91b75bf6108550035355c835bf0c93c885b61
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:25:57 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:01 +01:00

genirq/msi: Provide msi_match_device_domain()

Provide an interface to match a per device domain bus token. This allows to
query which type of domain is installed for a particular domain id. Will be
used for PCI to avoid frequent create/remove cycles for the MSI resp. MSI-X
domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232325.738047902@linutronix.de

---
 include/linux/msi.h |  3 +++
 kernel/irq/msi.c    | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index ef46a3e..b4ab005 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -553,6 +553,9 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 				  void *chip_data);
 void msi_remove_device_irq_domain(struct device *dev, unsigned int domid);
 
+bool msi_match_device_irq_domain(struct device *dev, unsigned int domid,
+				 enum irq_domain_bus_token bus_token);
+
 int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domid,
 				       unsigned int first, unsigned int last);
 int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 8b415bd..7449998 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -986,6 +986,31 @@ unlock:
 	msi_unlock_descs(dev);
 }
 
+/**
+ * msi_match_device_irq_domain - Match a device irq domain against a bus token
+ * @dev:	Pointer to the device
+ * @domid:	Domain id
+ * @bus_token:	Bus token to match against the domain bus token
+ *
+ * Return: True if device domain exists and bus tokens match.
+ */
+bool msi_match_device_irq_domain(struct device *dev, unsigned int domid,
+				 enum irq_domain_bus_token bus_token)
+{
+	struct msi_domain_info *info;
+	struct irq_domain *domain;
+	bool ret = false;
+
+	msi_lock_descs(dev);
+	domain = msi_get_device_domain(dev, domid);
+	if (domain && irq_domain_is_msi_device(domain)) {
+		info = domain->host_data;
+		ret = info->bus_token == bus_token;
+	}
+	msi_unlock_descs(dev);
+	return ret;
+}
+
 int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec, msi_alloc_info_t *arg)
 {
