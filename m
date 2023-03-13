Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2176B7C03
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCMPcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCMPcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:32:16 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ED57202B;
        Mon, 13 Mar 2023 08:32:14 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id by8so13030590ljb.7;
        Mon, 13 Mar 2023 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678721533;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3mDTuPUVBjuNvzrv7htFZs9fXsmGjXrR8ud01feVmOU=;
        b=VUT6lHfyhH9HAuRc+7yKUoXfsep0uyvAthBNK4/Hzty5zQwyJ+sLxkhNR7IysEiT66
         9YdojhPZccOIvZtcSsTMMb0YZC+yi0vPhGPZjzXrIs+dkzIk92dU+m0cK07pYSwvL/QZ
         i5Zwg6t8C4AdcXBLf2vQZQ5nhF1On5aNsxEhmkdQzMvyq12f0kNAc4TyT1rNuPF9pvLz
         KkWt3iZZGg7knddAOLYeQG9EkKm7YmMf6TYvhtuSGXUEICNJui1SC2SWf+eaiQd1Y1in
         Hut9YC2c0aEjh2BqXtjhtEp+IMft1/RfE14ystiiFQFNLidGmWP4PXUy4lvFsg0eM8r1
         rfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678721533;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3mDTuPUVBjuNvzrv7htFZs9fXsmGjXrR8ud01feVmOU=;
        b=AA6QMuphTwSlUs/Fhsaej5UGcp5qPnbHo/HAiIqBsrKYfeF95q1yLECE95HU3Gki6q
         /maMHnuAXdEz9r+4MM8rFGhJTPLRhctScI/8ujuhLeg+nXMYR2wpLvc5eDVDssVMDojb
         jfAyt5m1KeWtcGGlDRHaezq0g/6Yuum6/trkc8a7QSlcqJEKOMT6XY7zxlH30ual/HD3
         3P4WYZy7dxORkg8yySW3WVIJ5/Q+P2O3wOWcRK3lbryfGPKrz1wCR6oFn18rIskQTOJz
         ryVupFLkKTeyT/xdttg3ZlmMB12qSHRtFPqqA+71B5NpS6xqP0Qelw1ItPl5ZJl2x0+C
         +sMQ==
X-Gm-Message-State: AO0yUKVWfWB4rYopjKtd3UbhDa1Uy5GSG49XBYUAPI5AdOr/F7bSV1Cu
        sMjR2Z5jaUuzNoGHOyIqF7K8xRBBeXQ=
X-Google-Smtp-Source: AK7set9mOCfXSYb80vu4BAVpJP+sroY58lHpQNwteuLM0KefjtHOJYhfgldbVK7+WU8lKB+iuLZgbg==
X-Received: by 2002:a05:651c:84:b0:293:4b96:1b6b with SMTP id 4-20020a05651c008400b002934b961b6bmr10945710ljq.25.1678721533094;
        Mon, 13 Mar 2023 08:32:13 -0700 (PDT)
Received: from pc636 (host-78-79-233-41.mobileonline.telia.com. [78.79.233.41])
        by smtp.gmail.com with ESMTPSA id q7-20020a2e8747000000b002959f550084sm26947ljj.100.2023.03.13.08.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 08:32:12 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 13 Mar 2023 16:32:10 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <ZA9B+sgrlK5yommJ@pc636>
References: <ZA7yK6iznHqiBu5i@pc636>
 <01559085-EB77-4962-B5EF-FF767F5A7353@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01559085-EB77-4962-B5EF-FF767F5A7353@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 06:58:30AM -0700, Joel Fernandes wrote:
> 
> 
> > On Mar 13, 2023, at 2:51 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> > ﻿On Fri, Mar 10, 2023 at 10:24:34PM -0800, Paul E. McKenney wrote:
> >>> On Fri, Mar 10, 2023 at 09:55:02AM +0100, Uladzislau Rezki wrote:
> >>> On Thu, Mar 09, 2023 at 10:10:56PM +0000, Joel Fernandes wrote:
> >>>> On Thu, Mar 09, 2023 at 01:57:42PM +0100, Uladzislau Rezki wrote:
> >>>> [..]
> >>>>>>>>>> See this commit:
> >>>>>>>>>> 
> >>>>>>>>>> 3705b88db0d7cc ("rcu: Add a module parameter to force use of
> >>>>>>>>>> expedited RCU primitives")
> >>>>>>>>>> 
> >>>>>>>>>> Antti provided this commit precisely in order to allow Android
> >>>>>>>>>> devices to expedite the boot process and to shut off the
> >>>>>>>>>> expediting at a time of Android userspace's choosing.  So Android
> >>>>>>>>>> has been making this work for about ten years, which strikes me
> >>>>>>>>>> as an adequate proof of concept.  ;-)
> >>>>>>>>> 
> >>>>>>>>> Thanks for the pointer. That's true. Looking at Android sources, I
> >>>>>>>>> find that Android Mediatek devices at least are setting
> >>>>>>>>> rcu_expedited to 1 at late stage of their userspace boot (which is
> >>>>>>>>> weird, it should be set to 1 as early as possible), and
> >>>>>>>>> interestingly I cannot find them resetting it back to 0!.  Maybe
> >>>>>>>>> they set rcu_normal to 1? But I cannot find that either. Vlad? :P
> >>>>>>>> 
> >>>>>>>> Interesting.  Though this is consistent with Antti's commit log,
> >>>>>>>> where he talks about expediting grace periods but not unexpediting
> >>>>>>>> them.
> >>>>>>>> 
> >>>>>>> Do you think we need to unexpedite it? :))))
> >>>>>> 
> >>>>>> Android runs on smallish systems, so quite possibly not!
> >>>>>> 
> >>>>> We keep it enabled and never unexpedite it. The reason is a performance.  I
> >>>>> have done some app-launch time analysis with enabling and disabling of it.
> >>>>> 
> >>>>> An expedited case is much better when it comes to app launch time. It
> >>>>> requires ~25% less time to run an app comparing with unexpedited variant.
> >>>>> So we have a big gain here.
> >>>> 
> >>>> Wow, that's huge. I wonder if you can dig deeper and find out why that is so
> >>>> as the callbacks may need to be synchronize_rcu_expedited() then, as it could
> >>>> be slowing down other usecases! I find it hard to believe, real-time
> >>>> workloads will run better without those callbacks being always-expedited if
> >>>> it actually gives back 25% in performance!
> >>>> 
> >>> I can dig further, but on a high level i think there are some spots
> >>> which show better performance if expedited is set. I mean synchronize_rcu()
> >>> becomes as "less blocking a context" from a time point of view.
> >>> 
> >>> The problem of a regular synchronize_rcu() is - it can trigger a big latency
> >>> delays for a caller. For example for nocb case we do not know where in a list
> >>> our callback is located and when it is invoked to unblock a caller.
> >> 
> >> True, expedited RCU grace periods do not have this callback-invocation
> >> delay that normal RCU does.
> >> 
> >>> I have already mentioned somewhere. Probably it makes sense to directly wake-up
> >>> callers from the GP kthread instead and not via nocb-kthread that invokes our callbacks
> >>> one by one.
> >> 
> >> Makes sense, but it is necessary to be careful.  Wakeups are not fast,
> >> so making the RCU grace-period kthread do them all sequentially is not
> >> a strategy to win.  For example, note that the next expedited grace
> >> period can start before the previous expedited grace period has finished
> >> its wakeups.
> >> 
> > I hove done a small and quick prototype:
> > 
> > <snip>
> > diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
> > index 699b938358bf..e1a4cca9a208 100644
> > --- a/include/linux/rcupdate_wait.h
> > +++ b/include/linux/rcupdate_wait.h
> > @@ -9,6 +9,8 @@
> > #include <linux/rcupdate.h>
> > #include <linux/completion.h>
> > 
> > +extern struct llist_head gp_wait_llist;
> > +
> > /*
> >  * Structure allowing asynchronous waiting on RCU.
> >  */
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index ee27a03d7576..50b81ca54104 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -113,6 +113,9 @@ int rcu_num_lvls __read_mostly = RCU_NUM_LVLS;
> > int num_rcu_lvl[] = NUM_RCU_LVL_INIT;
> > int rcu_num_nodes __read_mostly = NUM_RCU_NODES; /* Total # rcu_nodes in use. */
> > 
> > +/* Waiters for a GP kthread. */
> > +LLIST_HEAD(gp_wait_llist);
> > +
> > /*
> >  * The rcu_scheduler_active variable is initialized to the value
> >  * RCU_SCHEDULER_INACTIVE and transitions RCU_SCHEDULER_INIT just before the
> > @@ -1776,6 +1779,14 @@ static noinline void rcu_gp_cleanup(void)
> >                on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
> > }
> > 
> > +static void rcu_notify_gp_end(struct llist_node *llist)
> > +{
> > +       struct llist_node *rcu, *next;
> > +
> > +       llist_for_each_safe(rcu, next, llist)
> > +               complete(&((struct rcu_synchronize *) rcu)->completion);
> 
> This looks broken to me, so the synchronize will complete even
> if it was called in the middle of an ongoing GP?
> 
Do you mean before replacing the list(and after rcu_gp_cleanup()) a new
GP sequence can be initiated?

--
Uladzislau Rezki
