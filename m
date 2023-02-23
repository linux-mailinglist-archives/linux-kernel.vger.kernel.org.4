Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B8A6A0C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbjBWO7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbjBWO7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:59:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FB718B29;
        Thu, 23 Feb 2023 06:59:19 -0800 (PST)
Date:   Thu, 23 Feb 2023 14:59:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677164357;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCVAjuc5AQRTS8zQItFvAnUhtNEEuOXdAGorfxjb+fo=;
        b=b7Kfw1JkDVa+jKCSPSm9R32gE/tCjArAehgQ+7IH5vjaV9ELcmPMlX67y/cqOLchB+I1an
        W8yPqtKZByDD6zsHHDPcBKkbKn++Ckn+NMnR6cjxQM+SWh65+QdFic7ij1VnZ248uo0oIM
        U+w6bG6u/4DA1hGGaaVGTdxQingN9GOzJkDalicwbXTmlLcIfZSINKXRlmTfRQTQDOPSfy
        2IdtqWHeImi2ZK8TafEowN/P1RaTONYOTuHFTnBVMmJCahPkLgVlI/SN4OsavNviGE954i
        A5eDpGrLDhQjmyVwV73DVcm1Qd2g04wzuLOk+eHqSw6s4rDou0gJr/gSkyOKIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677164357;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCVAjuc5AQRTS8zQItFvAnUhtNEEuOXdAGorfxjb+fo=;
        b=ASIIlfnEaq/9k1jpFPNjl0+JsgsEA1FtmvSHoLhbokQ28vXB04wghq/FrWMzQWObUbM821
        g7kewmetgRItFmCQ==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqdomain: Add missing NULL pointer check in
 irq_domain_create_hierarchy()
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230223083800.31347-1-jgross@suse.com>
References: <20230223083800.31347-1-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <167716435690.5837.7282180286659633068.tip-bot2@tip-bot2>
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

Commit-ID:     ad32ab9604f29827494024828f527228e84fbd2c
Gitweb:        https://git.kernel.org/tip/ad32ab9604f29827494024828f527228e84fbd2c
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Thu, 23 Feb 2023 09:38:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 Feb 2023 15:52:28 +01:00

irqdomain: Add missing NULL pointer check in irq_domain_create_hierarchy()

The recent switch to per-domain locking caused a NULL dereference in
irq_domain_create_hierarchy(), as Xen code is calling
msi_create_irq_domain() with a NULL parent pointer.

Fix that by testing parent to be set before dereferencing it. For a
non-existing parent the irqdomain's root will stay to point to
itself.

Fixes: 9dbb8e3452ab ("irqdomain: Switch to per-domain locking")
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230223083800.31347-1-jgross@suse.com

---
 kernel/irq/irqdomain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index aa5b7ee..6522dfb 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1172,7 +1172,8 @@ struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 		domain = __irq_domain_create(fwnode, 0, ~0, 0, ops, host_data);
 
 	if (domain) {
-		domain->root = parent->root;
+		if (parent)
+			domain->root = parent->root;
 		domain->parent = parent;
 		domain->flags |= flags;
 
