Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B89D701283
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbjELXdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240427AbjELXda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:33:30 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D7C1718
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:33:17 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-643ac91c51fso6706161b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683934397; x=1686526397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cvwQaaZ0+K9jxsdyvnDNJYbJcMSYJ8VZ+taENeCZRIA=;
        b=QZCKL/pBsTs6F+tWSP5H/zei428DLnLdg/MB/c8OqWTueXHbJIYngJctjVmMl6QqeL
         JmhBqmgGpNhq6DMd9Ti9RXZfCzWUkg6SRlAcbS/r0XW2aZdppaClgul2aEZQKmpn8gMz
         3991nMsXu1JI+WamivSybu83hBgEhhmsWuOQcTcUjsggBIJXjsJ0DpmaqzpbLpoHdDrL
         OfjbPNmXTAIndHDQdaJedfbyrgfwvZ1VAkiPG6km3LjpyHMxEel693Y1jtDtQfqAK9cQ
         nmJ4EltPuOBOijhOx+827gjITvMbdoPtOs9wOKCXAWqU/FP6YO2snBs+T9Ws/f9TR576
         +iJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683934397; x=1686526397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvwQaaZ0+K9jxsdyvnDNJYbJcMSYJ8VZ+taENeCZRIA=;
        b=hXdACotlKKa3I4/NFD4YRFxksVBscAtBTSpMpOmw3JLMW3kKkFpYKub8oHEh6/8Q67
         ThWZzgQVrE0pyLbyVsiSapet+L+Of3HOGUA2q3fTMHyOhVUS6lJgzmu6UeyfFwLtQLZO
         4IXim2k6TqnWqa7S/gDBCYasqzhsYsqH9ElDbYuv483xrgv6HAbYoBJ7SDXeskSVRnbg
         1Z+ZjDqwVdu5cnCHhab0V5YwluwTTyG79DTmwR/ZBuPXzg9HsZ9pW2YijGBA8xOt9fCP
         qhgTZDsFDoKksYuCaa6GDvb1O/oLmPbfRy4pcLyqOM377oMEwfajcqiGxRzxv6mUYos2
         ZB9Q==
X-Gm-Message-State: AC+VfDwIIki0QZb73vNZ+gHpM4O+tId4i7NY7K3e0DXWjfXSsBvc5jTg
        B/ZBP0Me07Ls0RTi891WqjV1cw==
X-Google-Smtp-Source: ACHHUZ6m6bPe9z3yKqGIZtPb8lpr4oDwO5tYzBU1w4Bstq53YIb0YfHv6Qn3ESxsxMeG8q7dvI+x3Q==
X-Received: by 2002:a17:903:247:b0:1ab:16cd:51a3 with SMTP id j7-20020a170903024700b001ab16cd51a3mr35719112plh.10.1683934396877;
        Fri, 12 May 2023 16:33:16 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d90200b001a9bfd4c5dfsm8500870plz.147.2023.05.12.16.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 16:33:16 -0700 (PDT)
Date:   Fri, 12 May 2023 16:33:12 -0700
From:   David Matlack <dmatlack@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH 6/9] KVM: x86/mmu: Bug the VM if a vCPU ends up in long
 mode without PAE enabled
Message-ID: <ZF7MuDGp9MvPNwFh@google.com>
References: <20230511235917.639770-1-seanjc@google.com>
 <20230511235917.639770-7-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511235917.639770-7-seanjc@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 04:59:14PM -0700, Sean Christopherson wrote:
> Promote the ASSERT(), which is quite dead code in KVM, into a KVM_BUG_ON()
> for KVM's sanity check that CR4.PAE=1 if the vCPU is in long mode when
> performing a walk of guest page tables.  The sanity is quite cheap since
> neither EFER nor CR4.PAE requires a VMREAD, especially relative to the
> cost of walking the guest page tables.
> 
> More importantly, the sanity check would have prevented the true badness
> fixed by commit 112e66017bff ("KVM: nVMX: add missing consistency checks
> for CR0 and CR4").  The missed consistency check resulted in some versions
> of KVM corrupting the on-stack guest_walker structure due to KVM thinking
> there are 4/5 levels of page tables, but wiring up the MMU hooks to point
> at the paging32 implementation, which only allocates space for two levels
> of page tables in "struct guest_walker32".
> 
> Queue a page fault for injection if the assertion fails, as the sole
> caller, FNAME(gva_to_gpa), assumes that walker.fault contains sane info

FNAME(page_fault)->FNAME(walk_addr)->FNAME(walk_addr_generic) is another
caller but I think the same reasoning here applies.

> on a walk failure, i.e. avoid making the situation worse between the time
> the assertion fails and when KVM kicks the vCPU out to userspace (because
> the VM is bugged).
> 
> Move the check below the initialization of "pte_access" so that the
> aforementioned to-be-injected page fault doesn't consume uninitialized
> stack data.  The information _shouldn't_ reach the guest or userspace,
> but there's zero downside to being paranoid in this case.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/paging_tmpl.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> index a3fc7c1a7f8d..f297e9311dcd 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -338,7 +338,6 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
>  	}
>  #endif
>  	walker->max_level = walker->level;
> -	ASSERT(!(is_long_mode(vcpu) && !is_pae(vcpu)));
>  
>  	/*
>  	 * FIXME: on Intel processors, loads of the PDPTE registers for PAE paging
> @@ -348,6 +347,10 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
>  	nested_access = (have_ad ? PFERR_WRITE_MASK : 0) | PFERR_USER_MASK;
>  
>  	pte_access = ~0;
> +
> +	if (KVM_BUG_ON(is_long_mode(vcpu) && !is_pae(vcpu), vcpu->kvm))
> +		goto error;

This if() deserves a comment since it's queueing a page fault for what
is likely a KVM bug. As a reader that'd be pretty jarring to see.

> +
>  	++walker->level;
>  
>  	do {
> -- 
> 2.40.1.606.ga4b1b128d6-goog
> 
