Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223356A0EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 18:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjBWRe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 12:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBWRe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 12:34:56 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6813654A21
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:34:55 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536c525d470so131983447b3.18
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4HvtD+IMg3vyDXGpZcS0GeFnM8gx7HgAcp0Q62lmtW4=;
        b=fvEBJKNTVgASaDjc9Q0VXXTAIHEeqbLAf/33eHK5qtIch5pppRvvtww/N2ViF2gpdq
         VCAiByWM0l/uNFtxN6iV9hK9EY1uZL/NFtqzu8+sHL4tj8XGIV3zT+VWHXk8cqOcs76m
         313IP1Iu0V/gvoPT+akxf2tRfrtOogk7Aohae/b/Aowp4hWjO+AiMIwooblfNsZUhyiu
         U4MrCMNErtTs5EP+Mg3bg1pBjkaTPY96RUHhEDGrAVECxaGcvdLPa0vW0CY9T5AOps78
         5vvq/sVqQVqjMo9ETUdGV8sO5IdO/RVjAtFU/I637xYFOPP6pd7vWPL3FWBwSWirJEqB
         rtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HvtD+IMg3vyDXGpZcS0GeFnM8gx7HgAcp0Q62lmtW4=;
        b=sG4xDOGtyof79o2E2jvab1lo9XVzWyttDfZyM4RNizTWDFSsm1uogIxInf8EzvziKx
         LzHckiNmSZUiZuLLYwzsgU9a2OY1hWr/njYLEAN/mRFOAN4aMi6ZymnZj6DjvuEdYYpJ
         4G0JLYwp5cLCOdPzTD10gXjZrFVS0E5W4ZJdqoE8dnoxscqQZbaIybi74duSLxUritAJ
         wex68yUkoZX14vJHOYl4BV0J88y8DYKQm3gdkLPdr55rQGsTdNkmAuOmBc2Ax+yfGKlI
         PJO6BpjWb0jdkW1LewSX5wJ8kQynjmVNfN5D3cXiqbZbU1UJOIOL8e8YmgK/KYJyEXBA
         sPcA==
X-Gm-Message-State: AO0yUKWeuBT4mN94nGpCx41veLAdQB68T4bQHlbpJZa/HtPeMBXoHEKZ
        AyfCuhtKLkMWkJAokZyHAFIxSyGg8I0=
X-Google-Smtp-Source: AK7set9qM18OCmCtNF4MtwIz5dX/Eaw8z+NF94C05s0wfxF7vpTFz86wUpljUQl+IzVT57C5nxDYcFR2baU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:524e:0:b0:534:7482:b73 with SMTP id
 g75-20020a81524e000000b0053474820b73mr788300ywb.153.1677173694654; Thu, 23
 Feb 2023 09:34:54 -0800 (PST)
Date:   Thu, 23 Feb 2023 09:34:52 -0800
In-Reply-To: <20230217041230.2417228-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20230217041230.2417228-1-yuzhao@google.com> <20230217041230.2417228-2-yuzhao@google.com>
Message-ID: <Y/ejvISuDQyOvrG8@google.com>
Subject: Re: [PATCH mm-unstable v1 1/5] mm/kvm: add mmu_notifier_test_clear_young()
From:   Sean Christopherson <seanjc@google.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <michael@michaellarabel.com>,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-mm@google.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023, Yu Zhao wrote:
> +static bool kvm_mmu_notifier_test_clear_young(struct mmu_notifier *mn, struct mm_struct *mm,
> +					      unsigned long start, unsigned long end,
> +					      unsigned long *bitmap)
> +{
> +	if (kvm_arch_has_test_clear_young())
> +		return kvm_test_clear_young(mmu_notifier_to_kvm(mn), start, end, bitmap);
> +
> +	return false;
> +}
> +
>  static int kvm_mmu_notifier_test_young(struct mmu_notifier *mn,
>  				       struct mm_struct *mm,
>  				       unsigned long address)
> @@ -903,6 +960,7 @@ static const struct mmu_notifier_ops kvm_mmu_notifier_ops = {
>  	.clear_flush_young	= kvm_mmu_notifier_clear_flush_young,
>  	.clear_young		= kvm_mmu_notifier_clear_young,
>  	.test_young		= kvm_mmu_notifier_test_young,
> +	.test_clear_young	= kvm_mmu_notifier_test_clear_young,

I am strongly opposed to adding yet another "young" mmu_notifier hook for this.
I would much rather we extend (and rename) mmu_notifier_clear_young() to take the
bitmap as an optional parameter, and then have KVM hide the details of whether or
not it supports lockless processing of the range/bitmap.

I also think for KVM x86 in particular, this series should first convert to a
lockless walk for aging ranges, and then add the batching.  It might also make
sense to land x86 first and then follow-up with ARM and PPC.  I haven't looked at
the ARM or PPC patches in too much depth, but on the x86 side of things KVM already
has the pieces in place to support a fully lockless walk, i.e. the x86 specific
changes aren't all that contentious, the only thing we need to figure out is what
to do about nested VMs.
