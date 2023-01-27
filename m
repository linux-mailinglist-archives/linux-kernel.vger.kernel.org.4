Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CBA67E15A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjA0KRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbjA0KRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:17:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF15D7E6C9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:17:24 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A6EC5201D6;
        Fri, 27 Jan 2023 10:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674814643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BvSAvLPB3FHEPhqZN7UODvQNd2e9U7VcApyqDZZQ1ck=;
        b=KW2hxf9sVZKKqI9WrbdoibHXiEUpC0RDrtyzeo/AOG7AocgFe9+i9+yogOZOtWu+jofMCR
        ZwgMhgzaJ/jA4NGWzHSEcJmZ2/udsO2jkr4uWWgom0JM3t7XzP1OCksJBtqcU7hWM0VEUh
        uRPaS8J2g+In/F9qvsWiGzSPSjTPT3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674814643;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BvSAvLPB3FHEPhqZN7UODvQNd2e9U7VcApyqDZZQ1ck=;
        b=E8zZEMSnSEVlY5ZdXZLAzR8c35trocWed4TMrKvvS0NZnjS8ke6gtxLlCIL0Z62xzDYGOy
        Gqu7jEZYQ/4R0zAw==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 51CAD2C141;
        Fri, 27 Jan 2023 10:17:22 +0000 (UTC)
Date:   Fri, 27 Jan 2023 10:17:20 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Raghavendra K T <raghavendra.kt@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [RFC PATCH V1 1/1] sched/numa: Enhance vma scanning logic
Message-ID: <20230127101720.qh2wramyfyyucxhx@suse.de>
References: <cover.1673610485.git.raghavendra.kt@amd.com>
 <67bf778d592c39d02444825c416c2ed11d2ef4b2.1673610485.git.raghavendra.kt@amd.com>
 <20230117145951.s2jmva4v54lfrhds@suse.de>
 <10a06a2f-0dfc-6f36-3b7b-f4fd03153f66@amd.com>
 <118c2f4a-58d7-de42-1f77-31ac8a4d4701@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <118c2f4a-58d7-de42-1f77-31ac8a4d4701@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 12:48:16AM +0530, Raghavendra K T wrote:
> looks like we have to additionally handle numab initialization in
> vm_area_dup() code path. something like below fixed it (copied pasted
> from tty):
> 

Yep, it wasn't even boot tested. Better approach is something like this,
still not actually tested

 include/linux/mm.h       |  9 +++++++++
 include/linux/mm_types.h |  7 +++++++
 kernel/fork.c            |  2 ++
 kernel/sched/fair.c      | 17 +++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8f857163ac89..481f90dc1983 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -612,6 +612,14 @@ struct vm_operations_struct {
 					  unsigned long addr);
 };
 
+#ifdef CONFIG_NUMA_BALANCING
+#define vma_numab_init(vma) do { (vma)->numab = NULL; } while (0)
+#define vma_numab_free(vma) do { kfree((vma)->numab); } while (0)
+#else
+static inline void vma_numab_init(struct vm_area_struct *vma) {}
+static inline void vma_numab_free(struct vm_area_struct *vma) {}
+#endif /* CONFIG_NUMA_BALANCING */
+
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
 	static const struct vm_operations_struct dummy_vm_ops = {};
@@ -620,6 +628,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	vma_numab_init(vma);
 }
 
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 9757067c3053..43ce363d5124 100644
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
index 9f7fe3541897..5a2e8c3cc410 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -474,6 +474,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		 */
 		*new = data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
+		vma_numab_init(new);
 		dup_anon_vma_name(orig, new);
 	}
 	return new;
@@ -481,6 +482,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 
 void vm_area_free(struct vm_area_struct *vma)
 {
+	vma_numab_free(vma);
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
