Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D6E6A22AC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjBXUAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBXUAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:00:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF453757D;
        Fri, 24 Feb 2023 11:59:57 -0800 (PST)
Date:   Fri, 24 Feb 2023 19:59:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677268795;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+QDv5nRWs6ZjIbRaVD5ljmBiyofZxQMMwPgAc7wVGTs=;
        b=g9kMLqjmHdcTN3c6Gza+NM8qDC7FaVtkkijjP35RnHBMOLRYguqGhzlNk40FyoZ1i4Rr9E
        rML7zG9RldqURWNqWkaK+nhTfE2n5XeZeXQzei5IVrrk42tf9meJYtNSu/nGjW0z7rQLHI
        djjgoLMO674OXKqeJJr9CAJtBSGep/82MWl+jODzP5PzDFeU3nPNhYXVnJdcE8LVLdd5Vr
        hAQ2ML0QW/APSnT4cJBIM/FdvKfvqTVzK0sgJpDcSKAIY6MD4sc2e1vt8E8xnZ8INLbuEf
        BS6h67gq6GOhRh+gHtHMrCD6iktJQ9EmtkRgWGpihPcMv3RVDGmjjUPsx2PuPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677268795;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+QDv5nRWs6ZjIbRaVD5ljmBiyofZxQMMwPgAc7wVGTs=;
        b=fDxbicN7KytEspVSAAHtjG8ejcQHRjKWm4agj+Y7I68Smu9XADePez/PoYvX222eijC0LB
        ioorswgWhp4eh/BA==
From:   "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq/msi: Drop dead domain name assignment
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230224130509.27814-1-johan+linaro@kernel.org>
References: <20230224130509.27814-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Message-ID: <167726879502.5837.7389254031515212648.tip-bot2@tip-bot2>
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

Commit-ID:     ea9a78c3a7a44e36fa690e1cc90dc2a758c8eb9a
Gitweb:        https://git.kernel.org/tip/ea9a78c3a7a44e36fa690e1cc90dc2a758c8eb9a
Author:        Johan Hovold <johan+linaro@kernel.org>
AuthorDate:    Fri, 24 Feb 2023 14:05:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Feb 2023 20:54:58 +01:00

genirq/msi: Drop dead domain name assignment

Since commit d59f6617eef0 ("genirq: Allow fwnode to carry name
information only") an IRQ domain is always given a name during
allocation (e.g. used for the debugfs entry).

Drop the unused fallback name assignment when creating MSI domains.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230224130509.27814-1-johan+linaro@kernel.org

---
 kernel/irq/msi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 13d9649..efd21b7 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -830,11 +830,8 @@ static struct irq_domain *__msi_create_irq_domain(struct fwnode_handle *fwnode,
 	domain = irq_domain_create_hierarchy(parent, flags | IRQ_DOMAIN_FLAG_MSI, 0,
 					     fwnode, &msi_domain_ops, info);
 
-	if (domain) {
-		if (!domain->name && info->chip)
-			domain->name = info->chip->name;
+	if (domain)
 		irq_domain_update_bus_token(domain, info->bus_token);
-	}
 
 	return domain;
 }
