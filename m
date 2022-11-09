Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A26622757
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiKIJmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiKIJmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:42:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A12CE36;
        Wed,  9 Nov 2022 01:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jlIZaaSJIR4LiHnUtZng5vtJ+u+uFUe9yS9JZEQlzUA=; b=cnKBWsglZbyYyrp41/ddrrcDR9
        1liTQ3whyKdsfyOCXTExSWXJicVnjq6VEVVREaIpkFJyxMYBGbjd3JMwMKpV9dYAcVRo/qa4hHVSD
        ZKmcRrgFc0llzAc5yq/06c1abegSQAdh0LOjPyxK990Ih8a569JHz2ksh4LW/tMju5xFrPooJVR74
        r9ZUYixGF/NtwS2odB+4QD0r90NR6iByCcAf4ZFVYo6llt5kQLnaBubFW9Vmwt4aSWijcFcDrhZxS
        0iJYAfn7S4ead4CRD0wlZPPMmz6/MC4ccFnZszyDGwf0SOEXp5ErMf7gPpZDoRuVghAb9AvakUHvY
        RPmEObjA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oshbY-00B4c3-HJ; Wed, 09 Nov 2022 09:42:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C03AD300137;
        Wed,  9 Nov 2022 10:42:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A03A02BD856FF; Wed,  9 Nov 2022 10:42:37 +0100 (CET)
Date:   Wed, 9 Nov 2022 10:42:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>
Subject: Re: [PATCH v5 08/24] sched: Introduce per memory space current
 virtual cpu id
Message-ID: <Y2t2DcHHLVB3tDfw@hirez.programming.kicks-ass.net>
References: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
 <20221103200359.328736-9-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103200359.328736-9-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 04:03:43PM -0400, Mathieu Desnoyers wrote:

> +void sched_vcpu_exit_signals(struct task_struct *t)
> +{
> +	struct mm_struct *mm = t->mm;
> +	unsigned long flags;
> +
> +	if (!mm)
> +		return;
> +	local_irq_save(flags);
> +	mm_vcpu_put(mm, t->mm_vcpu);
> +	t->mm_vcpu = -1;
> +	t->mm_vcpu_active = 0;
> +	local_irq_restore(flags);
> +}
> +
> +void sched_vcpu_before_execve(struct task_struct *t)
> +{
> +	struct mm_struct *mm = t->mm;
> +	unsigned long flags;
> +
> +	if (!mm)
> +		return;
> +	local_irq_save(flags);
> +	mm_vcpu_put(mm, t->mm_vcpu);
> +	t->mm_vcpu = -1;
> +	t->mm_vcpu_active = 0;
> +	local_irq_restore(flags);
> +}
> +
> +void sched_vcpu_after_execve(struct task_struct *t)
> +{
> +	struct mm_struct *mm = t->mm;
> +	unsigned long flags;
> +
> +	WARN_ON_ONCE((t->flags & PF_KTHREAD) || !t->mm);
> +
> +	local_irq_save(flags);
> +	t->mm_vcpu = mm_vcpu_get(mm);
> +	t->mm_vcpu_active = 1;
> +	local_irq_restore(flags);
> +	rseq_set_notify_resume(t);
> +}

> +static inline void mm_vcpu_put(struct mm_struct *mm, int vcpu)
> +{
> +	lockdep_assert_irqs_disabled();
> +	if (vcpu < 0)
> +		return;
> +	spin_lock(&mm->vcpu_lock);
> +	__cpumask_clear_cpu(vcpu, mm_vcpumask(mm));
> +	spin_unlock(&mm->vcpu_lock);
> +}
> +
> +static inline int mm_vcpu_get(struct mm_struct *mm)
> +{
> +	int ret;
> +
> +	lockdep_assert_irqs_disabled();
> +	spin_lock(&mm->vcpu_lock);
> +	ret = __mm_vcpu_get(mm);
> +	spin_unlock(&mm->vcpu_lock);
> +	return ret;
> +}


This:

	local_irq_disable()
	spin_lock()

thing is a PREEMPT_RT anti-pattern.

At the very very least this should then be raw_spin_lock(), not in the
least because you're calling this from under rq->lock, which itself is a
raw_spin_lock_t.

