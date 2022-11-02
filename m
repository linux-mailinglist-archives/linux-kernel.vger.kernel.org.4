Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141C5615D10
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiKBHjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKBHj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:39:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5372424F30
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:39:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D59122990;
        Wed,  2 Nov 2022 07:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667374765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cst1b3RBrCokRDWz1s7fqBTo7DXxaSid3C3ZueSC0aU=;
        b=MCUs88mxzmOlTAc8mxrTiceCrXQdLwvWBAJV8SwDzupNgOaTNt8sTrGZVSG2GD4oXEagEB
        hg1Zqx1Z4P8cHuITpVoSz35y1uhJ+eZgpH/P3FWVF0YC4fEvRP/vh48HBM+cVT7wvYF9+a
        fRFaHO580IffnBfH7CJeVuZ8CPL6Cms=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E67941376E;
        Wed,  2 Nov 2022 07:39:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y/b8NaweYmOUbgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 02 Nov 2022 07:39:24 +0000
Date:   Wed, 2 Nov 2022 08:39:24 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     Yang Shi <shy828301@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: don't warn if the node is offlined
Message-ID: <Y2IerOXJ+ZoRTHcs@dhcp22.suse.cz>
References: <20221031183122.470962-1-shy828301@gmail.com>
 <Y2BHcBCR2FIJgU4w@dhcp22.suse.cz>
 <CAAa6QmQt9Us8YpirQGXV0_AetuPS+EOqMSGqNn6KW24HXvwO_A@mail.gmail.com>
 <Y2DQr06mNzk0ITX1@dhcp22.suse.cz>
 <CAHbLzkonsnr4yxUOpMpoch1eCVNgR5hC9YaMkPR=fSV2Uszc6g@mail.gmail.com>
 <CAAa6QmRe1zMp8P-gZjR63Fg6KhOw+fP-v7SQWLNKuc2Y9ZxvyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAa6QmRe1zMp8P-gZjR63Fg6KhOw+fP-v7SQWLNKuc2Y9ZxvyA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01-11-22 12:13:35, Zach O'Keefe wrote:
[...]
> This is slightly tangential - but I don't want to send a new mail
> about it -- but I wonder if we should be doing __GFP_THISNODE +
> explicit node vs having hpage_collapse_find_target_node() set a
> nodemask. We could then provide fallback nodes for ties, or if some
> node contained > some threshold number of pages.

I would simply go with something like this (not even compile tested):

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4734315f7940..947a5158fe11 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -96,9 +96,6 @@ struct collapse_control {
 
 	/* Num pages scanned per node */
 	u32 node_load[MAX_NUMNODES];
-
-	/* Last target selected in hpage_collapse_find_target_node() */
-	int last_target_node;
 };
 
 /**
@@ -734,7 +731,6 @@ static void khugepaged_alloc_sleep(void)
 
 struct collapse_control khugepaged_collapse_control = {
 	.is_khugepaged = true,
-	.last_target_node = NUMA_NO_NODE,
 };
 
 static bool hpage_collapse_scan_abort(int nid, struct collapse_control *cc)
@@ -772,7 +768,7 @@ static inline gfp_t alloc_hugepage_khugepaged_gfpmask(void)
 }
 
 #ifdef CONFIG_NUMA
-static int hpage_collapse_find_target_node(struct collapse_control *cc)
+static int hpage_collapse_find_target_node(struct collapse_control *cc, nodemask_t *alloc_mask)
 {
 	int nid, target_node = 0, max_value = 0;
 
@@ -783,28 +779,25 @@ static int hpage_collapse_find_target_node(struct collapse_control *cc)
 			target_node = nid;
 		}
 
+	nodes_clear(&alloc_mask);
 	/* do some balance if several nodes have the same hit record */
-	if (target_node <= cc->last_target_node)
-		for (nid = cc->last_target_node + 1; nid < MAX_NUMNODES;
-		     nid++)
-			if (max_value == cc->node_load[nid]) {
-				target_node = nid;
-				break;
-			}
+	for_each_online_node(nid) {_
+		if (max_value == cc->node_load[nid])
+			node_set(nid, &alloc_mask)
+	}
 
-	cc->last_target_node = target_node;
 	return target_node;
 }
 #else
-static int hpage_collapse_find_target_node(struct collapse_control *cc)
+static int hpage_collapse_find_target_node(struct collapse_control *cc, nodemask_t *alloc_mask)
 {
 	return 0;
 }
 #endif
 
-static bool hpage_collapse_alloc_page(struct page **hpage, gfp_t gfp, int node)
+static bool hpage_collapse_alloc_page(struct page **hpage, gfp_t gfp, int node, nodemask_t *nmask)
 {
-	*hpage = __alloc_pages_node(node, gfp, HPAGE_PMD_ORDER);
+	*hpage = __alloc_pages(gfp, HPAGE_PMD_ORDER, node, nmask);
 	if (unlikely(!*hpage)) {
 		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
 		return false;
@@ -958,9 +951,18 @@ static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
 	/* Only allocate from the target node */
 	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
 		     GFP_TRANSHUGE) | __GFP_THISNODE;
-	int node = hpage_collapse_find_target_node(cc);
+	NODEMASK_ALLOC(nodemask_t, nmask, GFP_KERNEL);
+	int node;
+	int ret;
+
+	if (!nmaks)
+		return SCAN_ALLOC_HUGE_PAGE_FAIL;
+
+	node = hpage_collapse_find_target_node(cc, nmask);
+	ret = hpage_collapse_alloc_page(hpage, gfp, node, nmask);
+	NODEMASK_FREE(nmask);
 
-	if (!hpage_collapse_alloc_page(hpage, gfp, node))
+	if (!ret)
 		return SCAN_ALLOC_HUGE_PAGE_FAIL;
 	if (unlikely(mem_cgroup_charge(page_folio(*hpage), mm, gfp)))
 		return SCAN_CGROUP_CHARGE_FAIL;
@@ -2576,7 +2578,6 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	if (!cc)
 		return -ENOMEM;
 	cc->is_khugepaged = false;
-	cc->last_target_node = NUMA_NO_NODE;
 
 	mmgrab(mm);
 	lru_add_drain_all();
-- 
Michal Hocko
SUSE Labs
