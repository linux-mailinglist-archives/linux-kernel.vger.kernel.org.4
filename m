Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC14568F2DF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjBHQJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjBHQJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:09:33 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAC94C6C5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:09:30 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o13so18850820pjg.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 08:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Furcw+Iz7dNQbctvrcCjsm8Q+2APzV3ddxj9XuB328k=;
        b=LQiDcYOWZ8G/MEVDDZeV/1rsHCFkhfAcA1SbCgX6o/yLNHLdJmPtl227YeoE3NxLtw
         C9JF5Y/EVnWiP2wj8+ddBmWDN0kfwlf4BDwgyTW5ytB/hK5koG6iID+mTCvTGohf4zwz
         mZ3oAe+nqJow2nvI1LW6Gv5VT6lnAyD9o07DG6MhlEZuHDE6byiQOuZkH8lV+1RXpFJJ
         PLznV5YXPzTYee8NYlAqNGzVx/OX1Jc0echeO5xK5Mz+mmwZQbPrhdECcB8dewgTZduh
         t9iNcfF+5qIIncmwtRMrFfdSu+dBTIWY4YUa75wBVkjMQJrB3t1gHZ9ubOo/cXGO3KWE
         F4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Furcw+Iz7dNQbctvrcCjsm8Q+2APzV3ddxj9XuB328k=;
        b=zko0T8P2N/yTGhcqx4WmlmJCny6t8VbDDlh4uDIXavEQR2EUpXSMjYf3Jl3os2Hpcj
         NTQTBUBlPxMq2r5RIpGxiOcoaHpAjSvITRuPhC/NcnZUZnQ2ECdtL2FiPys2BIEQRiXk
         f9RnxVsfsrBF3E1Hqs43arYXXZ8VdA2PbflgRQZgbqeldAlBlu4BZJL/A0B/3gYqdigb
         6Wm9ktq+lXGN9XKScYAWmGZZ5TINKeTeofEXrTqa6PN7gS7rElHsVs47B/DGlFFk5J7T
         Yw/RliwcVXBSo86ISNLZ4f60wxcy5e9ZLAMeF46o6I8Hcog6v+GfyqJjNscaXIVi+hXC
         /zmg==
X-Gm-Message-State: AO0yUKUU7gwOwb/HxGOZxFvtHMnTI4w9U4RIbkZZodJqxcDmyKh5nlO2
        4J47+nvD1znDT/r1OEzQUaLVdg==
X-Google-Smtp-Source: AK7set+XjnGusCVHCGp2WzFDsi578Xn30Co0qJc/TRKOBLpuP8yoDzRz73FBGe4VkW1bnLzqfWk4jA==
X-Received: by 2002:a17:902:e80e:b0:198:af4f:de09 with SMTP id u14-20020a170902e80e00b00198af4fde09mr249862plg.9.1675872570192;
        Wed, 08 Feb 2023 08:09:30 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id n4-20020a635904000000b004fb3edd9465sm443397pgb.8.2023.02.08.08.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:09:29 -0800 (PST)
Date:   Wed, 8 Feb 2023 16:09:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Santosh Shukla <santosh.shukla@amd.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        Jing Liu <jing2.liu@intel.com>,
        Wyes Karny <wyes.karny@amd.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 07/11] KVM: x86: add a delayed hardware NMI injection
 interface
Message-ID: <Y+PJNhpqrjiov6vC@google.com>
References: <20221129193717.513824-1-mlevitsk@redhat.com>
 <20221129193717.513824-8-mlevitsk@redhat.com>
 <Y9mWFlGdzoa8ZDW7@google.com>
 <Y9mtGV+q0P2U9+M1@google.com>
 <d3681058-224d-07c7-283f-5f81ab523844@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3681058-224d-07c7-283f-5f81ab523844@amd.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023, Santosh Shukla wrote:
> On 2/1/2023 5:36 AM, Sean Christopherson wrote:
> > On Tue, Jan 31, 2023, Sean Christopherson wrote:
> >> On Tue, Nov 29, 2022, Maxim Levitsky wrote:
> >>> @@ -10015,13 +10022,34 @@ static void process_nmi(struct kvm_vcpu *vcpu)
> >>>  	 * Otherwise, allow two (and we'll inject the first one immediately).
> >>>  	 */
> >>>  	if (static_call(kvm_x86_get_nmi_mask)(vcpu) || vcpu->arch.nmi_injected)
> >>> -		limit = 1;
> >>> +		limit--;
> >>> +
> >>> +	/* Also if there is already a NMI hardware queued to be injected,
> >>> +	 * decrease the limit again
> >>> +	 */
> >>> +	if (static_call(kvm_x86_get_hw_nmi_pending)(vcpu))
> >>> +		limit--;
> >>
> >> I don't think this is correct.  If a vNMI is pending and NMIs are blocked, then
> >> limit will end up '0' and KVM will fail to pend the additional NMI in software.
> > 
> > Scratch that, dropping the second NMI in this case is correct.  The "running" part
> > of the existing "x86 is limited to one NMI running, and one NMI pending after it"
> > confused me.  The "running" thing is really just a variant on NMIs being blocked.
> > 
> > I'd also like to avoid the double decrement logic.  Accounting the virtual NMI is
> > a very different thing than dealing with concurrent NMIs, I'd prefer to reflect
> > that in the code.
> > 
> > Any objection to folding in the below to end up with:
> > 
> > 	unsigned limit;
> > 
> > 	/*
> > 	 * x86 is limited to one NMI pending, but because KVM can't react to
> > 	 * incoming NMIs as quickly as bare metal, e.g. if the vCPU is
> > 	 * scheduled out, KVM needs to play nice with two queued NMIs showing
> > 	 * up at the same time.  To handle this scenario, allow two NMIs to be
> > 	 * (temporarily) pending so long as NMIs are not blocked and KVM is not
> > 	 * waiting for a previous NMI injection to complete (which effectively
> > 	 * blocks NMIs).  KVM will immediately inject one of the two NMIs, and
> > 	 * will request an NMI window to handle the second NMI.
> > 	 */
> > 	if (static_call(kvm_x86_get_nmi_mask)(vcpu) || vcpu->arch.nmi_injected)
> > 		limit = 1;
> > 	else
> > 		limit = 2;
> > 
> > 	/*
> > 	 * Adjust the limit to account for pending virtual NMIs, which aren't
> > 	 * tracked in in vcpu->arch.nmi_pending.
> > 	 */
> > 	if (static_call(kvm_x86_is_vnmi_pending)(vcpu))
> > 		limit--;
> > 
> > 	vcpu->arch.nmi_pending += atomic_xchg(&vcpu->arch.nmi_queued, 0);
> > 	vcpu->arch.nmi_pending = min(vcpu->arch.nmi_pending, limit);
> > 
> 
> I believe, you missed the function below hunk -
> 
> 	if (vcpu->arch.nmi_pending &&
> 	    static_call(kvm_x86_set_vnmi_pending(vcpu)))
> 		vcpu->arch.nmi_pending--;
> 
> Or am I missing something.. please suggest.

You're not missing anything, I'm pretty sure I just lost tracking of things.
