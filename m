Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E636BBA57
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjCORAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjCORAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:00:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78FA23A47;
        Wed, 15 Mar 2023 09:59:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CE40B81E8A;
        Wed, 15 Mar 2023 16:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15B8C433D2;
        Wed, 15 Mar 2023 16:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678899596;
        bh=3o3gjoZHc5rg7rjmQ9L5hwd/d5TZOC5lj0aYZvfZexQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=K+nlAGubizxwp++a99hBHiEUuwD0zv9WFuHDwYE7pynQPysgr7hFL241uESLroUV8
         5dh4B76eczQ8Iy4cH6edPJkHd777iC42M1hUbnIPl1QL7c0TZXasHkIJtH2ApM+M+L
         TnoecicqcjpVqaDX0TPOyxjV59moNMnxvmi1Es0oxSf7oIBzrqANYb6Iu43yhqdAwJ
         hpZHPcPPQmKNQryKaJ4oh6QKJOoGv5LTN+MsaxKpq+oalBp06qC+s1IvZCzHW4fMsj
         D4wGvG89sQcYf+aWtkwHENyJDOdhuSdFM4f+QPmN2T8gltOxYgF7hO3Rpe0QVOUpvj
         aWCXJM15E755w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 727EF1540395; Wed, 15 Mar 2023 09:59:56 -0700 (PDT)
Date:   Wed, 15 Mar 2023 09:59:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s)
 after unloading rcuscale
Message-ID: <87b5fd9c-b34e-4105-8bbb-7902f17356cf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230313080403.89290-1-qiuxu.zhuo@intel.com>
 <d930f2a8-4b75-4109-a303-e2fc04443693@paulmck-laptop>
 <IA1PR11MB6171EA9F4437346FECB73F3189BF9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <CAEXW_YRatZhejsW-o1PXK3V8QxOcc-krvRdjwaDudFSfUotAKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YRatZhejsW-o1PXK3V8QxOcc-krvRdjwaDudFSfUotAKw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 10:12:05AM -0400, Joel Fernandes wrote:
> On Wed, Mar 15, 2023 at 10:07 AM Zhuo, Qiuxu <qiuxu.zhuo@intel.com> wrote:
> [...]
> > >
> > > I do applaud minmimizing the size of the patch, but in this case could you
> > > please pull the kfree_scale_cleanup() function ahead of its first use?
> > >
> >
> > I thought about it, but was also concerned that would make the patch bigger
> > while the effective changes were just only a few lines ...
> >
> > Pulling the kfree_scale_cleanup() function ahead of rcu_scale_cleanup() also needs
> > to pull another two kfree_* variables ahead used by kfree_scale_cleanup().
> > This looks like will mess up kfree_* and rcu_scale_* functions/variables in the source file.
> >
> > How about to pull the rcu_scale_cleanup() function after kfree_scale_cleanup().
> > This groups kfree_* functions and groups rcu_scale_* functions.
> > Then the code would look cleaner.
> > So, do you think the changes below are better?
> 
> IMHO, I don't think doing such a code move is better. Just add a new
> header file and declare the function there. But see what Paul says
> first.

This situation is likely to be an early hint that the kvfree_rcu() testing
should be split out from kernel/rcu/rcuscale.c.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> 
> >
> > ---
> >  kernel/rcu/rcuscale.c | 201 ++++++++++++++++++++++--------------------
> >  1 file changed, 103 insertions(+), 98 deletions(-)
> >
> > diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> > index 91fb5905a008..5a000d26f03e 100644
> > --- a/kernel/rcu/rcuscale.c
> > +++ b/kernel/rcu/rcuscale.c
> > @@ -522,89 +522,6 @@ rcu_scale_print_module_parms(struct rcu_scale_ops *cur_ops, const char *tag)
> >                  scale_type, tag, nrealreaders, nrealwriters, verbose, shutdown);
> >  }
> >
> > -static void
> > -rcu_scale_cleanup(void)
> > -{
> > -       int i;
> > -       int j;
> > -       int ngps = 0;
> > -       u64 *wdp;
> > -       u64 *wdpp;
> > -
> > -       /*
> > -        * Would like warning at start, but everything is expedited
> > -        * during the mid-boot phase, so have to wait till the end.
> > -        */
> > -       if (rcu_gp_is_expedited() && !rcu_gp_is_normal() && !gp_exp)
> > -               SCALEOUT_ERRSTRING("All grace periods expedited, no normal ones to measure!");
> > -       if (rcu_gp_is_normal() && gp_exp)
> > -               SCALEOUT_ERRSTRING("All grace periods normal, no expedited ones to measure!");
> > -       if (gp_exp && gp_async)
> > -               SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
> > -
> > -       if (torture_cleanup_begin())
> > -               return;
> > -       if (!cur_ops) {
> > -               torture_cleanup_end();
> > -               return;
> > -       }
> > -
> > -       if (reader_tasks) {
> > -               for (i = 0; i < nrealreaders; i++)
> > -                       torture_stop_kthread(rcu_scale_reader,
> > -                                            reader_tasks[i]);
> > -               kfree(reader_tasks);
> > -       }
> > -
> > -       if (writer_tasks) {
> > -               for (i = 0; i < nrealwriters; i++) {
> > -                       torture_stop_kthread(rcu_scale_writer,
> > -                                            writer_tasks[i]);
> > -                       if (!writer_n_durations)
> > -                               continue;
> > -                       j = writer_n_durations[i];
> > -                       pr_alert("%s%s writer %d gps: %d\n",
> > -                                scale_type, SCALE_FLAG, i, j);
> > -                       ngps += j;
> > -               }
> > -               pr_alert("%s%s start: %llu end: %llu duration: %llu gps: %d batches: %ld\n",
> > -                        scale_type, SCALE_FLAG,
> > -                        t_rcu_scale_writer_started, t_rcu_scale_writer_finished,
> > -                        t_rcu_scale_writer_finished -
> > -                        t_rcu_scale_writer_started,
> > -                        ngps,
> > -                        rcuscale_seq_diff(b_rcu_gp_test_finished,
> > -                                          b_rcu_gp_test_started));
> > -               for (i = 0; i < nrealwriters; i++) {
> > -                       if (!writer_durations)
> > -                               break;
> > -                       if (!writer_n_durations)
> > -                               continue;
> > -                       wdpp = writer_durations[i];
> > -                       if (!wdpp)
> > -                               continue;
> > -                       for (j = 0; j < writer_n_durations[i]; j++) {
> > -                               wdp = &wdpp[j];
> > -                               pr_alert("%s%s %4d writer-duration: %5d %llu\n",
> > -                                       scale_type, SCALE_FLAG,
> > -                                       i, j, *wdp);
> > -                               if (j % 100 == 0)
> > -                                       schedule_timeout_uninterruptible(1);
> > -                       }
> > -                       kfree(writer_durations[i]);
> > -               }
> > -               kfree(writer_tasks);
> > -               kfree(writer_durations);
> > -               kfree(writer_n_durations);
> > -       }
> > -
> > -       /* Do torture-type-specific cleanup operations.  */
> > -       if (cur_ops->cleanup != NULL)
> > -               cur_ops->cleanup();
> > -
> > -       torture_cleanup_end();
> > -}
> > -
> >  /*
> >   * Return the number if non-negative.  If -1, the number of CPUs.
> >   * If less than -1, that much less than the number of CPUs, but
> > @@ -624,21 +541,6 @@ static int compute_real(int n)
> >         return nr;
> >  }
> >
> > -/*
> > - * RCU scalability shutdown kthread.  Just waits to be awakened, then shuts
> > - * down system.
> > - */
> > -static int
> > -rcu_scale_shutdown(void *arg)
> > -{
> > -       wait_event(shutdown_wq,
> > -                  atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters);
> > -       smp_mb(); /* Wake before output. */
> > -       rcu_scale_cleanup();
> > -       kernel_power_off();
> > -       return -EINVAL;
> > -}
> > -
> >  /*
> >   * kfree_rcu() scalability tests: Start a kfree_rcu() loop on all CPUs for number
> >   * of iterations and measure total time and number of GP for all iterations to complete.
> > @@ -875,6 +777,109 @@ kfree_scale_init(void)
> >         return firsterr;
> >  }
> >
> > +static void
> > +rcu_scale_cleanup(void)
> > +{
> > +       int i;
> > +       int j;
> > +       int ngps = 0;
> > +       u64 *wdp;
> > +       u64 *wdpp;
> > +
> > +       /*
> > +        * Would like warning at start, but everything is expedited
> > +        * during the mid-boot phase, so have to wait till the end.
> > +        */
> > +       if (rcu_gp_is_expedited() && !rcu_gp_is_normal() && !gp_exp)
> > +               SCALEOUT_ERRSTRING("All grace periods expedited, no normal ones to measure!");
> > +       if (rcu_gp_is_normal() && gp_exp)
> > +               SCALEOUT_ERRSTRING("All grace periods normal, no expedited ones to measure!");
> > +       if (gp_exp && gp_async)
> > +               SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
> > +
> > +       if (kfree_rcu_test) {
> > +               kfree_scale_cleanup();
> > +               return;
> > +       }
> > +
> > +       if (torture_cleanup_begin())
> > +               return;
> > +       if (!cur_ops) {
> > +               torture_cleanup_end();
> > +               return;
> > +       }
> > +
> > +       if (reader_tasks) {
> > +               for (i = 0; i < nrealreaders; i++)
> > +                       torture_stop_kthread(rcu_scale_reader,
> > +                                            reader_tasks[i]);
> > +               kfree(reader_tasks);
> > +       }
> > +
> > +       if (writer_tasks) {
> > +               for (i = 0; i < nrealwriters; i++) {
> > +                       torture_stop_kthread(rcu_scale_writer,
> > +                                            writer_tasks[i]);
> > +                       if (!writer_n_durations)
> > +                               continue;
> > +                       j = writer_n_durations[i];
> > +                       pr_alert("%s%s writer %d gps: %d\n",
> > +                                scale_type, SCALE_FLAG, i, j);
> > +                       ngps += j;
> > +               }
> > +               pr_alert("%s%s start: %llu end: %llu duration: %llu gps: %d batches: %ld\n",
> > +                        scale_type, SCALE_FLAG,
> > +                        t_rcu_scale_writer_started, t_rcu_scale_writer_finished,
> > +                        t_rcu_scale_writer_finished -
> > +                        t_rcu_scale_writer_started,
> > +                        ngps,
> > +                        rcuscale_seq_diff(b_rcu_gp_test_finished,
> > +                                          b_rcu_gp_test_started));
> > +               for (i = 0; i < nrealwriters; i++) {
> > +                       if (!writer_durations)
> > +                               break;
> > +                       if (!writer_n_durations)
> > +                               continue;
> > +                       wdpp = writer_durations[i];
> > +                       if (!wdpp)
> > +                               continue;
> > +                       for (j = 0; j < writer_n_durations[i]; j++) {
> > +                               wdp = &wdpp[j];
> > +                               pr_alert("%s%s %4d writer-duration: %5d %llu\n",
> > +                                       scale_type, SCALE_FLAG,
> > +                                       i, j, *wdp);
> > +                               if (j % 100 == 0)
> > +                                       schedule_timeout_uninterruptible(1);
> > +                       }
> > +                       kfree(writer_durations[i]);
> > +               }
> > +               kfree(writer_tasks);
> > +               kfree(writer_durations);
> > +               kfree(writer_n_durations);
> > +       }
> > +
> > +       /* Do torture-type-specific cleanup operations.  */
> > +       if (cur_ops->cleanup != NULL)
> > +               cur_ops->cleanup();
> > +
> > +       torture_cleanup_end();
> > +}
> > +
> > +/*
> > + * RCU scalability shutdown kthread.  Just waits to be awakened, then shuts
> > + * down system.
> > + */
> > +static int
> > +rcu_scale_shutdown(void *arg)
> > +{
> > +       wait_event(shutdown_wq,
> > +                  atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters);
> > +       smp_mb(); /* Wake before output. */
> > +       rcu_scale_cleanup();
> > +       kernel_power_off();
> > +       return -EINVAL;
> > +}
> > +
> >  static int __init
> >  rcu_scale_init(void)
> >  {
> > --
> > 2.17.1
> >
> > > [...]
> >
