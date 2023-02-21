Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61EE69E8E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjBUUJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjBUUJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:09:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDEE2CFD4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:09:11 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id eg37so18160570edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/6Kr3iEFInbnKvbOes0vyk89NJtt6oh/me0FLDTRf1k=;
        b=c8q3kdSnxSawTxg/rYRveKAQ4fzz/UnbNZQW0ZhAgXfEf3Eng2rfpNErWbyr480bW7
         U3he3ZnyjLwsqq0y0hdq5rFp3eBl9vX/1rr/CTVT4ApONDrgEuJjHKliZVqwDXNT4Scg
         Fe62JbbyN/WGb+SAvgA49vSgxhvr6gffyjZdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6Kr3iEFInbnKvbOes0vyk89NJtt6oh/me0FLDTRf1k=;
        b=3NKWc3Hc86BMUQEnfIDNsY7jgDtXwNvizxx3UUIp2d/BJkPjNS2nnN0qH84c9vdthj
         8iGYFF+EG8O2m/qT9A/rdiGf5bYbuD73E4yqdhT5qYZ0ikvgEGmDJm2Oo1lYR6Q9cJS1
         8YJBsoeOP6Gz1gFLn+iEx11tae9UC7LSTLAxjpjqy5/wluG9IspZGFhUF7mWs+9N8mbs
         sSpOUBlS9L9iC9hIXEZII0Wn4ll+aJOqjC1qvdCO3FDDDxK8AIw86sj5JLtpX8P9o4jR
         B0lIvGa76jeVPMiu6HYLs0AVRKyn2RrWsdrZgkWG66xALXEcknOI6Hu50Dj7lkoGQ5cC
         3xlg==
X-Gm-Message-State: AO0yUKXNb3ybXz8lEr5ir+F1ZxHyYRHzME85683753wNsx3zPIehmM2a
        dWqI8uFfVAtgBKaHiUZYttLu8zW/HsLe2B84JOU=
X-Google-Smtp-Source: AK7set+K3DFx0ytl9caIzb9A6G371PPTZjVVmcJbwwXgEXog4+OcG02T0BIfzyFO9vRL0b77nSMsPg==
X-Received: by 2002:aa7:df15:0:b0:4ae:f496:ee2 with SMTP id c21-20020aa7df15000000b004aef4960ee2mr5263695edy.20.1677010149544;
        Tue, 21 Feb 2023 12:09:09 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id e17-20020a50a691000000b004accf3a63cbsm1752709edc.68.2023.02.21.12.09.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 12:09:08 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id x10so21161724edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:09:08 -0800 (PST)
X-Received: by 2002:a05:6402:500b:b0:4ad:739c:b3ac with SMTP id
 p11-20020a056402500b00b004ad739cb3acmr3630684eda.1.1677010148440; Tue, 21 Feb
 2023 12:09:08 -0800 (PST)
MIME-Version: 1.0
References: <63efd7ab.170a0220.3442b.6609@mx.google.com> <CAHk-=wgw++ccN-Pd1npZsBSDD3z6EGUSKsWuAEh5YC-TmfJAug@mail.gmail.com>
 <F522EBF9-9BB9-4258-B614-1BB87455B4F5@kernel.org>
In-Reply-To: <F522EBF9-9BB9-4258-B614-1BB87455B4F5@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Feb 2023 12:08:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh-u8dKyLtcDo4Vd=p==9hOH5D40de3tpC_rr_8eo9Lwg@mail.gmail.com>
Message-ID: <CAHk-=wh-u8dKyLtcDo4Vd=p==9hOH5D40de3tpC_rr_8eo9Lwg@mail.gmail.com>
Subject: Re: [GIT PULL] hardening updates for v6.3-rc1
To:     Kees Cook <kees@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Sam James <sam@gentoo.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-hardening@vger.kernel.org
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

On Tue, Feb 21, 2023 at 11:49 AM Kees Cook <kees@kernel.org> wrote:
>
> >I've said this before, and apparently I need to say this again: if you
> >cannot be bothered to explain *WHY* a merge exists, then that merge is
> >buggy garbage by definition.
>
> Okay, understood. This was a merge of the fixes for v6.2. I'll explain that more clearly in the log from now on. :)

So I really want people to document their merges, not just so that I
(and others) can see "oh, that's why it exists at all", but also
because I want to make people think about their merges more in
general.

For example, one reason why people do these kinds of merges is because
they are starting to do some new development for the next release, and
that new development then depends on fixes or infrastructure that they
had in another branch (like a "for-linus" branch in case of fixes).

So then they - mindlessly - just do a "git merge that-branch" and the
end result looks very much like what you sent me.

In a slightly better world, they then actually write an explanatory
commit message for that merge, knowing that I ask for them, and the
merge commit message ends up being exactly that kind of slightly odd

  "Now I'm starting a new thing that depends on the fixes
   I already sent upstream, so I'm merging that branch"

Which while certainly better than no explanation at all sounds a bit
odd, doesn't it? Yeah, add a few details on just what you depend on
and why, and it gets much better, but it's all going to be a bit
hand-wavy about future work that you haven't even written yet.

And *that* will them maybe make you then go "Ahh, I'm doing things wrong".

Because the "nice git way" to do that kind of thing is to actually
realize "oh, I'm starting new work that depends on the fixes I already
sent upstram, so I should just make a new topic branch and start at
that point that I needed".

And then - once you've done all the "new work" that depended on that
state, only at *THAT* point do you merge the topic branch.

And look - you have exactly the same commits: you have one (or more)
normal commits that implement the new feature, and you have one merge
commit, but notice how much easier it is to write the explanation for
the merge when you do it *after* the work.

Instead of having to waffle about "future work depends on this feature
that was in another branch, so I'm merging this branch", your merge
commit now makes *sense*. You're not merging some old state in order
to create new features, you are literally just merging the completed
new feature.

So *this* is one reason I want people to really think about, and
explain, their merges. Because it may be that having to explain it
makes you go "Oh, I'm doing this wrong".

Now, in your case, I don't actually think you needed that merge for
any "future new work" at all. I think you just randomly did a merge to
just get the same warning fixes that you had already sent me. So in
this case, it smells like the merge was just entirely superfluous.

Those kinds of superfluous merges can be ok - it's just annoying to
have a development branch that still shows some artifact that you
already fixed elsewhere.

But they still need the explanation. And for that case, I want the
explanation partly to make it clear that you really *thought* about
it, and partly just so that I can see why you did it.

Because we have a very real history where people did mindless daily
back-merges like this "just because" with absolutely no rhyme or
reason, just because they wanted to start each day with the most
recent base, and it really gets very ugly. The development history can
go from a DAG that actually visualizes the different development
streams nicely to a spider-net maze of inexplicable merges very
quickly.

         Linus
