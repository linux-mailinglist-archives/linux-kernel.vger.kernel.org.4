Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AF7641DD3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 17:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiLDQOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 11:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiLDQOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 11:14:49 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ADE13FB3
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 08:14:47 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id g10so8758469plo.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 08:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCicEi7EuklgtEvCZ5T+k9chhbYeMI1fhQwXDoR5e2w=;
        b=DN9268v2i3+YlCBpBr/u+qAFDKpY0ZPHZx2wfNv72EIZ3pz9YkMHTJLvBSDMkuUCaC
         D+jRP0AHeKOdXlpQN/h24Li3REEESHkiPS8mBrCAxV3Le447Tm9PqSTcS+jrW1ub8EOV
         g9yOr4RebeIRNyICOezYtiJ+JsT+RqSL3GcPYZ4FSxpxdtWPij2bM4mlYuUmLjYJACBj
         1KlAp0/qH4VcdAFwx0TOYD5ylJalVr84fLlz2dTC/izxghpZN5xf6LAVWQwiQuZ0Iua5
         k5Mpnxz4xpGYOWQPUnNBeOCGtw0LtOsRB8icvfzA3oeDlGHX9QgRL8xgmvPvsLhY/3H1
         niVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCicEi7EuklgtEvCZ5T+k9chhbYeMI1fhQwXDoR5e2w=;
        b=JZB+x5+Q2tDe3x+mk71ezBxn70ehiiiy6fC0b78XPbqCsJ8ngtGP1dO5kuBvD6rAES
         52vOXcufgmWsRLLHSeJveQHLY2zwEL/sbeC8EVgne4HcpCsNDPA/wa0vcshICsR47vJy
         wYLtsZuIfkKPIpzC4PsyDR/U7LGp1TdgzWo/V4int1YhOfbK5R7F1arYM6SEnboPIXsm
         JPqgbXYTQCsC2byxsYHn1F7RFMGnt6qx5LjCi8Wz9sT8zEzOZJc8z8iWd3410wBgODfK
         hZ2PBXxgNM4eukbw50t5bZjfb0OFMexqNkeVbAIi12S/2KuI1UpmbVo5pHCB6gPj/AuK
         IbOg==
X-Gm-Message-State: ANoB5pkokXBL9lE30wDiRJVwm+uLtBAGuDxSpXs0POWz2a886mQdtfuf
        B4RSNP6+kxb66gkuesG6mpQ3bg==
X-Google-Smtp-Source: AA0mqf4RTokf5jbtgEXm4IxyiK0LlJQVlE4iuPUaj9KIK0LuPxp0yXJ2jh/wtRqe576LVRVkqoPAhg==
X-Received: by 2002:a17:90a:ae01:b0:213:e8b5:2d50 with SMTP id t1-20020a17090aae0100b00213e8b52d50mr85553925pjq.211.1670170487204;
        Sun, 04 Dec 2022 08:14:47 -0800 (PST)
Received: from Tower.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b0016cf3f124e1sm9000323plh.234.2022.12.04.08.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 08:14:46 -0800 (PST)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, wuyun.abel@bytedance.com,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH 1/3] mm: replace mpol_put() with mpol_kill() initiated the destruction of mpol.
Date:   Mon,  5 Dec 2022 00:14:30 +0800
Message-Id: <20221204161432.2149375-2-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221204161432.2149375-1-hezhongkun.hzk@bytedance.com>
References: <20221204161432.2149375-1-hezhongkun.hzk@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpol_kill() is used to initiate destruction of mempolicy.
so it is called to free the mempolicy. The pol_put() just
decrement the local counter.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 fs/hugetlbfs/inode.c |  2 +-
 fs/proc/task_mmu.c   |  3 +--
 kernel/fork.c        |  4 ++--
 mm/hugetlb.c         |  6 +++---
 mm/mempolicy.c       | 42 +++++++++++++++++++++---------------------
 mm/mmap.c            | 10 +++++-----
 mm/shmem.c           | 10 +++++-----
 7 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index dd54f67e47fd..bad1b07f8653 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -93,7 +93,7 @@ static inline void hugetlb_set_vma_policy(struct vm_area_struct *vma,
 
 static inline void hugetlb_drop_vma_policy(struct vm_area_struct *vma)
 {
-	mpol_cond_put(vma->vm_policy);
+	mpol_put(vma->vm_policy);
 }
 #else
 static inline void hugetlb_set_vma_policy(struct vm_area_struct *vma,
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8a74cdcc9af0..24aac42428b3 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -107,7 +107,6 @@ static void hold_task_mempolicy(struct proc_maps_private *priv)
 
 	task_lock(task);
 	priv->task_mempolicy = get_task_policy(task);
-	mpol_get(priv->task_mempolicy);
 	task_unlock(task);
 }
 static void release_task_mempolicy(struct proc_maps_private *priv)
@@ -1949,7 +1948,7 @@ static int show_numa_map(struct seq_file *m, void *v)
 	pol = __get_vma_policy(vma, vma->vm_start);
 	if (pol) {
 		mpol_to_str(buffer, sizeof(buffer), pol);
-		mpol_cond_put(pol);
+		mpol_put(pol);
 	} else {
 		mpol_to_str(buffer, sizeof(buffer), proc_priv->task_mempolicy);
 	}
diff --git a/kernel/fork.c b/kernel/fork.c
index 08969f5aa38d..97ba127a1b89 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -712,7 +712,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 fail_nomem_mas_store:
 	unlink_anon_vmas(tmp);
 fail_nomem_anon_vma_fork:
-	mpol_put(vma_policy(tmp));
+	mpol_kill(vma_policy(tmp));
 fail_nomem_policy:
 	vm_area_free(tmp);
 fail_nomem:
@@ -2537,7 +2537,7 @@ static __latent_entropy struct task_struct *copy_process(
 bad_fork_cleanup_policy:
 	lockdep_free_task(p);
 #ifdef CONFIG_NUMA
-	mpol_put(p->mempolicy);
+	mpol_kill(p->mempolicy);
 #endif
 bad_fork_cleanup_delayacct:
 	delayacct_tsk_free(p);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 546df97c31e4..277330f40818 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1246,7 +1246,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 		h->resv_huge_pages--;
 	}
 
-	mpol_cond_put(mpol);
+	mpol_put(mpol);
 	return page;
 
 err:
@@ -2315,7 +2315,7 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 
 	if (!page)
 		page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
-	mpol_cond_put(mpol);
+	mpol_put(mpol);
 	return page;
 }
 
@@ -2351,7 +2351,7 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 	gfp_mask = htlb_alloc_mask(h);
 	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
 	page = alloc_huge_page_nodemask(h, node, nodemask, gfp_mask);
-	mpol_cond_put(mpol);
+	mpol_put(mpol);
 
 	return page;
 }
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index ee3e2ed5ef07..f1857ebded46 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -795,11 +795,11 @@ static int vma_replace_policy(struct vm_area_struct *vma,
 
 	old = vma->vm_policy;
 	vma->vm_policy = new; /* protected by mmap_lock */
-	mpol_put(old);
+	mpol_kill(old);
 
 	return 0;
  err_out:
-	mpol_put(new);
+	mpol_kill(new);
 	return err;
 }
 
@@ -890,7 +890,7 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 	ret = mpol_set_nodemask(new, nodes, scratch);
 	if (ret) {
 		task_unlock(current);
-		mpol_put(new);
+		mpol_kill(new);
 		goto out;
 	}
 
@@ -899,7 +899,7 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 	if (new && new->mode == MPOL_INTERLEAVE)
 		current->il_prev = MAX_NUMNODES-1;
 	task_unlock(current);
-	mpol_put(old);
+	mpol_kill(old);
 	ret = 0;
 out:
 	NODEMASK_SCRATCH_FREE(scratch);
@@ -925,8 +925,7 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 		*nodes = p->nodes;
 		break;
 	case MPOL_LOCAL:
-		/* return empty node mask for local allocation */
-		break;
+		/* return empty node mask for local allocation */killbreak;
 	default:
 		BUG();
 	}
@@ -1370,7 +1369,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 
 	mmap_write_unlock(mm);
 mpol_out:
-	mpol_put(new);
+	mpol_kill(new);
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
 		lru_cache_enable();
 	return err;
@@ -1566,7 +1565,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 
 		new->home_node = home_node;
 		err = mbind_range(mm, vmstart, vmend, new);
-		mpol_put(new);
+		mpol_kill(new);
 		if (err)
 			break;
 	}
@@ -1813,14 +1812,13 @@ static struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 bool vma_policy_mof(struct vm_area_struct *vma)
 {
 	struct mempolicy *pol;
+	bool ret = false;
 
 	if (vma->vm_ops && vma->vm_ops->get_policy) {
-		bool ret = false;
-
 		pol = vma->vm_ops->get_policy(vma, vma->vm_start);
 		if (pol && (pol->flags & MPOL_F_MOF))
 			ret = true;
-		mpol_cond_put(pol);
+		mpol_put(pol);
 
 		return ret;
 	}
@@ -1828,8 +1826,9 @@ bool vma_policy_mof(struct vm_area_struct *vma)
 	pol = vma->vm_policy;
 	if (!pol)
 		pol = get_task_policy(current);
+	mpol_put(pol);
 
-	return pol->flags & MPOL_F_MOF;
+	return ret;
 }
 
 bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
@@ -2193,7 +2192,7 @@ struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
 		unsigned nid;
 
 		nid = interleave_nid(pol, vma, addr, PAGE_SHIFT + order);
-		mpol_cond_put(pol);
+		mpol_put(pol);
 		gfp |= __GFP_COMP;
 		page = alloc_page_interleave(gfp, order, nid);
 		if (page && order > 1)
@@ -2208,7 +2207,7 @@ struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
 		node = policy_node(gfp, pol, node);
 		gfp |= __GFP_COMP;
 		page = alloc_pages_preferred_many(gfp, order, node, pol);
-		mpol_cond_put(pol);
+		mpol_put(pol);
 		if (page && order > 1)
 			prep_transhuge_page(page);
 		folio = (struct folio *)page;
@@ -2233,7 +2232,7 @@ struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
 
 		nmask = policy_nodemask(gfp, pol);
 		if (!nmask || node_isset(hpage_node, *nmask)) {
-			mpol_cond_put(pol);
+			mpol_put(pol);
 			/*
 			 * First, try to allocate THP only on local node, but
 			 * don't reclaim unnecessarily, just compact.
@@ -2258,7 +2257,7 @@ struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
 	nmask = policy_nodemask(gfp, pol);
 	preferred_nid = policy_node(gfp, pol, node);
 	folio = __folio_alloc(gfp, order, preferred_nid, nmask);
-	mpol_cond_put(pol);
+	mpol_put(pol);
 out:
 	return folio;
 }
@@ -2300,6 +2299,7 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
 				policy_node(gfp, pol, numa_node_id()),
 				policy_nodemask(gfp, pol));
 
+	mpol_put(pol);
 	return page;
 }
 EXPORT_SYMBOL(alloc_pages);
@@ -2566,7 +2566,7 @@ mpol_shared_policy_lookup(struct shared_policy *sp, unsigned long idx)
 
 static void sp_free(struct sp_node *n)
 {
-	mpol_put(n->policy);
+	mpol_kill(n->policy);
 	kmem_cache_free(sn_cache, n);
 }
 
@@ -2655,7 +2655,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 	if (curnid != polnid)
 		ret = polnid;
 out:
-	mpol_cond_put(pol);
+	mpol_put(pol);
 
 	return ret;
 }
@@ -2674,7 +2674,7 @@ void mpol_put_task_policy(struct task_struct *task)
 	pol = task->mempolicy;
 	task->mempolicy = NULL;
 	task_unlock(task);
-	mpol_put(pol);
+	mpol_kill(pol);
 }
 
 static void sp_delete(struct shared_policy *sp, struct sp_node *n)
@@ -2763,7 +2763,7 @@ static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
 
 err_out:
 	if (mpol_new)
-		mpol_put(mpol_new);
+		mpol_kill(mpol_new);
 	if (n_new)
 		kmem_cache_free(sn_cache, n_new);
 
@@ -2823,7 +2823,7 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 		mpol_set_shared_policy(sp, &pvma, new); /* adds ref */
 
 put_new:
-		mpol_put(new);			/* drop initial ref */
+		mpol_kill(new);			/* drop initial ref */
 free_scratch:
 		NODEMASK_SCRATCH_FREE(scratch);
 put_mpol:
diff --git a/mm/mmap.c b/mm/mmap.c
index 2def55555e05..7bf785463499 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -140,7 +140,7 @@ static void remove_vma(struct vm_area_struct *vma)
 		vma->vm_ops->close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
-	mpol_put(vma_policy(vma));
+	mpol_kill(vma_policy(vma));
 	vm_area_free(vma);
 }
 
@@ -595,7 +595,7 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
 		if (next->anon_vma)
 			anon_vma_merge(vma, next);
 		mm->map_count--;
-		mpol_put(vma_policy(next));
+		mpol_kill(vma_policy(next));
 		vm_area_free(next);
 	}
 
@@ -836,7 +836,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		if (next->anon_vma)
 			anon_vma_merge(vma, next);
 		mm->map_count--;
-		mpol_put(vma_policy(next));
+		mpol_kill(vma_policy(next));
 		if (remove_next != 2)
 			BUG_ON(vma->vm_end < next->vm_end);
 		vm_area_free(next);
@@ -2253,7 +2253,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 		fput(new->vm_file);
 	unlink_anon_vmas(new);
  out_free_mpol:
-	mpol_put(vma_policy(new));
+	mpol_kill(vma_policy(new));
  out_free_vma:
 	vm_area_free(new);
 	validate_mm_mt(mm);
@@ -3246,7 +3246,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 
 	unlink_anon_vmas(new_vma);
 out_free_mempol:
-	mpol_put(vma_policy(new_vma));
+	mpol_kill(vma_policy(new_vma));
 out_free_vma:
 	vm_area_free(new_vma);
 out:
diff --git a/mm/shmem.c b/mm/shmem.c
index c1d8b8a1aa3b..11e57d79c104 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1485,7 +1485,7 @@ static void shmem_pseudo_vma_init(struct vm_area_struct *vma,
 static void shmem_pseudo_vma_destroy(struct vm_area_struct *vma)
 {
 	/* Drop reference taken by mpol_shared_policy_lookup() */
-	mpol_cond_put(vma->vm_policy);
+	mpol_put(vma->vm_policy);
 }
 
 static struct folio *shmem_swapin(swp_entry_t swap, gfp_t gfp,
@@ -3528,7 +3528,7 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_mpol:
 		if (IS_ENABLED(CONFIG_NUMA)) {
-			mpol_put(ctx->mpol);
+			mpol_kill(ctx->mpol);
 			ctx->mpol = NULL;
 			if (mpol_parse_str(param->string, &ctx->mpol))
 				goto bad_value;
@@ -3666,7 +3666,7 @@ static int shmem_reconfigure(struct fs_context *fc)
 		ctx->mpol = NULL;
 	}
 	raw_spin_unlock(&sbinfo->stat_lock);
-	mpol_put(mpol);
+	mpol_kill(mpol);
 	return 0;
 out:
 	raw_spin_unlock(&sbinfo->stat_lock);
@@ -3730,7 +3730,7 @@ static void shmem_put_super(struct super_block *sb)
 
 	free_percpu(sbinfo->ino_batch);
 	percpu_counter_destroy(&sbinfo->used_blocks);
-	mpol_put(sbinfo->mpol);
+	mpol_kill(sbinfo->mpol);
 	kfree(sbinfo);
 	sb->s_fs_info = NULL;
 }
@@ -3830,7 +3830,7 @@ static void shmem_free_fc(struct fs_context *fc)
 	struct shmem_options *ctx = fc->fs_private;
 
 	if (ctx) {
-		mpol_put(ctx->mpol);
+		mpol_kill(ctx->mpol);
 		kfree(ctx);
 	}
 }
-- 
2.25.1

