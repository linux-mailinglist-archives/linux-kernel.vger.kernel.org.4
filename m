Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6475A69CB77
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjBTM4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjBTM4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:56:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAC4E3A1;
        Mon, 20 Feb 2023 04:56:00 -0800 (PST)
Date:   Mon, 20 Feb 2023 12:55:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676897758;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5qB7yZQqCaAbjDfa3wxBWK/S/EZXP+UvElzcVrla3Zw=;
        b=p+z4KuczSvCyjE02fcEL40RqQDI0T06Jem+8OcmhITfmjo/iXsRmw3C14Sk0resFPzkKXn
        vhMrWRwdVsFjSBeEvJk1Fi/MuxRTti90Hx0f0qH5W1gaDIqiwtczvjSVcgBT+VupfFC87+
        q9SUzdcpKHCs97hBBxjKHuG5lydwe1QswLQpQ2Ban67+UX0/oQP6LvpKfBfImfMqLGfn1b
        AtEQcjGaJLiG7IcV8sFCszw79NFESxiYnU8mt5CKjZxn/aKiBUCetSrSWsBl7bJK6fIDIJ
        rMb3/yZwb+l8iGjEz81pJeCWFifLDNG2SCON2k7QVzXmpKgefSLKnOSQIP/bVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676897758;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5qB7yZQqCaAbjDfa3wxBWK/S/EZXP+UvElzcVrla3Zw=;
        b=OTI6CrwoTHLyoqcnxmXji3dNX3K9WnOQ/flHEGozMVSqGEidTf4Xp9lj2fKfKWf9EIWhJT
        8iF3TDajnMRbncAA==
From:   "tip-bot2 for Sergey Shtylyov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq/ipi: Fix NULL pointer deref in
 irq_data_get_affinity_mask()
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <b541232d-c2b6-1fe9-79b4-a7129459e4d0@omp.ru>
References: <b541232d-c2b6-1fe9-79b4-a7129459e4d0@omp.ru>
MIME-Version: 1.0
Message-ID: <167689775708.387.18354451760866911184.tip-bot2@tip-bot2>
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

Commit-ID:     feabecaff5902f896531dde90646ca5dfa9d4f7d
Gitweb:        https://git.kernel.org/tip/feabecaff5902f896531dde90646ca5dfa9d4f7d
Author:        Sergey Shtylyov <s.shtylyov@omp.ru>
AuthorDate:    Wed, 17 Aug 2022 23:00:45 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 20 Feb 2023 13:53:41 +01:00

genirq/ipi: Fix NULL pointer deref in irq_data_get_affinity_mask()

If ipi_send_{mask|single}() is called with an invalid interrupt number, all
the local variables there will be NULL. ipi_send_verify() which is invoked
from these functions does verify its 'data' parameter, resulting in a
kernel oops in irq_data_get_affinity_mask() as the passed NULL pointer gets
dereferenced.

Add a missing NULL pointer check in ipi_send_verify()...

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Fixes: 3b8e29a82dd1 ("genirq: Implement ipi_send_mask/single()")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/b541232d-c2b6-1fe9-79b4-a7129459e4d0@omp.ru


---
 kernel/irq/ipi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index bbd945b..961d4af 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -188,9 +188,9 @@ EXPORT_SYMBOL_GPL(ipi_get_hwirq);
 static int ipi_send_verify(struct irq_chip *chip, struct irq_data *data,
 			   const struct cpumask *dest, unsigned int cpu)
 {
-	const struct cpumask *ipimask = irq_data_get_affinity_mask(data);
+	const struct cpumask *ipimask;
 
-	if (!chip || !ipimask)
+	if (!chip || !data)
 		return -EINVAL;
 
 	if (!chip->ipi_send_single && !chip->ipi_send_mask)
@@ -199,6 +199,10 @@ static int ipi_send_verify(struct irq_chip *chip, struct irq_data *data,
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
 
+	ipimask = irq_data_get_affinity_mask(data);
+	if (!ipimask)
+		return -EINVAL;
+
 	if (dest) {
 		if (!cpumask_subset(dest, ipimask))
 			return -EINVAL;
