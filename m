Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2645BECCD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiITSca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiITSc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:32:27 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DA35C97C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:32:26 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h188so3495103pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=mfxZ9By6Rg6qt2rzoAd9orSI7y5a9LjLbgRbhfxtxtI=;
        b=d7+SJ+q7z+g7DwCzRr/Cykg79DhgiARGbrrlV0vANkQp/+Bd3WS+raqq2/c/pfLHPR
         V7c6BHFQqHONMkpHid/IotH5ckQJsqNk9Q08fV6lTmT7kBai3WEy88BGFBlHEfU2TIZU
         /UzImU8ebNJ44l9QiU1DBOZPG8j9iHX7uZDV6xlKHDWSzlvl3SljnKSSlBbdR4naifdo
         INPylMId8Blnk05roJuNQtpan/0nS0iD88sIGC4pRY1E5AfSLmAGC/v7XhoYbh9IX+2z
         0UcV2yo6sIDNP6to1gxjXZoQZX5HzVILo/UzbpGX4gK1UZttDoGJErivv0RLewJ7QaF5
         okjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=mfxZ9By6Rg6qt2rzoAd9orSI7y5a9LjLbgRbhfxtxtI=;
        b=ilzt3Zeth+7/w7A9pVMbXTyz7NmyNMtWFJsxPYh19WYxhF86EDETJHzVsLSot2r23G
         lkItFxhFv1jdtMkQ0FfDvm1jpIl8QlZkOfpV4QfRyBZZZswditP/gA1YA7X18gGnKH3T
         gLW/0wnrqdBQviT+S8Y01Y0KPGqYNVkuCJhfA+t5Qk9OzUh+Sp0LjwO7pfbOP89YaTt3
         paVHAPvXgxKbRDcJSPvcQjFLVtyRzMHpYtII96pcAH3iuxLuYzGACZUD+ugoh6hFf9rz
         ALHNKA1vJ7QS8OHjmyoRV6hVtEQwfTSuledu/h+29u1+TFE3Vloa5jp7AqOa5Oe+3xt6
         Lu9A==
X-Gm-Message-State: ACrzQf3P3mZJ8Y0pi9B7uS2fy08VOgHSEiYDIpJHL6hwKY2geKDO6pd9
        uXdSrxWFqUPsPhpi+jBXMVDvlw==
X-Google-Smtp-Source: AMsMyM7WbzIJhWiqGG3Ho6NbZoY2XIX2WN9nHk3051J3s72FcITmfIvdQOWhd6xYlfFgZmMjZe4vRw==
X-Received: by 2002:a63:e709:0:b0:438:98e8:d1c with SMTP id b9-20020a63e709000000b0043898e80d1cmr21408187pgi.403.1663698746205;
        Tue, 20 Sep 2022 11:32:26 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id b15-20020a65578f000000b004348bd693a8sm266876pgr.31.2022.09.20.11.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 11:32:25 -0700 (PDT)
Date:   Tue, 20 Sep 2022 11:32:20 -0700
From:   David Matlack <dmatlack@google.com>
To:     Robert Hoo <robert.hu@linux.intel.com>
Cc:     Hou Wenlong <houwenlong.hwl@antgroup.com>, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] KVM: x86/mmu: Fix wrong gfn range of tlb flushing
 in validate_direct_spte()
Message-ID: <YyoHNMz3CH4SnJwJ@google.com>
References: <cover.1661331396.git.houwenlong.hwl@antgroup.com>
 <c0ee12e44f2d218a0857a5e05628d05462b32bf9.1661331396.git.houwenlong.hwl@antgroup.com>
 <f6fd8ccff13f9f48cbca06f0a5278654198d0d06.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6fd8ccff13f9f48cbca06f0a5278654198d0d06.camel@linux.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 09:11:00PM +0800, Robert Hoo wrote:
> On Wed, 2022-08-24 at 17:29 +0800, Hou Wenlong wrote:
> > The spte pointing to the children SP is dropped, so the
> > whole gfn range covered by the children SP should be flushed.
> > Although, Hyper-V may treat a 1-page flush the same if the
> > address points to a huge page, it still would be better
> > to use the correct size of huge page. Also introduce
> > a helper function to do range-based flushing when a direct
> > SP is dropped, which would help prevent future buggy use
> > of kvm_flush_remote_tlbs_with_address() in such case.
> > 
> > Fixes: c3134ce240eed ("KVM: Replace old tlb flush function with new
> > one to flush a specified range.")
> > Suggested-by: David Matlack <dmatlack@google.com>
> > Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index e418ef3ecfcb..a3578abd8bbc 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -260,6 +260,14 @@ void kvm_flush_remote_tlbs_with_address(struct
> > kvm *kvm,
> >  	kvm_flush_remote_tlbs_with_range(kvm, &range);
> >  }
> >  
> > +/* Flush all memory mapped by the given direct SP. */
> > +static void kvm_flush_remote_tlbs_direct_sp(struct kvm *kvm, struct
> > kvm_mmu_page *sp)
> > +{
> > +	WARN_ON_ONCE(!sp->role.direct);
> 
> What if !sp->role.direct? Below flushing sp->gfn isn't expected? but
> still to do it. Is this operation harmless? 

Flushing TLBs is always harmless because KVM cannot ever assume an entry is
in the TLB. However, *not* (properly) flushing TLBs can be harmful. If KVM ever
calls kvm_flush_remote_tlbs_direct_sp() with an indirect SP, that is a bug in
KVM. The TLB flush here won't be harmful, as I explained, but KVM will miss a
TLB flush.

That being said, I don't think any changes here are necessary.
kvm_flush_remote_tlbs_direct_sp() only has one caller, validate_direct_spte(),
which only operates on direct SPs. The name of the function also makes it
obvious this should only be called with a direct SP. And if we ever mess this
up in the future, we'll see the WARN_ON().
