Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508F169D309
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 19:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjBTSqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 13:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjBTSqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 13:46:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A432F206B2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676918726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m2vFhn7t5tTwlRY2KgZYkIDGVjOFCQRkUrMdOBQQfYk=;
        b=ciAbJzXtfy7lMzhTgkNlhM5cGof/V6lo0PHyLFOe+fDstxouUPnX8eP7/AjUpSTntLJocI
        jpKlAc/sGM714U2hGW60VlMFwFFnZqI9+CqMFvtSN+HOcGVwwsHPfum1e88nvs0983bntK
        o6iAEgkfs9D9qx3hJUFEa1Wa/AoQeio=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-417-PiagnEHCMuOmpLS6v_DhUQ-1; Mon, 20 Feb 2023 13:45:18 -0500
X-MC-Unique: PiagnEHCMuOmpLS6v_DhUQ-1
Received: by mail-ed1-f70.google.com with SMTP id dk16-20020a0564021d9000b004aaa054d189so2469420edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2vFhn7t5tTwlRY2KgZYkIDGVjOFCQRkUrMdOBQQfYk=;
        b=LholoUteHIwrAOyn0j+dkJZKakdflb4/Mtz1dwqI6fXed+t/A3K+ASP4dh63yZCmK8
         +5iMIdkLWjSEe3+RFTHeSoZ8x5vElx7eqFfBesrOhmZ2ZDZ4rYs0fyLOOxTHGu8kE5C6
         V+Qj7Pt7S7kltXG6mkjB+9J8uUpV7S+CLTKQN2b8Y6P38df9ohPNP3j2aUc8WgqT3QNh
         jIGGYHa3cr1Up7iFcvF5sR2OgKfHirDi+etGRae1fNcEBla8tFD+MZb7g1Ufc4M1jwgl
         VCRF/VczRFghSeDPkQz0HJHcrK/ZTKKHEYMBDAvsostLZbd8EDI/5s3Gq9VJtunrlBNE
         NPLQ==
X-Gm-Message-State: AO0yUKUKk7fraLVeRxSv4WdV7d2XblqdPEXAak1jvD+6AJfWu540ToXR
        hchXTJNkcdqNdSTb/4CHXPBHVO3PZ6VyoM1G/VH2VQn2CNYgPkNuQEUF5VDgFceIXQptPEtK0BS
        bKcWcQFAoT1fOmoTBVUaN5/9h
X-Received: by 2002:aa7:de99:0:b0:4ad:8fc7:76db with SMTP id j25-20020aa7de99000000b004ad8fc776dbmr1703385edv.36.1676918717072;
        Mon, 20 Feb 2023 10:45:17 -0800 (PST)
X-Google-Smtp-Source: AK7set9E6TCSVTn6bfP1N1j0XVnsM2kC+uO9GjLfyWWpTDZNEIwmetLbyvbD8dAXXLs2i9/y0H+5mg==
X-Received: by 2002:aa7:de99:0:b0:4ad:8fc7:76db with SMTP id j25-20020aa7de99000000b004ad8fc776dbmr1703365edv.36.1676918716802;
        Mon, 20 Feb 2023 10:45:16 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:4783:a68:c1ee:15c5? ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
        by smtp.googlemail.com with ESMTPSA id b10-20020a056402278a00b004aee606432dsm1479350ede.83.2023.02.20.10.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 10:45:16 -0800 (PST)
Message-ID: <f6bb5bdd-c058-b76e-d743-f83c99ee45f5@redhat.com>
Date:   Mon, 20 Feb 2023 19:45:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Tianrui Zhao <zhaotianrui@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn
References: <20230220065735.1282809-1-zhaotianrui@loongson.cn>
 <20230220065735.1282809-9-zhaotianrui@loongson.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 08/29] LoongArch: KVM: Implement vcpu handle exit
 interface
In-Reply-To: <20230220065735.1282809-9-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/23 07:57, Tianrui Zhao wrote:
> + * Return value is in the form (errcode<<2 | RESUME_FLAG_HOST | RESUME_FLAG_NV)

As far as I can see, RESUME_FLAG_NV does not exist anymore and this is 
just copied from arch/mips?

You can keep RESUME_HOST/RESUME_GUEST for the individual functions, but 
here please make it just "1" for resume guest, and "<= 0" for resume 
host.  This is easy enough to check from assembly and removes the srai by 2.

> +static int _kvm_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
> +{
> +	unsigned long exst = vcpu->arch.host_estat;
> +	u32 intr = exst & 0x1fff; /* ignore NMI */
> +	u32 exccode = (exst & CSR_ESTAT_EXC) >> CSR_ESTAT_EXC_SHIFT;
> +	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
> +	int ret = RESUME_GUEST, cpu;
> +
> +	vcpu->mode = OUTSIDE_GUEST_MODE;
> +
> +	/* Set a default exit reason */
> +	run->exit_reason = KVM_EXIT_UNKNOWN;
> +	run->ready_for_interrupt_injection = 1;
> +
> +	/*
> +	 * Set the appropriate status bits based on host CPU features,
> +	 * before we hit the scheduler
> +	 */

Stale comment?

> +	local_irq_enable();

Please add guest_state_exit_irqoff() here.

> +	kvm_debug("%s: exst: %lx, PC: %p, kvm_run: %p, kvm_vcpu: %p\n",
> +			__func__, exst, opc, run, vcpu);

Please add the information to the kvm_exit tracepoint (thus also 
removing variables such as "exst" or "opc" from this function) instead 
of calling kvm_debug().

> +	trace_kvm_exit(vcpu, exccode);
> +	if (exccode) {
> +		ret = _kvm_handle_fault(vcpu, exccode);
> +	} else {
> +		WARN(!intr, "suspicious vm exiting");
> +		++vcpu->stat.int_exits;
> +
> +		if (need_resched())
> +			cond_resched();

This "if" is not necessary because there is already a cond_resched() below.

> +		ret = RESUME_GUEST;

This "ret" is not necessary because "ret" is already initialized to 
RESUME_GUEST above, you can either remove it or remove the initializer.

> +	}
> +
> +	cond_resched();
> +	local_irq_disable();

At this point, ret is either RESUME_GUEST or RESUME_HOST.  So, the "if"s 
below are either all taken or all not taken, and most of this code:

	kvm_acquire_timer(vcpu);
	_kvm_deliver_intr(vcpu);

	if (signal_pending(current)) {
		run->exit_reason = KVM_EXIT_INTR;
		ret = (-EINTR << 2) | RESUME_HOST;
		++vcpu->stat.signal_exits;
		// no need for a tracepoint here
		// trace_kvm_exit(vcpu, KVM_TRACE_EXIT_SIGNAL);
	}

	trace_kvm_reenter(vcpu);

	/*
	 * Make sure the read of VCPU requests in vcpu_reenter()
	 * callback is not reordered ahead of the write to vcpu->mode,
	 * or we could miss a TLB flush request while the requester sees
	 * the VCPU as outside of guest mode and not needing an IPI.
	 */
	smp_store_mb(vcpu->mode, IN_GUEST_MODE);

	cpu = smp_processor_id();
	_kvm_check_requests(vcpu, cpu);
	_kvm_check_vmid(vcpu, cpu);
	vcpu->arch.host_eentry = csr_read64(LOONGARCH_CSR_EENTRY);

	/*
	 * If FPU are enabled (i.e. the guest's FPU context
	 * is live), restore FCSR0.
	 */
	if (_kvm_guest_has_fpu(&vcpu->arch) &&
		read_csr_euen() & (CSR_EUEN_FPEN)) {
		kvm_restore_fcsr(&vcpu->arch.fpu);
	}

(all except for the "if (signal_pending(current))" and the final "if") 
is pretty much duplicated with kvm_arch_vcpu_ioctl_run(); the remaining 
code can also be done from kvm_arch_vcpu_ioctl_run(), the cost is small. 
  Please move it to a separate function, for example:

int kvm_pre_enter_guest(struct kvm_vcpu *vcpu)
{
	if (signal_pending(current)) {
		run->exit_reason = KVM_EXIT_INTR;
		++vcpu->stat.signal_exits;
		return -EINTR;
	}

	kvm_acquire_timer(vcpu);
	_kvm_deliver_intr(vcpu);

	...

	if (_kvm_guest_has_fpu(&vcpu->arch) &&
		read_csr_euen() & (CSR_EUEN_FPEN)) {
		kvm_restore_fcsr(&vcpu->arch.fpu);
	}
	return 1;
}

Call it from _kvm_handle_exit():

	if (ret == RESUME_HOST)
		return 0;

	r = kvm_pre_enter_guest(vcpu);
	if (r > 0) {
		trace_kvm_reenter(vcpu);
		guest_state_enter_irqoff();
	}

	return r;

and from kvm_arch_vcpu_ioctl_run():

	local_irq_disable();
	guest_timing_enter_irqoff();
	r = kvm_pre_enter_guest(vcpu);
	if (r > 0) {
		trace_kvm_enter(vcpu);
		/*
		 * This should actually not be a function pointer, but
		 * just for clarity */
		 */
		guest_state_enter_irqoff();
		r = vcpu->arch.vcpu_run(run, vcpu);
		/* guest_state_exit_irqoff() already done.  */
		trace_kvm_out(vcpu);
	}
	guest_timing_exit_irqoff();
	local_irq_enable();

out:
	kvm_sigset_deactivate(vcpu);

	vcpu_put(vcpu);
	return r;

Paolo

> +	if (ret == RESUME_GUEST)
> +		kvm_acquire_timer(vcpu);
> +
> +	if (!(ret & RESUME_HOST)) {
> +		_kvm_deliver_intr(vcpu);
> +		/* Only check for signals if not already exiting to userspace */
> +		if (signal_pending(current)) {
> +			run->exit_reason = KVM_EXIT_INTR;
> +			ret = (-EINTR << 2) | RESUME_HOST;
> +			++vcpu->stat.signal_exits;
> +			trace_kvm_exit(vcpu, KVM_TRACE_EXIT_SIGNAL);
> +		}
> +	}
> +
> +	if (ret == RESUME_GUEST) {
> +		trace_kvm_reenter(vcpu);
> +
> +		/*
> +		 * Make sure the read of VCPU requests in vcpu_reenter()
> +		 * callback is not reordered ahead of the write to vcpu->mode,
> +		 * or we could miss a TLB flush request while the requester sees
> +		 * the VCPU as outside of guest mode and not needing an IPI.
> +		 */
> +		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
> +
> +		cpu = smp_processor_id();
> +		_kvm_check_requests(vcpu, cpu);
> +		_kvm_check_vmid(vcpu, cpu);
> +		vcpu->arch.host_eentry = csr_read64(LOONGARCH_CSR_EENTRY);
> +
> +		/*
> +		 * If FPU are enabled (i.e. the guest's FPU context
> +		 * is live), restore FCSR0.
> +		 */
> +		if (_kvm_guest_has_fpu(&vcpu->arch) &&
> +			read_csr_euen() & (CSR_EUEN_FPEN)) {
> +			kvm_restore_fcsr(&vcpu->arch.fpu);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>   int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>   {
>   	int i;

