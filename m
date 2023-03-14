Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C926B9163
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjCNLRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjCNLR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:17:26 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E673E1A7;
        Tue, 14 Mar 2023 04:16:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j11so19473414lfg.13;
        Tue, 14 Mar 2023 04:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678792615;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=paxnxYxbx4HrMv5BTgQUHEfCXgPIkhE/j+M9+u1vkJw=;
        b=OOiD6pW8WIkarCNqNodK/HHj7CtDz5vYQ/qwXwQpFdahkhdYd1gyhrl2PElp4a+uKY
         CT5G8YQvQkNj08P5vWxtnu1xWziMeI61oJ5+akMRrxFQhsE2nWeh/BMu0IKV/XyRuMU6
         KP20nqndDTxAUCqmh3PSoqgTfL9MSczEZ6XSVC9EF2qLnGmeGs/UQ+adyQUWftoC3VP0
         F58cgV2qPutsE85y+1a5OWAxRJ6bqS0Ztp3QtF0Fyssmcu+i9v5KM6owmSOlNeIP7mjN
         lj8SmqdgOXcTe16PJ93B/+xM4SRmeILa6qBF8VrrGssrbzWI5PjDZnlwMeiv8Qfpc5Tv
         2Fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678792615;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=paxnxYxbx4HrMv5BTgQUHEfCXgPIkhE/j+M9+u1vkJw=;
        b=KF60BBVYBcuFlRWpXD32VCJPQR87Q8xuHK0IO93HNxCHpqjMsUx05LKbZciGJpEtYk
         JbrsSke+Lqe41n7kIgX2PLqCOJ+iz0IlXThRXgsOChszDNl2G/SVloOyZJcMGViVXoDn
         jtB7sxle9TTq3/TkRdRrdK1ezq2dqXmKlXB52J1At2M6PaJfPN82QW9PfVmjnY0ezetS
         APMjw+KNc+LCUJ5qdjgob2Q0tx8oGAKfQTKb8HSryVTkAtHHIhUFgm44D8Xgl/Gc4Cr9
         edxz3t9sSZtQCMjq6qi0a0b/qwMexjQNXOJfq6gE+XmCpSU3AKbydDepRaloc3yiXBEi
         aXFg==
X-Gm-Message-State: AO0yUKVKsrLca1CKKegU6o7AYU8ll0XFsI0RnKpZu+uLzro4cq54Pomx
        7rOOjTDAt1iPxSkhhW033G43ynXahag=
X-Google-Smtp-Source: AK7set9+dVNAheONtnr9+/jTZ26WfHoeFOsv53hXj7Wbzeomt0X/hIbYw0rSMSbYNiiPbUZYqPF9wQ==
X-Received: by 2002:ac2:4a7c:0:b0:4cc:53e3:771d with SMTP id q28-20020ac24a7c000000b004cc53e3771dmr604248lfp.64.1678792614632;
        Tue, 14 Mar 2023 04:16:54 -0700 (PDT)
Received: from pc636 (host-78-79-233-41.mobileonline.telia.com. [78.79.233.41])
        by smtp.gmail.com with ESMTPSA id q11-20020a19a40b000000b00497a61453a9sm361981lfc.243.2023.03.14.04.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 04:16:54 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 14 Mar 2023 12:16:51 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <ZBBXo/z21UQYgQ+9@pc636>
References: <ZA7yK6iznHqiBu5i@pc636>
 <01559085-EB77-4962-B5EF-FF767F5A7353@joelfernandes.org>
 <ZA9B+sgrlK5yommJ@pc636>
 <CAEXW_YTgDM+47rfz0XNjeV8MMPnhyfCcXX+o74SqONvwd4wfzA@mail.gmail.com>
 <ZA9nd8LN4+qO5Sdn@pc636>
 <c7a7fac9-ae29-404d-98ec-e01e2c63968e@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7a7fac9-ae29-404d-98ec-e01e2c63968e@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 11:56:34AM -0700, Paul E. McKenney wrote:
> On Mon, Mar 13, 2023 at 07:12:07PM +0100, Uladzislau Rezki wrote:
> > On Mon, Mar 13, 2023 at 11:49:58AM -0400, Joel Fernandes wrote:
> > > On Mon, Mar 13, 2023 at 11:32 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > On Mon, Mar 13, 2023 at 06:58:30AM -0700, Joel Fernandes wrote:
> > > > >
> > > > >
> > > > > > On Mar 13, 2023, at 2:51 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > >
> > > > > > ﻿On Fri, Mar 10, 2023 at 10:24:34PM -0800, Paul E. McKenney wrote:
> > > > > >>> On Fri, Mar 10, 2023 at 09:55:02AM +0100, Uladzislau Rezki wrote:
> > > > > >>> On Thu, Mar 09, 2023 at 10:10:56PM +0000, Joel Fernandes wrote:
> > > > > >>>> On Thu, Mar 09, 2023 at 01:57:42PM +0100, Uladzislau Rezki wrote:
> > > > > >>>> [..]
> > > > > >>>>>>>>>> See this commit:
> > > > > >>>>>>>>>>
> > > > > >>>>>>>>>> 3705b88db0d7cc ("rcu: Add a module parameter to force use of
> > > > > >>>>>>>>>> expedited RCU primitives")
> > > > > >>>>>>>>>>
> > > > > >>>>>>>>>> Antti provided this commit precisely in order to allow Android
> > > > > >>>>>>>>>> devices to expedite the boot process and to shut off the
> > > > > >>>>>>>>>> expediting at a time of Android userspace's choosing.  So Android
> > > > > >>>>>>>>>> has been making this work for about ten years, which strikes me
> > > > > >>>>>>>>>> as an adequate proof of concept.  ;-)
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> Thanks for the pointer. That's true. Looking at Android sources, I
> > > > > >>>>>>>>> find that Android Mediatek devices at least are setting
> > > > > >>>>>>>>> rcu_expedited to 1 at late stage of their userspace boot (which is
> > > > > >>>>>>>>> weird, it should be set to 1 as early as possible), and
> > > > > >>>>>>>>> interestingly I cannot find them resetting it back to 0!.  Maybe
> > > > > >>>>>>>>> they set rcu_normal to 1? But I cannot find that either. Vlad? :P
> > > > > >>>>>>>>
> > > > > >>>>>>>> Interesting.  Though this is consistent with Antti's commit log,
> > > > > >>>>>>>> where he talks about expediting grace periods but not unexpediting
> > > > > >>>>>>>> them.
> > > > > >>>>>>>>
> > > > > >>>>>>> Do you think we need to unexpedite it? :))))
> > > > > >>>>>>
> > > > > >>>>>> Android runs on smallish systems, so quite possibly not!
> > > > > >>>>>>
> > > > > >>>>> We keep it enabled and never unexpedite it. The reason is a performance.  I
> > > > > >>>>> have done some app-launch time analysis with enabling and disabling of it.
> > > > > >>>>>
> > > > > >>>>> An expedited case is much better when it comes to app launch time. It
> > > > > >>>>> requires ~25% less time to run an app comparing with unexpedited variant.
> > > > > >>>>> So we have a big gain here.
> > > > > >>>>
> > > > > >>>> Wow, that's huge. I wonder if you can dig deeper and find out why that is so
> > > > > >>>> as the callbacks may need to be synchronize_rcu_expedited() then, as it could
> > > > > >>>> be slowing down other usecases! I find it hard to believe, real-time
> > > > > >>>> workloads will run better without those callbacks being always-expedited if
> > > > > >>>> it actually gives back 25% in performance!
> > > > > >>>>
> > > > > >>> I can dig further, but on a high level i think there are some spots
> > > > > >>> which show better performance if expedited is set. I mean synchronize_rcu()
> > > > > >>> becomes as "less blocking a context" from a time point of view.
> > > > > >>>
> > > > > >>> The problem of a regular synchronize_rcu() is - it can trigger a big latency
> > > > > >>> delays for a caller. For example for nocb case we do not know where in a list
> > > > > >>> our callback is located and when it is invoked to unblock a caller.
> > > > > >>
> > > > > >> True, expedited RCU grace periods do not have this callback-invocation
> > > > > >> delay that normal RCU does.
> > > > > >>
> > > > > >>> I have already mentioned somewhere. Probably it makes sense to directly wake-up
> > > > > >>> callers from the GP kthread instead and not via nocb-kthread that invokes our callbacks
> > > > > >>> one by one.
> > > > > >>
> > > > > >> Makes sense, but it is necessary to be careful.  Wakeups are not fast,
> > > > > >> so making the RCU grace-period kthread do them all sequentially is not
> > > > > >> a strategy to win.  For example, note that the next expedited grace
> > > > > >> period can start before the previous expedited grace period has finished
> > > > > >> its wakeups.
> > > > > >>
> > > > > > I hove done a small and quick prototype:
> > > > > >
> > > > > > <snip>
> > > > > > diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
> > > > > > index 699b938358bf..e1a4cca9a208 100644
> > > > > > --- a/include/linux/rcupdate_wait.h
> > > > > > +++ b/include/linux/rcupdate_wait.h
> > > > > > @@ -9,6 +9,8 @@
> > > > > > #include <linux/rcupdate.h>
> > > > > > #include <linux/completion.h>
> > > > > >
> > > > > > +extern struct llist_head gp_wait_llist;
> > > > > > +
> > > > > > /*
> > > > > >  * Structure allowing asynchronous waiting on RCU.
> > > > > >  */
> > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > index ee27a03d7576..50b81ca54104 100644
> > > > > > --- a/kernel/rcu/tree.c
> > > > > > +++ b/kernel/rcu/tree.c
> > > > > > @@ -113,6 +113,9 @@ int rcu_num_lvls __read_mostly = RCU_NUM_LVLS;
> > > > > > int num_rcu_lvl[] = NUM_RCU_LVL_INIT;
> > > > > > int rcu_num_nodes __read_mostly = NUM_RCU_NODES; /* Total # rcu_nodes in use. */
> > > > > >
> > > > > > +/* Waiters for a GP kthread. */
> > > > > > +LLIST_HEAD(gp_wait_llist);
> 
> This being a single global will of course fail due to memory contention
> on large systems.  So a patch that is ready for mainline must either
> have per-rcu_node-structure lists or similar.
> 
I agree. This is a prototype and the aim is a proof of concept :)
On bigger systems gp can starve if it wake-ups a lot of users.

At lease i see that a camera-app improves in terms of launch time.
It is around 12% percent.

> > > > > > /*
> > > > > >  * The rcu_scheduler_active variable is initialized to the value
> > > > > >  * RCU_SCHEDULER_INACTIVE and transitions RCU_SCHEDULER_INIT just before the
> > > > > > @@ -1776,6 +1779,14 @@ static noinline void rcu_gp_cleanup(void)
> > > > > >                on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
> > > > > > }
> > > > > >
> > > > > > +static void rcu_notify_gp_end(struct llist_node *llist)
> 
> And calling this directly from rcu_gp_kthread() is a no-go for large
> systems because the large number of wakeups will CPU-bound that kthread.
> Also, it would be better to invoke this from rcu_gp_cleanup().
> 
> One option would be to do the wakeups from a workqueue handler.
> 
> You might also want to have an array of lists indexed by the bottom few
> bits of the RCU grace-period sequence number.  This would reduce the
> number of spurious wakeups.
> 
> > > > > > +{
> > > > > > +       struct llist_node *rcu, *next;
> > > > > > +
> > > > > > +       llist_for_each_safe(rcu, next, llist)
> > > > > > +               complete(&((struct rcu_synchronize *) rcu)->completion);
> 
> If you don't eliminate spurious wakeups, it is necessary to do something
> like checking poll_state_synchronize_rcu() reject those wakeups.
> 
OK.

I will come up with some data and figures soon.

--
Uladzislau Rezki
