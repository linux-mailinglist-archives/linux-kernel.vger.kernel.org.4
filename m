Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A661862DF44
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240561AbiKQPLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240470AbiKQPJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:09:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684707666;
        Thu, 17 Nov 2022 07:08:27 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7AI5q4SFo/xo87sYTWbgmfMVQgBAzoy4AFJjjnkiOeY=;
        b=AZDuAXxRP2WJOtJsdXnCA4dpJTIFWVbMn0J+oOZKPX6Ezgz/IUfrYAYp3BDj/Kbz9DqGAC
        eyMbWmA3zctgcraNU6mgeZIx1nGF3uYSykc82BmxhxgyK1Mv5sPVs6/rBe3XGGiVQE/NO5
        muRl/NnhmipfeU2XNr93ZTmLZHRBArPLbVj7mDi+Zdi1LYzLwnQsNnlS4sOe6eDcV8usS6
        VL4orQ5yhZ5SSEO46W+QyhUtHdrLFlWPueG6Tv6LgmY+sYYoVQqI4F340NEYuCbf1CJa+Y
        5jdMq7yvexmU1q6q/0gmgXe3Ybz7H8pGqx9+5N83m2KOypYha1aC+KBjDxXumg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7AI5q4SFo/xo87sYTWbgmfMVQgBAzoy4AFJjjnkiOeY=;
        b=vHaykKWrnjGUcQTwXNj15hWzPm8WkgJPFcfgNZY8AL9DPNPsR6sczadvdW1y3+Uh7pIdMf
        7BMLpipP6wajLaAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] powerpc/pseries/msi: Use msi_domain_ops:: Msi_post_free()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122014.120489922@linutronix.de>
References: <20221111122014.120489922@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869770413.4906.968716787674638204.tip-bot2@tip-bot2>
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

Commit-ID:     c4bc51b1dd611fcce53849254c6582334368c715
Gitweb:        https://git.kernel.org/tip/c4bc51b1dd611fcce53849254c6582334368c715
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:19 +01:00

powerpc/pseries/msi: Use msi_domain_ops:: Msi_post_free()

Use the new msi_post_free() callback which is invoked after the interrupts
have been freed to tell the hypervisor about the shutdown.

This allows to remove the exposure of __msi_domain_free_irqs().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20221111122014.120489922@linutronix.de

---
 arch/powerpc/platforms/pseries/msi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index a3a71d3..3f05507 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -447,21 +447,18 @@ static void pseries_msi_ops_msi_free(struct irq_domain *domain,
  * RTAS can not disable one MSI at a time. It's all or nothing. Do it
  * at the end after all IRQs have been freed.
  */
-static void pseries_msi_domain_free_irqs(struct irq_domain *domain,
-					 struct device *dev)
+static void pseries_msi_post_free(struct irq_domain *domain, struct device *dev)
 {
 	if (WARN_ON_ONCE(!dev_is_pci(dev)))
 		return;
 
-	__msi_domain_free_irqs(domain, dev);
-
 	rtas_disable_msi(to_pci_dev(dev));
 }
 
 static struct msi_domain_ops pseries_pci_msi_domain_ops = {
 	.msi_prepare	= pseries_msi_ops_prepare,
 	.msi_free	= pseries_msi_ops_msi_free,
-	.domain_free_irqs = pseries_msi_domain_free_irqs,
+	.msi_post_free	= pseries_msi_post_free,
 };
 
 static void pseries_msi_shutdown(struct irq_data *d)
