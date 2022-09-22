Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100555E5B10
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiIVGEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiIVGEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:04:04 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5623B4E91
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:04:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id f9so12953600lfr.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=olO03nDFwqe9rFksGooFJngR4lSdLRLgIe6BNqbbGiE=;
        b=qzohgW4W028h1kLWT+ngvQ+sdokVC0lx0SVNa9LacLlCtQ/IxdfInBOE+kEv5Cj0Sv
         DHbjzLNxzFQ7Q3hq60AFtTC+AbEGMhCwaxnQXjlHCBw0BV3xzEPokfX59Jpb7E/yWEmu
         E23sL60jfE4Q8dz3+QTb3x5zHFw9x2g4ubVrrHZvQNln+8hg59HNlN73KwFlzrwc1pHJ
         Z3CMXa44KdgPJvZIuw452Wb75sYP0rD6HkFkratfsLZgdxwfdq0mOtF9O8n8it6ZN05O
         f/REz4t7kqW972qzmQmeSvK5zwxdKY/bv06FtuH75F7RLHdqjxuHk5Cux3hRPHRKdY9J
         gXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=olO03nDFwqe9rFksGooFJngR4lSdLRLgIe6BNqbbGiE=;
        b=Ln0kXDnXZDinuFYNB4wLGoG6BTKS9zbDLsGbr2Z8R0IwPMtvAyYD9Bw/y2LakBvyni
         wzdQZ+drEKL4okM6SmXb3kZ15RtK4wqbs9FE0QqDynoz4bm7Gpy1kpNrRovXQkrw6wo3
         p4iubsz48IWMF4F5FIDgbrOM9yeqMOUJJ9u9gB8m5vhAShpljdD/OialZQvqD/4w157o
         ewLEuEEn2B+I416D6Yl9XeZfaSFoaLmMatRwGz6SzbxHDguBiunJFsM+WThYOSibRsIN
         tGk7OEa8B8HblU4jiiz9m0agq88idM/ClSkZoiiBBw/k0aaCRw3dR8VT96XlF2xL5M6U
         1/Tw==
X-Gm-Message-State: ACrzQf3tX8Ed8SetGC7JbOz5+qQCdyL/Ls/0bmBw1FlqMqJEWnSeZQZO
        T+UStpKQw07tA3RQznUEBYDnJKodZ5Dp8IAMNDkeRw==
X-Google-Smtp-Source: AMsMyM5AMskxCm8Jz+477vviAsdu4yz0tWJSV689o7jAqlMq0UagCEkVck9qEsRwU82oQ8UeZSA+NdDBw04kp51UQfo=
X-Received: by 2002:a05:6512:139c:b0:48f:da64:d050 with SMTP id
 p28-20020a056512139c00b0048fda64d050mr566474lfa.268.1663826640739; Wed, 21
 Sep 2022 23:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220921231151.2321058-1-vipinsh@google.com> <CALMp9eQ8Rr-rSjXiZ_4O0mA=k3kk=hYrfB_NTszu=9DFOwNUaQ@mail.gmail.com>
 <YyuiWk/4TFYqf0qN@google.com>
In-Reply-To: <YyuiWk/4TFYqf0qN@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Wed, 21 Sep 2022 23:03:24 -0700
Message-ID: <CAHVum0fSz26O0KrmNYPQzpUHBBsf-invuow9gV5dWZPUGJRm8A@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: Fix hyperv_features test failure when
 built on Clang
To:     Sean Christopherson <seanjc@google.com>
Cc:     Jim Mattson <jmattson@google.com>, pbonzini@redhat.com,
        vkuznets@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Sep 21, 2022 at 4:46 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Sep 21, 2022, Jim Mattson wrote:
> > On Wed, Sep 21, 2022 at 4:11 PM Vipin Sharma <vipinsh@google.com> wrote:
> > >
> > > hyperv_features test fails when built on Clang. It throws error:
> > >
> > >          Failed guest assert: !hcall->ud_expected || res == hcall->expect at
> > >          x86_64/hyperv_features.c:90
> > >
> > > On GCC, EAX is set to 0 before the hypercall whereas in Clang it is not,
> > > this causes EAX to have garbage value when hypercall is returned in Clang
> > > binary.
> > >
> > > Fix by executing the guest assertion only when ud_expected is false.
>
> TL;DR: please rewrite the changelog to explain the actual bug (checking the
> result when the hypercall is expected to fault) and the fix, and only mention the
> gcc vs. clang behavior as a footnote.

On it.
>
> As Jim pointed out, the bug has nothing to do with clang.  Ha, figured out why
> gcc passes; it uses RAX as the scratch reg that the asm blob loads into R8,
> i.e. loads RAX with @output_address.  So ignore my earlier suggestion of:
>
>         *hv_status = -EFAULT,
>
> even better is to do:
>
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> index 79ab0152d281..673085f6edfd 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> @@ -26,7 +26,8 @@ static inline uint8_t hypercall(u64 control, vm_vaddr_t input_address,
>                      : "=a" (*hv_status),
>                        "+c" (control), "+d" (input_address),
>                        KVM_ASM_SAFE_OUTPUTS(vector)
> -                    : [output_address] "r"(output_address)
> +                    : [output_address] "r"(output_address),
> +                      "a"(-EFAULT)
>                      : "cc", "memory", "r8", KVM_ASM_SAFE_CLOBBERS);
>         return vector;
>  }
>
> so that there is zero chance of getting a false positive due to the compiler
> (but not KVM) modifying RAX.
>

Taking it.

> Anyways, this bug is not clang's fault, with above patch it fails as "expected".
>
> ==== Test Assertion Failure ====
>   x86_64/hyperv_features.c:622: false
>   pid=283847 tid=283847 errno=4 - Interrupted system call
>      1  0x0000000000402842: guest_test_hcalls_access at hyperv_features.c:622
>      2   (inlined by) main at hyperv_features.c:642
>      3  0x00007f23fc513082: ?? ??:0
>      4  0x0000000000402ebd: _start at ??:?
>   Failed guest assert: !hcall->ud_expected || res == hcall->expect at x86_64/hyperv_features.c:90
> arg1 = 0, arg2 = fffffff2
>
>
> > > Fixes: cc5851c6be86 ("KVM: selftests: Use exception fixup for #UD/#GP Hyper-V MSR/hcall tests")
> > > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > > Suggested-by: Sean Christopherson <seanjc@google.com>
> > >
> > > ---
> > >  tools/testing/selftests/kvm/x86_64/hyperv_features.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > In case Sean doesn't point it out, be wary of starting a shortlog with
> > "Fix." You may later regret it.

I am doing it already! :D

>
> Heh, I think our record is "Really, really fix xyz" for a shortlog.
>
> > Also, I think the "clang" part is a red herring. You are fixing a
> > latent bug in the code.
>
> Ya, it's definitely a good idea to call out why a bug was missed, but clang is
> not to blame here, at all.

I agree, my understanding was not complete for this bug. I will send
out a v2 with an updated shortlog. Thanks, Jim and Sean, for pointing
it out.
