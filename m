Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC0F720C2E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 01:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbjFBXHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 19:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbjFBXGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 19:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF67E43
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 16:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685747168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g6wkyDZjE3AkPJxDBxHTBEFEzJVoOQ4nWaImAmEi0sc=;
        b=aqePeWpru3LXVdZKoBm87b0ERXzgXoP2A5VtWC0+DDPI3ApDEKF8XXU5BKQQhsmhF0l1oJ
        JxJwAHlejvvK8zdVSJf697LOdmzoUx/NbPX7YLdpq0Ae3JFIDuCeChxAm5MXv36xoeXB2S
        KY9Mg4bhfO/Hcrq0ZeZans2DCd0rh5c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-HxqvD66iMJSIa2WdzzSNMQ-1; Fri, 02 Jun 2023 19:06:07 -0400
X-MC-Unique: HxqvD66iMJSIa2WdzzSNMQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-626204b0663so5584996d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 16:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685747166; x=1688339166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6wkyDZjE3AkPJxDBxHTBEFEzJVoOQ4nWaImAmEi0sc=;
        b=WgOEWhzRJErbvF+MbNB2WT10QGVg9s6JbN/0y8Lq0Mzl6MoBqdHmlwdjloNRAai/GT
         LvAZKPt//RcpG2KtvhmDeKynbedzxpZQLnxfxNCGkezCnRI4N8i7uZ056eTDH2HM4v2k
         y++Jl4qfGzmBRUkzTAiaibdJ5AnnSVBOJf8CjKyS3qZqpGeWCMs8rgbesftsqJTks516
         mMrg/0WaI3/HDK9amjJz9D7ZeWtx1iTkKh/uNe4GsZhU0hADOKlILRtTkvoFH9UPNCaa
         pkOfNasj+OJcVn9AxGDRy3F/GhrQPtYI5SmSZ6oUh3WJXg7cFEHADLAN0YQJh6XFPL/L
         FtKQ==
X-Gm-Message-State: AC+VfDzNoJ1m0dSkCscJEfAsTuuUGiTDSL6vmoA6nfXON3Y2Q+gtD3Id
        ktg1XaAc9AhKNVWb6P7NASen6NJtsqfn5cK/CWQK3gXUWRpwgiuJ7nRD5qMAr3qOhLhRW3Lxito
        vLpBdgyKgptwYj9CpSfrmRcdryXJTiWmGwHXqdf4RWh6Zzg5J1DapsQB+vpeXeBn78R1yEdUH0v
        8GHnLOVA==
X-Received: by 2002:a05:6214:5182:b0:625:aa49:c182 with SMTP id kl2-20020a056214518200b00625aa49c182mr11538756qvb.6.1685747166301;
        Fri, 02 Jun 2023 16:06:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5inHsA1r7fWdyWc5XKfTSPD/IdY8jLR96FRCb15whPmG7ALRLYp3r+GW9iNxru7TlNqwqvFQ==
X-Received: by 2002:a05:6214:5182:b0:625:aa49:c182 with SMTP id kl2-20020a056214518200b00625aa49c182mr11538709qvb.6.1685747165861;
        Fri, 02 Jun 2023 16:06:05 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id px13-20020a056214050d00b0062607ea6d01sm1400792qvb.50.2023.06.02.16.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 16:06:04 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>, peterx@redhat.com,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH 4/4] mm: Make most walk page paths with pmd_trans_unstable() to retry
Date:   Fri,  2 Jun 2023 19:05:52 -0400
Message-Id: <20230602230552.350731-5-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602230552.350731-1-peterx@redhat.com>
References: <20230602230552.350731-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For most of the page walk paths, logically it'll always be good to have the
pmd retries if hit pmd_trans_unstable() race.  We can treat it as none
pmd (per comment above pmd_trans_unstable()), but in most cases we're not
even treating that as a none pmd.  If to fix it anyway, a retry will be the
most accurate.

I've went over all the pmd_trans_unstable() special cases and this patch
should cover all the rest places where we should retry properly with
unstable pmd.  With the newly introduced ACTION_AGAIN since 2020 we can
easily achieve that.

These are the call sites that I think should be fixed with it:

*** fs/proc/task_mmu.c:
smaps_pte_range[634]           if (pmd_trans_unstable(pmd))
clear_refs_pte_range[1194]     if (pmd_trans_unstable(pmd))
pagemap_pmd_range[1542]        if (pmd_trans_unstable(pmdp))
gather_pte_stats[1891]         if (pmd_trans_unstable(pmd))
*** mm/memcontrol.c:
mem_cgroup_count_precharge_pte_range[6024] if (pmd_trans_unstable(pmd))
mem_cgroup_move_charge_pte_range[6244] if (pmd_trans_unstable(pmd))
*** mm/memory-failure.c:
hwpoison_pte_range[794]        if (pmd_trans_unstable(pmdp))
*** mm/mempolicy.c:
queue_folios_pte_range[517]    if (pmd_trans_unstable(pmd))
*** mm/madvise.c:
madvise_cold_or_pageout_pte_range[425] if (pmd_trans_unstable(pmd))
madvise_free_pte_range[625]    if (pmd_trans_unstable(pmd))

IIUC most of them may or may not be a big issue even without a retry,
either because they're already not strict (smaps, pte_stats, MADV_COLD,
.. it can mean e.g. the statistic may be inaccurate or one less 2M chunk to
cold worst case), but some of them could have functional error without the
retry afaiu (e.g. pagemap, where we can have the output buffer shifted over
the unstable pmd range.. so IIUC the pagemap result can be wrong).

While these call sites all look fine, and don't need any change:

*** include/linux/pgtable.h:
pmd_devmap_trans_unstable[1418] return pmd_devmap(*pmd) || pmd_trans_unstable(pmd);
*** mm/gup.c:
follow_pmd_mask[695]           if (pmd_trans_unstable(pmd))
*** mm/mapping_dirty_helpers.c:
wp_clean_pmd_entry[131]        if (!pmd_trans_unstable(&pmdval))
*** mm/memory.c:
do_anonymous_page[4060]        if (unlikely(pmd_trans_unstable(vmf->pmd)))
*** mm/migrate_device.c:
migrate_vma_insert_page[616]   if (unlikely(pmd_trans_unstable(pmdp)))
*** mm/mincore.c:
mincore_pte_range[116]         if (pmd_trans_unstable(pmd)) {

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/proc/task_mmu.c  | 17 +++++++++++++----
 mm/madvise.c        |  8 ++++++--
 mm/memcontrol.c     |  8 ++++++--
 mm/memory-failure.c |  4 +++-
 mm/mempolicy.c      |  4 +++-
 5 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6259dd432eeb..823eaba5c6bf 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -631,8 +631,11 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		goto out;
 	}
 
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(pmd)) {
+		walk->action = ACTION_AGAIN;
 		goto out;
+	}
+
 	/*
 	 * The mmap_lock held all the way back in m_start() is what
 	 * keeps khugepaged out of here and from collapsing things
@@ -1191,8 +1194,10 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		return 0;
 	}
 
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(pmd)) {
+		walk->action = ACTION_AGAIN;
 		return 0;
+	}
 
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
@@ -1539,8 +1544,10 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		return err;
 	}
 
-	if (pmd_trans_unstable(pmdp))
+	if (pmd_trans_unstable(pmdp)) {
+		walk->action = ACTION_AGAIN;
 		return 0;
+	}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 	/*
@@ -1888,8 +1895,10 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 		return 0;
 	}
 
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(pmd)) {
+		walk->action = ACTION_AGAIN;
 		return 0;
+	}
 #endif
 	orig_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	do {
diff --git a/mm/madvise.c b/mm/madvise.c
index 78cd12581628..0fd81712022c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -424,8 +424,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	}
 
 regular_folio:
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(pmd)) {
+		walk->action = ACTION_AGAIN;
 		return 0;
+	}
 #endif
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
@@ -626,8 +628,10 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		if (madvise_free_huge_pmd(tlb, vma, pmd, addr, next))
 			goto next;
 
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(pmd)) {
+		walk->action = ACTION_AGAIN;
 		return 0;
+	}
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6ee433be4c3b..15e50f033e41 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6021,8 +6021,10 @@ static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
 		return 0;
 	}
 
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(pmd)) {
+		walk->action = ACTION_AGAIN;
 		return 0;
+	}
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE)
 		if (get_mctgt_type(vma, addr, *pte, NULL))
@@ -6241,8 +6243,10 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 		return 0;
 	}
 
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(pmd)) {
+		walk->action = ACTION_AGAIN;
 		return 0;
+	}
 retry:
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	for (; addr != end; addr += PAGE_SIZE) {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 004a02f44271..c97fb2b7ab4a 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -791,8 +791,10 @@ static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
 		goto out;
 	}
 
-	if (pmd_trans_unstable(pmdp))
+	if (pmd_trans_unstable(pmdp)) {
+		walk->action = ACTION_AGAIN;
 		goto out;
+	}
 
 	mapped_pte = ptep = pte_offset_map_lock(walk->vma->vm_mm, pmdp,
 						addr, &ptl);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f06ca8c18e62..af8907b4aad1 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -514,8 +514,10 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 	if (ptl)
 		return queue_folios_pmd(pmd, ptl, addr, end, walk);
 
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(pmd)) {
+		walk->action = ACTION_AGAIN;
 		return 0;
+	}
 
 	mapped_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
-- 
2.40.1

