Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E8672511E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 02:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240332AbjFGAYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 20:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbjFGAYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 20:24:20 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089781989
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 17:24:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9745baf7c13so853781666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 17:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686097457; x=1688689457;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G3xWHxIDzZm/Cm/VNd/bMge2IkR3+FmhKrhLM2E3LiE=;
        b=zdBMHXa8hCib0O1mDaTw+TKuQ2tSGkAaoZsZcfxJhOlxFwTGROtc2h/xbUIj21rtcY
         ipfg4x3LfzhbN4qFNGapg+EG5NrWIDwDTEFMs4SEyZtMwsAY7kMuu7b/mQn2nf/xzGas
         HRqx0E0BSzdudq5rceDf4Qo9JUdlK4BDALOhCUY3tEicHrIKn5eowX9FHbChyoLG8w6P
         lNj3D30z/cpvI1ykxrYsU34uvRh4WwSwQNAmJRxAaGnVQburQiM9nja5N+x3vzLa6HsA
         pCzXKNsCnpjtv4ctcUQCKuMbUb7Wk1TH8ITJHV+uvrrGVLYsc6m0O20zDkeY2QL+WJzi
         gUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686097457; x=1688689457;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3xWHxIDzZm/Cm/VNd/bMge2IkR3+FmhKrhLM2E3LiE=;
        b=QYBTBXaYwuXYr9yMq8y8ybO4EgDk5XDwOvppxUNMfgriqHKXGGKrMMABZT8mmE49D0
         n8AA64KpMMlwBjetpmZ5db5HN3Qxg3ohXlFluL5bVteWyCbaPrNf1g78GxOP2tu6IbXH
         OI3v0T1I0L3sYgZ/lqvVbIBDh2ES5GcLw3NY92sDZSQWQFnSXhYKVHdaHe0VQhjYXZAR
         ctej9xaYQEk+xJCi7YUu6YML3CwrtoNgIg/VuDVXt7FE+XOq2bntz00XRemBGSLH9wy3
         ezkwiSsQaHFL920BK8jY5FMO3wDj5TYbD5DOOnHnWCXxkM6L6/LxtjkrnCNgmIjzm3s4
         RVpA==
X-Gm-Message-State: AC+VfDwWYxxCZXRxcm0qvPaZcWP1Q1WKYD2IkVsvkOrTnmbGRC+qSecR
        qlWgqIy6H4nMv5PcwHhLDQnTl7zp/fxwMTpnuZPycA==
X-Google-Smtp-Source: ACHHUZ4WktIqjKhxr/INGrYUyl4aY+b1XJ9GfZzbh0JB2NSelBN9kzic4Dm2GAvZCzxhHsZ/w6nvKxh/Oh9T7qQ6cEw=
X-Received: by 2002:a17:907:7d87:b0:969:7739:2eb7 with SMTP id
 oz7-20020a1709077d8700b0096977392eb7mr3888160ejc.4.1686097457385; Tue, 06 Jun
 2023 17:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230605004334.1930091-1-mizhang@google.com> <CALMp9eSQgcKd=SN4q2QRYbveKoayKzuYEQPM0Xu+FgQ_Mja8-g@mail.gmail.com>
 <CAL715WJowYL=W40SWmtPoz1F9WVBFDG7TQwbsV2Bwf9-cS77=Q@mail.gmail.com>
 <ZH4ofuj0qvKNO9Bz@google.com> <CAL715WKtsC=93Nqr7QJZxspWzF04_CLqN3FUxUaqTHWFRUrwBA@mail.gmail.com>
 <ZH+8GafaNLYPvTJI@google.com>
In-Reply-To: <ZH+8GafaNLYPvTJI@google.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Tue, 6 Jun 2023 17:23:40 -0700
Message-ID: <CAL715WJ1rHS9ORR2ttyAw+idqbaLnOhLveUhW8f4tB9o+ZsuiQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: Remove KVM MMU write lock when accessing indirect_shadow_pages
To:     Sean Christopherson <seanjc@google.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hmm. I agree with both points above, but below, the change seems too
> > heavyweight. smp_wb() is a mfence(), i.e., serializing all
> > loads/stores before the instruction. Doing that for every shadow page
> > creation and destruction seems a lot.
>
> No, the smp_*b() variants are just compiler barriers on x86.

hmm, it is a "lock addl" now for smp_mb(). Check this: 450cbdd0125c
("locking/x86: Use LOCK ADD for smp_mb() instead of MFENCE")

So this means smp_mb() is not a free lunch and we need to be a little
bit careful.

>
> > In fact, the case that only matters is '0->1' which may potentially
> > confuse kvm_mmu_pte_write() when it reads 'indirect_shadow_count', but
> > the majority of the cases are 'X => X + 1' where X != 0. So, those
> > cases do not matter. So, if we want to add barriers, we only need it
> > for 0->1. Maybe creating a new variable and not blocking
> > account_shadow() and unaccount_shadow() is a better idea?
> >
> > Regardless, the above problem is related to interactions among
> > account_shadow(), unaccount_shadow() and kvm_mmu_pte_write(). It has
> > nothing to do with the 'reexecute_instruction()', which is what this
> > patch is about. So, I think having a READ_ONCE() for
> > reexecute_instruction() should be good enough. What do you think.
>
> The reexecute_instruction() case should be fine without any fanciness, it's
> nothing more than a heuristic, i.e. neither a false positive nor a false negative
> will impact functional correctness, and nothing changes regardless of how many
> times the compiler reads the variable outside of mmu_lock.
>
> I was thinking that it would be better to have a single helper to locklessly
> access indirect_shadow_pages, but I agree that applying the barriers to
> reexecute_instruction() introduces a different kind of confusion.
>
> Want to post a v2 of yours without a READ_ONCE(), and I'll post a separate fix
> for the theoretical kvm_mmu_pte_write() race?  And then Paolo can tell me that
> there's no race and school me on lockless programming once more ;-)

yeah, that works for me.
