Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF0E643048
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiLES2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiLESZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD69720BD9;
        Mon,  5 Dec 2022 10:25:19 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264718;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jnTPAmVkRX47X4tNAaZo4ayXISHWGUMFEs/s/a5HNBc=;
        b=RLcUcHwmw2xPCUdqfF8xzbq0SXoH1JZUhHJsvPRLC5h30nlzBH3/oezy3OlDGe0lEMk9Ts
        Fkbr++oxSAZ8dm7SMB4VNyYFrYdVj8LwiBgN029nmY4YZJDa6ZiSfQq/gZ5Nrc13n4BTpC
        nhfdosgQq+5GZXyG8/Kk9U+j9emPTBi92+rMiFtW4q/HbaBbNr3HNxQMxx6GVmlPB9sQY9
        Vec46t7TjrWuuNu47G2/pZp08p9j1qHDQLoB2MhYFI5JQk/fy+3hpUYezzlYcZ/zGKWV2A
        SpyG17xuuHN914PORztTRGq3GrJ4+mwUldEwKH55Je4UPHHOTCS1an5m9EqDgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264718;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jnTPAmVkRX47X4tNAaZo4ayXISHWGUMFEs/s/a5HNBc=;
        b=wqU+S9/eYp9PRLp0Yd/lDlNZxPOH3e37u7YwhScPgzo8o0XDHq6Hoj8S4sCgaalTXuLq7c
        l1r33hdGeGQBdaBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] bus: fsl-mc-msi: Switch to domain id aware interfaces
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230314.575538524@linutronix.de>
References: <20221124230314.575538524@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471790.4906.17520351418938687087.tip-bot2@tip-bot2>
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

Commit-ID:     46a2bc8c7092cf277fb486c0629894ed904984a4
Gitweb:        https://git.kernel.org/tip/46a2bc8c7092cf277fb486c0629894ed904984a4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:00 +01:00

bus: fsl-mc-msi: Switch to domain id aware interfaces

Switch to the new domain id aware interfaces to phase out the previous
ones.

Get rid of the MSI descriptor and domain checks as the core code detects
these issues anyway.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230314.575538524@linutronix.de

---
 drivers/bus/fsl-mc/fsl-mc-msi.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index 0cfe859..f3f8af9 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -213,21 +213,8 @@ struct irq_domain *fsl_mc_find_msi_domain(struct device *dev)
 
 int fsl_mc_msi_domain_alloc_irqs(struct device *dev,  unsigned int irq_count)
 {
-	struct irq_domain *msi_domain;
-	int error;
-
-	msi_domain = dev_get_msi_domain(dev);
-	if (!msi_domain)
-		return -EINVAL;
-
-	error = msi_setup_device_data(dev);
-	if (error)
-		return error;
+	int error = msi_setup_device_data(dev);
 
-	msi_lock_descs(dev);
-	if (msi_first_desc(dev, MSI_DESC_ALL))
-		error = -EINVAL;
-	msi_unlock_descs(dev);
 	if (error)
 		return error;
 
@@ -235,7 +222,7 @@ int fsl_mc_msi_domain_alloc_irqs(struct device *dev,  unsigned int irq_count)
 	 * NOTE: Calling this function will trigger the invocation of the
 	 * its_fsl_mc_msi_prepare() callback
 	 */
-	error = msi_domain_alloc_irqs(msi_domain, dev, irq_count);
+	error = msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0, irq_count - 1);
 
 	if (error)
 		dev_err(dev, "Failed to allocate IRQs\n");
@@ -244,11 +231,5 @@ int fsl_mc_msi_domain_alloc_irqs(struct device *dev,  unsigned int irq_count)
 
 void fsl_mc_msi_domain_free_irqs(struct device *dev)
 {
-	struct irq_domain *msi_domain;
-
-	msi_domain = dev_get_msi_domain(dev);
-	if (!msi_domain)
-		return;
-
-	msi_domain_free_irqs(msi_domain, dev);
+	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
 }
