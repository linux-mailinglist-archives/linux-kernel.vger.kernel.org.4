Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EA7691614
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 02:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjBJBLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 20:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjBJBLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 20:11:08 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD464DBCE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 17:11:02 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id k13so4963639plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 17:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X7w7vI7qAx/6V5DcqybApwiP29xntyFWx8X21g/Jk34=;
        b=sfLeB184LFnKyNxEJNqrfR3Mdhk6RJENi2RNROz6WOYJw1p8jprGHKOmSj3uMfj9gD
         SDxk0RG959l3TvFug0YgjlXtJQaqXPfScMt6GhJz4XWFXjtc2Yc/97/WRXdV24W+u30j
         ot068Qc/PJd82iDYdnDSG6TBJMi0TsBCcG+v+zGOl2jqdpjAIG5i1tXjNtUvHo973lCj
         ANIQpynkOFkuPHbCmFM646xXGXO5UvuFqY5Us9I7ru3Mapth9M5RbiJbIDbrLN6pe3UQ
         5ZhrqOW5g05pQ1VTlZUrkp5AUhGrW1NRfK1ZOw6MwL5OwvD0tO7Lo2cpqEFhxhdj22iE
         SXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7w7vI7qAx/6V5DcqybApwiP29xntyFWx8X21g/Jk34=;
        b=LHd82s5A/Ff7x1FRXtaYAExlU2T2sFWYGUqz2fSaFEquKa9fyLP5UjLEosY6WHZWF4
         hyuRqWBKK3ZrQ8pG6cMSf/FeBiQnrlc3S9/CU39dZ6wWKKwualN3CtZ42eM51a4bU3OG
         OD6aLjQGLttPcR9PwPZV/q/XWWgfT8dE9fd/q8FVUW5Zb8OfuNYnUjRcy6hztOMsISiP
         SubE5kjBUFVGSf23Vuy7/CZ0u8hLhQGSYELfHHD1MnEjL3jzAX0JfaUWC7NnEYx/GXaG
         W61NLksTBE2MlOCs+9ADpzsISdwJWK1wAAxuwZRRBYt0VJRD8ZE2WxwV6IfrgAzZ9m1q
         Dr4Q==
X-Gm-Message-State: AO0yUKWPq6KT7Cx4BuW11oPNEJLKVXE2YAN59rejlSPfyT2FH8/WIpJp
        MyMEskUwFNYUzJjWYYy6oqRbaA==
X-Google-Smtp-Source: AK7set/P6j0ZULv7m7YeCfbR4xqE8ySttSE1jcDDYTFhVXBf+GQyrK97XmxBylb26k5OkPoBx2g05A==
X-Received: by 2002:a17:902:b194:b0:198:af50:e4ec with SMTP id s20-20020a170902b19400b00198af50e4ecmr94343plr.18.1675991461511;
        Thu, 09 Feb 2023 17:11:01 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902b19600b001994554099esm2111583plr.173.2023.02.09.17.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 17:11:00 -0800 (PST)
Date:   Fri, 10 Feb 2023 01:10:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
Subject: Re: [PATCH V2 6/8] kvm: x86/mmu: Remove FNAME(invlpg)
Message-ID: <Y+WZoXYvacqx/+Yu@google.com>
References: <20230207155735.2845-1-jiangshanlai@gmail.com>
 <20230207155735.2845-7-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207155735.2845-7-jiangshanlai@gmail.com>
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

On Tue, Feb 07, 2023, Lai Jiangshan wrote:
> Use FNAME(sync_spte) to share the code which has a slight semantics
> changed: clean vTLB entry is kept.

...

> +static void __kvm_mmu_invalidate_gva(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> +				     gva_t gva, hpa_t root_hpa)
> +{
> +	struct kvm_shadow_walk_iterator iterator;
> +
> +	vcpu_clear_mmio_info(vcpu, gva);
> +
> +	write_lock(&vcpu->kvm->mmu_lock);
> +	for_each_shadow_entry_using_root(vcpu, root_hpa, gva, iterator) {
> +		struct kvm_mmu_page *sp = sptep_to_sp(iterator.sptep);
> +
> +		if (sp->unsync && *iterator.sptep) {

Please make the !0 change in a separate patch.  It took me a while to connect the
dots, and to also understand what I suspect is a major motivation: sync_spte()
already has this check, i.e. the change is happening regardless, so might as well
avoid the indirect branch.

> +			gfn_t gfn = kvm_mmu_page_get_gfn(sp, iterator.index);
> +			int ret = mmu->sync_spte(vcpu, sp, iterator.index);
> +
> +			if (ret < 0)
> +				mmu_page_zap_pte(vcpu->kvm, sp, iterator.sptep, NULL);
> +			if (ret)
> +				kvm_flush_remote_tlbs_with_address(vcpu->kvm, gfn, 1);

Why open code kvm_flush_remote_tlbs_sptep()?  Does it actually shave enough
cycles to be visible?

If open coding is really justified, can you rebase on one of the two branches?
And then change this to kvm_flush_remote_tlbs_gfn().

  https://github.com/kvm-x86/linux/tree/next
  https://github.com/kvm-x86/linux/tree/mmu
