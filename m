Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B886FA374
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjEHJgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjEHJgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:36:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46927FD
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:36:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683538597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ZRUhoNxuRJv4YAvsY/1F29817RKjKvWUYqtqHUK5nw=;
        b=sw0DXDwRLeE9JXz87pVhj7ptI298gSDHmExy5/saBvXFiiaYy8DeAXvlSiE2t/b3P0t32w
        Oh6KqoIK2rTxp2x0OAo/xWAb1e8IqT1gM2MC2+NfXrjXU55SjtTEidH576juIx1GNGo4/Q
        OIi8ShSlAwsI5z268c9/3uR3UOtuzlQYE/zqEp1ipoj/kZL08l1rcX1v5b/a9jDkgvZNM3
        rqgaU+KO9KgjPvjVl7MzXE8hK0lLRmY3dG41M7OVIGliBX9Iznnkls0HMkyy1hrw+cZYfy
        h5U9JmWz+6QELXErUEB1ZVQqY5gK3RH8TdGDRxLDmXlxOmd8BRDQy969BljDjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683538597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ZRUhoNxuRJv4YAvsY/1F29817RKjKvWUYqtqHUK5nw=;
        b=KbRqTQNVPno/h+fP+QmlD76fDUNKCvn/x879FxGUHIf+lpymgZhcHVvfOiocNIcRc2oEtJ
        flDsy4Ct/nZst8Bg==
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     Shanker Donthineni <sdonthineni@nvidia.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v3 3/3] genirq: Use the maple tree for IRQ descriptors
 management
In-Reply-To: <ZFdbtipfTsIF0u6z@yujie-X299>
References: <202304251035.19367560-yujie.liu@intel.com>
 <87a5yuzvzd.ffs@tglx> <ZEsiYbi8dorXTI5t@yujie-X299> <877ctw5mdp.ffs@tglx>
 <ZFdbtipfTsIF0u6z@yujie-X299>
Date:   Mon, 08 May 2023 11:36:37 +0200
Message-ID: <87mt2f2mhm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yujie!

On Sun, May 07 2023 at 16:05, Yujie Liu wrote:
> Sorry for late reply as we were on public holiday earlier this week.

Holidays are more important and the problems do not run away :)

> On Fri, Apr 28, 2023 at 12:31:14PM +0200, Thomas Gleixner wrote:
>> Under the assumption that the code is correct, then the effect of this
>> patch is that it changes the timing. Sigh.
>> 
>>   1) Does this happen with a 64-bit kernel too?
>
> It doesn't happen on a 64-bit kernel:

Ok. So one difference might be that a 64 bit kernel enables interrupt
rempping. Can you add 'intremap=off' to the kernel command line please?

>>   2) Can you enable the irq_vector:vector_*.* tracepoints and provide
>>      the trace?
>
> I'm a beginner of kernel and not sure if I'm doing this correctly. Here
> are my test steps:

They are perfectly fine.

> # check the trace
> # cat /sys/kernel/debug/tracing/trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 0/0   #P:4
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>
> Nothing was written to trace buffer, seems like no irq_vector events
> were captured during this test.

Stupid me. I completely forgot that this happens on the outgoing CPU at
a point where the tracer for that CPU is already shut down.

Can you please apply the patch below? No need to enable the irq_vector
events. It just dumps the information into dmesg.

Thanks,

        tglx
---
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -57,7 +57,8 @@ static bool migrate_one_irq(struct irq_d
 	bool maskchip = !irq_can_move_pcntxt(d) && !irqd_irq_masked(d);
 	const struct cpumask *affinity;
 	bool brokeaff = false;
-	int err;
+	int err, irq = d->irq;
+	bool move_pending;
 
 	/*
 	 * IRQ chip might be already torn down, but the irq descriptor is
@@ -101,10 +102,16 @@ static bool migrate_one_irq(struct irq_d
 	 * there is no move pending or the pending mask does not contain
 	 * any online CPU, use the current affinity mask.
 	 */
-	if (irq_fixup_move_pending(desc, true))
+	move_pending = irqd_is_setaffinity_pending(d);
+	if (irq_fixup_move_pending(desc, true)) {
 		affinity = irq_desc_get_pending_mask(desc);
-	else
+		pr_info("IRQ %3d: move_pending=%d pending mask: %*pbl\n",
+			irq, move_pending, cpumask_pr_args(affinity));
+	} else {
 		affinity = irq_data_get_affinity_mask(d);
+		pr_info("IRQ %3d: move_pending=%d affinity mask: %*pbl\n",
+			irq, move_pending, cpumask_pr_args(affinity));
+	}
 
 	/* Mask the chip for interrupts which cannot move in process context */
 	if (maskchip && chip->irq_mask)
@@ -136,6 +143,9 @@ static bool migrate_one_irq(struct irq_d
 		brokeaff = false;
 	}
 
+	affinity = irq_data_get_effective_affinity_mask(d);
+	pr_info("IRQ %3d: Done: %*pbl\n", irq, cpumask_pr_args(affinity));
+
 	if (maskchip && chip->irq_unmask)
 		chip->irq_unmask(d);
 


