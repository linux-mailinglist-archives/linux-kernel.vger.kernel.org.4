Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF5866103B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 17:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjAGQbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 11:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAGQbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 11:31:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7494410DB;
        Sat,  7 Jan 2023 08:31:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D8E7B81C25;
        Sat,  7 Jan 2023 16:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E37C433D2;
        Sat,  7 Jan 2023 16:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673109102;
        bh=8BQadlA5r0bj6mFF/oMVQ7+e1WLYb+LKAF7ZSrHkYTg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=i+TwWQv6vFW9A5pSK7okqAYgbqY4vRfxPwQi9FZDoT0vRYmItlycGi7J1LZUWxpX6
         BnvjtIrLvzheRBKII0ijiDgTTwJVrmSMELFq2MvFrgt6vLdCIXimC2MHmCtsbhZpV8
         G5VyQ+RqQ9SNJD1h3z25DpObAzUTnsd946un/Icdr9yztwYF2nN9qo2DT37xV3UTu7
         TjGTHzVgRef3ksGyKo+yBtQmSDMujRNCTqJwi9BLpIy52lHskzSdlIsavKhmiUpFPa
         y2xcNnl12XTvWRqmYf/c3O2mjQSQ8UPkMAkYfmr6z7SE0CfHIlLGzl8eUa1Nsh28r+
         TPDCZhLTyjo1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 768ED5C09F1; Sat,  7 Jan 2023 08:31:42 -0800 (PST)
Date:   Sat, 7 Jan 2023 08:31:42 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rcu: Rework tick dependency setting into
 rcu_exp_handler()
Message-ID: <20230107163142.GC4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105034000.971748-1-qiang1.zhang@intel.com>
 <20230105051146.GN4028633@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880A74D08B09F139D9AC19ADAFB9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Y7ikmpPbhy6wVxmy@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7ikmpPbhy6wVxmy@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 11:45:46PM +0100, Frederic Weisbecker wrote:
> On Fri, Jan 06, 2023 at 02:42:59AM +0000, Zhang, Qiang1 wrote:
> > On Thu, Jan 05, 2023 at 11:40:00AM +0800, Zqiang wrote:
> > > Currently, when first find out the expedited grace period is not end 
> > > and timeout occurred, we set tick dependency for CPUs that have not 
> > > yet reported the quiescent state in the rcu_node structure's->expmask 
> > > but need to eliminate races between set and clear tick dependency, 
> > > setting CPU tick dependency need to hold rcu_node structure's->lock.
> > > 
> > > This commit move tick dependency setting into rcu_exp_handler(), set 
> > > tick dependency when fail to report a quiescent state and clear tick 
> > > dependency in rcu_report_exp_rdp(). [from Frederic Weisbecker 
> > > suggestion]
> > > 
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > >
> > >First, a big "thank you" to you an Frederic for investigating this approach!
> > >
> > >So which is better, this patch or the one that I already have queued?
> > >
> > >The advantage of the patch of yours that I already have queued is that CPUs that respond in some other way within a millisecond do not get hit with an additional scheduling-clock interrupt.
> > >
> > >On the other hand, if the CPU goes through a quiescent state before the next scheduling-clock interrupt arrives, rcu_report_exp_cpu_mult() will shut down the tick before it happens.  Plus if the CPU waits a full tick before reaching a quiescent state, then the tick_dep_set_cpu() called from
> > >synchronize_rcu_expedited_wait() is going to send along an IPI anyway.
> > 
> > Agreed, this new patch is set tick dependency immediately when we can't report a quiescent state
> > in rcu_exp_handler(), this seems a little too aggressive.
> > 
> > 
> > >
> > >Except that invoking tick_dep_set_cpu() on the CPU itself will also do an IPI from tick_dep_set_cpu() because of IRQ_WORK_INIT_HARD(), right?
> > >Which means that the patch below gets us an extra self-IPI, right?
> > >Or am I misreading the code?
> > 
> > Yes, This looks like it will trigger an additional IPI interrupt.
> > 
> > >
> > >In addition, doesn't tick_dep_clear_cpu() just clear a bit?  Won't that mean that the next scheduling-clock interrupt will happen, just that the one after that won't?  (Give or take kernel-to-user or kernel-to-idle transitions that might happen in the meantime.)
> > 
> > Yes, tick_dep_clear_cpu() just only clear a bit. next scheduling-clock interrupt will happen.
> > 
> > So I also want to know which one is better 😊?
> 
> Right, I may have misled you with this change. I missed the fact that a chance
> is given for 1 jiffy to nohz_full CPUs to report a QS before the tick is forced
> there.
> 
> Sorry about that. Your first patch is still a good fix though!

And I have it queued, with Frederic's Reviewed-by.

And hey, if you don't miss a thing or two once in a while, you are not
reviewing sufficiently challenging code.  ;-)

So I repeat my earlier "thank you" to both of you for looking into this!

							Thanx, Paul
