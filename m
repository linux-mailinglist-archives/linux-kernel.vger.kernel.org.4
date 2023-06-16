Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF409732B3D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245694AbjFPJSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244026AbjFPJSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:18:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40AA2695
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IrnvHszEBR9A7Viw68+3rFvRFE7mmEZ0fAWqL3Qu7Zg=; b=BysXOpPHnfhXbnPGqgDPLcCz+C
        6pw8y4oYfF9NFpETJt2L+g36hXECKvGAjRXlqPHpQeg100zEoi6lfNu5GFvkrczewu2dVRvfHj21g
        qMmYKB308zmb+hJlEp6DnQhmkSlI3wp7qOTnJtrsMoKUkyeCkimnzmv3vCY8kLw9ieZe8xzhgTVUj
        GGrrujRHNb8OR/qSInmpEsD0LlLQELW/+qYKreB1n6ICTM0BPq1c50mEsy+DsEz/qj7pEpga5f8Vs
        gXcUThYfWty7oinWmHGfd+IgaPm/fBk1F5Spns0JL/6wqrjk8jGMxVzTxy2CU1pEiWMFRsPmgQdT+
        1spnVuWA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qA5ap-00CsDc-24;
        Fri, 16 Jun 2023 09:18:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 378E2300188;
        Fri, 16 Jun 2023 11:18:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10B52300258E8; Fri, 16 Jun 2023 11:18:05 +0200 (CEST)
Date:   Fri, 16 Jun 2023 11:18:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH v5 2/4] sched/core: Avoid double calling
 update_rq_clock() in __balance_push_cpu_stop()
Message-ID: <20230616091805.GJ83892@hirez.programming.kicks-ass.net>
References: <20230613082012.49615-1-jiahao.os@bytedance.com>
 <20230613082012.49615-3-jiahao.os@bytedance.com>
 <20230615123950.GF1683497@hirez.programming.kicks-ass.net>
 <b4fcf354-f6ee-be68-1608-8b874511785a@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4fcf354-f6ee-be68-1608-8b874511785a@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 03:56:25PM +0800, Hao Jia wrote:

> I'm afraid not, the rq clock also needs to be updated before
> select_fallback_rq() is called.

> If we just remove update_rq_clock() from __balance_push_cpu_stop(), we will
> get this warning.
> 
> 
> [ 1260.960166] rq->clock_update_flags < RQCF_ACT_SKIP
> [ 1260.960170] WARNING: CPU: 25 PID: 196 at kernel/sched/sched.h:1496
> update_curr+0xf6/0x1f0
> 
> [ 1260.960318] Call Trace:
> [ 1260.960320]  <TASK>
> [ 1260.960359]  dequeue_entity+0x3b/0x410
> [ 1260.960361]  dequeue_task_fair+0xc7/0x3c0
> [ 1260.960363]  dequeue_task+0x30/0xf0
> [ 1260.960365]  __do_set_cpus_allowed+0x94/0x130
> [ 1260.960366]  do_set_cpus_allowed+0x38/0x60
> [ 1260.960368]  cpuset_cpus_allowed_fallback+0x70/0x80
> [ 1260.960372]  select_fallback_rq+0x20f/0x250            <----

Urgh... :-(
