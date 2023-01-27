Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240F567EE20
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjA0TZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjA0TZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:25:52 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8829D7E6E9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:25:51 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so16418872ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XsokS1YP+ed5nK3QU8sNOQqirFUSIf3rP7aib6Oe1Js=;
        b=gcQ2G1/dQOADZqdeXGdob2JCT0R19DKOkThzM8086d+XPChpdlL1O/HbyY/n4Y1Mib
         kJKg8P5v723hpFPJl4hBVx0pTFYgX1A7HTvUtpsYF97hn7ONu8XXAJ18HfyW+PvWdjMm
         GPd8oYLzRqBi0f58p7mAkIMY/2hQt5jB/YcBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsokS1YP+ed5nK3QU8sNOQqirFUSIf3rP7aib6Oe1Js=;
        b=ApD3ioMoVptTYjPyk9WHuh6zxGyRq4dEHCJe/DA7V4DLOdCzmZr8ol/KGgPlRKom6I
         HFcHro6FJyozCra9kbksTFY6sMtnJeZcXJXJqyBsu2B2hKazAOjhIZxGZ4JfF6sSsNva
         4bPDO3VJCxdHb77hoh54AJ6yTab8ZUhcB5moAcTQetVQEhmIpPcKLDQ+UgqFsMC9wB+h
         odjEJkx3M6T3yUI68owbEwqT9BJHZrGB1Xn/MyStohmmmychin8z0WVq6+NGA3+X0sb2
         pkfFM+xAwsDqRWo3s6z3xX5K5H7xMumIUsc4K6CDlcdJP7j44C+yTwJgR+T5HoZNn+c0
         fe/Q==
X-Gm-Message-State: AO0yUKU2ogf+MnOcnDsSco+8TXarbK+JrgGU6etKdq8D1Yp3h5EfwIT+
        TSdcWPvBMWWNaQ/L7acyd1JAuEc4GOYbbTtr6IE=
X-Google-Smtp-Source: AK7set/j5UtvJ3nX/7fuYwwwOnmXmeYP6CCmJ+VobG7o4hhbmgdRqmqsyI/y0WGhJ/15i38Vc590oQ==
X-Received: by 2002:a17:906:65d8:b0:878:5c22:6e03 with SMTP id z24-20020a17090665d800b008785c226e03mr7088698ejn.73.1674847549835;
        Fri, 27 Jan 2023 11:25:49 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id z4-20020a170906714400b0087223b8d6efsm2761689ejj.16.2023.01.27.11.25.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 11:25:49 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id qw12so495086ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:25:49 -0800 (PST)
X-Received: by 2002:a17:906:d9ce:b0:878:70c8:14f0 with SMTP id
 qk14-20020a170906d9ce00b0087870c814f0mr1906275ejb.20.1674847548910; Fri, 27
 Jan 2023 11:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20230118150703.4024-1-ubizjak@gmail.com> <20230118131825.c6daea81ea1e2dc6aa014f38@linux-foundation.org>
 <CAFULd4ZQGG+N3f7xDuoiNG1jY128pqaH0F4eLKO+fhvSNAbKfA@mail.gmail.com>
 <CAFULd4b5szcTHTVbGJ9WiciG_+8kANiPZYP_pkEZUhnz_HHy-g@mail.gmail.com>
 <913c01d41f824fa8b3400384437fa0d8@AcuMS.aculab.com> <CAFULd4aDORSrq7zf_LcAZRP8HOHcrq2-rGMaroKyG2zQDHNpOA@mail.gmail.com>
 <CAGudoHF6zbyzza6xysuCjcxjHAUgeAVvgW0sqxDAFQNwz9u7wg@mail.gmail.com>
 <CAHk-=whUSZk1dZrJuhxeb4qB3POstVRwOZCN8PXd3W7ztbqQBg@mail.gmail.com> <Y9NK/2Wv0o67KA2w@ZenIV>
In-Reply-To: <Y9NK/2Wv0o67KA2w@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Jan 2023 11:25:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wih--CcOho+zAp9BM4a2GXVE6QfT1t50=G8ZPS99OVDZQ@mail.gmail.com>
Message-ID: <CAHk-=wih--CcOho+zAp9BM4a2GXVE6QfT1t50=G8ZPS99OVDZQ@mail.gmail.com>
Subject: Re: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, Uros Bizjak <ubizjak@gmail.com>,
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

On Thu, Jan 26, 2023 at 7:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> >
> > And extending the LOOKUP_RCU window all the way over the stat info
> > gathering would require a lot of care, and force us to expose the
> > kinds of things we do for LOOKUP_RCU in namei.c to fs/stat.c too.
>
> Interesting...  So basically a variant of filename_lookup() that
> fills struct kstat instead of doing that to struct path?

Well, kinda. You still want the fallback to struct path in case you
can't fill in the kstat without it (because the filesystem needs to do
something under RCU).

So I think what you'd really want is something like a special version
of filename_lookup() that is then given an optimistic "call this
function under RCU before you finalize the path".

And then, *if* the filesystem can do the kstat lookup etc under RCU,
it can just fill it in there, and instead of finalizing the path, we
can just do terminate the walk without ever doing the try_to_unlazy()
that legitimizes the path.

I suspect it's fairly close to how we do d_revalidate() for the path
component, except we'd do this not per-component, but as a "for the
final result, let's do one last thing under RCU, and if it succeeded
there, we don't actually need the path at all after all, because we've
already done everything we needed".

I think the only really relevant situation this is the case is
basically the stat() family of functions, since those don't actually
care about the path after the operation.

But there are other cases that have that

        error = filename_lookup(dfd, filename, lookup_flags, &path, NULL);
        ... do something simple once ...
        path_put(&path);

pattern where we just do the 'put' on the path and don't have any
other use for it.

The io_uring xattr code matches that same pattern, for example - but
may simply not be worth worrying about.

So either some generic "callback under RCU before we finalize it", or
we could make it very specific for just "fill in kstat and don't
bother finalizing the path when this flag is set"

> Looks like the main obstacle is how to deal with duplication between
> that thing and vfs_getattr{,_nosec}();

I think we'd need something like a new ->rcu_getattr() function, and
filesystems that can do getattr under RCU would just set that function
pointer.

I dunno. I didn't look at it all, but it *feels* like you could have
something that just says "if I have this function, and calling it
returns success, then we can just do "terminate_walk()" without ever
doing "try_to_unlazy()".

                 Linus
