Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15592708328
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjERNsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjERNsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:48:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115E5E75
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=278tUrwM0ypNiOb8pgGS7TOvecJeprbi5y1J+57X7ug=; b=ZQiC5mwOK9iFCQYNYCs/K5vZVS
        zKL9z/6wIqg5DKcatooe/vWTvS4/eqdD7tHBHhCZRkggqsvLkm7bSVscr95ke5+nxi1Q9JGOAd5IC
        nNHkG5X0hoAikRoTugWtACi+jATSvJ3DsSp6qoYdTROT4KyEds9TmqMpnGd5m/2OhpXADXk3XgTat
        noy6L2fvRvnmxbmOYgX+HgpF/dV5vGUVRHDoKSxVCKlpYrKnHzjA/zwd5ruO2KRcDXswM357M35EA
        YfA68qw293k18QZlbenpx3SD9axi6Ebz7POVQGxuz9BRSxisPa/0SucYc8jOlcnc4IxxjBSMV7QYd
        JOLmrZRQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzdyu-00EplW-1C;
        Thu, 18 May 2023 13:47:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA85D30072F;
        Thu, 18 May 2023 15:47:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 772C0241C9363; Thu, 18 May 2023 15:47:46 +0200 (CEST)
Date:   Thu, 18 May 2023 15:47:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH RESEND] sched/nohz: Add HRTICK_BW for using cfs bandwidth
 with nohz_full
Message-ID: <20230518134746.GB2860939@hirez.programming.kicks-ass.net>
References: <20230518132038.3534728-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518132038.3534728-1-pauld@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 09:20:38AM -0400, Phil Auld wrote:
> CFS bandwidth limits and NOHZ full don't play well together.  Tasks
> can easily run well past their quotas before a remote tick does
> accounting.  This leads to long, multi-period stalls before such
> tasks can run again.  Use the hrtick mechanism to set a sched
> tick to fire at remaining_runtime in the future if we are on
> a nohz full cpu, if the task has quota and if we are likely to
> disable the tick (nr_running == 1).  This allows for bandwidth
> accounting before tasks go too far over quota.
> 
> A number of container workloads use a dynamic number of real
> nohz tasks but also have other work that is limited which ends
> up running on the "spare" nohz cpus.  This is an artifact of
> having to specify nohz_full cpus at boot. Adding this hrtick
> resolves the issue of long stalls on these tasks.
> 
> Add the sched_feat HRTICK_BW off by default to allow users to
> enable this only when needed.

OMG; so because NOHZ_FULL configuration sucks, we add hacks on?
