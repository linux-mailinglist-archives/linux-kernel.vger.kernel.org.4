Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CA174BEC3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 20:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjGHSkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 14:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGHSkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 14:40:15 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4074183
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 11:40:13 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-57688a146ecso38288457b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 11:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688841613; x=1691433613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MymRbz3ieuUAdzwpPbldo2WgSB6COfwRJnDlIa6QBns=;
        b=Dou3PgTSSuwDMevLhKPDFQkjfTIwUERNti/exYtr8KC5Fr1uRk53y/2upEOgzQAuvB
         yQ6noYSvDpKjTlt1JX2ZzS5ZEb1qJiyf/0pTP/915p/o6pnYju0wBEOcJQcGl7Bb/i/S
         yLRdTHANtBBhE9R87ukPNuhnAWoo7h0BL8OBhnIKPxmiWmElUvKh26paGfvbt526UDU3
         PnuHlmFIDjcC5C4nQr1wzh8srbReVPgN1NtyPbTKt2bLyfTP2GIukl8xGa/zslYieyb+
         VW3PmV52yfQwr0XcWSNOw9gXT2/gnLsXKlRY9rzhUOZk69nShG7+uU898SnCjSXRU8Vk
         MUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688841613; x=1691433613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MymRbz3ieuUAdzwpPbldo2WgSB6COfwRJnDlIa6QBns=;
        b=YBQKEj4eUhYPbgDvdmfMBPx+AhokCaRp1XsPu/A00F6NYVIhG0XPKVl9/YIR6rDEX8
         YLy4FcUlkUIJ5udeYBNhHW6AAPvW59s9vVurWEZOM+2ceDz8251lsUkKG98ibDGGUkge
         +3IumySTCazg/ttuDdE5/5NZnJ6hw8rLUhiEmCq0oTIqpPS8euESeqZV4YZJ7sRxAK2s
         y/HNbBbUCKkrvmlHbrRxhjMbFu3aJSNkkjgOqRNEwme1EZUDThmW5ZgTVpeGFgqwBcqY
         BIEeEVYqBigO9bbymi7X79cdHHlF/A0nc6txKycyZcxnLdfZ8UZd5mUOsU7g/dNEfIgC
         4drA==
X-Gm-Message-State: ABy/qLZ6P2gJJk8ZAw+8o6pt01MNMBajlb1fVAWHVdh+8fNP7rIfqhqi
        E1PHg1cnlyKK5wpPhYEzShYpVlh9HcrJbFtjx3b2WA==
X-Google-Smtp-Source: APBJJlE3w2AdZ9A5EaDN/VISkV40ZMSV3+Neg11bBy4VnYWxy1YfNqSmKLOubCHqPUg4as9gjsxMVt/0cyF/xZSuMqs=
X-Received: by 2002:a81:4ed4:0:b0:579:efbb:cbe3 with SMTP id
 c203-20020a814ed4000000b00579efbbcbe3mr7485642ywb.43.1688841612875; Sat, 08
 Jul 2023 11:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com>
 <5c7455db-4ed8-b54f-e2d5-d2811908123d@leemhuis.info> <CAJuCfpH7BOBYGEG=op09bZrh1x3WA8HMcGBXXRhe6M5RJaen5A@mail.gmail.com>
 <CAJuCfpH7t7gCV2FkctzG2eWTUVTFZD7CtD14-WuHqBqOYBo1jA@mail.gmail.com>
 <2023070359-evasive-regroup-f3b8@gregkh> <CAJuCfpF=XPpPYqp2Y1Vu-GUL=RBj4fyhXoXzjBY4EKtBnYE_eQ@mail.gmail.com>
 <2023070453-plod-swipe-cfbf@gregkh> <20230704091808.aa2ed3c11a5351d9bf217ac9@linux-foundation.org>
 <CAJuCfpE_WjRQoDT1XnvBghCH-kpqk+pfcBJGyDnK7DZLMVG5Mw@mail.gmail.com>
 <2023070509-undertow-pulverize-5adc@gregkh> <7668c45a-70b1-dc2f-d0f5-c0e76ec17145@leemhuis.info>
 <20230705084906.22eee41e6e72da588fce5a48@linux-foundation.org>
 <df1d7d39-56f3-699c-0d0f-fcc8774f182e@leemhuis.info> <CAHk-=whKd05V49AbZGF=inYmhU6H_yNvvw1grWyhQfQ=9+5-VQ@mail.gmail.com>
 <20230708103936.4f6655cd0d8e8a0478509e25@linux-foundation.org> <CAHk-=wh498i3s+BgOF=pUOF=Qe_A0A16-mFcH2YGy+iZXvNChQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh498i3s+BgOF=pUOF=Qe_A0A16-mFcH2YGy+iZXvNChQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sat, 8 Jul 2023 11:40:01 -0700
Message-ID: <CAJuCfpFLc1yoZm9uqRcmcwtFNGHYKyjxrc71tzXennpGB7QbYQ@mail.gmail.com>
Subject: Re: Fwd: Memory corruption in multithreaded user space program while
 calling fork
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jacob Young <jacobly.alt@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management <linux-mm@kvack.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Jul 8, 2023 at 11:05=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 8 Jul 2023 at 10:39, Andrew Morton <akpm@linux-foundation.org> wr=
ote:
> >
> > That was the v1 fix, but after some discussion
> > (https://lkml.kernel.org/r/20230705063711.2670599-1-surenb@google.com)
> > it was decided to take the "excessive" approach.
>
> That makes absolutely _zero_ sense.
>
> It seems to be complete voodoo programming.
>
> To some degree I don't care what happens in stable kernels, but
> there's no way we'll do that kind of thing in mainline without some
> logic or reason, when it makes no sense.
>
> flush_cache_dup_mm() is entirely irrelevant to the whole issue, for
> several reason, but the core one being that it only matters on broken
> virtually indexed caches, so none of the architectures that do per-vma
> locking.
>
> And the argument that "After the mmap_write_lock_killable(), there
> will still be a period where page faults can happen" may be true
> (that's kind of the *point* of per-vma locking), but it's irrelevant.
>
> It's true for *all* users of mmap_write_lock_killable, whether in fork
> or anywhere else. What makes fork() so magically special?
>
> It's why we have that vma_start_write(), to say "I'm now modifying
> *this* vma, so stop accessing it in parallel".
>
> Because no, flush_cache_dup_mm() is not the magical reason to do that thi=
ng.

My understanding was that flush_cache_dup_mm() is there to ensure
nothing is in the cache, so locking VMAs before doing that would
ensure that no page faults would pollute the caches after we flushed
them. Is that reasoning incorrect?

>
> Maybe there is something else going on, but no, we don't write crazy
> code without a reason for it. That's completely unmaintainable,
> because people will look at that code, not understand it (because
> there is nothing to understand) and be afraid to touch it. For no
> actual reason.
>
> The obvious place to say "I'm now starting to modify the vma" is when
> you actually start to modify the vma.
>
> > Also, this change needs a couple more updates:
>
> Those updates seem sane, and come with explanations of why they exist.
> Looks fine to me.
>
> Suren, please send me the proper fixes. Not the voodoo one. The ones
> you can explain.

Ok, I think these two are non-controversial:
https://lkml.kernel.org/r/20230707043211.3682710-1-surenb@google.com
https://lkml.kernel.org/r/20230707043211.3682710-2-surenb@google.com

and the question now is how we fix the fork() case:
https://lore.kernel.org/all/20230706011400.2949242-2-surenb@google.com/
(if my above explanation makes sense to you)
or
https://lore.kernel.org/all/20230705063711.2670599-2-surenb@google.com/

Please let me know which ones and I'll send you the patchset including
these patches.
Thanks,
Suren.

>
> And if stable wants to do something else, then that's fine. But for
> the development kernel,. we have two options:
>
>  - fix the PER_VMA_LOCK code
>
>  - decide that it's not worth it, and just revert it all
>
> and honestly, I'm ok with that second option, simply because this has
> all been way too much pain.
>
> But no, we don't mark it broken thinking we can't deal with it, or do
> random non-sensible code code we can't explain.
>
>             Linus
