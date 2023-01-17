Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779AA66E18C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjAQPCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjAQPBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:01:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB12240BE4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:59:58 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9886A688EC;
        Tue, 17 Jan 2023 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673967597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qLgqTbJWdzveKP+zt6MOjmsbrgQhAVlcSqf1/F/Fke4=;
        b=ySVbLUfhfhMuGGGA1cCrcJPB12Nh4JfvKhday4ev5IN4NX70+MK/TMW3H0HzJ+N/GShlkD
        SURoM+I7swFA8zGBUmi57EsPdTKBwfB356yvfi8e+5OTgl/4whqp2MkPQ9Nn5Wg6Exdk/0
        uV6Y9yF2M6rWyiXayAui/CFzaYbbjWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673967597;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qLgqTbJWdzveKP+zt6MOjmsbrgQhAVlcSqf1/F/Fke4=;
        b=iUZVkJUec3OMQOXPAYO27VCrg7WvhIqSBcEPQcKNBIIAp5iZsx2kmLZpt3Z7HyspweTmMx
        0ALO48kmTg2hBADw==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 206602C141;
        Tue, 17 Jan 2023 14:59:52 +0000 (UTC)
Date:   Tue, 17 Jan 2023 14:59:51 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Raghavendra K T <raghavendra.kt@amd.com>
Cc:     = <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        xu xin <cgel.zte@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Colin Cross <ccross@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Hugh Dickins <hughd@google.com>,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
Subject: Re: [RFC PATCH V1 1/1] sched/numa: Enhance vma scanning logic
Message-ID: <20230117145951.s2jmva4v54lfrhds@suse.de>
References: <cover.1673610485.git.raghavendra.kt@amd.com>
 <67bf778d592c39d02444825c416c2ed11d2ef4b2.1673610485.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <67bf778d592c39d02444825c416c2ed11d2ef4b2.1673610485.git.raghavendra.kt@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that the cc list is excessive for the topic.

On Mon, Jan 16, 2023 at 07:05:34AM +0530, Raghavendra K T wrote:
>  During the Numa scanning make sure only relevant vmas of the
> tasks are scanned.
> 
> Logic:
> 1) For the first two time allow unconditional scanning of vmas
> 2) Store recent 4 unique tasks (last 8bits of PIDs) accessed the vma.
>   False negetives in case of collison should be fine here.
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

This should be behind CONFIG_NUMA_BALANCING but per-vma state should also be
tracked in its own struct and allocated on demand iff the state is required.

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

I get the intent is to avoid PIDs scanning VMAs that it has never faulted
within but it seems unnecessarily complex to search on every fault to track
just 4 pids with no recent access information. The pid modulo BITS_PER_WORD
couls be used to set a bit on an unsigned long to track approximate recent
acceses and skip VMAs that do not have the bit set. That would allow more
recent PIDs to be tracked although false positives would still exist. It
would be necessary to reset the mask periodically.

Even tracking 4 pids, a reset is periodically needed. Otherwise it'll
be vulnerable to changes in phase behaviour causing all pids to scan all
VMAs again.

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

Won't build on defconfig

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

The PID tracking and clearing should probably be split out but that aside,
what about do_huge_pmd_numa_page?

First off though, expanding VMA size by more than a word for NUMA balancing
is probably a no-go.

This is a build-tested only prototype to illustrate how VMA could track
NUMA balancing state. It starts with applying the scan delay to every VMA
instead of every task to avoid scanning new or very short-lived VMAs. I
went back to my old notes on how I hoped to reduce excessive scanning in
NUMA balancing and it happened to be second on my list and straight-forward
to prototype in a few minutes.

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f3f196e4d66d..3cebda5cc8a7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -620,6 +620,9 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
+#ifdef CONFIG_NUMA_BALANCING
+	vma->numab = NULL;
+#endif
 }
 
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3b8475007734..3c0cfdde33e0 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -526,6 +526,10 @@ struct anon_vma_name {
 	char name[];
 };
 
+struct vma_numab {
+	unsigned long next_scan;
+};
+
 /*
  * This struct describes a virtual memory area. There is one of these
  * per VM-area/task. A VM area is any part of the process virtual memory
@@ -593,6 +597,9 @@ struct vm_area_struct {
 #endif
 #ifdef CONFIG_NUMA
 	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	struct vma_numab *numab;	/* NUMA Balancing state */
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
 } __randomize_layout;
diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe3541897..2d34c484553d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -481,6 +481,9 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 
 void vm_area_free(struct vm_area_struct *vma)
 {
+#ifdef CONFIG_NUMA_BALANCING
+	kfree(vma->numab);
+#endif
 	free_anon_vma_name(vma);
 	kmem_cache_free(vm_area_cachep, vma);
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c36aa54ae071..6a1cffdfc76b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3027,6 +3027,23 @@ static void task_numa_work(struct callback_head *work)
 		if (!vma_is_accessible(vma))
 			continue;
 
+		/* Initialise new per-VMA NUMAB state. */
+		if (!vma->numab) {
+			vma->numab = kzalloc(sizeof(struct vma_numab), GFP_KERNEL);
+			if (!vma->numab)
+				continue;
+
+			vma->numab->next_scan = now +
+				msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
+		}
+
+		/*
+		 * After the first scan is complete, delay the balancing scan
+		 * for new VMAs.
+		 */
+		if (mm->numa_scan_seq && time_before(jiffies, vma->numab->next_scan))
+			continue;
+
 		do {
 			start = max(start, vma->vm_start);
 			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);

-- 
Mel Gorman
SUSE Labs
