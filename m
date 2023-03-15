Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8436BBF9E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjCOWIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjCOWIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:08:41 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D916B97FE0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 15:08:31 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id e65so12397550ybh.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 15:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678918111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEPF+ci+lCAhZpQH0QsTGv5JkbkcgVCFUJGEmHRr3g8=;
        b=ZgomvdupMFElRj+TryfuiR9T4iOLUGnrL9gSnl3O0LHsh3mZvMR01+r+BFER0g8wD1
         Qv28oHDhefwHMLC6yVxu+Q3y6JYcuUbdqekUzEfzs+S6WGR5MPfaocscrv/a2Gqdtqrk
         bHgc8rEm8Cyz8RBd1dnYxUpf1ianlheoYz0GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678918111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEPF+ci+lCAhZpQH0QsTGv5JkbkcgVCFUJGEmHRr3g8=;
        b=fpmPuDMRm62o7yCJVUctVNhva4EYrfFVjxwp+FX0BUiY6tna1kj0LKYhb5w9J4palL
         kAftQ3V0rofRQyXtqaihZ7KKZR7oH3O5k1mLlbB0TWl/zR9AoYuVIn7b/EYva4eRzCKT
         CFRES092V63o2A9aZeg0qtYS6gwpPyjlWkTQ89OF5NyFePvKejWgSS+0VVkSmz0wecoy
         wopuyWWRTXLXrLUyNghA6ZBzIiCJ7tQawUQb2ppv6tuEj7DUgathw0AEKQ+/0u1A53f1
         SVlh6TZilFnZjs9r6Gwu8jtTX6/jwX2wjNn+wgw5fV9FmVnJ1SUv/NqLBqmkpn1Dqvp+
         paeA==
X-Gm-Message-State: AO0yUKVQ2t98yM9esUFbTtAkw5ryCvKM4qJ8xZQrCD92Q4jJkoZfly24
        hxgT8m+uYKqJrUKzodWFf0D9Kb7mELtzbU1mFWulvA==
X-Google-Smtp-Source: AK7set8YXgoMLXmf+AnFd/ws728cQrwINSIjjLxjL6rqrLkj1ny+y5AIRWoXmRC3W4uhwXi0bGdHrxBRs+UPGfzoBcY=
X-Received: by 2002:a5b:347:0:b0:a06:538f:24b2 with SMTP id
 q7-20020a5b0347000000b00a06538f24b2mr21358576ybp.2.1678918110834; Wed, 15 Mar
 2023 15:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230201150815.409582-1-urezki@gmail.com> <20230315151415.2534e11c@gandalf.local.home>
 <e5a1815b-65b5-55ca-9773-ec04378d53c0@kernel.dk> <ZBIbloFMm5xRsjfn@pc636>
 <20230315153448.6914f85b@gandalf.local.home> <CAEXW_YTLFQ3-LApyCPNNx7Tn2ovFr8YUXL=1WVCm+rE2hRKE8g@mail.gmail.com>
 <20230315162840.106a5b4f@gandalf.local.home>
In-Reply-To: <20230315162840.106a5b4f@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 15 Mar 2023 18:08:19 -0400
Message-ID: <CAEXW_YTNNJJftsg1QRvhUCRoZpKa3SM6=-0M-cukCGt5=G+row@mail.gmail.com>
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to k[v]free_rcu_mightsleep()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Steve,

On Wed, Mar 15, 2023 at 4:28=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 15 Mar 2023 15:57:02 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > > I was going to suggest "kvfree_rcu_might_synchronize()" but that's ju=
st
> > > getting ridiculous.
> >
> > No, synchronize() is incorrect. The code really can sleep for other
> > reasons like memory allocation. It is not that simple of an
> > implementation as one may imagine. mightsleep is really the correct
> > wording IMHO.
> >
> > > Still, I will replace that code back to a kfree() and rcu_synchonize(=
) than
> > > to let that other name get in.
> >
> > I think it is too late for that for now, we already have conversions
> > going into the other subsystems, that means we'll have to redo all
> > that over again (even if it sounded like a good idea, which it is
> > not).
> >
> > I would rather you just did: "#define kvfree_rcu_tracing
> > #kvfree_rcu_mightsleep", or something like that, if it is really a
> > problem. ;-)
> >
> > Also you are really the first person I know of who has a problem with t=
hat name.
>
> I guess you didn't read Jens's reply.

Apologies, I am trying to keep up with email but this week is crazy.

> The main issue I have with this, is that "might_sleep" is just an
> implementation issue. It has *nothing* to do with what the call is about.
> It is only about freeing something with RCU. It has nothing to do with
> sleeping. I don't use it because it might sleep. I use it to free somethi=
ng.
>
> If you don't like kvfree_rcu_synchronization() then call it
> kvfree_rcu_headless() and note that currently it can sleep. Because in
> the future, if we come up with an implementation where we it doesn't slee=
p,
> then we don't need to go and rename all the users in the future.
>
> See where I have the problem with the name "might_sleep"?

I am doubtful there may be a future where it does not sleep. Why?
Because you need an rcu_head *somewhere*. Unlike with debubojects,
which involves a lock-free per-CPU pool and a locked global pool, and
has the liberty to shutdown if it runs out of objects -- in RCU code
it doesn't have that liberty and it has to just keep working.  The
kfree_rcu code does have pools of rcu_head as well, but that is not
thought to be enough to prevent OOM when memory needs to be given
back.  AFAIK -- the synchronize_rcu() in there is a last resort and
undesirable (supposed to happen only when running out of
objects/memory).

Also "mightsleep" means just that -- *might*.  That covers the fact
that sleeping may not happen ;-).

This is just my opinion and I will defer to Uladzislau, Paul and you
on how to proceed. Another option is "cansleep" which has the same
number of characters as headless. I don't believe expecting users to
read comments is practical, since we did already have comments and
there was a bug in the usage that triggered this whole series.

thanks,

 - Joel
