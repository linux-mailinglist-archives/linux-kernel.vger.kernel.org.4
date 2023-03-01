Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D420C6A7034
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjCAPuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCAPut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:50:49 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B948334F62
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 07:50:48 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id k14so18206541lfj.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 07:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677685847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hj6eJ++1N3rPBTIwpz1eg0ar98rfOfDI3Yg4f3Txs4g=;
        b=tvCe3xzXBBIPl3AxmBXtIzZnjoaVOHSBFAB1HzTf2DstlkU2/PsVF6BjHqPhb3VnKi
         UWi0owQwaNYEqUdgfWHj6nZKTSa0pPxIaBallK7tv2OFUlAWom+PJZkePoLFcdQxV5y0
         Xjhj1KuJ2AUQiQAkiT8gqxw94Zf1A4cDWvzWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677685847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hj6eJ++1N3rPBTIwpz1eg0ar98rfOfDI3Yg4f3Txs4g=;
        b=PoUck3K9C42X5ok/SM3obgYEmcn2HNT/L1Cu05HdYGkOU9Mwhnv03+a4Vfke7mJWbU
         lJZ/IfQYrKcLrYkzQ4n0U3HHhzp1lbiJiAuMbH/FZ85GmVuWtiCAf5Hv6JsaazAP+D/9
         Cxyr9bEUo/gOxpWXD9WLZUHCWu0xjoZ2bGKFFfRVa7ouc9W0PKFz035gibgmiSMsj/TF
         UqG3dlAgHQd7L0BgCXfkI3l6xU2x19yi+YljAjZL70pCUxfuKfmox9zkbAYD5PtL3/O9
         94JMlRU3ZeoRnfk+AM/Dq5JfGgI/T1XpSdR4Y6RT0k7GdyXIMaPiyZA0gn03nUqD9HtD
         j1VA==
X-Gm-Message-State: AO0yUKVKpAtnNuNjlgK/vE/CFB4fMSqxO4LiQ43pUxzXYGkpoXbcZLHf
        Z831UU1r37yp+IxDkCayDfeq0jFLw3GDi0xB4NvXIehg92mDPQ==
X-Google-Smtp-Source: AK7set/Ii2c/xr5ug7XO7NPba/+dAmzP1vCVYVe5ySZofk0mqO+qbgoZvtCesR6s25V3nxu6Sjr4VWsnKCda2oGsulk=
X-Received: by 2002:ac2:5fe6:0:b0:4dd:a9e5:aa09 with SMTP id
 s6-20020ac25fe6000000b004dda9e5aa09mr1927421lfg.11.1677685846804; Wed, 01 Mar
 2023 07:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20230228175929.7534-1-ubizjak@gmail.com> <20230228175929.7534-4-ubizjak@gmail.com>
 <20230228164346.0691bb11@gandalf.local.home> <CAFULd4aGx=kGYYUz0BkFJz3abz97WOwDEgFHAOocT8SWT2oX-Q@mail.gmail.com>
 <CAEXW_YS89AXrbFXZpYeyh=5AxbQwhxDitniVcz=_tWFvnyuQyA@mail.gmail.com>
In-Reply-To: <CAEXW_YS89AXrbFXZpYeyh=5AxbQwhxDitniVcz=_tWFvnyuQyA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 1 Mar 2023 10:50:35 -0500
Message-ID: <CAEXW_YSHD98Ys7-LLmpxsrmSSbUj30LU1dg1y2vvv=vva-Ttdw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 10:49=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> On Wed, Mar 1, 2023 at 4:37=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wr=
ote:
> >
> > On Tue, Feb 28, 2023 at 10:43 PM Steven Rostedt <rostedt@goodmis.org> w=
rote:
> > >
> > > On Tue, 28 Feb 2023 18:59:29 +0100
> > > Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > > Use try_cmpxchg instead of cmpxchg (*ptr, old, new) =3D=3D old.
> > > > x86 CMPXCHG instruction returns success in ZF flag, so this change
> > > > saves a compare after cmpxchg (and related move instruction in
> > > > front of cmpxchg).
> > > >
> > > > Also, try_cmpxchg implicitly assigns old *ptr value to "old" when c=
mpxchg
> > > > fails. There is no need to re-read the value in the loop.
> > > >
> > > > No functional change intended.
> > >
> > > As I mentioned in the RCU thread, I have issues with some of the chan=
ges
> > > here.
> > >
> > > >
> > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > > ---
> > > >  kernel/trace/ring_buffer.c | 20 ++++++++------------
> > > >  1 file changed, 8 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.=
c
> > > > index 4188af7d4cfe..8f0ef7d12ddd 100644
> > > > --- a/kernel/trace/ring_buffer.c
> > > > +++ b/kernel/trace/ring_buffer.c
> > > > @@ -1493,14 +1493,11 @@ static bool rb_head_page_replace(struct buf=
fer_page *old,
> > > >  {
> > > >       unsigned long *ptr =3D (unsigned long *)&old->list.prev->next=
;
> > > >       unsigned long val;
> > > > -     unsigned long ret;
> > > >
> > > >       val =3D *ptr & ~RB_FLAG_MASK;
> > > >       val |=3D RB_PAGE_HEAD;
> > > >
> > > > -     ret =3D cmpxchg(ptr, val, (unsigned long)&new->list);
> > > > -
> > > > -     return ret =3D=3D val;
> > > > +     return try_cmpxchg(ptr, &val, (unsigned long)&new->list);
> > >
> > > No, val should not be updated.
> >
> > Please see the definition of try_cmpxchg. The definition is written in
> > such a way that benefits loops as well as linear code and in the later
> > case depends on the compiler to eliminate assignment to val as a dead
> > assignment.
> >
> > The above change was done under the assumption that val is unused
> > after try_cmpxchg, and can be considered as a temporary
> > [Alternatively, the value could be copied to a local temporary and a
> > pointer to this local temporary could be passed to try_cmpxchg
> > instead. Compiler is smart enough to eliminate the assignment in any
> > case.]

Ah I need to be more careful how I type.

> If I understood Steve correctly, I think the "misleading" part is that
> you are passing a variable by address to try_cmpxchg() but not really
> modifying it (unlike in the loop patterns).

It does modify it, but I meant it does not use it.

> Perhaps it is more meaningful to have an API that looks like:
> bool cmpxchg_succeeded(TYPE ptr, TYPE old, TYPE new)
> Where old is not a pointer (unlike try_cmpxchg), and the API returns bool=
.
>
> Both cleaner to read and has the optimization you want, I believe.
>
> However, the other point is, this is useful only for slow paths, but

Useful only for fast paths...

> at least cmpxchg_succeeded() is more readable and less "misleading"
> than try_cmpxchg() IMO.
>

Proofreading emails properly from here on! Not after the fact!

 - Joel
