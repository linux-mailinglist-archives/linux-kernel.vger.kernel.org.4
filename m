Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642E065370F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiLUTd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbiLUTdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:33:24 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD88B15F35
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:33:23 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b3so25058231lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVp2NcubVkYcnUWhCqoYzp6ihe4lVahqimbpG9zg+F4=;
        b=lRSXNOU+8+kuu2jclxxc78LqOBk5vvSjTxEQFHOD8GJr/ItwF+Mn5NMg3pLTQ8rXpt
         JtQFyZULsj6iBXWqPLaml1ftQhzwBguEKINZUVYFOP0jjCMZnBDMBWr00umnjrWNhbkX
         VfqYyGTE3NKvUClko+mRsbjN93A3JhudwlMJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVp2NcubVkYcnUWhCqoYzp6ihe4lVahqimbpG9zg+F4=;
        b=yVNVzSoztXr+XFui5x3GS4tfi+t624JpHxLqZC2KsbirNdbPZqYIw5DkH8n/E6h7ce
         H9EE6yWWDPhXjC0TN4KW5xk+2LyRf+SShsp2/MdtwpRfMpzFfmGObHrvg7XhgQzLrvr1
         8x9IH9f7jvmoU1Rb8WbMW4yiIcsRuzCYR8O3WNc0aI/YtzurgcByoB7t6r98abt9Gzq5
         1AhUGR1cNe/vA5rgxXNy4wEVGqnC3BGNL6cWDzXUfFDfZtAuuHT5tXGU9ITfr+CSTxAC
         HaUnv0/jIGynW8sCtKC/ec7L7wDdjS1mUf3Zm72jONFXlHS6PZIW5Up9+2M7k6NhB/NP
         C3JQ==
X-Gm-Message-State: AFqh2kqHbwV7OhjoDpuT8QuaXmu0fIdKcYrjJRO4CrGbfQSdYKi8l/a8
        vt/Sr/EYTuDYknGgb4pr+t/lS9SrCXu6FrcN9Ir2Jw==
X-Google-Smtp-Source: AMrXdXvk61JrBCfhAE91c3Dgb7kDwkf7lfIJQu05woddN2+r7eQOjcJNflmKz4X6WixMRS3AfvzzT13qpS+6PgVr95E=
X-Received: by 2002:a19:4905:0:b0:4ba:caf8:a948 with SMTP id
 w5-20020a194905000000b004bacaf8a948mr172836lfa.169.1671651201988; Wed, 21 Dec
 2022 11:33:21 -0800 (PST)
MIME-Version: 1.0
References: <20221221004957.GA29021@lothringen> <0B1950D8-9319-4F25-B14B-4ED949A57BE0@joelfernandes.org>
 <20221221112629.GA29427@lothringen> <Y6MuFH2ZMY7mV06q@Boquns-Mac-mini.local> <20221221173005.GB37362@lothringen>
In-Reply-To: <20221221173005.GB37362@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 21 Dec 2022 19:33:10 +0000
Message-ID: <CAEXW_YRe=h0tuRyp=2N1mB9ytsiFLL6U4UX=Od5PN-=7FwuDsg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah Frederic, I think you nailed it. E is required to order the flip
write with the control-dependency on the READ side. I can confirm the
below test with bad condition shows the previous reader sees the
post-flip index when it shouldn't have. Please see below modifications
to your Litmus test.

I think we should document it in the code that E pairs with the
control-dependency between idx read and lock count write.

C srcu
{}
// updater
P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
{
        int lock1;
        int unlock1;
        int lock0;
        int unlock0;

        // SCAN1
        unlock1 =3D READ_ONCE(*UNLOCK1);
        smp_mb(); // A
        lock1 =3D READ_ONCE(*LOCK1);

        // FLIP
        smp_mb(); // E -------------------- required to make the bad
condition not happen.
        WRITE_ONCE(*IDX, 1);
        smp_mb(); // D

        // SCAN2
        unlock0 =3D READ_ONCE(*UNLOCK0);
        smp_mb(); // A
        lock0 =3D READ_ONCE(*LOCK0);
}

// reader
P1(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
{
        int tmp;
        int idx1;
        int idx2;

        // 1st reader
        idx1 =3D READ_ONCE(*IDX);
        if (idx1 =3D=3D 0) {
                tmp =3D READ_ONCE(*LOCK0);
                WRITE_ONCE(*LOCK0, tmp + 1);
                smp_mb(); /* B and C */
                tmp =3D READ_ONCE(*UNLOCK0);
                WRITE_ONCE(*UNLOCK0, tmp + 1);
        } else {
                tmp =3D READ_ONCE(*LOCK1);
                WRITE_ONCE(*LOCK1, tmp + 1);
                smp_mb(); /* B and C */
                tmp =3D READ_ONCE(*UNLOCK1);
                WRITE_ONCE(*UNLOCK1, tmp + 1);
        }

        // second reader
        idx2 =3D READ_ONCE(*IDX);
        if (idx2 =3D=3D 0) {
                tmp =3D READ_ONCE(*LOCK0);
                WRITE_ONCE(*LOCK0, tmp + 1);
                smp_mb(); /* B and C */
                tmp =3D READ_ONCE(*UNLOCK0);
                WRITE_ONCE(*UNLOCK0, tmp + 1);
        } else {
                tmp =3D READ_ONCE(*LOCK1);
                WRITE_ONCE(*LOCK1, tmp + 1);
                smp_mb(); /* B and C */
                tmp =3D READ_ONCE(*UNLOCK1);
                WRITE_ONCE(*UNLOCK1, tmp + 1);
        }
}

exists (0:lock1=3D1 /\ 1:idx1=3D1 /\ 1:idx2=3D1 )  (* bad condition: 1st
reader saw flip *)





On Wed, Dec 21, 2022 at 5:30 PM Frederic Weisbecker <frederic@kernel.org> w=
rote:
>
> On Wed, Dec 21, 2022 at 08:02:28AM -0800, Boqun Feng wrote:
> > On Wed, Dec 21, 2022 at 12:26:29PM +0100, Frederic Weisbecker wrote:
> > > On Tue, Dec 20, 2022 at 09:41:17PM -0500, Joel Fernandes wrote:
> > > >
> > > >
> > > > > On Dec 20, 2022, at 7:50 PM, Frederic Weisbecker <frederic@kernel=
.org> wrote:
> > > > >
> > > > > =EF=BB=BFOn Tue, Dec 20, 2022 at 07:15:00PM -0500, Joel Fernandes=
 wrote:
> > > > >> On Tue, Dec 20, 2022 at 5:45 PM Frederic Weisbecker <frederic@ke=
rnel.org> wrote:
> > > > >> Agreed about (1).
> > > > >>
> > > > >>> _ In (2), E pairs with the address-dependency between idx and l=
ock_count.
> > > > >>
> > > > >> But that is not the only reason. If that was the only reason for=
 (2),
> > > > >> then there is an smp_mb() just before the next-scan post-flip be=
fore
> > > > >> the lock counts are read.
> > > > >
> > > > > The post-flip barrier makes sure the new idx is visible on the ne=
xt READER's
> > > > > turn, but it doesn't protect against the fact that "READ idx then=
 WRITE lock[idx]"
> > > > > may appear unordered from the update side POV if there is no barr=
ier between the
> > > > > scan and the flip.
> > > > >
> > > > > If you remove the smp_mb() from the litmus test I sent, things ex=
plode.
> > > >
> > > > Sure I see what you are saying and it=E2=80=99s a valid point as we=
ll. However why do you need memory barrier D (labeled such in the kernel co=
de) for that? You already have a memory barrier A before the lock count is =
read. That will suffice for the ordering pairing with the addr dependency.
> > > > In other words, if updater sees readers lock counts, then reader wo=
uld be making those lock count updates on post-flip inactive index, not the=
 one being scanned as you wanted, and you will accomplish that just with th=
e mem barrier A.
> > > >
> > > > So D fixes the above issue you are talking about (lock count update=
), however that is already fixed by the memory barrier A. But you still nee=
d D for the issue I mentioned (unlock counts vs flip).
> > > >
> > > > That=E2=80=99s just my opinion and let=E2=80=99s discuss more becau=
se I cannot rule out that I
> > > > am missing something with this complicated topic ;-)
> > >
> > > I must be missing something. I often do.
> > >
> > > Ok let's put that on litmus:
> > >
> > > ----
> > > C srcu
> > >
> > > {}
> > >
> > > // updater
> > > P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> > > {
> > >     int lock1;
> > >     int unlock1;
> > >     int lock0;
> > >     int unlock0;
> > >
> > >     // SCAN1
> > >     unlock1 =3D READ_ONCE(*UNLOCK1);
> > >     smp_mb(); // A
> > >     lock1 =3D READ_ONCE(*LOCK1);
> > >
> > >     // FLIP
> > >     smp_mb(); // E
> >
> > In real code there is a control dependency between the READ_ONCE() abov=
e
> > and the WRITE_ONCE() before, i.e. only flip the idx when lock1 =3D=3D
> > unlock1, maybe try with the P0 below? Untested due to not having herd o=
n
> > this computer ;-)
> >
> > >     WRITE_ONCE(*IDX, 1);
> > >     smp_mb(); // D
> > >
> > >     // SCAN2
> > >     unlock0 =3D READ_ONCE(*UNLOCK0);
> > >     smp_mb(); // A
> > >     lock0 =3D READ_ONCE(*LOCK0);
> > > }
> > >
> >       P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> >       {
> >               int lock1;
> >               int unlock1;
> >               int lock0;
> >               int unlock0;
> >
> >               // SCAN1
> >               unlock1 =3D READ_ONCE(*UNLOCK1);
> >               smp_mb(); // A
> >               lock1 =3D READ_ONCE(*LOCK1);
> >
> >               // FLIP
> >               if (unlock1 =3D=3D lock1) {
> >                       smp_mb(); // E
> >                       WRITE_ONCE(*IDX, 1);
> >                       smp_mb(); // D
> >
> >                       // SCAN2
> >                       unlock0 =3D READ_ONCE(*UNLOCK0);
> >                       smp_mb(); // A
> >                       lock0 =3D READ_ONCE(*LOCK0);
> >               }
> >       }
>
> That becomes the below (same effect).
>
> C D
>
> {}
>
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
>         if (unlock1 =3D=3D lock1) {
>                 // FLIP
>                 smp_mb(); // E
>                 WRITE_ONCE(*IDX, 1);
>                 smp_mb(); // D
>
>                 // SCAN 2
>                 unlock0 =3D READ_ONCE(*UNLOCK0);
>                 smp_mb(); // A
>                 lock0 =3D READ_ONCE(*LOCK0);
>         }
> }
>
> // reader
> P1(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> {
>         int tmp;
>         int idx;
>
>         // 1st reader
>         idx =3D READ_ONCE(*IDX);
>         if (idx =3D=3D 0) {
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
>         idx =3D READ_ONCE(*IDX);
>         if (idx =3D=3D 0) {
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
>         // third reader
>         idx =3D READ_ONCE(*IDX);
>         if (idx =3D=3D 0) {
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
> exists (0:unlock0=3D0 /\ 1:idx=3D0)
>
