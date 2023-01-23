Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10209678677
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjAWTgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjAWTgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:36:46 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7FE30E9B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:36:44 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id q15so10826399qtn.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PGBgateVC2uw8kpcfhZiYmmB9XGcVuuEV0X2SQc0v2Q=;
        b=MS+YzRWdkMeCP7tOCCC5KuUuirEsDD2k+yGWAh9vubpHqYlZeFoWMb6GOkV8QZaX6H
         0Hozkd37oW36uuNHWgvcT0xBM1V0vtZDW815MtzCv7ueaB5rvxiSxFADBNJj9RTkhxRJ
         pThXZ1W1pFtv8iUSiL6eJC9UJIqsjg4V1ZWEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGBgateVC2uw8kpcfhZiYmmB9XGcVuuEV0X2SQc0v2Q=;
        b=nFQNMVcV76zdGT2qdqXAIMwIQC5m6DYyg33+Gm/EHKPZhplcCn25lAO7IJftcSh+PR
         Z/3IfSBA7AmOdYGS9aEtfgUliQaIw+w6KpIN4eNPIk1ILMTJJXAzapWjVNjXtRk7N8EP
         mNT0PhvKsy21cuaf/mUNH7JAZt/IRRF3Pv4IHZf+TM1qp6cOZJsQ+Ngyg0mP463WOvX/
         GaH77UshRnKDghqRMYzHaoWarQ/Je/5MPXPVA6KM+0injrX5q8TyDYHlABYCVBdcxqCn
         iYiLLeSkjOR7xG8sITonH6SQI10EWYL3kjvdQeZoB+e4qHmo+W+OKOghIRydq/GZmBJU
         86ww==
X-Gm-Message-State: AFqh2kocXErCoTfFfjeAobG/vlWlJhyaNnBbnSNiIawbS6e8ouiubABh
        KgfUTPq2ZZMWHreotOUxrZsnKJRIswwEOkOp
X-Google-Smtp-Source: AMrXdXvGad7JjyMpOOiONQV5rwiS0uiMpI+Qf3YbGvrviUirAm5OzXJqqOJVHuX13WpuAWw6JW2pKA==
X-Received: by 2002:ac8:70cb:0:b0:3a7:f599:9c6c with SMTP id g11-20020ac870cb000000b003a7f5999c6cmr35860802qtp.26.1674502602865;
        Mon, 23 Jan 2023 11:36:42 -0800 (PST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com. [209.85.219.46])
        by smtp.gmail.com with ESMTPSA id e26-20020ac845da000000b003a527d29a41sm12161476qto.75.2023.01.23.11.36.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 11:36:42 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id i12so9894802qvs.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:36:42 -0800 (PST)
X-Received: by 2002:ad4:50a9:0:b0:532:31b0:b4fa with SMTP id
 d9-20020ad450a9000000b0053231b0b4famr1597538qvq.129.1674502602064; Mon, 23
 Jan 2023 11:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20230118150703.4024-1-ubizjak@gmail.com> <20230118131825.c6daea81ea1e2dc6aa014f38@linux-foundation.org>
 <CAFULd4ZQGG+N3f7xDuoiNG1jY128pqaH0F4eLKO+fhvSNAbKfA@mail.gmail.com>
 <CAFULd4b5szcTHTVbGJ9WiciG_+8kANiPZYP_pkEZUhnz_HHy-g@mail.gmail.com>
 <913c01d41f824fa8b3400384437fa0d8@AcuMS.aculab.com> <CAFULd4aDORSrq7zf_LcAZRP8HOHcrq2-rGMaroKyG2zQDHNpOA@mail.gmail.com>
 <CAGudoHF6zbyzza6xysuCjcxjHAUgeAVvgW0sqxDAFQNwz9u7wg@mail.gmail.com>
In-Reply-To: <CAGudoHF6zbyzza6xysuCjcxjHAUgeAVvgW0sqxDAFQNwz9u7wg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Jan 2023 11:36:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=whUSZk1dZrJuhxeb4qB3POstVRwOZCN8PXd3W7ztbqQBg@mail.gmail.com>
Message-ID: <CAHk-=whUSZk1dZrJuhxeb4qB3POstVRwOZCN8PXd3W7ztbqQBg@mail.gmail.com>
Subject: Re: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
To:     Mateusz Guzik <mjguzik@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, Jan 23, 2023 at 7:59 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> In that case what about lockref? It definitely is not the fastest it
> can be, for one some provisions could be made for NUMA-aware handling.

Note that the contention case for lockref really is fairly made-up.

Yes, yes, it's easy enough to trigger with microbenchmarks. In real
life less so.

> Basic idea would be to have competing CPUs aggregate the total change
> on the lock and then have one of them make it happen across the
> interconnect -- so instead of add/sub 1 you would add/sub n, where n
> can very well be quite big.

No. The use is literally serialized, and done one at a time, and needs
to be synchronous.

We're talking about looking up a <i>single</i> path component, while
at the same time making sure that that path component isn't being
removed by another CPU - and there is by definition no other locking
going on, because the lockref *is* the locking.

And it really is one single path component, because this is all very
much the equivalent of doing a list traversal (where the "list" is the
full path, and the list entries are the individual components), and
there is absolutely zero parallel cases except for entirely
independent threads doing this in parallel on *different* paths (that
may have common components, of course, with the root and home
directory in particular being shared - but they are "shared" only in
the sense that lots of threads use them entirely independently).

Now, there are ways to do lockref more efficiently, but I suspect

 (a) most of them are about hardware optimizations

 (b) it's very seldom an issue in practice, because the code is
actually very good at avoiding them already (ie the RCU pathname walk
already avoids it)

Thanks to RCU pathname lookup, the lockref thing *should* come into
play only when  you actually fall out of RCU mode, ie for the last
component. That's a huge win, because that's what avoids the whole
"everybody hammers on the root/pwd dentry counts".

Your benchmark that looked up the *same* last component in parallell
and all the time is not really a real load.

As to the actual hardware optimizations, it would be interesting to
see if a LL/SC architecture might do a "native" lockref implementation
better than the "emulated" one that just uses LL/SC for the cmpxchg.

And Intel *has* talked about instruction set extensions for remote
atomics, and using CMPxxXADD *may* be a win. At least it would avoid
the *looping* on cmpxchg, and it *migth* avoid bouncing the value too
if the op is actually done using L3 accesses or something.

(But I do also worry that CMPxxXADD migth actually make things *worse*
because of any remote access, because caches worka and contention is
rare, and in many common cases you might be better off with a local
cache than with a remote one).

So I'm not claiming lockref is perfect, but I do suspect you're
barking up the wrong tree here. The optimizations you are talking
about are either not realistic in the first place (because
serialization and locking) or have already mostly been done (ie
avoiding the op entirely except for the last component).

HOWEVER. There is one special exception that might be interesting and
that has never been done: 'fstat()' and friends could possibly avoid
the "try_to_unlazy()" even for the last component.

IOW, we might be able to do fstatat() without ever even finalizing the
RCU state of the pathname, and actually looking up the stat
information while still in RCU mode, and instead of doing the actual
final lockref_get_not_dead() to turn an RCU path into a real
ref-counted path, we could just do the "get the stat info, then do
read_seqcount_retry() to verify that the RCU walk _and_ the stat info
is still valid".

But I'm not convinced that final complexity would be worth it. It
sounds like a potentially fun and interesting exercise (Al Viro added
to particupants so that he can say "No! That's not 'fun and exciting',
that's just crazy!") if somebody really wants to, but see above: the
last path component is very seldom something that sees contention. You
look up the same root/pwd over and over again, but nobody sane looks
up the same full pathname over and over again.

And extending the LOOKUP_RCU window all the way over the stat info
gathering would require a lot of care, and force us to expose the
kinds of things we do for LOOKUP_RCU in namei.c to fs/stat.c too.

So it might be fun and exciting, but it might also be quite nasty, and
it's not entirely clear that ti would be worth the pain.

But since you clearly were looking at fstatat() performance, I can
only point you at this case and say "There's _potentially_ upside
there".

                   Linus
