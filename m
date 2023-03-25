Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9506C8FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 18:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCYRHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 13:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYRHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:07:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A287AA9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:07:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t10so19717270edd.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679764037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EsZB6yEVOxUzDuq6efy5zLPvRU3T6pjyjc8/hy6n1g=;
        b=HnAKcQuX7wFaG403iVg1comNdQeJfEaFDEKex0z0FvtkMmvWjgpB+ylLds5gJsGPb8
         Ez8kpKGz/PlqGHQyzEX+xa0qutHUJ7GKbSB8GQTpKdznV3VCMUv54QJ0dfLX7jNVV5GY
         3B0yvRf6E0bCwxaWcK8PutAuax6405lfs6GP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679764037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EsZB6yEVOxUzDuq6efy5zLPvRU3T6pjyjc8/hy6n1g=;
        b=v5yfJcfpPf0uLOV76u+yoS1N4wmCzGFWKwrvsZkEI1AhQAP4fF6NsfOKh2SPFYXrmk
         13Syj+zYCfK3s4i5hPGsje6mhJqOVyCQew9d4NnGbzcD3/F4wpBolRFw/0xahPnV1gVd
         2oNx1eRnNI34XwmtcxS7THYs8DHoujwyoeVb8v5P0YoD3IhW4eFQDq1lpEYpKqilv4G0
         biLnejpMxFZkY32e/GifdJrADF/Eg35+ZZSynvdtaKnjfJTvslzpgLSV7PUHt8gbEZES
         ayija9Ip6uINGzUoaz18ylwYMAxblV8d0gtdgkdlJxO8npYdZL+BHk7hQIGxJ5Pan8Yc
         6NGw==
X-Gm-Message-State: AAQBX9cR9gPEG68y5HtTnfarxpcif4+SoUUyajQB3J0Ln1qxrhtAkAnj
        IxMLHDXydW2jfdO/LR0f9N+1vVDFTeKs0bGw4tiVIcdQ
X-Google-Smtp-Source: AKy350YHPIgtGYHqMnIjE2P2QrfmpzcrUMmghKeibBikaCDQcObOIL7up3ZCiE2oo/S1Ub/sVF8lrg==
X-Received: by 2002:a05:6402:74d:b0:502:23a2:6739 with SMTP id p13-20020a056402074d00b0050223a26739mr4881028edy.28.1679764037008;
        Sat, 25 Mar 2023 10:07:17 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id j30-20020a508a9e000000b004af5968cb3bsm12365769edj.17.2023.03.25.10.07.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 10:07:16 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id b20so19897607edd.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:07:16 -0700 (PDT)
X-Received: by 2002:a17:906:eec7:b0:93e:186f:ea0d with SMTP id
 wu7-20020a170906eec700b0093e186fea0dmr2853620ejb.15.1679764035953; Sat, 25
 Mar 2023 10:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <ZB2GTBD/LWTrkOiO@dhcp22.suse.cz> <20230324130530.xsmqcxapy4j2aaik@box.shutemov.name>
 <CAEXW_YQj_Wg0Xx2cHT9hTrDjEtrAV-bRjgL79=76d=D5f8GnEA@mail.gmail.com>
 <CAHk-=whuXx+cyGhFKjU0qjzvgna8iDA8YcqDDyH3cQywixuMgA@mail.gmail.com> <20230325163323.GA3088525@google.com>
In-Reply-To: <20230325163323.GA3088525@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Mar 2023 10:06:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whd7msp8reJPfeGNyt0LiySMT0egExx3TVZSX3Ok6X=9g@mail.gmail.com>
Message-ID: <CAHk-=whd7msp8reJPfeGNyt0LiySMT0egExx3TVZSX3Ok6X=9g@mail.gmail.com>
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

On Sat, Mar 25, 2023 at 9:33=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> I actually didn't follow what you meant by "mutually PMD-aligned". Could =
you
> provide some example address numbers to explain?

Sure, let me make this more clear with a couple of concrete examples.

Let's say that we have a range '[old, old+len]' and we want to remap
it to '[new, new+len]'.

Furthermore, we'll say that overlapping is fine, but because we're
always moving pages from "low address to high", we only allow
overlapping when we're moving things down (ie 'new < old').

And yes, I know that the overlapping case cannot actually happen with
mremap() itself. So in practice the overlapping case only happens for
the special "move the stack pages" around at execve() startup, but
let's ignore that for now.

So we'll talk about the generic "move pages around" case, not the more
limited 'mremap()' case.

I'll also simplify the thing to just assume that we have that
CONFIG_HAVE_MOVE_PMD enabled, so I'll ignore some of the full grotty
details.

Ok?

So let's take the simple case first:

 (a) everything is PMD aligned, so all of old, new, and len are
multiples of the PMD size.

This is the simple case, because we can just do the whole move by
moving the PMD entries, and we'll never hit any issues. As we move the
PMD entries in move_normal_pmd(), we always remove the entry we are
moving down:

        /* Clear the pmd */
        pmd =3D *old_pmd;
        pmd_clear(old_pmd);

so as we move up in the destination, we will never hit a populated PMD
entry as we walk the page tables.

So (a) is fine today, everybody is happy, we have no issues. It's
efficient and simple.

The other simple case is

 (b) we're *not* PMD-aligned, and everything is done one page at a time.

This is basically the exact same thing as (a), except rather than move
the PMD entry around, we move a PTE entry, and we do the exact same
"clear the entry as we move it" in move_ptes(), except (due to our
locking rules being different), it now looks like this instead:

                pte =3D ptep_get_and_clear(mm, old_addr, old_pte);

but otherwise it's all the same as (a), just one level lower.

But then we have case (c): the "mutually aligned" case:

> AFAIK, only 2MB aligned memory addresses can be directly addressed by a P=
MD.
> Otherwise how will you index the bytes in the 2MB page? You need bits in =
the
> address for that.

The thing is, the problematic case is when 'old' and 'new' are not
initially themselves PMD-aligned (so they have lower bits set), but
they are *mutually* aligned, so they have the *same* lower bits set.

So in this case (c), we start off with case (b), but as we walk the
address one page at a time, at some point we suddenly hit case (a) in
the middle.

To make this really concrete, lets say that we have

    old =3D 0x1fff000
    new =3D 0x0fff000
    len =3D 0x201000

and we have PMD_SIZE being 0x200000.

Notice how 'old' and 'new' are *not* PMD-aligned, but they are
*mutually* aligned in the PMD size (ie "old & (PMD_SIZE-1)" and "new &
(PMD_SIZE-1)" are the same).

Look at what happens: we start with the unaligned case, and we move
one single page, from address 0x1fff000 to 0x0fff000.

But what happens after we moved that page? We'll update old/new/len,
and now, we'll have

    old =3D 0x2000000
    new =3D 0x1000000
    len =3D 0x200000

and now evertthing *is* PMD-aligned, and we just move a single PMD
entry from 0x2000000 to 0x1000000. And then we're done.

And that's fine, and won't cause any problems, because the area wasn't
overlapping at a PMD level, so we're all good.

But it it *was* overlapping, and we started out with

    old =3D 0x1fff000
    new =3D 1dff000
    len =3D 0x201000

instead, we start out with the exact same thing, but after moving one
page, we'll have

    old =3D 0x2000000
    new =3D 0x1e00000
    len =3D 0x200000

and now when we try to move the PMD entry from 0x2000000 to 0x1e00000,
we'll hit that *old* (and empty) PMD entry that used to contain that
one single page that we moved earlier.

And notice how for this all to happen, the old/new addresses have to
start out mutually aligned. So we can see the dangerous case up-front:
even if old and new aren't PMD-aligned to start with, you can see the
low bits are the same:

   (old ^ new) & (PMD_SIZE-1) =3D=3D 0

because as we move pages around, we'll always be updating old/new
together by the same amount.

So what I'm saying is that *if* we start out with that situation, and
we have that

    old =3D 0x1fff000
    new =3D 1dff000
    len =3D 0x201000

we could easily decode "let's just move the whole PMD", and expand the
move to be

    old =3D 0x1e00000
    new =3D 0x1c00000
    len =3D 0x400000

instead. And then instead of moving PTE's around at first, we'd move
PMD's around *all* the time, and turn this into that "simple case
(a)".

NOTE! For this to work, there must be no mapping right below 'old' or
'new', of course. But during the execve() startup, that should be
trivially true.

See what I'm saying?

                Linus
