Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063406E46C0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjDQLq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjDQLq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:46:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063F49F;
        Mon, 17 Apr 2023 04:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=euqFyJ5D5EZ1z4Bo2J06MIkQP2iXlSqQQupLUBYhVqM=; b=aPcrZ46ynB7zUL/Qy+XlM2Op3u
        JHQ4DEQ8rAmR/vD5AMWPQM7dGv1tN77w9/9GHhWblSScKnVmb+tpfmrNkKrpVVkSqnodRrhAWk/RX
        RZ3CR4qxp1Yezm1tnqe+J9CoTlLbRebkW7yQcDhlNmrKzwRjsYdR6Bg/+RJ1JiaapcPu1pLivfOOB
        Crek56RUCUMvBMZRDqIJ4UqY9AuuPRsMxeuxeSJYd/pVCYxXeCf4q8+ybr1mMGaP1Oasifytp+B0j
        zmXKSZub0w8PIOzMSH5b50nZ0xswntJXSlIP15+pQNLQSoYLpa69pj03eH4NLdIWPXgVsbczP+wFe
        wKDIcyWw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1poNIK-00BIsx-4T; Mon, 17 Apr 2023 11:45:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D3586300338;
        Mon, 17 Apr 2023 13:45:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 782C024248737; Mon, 17 Apr 2023 13:45:12 +0200 (CEST)
Date:   Mon, 17 Apr 2023 13:45:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: Fix perf_sample_data not properly initialized
 for different swevents in perf_tp_event()
Message-ID: <20230417114512.GK83892@hirez.programming.kicks-ass.net>
References: <20230412095240.181516-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412095240.181516-1-yangjihong1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 09:52:40AM +0000, Yang Jihong wrote:
> data->sample_flags may be modified in perf_prepare_sample(),
> in perf_tp_event(), different swevents use the same on-stack
> perf_sample_data, the previous swevent may change sample_flags in
> perf_prepare_sample(), as a result, some members of perf_sample_data are
> not correctly initialized when next swevent_event preparing sample
> (for example data->id, the value varies according to swevent).
> 
> A simple scenario triggers this problem is as follows:
> 
>   # perf record -e sched:sched_switch --switch-output-event sched:sched_switch -a sleep 1
>   [ perf record: dump data: Woken up 0 times ]
>   [ perf record: Dump perf.data.2023041209014396 ]
>   [ perf record: dump data: Woken up 0 times ]
>   [ perf record: Dump perf.data.2023041209014662 ]
>   [ perf record: dump data: Woken up 0 times ]
>   [ perf record: Dump perf.data.2023041209014910 ]
>   [ perf record: Woken up 0 times to write data ]
>   [ perf record: Dump perf.data.2023041209015164 ]
>   [ perf record: Captured and wrote 0.069 MB perf.data.<timestamp> ]
>   # ls -l
>   total 860
>   -rw------- 1 root root  95694 Apr 12 09:01 perf.data.2023041209014396
>   -rw------- 1 root root 606430 Apr 12 09:01 perf.data.2023041209014662
>   -rw------- 1 root root  82246 Apr 12 09:01 perf.data.2023041209014910
>   -rw------- 1 root root  82342 Apr 12 09:01 perf.data.2023041209015164
>   # perf script -i perf.data.2023041209014396
>   0x11d58 [0x80]: failed to process type: 9 [Bad address]
> 
> Solution: Add perf_sample_data_flags_{save, restore} helpers to save and
> restore sample_flags when processing different swevents
> 
> After fix:
> 
>   # perf record -e sched:sched_switch --switch-output-event sched:sched_switch -a sleep 1
>   [ perf record: dump data: Woken up 0 times ]
>   [ perf record: Dump perf.data.2023041209442259 ]
>   [ perf record: dump data: Woken up 0 times ]
>   [ perf record: Dump perf.data.2023041209442514 ]
>   [ perf record: dump data: Woken up 0 times ]
>   [ perf record: Dump perf.data.2023041209442760 ]
>   [ perf record: Woken up 0 times to write data ]
>   [ perf record: Dump perf.data.2023041209443003 ]
>   [ perf record: Captured and wrote 0.069 MB perf.data.<timestamp> ]
>   # ls -l
>   total 864
>   -rw------- 1 root root 100166 Apr 12 09:44 perf.data.2023041209442259
>   -rw------- 1 root root 606438 Apr 12 09:44 perf.data.2023041209442514
>   -rw------- 1 root root  82246 Apr 12 09:44 perf.data.2023041209442760
>   -rw------- 1 root root  82342 Apr 12 09:44 perf.data.2023041209443003
>   # perf script -i perf.data.2023041209442259 | head -n 5
>               perf   232 [000]    66.846217: sched:sched_switch: prev_comm=perf prev_pid=232 prev_prio=120 prev_state=D ==> next_comm=perf next_pid=234 next_prio=120
>               perf   234 [000]    66.846449: sched:sched_switch: prev_comm=perf prev_pid=234 prev_prio=120 prev_state=S ==> next_comm=perf next_pid=232 next_prio=120
>               perf   232 [000]    66.846546: sched:sched_switch: prev_comm=perf prev_pid=232 prev_prio=120 prev_state=R ==> next_comm=perf next_pid=234 next_prio=120
>               perf   234 [000]    66.846606: sched:sched_switch: prev_comm=perf prev_pid=234 prev_prio=120 prev_state=S ==> next_comm=perf next_pid=232 next_prio=120
>               perf   232 [000]    66.846646: sched:sched_switch: prev_comm=perf prev_pid=232 prev_prio=120 prev_state=R ==> next_comm=perf next_pid=234 next_prio=120

This seems a little bit short on analysis; what actual flags are the
problem? Much of the data will in fact be identical between these
invocations and endlessly re-computing that is wasteful.

I'm thinking perhaps those flags that update ->dyn_size are the problem?
At the same time, Should you not also then clear dyn_size?
