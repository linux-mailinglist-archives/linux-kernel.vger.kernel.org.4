Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF68673498
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjASJkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjASJj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:39:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368166B9A5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:39:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F6A761384
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AE5C433EF;
        Thu, 19 Jan 2023 09:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674121193;
        bh=oC4rK1vElis6p5UZEhMNSBbWkHGAXkm0JBiBL1EnbyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZYHsHP0Mmss5O6jrrdgh9VRP8MrCsP4GP6MitJFyW3HxUxoxwifctz8cD/uLuqokI
         4ZfSATGVdLbN6QJ4z4tGVHPFqavkPJvqZi6a8M1EuoX4qUs43djPluB+n0UXv8MDNa
         4ZDxkNTYWKED8vb1JLuDXOuLz87reKSzKPBrQe1iXDKDtRIyiN8ogm4nGMy06cr9/Y
         teXR1sKxx2QhLAuGwmyMo89vNXBeNpcKUXVbn2Wwo6ueZuATmNEajDnt0pInCC3oR3
         yWlZCKewxkMonojOO5ht0RGTWqLW7joTDrNLW39TOi8zzERCrydbEaSLlO6A/ZvmMr
         s9dUJtvVqJfcg==
Date:   Thu, 19 Jan 2023 11:39:36 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Raghavendra K T <raghavendra.kt@amd.com>
Cc:     = <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        --cc=Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        xu xin <cgel.zte@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Colin Cross <ccross@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Hugh Dickins <hughd@google.com>,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
Subject: Re: [RFC PATCH V1 1/1] sched/numa: Enhance vma scanning logic
Message-ID: <Y8kP2KbJqWDIgGRZ@kernel.org>
References: <cover.1673610485.git.raghavendra.kt@amd.com>
 <67bf778d592c39d02444825c416c2ed11d2ef4b2.1673610485.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67bf778d592c39d02444825c416c2ed11d2ef4b2.1673610485.git.raghavendra.kt@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 16, 2023 at 07:05:34AM +0530, Raghavendra K T wrote:
>  During the Numa scanning make sure only relevant vmas of the
> tasks are scanned.

Please add more detailed description about what are the issues with the
current scanning this patch aims to solve.

> Logic:
> 1) For the first two time allow unconditional scanning of vmas
> 2) Store recent 4 unique tasks (last 8bits of PIDs) accessed the vma.
>   False negetives in case of collison should be fine here.

         ^ negatives

> 3) If more than 4 pids exist assume task indeed accessed vma to
>  to avoid false negetives
> 
> Co-developed-by: Bharata B Rao <bharata@amd.com>
> (initial patch to store pid information)
> 
> Suggested-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Bharata B Rao <bharata@amd.com>
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---
>  include/linux/mm_types.h |  2 ++
>  kernel/sched/fair.c      | 32 ++++++++++++++++++++++++++++++++
>  mm/memory.c              | 21 +++++++++++++++++++++
>  3 files changed, 55 insertions(+)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 500e536796ca..07feae37b8e6 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -506,6 +506,8 @@ struct vm_area_struct {
>  	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
>  #endif
>  	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> +	unsigned int accessing_pids;
> +	int next_pid_slot;
>  } __randomize_layout;
>  
>  struct kioctx_table;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e4a0b8bd941c..944d2e3b0b3c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2916,6 +2916,35 @@ static void reset_ptenuma_scan(struct task_struct *p)
>  	p->mm->numa_scan_offset = 0;
>  }
>  
> +static bool vma_is_accessed(struct vm_area_struct *vma)
> +{
> +	int i;
> +	bool more_pids_exist;
> +	unsigned long pid, max_pids;
> +	unsigned long current_pid = current->pid & LAST__PID_MASK;
> +
> +	max_pids = sizeof(unsigned int) * BITS_PER_BYTE / LAST__PID_SHIFT;
> +
> +	/* By default we assume >= max_pids exist */
> +	more_pids_exist = true;
> +
> +	if (READ_ONCE(current->mm->numa_scan_seq) < 2)
> +		return true;
> +
> +	for (i = 0; i < max_pids; i++) {
> +		pid = (vma->accessing_pids >> i * LAST__PID_SHIFT) &
> +			LAST__PID_MASK;
> +		if (pid == current_pid)
> +			return true;
> +		if (pid == 0) {
> +			more_pids_exist = false;
> +			break;
> +		}
> +	}
> +
> +	return more_pids_exist;
> +}
> +
>  /*
>   * The expensive part of numa migration is done from task_work context.
>   * Triggered from task_tick_numa().
> @@ -3015,6 +3044,9 @@ static void task_numa_work(struct callback_head *work)
>  		if (!vma_is_accessible(vma))
>  			continue;
>  
> +		if (!vma_is_accessed(vma))
> +			continue;
> +
>  		do {
>  			start = max(start, vma->vm_start);
>  			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
> diff --git a/mm/memory.c b/mm/memory.c
> index 8c8420934d60..fafd78d87a51 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4717,7 +4717,28 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	pte_t pte, old_pte;
>  	bool was_writable = pte_savedwrite(vmf->orig_pte);
>  	int flags = 0;
> +	int pid_slot = vma->next_pid_slot;
>  
> +	int i;
> +	unsigned long pid, max_pids;
> +	unsigned long current_pid = current->pid & LAST__PID_MASK;
> +
> +	max_pids = sizeof(unsigned int) * BITS_PER_BYTE / LAST__PID_SHIFT;
> +
> +	/* Avoid duplicate PID updation */
> +	for (i = 0; i < max_pids; i++) {
> +		pid = (vma->accessing_pids >> i * LAST__PID_SHIFT) &
> +			LAST__PID_MASK;
> +		if (pid == current_pid)
> +			goto skip_update;
> +	}
> +
> +	vma->next_pid_slot = (++pid_slot) % max_pids;
> +	vma->accessing_pids &= ~(LAST__PID_MASK << (pid_slot * LAST__PID_SHIFT));
> +	vma->accessing_pids |= ((current_pid) <<
> +			(pid_slot * LAST__PID_SHIFT));
> +
> +skip_update:
>  	/*
>  	 * The "pte" at this point cannot be used safely without
>  	 * validation through pte_unmap_same(). It's of NUMA type but
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
