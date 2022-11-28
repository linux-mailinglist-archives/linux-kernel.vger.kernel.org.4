Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8549163B108
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiK1STj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiK1SSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:18:55 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82933391CC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:03:11 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5so9111604wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l98v59BwmjV3ozOfAPw93XrEkUrol6K2zteQO/pxMQA=;
        b=e/bGIA0HwGB+g6h3LY4eVczqCQQA7q3lac86AA8ayrG5RmwDmE42BKfG03HoYIQKsz
         fMIN5YuLApIg7+jeOJkwev91+mwmAodAoBnqKNmf+ZyiCiDkOu2GYqHqzKzhbJWp/ecI
         vWsg6LX5RDFYedCD530UHz52LBU5F7BC2+HnuTEORVeZrSQlOPbK4fD7O+EJmC+ChSqT
         4/QrQNGQYxmjFVHe4CjMFUxzDdcOEnJOVqPakZboLMtfqHUntjEYD8GQnRWIeBPl84lH
         7h9OmgR2dU+cq7dQy/wrZmcmqRNiPwgNox6e/naAqPQyFZei0ecGmQ4QHiMSLPBUWKVm
         BCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l98v59BwmjV3ozOfAPw93XrEkUrol6K2zteQO/pxMQA=;
        b=GDyfVLrVqxvFqEOrZfFzBGo4M0lvRRcdLqeyHLhQoIxKXFOAiHaBTRXu5u5zZHyOyi
         LHnILqOEhP/MtnNQRCN+kb+KY7MQkG8rT42MhjFGSi0hRpiVrBNXJ+M+4SZV+3QwiOfk
         M0DyAkBTPxed+hFPEeVXOAoHqzpier1xldf6YhneNvL6heDkiV72vhHSsKSeaePUcW9J
         z9P2sqp7PocFtIZCIH6QrZyaXWUy42wBlXELWe4yrdqJmqkkVR4aacTO6epuT1y8uE6j
         hvZEYnllbKrxWxePNrJnzuO/cuwkEqeQSnu5icSQSbsi7Sm0mo+uC68uzt6UW0Esiqhk
         RaIw==
X-Gm-Message-State: ANoB5pmrvU8l5lzUJzfelhoV5qH/1rxFVQHJIY1TH226oVC2ZcAdn4HU
        x3PIj/Cu+39U6rS7nMJQyVhL3g==
X-Google-Smtp-Source: AA0mqf5bPnlo2nRCz9Eyg7DCrG+Pr9DR0sbrCKNNE0RnhBm/HPey1JfsWRdDN/GOXPZxYrMjEe4RKA==
X-Received: by 2002:a05:600c:4fd0:b0:3cf:70a0:f689 with SMTP id o16-20020a05600c4fd000b003cf70a0f689mr43238540wmq.161.1669658589915;
        Mon, 28 Nov 2022 10:03:09 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:f4d1:b340:8675:e840])
        by smtp.gmail.com with ESMTPSA id d8-20020a5d6dc8000000b002415dd45320sm11359859wrz.112.2022.11.28.10.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 10:03:09 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     security@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v4 3/3] mm/khugepaged: Invoke MMU notifiers in shmem/file collapse paths
Date:   Mon, 28 Nov 2022 19:02:52 +0100
Message-Id: <20221128180252.1684965-3-jannh@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221128180252.1684965-1-jannh@google.com>
References: <20221128180252.1684965-1-jannh@google.com>
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
v4: no changes

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

