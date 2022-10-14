Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0BD5FF3EF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiJNTJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJNTJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:09:10 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF841D73F3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 12:09:06 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 8so3111767qka.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 12:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PSBBubo8IAbN+yxQgMGavzYe4lqgiZmQwmoNccc+Tn4=;
        b=F5Xlc3cB3hD+HemKoUoTCn6rUhK1cLvebZc7zGnOdkHD1l1qiFITFPwghAoVxRqtB2
         wX1K2pDVCWFT9c5ESJ9ynoOhPSADnfXeM0ux4tvIeRZM/Fj8AS7Mgr/YEoRkVOk9NBol
         qZLYuS+9+7U6Wx++SXhVg93i5BQzaGhNmZwe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSBBubo8IAbN+yxQgMGavzYe4lqgiZmQwmoNccc+Tn4=;
        b=CktsGR5zcJT8QAPNGUK6hZ/1C6/kuIaHo53a7ZQSHOtrKtZrd4tAd/c38XUo2uumes
         hjMTFV9eCnBeJZne5vNOp6FlXns601DPlqAxHhTf4ZVc8DzXMXsdZ9vuXQ5eN2QQpywS
         YAlUncrNAIBTumBRs85D6Z+SXEXzNsFq8KaV8IFuWO7B5Bd4z1rcab89EJC9MHsu+PtB
         98msonxe9gA7ueVIsEjzF7thYal/O3Z7RdPJ2l70vqQz+zD7dzppr5OF7gQ3ZjL8pUnA
         6QUICWrpvF//DFuEbWwsRfwvtc+ruI0dRxilwvBXjk+Mg7bM3cwzkJQApDZUTGS5eO2x
         lzKw==
X-Gm-Message-State: ACrzQf3cP1tEvH7FwCOc9RMKb2/nzv3/sblArdrQXkQzMQSqyggbhZbJ
        s2P776x7YCmhtZPfKBNAyrpwz1wZ/P/9ow==
X-Google-Smtp-Source: AMsMyM7O/npxoXoVfZqtQDWy1w5dO+f/74wN38yzpV4zjKdJy0NaygMFzwGRohltAZCquzznjrWt0A==
X-Received: by 2002:a05:620a:1231:b0:6ee:83a8:29f1 with SMTP id v17-20020a05620a123100b006ee83a829f1mr4898767qkj.325.1665774543778;
        Fri, 14 Oct 2022 12:09:03 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id d25-20020a05620a159900b006ee7e223bb8sm2934445qkk.39.2022.10.14.12.09.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 12:09:02 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 203so6671267ybc.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 12:09:02 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr6177123ybu.310.1665774542040; Fri, 14
 Oct 2022 12:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez0B18eh3Q1853Cug8WSip7dPb2G9fhgqsPWzr0D_TBjRQ@mail.gmail.com>
In-Reply-To: <CAG48ez0B18eh3Q1853Cug8WSip7dPb2G9fhgqsPWzr0D_TBjRQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Fri, 14 Oct 2022 12:08:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgu9x3ds+Mxpz6-BxuQgPt-YJ75J8q0q38w+QR-fA2kqA@mail.gmail.com>
Message-ID: <CAHk-=wgu9x3ds+Mxpz6-BxuQgPt-YJ75J8q0q38w+QR-fA2kqA@mail.gmail.com>
Subject: Re: [BUG?] X86 arch_tlbbatch_flush() seems to be lacking
 mm_tlb_flush_nested() integration
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sasha.levin@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 11:20 AM Jann Horn <jannh@google.com> wrote:\
>
> The effect would be that after process B removes a mapping with
> munmap() and creates a new mapping in its place, it would still see
> data from the old mapping when trying to access the new mapping.
>
> Am I missing something that protects against this scenario?

While I don't think that scenario is something you can trigger in
practice without enormously bad luck, I don't see anything that would
protect against it.

Afaik, the whole vmscan thing never takes the vm lock, only the file
lock (to protect mapping->i_map) or the anonvma lock (to protect
anon_vma->rb_root).

And none of that ends up serializing with a new mmap() that doesn't
even install a new page in the page tables (and just gets an old TLB
entry). There are zero shared data structures outside of the mm
itself.

Now, munmap() *could* serialize with it, because at least munmap has
access to the data structures and their locks. But it doesn't do any
deferred flushes that I can see, so while it's serialized, it doesn't
help.

And it wouldn't help to do try_to_unmap_flush() from munmap either,
since the deferred flushing is per-thread, and the munmap is done from
a different thread.

So if you're missing something, then I am too.

All this flushing is very careful to flush before actually releasing
the page, which is our really traditional TLB flush bug. But yeah,
that's not the only race - we should flush before replacing the
mapping too.

Mel? I think the batched flushing goes back to you many many years
ago. I hope Jann and me are just being stupid and missing something
obvious.

                  Linus
