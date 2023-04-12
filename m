Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ADD6DF7D9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjDLN6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjDLN6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:58:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21B383F0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qYl5ekyLj7iQo8GlRLOVDEB8fB577eS6HixCK1lG4No=; b=orZuSzpUOPEWh+QSjssey7Xg2/
        p9j7M+8XFzvErQ6S1ZCL/QeuBlghz2x/b/Omg2ky4zfBLABZk69RLHLO8UUvslAHzXGD88ljeRMjR
        mZrMyz0N3QN0J6o5XNMOHYI3puAbM9f4FhasfVMiy/1xh+m3OQ7VE67ETaMNxEpRpHRppKocpChUW
        kuGGzlSqctuTiLjhQQrM2+PQ+NUySa93PkDMxzHyJyE8ePCzxBU/76ox5pWSZm5wpr3kbfxV29WSy
        gdCxBi/hmC2e2PzE5IBo/+53aYn4zeGCCGhUTSvNFQRxOPS5uojmR9zu+uBl5YmFudX2yuSIRH2+4
        uWmoldYg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmazV-00DwJs-1P;
        Wed, 12 Apr 2023 13:58:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5FC73300274;
        Wed, 12 Apr 2023 15:58:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B67F2095F655; Wed, 12 Apr 2023 15:58:28 +0200 (CEST)
Date:   Wed, 12 Apr 2023 15:58:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230412135828.GB629496@hirez.programming.kicks-ass.net>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <20230412115936.GC628377@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412115936.GC628377@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 01:59:36PM +0200, Peter Zijlstra wrote:
> On Mon, Mar 27, 2023 at 01:39:55PM +0800, Aaron Lu wrote:
> > When using sysbench to benchmark Postgres in a single docker instance
> > with sysbench's nr_threads set to nr_cpu, it is observed there are times
> > update_cfs_group() and update_load_avg() shows noticeable overhead on
> > cpus of one node of a 2sockets/112core/224cpu Intel Sapphire Rapids:
> > 
> >     10.01%     9.86%  [kernel.vmlinux]        [k] update_cfs_group
> >      7.84%     7.43%  [kernel.vmlinux]        [k] update_load_avg
> > 
> > While cpus of the other node normally sees a lower cycle percent:
> > 
> >      4.46%     4.36%  [kernel.vmlinux]        [k] update_cfs_group
> >      4.02%     3.40%  [kernel.vmlinux]        [k] update_load_avg
> > 
> > Annotate shows the cycles are mostly spent on accessing tg->load_avg
> > with update_load_avg() being the write side and update_cfs_group() being
> > the read side.
> > 
> > The reason why only cpus of one node has bigger overhead is: task_group
> > is allocated on demand from a slab and whichever cpu happens to do the
> > allocation, the allocated tg will be located on that node and accessing
> > to tg->load_avg will have a lower cost for cpus on the same node and
> > a higer cost for cpus of the remote node.
> > 
> > Tim Chen told me that PeterZ once mentioned a way to solve a similar
> > problem by making a counter per node so do the same for tg->load_avg.
> 
> Yeah, I send him a very similar patch (except horrible) some 5 years ago
> for testing.
> 
> > After this change, the worst number I saw during a 5 minutes run from
> > both nodes are:
> > 
> >      2.77%     2.11%  [kernel.vmlinux]        [k] update_load_avg
> >      2.72%     2.59%  [kernel.vmlinux]        [k] update_cfs_group
> 
> Nice!
> 
> > Another observation of this workload is: it has a lot of wakeup time
> > task migrations and that is the reason why update_load_avg() and
> > update_cfs_group() shows noticeable cost. Running this workload in N
> > instances setup where N >= 2 with sysbench's nr_threads set to 1/N nr_cpu,
> > task migrations on wake up time are greatly reduced and the overhead from
> > the two above mentioned functions also dropped a lot. It's not clear to
> > me why running in multiple instances can reduce task migrations on
> > wakeup path yet.
> 
> If there is *any* idle time, we're rather agressive at moving tasks to
> idle CPUs in an attempt to avoid said idle time. If you're running at
> about the number of CPUs there will be a fair amount of idle time and
> hence significant migrations.
> 
> When you overload, there will no longer be idle time and hence no more
> migrations.
> 
> > Reported-by: Nitin Tekchandani <nitin.tekchandani@intel.com>
> > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> 
> If you want to make things more complicated you can check
> num_possible_nodes()==1 on boot and then avoid the indirection, but

... finishing emails is hard :-)

I think I meant to say we should check if there's measurable overhead on
single-node systems before we go overboard or somesuch.


