Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18D861FF8A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiKGU3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiKGU3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:29:37 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACA4183B6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:29:36 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id j6so8903436qvn.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 12:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rmekPIfsDhO/c1VKUUGZV/Wt7GFULF9qq4iGNhwtPaQ=;
        b=WoUgENFw6x+yDkOL6DTJqhHSKthAbh8p3B4djaVfiu1Y1OuAAH5VN0vqEy2WlUru6T
         qBEWcImUuA95okNKVQS17+EvIUay4jWOzyHexqa6/e0Q/rmKyMAQKq5oz9xW/cpg+3BR
         IBAgXFUqMgzbuGwbQH9Ng0QPbzKb63u+5xeN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmekPIfsDhO/c1VKUUGZV/Wt7GFULF9qq4iGNhwtPaQ=;
        b=AZzfz2EgY405mON0UmPcMKRqRYIZg8b7lJipbR+nX9QzdLdmCVOzwiQ9ePyDqHGsfz
         q2598WJiquUxFgdrLhUHyPbS0xkzW0f98i0i0vm9ypAUt1R/ux0NYhZlrwxjmQZgWLWr
         Hsz51jl3QRL3DdTaTiUDmBOcB7fi2QruUXSt4hM25WjfzzMOQyE6HYz6SC5glz7dJguw
         3pkHtZlDO/hymvtgJHoOtGh2UgrP/ra7AiWZVQcvq0/b9/Wg2SJ3+R4OhsX6EYvZa6Mj
         X2jCaRP1M9CuJAF5axkXTBZVbsS1OUlt2wdmTUiaroqD3+QFtlD65+pUNrhIHlPLLpPr
         pypg==
X-Gm-Message-State: ACrzQf1UlE2Pcl1XFHNu0zc4Nuc7DDLPBhCcAJRU24dwzN7azgLLBnFZ
        PZBNzXqszc10U4IZX9tyMmftZozdizBS8Q==
X-Google-Smtp-Source: AMsMyM4B0tjbEF88cweN0JFH9WPp98KWq1MiYjbz7OHxZhZM4u4RNw5hmZvELq787XNjOBfuDr6hcg==
X-Received: by 2002:a0c:a702:0:b0:4c1:2cc7:2d3d with SMTP id u2-20020a0ca702000000b004c12cc72d3dmr19035670qva.88.1667852975130;
        Mon, 07 Nov 2022 12:29:35 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id c8-20020a05620a134800b006ecb9dfdd15sm7405414qkl.92.2022.11.07.12.29.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 12:29:29 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id o70so14998187yba.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 12:29:28 -0800 (PST)
X-Received: by 2002:a25:bd7:0:b0:6d7:7464:4859 with SMTP id
 206-20020a250bd7000000b006d774644859mr5895133ybl.362.1667852967798; Mon, 07
 Nov 2022 12:29:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
 <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net> <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
 <Y2SyJuohLFLqIhlZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CAHk-=wjzp65=-QE1dg8KfqG-tVHiT+yAfHXGx9sro=8yOceELg@mail.gmail.com>
 <8a1e97c9-bd5-7473-6da8-2aa75198fbe8@google.com> <Y2llcRiDLHc2kg/N@cmpxchg.org>
In-Reply-To: <Y2llcRiDLHc2kg/N@cmpxchg.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Nov 2022 12:29:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=whw1Oo0eJ7fFjy_Fus80CM8CnA4Lb5BrrCdot3Rc1ZZRQ@mail.gmail.com>
Message-ID: <CAHk-=whw1Oo0eJ7fFjy_Fus80CM8CnA4Lb5BrrCdot3Rc1ZZRQ@mail.gmail.com>
Subject: Re: mm: delay rmap removal until after TLB flush
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Uros Bizjak <ubizjak@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 12:07 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> - If we DO want to codify the pte lock requirement, we should just
>   remove the lock_page_memcg() altogether, as it's fully redundant.
>
> I'm leaning toward that second option.

The thing is, that's very much the case we do *not* want.

We need to delay the rmap removal until at least after the TLB flush.
At least for dirty filemapped pages - because the page cleaning needs
to see that they exists as mapped entities until all CPU's have
*actually* dropped them.

Now, we do the TLB flush still under the page table lock, so we could
still then do the rmap removal before dropping the lock.

But it would be much cleaner from the TLB flushing standpoint to delay
it until the page freeing, which ends up being delayed until after the
lock is dropped.

That said, if always doing the rmap removal under the page table lock
means that that memcg lock can just be deleted in that whole path, I
will certainly bow to _that_ simplification instead, and just handle
the dirty pages after the TLB flush but before the page table drop.

              Linus
