Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A9862DF52
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbiKQPLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240363AbiKQPJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:09:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C16490B1;
        Thu, 17 Nov 2022 07:08:34 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUJ8CspZ0v+ELSclYE/XQ8O/kg00c2EM8DtH+fEMTf4=;
        b=VLq4Iu52psv1FpsFQAF4VSBE2iiLDct/nNOuYlt4ikswTRan0cpx2zxnTepp/cyx6yVE65
        hqIBtzMmXWwep9o9JpfeocCp35HHr9uVaMcOt8fEayguy29f/ltw+estb24yl367mkl4AM
        hjl9u2903McVabhsGGMpndRk+CqXZw/nTLf+C0ai8tXVpo8Zz0Tr2IGuoTzKl5hFimGhkG
        WNDhwVBwkSOJ7wHdaamP+BZcjwdaHc7NxCXvcmPZlxpAFMEDsmBfdHytQzEBZJfpnVCISp
        w7mAKG7UClIar8LcZzmVNeQEcXykl33rK6YGAbQHJ/vvoXw0Iv4gsReX19vsKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUJ8CspZ0v+ELSclYE/XQ8O/kg00c2EM8DtH+fEMTf4=;
        b=pQO29+nVdB3L3DWOKK1WNUg0D2g61FHMOZAaaLMxyuAUZP2uiOzas/1greU/gLmgLmfrna
        yIkOXn2pMXewuqCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] iommu/vt-d: Remove bogus check for multi MSI-X
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122013.713848846@linutronix.de>
References: <20221111122013.713848846@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869771167.4906.10116563938839220650.tip-bot2@tip-bot2>
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

Commit-ID:     527f378c42eaac0b48a8c6ff16da99a6177ff9e3
Gitweb:        https://git.kernel.org/tip/527f378c42eaac0b48a8c6ff16da99a6177ff9e3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:18 +01:00

iommu/vt-d: Remove bogus check for multi MSI-X

PCI/Multi-MSI is MSI specific and not supported for MSI-X.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Link: https://lore.kernel.org/r/20221111122013.713848846@linutronix.de

---
 drivers/iommu/intel/irq_remapping.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 5962bb5..0b80a27 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1334,8 +1334,7 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
 
 	if (!info || !iommu)
 		return -EINVAL;
-	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI &&
-	    info->type != X86_IRQ_ALLOC_TYPE_PCI_MSIX)
+	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI)
 		return -EINVAL;
 
 	/*
