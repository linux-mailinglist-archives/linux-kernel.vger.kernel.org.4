Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C5B6D78DB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbjDEJvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237771AbjDEJui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:50:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F3E6EB7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 02:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wXSYlaUXA5nBhRHj1ZP3FZadTBcoN+227rMjOru0hZA=; b=m0uJtO+HM2ocQF7Z7UywmajYTY
        vkQgMQ73PxuvX361gEhhuxJJYry0Yc3fBuZ6Nna8iu0lrwcga2AN2HoAoE/MqIJu9bAw6dbuGE3T0
        Qs/MU1+kHC40gbj1pWl0qbtQrv77Sk1vz5Xb67eTGqpSJA5nBr5GAudWQXLNVkeu6WSEwM0Mhscb5
        fzOKQwxGxRdhUXmCOSeiPilR8lVm9U3M1Mx9HvbM12bVVBGzLAeob5NUN23/ljdfwR8ryyW8hvc7i
        W6yF2qE8AIWOhVCfKRhNwNuE8SuLqKGX/0MuOZK9jgUis3ZIgjrcmPEdD/yf3etrTJhLz2xlyXRaC
        OyWdG6cw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjzjh-009rzn-0z;
        Wed, 05 Apr 2023 09:47:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2CD9330008D;
        Wed,  5 Apr 2023 11:47:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 082312750AC48; Wed,  5 Apr 2023 11:47:21 +0200 (CEST)
Date:   Wed, 5 Apr 2023 11:47:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de
Subject: Re: [PATCH 06/17] sched/fair: Add lag based placement
Message-ID: <20230405094720.GA4253@hirez.programming.kicks-ass.net>
References: <20230328092622.062917921@infradead.org>
 <20230328110353.988000317@infradead.org>
 <ZCqZzp98q806qfip@chenyu5-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCqZzp98q806qfip@chenyu5-mobl1>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 05:18:06PM +0800, Chen Yu wrote:
> On 2023-03-28 at 11:26:28 +0200, Peter Zijlstra wrote:
> >  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> [...]
> >  		/*
> > -		 * Halve their sleep time's effect, to allow
> > -		 * for a gentler effect of sleepers:
> > +		 * If we want to place a task and preserve lag, we have to
> > +		 * consider the effect of the new entity on the weighted
> > +		 * average and compensate for this, otherwise lag can quickly
> > +		 * evaporate:
> > +		 *
> > +		 * l_i = V - v_i <=> v_i = V - l_i
> > +		 *
> > +		 * V = v_avg = W*v_avg / W
> > +		 *
> > +		 * V' = (W*v_avg + w_i*v_i) / (W + w_i)
> If I understand correctly, V' means the avg_runtime if se_i is enqueued?
> Then,
> 
> V  = (\Sum w_j*v_j) / W

multiply by W on both sides to get:

  V*W = \Sum w_j*v_j

> V' = (\Sum w_j*v_j + w_i*v_i) / (W + w_i)
> 
> Not sure how W*v_avg equals to Sum w_j*v_j ?

 V := v_avg

(yeah, I should clean up this stuff, already said to Josh I would)

> > +		 *    = (W*v_avg + w_i(v_avg - l_i)) / (W + w_i)
> > +		 *    = v_avg + w_i*l_i/(W + w_i)
> v_avg - w_i*l_i/(W + w_i) ?

Yup -- seems typing is hard :-)

> > +		 *
> > +		 * l_i' = V' - v_i = v_avg + w_i*l_i/(W + w_i) - (v_avg - l)
> > +		 *      = l_i - w_i*l_i/(W + w_i)
> > +		 *
> > +		 * l_i = (W + w_i) * l_i' / W
> >  		 */
> [...]
> > -		if (sched_feat(GENTLE_FAIR_SLEEPERS))
> > -			thresh >>= 1;
> > +		load = cfs_rq->avg_load;
> > +		if (curr && curr->on_rq)
> > +			load += curr->load.weight;
> > +
> > +		lag *= load + se->load.weight;
> > +		if (WARN_ON_ONCE(!load))
> > +			load = 1;
> > +		lag = div_s64(lag, load);
> >  
> Should we calculate
> l_i' = l_i * w / (W + w_i) instead of calculating l_i above? I thought we want to adjust
> the lag(before enqueue) based on the new weight(after enqueued)

We want to ensure the lag after placement is the lag we got before
dequeue.

I've updated the comment to read like so:

		/*
		 * If we want to place a task and preserve lag, we have to
		 * consider the effect of the new entity on the weighted
		 * average and compensate for this, otherwise lag can quickly
		 * evaporate.
		 *
		 * Lag is defined as:
		 *
		 *   l_i = V - v_i <=> v_i = V - l_i
		 *
		 * And we take V to be the weighted average of all v:
		 *
		 *   V = (\Sum w_j*v_j) / W
		 *
		 * Where W is: \Sum w_j
		 *
		 * Then, the weighted average after adding an entity with lag
		 * l_i is given by:
		 *
		 *   V' = (\Sum w_j*v_j + w_i*v_i) / (W + w_i)
		 *      = (W*V + w_i*(V - l_i)) / (W + w_i)
		 *      = (W*V + w_i*V - w_i*l_i) / (W + w_i)
		 *      = (V*(W + w_i) - w_i*l) / (W + w_i)
		 *      = V - w_i*l_i / (W + w_i)
		 *
		 * And the actual lag after adding an entity with l_i is:
		 *
		 *   l'_i = V' - v_i
		 *        = V - w_i*l_i / (W + w_i) - (V - l_i)
		 *        = l_i - w_i*l_i / (W + w_i)
		 *
		 * Which is strictly less than l_i. So in order to preserve lag
		 * we should inflate the lag before placement such that the
		 * effective lag after placement comes out right.
		 *
		 * As such, invert the above relation for l'_i to get the l_i
		 * we need to use such that the lag after placement is the lag
		 * we computed before dequeue.
		 *
		 *   l'_i = l_i - w_i*l_i / (W + w_i)
		 *        = ((W + w_i)*l_i - w_i*l_i) / (W + w_i)
		 *
		 *   (W + w_i)*l'_i = (W + w_i)*l_i - w_i*l_i
		 *                  = W*l_i
		 *
		 *   l_i = (W + w_i)*l'_i / W
		 */
