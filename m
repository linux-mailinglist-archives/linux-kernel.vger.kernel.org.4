Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2756E1144
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjDMPhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjDMPhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:37:20 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F971712
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681400238;
        bh=fjXZqkHXe19Tq3jXBylPeWy5W3C2ybEhSf4v5enAkPA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kHRYyY/4mX79LTldODq//iWHMzCCbRR4zHH7NWBG0SnwOI0BkuxqQS0iTcKZ8Rw+7
         EGMd8H+gPwXukd8KQjaKOlTtxk9dW3zjGpoThW3lAUrfGvhxR3+iErLzmbmKnxNPu6
         7R58SRxg4nGdGZES61FPiqlrk6IQR0m1KXpmfnMIRjossMSeI8H4hpQP++GD2xrKON
         uc8tLrnJpDNhvmNkuLTaxB4mL5IZrhuSkfVNvnv9RpeG929fkiTyXj8O9etIlGfMbH
         B5rkX0Iudr5fKcFREaMvgLlrqjY2XLMk02N47/ktz3ZfsSRTYsYvDsnRAHl4XduBUM
         2kYi2BkguA1Hw==
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Py3by1BmZzvJj;
        Thu, 13 Apr 2023 11:37:18 -0400 (EDT)
Message-ID: <47f42d31-4b74-0273-62c1-0b75fffbf066@efficios.com>
Date:   Thu, 13 Apr 2023 11:37:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v4] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aaron Lu <aaron.lu@intel.com>, linux-kernel@vger.kernel.org,
        Olivier Dion <odion@efficios.com>, michael.christie@oracle.com
References: <20230410150150.2179062-1-mathieu.desnoyers@efficios.com>
 <20230411045225.GA3509@ziqianlu-desk2> <20230411131221.GA7356@ziqianlu-desk2>
 <20230412091043.GC4253@hirez.programming.kicks-ass.net>
 <20230412114240.GA155547@ziqianlu-desk2>
 <20230412142616.GI628377@hirez.programming.kicks-ass.net>
 <20230412143934.GB162902@ziqianlu-desk2>
 <20230413111047.GB83892@hirez.programming.kicks-ass.net>
 <6b8e63ab-e81e-470c-e03f-f3860c83bdb1@efficios.com>
 <20230413152023.GO4253@hirez.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230413152023.GO4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-13 11:20, Peter Zijlstra wrote:
> On Thu, Apr 13, 2023 at 09:56:38AM -0400, Mathieu Desnoyers wrote:
> 
>>> Mathieu, WDYT? -- other than that the patch is an obvious hack :-)
>>
>> I hate it with passion :-)
>>
>> It is quite specific to your workload/configuration.
>>
>> If we take for instance a process with a large mm_users count which is
>> eventually affined to a subset of the cpus with cpusets or
>> sched_setaffinity, your patch will prevent compaction of the concurrency ids
>> when it really should not.
> 
> I don't think it will, it will only kick in once the higest cid is
> handed out (I should've used num_online_cpus() instead of nr_cpu_ids),
> and with affinity at play that should never happen.

So in that case, this optimization will only work if affinity is not 
set. E.g. a hackbench with cpuset or sched_setaffinity excluding one
core from the set will still be slower.

> 
> Now, the more fancy scheme with:
> 
> 	min(t->nr_cpus_allowed, atomic_read(&t->mm->mm_users))
> 
> that does get to be more complex; and I've yet to find a working version
> that doesn't also need a for_each_cpu() loop on for reclaim :/

Indeed. And with a allowed cpus approach, we need to carefully consider 
what happens if we change a allowed cpu mask from one set to another 
set, e.g, from allowing cpus 0, 1 to allowing only cpus 2, 3. There will 
be task migration, and we need to reclaim the cids from 0, 1, but we can 
very well be in a case where the number of mm_users is above the number 
of allowed cpus.

> 
> Anyway, I think the hack as presented is safe, but a hack none-the-less.

I don't think it is _unsafe_, but it will only trigger in specific 
scenarios, which makes it harder to understand more subtle performance 
regressions for scenarios that are not covered by this hack.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

