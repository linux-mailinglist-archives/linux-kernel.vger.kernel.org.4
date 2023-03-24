Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977FA6C8960
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 00:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjCXXid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 19:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjCXXib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 19:38:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAA315CB1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:38:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eg48so13728759edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679701101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZvH/dLcD2vRcbCXF9npzcRjSuFqRKQGdZPrUOz5Jgo=;
        b=XVeK829btdxKIg+thjaP/IT8lt6a5tb3bxUlerQHm8JA/PIzhc9Gg3qz9UguvVeDmF
         HYnl8GDysgE1Pjl7u3mq4LFYiAxbRwDGWA8vyBD/j2G7HKbLXXVLQwWuYzlqmTpEbLLF
         OZxINnIvxT0Z8nLbkI2t3TtXLWnWpC4DThdb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679701101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZvH/dLcD2vRcbCXF9npzcRjSuFqRKQGdZPrUOz5Jgo=;
        b=beBsM6gbAIvLY+Cp+hMkkwqv6uJvGAXgIzDUOe6AvIe1hjiG0tOvwb4/xSZWluukRg
         BFvo1jnrpEEen7zyZnQSzd++n3TdMHQZL9shMXFHdisd3eGwh2s0/9KIaWTfa6Nnjj9k
         z2F9iXctHq0lYIwvyJqYlS4RwYaLPwSiAU8don5eo2dxCYMj8SCt4EHmPRkUdhLUhNp4
         gCHQ5Z8o4yeETQDA05ZlcYQzqbx+ptkm63JLKn23GDGjUk8D1mjk+anBlhgIZ1FZ9+CL
         zbEAvCo0eAxVabzbFgI1F3SsbgfJZZP0xPNVduvTglmq6iQ3EfoWnlSVQ1P1vDzOERXh
         8FcQ==
X-Gm-Message-State: AAQBX9cNcUgVpLyeHeSNs/4GPznYYhTWMkhZHaLC1whywKG1MuBJlhEm
        3QZq2sw7EkcyMzAzgAx4/e9VIGRDvOnpxZxsB3iINd0S
X-Google-Smtp-Source: AKy350ZFnZ/6WPpi5fbKx4nrphn1anXTFKmJxCf/d0tHbqvFxmnUkSq61UxdSSop6h2GIpewOmeIHw==
X-Received: by 2002:a05:6402:18:b0:501:cf67:97fc with SMTP id d24-20020a056402001800b00501cf6797fcmr4396369edu.10.1679701101407;
        Fri, 24 Mar 2023 16:38:21 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 28-20020a508e5c000000b004fc856b208asm11567652edx.51.2023.03.24.16.38.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 16:38:20 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id x3so13751779edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:38:20 -0700 (PDT)
X-Received: by 2002:a50:cd0b:0:b0:4fc:a484:c6ed with SMTP id
 z11-20020a50cd0b000000b004fca484c6edmr2277835edi.2.1679701100013; Fri, 24 Mar
 2023 16:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <ZB2GTBD/LWTrkOiO@dhcp22.suse.cz> <20230324130530.xsmqcxapy4j2aaik@box.shutemov.name>
 <CAEXW_YQj_Wg0Xx2cHT9hTrDjEtrAV-bRjgL79=76d=D5f8GnEA@mail.gmail.com>
In-Reply-To: <CAEXW_YQj_Wg0Xx2cHT9hTrDjEtrAV-bRjgL79=76d=D5f8GnEA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Mar 2023 16:38:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whuXx+cyGhFKjU0qjzvgna8iDA8YcqDDyH3cQywixuMgA@mail.gmail.com>
Message-ID: <CAHk-=whuXx+cyGhFKjU0qjzvgna8iDA8YcqDDyH3cQywixuMgA@mail.gmail.com>
Subject: Re: WARN_ON in move_normal_pmd
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 6:43=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> Wouldn't it be better to instead fix it from the caller side? Like
> making it non-overlapping.

I wonder if we could just do something like this in mremap() instead

 - if old/new are mutually PMD_ALIGNED

 - *and* there is no vma below new within the same PMD

 - then just expand the mremap to be PMD-aligned downwards

IOW, the problem with the exec stack moving case isn't really that
it's overlapping: that part is fine. We're moving downwards, and we
start from the bottom, so the moving part works fine.

No, the problem is that we *start* by moving individual pages, and
then by the time we've a few pages down by a whole PMD, we finish the
source PMD (and we've cleared all the contents of it), but it still
exists.

And at *that* point, when we go and start copying the next page, we're
suddenly fully PMD-aligned, and now we try to copy a whole PMD, and
then that code is unhappy about the fact that the old (empty) PMD is
there in the target.

And for all of this to happen, we need to move things by an exact
multiple of PMD size, because otherwise we'd never get to that aligned
situation at all, and we'd always do all the movement in individual
pages, and everything would be just fine.

And more importantly, if we had just *started* with moving a whole
PMD, this also wouldn't have happened. But we didn't. We started
moving individual pages.

So you could see the warning not as a "this range overlaps" warning
(it's fine, and happens all the time, and we do individual pages that
way quite happily), but really as a "hey, this was very inefficient -
you shouldn't have done those individual pages as several small
independent invidual pages in the first place" warning.

So some kind of

        /* Is the movement mutually PMD-aligned? */
        if ((old_addr ^ new_addr) & ~PMD_MASK =3D=3D 0) {
                .. try to extend the move_vma() down to the *aligned*
PMD case ..
        }

logic in move_page_tables() would get rid of the warning, and would
make the move more efficient since you'd skip the "move individual
pages and allocate a new PMD" case entirely.

This is all fairly com,plicated, and the "try to extend the move
range" would also have to depend on CONFIG_HAVE_MOVE_PMD etc, so I'm
not saying it's trivial.

But it would seem to be a really nice optimization, in addition to
getting rid of the warning.

It could even help real world cases outside of this odd stack
remapping case if users ever end up moving vma's by multiples of
PMD_SIZE, and there aren't other vma's around the source/target that
disable the optimization.

Hmm? Anybody want to look into that? It looks hairy enough that I
think that "you could test this with mutually aligned mremap()
source/targets in some test program" would be a good thing. Because
the pure execve() case is rare enough that using *that* as a test-case
seems like a fool's errand.

(To make things very clear: the important part is that the source and
targets aren't *actually* PMD-aligned, just mutually aligned so that
you *can* do the mremap() by just moving whole PMD's around)

               Linus
