Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C258365374A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbiLUT6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLUT6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:58:05 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6465610B5D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:58:04 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m29so24873184lfo.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgZH7C3EFab6QPuF4xdSFFnQg7k8Lmf8P5JMzy2Da58=;
        b=GFx1gLnyRPHbQBstsEDO1/fKXIF7FOL+kOKrUraYK+FIwpHEfO7/TGz2OnFhTK++NL
         s8Pu52L9DkHVRHGRZz3N3E50jXA7bqQtzx5N8PMh2r7+uQJNuIEn1XfkqF5FCFUj6nyF
         8UqZNvCr4zNvVbEJH7+2nK3yhqLjv8aXi1RDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgZH7C3EFab6QPuF4xdSFFnQg7k8Lmf8P5JMzy2Da58=;
        b=Ja9MxFFRZtngirpx7q7/NEQlYjXMDyw5LnseOfgl0cNsuWn1NTAFUkcwYGEDk3Z7zb
         6sVtfd8CwtJgK0Xsjefx0vSKUzjQk6H9XDSdiBeMZLhId1BPMKRizAXbWcAuKJY1WR/y
         zuN3x8a005c4NJEFV6kJyxqF1OVL9WSv/+MLWmyDa/MZE/w9OLeicdBo4CIYzqgO5cA7
         oIq7sZjk8IjMaR4bN18gYHPSzXyO1j7d/YvHXimpthzVuhsoumHiKAyJ4iVqOmyimqJr
         8y0pXcR27kO6JcrplzTtwKLPXDN9fACjvOBjSW0a9rLJ4ULey73fOhPphXxFsK47eXK6
         ZXgw==
X-Gm-Message-State: AFqh2koF3jTTJw4HORpVbKoXyW5JyY+hqTP9Qft/cYmsxoINPqwR1+B3
        zMjauZWGrfzNaCM8/XH3wUGk5UoOWkbBDyDPzT6clA==
X-Google-Smtp-Source: AMrXdXvYxZWKDva6YXYWhomjEbA7yIe/H87WoxNx4RfEl4AevsaFSB7B77wR9lz6f0ciup+5xqwHlz7SgL2TTpazITA=
X-Received: by 2002:ac2:5205:0:b0:4a4:782a:42ac with SMTP id
 a5-20020ac25205000000b004a4782a42acmr144698lfl.468.1671652682712; Wed, 21 Dec
 2022 11:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20221221004957.GA29021@lothringen> <0B1950D8-9319-4F25-B14B-4ED949A57BE0@joelfernandes.org>
 <20221221112629.GA29427@lothringen> <Y6MuFH2ZMY7mV06q@Boquns-Mac-mini.local>
 <20221221173005.GB37362@lothringen> <CAEXW_YRe=h0tuRyp=2N1mB9ytsiFLL6U4UX=Od5PN-=7FwuDsg@mail.gmail.com>
In-Reply-To: <CAEXW_YRe=h0tuRyp=2N1mB9ytsiFLL6U4UX=Od5PN-=7FwuDsg@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 21 Dec 2022 19:57:50 +0000
Message-ID: <CAEXW_YRkh69OBmFk8UoL=EALseJZy2rwbfgNwrPrv1cK0BvnOg@mail.gmail.com>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
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

Mathieu pointed out to me on IRC that adding the control dep on the
update side removes even that need for E. And I see that is what Boqun
was suggesting above and that Frederic modified.

See updated litmus here: https://www.irccloud.com/pastebin/TrXacogO/

With this, I am not seeing the "bad condition" happen.

On Wed, Dec 21, 2022 at 7:33 PM Joel Fernandes <joel@joelfernandes.org> wro=
te:
>
> Ah Frederic, I think you nailed it. E is required to order the flip
> write with the control-dependency on the READ side. I can confirm the
> below test with bad condition shows the previous reader sees the
> post-flip index when it shouldn't have. Please see below modifications
> to your Litmus test.
>
> I think we should document it in the code that E pairs with the
> control-dependency between idx read and lock count write.
>
> C srcu
> {}
> // updater
> P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> {
>         int lock1;
>         int unlock1;
>         int lock0;
>         int unlock0;
>
>         // SCAN1
>         unlock1 =3D READ_ONCE(*UNLOCK1);
>         smp_mb(); // A
>         lock1 =3D READ_ONCE(*LOCK1);
>
>         // FLIP
>         smp_mb(); // E -------------------- required to make the bad
> condition not happen.
>         WRITE_ONCE(*IDX, 1);
>         smp_mb(); // D
>
>         // SCAN2
>         unlock0 =3D READ_ONCE(*UNLOCK0);
>         smp_mb(); // A
>         lock0 =3D READ_ONCE(*LOCK0);
> }
>
> // reader
> P1(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> {
>         int tmp;
>         int idx1;
>         int idx2;
>
>         // 1st reader
>         idx1 =3D READ_ONCE(*IDX);
>         if (idx1 =3D=3D 0) {
>                 tmp =3D READ_ONCE(*LOCK0);
>                 WRITE_ONCE(*LOCK0, tmp + 1);
>                 smp_mb(); /* B and C */
>                 tmp =3D READ_ONCE(*UNLOCK0);
>                 WRITE_ONCE(*UNLOCK0, tmp + 1);
>         } else {
>                 tmp =3D READ_ONCE(*LOCK1);
>                 WRITE_ONCE(*LOCK1, tmp + 1);
>                 smp_mb(); /* B and C */
>                 tmp =3D READ_ONCE(*UNLOCK1);
>                 WRITE_ONCE(*UNLOCK1, tmp + 1);
>         }
>
>         // second reader
>         idx2 =3D READ_ONCE(*IDX);
>         if (idx2 =3D=3D 0) {
>                 tmp =3D READ_ONCE(*LOCK0);
>                 WRITE_ONCE(*LOCK0, tmp + 1);
>                 smp_mb(); /* B and C */
>                 tmp =3D READ_ONCE(*UNLOCK0);
>                 WRITE_ONCE(*UNLOCK0, tmp + 1);
>         } else {
>                 tmp =3D READ_ONCE(*LOCK1);
>                 WRITE_ONCE(*LOCK1, tmp + 1);
>                 smp_mb(); /* B and C */
>                 tmp =3D READ_ONCE(*UNLOCK1);
>                 WRITE_ONCE(*UNLOCK1, tmp + 1);
>         }
> }
>
> exists (0:lock1=3D1 /\ 1:idx1=3D1 /\ 1:idx2=3D1 )  (* bad condition: 1st
> reader saw flip *)
>
>
>
>
>
> On Wed, Dec 21, 2022 at 5:30 PM Frederic Weisbecker <frederic@kernel.org>=
 wrote:
> >
> > On Wed, Dec 21, 2022 at 08:02:28AM -0800, Boqun Feng wrote:
> > > On Wed, Dec 21, 2022 at 12:26:29PM +0100, Frederic Weisbecker wrote:
> > > > On Tue, Dec 20, 2022 at 09:41:17PM -0500, Joel Fernandes wrote:
> > > > >
> > > > >
> > > > > > On Dec 20, 2022, at 7:50 PM, Frederic Weisbecker <frederic@kern=
el.org> wrote:
> > > > > >
> > > > > > =EF=BB=BFOn Tue, Dec 20, 2022 at 07:15:00PM -0500, Joel Fernand=
es wrote:
> > > > > >> On Tue, Dec 20, 2022 at 5:45 PM Frederic Weisbecker <frederic@=
kernel.org> wrote:
> > > > > >> Agreed about (1).
> > > > > >>
> > > > > >>> _ In (2), E pairs with the address-dependency between idx and=
 lock_count.
> > > > > >>
> > > > > >> But that is not the only reason. If that was the only reason f=
or (2),
> > > > > >> then there is an smp_mb() just before the next-scan post-flip =
before
> > > > > >> the lock counts are read.
> > > > > >
> > > > > > The post-flip barrier makes sure the new idx is visible on the =
next READER's
> > > > > > turn, but it doesn't protect against the fact that "READ idx th=
en WRITE lock[idx]"
> > > > > > may appear unordered from the update side POV if there is no ba=
rrier between the
> > > > > > scan and the flip.
> > > > > >
> > > > > > If you remove the smp_mb() from the litmus test I sent, things =
explode.
> > > > >
> > > > > Sure I see what you are saying and it=E2=80=99s a valid point as =
well. However why do you need memory barrier D (labeled such in the kernel =
code) for that? You already have a memory barrier A before the lock count i=
s read. That will suffice for the ordering pairing with the addr dependency=
.
> > > > > In other words, if updater sees readers lock counts, then reader =
would be making those lock count updates on post-flip inactive index, not t=
he one being scanned as you wanted, and you will accomplish that just with =
the mem barrier A.
> > > > >
> > > > > So D fixes the above issue you are talking about (lock count upda=
te), however that is already fixed by the memory barrier A. But you still n=
eed D for the issue I mentioned (unlock counts vs flip).
> > > > >
> > > > > That=E2=80=99s just my opinion and let=E2=80=99s discuss more bec=
ause I cannot rule out that I
> > > > > am missing something with this complicated topic ;-)
> > > >
> > > > I must be missing something. I often do.
> > > >
> > > > Ok let's put that on litmus:
> > > >
> > > > ----
> > > > C srcu
> > > >
> > > > {}
> > > >
> > > > // updater
> > > > P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> > > > {
> > > >     int lock1;
> > > >     int unlock1;
> > > >     int lock0;
> > > >     int unlock0;
> > > >
> > > >     // SCAN1
> > > >     unlock1 =3D READ_ONCE(*UNLOCK1);
> > > >     smp_mb(); // A
> > > >     lock1 =3D READ_ONCE(*LOCK1);
> > > >
> > > >     // FLIP
> > > >     smp_mb(); // E
> > >
> > > In real code there is a control dependency between the READ_ONCE() ab=
ove
> > > and the WRITE_ONCE() before, i.e. only flip the idx when lock1 =3D=3D
> > > unlock1, maybe try with the P0 below? Untested due to not having herd=
 on
> > > this computer ;-)
> > >
> > > >     WRITE_ONCE(*IDX, 1);
> > > >     smp_mb(); // D
> > > >
> > > >     // SCAN2
> > > >     unlock0 =3D READ_ONCE(*UNLOCK0);
> > > >     smp_mb(); // A
> > > >     lock0 =3D READ_ONCE(*LOCK0);
> > > > }
> > > >
> > >       P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1=
)
> > >       {
> > >               int lock1;
> > >               int unlock1;
> > >               int lock0;
> > >               int unlock0;
> > >
> > >               // SCAN1
> > >               unlock1 =3D READ_ONCE(*UNLOCK1);
> > >               smp_mb(); // A
> > >               lock1 =3D READ_ONCE(*LOCK1);
> > >
> > >               // FLIP
> > >               if (unlock1 =3D=3D lock1) {
> > >                       smp_mb(); // E
> > >                       WRITE_ONCE(*IDX, 1);
> > >                       smp_mb(); // D
> > >
> > >                       // SCAN2
> > >                       unlock0 =3D READ_ONCE(*UNLOCK0);
> > >                       smp_mb(); // A
> > >                       lock0 =3D READ_ONCE(*LOCK0);
> > >               }
> > >       }
> >
> > That becomes the below (same effect).
> >
> > C D
> >
> > {}
> >
> > // updater
> > P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> > {
> >         int lock1;
> >         int unlock1;
> >         int lock0;
> >         int unlock0;
> >
> >         // SCAN1
> >         unlock1 =3D READ_ONCE(*UNLOCK1);
> >         smp_mb(); // A
> >         lock1 =3D READ_ONCE(*LOCK1);
> >
> >         if (unlock1 =3D=3D lock1) {
> >                 // FLIP
> >                 smp_mb(); // E
> >                 WRITE_ONCE(*IDX, 1);
> >                 smp_mb(); // D
> >
> >                 // SCAN 2
> >                 unlock0 =3D READ_ONCE(*UNLOCK0);
> >                 smp_mb(); // A
> >                 lock0 =3D READ_ONCE(*LOCK0);
> >         }
> > }
> >
> > // reader
> > P1(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> > {
> >         int tmp;
> >         int idx;
> >
> >         // 1st reader
> >         idx =3D READ_ONCE(*IDX);
> >         if (idx =3D=3D 0) {
> >                 tmp =3D READ_ONCE(*LOCK0);
> >                 WRITE_ONCE(*LOCK0, tmp + 1);
> >                 smp_mb(); /* B and C */
> >                 tmp =3D READ_ONCE(*UNLOCK0);
> >                 WRITE_ONCE(*UNLOCK0, tmp + 1);
> >         } else {
> >                 tmp =3D READ_ONCE(*LOCK1);
> >                 WRITE_ONCE(*LOCK1, tmp + 1);
> >                 smp_mb(); /* B and C */
> >                 tmp =3D READ_ONCE(*UNLOCK1);
> >                 WRITE_ONCE(*UNLOCK1, tmp + 1);
> >         }
> >
> >         // second reader
> >         idx =3D READ_ONCE(*IDX);
> >         if (idx =3D=3D 0) {
> >                 tmp =3D READ_ONCE(*LOCK0);
> >                 WRITE_ONCE(*LOCK0, tmp + 1);
> >                 smp_mb(); /* B and C */
> >                 tmp =3D READ_ONCE(*UNLOCK0);
> >                 WRITE_ONCE(*UNLOCK0, tmp + 1);
> >         } else {
> >                 tmp =3D READ_ONCE(*LOCK1);
> >                 WRITE_ONCE(*LOCK1, tmp + 1);
> >                 smp_mb(); /* B and C */
> >                 tmp =3D READ_ONCE(*UNLOCK1);
> >                 WRITE_ONCE(*UNLOCK1, tmp + 1);
> >         }
> >
> >         // third reader
> >         idx =3D READ_ONCE(*IDX);
> >         if (idx =3D=3D 0) {
> >                 tmp =3D READ_ONCE(*LOCK0);
> >                 WRITE_ONCE(*LOCK0, tmp + 1);
> >                 smp_mb(); /* B and C */
> >                 tmp =3D READ_ONCE(*UNLOCK0);
> >                 WRITE_ONCE(*UNLOCK0, tmp + 1);
> >         } else {
> >                 tmp =3D READ_ONCE(*LOCK1);
> >                 WRITE_ONCE(*LOCK1, tmp + 1);
> >                 smp_mb(); /* B and C */
> >                 tmp =3D READ_ONCE(*UNLOCK1);
> >                 WRITE_ONCE(*UNLOCK1, tmp + 1);
> >         }
> > }
> >
> > exists (0:unlock0=3D0 /\ 1:idx=3D0)
> >
