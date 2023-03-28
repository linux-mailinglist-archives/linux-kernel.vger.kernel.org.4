Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5482F6CB2FA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjC1BGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjC1BGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:06:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0821733;
        Mon, 27 Mar 2023 18:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 661F461566;
        Tue, 28 Mar 2023 01:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF156C433EF;
        Tue, 28 Mar 2023 01:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679965581;
        bh=GMDjFYzfoOpqjpPC5xr9N+gid/BIF4M7vG0OrqXiJD4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=inTA9YoOE6AGXdnKOx02p/lfio51jTO+DNwWcjgwYOL80tfRKobyclqCnEgDq13sV
         N7tbaaYSgKf0xqzh93JpuFin3nf+ioF+4H7z22qzl95D9cqwK4PT8xApWT0gtObJoX
         lsMHndYdWSezzwOLKTYsnhRfIV6PbLlXVULRI97KJnDZEmP9hBAGtDlh+yYIChFzq+
         5yaA8YB9g1gG8fVIploRkGyCbh/mdPAy6Jwmo7KYLSJglyXSsHgy5nZ7VSt0XOJDhM
         tno/PoGRkYqlclL/lpXF3W97MYsrbh6bwJ4PzB5N+JpCfg80JAP2wkW7pGwx2XFUc/
         iAL+IVx4Mx49A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 58E89154039B; Mon, 27 Mar 2023 18:06:21 -0700 (PDT)
Date:   Mon, 27 Mar 2023 18:06:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, RCU <rcu@vger.kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Message-ID: <ca153af5-bd66-4d48-afa5-ace3a13aec3c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230321102748.127923-1-urezki@gmail.com>
 <IA1PR11MB617169A10E6DDE3C1168605D89819@IA1PR11MB6171.namprd11.prod.outlook.com>
 <ZBnKKZsSpI8aAk9W@pc636>
 <PH0PR11MB58805561777B77DC69E87711DA8B9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB58805561777B77DC69E87711DA8B9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:21:23AM +0000, Zhang, Qiang1 wrote:
> > > From: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Sent: Tuesday, March 21, 2023 6:28 PM
> > > [...]
> > > Subject: [PATCH 1/1] Reduce synchronize_rcu() waiting time
> > > 
> > > A call to a synchronize_rcu() can be expensive from time point of view.
> > > Different workloads can be affected by this especially the ones which use this
> > > API in its time critical sections.
> > > 
> > 
> > This is interesting and meaningful research. ;-)
> > 
> > > For example in case of NOCB scenario the wakeme_after_rcu() callback
> > > invocation depends on where in a nocb-list it is located. Below is an example
> > > when it was the last out of ~3600 callbacks:
> >
> 
> 
> 
> Can it be implemented separately as follows?  it seems that the code is simpler
> (only personal opinion)  😊.
> 
> But I didn't test whether this reduce synchronize_rcu() waiting time
> 
> +static void rcu_poll_wait_gp(struct rcu_tasks *rtp)
> +{
> +       unsigned long gp_snap;
> +
> +       gp_snap = start_poll_synchronize_rcu();
> +       while (!poll_state_synchronize_rcu(gp_snap))
> +               schedule_timeout_idle(1);

I could be wrong, but my guess is that the guys working with
battery-powered devices are not going to be very happy with this loop.

All those wakeups by all tasks waiting for a grace period end up
consuming a surprisingly large amount of energy.

							Thanx, Paul

> +}
> +
> +void call_rcu_poll(struct rcu_head *rhp, rcu_callback_t func);
> +DEFINE_RCU_TASKS(rcu_poll, rcu_poll_wait_gp, call_rcu_poll,
> +                 "RCU Poll");
> +void call_rcu_poll(struct rcu_head *rhp, rcu_callback_t func)
> +{
> +       call_rcu_tasks_generic(rhp, func, &rcu_poll);
> +}
> +EXPORT_SYMBOL_GPL(call_rcu_poll);
> +
> +void synchronize_rcu_poll(void)
> +{
> +       synchronize_rcu_tasks_generic(&rcu_poll);
> +}
> +EXPORT_SYMBOL_GPL(synchronize_rcu_poll);
> +
> +static int __init rcu_spawn_poll_kthread(void)
> +{
> +       cblist_init_generic(&rcu_poll);
> +       rcu_poll.gp_sleep = HZ / 10;
> +       rcu_spawn_tasks_kthread_generic(&rcu_poll);
> +       return 0;
> +}
> 
> Thanks
> Zqiang
> 
> 
> > > 
> > > <snip>
> > >   <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt
> > > CBs=3613 bl=28
> > > ...
> > >   <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preempt
> > > rhp=00000000b2d6dee8 func=__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preempt
> > > rhp=00000000a446f607 func=__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preempt
> > > rhp=00000000a5cab03b func=__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preempt
> > > rhp=0000000013b7e5ee func=__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preempt
> > > rhp=000000000a8ca6f9 func=__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preempt
> > > rhp=000000008f162ca8 func=wakeme_after_rcu.cfi_jt
> > >   <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs-
> > > invoked=3612 idle=....
> > > <snip>
> > >
> > 
> > Did the results above tell us that CBs-invoked=3612 during the time 21950.145313 ~ 21950.152625?
> > 
> >Yes.
> >
> >
> > If possible, may I know the steps, commands, and related parameters to produce the results above?
> > Thank you!
> > 
> >Build the kernel with CONFIG_RCU_TRACE configuration. Update your "set_event"
> >file with appropriate traces:
> >
> ><snip>
> >XQ-DQ54:/sys/kernel/tracing # echo rcu:rcu_batch_start rcu:rcu_batch_end rcu:rcu_invoke_callback > set_event
> >
> >XQ-DQ54:/sys/kernel/tracing # cat set_event
> >rcu:rcu_batch_start
> >rcu:rcu_invoke_callback
> >rcu:rcu_batch_end
> >XQ-DQ54:/sys/kernel/tracing #
> ><snip>
> >
> >Collect traces as much as you want: XQ-DQ54:/sys/kernel/tracing # echo 1 > tracing_on; sleep 10; echo 0 > tracing_on
> >Next problem is how to parse it. Of course you will not be able to parse
> >megabytes of traces. For that purpose i use a special C trace parser.
> >If you need an example please let me know i can show here.
> >
> >--
> >Uladzislau Rezki
