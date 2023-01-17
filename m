Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CE8670B90
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjAQWWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjAQWWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:22:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF06442C0;
        Tue, 17 Jan 2023 14:01:21 -0800 (PST)
Date:   Tue, 17 Jan 2023 22:01:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673992868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cw2ifadid2co5wrZ8WMKcQk2tEe2rtV1EvOYOZJpSz0=;
        b=mPQOu0upuAow0EFlbXSZtYpOzm/Ma2pG67mk9BwOvD8bYcbqCETte2+u5ZUgLCOkbxqMEF
        fcZ7+U1al6Enrg7r+uXSAgqCR9A2o3rmSzNWHezzf/pdZG4wyFbmJdYYlVbOn9jrnN+nj2
        nnPACwuxsuwSz16sQw1KXbamgDJ2aZkabdBzF+1prTuXUNMi9E9fFzvBAJ0iixljY+vWx6
        eQNoTfNxW+NTLbCGPCzlhTwfDddRHOGFtxbIvZJnsyvGNX282kRmuCsl0vFuPFcRUx4p5b
        KJVNrKEI3p5sP0+nNHjSk0Myjd5+LKxFu8X5HYLzoaxeLJMnLuTn3v70w8/INw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673992868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cw2ifadid2co5wrZ8WMKcQk2tEe2rtV1EvOYOZJpSz0=;
        b=eSxVsx7g9HGDdeQUznb3llfcHAVhiYAP5IuRNZRXQ6UvMtroo2xWeY3sPYlZ0LCnJs8yHy
        czJU8VT+TvudqlAA==
From:   "tip-bot2 for Jason Gunthorpe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq/msi: Free the fwnode created by
 msi_create_device_irq_domain()
Cc:     Omri Barazi <obarazi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kalle Valo <kvalo@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <0-v2-24af6665e2da+c9-msi_leak_jgg@nvidia.com>
References: <0-v2-24af6665e2da+c9-msi_leak_jgg@nvidia.com>
MIME-Version: 1.0
Message-ID: <167399286755.4906.18338458048671673819.tip-bot2@tip-bot2>
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

Commit-ID:     ac8f29aef2f1695956ff6773b33f975290437f29
Gitweb:        https://git.kernel.org/tip/ac8f29aef2f1695956ff6773b33f975290437f29
Author:        Jason Gunthorpe <jgg@nvidia.com>
AuthorDate:    Tue, 17 Jan 2023 15:16:17 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 17 Jan 2023 22:57:04 +01:00

genirq/msi: Free the fwnode created by msi_create_device_irq_domain()

msi_create_device_irq_domain() creates a firmware node for the new domain,
which is never freed. kmemleak reports:

unreferenced object 0xffff888120ba9a00 (size 96):
  comm "systemd-modules", pid 221, jiffies 4294893411 (age 635.732s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 e0 19 8b 83 ff ff ff ff  ................
    00 00 00 00 00 00 00 00 18 9a ba 20 81 88 ff ff  ........... ....
  backtrace:
    [<000000008cdbc98d>] __irq_domain_alloc_fwnode+0x51/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0

Use the proper free operation for the firmware wnode so the name is freed
during error unwind of msi_create_device_irq_domain() and also free the
node in msi_remove_device_irq_domain() if it was automatically allocated.

To avoid extra NULL pointer checks make irq_domain_free_fwnode() tolerant
of NULL.

Fixes: 27a6dea3ebaa ("genirq/msi: Provide msi_create/free_device_irq_domain()")
Reported-by: Omri Barazi <obarazi@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kalle Valo <kvalo@kernel.org>
Tested-by: Leon Romanovsky <leonro@nvidia.com>
Link: https://lore.kernel.org/r/0-v2-24af6665e2da+c9-msi_leak_jgg@nvidia.com

---
 kernel/irq/irqdomain.c | 2 +-
 kernel/irq/msi.c       | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8fe1da9..5c3fb61 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -114,7 +114,7 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
 {
 	struct irqchip_fwid *fwid;
 
-	if (WARN_ON(!is_fwnode_irqchip(fwnode)))
+	if (!fwnode || WARN_ON(!is_fwnode_irqchip(fwnode)))
 		return;
 
 	fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 955267b..783a3e6 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1000,7 +1000,7 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 fail:
 	msi_unlock_descs(dev);
 free_fwnode:
-	kfree(fwnode);
+	irq_domain_free_fwnode(fwnode);
 free_bundle:
 	kfree(bundle);
 	return false;
@@ -1013,6 +1013,7 @@ free_bundle:
  */
 void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
 {
+	struct fwnode_handle *fwnode = NULL;
 	struct msi_domain_info *info;
 	struct irq_domain *domain;
 
@@ -1025,7 +1026,10 @@ void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
 
 	dev->msi.data->__domains[domid].domain = NULL;
 	info = domain->host_data;
+	if (irq_domain_is_msi_device(domain))
+		fwnode = domain->fwnode;
 	irq_domain_remove(domain);
+	irq_domain_free_fwnode(fwnode);
 	kfree(container_of(info, struct msi_domain_template, info));
 
 unlock:
