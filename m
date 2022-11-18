Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4D962FB1F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242446AbiKRRFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242224AbiKRREu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:04:50 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C806810FD2;
        Fri, 18 Nov 2022 09:04:48 -0800 (PST)
Date:   Fri, 18 Nov 2022 17:04:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668791087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TT9WIDG2PcC0Y0VIGysC67t4tuJ3IbUzD2E14K7Mj+U=;
        b=LGYC1eBuUtn8jOWDiDcXMIJ1YnhdPWLXut1ZBEcavASub+m8ULYW0AASixs5J/vq/3BhV1
        mVS8burSTjm3iAAFWmAcG5ZCDTMyuAxBv3B0ihS0N/cgR1xxf7HIwJlJWJnK35X8d7ijLp
        fU7waACJ//jWMMIY9avT7eDUsKoxS+A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Will Deacon <will@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] KVM: arm64: Allow userspace to trap SMCCC
 sub-ranges
Message-ID: <Y3e7KqJKz6nHjFSu@google.com>
References: <20221110015327.3389351-1-oliver.upton@linux.dev>
 <20221110015327.3389351-3-oliver.upton@linux.dev>
 <20221118145637.GC4624@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118145637.GC4624@willie-the-truck>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 02:56:38PM +0000, Will Deacon wrote:
> On Thu, Nov 10, 2022 at 01:53:26AM +0000, Oliver Upton wrote:
> > As the SMCCC (and related specifications) march towards an
> > 'everything and the kitchen sink' interface for interacting with a
> > system, it is less likely that KVM will implement every supported
> > feature.
> > 
> > Add a capability that allows userspace to trap hypercall ranges,
> > allowing the VMM to mix-and-match between calls handled in userspace vs.
> > KVM.
> > 
> > Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> > ---
> >  arch/arm64/include/asm/kvm_host.h |  5 ++++
> >  arch/arm64/include/uapi/asm/kvm.h | 15 ++++++++++
> >  arch/arm64/kvm/arm.c              | 10 +++++++
> >  arch/arm64/kvm/hypercalls.c       | 48 +++++++++++++++++++++++++++++++
> >  include/uapi/linux/kvm.h          |  1 +
> >  5 files changed, 79 insertions(+)
> 
> [...]
> 
> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > index 6f0b56e7f8c7..6e8a222fc295 100644
> > --- a/arch/arm64/kvm/arm.c
> > +++ b/arch/arm64/kvm/arm.c
> > @@ -100,6 +100,13 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
> >  		r = 0;
> >  		set_bit(KVM_ARCH_FLAG_SYSTEM_SUSPEND_ENABLED, &kvm->arch.flags);
> >  		break;
> > +	case KVM_CAP_ARM_USER_HYPERCALLS:
> > +		if (cap->args[0] & ~KVM_ARM_USER_HYPERCALL_FLAGS)
> > +			return -EINVAL;
> 
> Why not use KVM_CAP_EXIT_HYPERCALL for this?

Err... I hilariously hijacked its UAPI for the exit but added a new cap
for it :)

I think the direction going forward will be to provide userspace with a
range-based filter such that (to a degree) we can arbitrarily forward
hypercalls to userspace, allowing for a mix-and-match approach.

> At some point during pKVM
> development, we used that to notify the VMM about memory being shared
> back from the guest but we eventually dropped it as the notification to
> userspace ended up not being needed:
> 
> https://android-kvm.googlesource.com/linux/+/dbd2861832dfc4c8a3103214b3c212ee7ace1c44%5E%21/
> https://android-kvm.googlesource.com/linux/+/2a3afc6da99c0e0cb62be1687153ee572903aa80%5E%21/
> 
> I'm not saying that what we did was necessarily better, but it seems a bit
> simpler and I figured it might be useful to point you to it.

Yeah, this is certainly a lot cleaner than what I've proposed here. And
frankly, for my immediate interest (forwarding vendor hypercalls to
userspace), this would fit the bill. OTOH, I was hoping that something
a bit more flexible could move the onus of implementing every darn spec
onto userspace (where possible).

I know you said pKVM has no need for userspace notifications at this
moment, but could user hypercalls be useful again going forward?

--
Thanks,
Oliver
