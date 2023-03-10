Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA246B5295
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjCJVOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCJVOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:14:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6FFEB57
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:13:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2391B8240E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 21:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42712C433EF;
        Fri, 10 Mar 2023 21:13:56 +0000 (UTC)
Date:   Fri, 10 Mar 2023 16:13:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC][PATCH 5/5] x86/kvm: Simplify static call handling
Message-ID: <20230310161354.1889b539@gandalf.local.home>
In-Reply-To: <ZAucD8gHx8Xp8Dlb@google.com>
References: <cover.1678474914.git.jpoimboe@kernel.org>
        <432e4844ba65840af4a24f5e3f561aead867f6e7.1678474914.git.jpoimboe@kernel.org>
        <ZAucD8gHx8Xp8Dlb@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 13:07:27 -0800
Sean Christopherson <seanjc@google.com> wrote:

> "KVM: x86:" please, "x86/kvm" is for guest-side changes.
> 
> On Fri, Mar 10, 2023, Josh Poimboeuf wrote:
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index 1dfba499d3e5..612531e1c478 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -1789,8 +1789,6 @@ extern struct kvm_x86_ops kvm_x86_ops;
> >  
> >  #define KVM_X86_OP(func) \
> >  	DECLARE_STATIC_CALL(kvm_x86_##func, *(((struct kvm_x86_ops *)0)->func));
> > -#define KVM_X86_OP_OPTIONAL KVM_X86_OP
> > -#define KVM_X86_OP_OPTIONAL_RET0 KVM_X86_OP
> >  #include <asm/kvm-x86-ops.h>
> >  
> >  int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops);
> > diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> > index 6accb46295a3..5f7f860c5f17 100644
> > --- a/arch/x86/kvm/pmu.c
> > +++ b/arch/x86/kvm/pmu.c
> > @@ -77,20 +77,15 @@ static struct kvm_pmu_ops kvm_pmu_ops __read_mostly;
> >  #define KVM_X86_PMU_OP(func)					     \
> >  	DEFINE_STATIC_CALL_NULL(kvm_x86_pmu_##func,			     \
> >  				*(((struct kvm_pmu_ops *)0)->func));
> > -#define KVM_X86_PMU_OP_OPTIONAL KVM_X86_PMU_OP
> >  #include <asm/kvm-x86-pmu-ops.h>
> >  
> >  void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops)
> >  {
> >  	memcpy(&kvm_pmu_ops, pmu_ops, sizeof(kvm_pmu_ops));
> >  
> > -#define __KVM_X86_PMU_OP(func) \
> > -	static_call_update(kvm_x86_pmu_##func, kvm_pmu_ops.func);
> >  #define KVM_X86_PMU_OP(func) \
> > -	WARN_ON(!kvm_pmu_ops.func); __KVM_X86_PMU_OP(func)  
> 
> I would much prefer to keep KVM mostly as-is, specifically so that we don't lose
> this WARN_ON() that guards against a vendor module neglecting to implement a
> mandatory callback.  This effectively gives KVM "full" protection against consuming
> an unexpectedly-NULL function pointer.

As in my reply to patch 0/5, I suggested that static_call_update(NULL)
would trigger a WARN_ON() always. Then this could be cleaned up and still
get that warning.

-- Steve
