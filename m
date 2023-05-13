Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D47B7015C8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbjEMJdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbjEMJdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:33:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234311BEF
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LuQPbOgFQBxB7HAFKEvsn8YgYKJGpy7A5vG4zyd1rPg=; b=gvzNKwCYbwhvmIiNecujLeLtV3
        UMuVlhAGuoo6stoKVLTwr2BmAJuPzfuX92YSJNC3aWvYw5vvZk3PNZI9IcMuKBbpW3F3bdLSEwQVV
        j67+AjKbmfqgylEK+qbBVmDHptHxjvkXhtgsD+dJwnBccXS7ILxdfC666Jszwj98c3t2hgIW4gEzH
        htYCvYfa7d7AQBfnKpAAAiiaOVQHUhuf6SgywYIwLbmcaX/+XVvU5Vm3aZ/+yTyhecgZcuP33LTjN
        gOIk2HMMvGeQ1qJimDtn6Wq9mOGDk+Q48xgWolJru5iT6L0VanDpMxcSzn38kCiQQolbZqmcykRw+
        hKPo3ihQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxlcB-00A78f-2L;
        Sat, 13 May 2023 09:32:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 57D3A300451;
        Sat, 13 May 2023 11:32:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1516E26AA4A55; Sat, 13 May 2023 11:32:34 +0200 (CEST)
Date:   Sat, 13 May 2023 11:32:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qyousef@layalina.io>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sched/fair, cpufreq: Introduce 'runnable boosting'
Message-ID: <20230513093234.GB4253@hirez.programming.kicks-ass.net>
References: <20230512101029.342823-1-dietmar.eggemann@arm.com>
 <20230512101029.342823-3-dietmar.eggemann@arm.com>
 <20230512112229.GW4253@hirez.programming.kicks-ass.net>
 <251b524a-2c44-3892-1bae-03f879d6a64b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <251b524a-2c44-3892-1bae-03f879d6a64b@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 04:39:51PM +0200, Dietmar Eggemann wrote:
> On 12/05/2023 13:22, Peter Zijlstra wrote:
> > On Fri, May 12, 2023 at 12:10:29PM +0200, Dietmar Eggemann wrote:
> > 
> >> -static unsigned long cpu_util(int cpu, struct task_struct *p, int dst_cpu)
> >> +static unsigned long
> >> +cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
> >>  {
> >>  	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
> >>  	unsigned long util = READ_ONCE(cfs_rq->avg.util_avg);
> >> +	unsigned long runnable;
> >> +
> >> +	runnable = boost ? READ_ONCE(cfs_rq->avg.runnable_avg) : 0;
> >> +	util = max(util, runnable);
> >>  
> > 	if (boost)
> > 		util = max(util, READ_ONCE(cfs_rq->avg.runnable_avg));
> 
> I need the util_est = max(util_est, runnable) further down as well. Just
> want to fetch runnable only once.

Ah, fair enought; but still, please use a regular if().
