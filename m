Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358CE6D556A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 02:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjDDANC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 20:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjDDAM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 20:12:59 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7484209
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 17:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1680567172;
        bh=Y/dFV+CJVBUNvm1HPncse1hPcNAqlrN9lWbk69vAWjA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gNTdrqpdpfIBqy2ToQyEQvEDGOjv6vKijUsCfQC4Ed5JMEaRb3kidZ1u9eQ1DKHaa
         b/gpe4YvcQW/7+WNQcRwotj3wsL9VW1S5VBIfVQbSzvV0zr5G7hj9C0h6O+UgYiqIN
         nXccd/EC9OotETex7tJEQ/OkXQle0NRA5rDjnkAmSVbBY9gC9vy5oIgmY6kTGNPdlB
         B7FVF00+hCuXa18E9e1xO+Gs3BQSafGjjPoqImqzJyfww60ASTOVn0uL8lkSyNKUq2
         ltfJ3LlDT7p10QSVeaWdf+aSfloFv7XfmcBqwnNpsHK9cO4OrhVdnxbkLJSF1yoNlk
         XoORdVWFlGslQ==
Received: from [10.1.0.215] (unknown [192.222.195.223])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Pr7WS4stSzthn;
        Mon,  3 Apr 2023 20:12:52 -0400 (EDT)
Message-ID: <230301bb-58db-650d-8eb3-8915151685d1@efficios.com>
Date:   Mon, 3 Apr 2023 20:13:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
References: <20230403181342.210896-1-mathieu.desnoyers@efficios.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230403181342.210896-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-03 14:13, Mathieu Desnoyers wrote:
[...]
> +/*
> + * Migration to dst cpu. Called with dst_rq lock held.
> + */
> +void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t, int src_cid)
> +{
> +	struct mm_struct *mm = t->mm;
> +	int dst_cid, *dst_pcpu_cid;
> +
> +	lockdep_assert_rq_held(dst_rq);
> +
> +	if (!mm || src_cid == -1)
> +		return;
> +
> +	dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
> +
> +	/*
> +	 * If destination cpu cid is greater than the source cpu cid, unset it
> +	 * so it can be reallocated.
> +	 */
> +	dst_cid = *dst_pcpu_cid;
> +	if (dst_cid == -1 || dst_cid < src_cid)

Small detail: I plan to change this from "dst_cid < src_cid" to
"dst_cid  <= src_cid" in my next version of the patch to handle the
unlikely case where a task would be migrated back and forth between
two runqueues without being scheduled. It would be possible that the
task's last_mm_cid is equal to the dst_cid here, in which case it
would be better to leave the mm's destination cpu cid set.

> +		return;
> +	*dst_pcpu_cid = -1;
> +	/*
> +	 * Put dst_cid if it is not currently in use, else it will be lazy put
> +	 * on the next context switch.
> +	 */
> +	if (dst_rq->curr->mm != mm)
> +		__mm_cid_put(mm, dst_cid);
> +}

[...]

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

