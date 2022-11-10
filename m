Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584266242D0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiKJNFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiKJNFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:05:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444041A225
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VLuXSJpMZo2D9GhJlx0I8MAytanQxzyqkRXjeWV7LHA=; b=kwgX1pY4dyUUEbr85ef9jhDpqK
        S86xR0T8hPYf2U+cRDWd7UwcKPF+HKQ50KIGClc5vkPY/py5LQocIAu0H4LQ7xy5wxD3QfRq1xA3U
        cCJvLzxz8SBUTfoBS3+TGxbxQU7cEmNtC8RAxHwM2Fq2bPE0GbCFXpm9XuKhLB4PLoVTwAtFN5cyX
        CYrAs2N6imssbp5JmWPAY3x5Nm5b9rkcZfY07ps8+yT8XcVrSOZAVew9ok3qoQEutPJ8t/uIF6Cq2
        C3NG7vqejlgZ4IRYmnasbhp9S2a7mlY1+56BGCav73XbvjoSASLnk3rSh42lJoNKm3bDtm6U6oio4
        A7cESytw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ot7Ez-00C4yO-63; Thu, 10 Nov 2022 13:05:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 80A41300348;
        Thu, 10 Nov 2022 14:05:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3EDFC2B31AD65; Thu, 10 Nov 2022 14:05:02 +0100 (CET)
Date:   Thu, 10 Nov 2022 14:05:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Jian-Min Liu <jian-min.liu@mediatek.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Message-ID: <Y2z2/nhGfud7NIM8@hirez.programming.kicks-ass.net>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
 <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
 <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
 <d2789d23-816b-11f1-d654-a7989f323ac8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2789d23-816b-11f1-d654-a7989f323ac8@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 12:16:26PM +0100, Dietmar Eggemann wrote:
> On 07/11/2022 14:41, Peter Zijlstra wrote:
> > On Thu, Sep 29, 2022 at 03:41:47PM +0100, Kajetan Puchalski wrote:
> 
> [...]
> 
> > @@ -2956,13 +2958,26 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
> >   */
> >  static inline unsigned long cpu_util_cfs(int cpu)
> >  {
> > +	struct rq *rq = cpu_rq(cpu);
> >  	struct cfs_rq *cfs_rq;
> >  	unsigned long util;
> >  
> > -	cfs_rq = &cpu_rq(cpu)->cfs;
> > +	cfs_rq = &rq->cfs;
> >  	util = READ_ONCE(cfs_rq->avg.util_avg);
> >  
> >  	if (sched_feat(UTIL_EST)) {
> > +		if (sched_feat(UTIL_EST_FASTER)) {
> > +			struct task_struct *curr;
> > +
> > +			rcu_read_lock();
> > +			curr = rcu_dereference(rq->curr);
> > +			if (likely(curr->sched_class == &fair_sched_class)) {
> > +				u64 runtime = curr->se.sum_exec_runtime - curr->se.exec_start;
> 
> Don't we and up with gigantic runtime numbers here?
> 
> oot@juno:~# cat /proc/1676/task/1676/schedstat
> 36946300 1150620 11
> root@juno:~# cat /proc/1676/task/1676/sched
> rt-app (1676, #threads: 2)
> -------------------------------------------------------------------
> se.exec_start                                :         77766.964240 <- !
> se.vruntime                                  :           563.587883
> e.sum_exec_runtime                          :            36.946300  <- !
> se.nr_migrations                             :                    0
> ...
> 
> I expect cpu_util_cfs() to be ~1024 almost all the time now.

Duh, obviously I meant to measure the runtime of the current activation
and messed up.

We don't appear to have the right information to compute this atm :/

