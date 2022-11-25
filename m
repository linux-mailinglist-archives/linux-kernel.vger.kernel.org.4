Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39548639125
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiKYVhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiKYVhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:37:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7512FC745
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:37:48 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q7so7627492wrr.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOnwsTARUoatlgwSRumO8KX+asIUrP0Tz9G19w9mrYE=;
        b=F18wqhUOYlIX6J6ZsQFtBJSCT9eGiwguPQmjVFDZS7DKaV/hKfBW3zmQdVbyWmz0uh
         1qn6FwsVbEYLb+xyfH7ZZDkMM6uZzqnljapoiX58tD5RA3MCm3fzaxHGzkfPd3KCl72H
         eLo3OgIuOrR6ZHT0e5Vs6f3N7tbNhtobUBQo7V1CM1IAM8bmN6iM8aOJPykUrX6giarR
         xd4kwOdZ+Eq1KakuVhnZd5qSnVHmGaIw7gDT+yJUNeydDyPLcBSlzYbaId82H7eBHzlc
         fn5z8Iu3LtcKkbFACMjoo5wH0GZrIpPMcDx6MXGiwHzlNQBftGPREzMGphe0eLA01xqh
         4L7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOnwsTARUoatlgwSRumO8KX+asIUrP0Tz9G19w9mrYE=;
        b=B1q7HXoj8ohQVxaNwv3QcBQD+c3V8mVl3OkRUvoPe4lcaLqUxPFX/KuVnSWvKZjAKD
         q+SByo2z2qt6Azw2uK9aIqYcxsCVQ9oAlqRoisQZhTwyZl59NikqSdSicr6yj1JAFEgf
         /FJi8IuntgC4PrsXxDnqxUVNvxE9Dm7jvb8tlCyp/W9cVGfLhXhjykrRuTahqKtr73Wx
         QQf2Pl6UNC8U1w/frIm5b/lBIa6uPezmozjQMnV1yGhmAHqAw8U+KGr2OBepnFWePzGG
         Cqvpev+Sh6Kutw/xY+hSNazbhlAPkTm70H+claP9N7n1jDRHuyAENqj9kz8JgRfOLrYe
         Br0w==
X-Gm-Message-State: ANoB5plctGCZoPmWZ+SvAE23htHysZ03ndv7SlsF1NX1phDSPuCNHXY6
        4NiNT8trBI0NUKdd7SWnoXFpxQ==
X-Google-Smtp-Source: AA0mqf7a8Vcy4n5comCXosZv/VZNsAUlq9hK2P6zFM9IR6J9bTMU0oSmYK5q5Wf0ZQYoI23b3wkX4Q==
X-Received: by 2002:a5d:6f02:0:b0:241:fdb5:50f7 with SMTP id ay2-20020a5d6f02000000b00241fdb550f7mr6563623wrb.170.1669412266904;
        Fri, 25 Nov 2022 13:37:46 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:9104:e316:5846:858e])
        by smtp.gmail.com with ESMTPSA id z6-20020adfe546000000b0023655e51c33sm4675291wrm.4.2022.11.25.13.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 13:37:46 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     security@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 3/3] mm/khugepaged: Invoke MMU notifiers in shmem/file collapse paths
Date:   Fri, 25 Nov 2022 22:37:14 +0100
Message-Id: <20221125213714.4115729-3-jannh@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221125213714.4115729-1-jannh@google.com>
References: <20221125213714.4115729-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any codepath that zaps page table entries must invoke MMU notifiers to
ensure that secondary MMUs (like KVM) don't keep accessing pages which
aren't mapped anymore. Secondary MMUs don't hold their own references to
pages that are mirrored over, so failing to notify them can lead to page
use-after-free.

I'm marking this as addressing an issue introduced in commit f3f0e1d2150b
("khugepaged: add support of collapse for tmpfs/shmem pages"), but most of
the security impact of this only came in commit 27e1f8273113 ("khugepaged:
enable collapse pmd for pte-mapped THP"), which actually omitted flushes
for the removal of present PTEs, not just for the removal of empty page
tables.

Cc: stable@kernel.org
Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/khugepaged.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index c3d3ce596bff7..49eb4b4981d88 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1404,6 +1404,7 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
 				  unsigned long addr, pmd_t *pmdp)
 {
 	pmd_t pmd;
+	struct mmu_notifier_range range;
 
 	mmap_assert_write_locked(mm);
 	if (vma->vm_file)
@@ -1415,8 +1416,12 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
 	if (vma->anon_vma)
 		lockdep_assert_held_write(&vma->anon_vma->root->rwsem);
 
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, NULL, mm, addr,
+				addr + HPAGE_PMD_SIZE);
+	mmu_notifier_invalidate_range_start(&range);
 	pmd = pmdp_collapse_flush(vma, addr, pmdp);
 	tlb_remove_table_sync_one();
+	mmu_notifier_invalidate_range_end(&range);
 	mm_dec_nr_ptes(mm);
 	page_table_check_pte_clear_range(mm, addr, pmd);
 	pte_free(mm, pmd_pgtable(pmd));
-- 
2.38.1.584.g0f3c55d4c2-goog

