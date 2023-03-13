Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258346B8022
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjCMSMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjCMSMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:12:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3155763CB;
        Mon, 13 Mar 2023 11:12:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i28so16887226lfv.0;
        Mon, 13 Mar 2023 11:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678731130;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OdSLYKJUtA9E/9SjNjQ3vieqKbkcB4VMy9EGsn81FmA=;
        b=K0jnPl/IyZgiJlspsVHAGnS/5Dpzjy+mVOArxl/DIebTzSzMi8yz2qrhTNiaqJBmW4
         UUwusbBtf5Roa/PG4eKjLLfFks1L736OKWnwyHlnqASN3n6YHdW1gQ6sx+EvzlGpC+ZZ
         u/RWiQIH62jzlalF2ADHS2c8iPUuczQ6VY8UJ74FEg1TT532QbbbuqeQbWQfsT8sx6FC
         C10QYTJ87yF++QjJp3JwBG3iyZco5XBnvDeHZSTewhLqp43NSOfwlOFyjaElozKw3zeS
         o/PO8YZ4AFVAcuLwdCAGiMJUp3L0htqB44XIvPIX6hiDwCltceNwR6kVSB48T1QVC3Vp
         VXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678731130;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OdSLYKJUtA9E/9SjNjQ3vieqKbkcB4VMy9EGsn81FmA=;
        b=CNCqW+dTAkVrMMRlUniHZZjuOculpEfJpbMTLZY7+QYSra5xNe1PbdFYo16xX7QOvo
         LcjBHZFfG/1lvRmDEz/oh12FSUhMztzqoUaRvNEviQnWRAEPPBoHjAQCyxYg4vxQxzkq
         10YpEOtaVrcgOUvITDZJ1Yfz6LRrkjrAZxFX1wTaRl3UG0jFkGLt/PwDnEOR3hXhDTyw
         yma/OZkEpuDW4966scRjbnSTSb2maCavbGOdSpOe/+mPiNXAE5gbkRqon6YaPCy/jZIo
         d1PWj/yy6BnOQVEMtk86dFFcFmF6KKZHnontBoz8c3UASBByhB/OUKnO91nOHs+QoyRd
         x6TQ==
X-Gm-Message-State: AO0yUKXR9R5E4dw/ur1g0V93nH6uWfbFHYYY2MQwxmNGqPRSS410tvHF
        meRW2B3JZUKR+X017n3dJY0=
X-Google-Smtp-Source: AK7set/XqDN+hrpMLKpXbwMTX5f+dRPWjcW7ch1ebUuwAZtpRYZR3FFxnQovew/TnqVWob4cNvScdQ==
X-Received: by 2002:ac2:54bb:0:b0:4b4:f9df:c6ab with SMTP id w27-20020ac254bb000000b004b4f9dfc6abmr8867089lfk.60.1678731129952;
        Mon, 13 Mar 2023 11:12:09 -0700 (PDT)
Received: from pc636 (host-78-79-233-41.mobileonline.telia.com. [78.79.233.41])
        by smtp.gmail.com with ESMTPSA id t10-20020a19ad0a000000b004e7a0f67490sm46062lfc.110.2023.03.13.11.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 11:12:09 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 13 Mar 2023 19:12:07 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <ZA9nd8LN4+qO5Sdn@pc636>
References: <ZA7yK6iznHqiBu5i@pc636>
 <01559085-EB77-4962-B5EF-FF767F5A7353@joelfernandes.org>
 <ZA9B+sgrlK5yommJ@pc636>
 <CAEXW_YTgDM+47rfz0XNjeV8MMPnhyfCcXX+o74SqONvwd4wfzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YTgDM+47rfz0XNjeV8MMPnhyfCcXX+o74SqONvwd4wfzA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 11:49:58AM -0400, Joel Fernandes wrote:
> On Mon, Mar 13, 2023 at 11:32 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Mon, Mar 13, 2023 at 06:58:30AM -0700, Joel Fernandes wrote:
> > >
> > >
> > > > On Mar 13, 2023, at 2:51 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > ﻿On Fri, Mar 10, 2023 at 10:24:34PM -0800, Paul E. McKenney wrote:
> > > >>> On Fri, Mar 10, 2023 at 09:55:02AM +0100, Uladzislau Rezki wrote:
> > > >>> On Thu, Mar 09, 2023 at 10:10:56PM +0000, Joel Fernandes wrote:
> > > >>>> On Thu, Mar 09, 2023 at 01:57:42PM +0100, Uladzislau Rezki wrote:
> > > >>>> [..]
> > > >>>>>>>>>> See this commit:
> > > >>>>>>>>>>
> > > >>>>>>>>>> 3705b88db0d7cc ("rcu: Add a module parameter to force use of
> > > >>>>>>>>>> expedited RCU primitives")
> > > >>>>>>>>>>
> > > >>>>>>>>>> Antti provided this commit precisely in order to allow Android
> > > >>>>>>>>>> devices to expedite the boot process and to shut off the
> > > >>>>>>>>>> expediting at a time of Android userspace's choosing.  So Android
> > > >>>>>>>>>> has been making this work for about ten years, which strikes me
> > > >>>>>>>>>> as an adequate proof of concept.  ;-)
> > > >>>>>>>>>
> > > >>>>>>>>> Thanks for the pointer. That's true. Looking at Android sources, I
> > > >>>>>>>>> find that Android Mediatek devices at least are setting
> > > >>>>>>>>> rcu_expedited to 1 at late stage of their userspace boot (which is
> > > >>>>>>>>> weird, it should be set to 1 as early as possible), and
> > > >>>>>>>>> interestingly I cannot find them resetting it back to 0!.  Maybe
> > > >>>>>>>>> they set rcu_normal to 1? But I cannot find that either. Vlad? :P
> > > >>>>>>>>
> > > >>>>>>>> Interesting.  Though this is consistent with Antti's commit log,
> > > >>>>>>>> where he talks about expediting grace periods but not unexpediting
> > > >>>>>>>> them.
> > > >>>>>>>>
> > > >>>>>>> Do you think we need to unexpedite it? :))))
> > > >>>>>>
> > > >>>>>> Android runs on smallish systems, so quite possibly not!
> > > >>>>>>
> > > >>>>> We keep it enabled and never unexpedite it. The reason is a performance.  I
> > > >>>>> have done some app-launch time analysis with enabling and disabling of it.
> > > >>>>>
> > > >>>>> An expedited case is much better when it comes to app launch time. It
> > > >>>>> requires ~25% less time to run an app comparing with unexpedited variant.
> > > >>>>> So we have a big gain here.
> > > >>>>
> > > >>>> Wow, that's huge. I wonder if you can dig deeper and find out why that is so
> > > >>>> as the callbacks may need to be synchronize_rcu_expedited() then, as it could
> > > >>>> be slowing down other usecases! I find it hard to believe, real-time
> > > >>>> workloads will run better without those callbacks being always-expedited if
> > > >>>> it actually gives back 25% in performance!
> > > >>>>
> > > >>> I can dig further, but on a high level i think there are some spots
> > > >>> which show better performance if expedited is set. I mean synchronize_rcu()
> > > >>> becomes as "less blocking a context" from a time point of view.
> > > >>>
> > > >>> The problem of a regular synchronize_rcu() is - it can trigger a big latency
> > > >>> delays for a caller. For example for nocb case we do not know where in a list
> > > >>> our callback is located and when it is invoked to unblock a caller.
> > > >>
> > > >> True, expedited RCU grace periods do not have this callback-invocation
> > > >> delay that normal RCU does.
> > > >>
> > > >>> I have already mentioned somewhere. Probably it makes sense to directly wake-up
> > > >>> callers from the GP kthread instead and not via nocb-kthread that invokes our callbacks
> > > >>> one by one.
> > > >>
> > > >> Makes sense, but it is necessary to be careful.  Wakeups are not fast,
> > > >> so making the RCU grace-period kthread do them all sequentially is not
> > > >> a strategy to win.  For example, note that the next expedited grace
> > > >> period can start before the previous expedited grace period has finished
> > > >> its wakeups.
> > > >>
> > > > I hove done a small and quick prototype:
> > > >
> > > > <snip>
> > > > diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
> > > > index 699b938358bf..e1a4cca9a208 100644
> > > > --- a/include/linux/rcupdate_wait.h
> > > > +++ b/include/linux/rcupdate_wait.h
> > > > @@ -9,6 +9,8 @@
> > > > #include <linux/rcupdate.h>
> > > > #include <linux/completion.h>
> > > >
> > > > +extern struct llist_head gp_wait_llist;
> > > > +
> > > > /*
> > > >  * Structure allowing asynchronous waiting on RCU.
> > > >  */
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index ee27a03d7576..50b81ca54104 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -113,6 +113,9 @@ int rcu_num_lvls __read_mostly = RCU_NUM_LVLS;
> > > > int num_rcu_lvl[] = NUM_RCU_LVL_INIT;
> > > > int rcu_num_nodes __read_mostly = NUM_RCU_NODES; /* Total # rcu_nodes in use. */
> > > >
> > > > +/* Waiters for a GP kthread. */
> > > > +LLIST_HEAD(gp_wait_llist);
> > > > +
> > > > /*
> > > >  * The rcu_scheduler_active variable is initialized to the value
> > > >  * RCU_SCHEDULER_INACTIVE and transitions RCU_SCHEDULER_INIT just before the
> > > > @@ -1776,6 +1779,14 @@ static noinline void rcu_gp_cleanup(void)
> > > >                on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
> > > > }
> > > >
> > > > +static void rcu_notify_gp_end(struct llist_node *llist)
> > > > +{
> > > > +       struct llist_node *rcu, *next;
> > > > +
> > > > +       llist_for_each_safe(rcu, next, llist)
> > > > +               complete(&((struct rcu_synchronize *) rcu)->completion);
> > >
> > > This looks broken to me, so the synchronize will complete even
> > > if it was called in the middle of an ongoing GP?
> > >
> > Do you mean before replacing the list(and after rcu_gp_cleanup()) a new
> > GP sequence can be initiated?
> 
> I guess I mean rcu_notify_gp_end() is called at the end of the current
> grace period, which might be the grace period which started _before_
> the synchronize_rcu() was called. So the callback needs to be invoked
> after the end of the next grace period, not the current one.
> 
> Did I miss some part of your patch that is handling this?
> 
No, you did not! That was my fault in placing llist_del_all() into
inappropriate place. We have to guarantee a full grace period. But
this is a prototype and kind of kick off :)

--
Uladzislau Rezki
