Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D34F5F728E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 03:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiJGBjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 21:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJGBja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 21:39:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014D592592
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 18:39:30 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s206so3373523pgs.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 18:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VgARxyE2xUeWs6ZD9Z2C3jeaxK0tUIpvYnHYcRwlYa0=;
        b=cmiwTKlVBOkxVvMH61UVx2IAeAmk3ZEDhzuxfCr0BIqwMIV+vqVFL7sZMdwb6nq3Nh
         2Bcg+SBwxvFYVst+PqWXNyfe2idtXvypWraJhg/j6Z7pR3sbeZjTISPtCjoT3Dkbp/qH
         /KzItD6j0dJ+M0MaY/V+swyMEEqnTjkF599+5OCS+N6kVCUCqDFuyq1Y8NlrITHjp7AM
         iy5axHPM2diZk42cMhqjf3zQk3R4qkKEAksrV0Ap+OHhoIClR1ru5yTvt2SwiFeBkyGc
         LX00XEULTE0hbwkjxIDW/YZvpPRRJlm4BMoggtrYQ3QDCh964JHWavMxv8H1FOdW8ZBz
         1RSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgARxyE2xUeWs6ZD9Z2C3jeaxK0tUIpvYnHYcRwlYa0=;
        b=jvLOK5NFRQm7wxIaujhaS7IcktEvF3eGL3FggfuGGr9Mq6okzOeU5b8/w2UEPuPUDW
         1zRZcoKYnJ1mjBJVN+ZdjRun+/3rM2N5b7sqsCv757wVbEfxWkNi+q315IxxfavkSXtz
         38wsc873AUbNE+ejz6+erdC31ruD2EwPEWovYAGiphF2tMqSbMxJ48MyhZyPTkj0z1VT
         AXB7WOZ8idlQApibaBexL/8D1/fODIUBfLbKAsxoQQy85RY4RZIArEjlM8mpDBXaL9a/
         GAtKBoyYWKvIP4yQeQPYXn4aiMjSMWeuqKhjlY13Onmbz+eURH/GLy1ExnxWl7tykLfJ
         mGQg==
X-Gm-Message-State: ACrzQf08XJ+erVVmq3AugmMCcwWiL+bLZA0mWsq2Wh3KfwPuumZ6aWmS
        GV/KshsgWRNU/rTEKJOC0ao/ayzXX2G9hg==
X-Google-Smtp-Source: AMsMyM5ypW2SmqmuaCpoQm1fGL4m+5i4nzI1trKqT11hKBFIwEd60sTlRXe6/GS4KVSoZzMNTuKfTA==
X-Received: by 2002:a05:6a00:1a44:b0:52a:ecd5:bbef with SMTP id h4-20020a056a001a4400b0052aecd5bbefmr2560094pfv.28.1665106769348;
        Thu, 06 Oct 2022 18:39:29 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902cec600b00176a715653dsm268651plg.145.2022.10.06.18.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 18:39:25 -0700 (PDT)
Date:   Fri, 7 Oct 2022 01:39:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 2/3] kvm: Add new pfn error KVM_PFN_ERR_SIGPENDING
Message-ID: <Yz+DRTfdFGmSR7Mq@google.com>
References: <20220817003614.58900-1-peterx@redhat.com>
 <20220817003614.58900-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817003614.58900-3-peterx@redhat.com>
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

On Tue, Aug 16, 2022, Peter Xu wrote:
> Since at it, renaming kvm_handle_bad_page to kvm_handle_error_pfn assuming

Please put parantheses after function names, e.g. kvm_handle_bad_page().

> that'll match better with what it does, e.g. KVM_PFN_ERR_SIGPENDING is not
> accurately a bad page but just one kind of errors.

...

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 3e1317325e1f..23dc46da2f18 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3134,8 +3134,13 @@ static void kvm_send_hwpoison_signal(unsigned long address, struct task_struct *
>  	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, PAGE_SHIFT, tsk);
>  }
>  
> -static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> +static int kvm_handle_error_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
>  {
> +	if (is_sigpending_pfn(pfn)) {
> +		kvm_handle_signal_exit(vcpu);
> +		return -EINTR;
> +	}

...

> @@ -2648,9 +2651,12 @@ kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool *async,
>  	if (atomic)
>  		return KVM_PFN_ERR_FAULT;
>  
> -	npages = hva_to_pfn_slow(addr, async, write_fault, writable, &pfn);
> +	npages = hva_to_pfn_slow(addr, async, write_fault, interruptible,
> +				 writable, &pfn);
>  	if (npages == 1)
>  		return pfn;
> +	if (npages == -EINTR)
> +		return KVM_PFN_ERR_SIGPENDING;

This patch should be split into 3 parts:

  1. Add KVM_PFN_ERR_SIGPENDING and the above code
  2. Add the interruptible flag
  3. Add handling in x86 and rename kvm_handle_bad_page()

With #3 merged with patch 3.

That was if there's oddball arch code that reacts poorly to KVM_PFN_ERR_SIGPENDING,
those errors will bisect to #1.

And if there's a typo in the plumbing, that bisects to #2.

And if something goes sideways in x86, those bugs bisect to #3 (patch 3), and it's
easy to revert just the x86 changes (though I can't imagine that's likely).
