Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEA66529FE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 00:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiLTXq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 18:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiLTXqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 18:46:24 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C089B388F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 15:46:23 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f34so5807183lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 15:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtML0qwGaitUp0TiRy+O4yYYdbB8tFyIG4fs8NuVCa8=;
        b=YvSlxYAty7ptj+47fW722mslnmYbmOMcphE/kwVArTgkcoYN9XNKCGTWjElFJPT/Et
         AHJmRI/6bxx9qArXwUviHg0KBXnmdQziNra7RV4bCV0LfgZmmhELJHbb1YzTWFIUwHin
         8NEEy3MfYmAKKeNtERKqDBNLwPyT7iYPD1TvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtML0qwGaitUp0TiRy+O4yYYdbB8tFyIG4fs8NuVCa8=;
        b=KBSPqCqDuaG4X9gz4whZMUPPJ116hEWYP4gsGm2yDdsYfaymgxFRrcVQ6tBLBj2UuS
         kz+qYm9/O1zl+aKSDrJLtFuDG49P1BdnSsuPtZm9p7Pk8VITEC4Ea/Xe3bZkaSSDKQo8
         F387Jq6lSwGN5fFU0O6JZukY1s4Ck3aL8Gp/2iNdP2eXyePsjE9LnphlLXaUT2zmI8zM
         3PeKdt6/YCshKpRp+yJ6D910nK3bMkADC25Da9XMKpcitRpixuEdbgPXFnTrvnBj4ygv
         wr3K+Z03VcGTjGauPP4ir/qPapqK7wiD4S9ZtWSsH0hznsaB2+bMoRSmrI9hZhTmtRd1
         9DYw==
X-Gm-Message-State: ANoB5pm2IX/t1u25c3YRP3tqy2LrCxw+PZXxziBgQIYG5XtNj+z3By4v
        gPYJC+JewdHKBYTG+jIVFpE5ozDhYI0M/Z+G1kPZ7g==
X-Google-Smtp-Source: AA0mqf5y9AaRKqe9GoU5stkGyhjdrAgbiKjzJOpEdCei7zwLDtg0XuYSBv+cYQoULx58DH7465i25iN0t1N4VEW33+g=
X-Received: by 2002:ac2:4347:0:b0:4a4:782a:42ac with SMTP id
 o7-20020ac24347000000b004a4782a42acmr31901376lfl.468.1671579982033; Tue, 20
 Dec 2022 15:46:22 -0800 (PST)
MIME-Version: 1.0
References: <6438d903-ab97-48c7-c338-9f0bc2686f94@efficios.com>
 <7A9876BA-C375-42A7-A5C9-FD940D2898D7@joelfernandes.org> <5bd5ee4a-710a-96bc-abe8-772b2e60f478@efficios.com>
 <CAEXW_YRFbsCzT9iPdVfmeZ5qK+2fnVAwSzxbj1EXmU+vepOKdg@mail.gmail.com> <20221220230521.GC26563@lothringen>
In-Reply-To: <20221220230521.GC26563@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 20 Dec 2022 18:46:10 -0500
Message-ID: <CAEXW_YRw76oCBevJwFvwRRTyNGJZW2H0Zbg1WNX7D4R3bTvsHw@mail.gmail.com>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
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

On Tue, Dec 20, 2022 at 6:05 PM Frederic Weisbecker <frederic@kernel.org> w=
rote:
>
> On Tue, Dec 20, 2022 at 07:06:57PM +0000, Joel Fernandes wrote:
> > On Tue, Dec 20, 2022 at 7:01 PM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> > >
> > > On 2022-12-20 13:29, Joel Fernandes wrote:
> > > >
> > >
> > > > I do want to finish my memory barrier studies of SRCU over the holi=
days since I have been deep in the hole with that already. Back to the post=
 flip memory barrier here since I think now even that might not be needed=
=E2=80=A6
> > >
> > > I strongly suspect the memory barrier after flip is useless for the s=
ame
> > > reasons I mentioned explaining why the barrier before the flip is use=
less.
> > >
> > > However, we need to double-check that we have memory barriers at the
> > > beginning and end of synchronize_srcu, and between load of "unlock"
> > > counters and load of "lock" counters.
> > >
> > > Where is the barrier at the beginning of synchronize_srcu ?
> >
> > I believe we don't need another memory barrier at the beginning of
> > synchronize_srcu() (but this part of my SRCU study is still pending
> > ;)) . The grace period guarantee (read-side critical sections don't
> > span the GP) is already enforced by the memory barrier between
> > scanning for all unlocks, and scanning for all locks (Paired with
> > corresponding memory barriers on the read-side).
> >
> > Accordingly, before we scan all locks and match lock =3D=3D unlock, the=
re
> > is an smp_mb(). Why is that not sufficient?
>
> That's not enough, you still need a barrier between the updater's pre-GP
> accesses and the scans, so that post-GP read side sees the updater's pre-=
GP
> accesses:
>
>
>             UPDATER                        READER
>             -------                        ------
>             WRITE A                        WRITE srcu_read_lock
>             smp_mb() //rcu_seq_snap()      smp_mb()
>             READ srcu_read_lock //scans    READ A

But see the comments also in srcu_readers_active_idx_check()

* Needs to be a smp_mb() as the read side may
* contain a read from a variable that is written to before the
* synchronize_srcu() in the write side

So that appears to be already covered. Or is your point that the scans
are not happening on the same CPU as the pre-GP writer, as scans are
happening from workqueue ?

Perhaps that comment misled me.

Confused,

 - Joel
