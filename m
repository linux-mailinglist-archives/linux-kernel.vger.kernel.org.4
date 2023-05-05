Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB11B6F83E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjEENYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjEENYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:24:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D0C1F4A1
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 06:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uAM7n1wiZVSe7HQ0FgmpzakIsAC14G7Nrb0RDRnGptg=; b=JCsOWYqDRJr2k/EiRyEQjkaFeQ
        /YcGBjXxaiyU6jewqxA7wiGyrjXu//3XBw+aCq8hd/FZIphf5plRzi7e+z1FNdCLJLhX3KUfcjUvm
        wGkNUuf1yf1vv0W4KIolBtEdcsrsco+UBqyitBLQZ0tcOQ7Dc4gK9bhaRiXITU8E9aYVTzjR54iIS
        Xck+77ASbZYYU0Xc6OREjV5aLDjEzfnNtf7itgofdPYtDNoLB5CiBzdi6JsgUJ5DBxqU1nDLWj6C9
        NSq+sLGzWS8dxT2LIViD+YqrSa02AQwHasSdQVy7J2Jl/Ac9RPEXPVJbVmAv8IXQ3OderKTnz7cgP
        JHRx84Fw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1puvPY-00BVIO-Dc; Fri, 05 May 2023 13:23:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 34A8D302DAA;
        Fri,  5 May 2023 15:23:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2624921353002; Fri,  5 May 2023 15:23:47 +0200 (CEST)
Date:   Fri, 5 May 2023 15:23:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH 5/6] sched/fair: Consider the idle state of the whole
 core for load balance
Message-ID: <20230505132347.GR83892@hirez.programming.kicks-ass.net>
References: <cover.1683156492.git.tim.c.chen@linux.intel.com>
 <849d3fee51d218de71ecc9d557667ff6b137ac2d.1683156492.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <849d3fee51d218de71ecc9d557667ff6b137ac2d.1683156492.git.tim.c.chen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 09:09:55AM -0700, Tim Chen wrote:

> @@ -10709,11 +10709,26 @@ static int should_we_balance(struct lb_env *env)
>  	for_each_cpu_and(cpu, group_balance_mask(sg), env->cpus) {
>  		if (!idle_cpu(cpu))
>  			continue;
> +		else {
> +			/*
> +			 * Don't balance to idle SMT in busy core right away when
> +			 * balancing cores, but remember the first idle SMT CPU for
> +			 * later consideration.  Find CPU on an idle core first.
> +			 */
> +			if (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && !is_core_idle(cpu)) {
> +				if (idle_smt == -1)
> +					idle_smt = cpu;
> +				continue;
> +			}
> +		}

Not only does that bust CodingStyle, it's also entirely daft. What
exactly is the purpose of that else statement?

>  
>  		/* Are we the first idle CPU? */
>  		return cpu == env->dst_cpu;
>  	}
