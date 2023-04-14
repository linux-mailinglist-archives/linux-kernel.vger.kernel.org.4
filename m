Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8656E2558
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjDNOLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjDNOLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:11:24 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E58AB75E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681481395;
        bh=FdFmreqaZuM3m9SBLcM9MD/taB99z0XN3qpFnz7qd3c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pPbBqLgWLAOjGSxdKcbS+kZXenbsfRYzOimW3z1FkURA7nACRWBE0TZ/gnen9T43L
         Zgdk2El5Cd6Qjk+S+c9rlhCjhV6THlXG6QryuzG/vGId9AdoTR6cuz0MkRfMTGD6jY
         B6k/N8kSnP0lrIPJINCGKINCBFLuNwJcRU7uL01LfAkPmyve8BI7ry6jp82Yn4qnNb
         Nt3sq2oqY94XgsQ8E5lCtWVfN5DuWpSRDfvMMgdE2GhLQHs9hOA00DzbSi7v/WhUEV
         Z7HdjS24PGAfGnLOfXtw/QG2fzw+xlLuRyBch0iO7SusZbGPQEg3dsxNaMqisFEkIw
         fYVksmihLG69w==
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Pydcg3gLvzvRx;
        Fri, 14 Apr 2023 10:09:55 -0400 (EDT)
Message-ID: <ebfb79e8-a5a6-0bc4-c46c-4c1bc80777ac@efficios.com>
Date:   Fri, 14 Apr 2023 10:09:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v6] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Olivier Dion <odion@efficios.com>,
        michael.christie@oracle.com
References: <20230413223356.17195-1-mathieu.desnoyers@efficios.com>
 <20230414140753.GA279103@ziqianlu-desk2>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230414140753.GA279103@ziqianlu-desk2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-14 10:07, Aaron Lu wrote:
> On Thu, Apr 13, 2023 at 06:33:56PM -0400, Mathieu Desnoyers wrote:
>> Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
>> sysbench regression reported by Aaron Lu.
>>
>> Keep track of the currently allocated mm_cid for each mm/cpu rather than
>> freeing them immediately on context switch. This eliminates most atomic
>> operations when context switching back and forth between threads
>> belonging to different memory spaces in multi-threaded scenarios (many
>> processes, each with many threads). The per-mm/per-cpu mm_cid values are
>> serialized by their respective runqueue locks.
>>
>> Thread migration is handled by introducing a task-work executed
>> periodically, similarly to NUMA work, which delays reclaim of cid
>> values when they are unused for a period of time.
>>
>> Keep track of the allocation time for each per-cpu cid, and let the task
>> work clear them when they are observed to be older than
>> SCHED_MM_CID_PERIOD_NS and unused.
>>
>> This fix is going for a task-work and delayed reclaim approach rather
>> than adding hooks to migrate-from and migrate-to because migration
>> happens to be a hot path for various real-world workloads.
>>
>> Because we want to ensure the mm_cid converges towards the smaller
>> values as migrations happen, the prior optimization that was done when
>> context switching between threads belonging to the same mm is removed,
>> because it could delay the lazy release of the destination runqueue
>> mm_cid after it has been replaced by a migration. Removing this prior
>> optimization is not an issue performance-wise because the introduced
>> per-mm/per-cpu mm_cid tracking also covers this more specific case.
> 
> I was wondering, if a thread was migrated to all possible cpus in the
> SCHED_MM_CID_PERIOD_NS window, its mm_cidmask will be full. For user
> space, if cid can be the full set of cpus, then it will have to prepare
> storage for the full set. Then what's the point of doing compaction? Or
> do I understand it wrong?

Yes, that's a limit of this approach I am aware of. I'm currently trying 
to combine the best parts of v5 and v6 together to add back a low 
overhead migration hook that will preserve the compactness in those 
migration scenarios.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

