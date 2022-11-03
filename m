Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681B1617CE7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiKCMpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiKCMpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:45:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3019910B64
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HCFDfBsw1t4TwyE4aixcJbLjNpdOwDL65IBVpDbxU3g=; b=AUs8DSN4y5XA/oMkE/BV/2vrrM
        54P/VtUuGexfYjYpjj2YU0v5KV1pR/ppY/FEU4HaiQRmUEp4IkdSLwz1x1tgqz8UTI3SclDr2XPMy
        RzicET/ENwm4lqkhGVSY8TL3hsTgWM+70YjE8GwASfMVV7VgsrDGcSAJTOKz+Te0EosqK5xSuY/BC
        sek3bF1tMx3IWXR6btzZuoy5OIBkFS5Y9zsXe4W/2CVJp9LRltAzyZpqAkT66caG/SXtfM/FYk7La
        cK+LTQz30qsU2F4PfI/b2RIadRcsz3bnRyFdt2Caf+bYz0iRNK3pCr+O7LR7f8vppFRyj95fdIk/m
        GyQZ3dHw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqZZv-008gM6-Cc; Thu, 03 Nov 2022 12:44:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC3F7300130;
        Thu,  3 Nov 2022 13:44:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4C42201001C7; Thu,  3 Nov 2022 13:44:12 +0100 (CET)
Date:   Thu, 3 Nov 2022 13:44:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] sched/fair: Introduce short duration task
 check
Message-ID: <Y2O3nDrvcy+KuGg1@hirez.programming.kicks-ass.net>
References: <cover.1666531576.git.yu.c.chen@intel.com>
 <6b81eea9a8cafb7634f36586f1744b8d4ac49da5.1666531576.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b81eea9a8cafb7634f36586f1744b8d4ac49da5.1666531576.git.yu.c.chen@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 11:32:31PM +0800, Chen Yu wrote:

> +	if (sched_feat(SIS_SHORT) && !prev->on_rq) {
> +		/*
> +		 * sum_exec_runtime has been updated in update_curr()
> +		 * because we reach here via dequeue.
> +		 */
> +		this_dur_avg = se->sum_exec_runtime - se->prev_sum_runtime_vol;
> +		/*
> +		 * Record the accumulated runtime when task voluntarily
> +		 * switches out. End of old duration period, a new period
> +		 * starts.
> +		 */
> +		se->prev_sum_runtime_vol = se->sum_exec_runtime;
> +
> +		last_dur_avg = se->dur_avg;
> +		delta = this_dur_avg - last_dur_avg;
> +		/* consider large change to avoid frequent update */
> +		if (abs(delta) >= sysctl_sched_min_granularity) {
> +			/*
> +			 * If it is the first time the task starts to
> +			 * record dur_avg, discard the initial value 0.
> +			 * Otherwise, calculate the EWMA.
> +			 */
> +			if (unlikely(!this_dur_avg))
> +				se->dur_avg = this_dur_avg;
> +			else
> +				update_avg(&se->dur_avg, this_dur_avg);
> +		}
> +	}

This seems excessively convoluted; what's wrong with something like:

	if (sched_feat(SIS_SHORT) && !prev->on_rq) {
		u64 this_dur = se->sum_exec_runtime - se->prev_sum_exec_runtime_vol;
		se->prev_sum_exec_runtime_vol = se->sum_exec_runtime;

		update_avg(&se->dur_avg, this_dur);
	}

All that other stuff just makes it unreadable and probably slower.
