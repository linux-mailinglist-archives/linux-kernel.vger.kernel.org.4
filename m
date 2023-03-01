Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F33E6A702E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjCAPtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjCAPt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:49:29 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014831BFC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 07:49:24 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id h9so14466863ljq.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 07:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677685763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JkydG2DRk4JOaJeEiFWJUTEBQi7aSQ+GmTlbAeBTqY=;
        b=Ikn7e+BoE4WfGJwctB8k0N3bt9XTlZfSkpOU461CEJ6hnFoyOyPQTR+Xocy5lD1nGD
         SfCeE6Hm4/4m53EsigjTIW+ryHqI7CvsdFsjrAi/rKvX73l0LcLTBME/AEtDnjchj9R8
         1Z5dasOZJ8P5gteajVDvoydGbK29VslX/OmKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677685763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JkydG2DRk4JOaJeEiFWJUTEBQi7aSQ+GmTlbAeBTqY=;
        b=Pi2wCdqrlct/0+hqNFklbUKOCkmLuAM0eF0f4/7SQqZmqQz2VO3Ss6dDchRTH74pNN
         xX+GhRSRsD6nhqbfZj1q/LeFXxuXq6kEXsWgZUFVeER4bJmAOFTVzNnnjSpTpFGvzVof
         F8jRWEVHGiqi4TxiyKUdkgZ5uQzw4wYmtEFPTk+KEjgBb11uLd5ZV7H8pZhV0pVSv2Ne
         z6uwbMMUXYiRVDGFirNwoOH9mYfWog1iMdLpVcZ0hK1XZMVgOZVqILa6FMV/y8ktmNDI
         ICjLXu+ZO9F/0VAdnT7YJ4vqUnJZ9hoRknvO4AQl4KnmvCUGLL+1Mm7PU2UZoILmbRvr
         QJSA==
X-Gm-Message-State: AO0yUKXYQ9I+UsMwHqoD8apTWuLx1FJ/rfCzoc7My77HvhLRH0Y/2BhP
        CmiDU/GIdhqSlr3uX6jgyoZqBCHetTrkNo0kSaLqOw==
X-Google-Smtp-Source: AK7set95iPbgny2MOgX4k296eemoKEMpGfg3hrtBBuu8xtR8ABzVCOuKwdUwyBS9SRiM0RMA8D6WHbOIVzw74Y+RyRE=
X-Received: by 2002:a05:651c:170b:b0:295:b597:c903 with SMTP id
 be11-20020a05651c170b00b00295b597c903mr2190963ljb.3.1677685763184; Wed, 01
 Mar 2023 07:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20230228175929.7534-1-ubizjak@gmail.com> <20230228175929.7534-4-ubizjak@gmail.com>
 <20230228164346.0691bb11@gandalf.local.home> <CAFULd4aGx=kGYYUz0BkFJz3abz97WOwDEgFHAOocT8SWT2oX-Q@mail.gmail.com>
In-Reply-To: <CAFULd4aGx=kGYYUz0BkFJz3abz97WOwDEgFHAOocT8SWT2oX-Q@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 1 Mar 2023 10:49:11 -0500
Message-ID: <CAEXW_YS89AXrbFXZpYeyh=5AxbQwhxDitniVcz=_tWFvnyuQyA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ring_buffer: Use try_cmpxchg instead of cmpxchg
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 4:37=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> On Tue, Feb 28, 2023 at 10:43 PM Steven Rostedt <rostedt@goodmis.org> wro=
te:
> >
> > On Tue, 28 Feb 2023 18:59:29 +0100
> > Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > Use try_cmpxchg instead of cmpxchg (*ptr, old, new) =3D=3D old.
> > > x86 CMPXCHG instruction returns success in ZF flag, so this change
> > > saves a compare after cmpxchg (and related move instruction in
> > > front of cmpxchg).
> > >
> > > Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmp=
xchg
> > > fails. There is no need to re-read the value in the loop.
> > >
> > > No functional change intended.
> >
> > As I mentioned in the RCU thread, I have issues with some of the change=
s
> > here.
> >
> > >
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > ---
> > >  kernel/trace/ring_buffer.c | 20 ++++++++------------
> > >  1 file changed, 8 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > index 4188af7d4cfe..8f0ef7d12ddd 100644
> > > --- a/kernel/trace/ring_buffer.c
> > > +++ b/kernel/trace/ring_buffer.c
> > > @@ -1493,14 +1493,11 @@ static bool rb_head_page_replace(struct buffe=
r_page *old,
> > >  {
> > >       unsigned long *ptr =3D (unsigned long *)&old->list.prev->next;
> > >       unsigned long val;
> > > -     unsigned long ret;
> > >
> > >       val =3D *ptr & ~RB_FLAG_MASK;
> > >       val |=3D RB_PAGE_HEAD;
> > >
> > > -     ret =3D cmpxchg(ptr, val, (unsigned long)&new->list);
> > > -
> > > -     return ret =3D=3D val;
> > > +     return try_cmpxchg(ptr, &val, (unsigned long)&new->list);
> >
> > No, val should not be updated.
>
> Please see the definition of try_cmpxchg. The definition is written in
> such a way that benefits loops as well as linear code and in the later
> case depends on the compiler to eliminate assignment to val as a dead
> assignment.
>
> The above change was done under the assumption that val is unused
> after try_cmpxchg, and can be considered as a temporary
> [Alternatively, the value could be copied to a local temporary and a
> pointer to this local temporary could be passed to try_cmpxchg
> instead. Compiler is smart enough to eliminate the assignment in any
> case.]

If I understood Steve correctly, I think the "misleading" part is that
you are passing a variable by address to try_cmpxchg() but not really
modifying it (unlike in the loop patterns).

Perhaps it is more meaningful to have an API that looks like:
bool cmpxchg_succeeded(TYPE ptr, TYPE old, TYPE new)
Where old is not a pointer (unlike try_cmpxchg), and the API returns bool.

Both cleaner to read and has the optimization you want, I believe.

However, the other point is, this is useful only for slow paths, but
at least cmpxchg_succeeded() is more readable and less "misleading"
than try_cmpxchg() IMO.

 - Joel

[...]
