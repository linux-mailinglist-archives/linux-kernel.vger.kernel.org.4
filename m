Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232C35F857E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 15:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJHNvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 09:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJHNvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 09:51:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9403ECEF;
        Sat,  8 Oct 2022 06:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AwbDRp9Us0UrL0zD8MoR0o+YWUfajcsfFiC3fOiNTTM=; b=pCwuzjOUz0tWxwqCc497YfpRKw
        GoU+CgGL0UXNHqWQDw6wxV0PNsWghQZbu5omagYEAcZ/vvldxR5NZUSI6TEjqBemhLaeOutUW0muR
        upAxaNbzc+pEB1jyucMju4l+KOYzTfwnVzWy6zxtPiJidGz2bfpN0yzxi58BLjp6HcqoVd9LJ8CEk
        DWGzmr1dA0EWVHWEM2omUSPz5OP5knxW5L8/8KHc46viRA1jcXx5MkpHiHy1nhYBlBRyEKWiHH6Kt
        hbgVd0cu75fExTLp8IM8XlyLX4EBh+4phzZiFPTrDzcG2Zw0rZ02+Xk8Lvjra1AsGRjQGkvZ15WOr
        BMbXS7PQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohAEj-002ijA-Nd; Sat, 08 Oct 2022 13:51:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 65D62300445;
        Sat,  8 Oct 2022 15:51:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3CD5C2BE948B4; Sat,  8 Oct 2022 15:51:24 +0200 (CEST)
Date:   Sat, 8 Oct 2022 15:51:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] perf: Fix missing SIGTRAPs
Message-ID: <Y0GAXJkwK5nXeFfG@hirez.programming.kicks-ass.net>
References: <20220927121322.1236730-1-elver@google.com>
 <Yz7ZLaT4jW3Y9EYS@hirez.programming.kicks-ass.net>
 <Yz7fWw8duIOezSW1@elver.google.com>
 <Yz78MMMJ74tBw0gu@hirez.programming.kicks-ass.net>
 <Yz/zXpF1yLshrJm/@elver.google.com>
 <Y0Ak/D05KhJeKaed@hirez.programming.kicks-ass.net>
 <Y0AwaxcJNOWhMKXP@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0AwaxcJNOWhMKXP@elver.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 03:58:03PM +0200, Marco Elver wrote:
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 9319af6013f1..7de83c42d312 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2285,9 +2285,10 @@ event_sched_out(struct perf_event *event,
>  			 */
>  			local_dec(&event->ctx->nr_pending);
>  		} else {
> -			WARN_ON_ONCE(event->pending_work);
> -			event->pending_work = 1;
> -			task_work_add(current, &event->pending_task, TWA_RESUME);
> +			if (!event->pending_work) {
> +				event->pending_work = 1;
> +				task_work_add(current, &event->pending_task, TWA_RESUME);
> +			}
			  else {
				local_dec(&event->ctx->nr_pending);
			}
>  		}
>  	}

That whole thing can be written much saner like:

	if (event->pending_sigtrap) {
		event->pending_sigtrap = 0;
		if (state != PERF_EVENT_STATE_OFF &&
		    !event->pending_work) {
			event->pending_work = 1;
			local_inc(&event->ctx->nr_pending);
			task_work_add(current, &event->pending_task, TWA_RESUME);
		}
		local_dec(&event->ctx->nr_pending);
	}

Except now we have two nr_pending ops -- I'm torn.
