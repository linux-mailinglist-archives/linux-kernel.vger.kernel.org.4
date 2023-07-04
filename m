Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1209747683
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjGDQ1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjGDQ1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:27:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED281704
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 09:27:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so218215e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 09:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688488029; x=1691080029;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OwQr9W55X8RNR2CtPf2qZuGcHu62lyr7ZUFMcJnQdtM=;
        b=dEpRBkMSbilzHcQr1TMq36A+As+SAUWyE6TsMGiKt2KbeS3xIsT0UMjIQP7a83WnQ5
         hAzTGdi1L7TCDYZfNqN4VOGkKIrZVJeCiu0zGQ+PCHQeCWWV/aVPnnR3xfXpoC1AD+rK
         1aZmz+VfUe3T/ILRj2BcIGe2ymiFj3YJLcnAtpprZwSysOC6eaYshs+VBhth48cCvfoN
         pfKVKpLWAowNo+puq6121BYciZI7feJo4QY3UI/ux8+7lSUc26wQDxlIOK7RnoMW0Gdf
         se3NJQuiFW6oQdHiSMwrS1H+xguvlnTTT4SKCpcxVbl4oLoBevwT9cznGXmS9NRry4Gg
         Cn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688488029; x=1691080029;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwQr9W55X8RNR2CtPf2qZuGcHu62lyr7ZUFMcJnQdtM=;
        b=lw9hDGJqGOGFaGbb7jYY2K/yzryBegskdxdG9CFMCOZGeOzZixU0boNh3OBDk4Eue5
         6/dz4XgfXhJ7C5lATf3bRU6EwM+aCzHuccurNXa/eXqn9TkbOswV2hQ50/h+sKzC4Yx5
         VKsSfWZ0NXw37/hyD52PaOGdcGuUZDtvBnmz69pC7JZIExPaQWKxtI9Yd5IRYOQxwIQw
         RRFkUnQmeByjZFZKqyA81JFvRVNAy5o6uKEEeGyvlaD8GfbjCY2VrxSSRhwjxhAzMsuo
         qDNGGpRtvyVEslYbli9ckigocx93wqvxXSHchGI8+86LBOCxBhRUoWRTapSYxWFEsyS9
         DSIw==
X-Gm-Message-State: ABy/qLa20KcjF3S3WbqRbF9o3mzr0jCLxNkWLhtd5VUlScVGVHpmbnQc
        NBIQQezsnN4gHCCbtA+nusrbBw==
X-Google-Smtp-Source: APBJJlE/AWwOljtrJpRMbdFlc2ytul4cxt3bN0oyBiY21F7m9kugng668rUy4tPk1a6xsNgtqZdjWg==
X-Received: by 2002:a05:600c:4f49:b0:3f1:9a3d:4f7f with SMTP id m9-20020a05600c4f4900b003f19a3d4f7fmr79554wmq.1.1688488029067;
        Tue, 04 Jul 2023 09:27:09 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id y19-20020a05600c365300b003fa8dbb7b5dsm26836778wmq.25.2023.07.04.09.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:27:08 -0700 (PDT)
Date:   Tue, 4 Jul 2023 16:27:04 +0000
From:   Mostafa Saleh <smostafa@google.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     maz@kernel.org, oliver.upton@linux.dev,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, tabba@google.com, qperret@google.com,
        will@kernel.org, catalin.marinas@arm.com, yuzenghui@huawei.com,
        suzuki.poulose@arm.com, james.morse@arm.com, bgardon@google.com,
        gshan@redhat.com
Subject: Re: [PATCH v3] KVM: arm64: Use BTI for nvhe
Message-ID: <ZKRIWJKn7aVSOvjd@google.com>
References: <20230530150845.2856828-1-smostafa@google.com>
 <20230704134136.a5znw4jupt5yp5kg@bogus>
 <ZKQqIYRrckLlXqkx@google.com>
 <20230704143339.cqrvntq7rmmb2on3@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230704143339.cqrvntq7rmmb2on3@bogus>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Tue, Jul 04, 2023 at 03:33:39PM +0100, Sudeep Holla wrote:
> Hi Mostafa,
> 
> On Tue, Jul 04, 2023 at 02:18:09PM +0000, Mostafa Saleh wrote:
> > Hi Sudeep,
> > 
> > On Tue, Jul 04, 2023 at 02:41:36PM +0100, Sudeep Holla wrote:
> > > On Tue, May 30, 2023 at 03:08:45PM +0000, Mostafa Saleh wrote:
> > > > CONFIG_ARM64_BTI_KERNEL compiles the kernel to support ARMv8.5-BTI.
> > > > However, the nvhe code doesn't make use of it as it doesn't map any
> > > > pages with Guarded Page(GP) bit.
> > > > 
> > > > kvm pgtable code is modified to map executable pages with GP bit
> > > > if BTI is enabled for the kernel.
> > > > 
> > > > At hyp init, SCTLR_EL2.BT is set to 1 to match EL1 configuration
> > > > (SCTLR_EL1.BT1) set in bti_enable().
> > > > 
> > > > One difference between kernel and nvhe code, is that the kernel maps
> > > > .text with GP while nvhe maps all the executable pages, this makes
> > > > nvhe code need to deal with special initialization code coming from
> > > > other executable sections (.idmap.text).
> > > > For this we need to add bti instruction at the beginning of
> > > > __kvm_handle_stub_hvc as it can be called by  __host_hvc through
> > > > branch instruction(br) and unlike SYM_FUNC_START, SYM_CODE_START
> > > > doesn’t add bti instruction at the beginning, and it can’t be modified
> > > > to add it as it is used with vector tables.
> > > > Another solution which is more intrusive is to convert
> > > > __kvm_handle_stub_hvc to a function and inject “bti jc” instead of
> > > > “bti c” in SYM_FUNC_START
> > > >
> > > 
> > > I was chasing a bug in linux-next yesterday with protected nVHE(pKVM) and
> > > cpuidle enabled. The system fails to boot. I just bisected the issue to this
> > > patch and also saw this patch landed in the linus tree yesterday/today.
> > 
> > One of the challenges of BTI is that we need to add explicit BTI instructions
> > for assembly code. I checked the code to make sure that nothing was missing,
> > but maybe this is not the case.
> > Can you please share more about the issue (is ESR a Branch Target Exception,
> > call stack...) if possible.
> 
> I haven't debugged it any further, just reported it as soon as I bisected it.
> Reverting this get back the booting system. I am not sure if anything is going
> wrong when the CPU is entering suspend(highly unlikely in normal scenario but
> I am not so sure with pKVM trapping these PSCI calls now) or when it is woken
> up and resuming back. IIUC this now will happen via kvm_hyp_cpu_resume->
> __kvm_hyp_init_cpu->___kvm_hyp_init. 

Thanks a lot for the information.

I checked this now, and I believe I found an issue. I see that __kvm_hyp_init_cpu
calls kvm_host_psci_cpu_entry indirectly and there is no BTI there.
I think this is the only C function that needs special handling.

Can you please check if this solves the issue?

diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index c87c63133e10..7df63f364c3c 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -297,3 +297,8 @@ SYM_CODE_START(__kvm_hyp_host_forward_smc)
 
        ret
 SYM_CODE_END(__kvm_hyp_host_forward_smc)
+
+SYM_CODE_START(kvm_host_psci_cpu_entry)
+       bti j
+       b __kvm_host_psci_cpu_entry
+SYM_CODE_END(kvm_host_psci_cpu_entry)
diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index 08508783ec3d..24543d2a3490 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -200,7 +200,7 @@ static int psci_system_suspend(u64 func_id, struct kvm_cpu_context *host_ctxt)
                         __hyp_pa(init_params), 0);
 }
 
-asmlinkage void __noreturn kvm_host_psci_cpu_entry(bool is_cpu_on)
+asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
 {
        struct psci_boot_args *boot_args;
        struct kvm_cpu_context *host_ctxt;


> > Also, is this with CONFIG_ARM_PSCI_CPUIDLE?
> 
> Yes, basically the cpus can enter cpu_suspend which IIUC pKVM traps and
> handle for the host.

My current setup has no CONFIG_ARM_PSCI_CPUIDLE?, I will try to find
something I can test with.

> > 
> > > Not sure if this is something to do with the fact that pKVM skips to
> > > __kvm_handle_stub_hvc in __host_hvc.
> 
> Sorry, my bad. I meant pKVM skips calling __kvm_handle_stub_hvc in __host_hvc
> and jumps to __host_exit directly. Sorry for that, one wrong "to" changed the
> whole meaning.

I don't see an issue in this, as this path has no indirect branches.

> > __kvm_handle_stub_hvc is called from __host_hvc with "br x5"
> > That's why "bti j" was added at the beginning of __kvm_handle_stub_hvc,
> > so this should be fine.
> >
> 
> Yes I saw that and understood that but I wanted to tell the above which went
> horribly wrong before.
> 

Thanks,
Mostafa
