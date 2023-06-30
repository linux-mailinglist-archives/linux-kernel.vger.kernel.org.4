Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17734743809
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjF3JS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjF3JSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:18:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C05A35AE;
        Fri, 30 Jun 2023 02:18:31 -0700 (PDT)
Date:   Fri, 30 Jun 2023 09:18:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688116709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=odG3RuAEmIQUMBe5PO/6PQwaLkI3rJzneIanf6tBvlI=;
        b=bwpX7JYSwrrNbUyjQzsoZcnIhRMULr1vKak/+/ieE6QHa/w/VdsRVYpDkjOKJaF6l7s5wD
        lOBZMGW4Wt+iSwxvgmFoX1QRH70uCO9X+IhD9XUtNJhy/QMc+S1QUP4GyyW6noU8wVkiON
        Bb99oTPaHcCvqq3dSfADDSVXoS4Z2e/O/9ZxPMnuI1UPfIgRnHjfLE5ZwgoEws2IfSAKUp
        f95761UAtPLIhsrs62wp/hTCOC0+U2ARx2kzOCkD+jwzGhmjD8O6if+B0a5iJxQa9egM8X
        8p0pVZqIQLq15goECTjJU0+jYHb+rDWCK6NjZlSObG/eQIE2DqUYSHpPCQyXhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688116709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=odG3RuAEmIQUMBe5PO/6PQwaLkI3rJzneIanf6tBvlI=;
        b=RzuVnTpjhNJcnw/CnaYGdFCl+2Uv/8WYKOXiFVyKZznic1dfgqknA91FlfJO6fXAcihvI5
        WmrOTkyzMY6BuQDw==
From:   "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqdomain: Use return value of strreplace()
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230628150251.17832-1-andriy.shevchenko@linux.intel.com>
References: <20230628150251.17832-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168811670871.404.17155644226213801452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     67a4e1a3bf7c68ed3fbefc4213648165d912cabb
Gitweb:        https://git.kernel.org/tip/67a4e1a3bf7c68ed3fbefc4213648165d912cabb
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Wed, 28 Jun 2023 18:02:51 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 30 Jun 2023 11:13:44 +02:00

irqdomain: Use return value of strreplace()

Since strreplace() returns the pointer to the string itself, use it
directly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230628150251.17832-1-andriy.shevchenko@linux.intel.com

---
 kernel/irq/irqdomain.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 5bd0162..0bdef4f 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -182,9 +182,7 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 			return NULL;
 		}
 
-		strreplace(name, '/', ':');
-
-		domain->name = name;
+		domain->name = strreplace(name, '/', ':');
 		domain->fwnode = fwnode;
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 	}
