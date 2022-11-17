Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906B762DF4F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbiKQPLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240525AbiKQPJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:09:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9111C490A9;
        Thu, 17 Nov 2022 07:08:33 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7xnQPsOy40l1xJvNfBGlUKQFfooNA07HWoVxmqhPTGM=;
        b=Il5oXTx0v+LJtciV81/VLW4UuWy4Rrr3NxhGzv0FRRCFv3qjYSqu6m9UDSJl7um/z5hBau
        /G3WkK6vghEPkNdn8tBdJNy+ZOL3TljeDVb+oBaNOCQDycmMvFJkfCbp0Pgb3V2Oh7qv0G
        K4n+Ou9d29iuka+wno5MMW6JqSbBbtyrhW7kpaqq6PynXzUWWNgo6OeZBJ2grwx5qebkhT
        wDrMCM/vDze6x9SDfTI7sfSaym3bAyQZmGiHLLFRFERMCNKhPBaLqwWnUpZLHxQ6Qqgug8
        0+3ImPwCabVnNDRyj7Nm3R9LaRJP8Uddgx/VlyxJPlY3gD8oGPMEoxnTnQZMNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7xnQPsOy40l1xJvNfBGlUKQFfooNA07HWoVxmqhPTGM=;
        b=4rfaeDhFVNMFx8/EEyxze4OoNiqVY3ACb6rN52cM+HB9rzDQOtdGPJ8sCOPST0qMryHRjd
        egT+j2Mr7wEVkkAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] iommu/amd: Remove bogus check for multi MSI-X
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122013.772447165@linutronix.de>
References: <20221111122013.772447165@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869771061.4906.14414171703731337638.tip-bot2@tip-bot2>
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

Commit-ID:     1c82f0d3fcdcb509a7ba1a2c8f58890155750b00
Gitweb:        https://git.kernel.org/tip/1c82f0d3fcdcb509a7ba1a2c8f58890155750b00
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:18 +01:00

iommu/amd: Remove bogus check for multi MSI-X

PCI/Multi-MSI is MSI specific and not supported for MSI-X

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20221111122013.772447165@linutronix.de

---
 drivers/iommu/amd/iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d3b39d0..8ece864 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3294,8 +3294,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 
 	if (!info)
 		return -EINVAL;
-	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI &&
-	    info->type != X86_IRQ_ALLOC_TYPE_PCI_MSIX)
+	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI)
 		return -EINVAL;
 
 	/*
