Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17E26BA2AD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjCNWpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjCNWpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:45:11 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01A053723
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:44:55 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54184571389so184501407b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678833895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0s+v6LS+NWGEtMekhBGCmTrpxFB8JH+hOTMrHBsYtK4=;
        b=wylb5Cm9tGFHdcSyHqaVU4JVgHjfM8KOIxKAZBd2UxJY76hTl2eMMQixud0G7Dq8EO
         h1HfKUUqqmaP33OeH1fpEaybhv8EkcQlxzNlaP4MuSgwef44RLkrJurMtwd/xS1xFJfG
         tVaVaM3er5ESki6s0/mAH/nBDMkm18KFK2Hxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678833895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0s+v6LS+NWGEtMekhBGCmTrpxFB8JH+hOTMrHBsYtK4=;
        b=DYuuVHUuVl38/WxdzxdqorOpdpFz6DaKF2o6SMXFyDvr9wHXeO8CkBLFdgBHqHypSQ
         xSmwuSDHYBdKByUryd/mfJu+ugsKRR62Gfo12rVX59rfiv3eoYEeKGpYSrxLlrIGaojx
         ycCa9ureamUklP7uVUUKy+NcWDbgc5GSrO33Kq97RL/6eGT9BsVPyo4AXlx/7RrcB3ZD
         FrwZd81OVY4K+NPKn0t3B5CNJ3Np0DtunxCqr7ILdCCk6FMHJOF2izhV8xGWW8LQhhTA
         LPG9aWaiWgm+kFhpGZ1cD2q/B0qDR5Gj+iOjnJ2/dbZutIACRbTVGO4zWYBZ3uvVbmlu
         2WPQ==
X-Gm-Message-State: AO0yUKXPvArTuRcXO3HBF4qAHZSzDP7hIDtN9vfeNmQlk+f/6/4hLnJb
        sD9xLbyl9yMyqKjxWtnZU0isspE2Xzm2g+f89UrniQ==
X-Google-Smtp-Source: AK7set9LtcZDFc2p3zjc+4NxNeUeRxuXQiqiVNtY/S5MFikpUPdUCv6H0pTbKq+aRkNrK+6v+z+hk7RutqiDCpnJ6cA=
X-Received: by 2002:a81:af21:0:b0:541:693f:cdd1 with SMTP id
 n33-20020a81af21000000b00541693fcdd1mr8519425ywh.9.1678833894835; Tue, 14 Mar
 2023 15:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <ZA7yK6iznHqiBu5i@pc636> <01559085-EB77-4962-B5EF-FF767F5A7353@joelfernandes.org>
 <ZA9B+sgrlK5yommJ@pc636>
In-Reply-To: <ZA9B+sgrlK5yommJ@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 14 Mar 2023 18:44:44 -0400
Message-ID: <CAEXW_YQ=cr_KTCZ8+Gpx9XLz6K6_sdcz_9KBs+gZuhuc2UQuLg@mail.gmail.com>
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 11:32=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com=
> wrote:
>
> On Mon, Mar 13, 2023 at 06:58:30AM -0700, Joel Fernandes wrote:
> >
> >
> > > On Mar 13, 2023, at 2:51 AM, Uladzislau Rezki <urezki@gmail.com> wrot=
e:
> > >
> > > =EF=BB=BFOn Fri, Mar 10, 2023 at 10:24:34PM -0800, Paul E. McKenney w=
rote:
> > >>> On Fri, Mar 10, 2023 at 09:55:02AM +0100, Uladzislau Rezki wrote:
> > >>> On Thu, Mar 09, 2023 at 10:10:56PM +0000, Joel Fernandes wrote:
> > >>>> On Thu, Mar 09, 2023 at 01:57:42PM +0100, Uladzislau Rezki wrote:
> > >>>> [..]
> > >>>>>>>>>> See this commit:
> > >>>>>>>>>>
> > >>>>>>>>>> 3705b88db0d7cc ("rcu: Add a module parameter to force use of
> > >>>>>>>>>> expedited RCU primitives")
> > >>>>>>>>>>
> > >>>>>>>>>> Antti provided this commit precisely in order to allow Andro=
id
> > >>>>>>>>>> devices to expedite the boot process and to shut off the
> > >>>>>>>>>> expediting at a time of Android userspace's choosing.  So An=
droid
> > >>>>>>>>>> has been making this work for about ten years, which strikes=
 me
> > >>>>>>>>>> as an adequate proof of concept.  ;-)
> > >>>>>>>>>
> > >>>>>>>>> Thanks for the pointer. That's true. Looking at Android sourc=
es, I
> > >>>>>>>>> find that Android Mediatek devices at least are setting
> > >>>>>>>>> rcu_expedited to 1 at late stage of their userspace boot (whi=
ch is
> > >>>>>>>>> weird, it should be set to 1 as early as possible), and
> > >>>>>>>>> interestingly I cannot find them resetting it back to 0!.  Ma=
ybe
> > >>>>>>>>> they set rcu_normal to 1? But I cannot find that either. Vlad=
? :P
> > >>>>>>>>
> > >>>>>>>> Interesting.  Though this is consistent with Antti's commit lo=
g,
> > >>>>>>>> where he talks about expediting grace periods but not unexpedi=
ting
> > >>>>>>>> them.
> > >>>>>>>>
> > >>>>>>> Do you think we need to unexpedite it? :))))
> > >>>>>>
> > >>>>>> Android runs on smallish systems, so quite possibly not!
> > >>>>>>
> > >>>>> We keep it enabled and never unexpedite it. The reason is a perfo=
rmance.  I
> > >>>>> have done some app-launch time analysis with enabling and disabli=
ng of it.
> > >>>>>
> > >>>>> An expedited case is much better when it comes to app launch time=
. It
> > >>>>> requires ~25% less time to run an app comparing with unexpedited =
variant.
> > >>>>> So we have a big gain here.
> > >>>>
> > >>>> Wow, that's huge. I wonder if you can dig deeper and find out why =
that is so
> > >>>> as the callbacks may need to be synchronize_rcu_expedited() then, =
as it could
> > >>>> be slowing down other usecases! I find it hard to believe, real-ti=
me
> > >>>> workloads will run better without those callbacks being always-exp=
edited if
> > >>>> it actually gives back 25% in performance!
> > >>>>
> > >>> I can dig further, but on a high level i think there are some spots
> > >>> which show better performance if expedited is set. I mean synchroni=
ze_rcu()
> > >>> becomes as "less blocking a context" from a time point of view.
> > >>>
> > >>> The problem of a regular synchronize_rcu() is - it can trigger a bi=
g latency
> > >>> delays for a caller. For example for nocb case we do not know where=
 in a list
> > >>> our callback is located and when it is invoked to unblock a caller.
> > >>
> > >> True, expedited RCU grace periods do not have this callback-invocati=
on
> > >> delay that normal RCU does.
> > >>
> > >>> I have already mentioned somewhere. Probably it makes sense to dire=
ctly wake-up
> > >>> callers from the GP kthread instead and not via nocb-kthread that i=
nvokes our callbacks
> > >>> one by one.
> > >>
> > >> Makes sense, but it is necessary to be careful.  Wakeups are not fas=
t,
> > >> so making the RCU grace-period kthread do them all sequentially is n=
ot
> > >> a strategy to win.  For example, note that the next expedited grace
> > >> period can start before the previous expedited grace period has fini=
shed
> > >> its wakeups.
> > >>
> > > I hove done a small and quick prototype:
> > >
> > > <snip>
> > > diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_w=
ait.h
> > > index 699b938358bf..e1a4cca9a208 100644
> > > --- a/include/linux/rcupdate_wait.h
> > > +++ b/include/linux/rcupdate_wait.h
> > > @@ -9,6 +9,8 @@
> > > #include <linux/rcupdate.h>
> > > #include <linux/completion.h>
> > >
> > > +extern struct llist_head gp_wait_llist;
> > > +
> > > /*
> > >  * Structure allowing asynchronous waiting on RCU.
> > >  */
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index ee27a03d7576..50b81ca54104 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -113,6 +113,9 @@ int rcu_num_lvls __read_mostly =3D RCU_NUM_LVLS;
> > > int num_rcu_lvl[] =3D NUM_RCU_LVL_INIT;
> > > int rcu_num_nodes __read_mostly =3D NUM_RCU_NODES; /* Total # rcu_nod=
es in use. */
> > >
> > > +/* Waiters for a GP kthread. */
> > > +LLIST_HEAD(gp_wait_llist);
> > > +
> > > /*
> > >  * The rcu_scheduler_active variable is initialized to the value
> > >  * RCU_SCHEDULER_INACTIVE and transitions RCU_SCHEDULER_INIT just bef=
ore the
> > > @@ -1776,6 +1779,14 @@ static noinline void rcu_gp_cleanup(void)
> > >                on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
> > > }
> > >
> > > +static void rcu_notify_gp_end(struct llist_node *llist)
> > > +{
> > > +       struct llist_node *rcu, *next;
> > > +
> > > +       llist_for_each_safe(rcu, next, llist)
> > > +               complete(&((struct rcu_synchronize *) rcu)->completio=
n);
> >
> > This looks broken to me, so the synchronize will complete even
> > if it was called in the middle of an ongoing GP?
> >
> Do you mean before replacing the list(and after rcu_gp_cleanup()) a new
> GP sequence can be initiated?

It looks interesting, I am happy to try it on ChromeOS once you
provide a patch, in case it improves something, even if that is
suspend or boot time.

I think the main concern I had was if you did not wait for a full
grace period (which as you indicated, you would fix), you are not
really measuring the long delays that the full grace period can cause
so IMHO it is important to only measure once correctness is preserved
by the modification.  To that end, perhaps having rcutorture pass with
your modification could be a vote of confidence before proceeding to
performance tests.

 - Joel
