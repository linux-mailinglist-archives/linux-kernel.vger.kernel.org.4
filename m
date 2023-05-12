Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE75A70128F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbjELXlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240666AbjELXlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:41:00 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F181FC1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:40:59 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-518d6f87a47so5259695a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683934859; x=1686526859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rdSWNdPBzCvQZue8s+nJ8+4j93W1/3mOYRyvy9I/esk=;
        b=s748YbYXBKYE0u5/i9t2zN0VCehO3hUO821bHn0KtVX4LXrWfGzZ4Jbc6Q9rO3V43b
         RiyXOdLXeaLu1852urhveSmkofnGqK7qbxSK014EGoO6mUFQdrZhTVh7xP56qFs/ATrE
         MVCFF+tfhGcmsE/KSSsyntK9K+1Z48J82yBZDZCMbNAcXrXE5esiP7TaLOp2ffybU5c3
         if3wbDGggFxaCeOy3aqvsUdvpZtLMT/bklfy6heYp/Wg3hXEsrFldIoHxeZAA2BayQHp
         3Fhz7FG2ldpIJhdmn4rkX9lUdmSuRINZLW+58knj9s89UwMfOzRBvTXpwOeXTBrz3txA
         JCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683934859; x=1686526859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdSWNdPBzCvQZue8s+nJ8+4j93W1/3mOYRyvy9I/esk=;
        b=ihn1ydqubotgx/eKc4LqllLdsc46/MLNuzz3+jBmgB0dlP4WxCj3QS124ahQBpSvGz
         nVWAmqjKLOTYpnINlB0QX2kw7AaQkeDosSBxqC+TkT47Uzx94hZxD4rqHk8l25+Wy22X
         aVnpyldVP0pQjmI0J97iHFXjgq3JBml3T9OyAvO5MQrYAZb/9k0ccKUOR7FjVlaslruL
         /o22E46P7JKnV3DEKPTbK0nkfpnECfEQUcwkljLRat/qihR/bLG221noMfStiqgFY3XD
         JQDNygeDELS5dg0yXN/rD6FWOtvyjQItxxYseKtIt4bXtyU5MXjn4hCmw3m63B76crUR
         PMfQ==
X-Gm-Message-State: AC+VfDz+iKAWWWilVjWglmh+7OcnVL7irAvR4Kjr7DSY1i/D2jvibYYT
        yQ3k1L52Acr5r0HTvIYF4VzRILYS/yw=
X-Google-Smtp-Source: ACHHUZ4OzfCZhOK1+M55+P7V05CPjr5Pv1An6dc8vQsgHRcETuTHgKA7sVjS0VxhHEOQ9gqJIf3D6QUKhuQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:2b04:0:b0:521:62ef:9b38 with SMTP id
 r4-20020a632b04000000b0052162ef9b38mr7266189pgr.3.1683934859334; Fri, 12 May
 2023 16:40:59 -0700 (PDT)
Date:   Fri, 12 May 2023 16:40:57 -0700
In-Reply-To: <ZF7MuDGp9MvPNwFh@google.com>
Mime-Version: 1.0
References: <20230511235917.639770-1-seanjc@google.com> <20230511235917.639770-7-seanjc@google.com>
 <ZF7MuDGp9MvPNwFh@google.com>
Message-ID: <ZF7OiYzjkG2cp7Fi@google.com>
Subject: Re: [PATCH 6/9] KVM: x86/mmu: Bug the VM if a vCPU ends up in long
 mode without PAE enabled
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023, David Matlack wrote:
> On Thu, May 11, 2023 at 04:59:14PM -0700, Sean Christopherson wrote:
> > Promote the ASSERT(), which is quite dead code in KVM, into a KVM_BUG_ON()
> > for KVM's sanity check that CR4.PAE=1 if the vCPU is in long mode when
> > performing a walk of guest page tables.  The sanity is quite cheap since
> > neither EFER nor CR4.PAE requires a VMREAD, especially relative to the
> > cost of walking the guest page tables.
> > 
> > More importantly, the sanity check would have prevented the true badness
> > fixed by commit 112e66017bff ("KVM: nVMX: add missing consistency checks
> > for CR0 and CR4").  The missed consistency check resulted in some versions
> > of KVM corrupting the on-stack guest_walker structure due to KVM thinking
> > there are 4/5 levels of page tables, but wiring up the MMU hooks to point
> > at the paging32 implementation, which only allocates space for two levels
> > of page tables in "struct guest_walker32".
> > 
> > Queue a page fault for injection if the assertion fails, as the sole
> > caller, FNAME(gva_to_gpa), assumes that walker.fault contains sane info
> 
> FNAME(page_fault)->FNAME(walk_addr)->FNAME(walk_addr_generic) is another
> caller but I think the same reasoning here applies.

Huh.  No idea what I was doing.  Missed the super obvious use case...  I'll make
sure the call from walk_addr() does something not awful.

> > on a walk failure, i.e. avoid making the situation worse between the time
> > the assertion fails and when KVM kicks the vCPU out to userspace (because
> > the VM is bugged).
> > 
> > Move the check below the initialization of "pte_access" so that the
> > aforementioned to-be-injected page fault doesn't consume uninitialized
> > stack data.  The information _shouldn't_ reach the guest or userspace,
> > but there's zero downside to being paranoid in this case.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/mmu/paging_tmpl.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> > index a3fc7c1a7f8d..f297e9311dcd 100644
> > --- a/arch/x86/kvm/mmu/paging_tmpl.h
> > +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> > @@ -338,7 +338,6 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
> >  	}
> >  #endif
> >  	walker->max_level = walker->level;
> > -	ASSERT(!(is_long_mode(vcpu) && !is_pae(vcpu)));
> >  
> >  	/*
> >  	 * FIXME: on Intel processors, loads of the PDPTE registers for PAE paging
> > @@ -348,6 +347,10 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
> >  	nested_access = (have_ad ? PFERR_WRITE_MASK : 0) | PFERR_USER_MASK;
> >  
> >  	pte_access = ~0;
> > +
> > +	if (KVM_BUG_ON(is_long_mode(vcpu) && !is_pae(vcpu), vcpu->kvm))
> > +		goto error;
> 
> This if() deserves a comment since it's queueing a page fault for what
> is likely a KVM bug. As a reader that'd be pretty jarring to see.

Will add.
