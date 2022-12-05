Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC217643056
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiLES25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiLESZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ADD2125D;
        Mon,  5 Dec 2022 10:25:22 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lK52VqS+nA4fYa+B2TcS1ex1rq4ICiou2FpdOjsQPSI=;
        b=sSz6UTwcigi7I8akpF7W/bkqYRmZ+ktGtWRpwC6RQ9P73pymvhZK9QXHjFzydhdCJe/DBv
        M7F7R9I0UcshaOuD8j+O4zQm4k83CZImQuu6cLldPXMZ9f02nb31ZzmeSMdRBtiqchFne3
        bbt8ax7fP+wNKMlaXORL24KO0pWRaEP6CjVbssQgDFrPCrtslh75RfRSPxIsuJT8UbhK8S
        yvEfu8rBBwFMrCez2K5f+hiIw4WD6Dsr3mAS0Xr7gT7ygo+yPLXTEW6q9pZ+b+mKhIChYd
        Byr2OdnCRyGAK+jIfGptECplc7YkeM+DKrJuknoUlirAr87b7z5si9fmlNxNYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lK52VqS+nA4fYa+B2TcS1ex1rq4ICiou2FpdOjsQPSI=;
        b=0jo1uFk9QBnPy0twNE6B6LIMYFymYbE6c7GTLpIVaA2D+U5DnwTM57Seis/dNb8cahl9bZ
        psLfyjJoLYqKsxBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Check for invalid MSI parent domain usage
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230313.806128070@linutronix.de>
References: <20221124230313.806128070@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026472092.4906.17905366797803446408.tip-bot2@tip-bot2>
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

Commit-ID:     3e86a3a3ed031dd498e614db0fa082a58d700df9
Gitweb:        https://git.kernel.org/tip/3e86a3a3ed031dd498e614db0fa082a58d700df9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:20:59 +01:00

genirq/msi: Check for invalid MSI parent domain usage

In the upcoming per device MSI domain concept the MSI parent domains are
not allowed to be used as regular MSI domains where the MSI allocation/free
operations are applicable.

Add appropriate checks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230313.806128070@linutronix.de

---
 kernel/irq/msi.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index c37c0be..5939dc6 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -937,13 +937,21 @@ int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device 
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
+	if (WARN_ON_ONCE(irq_domain_is_msi_parent(domain))) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	/* Frees allocated descriptors in case of failure. */
 	ret = msi_domain_add_simple_msi_descs(info, dev, nvec);
 	if (ret)
-		return ret;
+		goto free;
 
 	ret = ops->domain_alloc_irqs(domain, dev, nvec);
-	if (ret)
-		msi_domain_free_irqs_descs_locked(domain, dev);
+	if (!ret)
+		return 0;
+free:
+	msi_domain_free_irqs_descs_locked(domain, dev);
 	return ret;
 }
 
@@ -1013,6 +1021,9 @@ void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device 
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
+	if (WARN_ON_ONCE(irq_domain_is_msi_parent(domain)))
+		return;
+
 	ops->domain_free_irqs(domain, dev);
 	if (ops->msi_post_free)
 		ops->msi_post_free(domain, dev);
