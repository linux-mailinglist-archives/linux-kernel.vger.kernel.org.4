Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A100F7330B0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345068AbjFPMDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344589AbjFPMDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:03:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AEF2D69;
        Fri, 16 Jun 2023 05:03:12 -0700 (PDT)
Date:   Fri, 16 Jun 2023 12:03:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686916990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46vrl4ylUTLsMdMSynSrUU4Cn+HCsdL3cBHiPpuWos0=;
        b=1b81gD2qZYQPf2bAHZ/S0802+LZYvoOAfXNuAA1yXvdEQhqHdGzrytYgX0uTuXmXHqfyMc
        N9ah6hMaYgddjP8IDJNnqJSpLHouhQpOSvd72F5RNX63PvbXTrCegkWCQQ67QcDZvnwAzX
        hZEOXMGwN5IggR4vKXMhSg8QiBwQzQNje/NQeYIDbvl32Hiu5pKDXFzlvttAo0GIQvQtjK
        /E0N60h16PdYxYNSLD71jEl8XgQSEukEKVWbBS6CyWGV2m18uzmNOlFLn6DwtwEi4RK/Dp
        gh0qucgK9jm/GgTH/gsTOB+2DNHPsmh2M/v3VrGIYp9rd5FhZWNwbXPDcmw14w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686916990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46vrl4ylUTLsMdMSynSrUU4Cn+HCsdL3cBHiPpuWos0=;
        b=pNn8smC+BOAVS5eGRt5UwxEHVLZH4cLiI8s+IYSpjGkQI8zOdc2nWu0ClQ4qSQAcwOKYww
        5c8+hb84UEd1fLDA==
From:   "irqchip-bot for Liu Peibao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-pch-pic: Fix potential
 incorrect hwirq assignment
Cc:     stable@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230614115936.5950-3-lvjianmin@loongson.cn>
References: <20230614115936.5950-3-lvjianmin@loongson.cn>
MIME-Version: 1.0
Message-ID: <168691699008.404.10069556524976905462.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     783422e704ca0fa41cb2fe9ed79e46b6fe7eae29
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/783422e704ca0fa41cb2fe9ed79e46b6fe7eae29
Author:        Liu Peibao <liupeibao@loongson.cn>
AuthorDate:    Wed, 14 Jun 2023 19:59:33 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 16 Jun 2023 12:59:28 +01:00

irqchip/loongson-pch-pic: Fix potential incorrect hwirq assignment

In DeviceTree path, when ht_vec_base is not zero, the hwirq of PCH PIC
will be assigned incorrectly. Because when pch_pic_domain_translate()
adds the ht_vec_base to hwirq, the hwirq does not have the ht_vec_base
subtracted when calling irq_domain_set_info().

The ht_vec_base is designed for the parent irq chip/domain of the PCH PIC.
It seems not proper to deal this in callbacks of the PCH PIC domain and
let's put this back like the initial commit ef8c01eb64ca ("irqchip: Add
Loongson PCH PIC controller").

Fixes: bcdd75c596c8 ("irqchip/loongson-pch-pic: Add ACPI init support")
Cc: stable@vger.kernel.org
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230614115936.5950-3-lvjianmin@loongson.cn
---
 drivers/irqchip/irq-loongson-pch-pic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index 921c5c0..93a71f6 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -164,7 +164,7 @@ static int pch_pic_domain_translate(struct irq_domain *d,
 		if (fwspec->param_count < 2)
 			return -EINVAL;
 
-		*hwirq = fwspec->param[0] + priv->ht_vec_base;
+		*hwirq = fwspec->param[0];
 		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
 	} else {
 		if (fwspec->param_count < 1)
@@ -196,7 +196,7 @@ static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
 
 	parent_fwspec.fwnode = domain->parent->fwnode;
 	parent_fwspec.param_count = 1;
-	parent_fwspec.param[0] = hwirq;
+	parent_fwspec.param[0] = hwirq + priv->ht_vec_base;
 
 	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
 	if (err)
