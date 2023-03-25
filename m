Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E5B6C8F86
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 17:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCYQrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 12:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjCYQrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 12:47:18 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6FF10254
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 09:47:17 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5456249756bso91955117b3.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679762836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuinZIw6Yor0K6X5bMFGjb+r0iCgiWpAUiHlBpjx5S4=;
        b=tNGKWix9w4Ros/0fBXDlveKlSF9FdbpZJ1Dp89Z8JTU7YaU3W/pu5VUnT1DTQCvU9u
         p/h8Q/KsMaT4YHx4fwreDlA5KCqakQasOKbUKfeVQ27qpFT9mc4QY3nTv0+hZU2WbGk0
         Ji4o/izZ8S7JILa2vpNvZfnklM4CozlwaB/qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679762836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuinZIw6Yor0K6X5bMFGjb+r0iCgiWpAUiHlBpjx5S4=;
        b=zQ1MtM5mls41m0VJd6clmYmf1d6+OxCVBdRnx/MlohhPJDkJAlpFf98R0Ikfd6ru04
         vj6cl2LxFgEq7gOasXc1BB9QeKhaUr+0+qM0cr/myOOBL9PY1iLPzfzyn4wEPfcIkpuq
         Npqy7QGV8bUUGb3AjDlMixszlsv6V7+S7r5g3NDx4O4NYMi4kr36C+L+0NIydhoDlN2K
         SRxYPxUKorMXbR5tmgphWx0M5KBJzEZDNVbGztShjRVIfAZk7TyRA3P1j7ZglwDTzhgb
         91IcGu4MT3Wym5JEm5xffRyxxg1VUHso7AwtKhqH7ulWiFkWvXPTdaTEFzvX5DkuUbMg
         D5Xg==
X-Gm-Message-State: AAQBX9eJ5RMY7pMfS2liCYKEVphJxXM5X1Hv6m/9J0u+iQzXGJ+vFslj
        JCg1TrBJ+W1QrLltGes6nbAGAmIy5kLFq13K7506MDbYvN9oTn37
X-Google-Smtp-Source: AKy350ZYw1WANBO4EDCyYnPXd89I5FSJCYTgiymkFeQE8UuNELTYzA5K0tFwLLrI7AcuMDNicjm/odmWzRC498sKYVI=
X-Received: by 2002:a81:a707:0:b0:545:6225:4536 with SMTP id
 e7-20020a81a707000000b0054562254536mr2752308ywh.9.1679762836444; Sat, 25 Mar
 2023 09:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <ZB2GTBD/LWTrkOiO@dhcp22.suse.cz> <20230324130530.xsmqcxapy4j2aaik@box.shutemov.name>
 <CAEXW_YQj_Wg0Xx2cHT9hTrDjEtrAV-bRjgL79=76d=D5f8GnEA@mail.gmail.com>
 <CAHk-=whuXx+cyGhFKjU0qjzvgna8iDA8YcqDDyH3cQywixuMgA@mail.gmail.com> <20230325163323.GA3088525@google.com>
In-Reply-To: <20230325163323.GA3088525@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 25 Mar 2023 12:47:05 -0400
Message-ID: <CAEXW_YQth_eaGH3AyA4UR9yDXAMKNxgeRA0T8fgRjW_UdtQpMA@mail.gmail.com>
Subject: Re: WARN_ON in move_normal_pmd
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 12:33=E2=80=AFPM Joel Fernandes <joel@joelfernandes=
.org> wrote:
>
> Hi Linus,
>
> On Fri, Mar 24, 2023 at 04:38:03PM -0700, Linus Torvalds wrote:
> > On Fri, Mar 24, 2023 at 6:43=E2=80=AFAM Joel Fernandes <joel@joelfernan=
des.org> wrote:
> > >
> > > Wouldn't it be better to instead fix it from the caller side? Like
> > > making it non-overlapping.
> >
> > I wonder if we could just do something like this in mremap() instead
> >
> >  - if old/new are mutually PMD_ALIGNED
> >
> >  - *and* there is no vma below new within the same PMD
> >
> >  - then just expand the mremap to be PMD-aligned downwards
> >
> > IOW, the problem with the exec stack moving case isn't really that
> > it's overlapping: that part is fine. We're moving downwards, and we
> > start from the bottom, so the moving part works fine.
> >
> > No, the problem is that we *start* by moving individual pages, and
> > then by the time we've a few pages down by a whole PMD, we finish the
> > source PMD (and we've cleared all the contents of it), but it still
> > exists.
> >
> > And at *that* point, when we go and start copying the next page, we're
> > suddenly fully PMD-aligned, and now we try to copy a whole PMD, and
> > then that code is unhappy about the fact that the old (empty) PMD is
> > there in the target.
> >
>
> You are very right. I am able to also trigger the warning with a syntheti=
c
> program that just mremaps a range and moves it in the same way that trigg=
ers
> this issue, however I had to hack the kernel to prevent mremap from error=
ing
> out if ranges overlap (unlike exec, mremap does some initial checks for
> that). Also had to do other hacks but I did reproduce it consistently.
>
> The issue is that even though the PMD is empty, it is allocated. So
> pmd_none() is kind of a lie in some sense, it is pointing to empty PTEs w=
hen
> the range is really empty.
>
> How about we replace the warning with something like the following?
>
> +       if (unlikely(!pmd_none(*new_pmd))) {
> +               // Check if any ptes in the pmd are non-empty. Doing this=
 here
> +               // is ok since this is not a fast path.
> +               bool pmd_empty =3D true;
> +               unsigned long tmp_addr =3D new_addr;
> +               pte_t* check_pte =3D pte_offset_map(new_pmd, new_addr);
> +
> +               new_ptl =3D pte_lockptr(mm, new_pmd);
> +               spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> +               for (; tmp_addr < old_addr + PMD_SIZE; check_pte++, tmp_a=
ddr +=3D PAGE_SIZE) {

Apologies, here I was going for "tmp_addr < new_addr + PMD_SIZE".  I
made the change and it still works (This is just to show the basic
idea, I am still testing it).

thanks,

 - Joel


> +                       if (!pte_none(*check_pte)) {
> +                               pmd_empty =3D false;
> +                               break;
> +                       }
> +               }
>
> +               WARN_ON_ONCE(!pmd_empty);
> +               spin_unlock(new_ptl);
> +       }
> +
>
> > And for all of this to happen, we need to move things by an exact
> > multiple of PMD size, because otherwise we'd never get to that aligned
> > situation at all, and we'd always do all the movement in individual
> > pages, and everything would be just fine.
> >
> > And more importantly, if we had just *started* with moving a whole
> > PMD, this also wouldn't have happened. But we didn't. We started
> > moving individual pages.
> >
> > So you could see the warning not as a "this range overlaps" warning
> > (it's fine, and happens all the time, and we do individual pages that
> > way quite happily), but really as a "hey, this was very inefficient -
> > you shouldn't have done those individual pages as several small
> > independent invidual pages in the first place" warning.
> >
>
> Exactly.
>
> > So some kind of
> >
> >         /* Is the movement mutually PMD-aligned? */
> >         if ((old_addr ^ new_addr) & ~PMD_MASK =3D=3D 0) {
> >                 .. try to extend the move_vma() down to the *aligned*
> > PMD case ..
> >         }
> >
>
> I actually didn't follow what you meant by "mutually PMD-aligned". Could =
you
> provide some example address numbers to explain?
>
> AFAIK, only 2MB aligned memory addresses can be directly addressed by a P=
MD.
> Otherwise how will you index the bytes in the 2MB page? You need bits in =
the
> address for that.
>
> > logic in move_page_tables() would get rid of the warning, and would
> > make the move more efficient since you'd skip the "move individual
> > pages and allocate a new PMD" case entirely.
> >
> > This is all fairly com,plicated, and the "try to extend the move
> > range" would also have to depend on CONFIG_HAVE_MOVE_PMD etc, so I'm
> > not saying it's trivial.
> >
> > But it would seem to be a really nice optimization, in addition to
> > getting rid of the warning.
> >
> > It could even help real world cases outside of this odd stack
> > remapping case if users ever end up moving vma's by multiples of
> > PMD_SIZE, and there aren't other vma's around the source/target that
> > disable the optimization.
> >
> > Hmm? Anybody want to look into that? It looks hairy enough that I
> > think that "you could test this with mutually aligned mremap()
> > source/targets in some test program" would be a good thing. Because
> > the pure execve() case is rare enough that using *that* as a test-case
> > seems like a fool's errand.
> >
>
> Just to mention, mremap errors out if you try to move overlapping ranges
> because this in  mremap_to():
>
>        /* Ensure the old/new locations do not overlap
>         if (addr + old_len > new_addr && new_addr + new_len > addr) {
>                 pr_err("%s: (%s) (%d)", __func__, __FILE__, __LINE__);
>                 goto out;
>         }
>
> Or is there an mremap trick I might be missing which actually allows
> overlapping range moves?
>
> thanks,
>
>  - Joel
>
>
