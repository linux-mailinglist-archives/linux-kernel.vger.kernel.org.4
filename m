Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A02B6B4DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjCJRCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjCJRB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:01:59 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571953A87
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:00:03 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id i22-20020aa787d6000000b0061dda189477so3164575pfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678467602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=96VhZad7fau15RxlhATOVUVG6AhXrzUQgEwbilYaxXk=;
        b=PhqamPCq0kh+yF3ufPBTjFXe3496VSnG0W5rK2v0utOj9XkQbZD1dO5O+po+IeDBBL
         PtlP4GZ1vwmQoDNXtsNXpwDkhw+2ZwJy/HIM6+EUPXQJ1zVbVP3LXkDsolaqMqs9lRgL
         KLOnVcM2XZ1oQpobzY2gI35dLm7cfMD6nd5oVDOXhwKEx7p0PsMMOdiEvyDfjIjFtHuA
         RPARCpCPP2qbwsTYq9uAnHcJjb9cv3oz/sn6ORVdrXaZVprrrp5lWAalEUV3lH2Ry2X/
         xkXG/eXpnrbDEQbjVq6YRkr9uwKwFPPYvIX0WIs797BlnFl4N0kRkyHLT8BTvZSqto69
         anow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678467602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96VhZad7fau15RxlhATOVUVG6AhXrzUQgEwbilYaxXk=;
        b=1Yau2MCJBoLftXd0tj4IIAdPrY7aP5JGCqGO/m/cypJ35BeS1Ikr9riu4fRjmR+utY
         N8RZ/d9J2RO1BEG7wNgmtMsCcjqPfkV8OhB4Ij+016G3K0sXRuhdBEGsmKFJWYqqdmvw
         2PXMK41pm8Z96Y72vtgKAFccCzIdrMN4hSJghoMwVblF+ra+uNUnlIBbykyp/SkmBa53
         /6VIbQyi7Mz+9holSgLym6v1gLLktj+KRooZZ5rfFD1LaAuJtuRhNCRsVYI3arWvq7Yb
         GR0VyHeHfBobJ5d+ppBA0PWtjePocEPh1mG4zeS6XDi3uCbCjcUOmqk1n+f4k1i3uMZ9
         /CsQ==
X-Gm-Message-State: AO0yUKUnPQhiNovmKGViSVAUxT8kw/b6MW7FBICJZRtenm3oLXWuKWcW
        Jzh/NlBlMKB+AVUMTbwvQ874ykJw2S4=
X-Google-Smtp-Source: AK7set9h7gaS3jxJCUMG+EcVAtd9dHw0FAmSFp99EKPwLsuL99BYlkQvtJ6TlNqsXjHaT4N6zQQEB0RgkKc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:420f:b0:234:13d8:ed5b with SMTP id
 o15-20020a17090a420f00b0023413d8ed5bmr9611955pjg.3.1678467602246; Fri, 10 Mar
 2023 09:00:02 -0800 (PST)
Date:   Fri, 10 Mar 2023 09:00:00 -0800
In-Reply-To: <20230310155955.29652-1-yan.y.zhao@intel.com>
Mime-Version: 1.0
References: <20230310155955.29652-1-yan.y.zhao@intel.com>
Message-ID: <ZAtiEO/DST05GRRN@google.com>
Subject: Re: [PATCH] KVM: VMX: fix lockdep warning on posted intr wakeup
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023, Yan Zhao wrote:
> Use rcu list to break the possible circular locking dependency reported
> by lockdep.
> 
> path 1, ``sysvec_kvm_posted_intr_wakeup_ipi()`` --> ``pi_wakeup_handler()``
>          -->  ``kvm_vcpu_wake_up()`` --> ``try_to_wake_up()``,
>          the lock sequence is
>          &per_cpu(wakeup_vcpus_on_cpu_lock, cpu) --> &p->pi_lock.

Heh, that's an unfortunate naming collision.  It took me a bit of staring to
realize pi_lock is a scheduler lock, not a posted interrupt lock.

> path 2, ``schedule()`` --> ``kvm_sched_out()`` --> ``vmx_vcpu_put()`` -->
>         ``vmx_vcpu_pi_put()`` --> ``pi_enable_wakeup_handler()``,
>          the lock sequence is
>          &rq->__lock --> &per_cpu(wakeup_vcpus_on_cpu_lock, cpu).
> 
> path 3, ``task_rq_lock()``,
>         the lock sequence is &p->pi_lock --> &rq->__lock
> 
> lockdep report:
>  Chain exists of:
>    &p->pi_lock --> &rq->__lock --> &per_cpu(wakeup_vcpus_on_cpu_lock, cpu)
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                CPU1
>         ----                ----
>    lock(&per_cpu(wakeup_vcpus_on_cpu_lock, cpu));
>                             lock(&rq->__lock);
>                             lock(&per_cpu(wakeup_vcpus_on_cpu_lock, cpu));
>    lock(&p->pi_lock);
> 
>   *** DEADLOCK ***

I don't think there's a deadlock here.  pi_wakeup_handler() is called from IRQ
context, pi_enable_wakeup_handler() disable IRQs before acquiring
wakeup_vcpus_on_cpu_lock, and "cpu" in pi_enable_wakeup_handler() is guaranteed
to be the current CPU, i.e. the same CPU.  So CPU0 and CPU1 can't be contending
for the same wakeup_vcpus_on_cpu_lock in this scenario.

vmx_vcpu_pi_load() does do cross-CPU locking, but finish_task_switch() drops
rq->__lock before invoking the sched_in notifiers.

> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  arch/x86/kvm/vmx/posted_intr.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
> index 94c38bea60e7..e3ffc45c0a7b 100644
> --- a/arch/x86/kvm/vmx/posted_intr.c
> +++ b/arch/x86/kvm/vmx/posted_intr.c
> @@ -90,7 +90,7 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
>  	 */
>  	if (pi_desc->nv == POSTED_INTR_WAKEUP_VECTOR) {
>  		raw_spin_lock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
> -		list_del(&vmx->pi_wakeup_list);
> +		list_del_rcu(&vmx->pi_wakeup_list);
>  		raw_spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));

_If_ there is indeed a possible deadlock, there technically needs to be an explicit 
synchonize_rcu() before freeing the vCPU.  In practice, there are probably multiple
synchonize_rcu() calls in the destruction path, not to mention that it would take a
minor miracle for pi_wakeup_handler() to get stalled long enough to achieve a
use-after-free.

>  	}
>  
> @@ -153,7 +153,7 @@ static void pi_enable_wakeup_handler(struct kvm_vcpu *vcpu)
>  	local_irq_save(flags);
>  
>  	raw_spin_lock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
> -	list_add_tail(&vmx->pi_wakeup_list,
> +	list_add_tail_rcu(&vmx->pi_wakeup_list,
>  		      &per_cpu(wakeup_vcpus_on_cpu, vcpu->cpu));
>  	raw_spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));


> @@ -219,16 +219,14 @@ void pi_wakeup_handler(void)
>  {
>  	int cpu = smp_processor_id();
>  	struct list_head *wakeup_list = &per_cpu(wakeup_vcpus_on_cpu, cpu);
> -	raw_spinlock_t *spinlock = &per_cpu(wakeup_vcpus_on_cpu_lock, cpu);
>  	struct vcpu_vmx *vmx;
>  
> -	raw_spin_lock(spinlock);
> -	list_for_each_entry(vmx, wakeup_list, pi_wakeup_list) {
> -
> +	rcu_read_lock();

This isn't strictly necessary, IRQs are disabled.

> +	list_for_each_entry_rcu(vmx, wakeup_list, pi_wakeup_list) {
>  		if (pi_test_on(&vmx->pi_desc))
>  			kvm_vcpu_wake_up(&vmx->vcpu);
>  	}
> -	raw_spin_unlock(spinlock);
> +	rcu_read_unlock();
>  }
>  
>  void __init pi_init_cpu(int cpu)
> 
> base-commit: 89400df96a7570b651404bbc3b7afe627c52a192
> -- 
> 2.17.1
> 
