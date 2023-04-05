Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A006D7698
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbjDEIPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbjDEIPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:15:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EC0DF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KQiY2BSTqgmN+97qITG2MYayhrDwaEuFNxVLU8l4ftY=; b=YwHgF0dOXNDf/Zvb8KQ+KLe6Jj
        G7kemxYPf+LFnG8NepZohdGNzMPRGotzaBiSL0J1qTtxAPue6Stc8rPpVKiTVa3fODkl6bjEFTJgW
        zshTeymiz1oNvX1jnCUipTXuZqfyV4lNaiNeH2vkQDAXd36K/nzscTkzZ7tR0qSlS21glbMxqCYbs
        KNn3HfPaw9SVaozewM/GEP4DO5+etM2YQBkhRFFShKAz2hxiIEZb5YU0eKavycd3Z5FziTod2J/Dt
        ZisACwOlCaVREyBmjq//NrtnBSjn2zrO6QhZpKo5g6wOYw9S8F+YkA2PqbNWmgmcI0ilJ5PJgrQFC
        +6Y25Qkg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjyI6-00GBdn-Ld; Wed, 05 Apr 2023 08:14:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B0898300202;
        Wed,  5 Apr 2023 10:14:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8DC4026A69DAC; Wed,  5 Apr 2023 10:14:49 +0200 (CEST)
Date:   Wed, 5 Apr 2023 10:14:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Dai <davidai@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] sched/fair: Add util_guest for tasks
Message-ID: <20230405081449.GX4253@hirez.programming.kicks-ass.net>
References: <20230330224348.1006691-1-davidai@google.com>
 <20230330224348.1006691-2-davidai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330224348.1006691-2-davidai@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 03:43:36PM -0700, David Dai wrote:
> @@ -499,6 +509,7 @@ struct sched_avg {
>  	unsigned long			load_avg;
>  	unsigned long			runnable_avg;
>  	unsigned long			util_avg;
> +	unsigned long			util_guest;
>  	struct util_est			util_est;
>  } ____cacheline_aligned;
>  

Yeah, no... you'll have to make room first.

struct sched_avg {
	/* typedef u64 -> __u64 */ long long unsigned int     last_update_time;          /*     0     8 */
	/* typedef u64 -> __u64 */ long long unsigned int     load_sum;                  /*     8     8 */
	/* typedef u64 -> __u64 */ long long unsigned int     runnable_sum;              /*    16     8 */
	/* typedef u32 -> __u32 */ unsigned int               util_sum;                  /*    24     4 */
	/* typedef u32 -> __u32 */ unsigned int               period_contrib;            /*    28     4 */
	long unsigned int          load_avg;                                             /*    32     8 */
	long unsigned int          runnable_avg;                                         /*    40     8 */
	long unsigned int          util_avg;                                             /*    48     8 */
	struct util_est {
		unsigned int       enqueued;                                             /*    56     4 */
		unsigned int       ewma;                                                 /*    60     4 */
	} __attribute__((__aligned__(8)))util_est __attribute__((__aligned__(8))); /*    56     8 */

	/* size: 64, cachelines: 1, members: 9 */
	/* forced alignments: 1 */
} __attribute__((__aligned__(64)));


