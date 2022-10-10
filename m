Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F125E5FA207
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJJQdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJJQdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:33:14 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AF272EDE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:33:13 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id b5so10685267pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ODUrvB6x9PyfijUG47/H8ontrjgUIcyhbXeewpsYxz0=;
        b=qyTR4UJdomUFFX7ddk8hWsQ6pXgE0zVqp4kJPK4Rg/BbRA56086+5NsSRHFzfwThyl
         1Sk15mKBDYJUVoy8mEPXZcycGFvtu0OsVeDNgZAs0u7EobolR6cDqNqKG6iZVNHVHif6
         ff7vdKljqBAMlRL0711hapq0uqjFHkQOeWEYCuEGyDKhjFHQOd7KWnfsQKESUTlTBkYw
         nXK8walR5h1oWPa9C8gVRipLjtD75BLaI+3byRQ4QUXGn5KYGsF3Uqx7Kb/dZ1UA0NHE
         z1gk+Q7AxbS6m5hRvImZy9Z1hIOoE5DBLdeNtfedD7O/3ZoEBQxYSJESC6pcObU/FcJm
         FGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODUrvB6x9PyfijUG47/H8ontrjgUIcyhbXeewpsYxz0=;
        b=Y5USumiBPRndUqqKFW2WzWdkeBPHG2uOIEW0YiFoqDDhCXYWymmRx6v03On1mhr9bv
         UXxdD1uY/Ftnw/En1nr0sZT6LoXKS9FrXE6ennRBVVG4/1bSDTpOk+WUgZcUlBAoCGtX
         0KquPCLye1A5qcS15udQz++E1tkwcdswBch0X6kdKQmAPX1fHUXBcjUCAae/4WfeNFp3
         nU9say9dbJ8mt/jDmkufnUAsFZsaLQHNyqldPfmf3HsStiAP5lyP/p58ZeAnya08elFC
         uVpqtNx0RHsf9KbH3CTR8WKZr5GKkbptRjVgYYAAmpiEFPRDqoarnGTbDDdbzVD4h5jP
         f6lg==
X-Gm-Message-State: ACrzQf2g/QlD0XUrPwxdT3fNFTybYZOribuN9upkG76b7ZPkmlLHNidP
        iaha6heRGeq8orF3iIZQpgsaLw==
X-Google-Smtp-Source: AMsMyM49LWajn+Jm8Ccsvub6XFGPzX2C5YChJwxJk3mwJhF3qCuTvZ6Ci74I7Qj2/NMz157sQLmFHw==
X-Received: by 2002:a63:571c:0:b0:452:e934:4058 with SMTP id l28-20020a63571c000000b00452e9344058mr17101120pgb.426.1665419592429;
        Mon, 10 Oct 2022 09:33:12 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id v3-20020a17090ad58300b00209a12b3879sm6123748pju.37.2022.10.10.09.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 09:33:11 -0700 (PDT)
Date:   Mon, 10 Oct 2022 16:33:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH v5 2/7] KVM: x86/mmu: Rename NX huge pages
 fields/functions for consistency
Message-ID: <Y0RJRHuUxnO7o4kO@google.com>
References: <20220930234854.1739690-1-seanjc@google.com>
 <20220930234854.1739690-3-seanjc@google.com>
 <Y0N96VIqxm76F3xl@yzhao56-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0N96VIqxm76F3xl@yzhao56-desk.sh.intel.com>
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

On Mon, Oct 10, 2022, Yan Zhao wrote:
> On Fri, Sep 30, 2022 at 11:48:49PM +0000, Sean Christopherson wrote:
> <...>
> > -static void kvm_recover_nx_lpages(struct kvm *kvm)
> > +static void kvm_recover_nx_huge_pages(struct kvm *kvm)
> >  {
> >  	unsigned long nx_lpage_splits = kvm->stat.nx_lpage_splits;
> >  	int rcu_idx;
> > @@ -6833,23 +6834,25 @@ static void kvm_recover_nx_lpages(struct kvm *kvm)
> >  	ratio = READ_ONCE(nx_huge_pages_recovery_ratio);
> >  	to_zap = ratio ? DIV_ROUND_UP(nx_lpage_splits, ratio) : 0;
> >  	for ( ; to_zap; --to_zap) {
> > -		if (list_empty(&kvm->arch.lpage_disallowed_mmu_pages))
> > +		if (list_empty(&kvm->arch.possible_nx_huge_pages))
> >  			break;
> >  
> >  		/*
> >  		 * We use a separate list instead of just using active_mmu_pages
> > -		 * because the number of lpage_disallowed pages is expected to
> > -		 * be relatively small compared to the total.
> > +		 * because the number of shadow pages that be replaced with an
> > +		 * NX huge page is expected to be relatively small compared to
> > +		 * the total number of shadow pages.  And because the TDP MMU
> > +		 * doesn't use active_mmu_pages.
> >  		 */
> > -		sp = list_first_entry(&kvm->arch.lpage_disallowed_mmu_pages,
> > +		sp = list_first_entry(&kvm->arch.possible_nx_huge_pages,
> >  				      struct kvm_mmu_page,
> > -				      lpage_disallowed_link);
> > -		WARN_ON_ONCE(!sp->lpage_disallowed);
> > +				      possible_nx_huge_page_link);
> > +		WARN_ON_ONCE(!sp->nx_huge_page_disallowed);
> >  		if (is_tdp_mmu_page(sp)) {
> >  			flush |= kvm_tdp_mmu_zap_sp(kvm, sp);
> >  		} else {
> >  			kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
> > -			WARN_ON_ONCE(sp->lpage_disallowed);
> > +			WARN_ON_ONCE(sp->nx_huge_page_disallowed);
> Can this WARN_ON_ONCE(sp->nx_huge_page_disallowed) also be applied to
> tdp mmu case as it holds write lock now?

Hmm, yes.  I'll tack on a patch, assuming it doesn't cause explosions.  If it does
cause explosions, I'll probably just cry :-)
