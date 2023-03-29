Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C7F6CD3ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjC2IDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjC2IDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:03:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F97211C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R8t2KTz/hNrQOzSALKPZGlNYWPIIKIOL0c78TVKqQD0=; b=PNCSAcUG34iFiZxsNjuhascS8p
        PD/N6HgQzvh2bFx0MJLV95iBzGtcwTi5qO31O+8LjRIMZwUcCWmG5MhDhSDo917FEl2pnPF0HT4Q2
        ctzGSgyLdg81SRQ/jiC3/IjQ18ylcZ0eHcSH5yTWgft4FfH/L+/g8alSiSEjegxlJUi/w92z/gmJr
        G3qJH2JFO2OSVDYnsETHTDmHVve+uoPAdkesUtZPoqHsghmr+nP8WYICJpgnvcdeW9vVwBG6EY/j2
        Mf4611nX3COrHX4N7NgsCVXWYVHtcfD5C75xAver8WYZrPdXcbvLVBL6rKghNYhckw2dlugw2pXwQ
        X8TqiVKw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phQlg-006nPo-2c;
        Wed, 29 Mar 2023 08:02:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9214F3000E6;
        Wed, 29 Mar 2023 10:02:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 74EB42CC7A024; Wed, 29 Mar 2023 10:02:51 +0200 (CEST)
Date:   Wed, 29 Mar 2023 10:02:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de
Subject: Re: [PATCH 08/17] sched/fair: Implement an EEVDF like policy
Message-ID: <20230329080251.GK4253@hirez.programming.kicks-ass.net>
References: <20230328092622.062917921@infradead.org>
 <20230328110354.141543852@infradead.org>
 <CABk29Nt4T67S+L9Qs1qeOUyo5gY1Qy5KuOwuCYNM74E58J81Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nt4T67S+L9Qs1qeOUyo5gY1Qy5KuOwuCYNM74E58J81Eg@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 06:26:51PM -0700, Josh Don wrote:
> Hi Peter,
> 
> This is a really interesting proposal and in general I think the
> incorporation of latency/deadline is quite a nice enhancement. We've
> struggled for a while to get better latency bounds on performance
> sensitive threads in the face of antagonism from overcommit.
> 
> >  void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >  {
> > +       s64 lag, limit;
> > +
> >         SCHED_WARN_ON(!se->on_rq);
> > -       se->vlag = avg_vruntime(cfs_rq) - se->vruntime;
> > +       lag = avg_vruntime(cfs_rq) - se->vruntime;
> > +
> > +       limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
> > +       se->vlag = clamp(lag, -limit, limit);
> 
> This is for dequeue; presumably you'd want to update the vlag at
> enqueue in case the average has moved again due to enqueue/dequeue of
> other entities?

Ha, just adding the entry back will shift the avgerage around and it's
all a giant pain in the backside.

 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
 	u64 vruntime = avg_vruntime(cfs_rq);
+	s64 lag = 0;
 
+	/*
+	 * Due to how V is constructed as the weighted average of entities,
+	 * adding tasks with positive lag, or removing tasks with negative lag
+	 * will move 'time' backwards, this can screw around with the lag of
+	 * other tasks.
+	 *
+	 * EEVDF: placement strategy #1 / #2
+	 */
+	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running > 1) {
+		struct sched_entity *curr = cfs_rq->curr;
+		unsigned long load;
 
+		lag = se->vlag;
 
 		/*
+		 * If we want to place a task and preserve lag, we have to
+		 * consider the effect of the new entity on the weighted
+		 * average and compensate for this, otherwise lag can quickly
+		 * evaporate:
+		 *
+		 * l_i = V - v_i <=> v_i = V - l_i
+		 *
+		 * V = v_avg = W*v_avg / W
+		 *
+		 * V' = (W*v_avg + w_i*v_i) / (W + w_i)
+		 *    = (W*v_avg + w_i(v_avg - l_i)) / (W + w_i)
+		 *    = v_avg + w_i*l_i/(W + w_i)
+		 *
+		 * l_i' = V' - v_i = v_avg + w_i*l_i/(W + w_i) - (v_avg - l)
+		 *      = l_i - w_i*l_i/(W + w_i)
+		 *
+		 * l_i = (W + w_i) * l_i' / W
 		 */
+		load = cfs_rq->avg_load;
+		if (curr && curr->on_rq)
+			load += curr->load.weight;
+
+		lag *= load + se->load.weight;
+		if (WARN_ON_ONCE(!load))
+			load = 1;
+		lag = div_s64(lag, load);
 
+		vruntime -= lag;
 	}


That ^ is the other side of it.

But yes, once enqueued, additional join/leave operations can/will shift
V around and lag changes, nothing much to do about that.

The paper does it all a wee bit differently, but I think it ends up
being the same. They explicitly track V (and shift it around on
join/leave) while I implicitly track it through the average and then
need to play games like the above, but in the end it should be the same.
