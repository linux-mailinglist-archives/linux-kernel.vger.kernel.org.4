Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFFA7478AC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 21:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjGDTZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 15:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGDTZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 15:25:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90EB610D9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 12:25:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEB4615DB;
        Tue,  4 Jul 2023 12:26:17 -0700 (PDT)
Received: from bogus (unknown [10.57.76.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5715A3F663;
        Tue,  4 Jul 2023 12:25:32 -0700 (PDT)
Date:   Tue, 4 Jul 2023 20:25:29 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mostafa Saleh <smostafa@google.com>
Cc:     maz@kernel.org, oliver.upton@linux.dev,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, tabba@google.com, qperret@google.com,
        will@kernel.org, catalin.marinas@arm.com, yuzenghui@huawei.com,
        suzuki.poulose@arm.com, james.morse@arm.com, bgardon@google.com,
        gshan@redhat.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3] KVM: arm64: Use BTI for nvhe
Message-ID: <20230704192529.d4x2p7ndz2dc4q52@bogus>
References: <20230530150845.2856828-1-smostafa@google.com>
 <20230704134136.a5znw4jupt5yp5kg@bogus>
 <ZKQqIYRrckLlXqkx@google.com>
 <20230704143339.cqrvntq7rmmb2on3@bogus>
 <ZKRIWJKn7aVSOvjd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZKRIWJKn7aVSOvjd@google.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 04:27:04PM +0000, Mostafa Saleh wrote:
> Hi Sudeep,
> 
> On Tue, Jul 04, 2023 at 03:33:39PM +0100, Sudeep Holla wrote:
> > Hi Mostafa,
> > 
> > On Tue, Jul 04, 2023 at 02:18:09PM +0000, Mostafa Saleh wrote:
> > > Hi Sudeep,
> > > 
> > > On Tue, Jul 04, 2023 at 02:41:36PM +0100, Sudeep Holla wrote:
> > > > On Tue, May 30, 2023 at 03:08:45PM +0000, Mostafa Saleh wrote:
> > > > > CONFIG_ARM64_BTI_KERNEL compiles the kernel to support ARMv8.5-BTI.
> > > > > However, the nvhe code doesn't make use of it as it doesn't map any
> > > > > pages with Guarded Page(GP) bit.
> > > > > 
> > > > > kvm pgtable code is modified to map executable pages with GP bit
> > > > > if BTI is enabled for the kernel.
> > > > > 
> > > > > At hyp init, SCTLR_EL2.BT is set to 1 to match EL1 configuration
> > > > > (SCTLR_EL1.BT1) set in bti_enable().
> > > > > 
> > > > > One difference between kernel and nvhe code, is that the kernel maps
> > > > > .text with GP while nvhe maps all the executable pages, this makes
> > > > > nvhe code need to deal with special initialization code coming from
> > > > > other executable sections (.idmap.text).
> > > > > For this we need to add bti instruction at the beginning of
> > > > > __kvm_handle_stub_hvc as it can be called by  __host_hvc through
> > > > > branch instruction(br) and unlike SYM_FUNC_START, SYM_CODE_START
> > > > > doesn’t add bti instruction at the beginning, and it can’t be modified
> > > > > to add it as it is used with vector tables.
> > > > > Another solution which is more intrusive is to convert
> > > > > __kvm_handle_stub_hvc to a function and inject “bti jc” instead of
> > > > > “bti c” in SYM_FUNC_START
> > > > >
> > > > 
> > > > I was chasing a bug in linux-next yesterday with protected nVHE(pKVM) and
> > > > cpuidle enabled. The system fails to boot. I just bisected the issue to this
> > > > patch and also saw this patch landed in the linus tree yesterday/today.
> > > 
> > > One of the challenges of BTI is that we need to add explicit BTI instructions
> > > for assembly code. I checked the code to make sure that nothing was missing,
> > > but maybe this is not the case.
> > > Can you please share more about the issue (is ESR a Branch Target Exception,
> > > call stack...) if possible.
> > 
> > I haven't debugged it any further, just reported it as soon as I bisected it.
> > Reverting this get back the booting system. I am not sure if anything is going
> > wrong when the CPU is entering suspend(highly unlikely in normal scenario but
> > I am not so sure with pKVM trapping these PSCI calls now) or when it is woken
> > up and resuming back. IIUC this now will happen via kvm_hyp_cpu_resume->
> > __kvm_hyp_init_cpu->___kvm_hyp_init. 
> 
> Thanks a lot for the information.
> 
> I checked this now, and I believe I found an issue. I see that __kvm_hyp_init_cpu
> calls kvm_host_psci_cpu_entry indirectly and there is no BTI there.
> I think this is the only C function that needs special handling.
>

So it is in the wake up path. Thanks for the description, now I understand
the issue and fix better.

> Can you please check if this solves the issue?
>

Yes, the below patch fixed the issue. Feel free to add when you post the
formal patch.

Reported-and-Tested-by: Sudeep Holla <sudeep.holla@arm.com>

> diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
> index c87c63133e10..7df63f364c3c 100644
> --- a/arch/arm64/kvm/hyp/nvhe/host.S
> +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> @@ -297,3 +297,8 @@ SYM_CODE_START(__kvm_hyp_host_forward_smc)
>  
>         ret
>  SYM_CODE_END(__kvm_hyp_host_forward_smc)
> +
> +SYM_CODE_START(kvm_host_psci_cpu_entry)
> +       bti j
> +       b __kvm_host_psci_cpu_entry
> +SYM_CODE_END(kvm_host_psci_cpu_entry)
> diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> index 08508783ec3d..24543d2a3490 100644
> --- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> +++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> @@ -200,7 +200,7 @@ static int psci_system_suspend(u64 func_id, struct kvm_cpu_context *host_ctxt)
>                          __hyp_pa(init_params), 0);
>  }
>  
> -asmlinkage void __noreturn kvm_host_psci_cpu_entry(bool is_cpu_on)
> +asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
>  {
>         struct psci_boot_args *boot_args;
>         struct kvm_cpu_context *host_ctxt;
> 
> 
> > > Also, is this with CONFIG_ARM_PSCI_CPUIDLE?
> > 
> > Yes, basically the cpus can enter cpu_suspend which IIUC pKVM traps and
> > handle for the host.
> 
> My current setup has no CONFIG_ARM_PSCI_CPUIDLE?, I will try to find
> something I can test with.
>

No worries, I can help until you find one.


> > > 
> > > > Not sure if this is something to do with the fact that pKVM skips to
> > > > __kvm_handle_stub_hvc in __host_hvc.
> > 
> > Sorry, my bad. I meant pKVM skips calling __kvm_handle_stub_hvc in __host_hvc
> > and jumps to __host_exit directly. Sorry for that, one wrong "to" changed the
> > whole meaning.
> 
> I don't see an issue in this, as this path has no indirect branches.
>

Understood.

-- 
Regards,
Sudeep
