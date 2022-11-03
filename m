Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8A661829B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiKCPYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiKCPYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C3A22C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667488999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ex9w6AF29xEwpNLs+Jj1aaojn2ZZjhH0ZX9iUoTOfgc=;
        b=JYIcN4Qvut2ueP8N4RFbgV0SYq5S8nvRybbNe2ttD9jexTpnOj2XngkrGJD88PEFd9PSiO
        khIJaLvEJXZECQvfBP2WCcEPF4mGZDl/ojdIeFDtnqLr+D9EM85KqMhDa91FrMO3n72YH3
        QJLdpwtvDAncQDbMJaVB0ruJZizXNQ0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-151-87E8odr_MsGkVLC5oM3wYg-1; Thu, 03 Nov 2022 11:23:18 -0400
X-MC-Unique: 87E8odr_MsGkVLC5oM3wYg-1
Received: by mail-ed1-f69.google.com with SMTP id r12-20020a05640251cc00b00463699c95aeso1595234edd.18
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 08:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ex9w6AF29xEwpNLs+Jj1aaojn2ZZjhH0ZX9iUoTOfgc=;
        b=ZoHhlAYciVO3EZMz/kLsaqD1LOPhfTXSNlp2ZDtlpXAEpMxa/asskrrP/vbo57TPsl
         Tp0M1dqKI2KIDcTK/betS85U0ZIEXVg8ayFdEPGzXGu2QYnhDxqsoNZl+edPrOvk+9a5
         OH767Fcpc85J61UncfTT1NNsnTBXlh7HHwtKmxG2Q7QVzcjE6bXMs8vvz42Uaift6bZF
         L3CckMGtWQvxd6gHwvpCytm8qnppmDdRgx87Ox1OY2p6lzpehsLsDgLF/Gfs6g8T6rFn
         nEeFXkMf0aLwP6mhCVQKzx966jDy3mL93qxIb8MkUiymjuC4w8VoCnmGfuir2cAUxlsH
         7ZkQ==
X-Gm-Message-State: ACrzQf1ULSUVIKGKfRjI1UBmFIs4Wfpf+kbCynzpaVX6Xr4RK1+5rm2+
        yaPVU3+8KJ9iXWmNo8dHvvNAu/jDCuzU8lDG2w3gigwhJlHAw1UlV/svEhjPAm9BcGEDHOcn6u0
        nna5RiZBgNc1tJJHkV5TwTLfw
X-Received: by 2002:a17:907:8a07:b0:7ad:e111:9f1f with SMTP id sc7-20020a1709078a0700b007ade1119f1fmr18706630ejc.748.1667488996693;
        Thu, 03 Nov 2022 08:23:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7w/ZtXgKJ7V+2Z8oeupCi1g9Jll17Pmqv+y4uPqlw3EJEEB8/pAd5jt1iBgMRagb/0UlEDkg==
X-Received: by 2002:a17:907:8a07:b0:7ad:e111:9f1f with SMTP id sc7-20020a1709078a0700b007ade1119f1fmr18706603ejc.748.1667488996425;
        Thu, 03 Nov 2022 08:23:16 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id 9-20020a170906218900b007a9c3831409sm596520eju.137.2022.11.03.08.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 08:23:15 -0700 (PDT)
Message-ID: <7b6ce80e-7f1f-11cd-8bde-8d8fa9fd7e1d@redhat.com>
Date:   Thu, 3 Nov 2022 16:23:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 39/44] KVM: Drop kvm_count_lock and instead protect
 kvm_usage_count with kvm_lock
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuan Yao <yuan.yao@intel.com>
References: <20221102231911.3107438-1-seanjc@google.com>
 <20221102231911.3107438-40-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221102231911.3107438-40-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/22 00:19, Sean Christopherson wrote:
> +- kvm_lock is taken outside kvm->mmu_lock

Not surprising since one is a mutex and one is an rwlock. :)  You can 
drop this hunk as well as the "Opportunistically update KVM's locking 
documentation" sentence in the commit message.

>   - vcpu->mutex is taken outside kvm->arch.hyperv.hv_lock
>   
>   - kvm->arch.mmu_lock is an rwlock.  kvm->arch.tdp_mmu_pages_lock and
> @@ -216,15 +220,11 @@ time it will be set using the Dirty tracking mechanism described above.
>   :Type:		mutex
>   :Arch:		any
>   :Protects:	- vm_list
> -
> -``kvm_count_lock``
> -^^^^^^^^^^^^^^^^^^
> -
> -:Type:		raw_spinlock_t
> -:Arch:		any
> -:Protects:	- hardware virtualization enable/disable
> -:Comment:	'raw' because hardware enabling/disabling must be atomic /wrt
> -		migration.
> +		- kvm_usage_count
> +		- hardware virtualization enable/disable
> +		- module probing (x86 only)

What do you mean exactly by "module probing"?  Is it anything else than 
what is serialized by vendor_module_lock?

Paolo

> +:Comment:	KVM also disables CPU hotplug via cpus_read_lock() during
> +		enable/disable.
>   
>   ``kvm->mn_invalidate_lock``
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 4e765ef9f4bd..c8d92e6c3922 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -100,7 +100,6 @@ EXPORT_SYMBOL_GPL(halt_poll_ns_shrink);
>    */
>   
>   DEFINE_MUTEX(kvm_lock);
> -static DEFINE_RAW_SPINLOCK(kvm_count_lock);
>   LIST_HEAD(vm_list);
>   
>   static cpumask_var_t cpus_hardware_enabled;
> @@ -5028,9 +5027,10 @@ static void hardware_enable_nolock(void *junk)
>   
>   static int kvm_online_cpu(unsigned int cpu)
>   {
> +	unsigned long flags;
>   	int ret = 0;
>   
> -	raw_spin_lock(&kvm_count_lock);
> +	mutex_lock(&kvm_lock);
>   	/*
>   	 * Abort the CPU online process if hardware virtualization cannot
>   	 * be enabled. Otherwise running VMs would encounter unrecoverable
> @@ -5039,13 +5039,16 @@ static int kvm_online_cpu(unsigned int cpu)
>   	if (kvm_usage_count) {
>   		WARN_ON_ONCE(atomic_read(&hardware_enable_failed));
>   
> +		local_irq_save(flags);
>   		hardware_enable_nolock(NULL);
> +		local_irq_restore(flags);
> +
>   		if (atomic_read(&hardware_enable_failed)) {
>   			atomic_set(&hardware_enable_failed, 0);
>   			ret = -EIO;
>   		}
>   	}
> -	raw_spin_unlock(&kvm_count_lock);
> +	mutex_unlock(&kvm_lock);
>   	return ret;
>   }
>   
> @@ -5061,10 +5064,13 @@ static void hardware_disable_nolock(void *junk)
>   
>   static int kvm_offline_cpu(unsigned int cpu)
>   {
> -	raw_spin_lock(&kvm_count_lock);
> -	if (kvm_usage_count)
> +	mutex_lock(&kvm_lock);
> +	if (kvm_usage_count) {
> +		preempt_disable();
>   		hardware_disable_nolock(NULL);
> -	raw_spin_unlock(&kvm_count_lock);
> +		preempt_enable();
> +	}
> +	mutex_unlock(&kvm_lock);
>   	return 0;
>   }
>   
> @@ -5079,9 +5085,11 @@ static void hardware_disable_all_nolock(void)
>   
>   static void hardware_disable_all(void)
>   {
> -	raw_spin_lock(&kvm_count_lock);
> +	cpus_read_lock();
> +	mutex_lock(&kvm_lock);
>   	hardware_disable_all_nolock();
> -	raw_spin_unlock(&kvm_count_lock);
> +	mutex_unlock(&kvm_lock);
> +	cpus_read_unlock();
>   }
>   
>   static int hardware_enable_all(void)
> @@ -5097,7 +5105,7 @@ static int hardware_enable_all(void)
>   	 * Disable CPU hotplug to prevent scenarios where KVM sees
>   	 */
>   	cpus_read_lock();
> -	raw_spin_lock(&kvm_count_lock);
> +	mutex_lock(&kvm_lock);
>   
>   	kvm_usage_count++;
>   	if (kvm_usage_count == 1) {
> @@ -5110,7 +5118,7 @@ static int hardware_enable_all(void)
>   		}
>   	}
>   
> -	raw_spin_unlock(&kvm_count_lock);
> +	mutex_unlock(&kvm_lock);
>   	cpus_read_unlock();
>   
>   	return r;
> @@ -5716,6 +5724,15 @@ static void kvm_init_debug(void)
>   
>   static int kvm_suspend(void)
>   {
> +	/*
> +	 * Secondary CPUs and CPU hotplug are disabled across the suspend/resume
> +	 * callbacks, i.e. no need to acquire kvm_lock to ensure the usage count
> +	 * is stable.  Assert that kvm_lock is not held as a paranoid sanity
> +	 * check that the system isn't suspended when KVM is enabling hardware.
> +	 */
> +	lockdep_assert_not_held(&kvm_lock);
> +	lockdep_assert_irqs_disabled();
> +
>   	if (kvm_usage_count)
>   		hardware_disable_nolock(NULL);
>   	return 0;
> @@ -5723,10 +5740,11 @@ static int kvm_suspend(void)
>   
>   static void kvm_resume(void)
>   {
> -	if (kvm_usage_count) {
> -		lockdep_assert_not_held(&kvm_count_lock);
> +	lockdep_assert_not_held(&kvm_lock);
> +	lockdep_assert_irqs_disabled();
> +
> +	if (kvm_usage_count)
>   		hardware_enable_nolock(NULL);
> -	}
>   }
>   
>   static struct syscore_ops kvm_syscore_ops = {

