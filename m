Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1AC6609A8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbjAFWp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjAFWpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:45:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D7E3C0FF;
        Fri,  6 Jan 2023 14:45:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FB79B81C39;
        Fri,  6 Jan 2023 22:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610A5C433D2;
        Fri,  6 Jan 2023 22:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673045149;
        bh=XiYZECjPbSbS5QC+pGrewcmGMdZ9/elc47NnAGKckCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUX5G8MMEWoC5w5EktAfc+XU7DoDZPgpk1Sy6bM/IHD6xYHCZZcgmm5XpoDt45mVA
         fz8w+dLGjlMlIx9laluMApPil3YBUGVXqK7P6e9ylHy0gW0H/jN7TTN4P/tBf0jJGR
         5p2g6bAQmvqmjBOQo6Wqo2s0D/fES8VCB3HJPEDSTU9rFuMag2BZMWQPZItAzjvYgM
         fIAsieS9N6nvpx5V5ivVFXg1RNI3S8JPiriQ8uinxtDW3NuYR/jZyASQuZ3X6+aCAe
         mcb0ceyJkPEjYU6ODCjzIpRIf4FR7B3jgIUrnlLO3xu5U5fdlN0syL6+h2BGoeV3bt
         GwIvezObrv92Q==
Date:   Fri, 6 Jan 2023 23:45:46 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rcu: Rework tick dependency setting into
 rcu_exp_handler()
Message-ID: <Y7ikmpPbhy6wVxmy@lothringen>
References: <20230105034000.971748-1-qiang1.zhang@intel.com>
 <20230105051146.GN4028633@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880A74D08B09F139D9AC19ADAFB9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB5880A74D08B09F139D9AC19ADAFB9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 02:42:59AM +0000, Zhang, Qiang1 wrote:
> On Thu, Jan 05, 2023 at 11:40:00AM +0800, Zqiang wrote:
> > Currently, when first find out the expedited grace period is not end 
> > and timeout occurred, we set tick dependency for CPUs that have not 
> > yet reported the quiescent state in the rcu_node structure's->expmask 
> > but need to eliminate races between set and clear tick dependency, 
> > setting CPU tick dependency need to hold rcu_node structure's->lock.
> > 
> > This commit move tick dependency setting into rcu_exp_handler(), set 
> > tick dependency when fail to report a quiescent state and clear tick 
> > dependency in rcu_report_exp_rdp(). [from Frederic Weisbecker 
> > suggestion]
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >
> >First, a big "thank you" to you an Frederic for investigating this approach!
> >
> >So which is better, this patch or the one that I already have queued?
> >
> >The advantage of the patch of yours that I already have queued is that CPUs that respond in some other way within a millisecond do not get hit with an additional scheduling-clock interrupt.
> >
> >On the other hand, if the CPU goes through a quiescent state before the next scheduling-clock interrupt arrives, rcu_report_exp_cpu_mult() will shut down the tick before it happens.  Plus if the CPU waits a full tick before reaching a quiescent state, then the tick_dep_set_cpu() called from
> >synchronize_rcu_expedited_wait() is going to send along an IPI anyway.
> 
> Agreed, this new patch is set tick dependency immediately when we can't report a quiescent state
> in rcu_exp_handler(), this seems a little too aggressive.
> 
> 
> >
> >Except that invoking tick_dep_set_cpu() on the CPU itself will also do an IPI from tick_dep_set_cpu() because of IRQ_WORK_INIT_HARD(), right?
> >Which means that the patch below gets us an extra self-IPI, right?
> >Or am I misreading the code?
> 
> Yes, This looks like it will trigger an additional IPI interrupt.
> 
> >
> >In addition, doesn't tick_dep_clear_cpu() just clear a bit?  Won't that mean that the next scheduling-clock interrupt will happen, just that the one after that won't?  (Give or take kernel-to-user or kernel-to-idle transitions that might happen in the meantime.)
> 
> Yes, tick_dep_clear_cpu() just only clear a bit. next scheduling-clock interrupt will happen.
> 
> So I also want to know which one is better 😊?

Right, I may have misled you with this change. I missed the fact that a chance
is given for 1 jiffy to nohz_full CPUs to report a QS before the tick is forced
there.

Sorry about that. Your first patch is still a good fix though!

Thanks!
