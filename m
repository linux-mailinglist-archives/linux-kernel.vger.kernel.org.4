Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C285C64304D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiLES14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbiLESZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A45D20BD8;
        Mon,  5 Dec 2022 10:25:19 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264718;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H77oCQcfyF7CRvU/+fKBpZxDnkjoAtRTLyPaW2YTn+g=;
        b=fiGdI8TFnlWqBkepj/zAHjVdAYdehTab0A/yK1IwpfA0P5DKqDTa2urgZC6ve1ueUuioD/
        1NztINx9UXWXcH0N7Bnpic1bu/rrLxUf0/weu63XntL5Nf/ifyhNhCP+SYOG3EiPkRixWp
        BiJ6ZtE0ziPLl/H32FTfjKIULTX8g0vq8CqD/R4oAG90otZMX+hK4JSgkH12I5/ewxv8vC
        G4olGb0TQee4VPSLM539yOx7S5BTrVZprwT1N1cLTC8SGPP15G1tRrpU0RxzQfrRw9x3JL
        N+3RshK6BbMbnKzbGNdgMAFpvAUBoPLX+wptHoVS9qAZ9Jjoq7JnSBJbEe4NVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264718;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H77oCQcfyF7CRvU/+fKBpZxDnkjoAtRTLyPaW2YTn+g=;
        b=VVMHdS4vDX5B52gzANtz0sK3XX6lolFyjmRFIuOQ+e7y48OXzJHcZFTsfTXKVWFGw8bTMY
        TZBhd7+uzxsE98DA==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] oc: ti: ti_sci_inta_msi: Switch to domain id aware
 MSI functions
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230314.634800247@linutronix.de>
References: <20221124230314.634800247@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471769.4906.17409547854986579217.tip-bot2@tip-bot2>
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

Commit-ID:     811b32811fbd1a5d3a9eb089ff1d34fa04ef2144
Gitweb:        https://git.kernel.org/tip/811b32811fbd1a5d3a9eb089ff1d34fa04ef2144
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:00 +01:00

oc: ti: ti_sci_inta_msi: Switch to domain id aware MSI functions

Switch to the new domain id aware interfaces to phase out the previous
ones. Remove the domain check as it happens in the core code now.

No functional change.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230314.634800247@linutronix.de

---
 drivers/soc/ti/ti_sci_inta_msi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_msi.c
index 255849c..b9251e1 100644
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -93,13 +93,8 @@ int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
 				      struct ti_sci_resource *res)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct irq_domain *msi_domain;
 	int ret, nvec;
 
-	msi_domain = dev_get_msi_domain(dev);
-	if (!msi_domain)
-		return -EINVAL;
-
 	if (pdev->id < 0)
 		return -ENODEV;
 
@@ -114,7 +109,8 @@ int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
 		goto unlock;
 	}
 
-	ret = msi_domain_alloc_irqs_descs_locked(msi_domain, dev, nvec);
+	/* Use alloc ALL as it's unclear whether there are gaps in the indices */
+	ret = msi_domain_alloc_irqs_all_locked(dev, MSI_DEFAULT_DOMAIN, nvec);
 	if (ret)
 		dev_err(dev, "Failed to allocate IRQs %d\n", ret);
 unlock:
