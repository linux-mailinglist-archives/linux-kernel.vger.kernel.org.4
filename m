Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A9F64DF85
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiLORRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiLORRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:17:33 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8993B9CA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:17:31 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3bfd998fa53so51092237b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vgwEKtWDyNCFdKKLSB7ml7wFDqNcuLAkG79hbnDj2wQ=;
        b=YkPbXTjmJaIVuwPsliYqXwhDF3eJg9BIcND5IwsxQ7PT6VubAh8uNbPi3H1j9su/+h
         jKV2d88SutLPpO6UGoqTSjGtuYX2MGjyg3tX3Ub/MMn0iAJ+ZD4GFTNy9WP3VhUaITcX
         cb5imFEtwkpFEu028p1TqoqOBAJ09UBeFDEKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgwEKtWDyNCFdKKLSB7ml7wFDqNcuLAkG79hbnDj2wQ=;
        b=qXQPUc9j5R4rGWDV+BeyFn1cUi6kIUypcImUu1ZXdRWnOyJgBgbB4zK/7jdtajyk+s
         Hij1DF0UdU0VfiSlUzvhuepB4Bl0q2OWFca7/Bh8x4HFK0YFTplqLDeK1edxMq/IOqQN
         CMfWnmP6AqAaFpLyBrjrPuSisgsdzmy0XoDoUvhFtHif9tmkNgdt+0Fi4tU8xdDvaMZ3
         EjU0IibCDpQZcW9uabeN6lGbBC7YpU+z0OpUnE5ilF+K+evTXHi2ez+OIcnrzcAFfy5Y
         xfkzTpLTg/1P8/45wqT5ljLDrwsbyHzx+GiEiwY7lFDOODMRPsK/YUBh1XnJ3v3ttsXT
         fIdg==
X-Gm-Message-State: ANoB5pnQeQBLob3e11JODbQLWMxYg5vDlCyJHeYVZHlGIER3/Os6/u3c
        RZNqV18qsez3f7KZw9WW7hqMQtjokh/1+8SV
X-Google-Smtp-Source: AA0mqf7LaYLhLPaGKkxdzuE5W1yjaynnAubtmpWTTGwDOHWbK1EBuusIaayboSEnRvGIfj/EVajSTA==
X-Received: by 2002:a05:7500:5696:b0:ea:f6ed:7d50 with SMTP id ca22-20020a057500569600b000eaf6ed7d50mr3674754gab.14.1671124649294;
        Thu, 15 Dec 2022 09:17:29 -0800 (PST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id t14-20020a37ea0e000000b006fa7b5ea2d1sm12095032qkj.125.2022.12.15.09.17.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 09:17:28 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id x11so17812qtv.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:17:27 -0800 (PST)
X-Received: by 2002:a05:622a:1745:b0:3a6:8b84:47ce with SMTP id
 l5-20020a05622a174500b003a68b8447cemr33770245qtk.678.1671124647583; Thu, 15
 Dec 2022 09:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20221213174234.688534-1-dave.hansen@linux.intel.com>
 <CAHk-=wi=TY3Kte5Z1_nvfcsEh+rcz86pYnzeASw=pbG9QtpJEQ@mail.gmail.com> <20221215123007.cagd7qiidehqd77k@box.shutemov.name>
In-Reply-To: <20221215123007.cagd7qiidehqd77k@box.shutemov.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Dec 2022 09:17:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=whC_ixb3FDdMhW_wiKw7-bB700kvUyqN+_cPUNp=1hNsQ@mail.gmail.com>
Message-ID: <CAHk-=whC_ixb3FDdMhW_wiKw7-bB700kvUyqN+_cPUNp=1hNsQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm for 6.2
To:     kirill.shutemov@linux.intel.com
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
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

On Thu, Dec 15, 2022 at 4:30 AM <kirill.shutemov@linux.intel.com> wrote:
>
> My initial enabling allowed userspace to enable the feature per-thread.
> I pointed out the same potential use -- JIT -- case as you did[1].
> But it made harder to handle corner cases. Like, it is not obvious what
> LAM setup kernel thread has to use when acts on behalf of the process
> (io_uring for instance). I ended up with using the most permissive LAM
> mode (that allowed the most tag bits), but it is clearly a hack.

... and doing it per-mm causes more corner cases.

Look at the - actively buggy - uses of the mask outside the mm lock.

And no, "take the mm lock for reading every time you want to do
untagged_addr()" isn't the answer either.

I didn't look at every single use of 'untagged_addr()', but I did look
at a couple, and every single one of the ones I looked at was racy and
wrong.

Does the race _matter_? Almost certainly not. Nobody will ever care.
It's something we would have happily ignored for years, and then
sighed, and added a READ_ONCE() for to make KCSAN happy.

But when I get a new pull request, and the first thing I look at is
fundamentally racy, just take a wild guess at how happy it makes me
about that pull request?

> Thomas pointed[2] that out and following versions used per-process
> approach. It simplified the patchset substantially.

No, it sure as hell didn't.

It "simplified" things by just introducing another bug instead.

> Speaking about, untagged_addr(), how do you see the interface should look
> like? It has to work correctly when called from a kernel thread. I can
> only think of a hack that makes it branch on task->flags & PF_KTHREAD.

So I think that the current branch contents I see are simply not an
option. I do not want to pull code that when I look at it, I see a
data race on context.untag_mask .

I also find the "pass in mm" to be fundamentally objectionable,
because even if that then ends up being the right approach for x86,
this interface really isn't x86-centric.

Yes, arm64 ends up making it all unconditional, which simplifies
things enormously and just means that arm64 doesn't care at all. But
what if somebody else comes along, and really does want to make it
per-thread?

So I'd be ok with an interface that passes in 'struct task_struct',
and then x86 could use "tsk->mm" to get the mm if that really is the
interface x86 people want. Because then at least the *interface* isn't
hardcoded to be broken.

So those are my two fundamental objections against the current LAM
code. An outright bug in x86 code, and a bad interface in non-x86
code.

Here's *one* suggested solution:

 - pass in the 'task' for the target for untagged_addr(), so that
we're not locked into one model

 - if x86 really wants to make thing per-mm, let it, but have a "lock"
operation that says "now my setting is set in stone". You already do
that in prctl_enable_tagged_addr() with that

        /* Already enabled? */
        if (mm->context.lam_cr3_mask) {
                ret = -EBUSY;
                goto out;
        }

   just expose that as a thing.

 - make thread creation lock it (and unlock it on creating a new mm at
execve, but not fork).

And yes, I would actually suggest that _any_ thread creation locks it,
so that you never *EVER* have any issues with "oh, now I need to
synchronize with other threads". A process can set its LAM state at
startup, not in the middle of running!

Note that io_uring will automatically do that locking, because it does
that thread creation (create_io_thread()). So io_uring threads won't
even be a special case.

You could go even further, and just make it a ELF binary flag, and
basically have that LAM thing be a "when creating the mm, this is what
it gets created as". That is probably what most people would actually
want, but it sounds painful from a bootstrapping standpoint.

Now, the above is just a suggestion off the top of my head. It
simplifies things a lot, in that now even if the state is "per mm",
you can actually *cache* it per-thread, and there are no data races.

It also means that prctl_enable_tagged_addr() doesn't have to worry
about serialization and that whole

        on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);

thing.

> Normal untagged_addr() usage doesn't require serialization: IPI in
> prctl_enable_tagged_addr() makes mm->context.untag_mask visible to all
> CPUs that runs the mm before it returns.

BS.

That operation is not serialized IN ANY WAY with the other threads
reading the value. For all you know, untagged_addr() may be reading
that value multiple times due to compiler reloads, and getting
different values between two reads, and doing random things because
you use one value for one thing, and another for the later
"find_vma()" when the untagged address is actually used.

The IPI does *nothing*.  It serializes the cores, but since there is
no actual locking (or even a READ_ONCE() or anything), it doesn't
actually do anything on a software level.

The code is buggy. Really. It's likely a "this works in practice
because reloads are unlikely and you wouldn't hit them anyway" kind of
bug, but no, that IPI does not help.

(Of course, the IPI helps in that now at least the cr3 value is
synchronized, so the IPI is needed for the *hardware* accesses, but
doesn't help software use of mm->context.untag_mask).

                Linus
