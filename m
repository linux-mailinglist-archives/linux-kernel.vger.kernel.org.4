Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D506E689665
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjBCKZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjBCKZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:25:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507622BEDD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 02:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cY1asauO9N6j2ftzTeNwNb4RpkVnzG8lkgCxzfn/q9Q=; b=OtJIdCIOO37kUxdi79dcei1uA4
        PAv7KA7NbJA7WO5KFgPC/NKldw7WvvSmfpaGDBEQJb49tvZGt+iahhf0WIy4HaNQOW0P9h14skvB+
        i5faICwdmc/zlLPIADhWbnSHWsC4ME/IbOmakrWze5Nrr8Qf9JOWwsKsgKBHT4rsDjGvLiCA+LbCg
        c8jF7HKttZXW6axIB6cEsz50tq6VKsTlj7S8s+IR78+m2axbWDZwPiasq8S5+8JUTc2TJ2f/i231x
        sBhu3bL6ymitSpIzaZiyy+sFGGyjEEreeC2++3EMggk2p2e2JFYlkwZuI9RMbEQ7rfG7Ku3kXCl+b
        x8iP79Yw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pNtEf-005U8p-13;
        Fri, 03 Feb 2023 10:24:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C312D3001E5;
        Fri,  3 Feb 2023 11:24:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B4CBC2136FF23; Fri,  3 Feb 2023 11:24:35 +0100 (CET)
Date:   Fri, 3 Feb 2023 11:24:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Raghavendra K T <raghavendra.kt@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH V2 1/3] sched/numa: Apply the scan delay to every vma
 instead of tasks
Message-ID: <Y9zg46/Y7fGUvKCQ@hirez.programming.kicks-ass.net>
References: <cover.1675159422.git.raghavendra.kt@amd.com>
 <1aebc55030925998a3df3cafb79c5cd28b199ea8.1675159422.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aebc55030925998a3df3cafb79c5cd28b199ea8.1675159422.git.raghavendra.kt@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 01:32:20PM +0530, Raghavendra K T wrote:
> From: Mel Gorman <mgorman@techsingularity.net>
> 
>  Avoid scanning new or very short-lived VMAs.
> 
> (Raghavendra: Add initialization in vm_area_dup())

Given this is a performance centric patch -- some sort of qualification
/ justification would be much appreciated.

Also, perhaps explain the rationale for the actual heuristics chosen.

> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---
>  include/linux/mm.h       |  9 +++++++++
>  include/linux/mm_types.h |  7 +++++++
>  kernel/fork.c            |  2 ++
>  kernel/sched/fair.c      | 17 +++++++++++++++++
>  4 files changed, 35 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 974ccca609d2..74d9df1d8982 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -611,6 +611,14 @@ struct vm_operations_struct {
>  					  unsigned long addr);
>  };
>  
> +#ifdef CONFIG_NUMA_BALANCING
> +#define vma_numab_init(vma) do { (vma)->numab = NULL; } while (0)
> +#define vma_numab_free(vma) do { kfree((vma)->numab); } while (0)
> +#else
> +static inline void vma_numab_init(struct vm_area_struct *vma) {}
> +static inline void vma_numab_free(struct vm_area_struct *vma) {}
> +#endif /* CONFIG_NUMA_BALANCING */

I'm tripping over the inconsistency of macros and functions here. I'd
suggest making both cases functions.


> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 500e536796ca..e84f95a77321 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -435,6 +435,10 @@ struct anon_vma_name {
>  	char name[];
>  };
>  
> +struct vma_numab {
> +	unsigned long next_scan;
> +};

I'm not sure what a numab is; contraction of new-kebab, something else?

While I appreciate short names, they'd ideally also make sense. If we
cannot come up with a better one, perhaps elucidate the reader with a
comment.

> +
>  /*
>   * This struct describes a virtual memory area. There is one of these
>   * per VM-area/task. A VM area is any part of the process virtual memory
> @@ -504,6 +508,9 @@ struct vm_area_struct {

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e4a0b8bd941c..060b241ce3c5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3015,6 +3015,23 @@ static void task_numa_work(struct callback_head *work)
>  		if (!vma_is_accessible(vma))
>  			continue;
>  
> +		/* Initialise new per-VMA NUMAB state. */
> +		if (!vma->numab) {
> +			vma->numab = kzalloc(sizeof(struct vma_numab), GFP_KERNEL);
> +			if (!vma->numab)
> +				continue;
> +
> +			vma->numab->next_scan = now +
> +				msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
> +		}
> +
> +		/*
> +		 * After the first scan is complete, delay the balancing scan
> +		 * for new VMAs.
> +		 */
> +		if (mm->numa_scan_seq && time_before(jiffies, vma->numab->next_scan))
> +			continue;

I think I sorta see why, but I'm thinking it would be good to include
more of the why in that comment.
