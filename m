Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F95A63C41E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbiK2PsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbiK2Pr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:47:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FFC5F42
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:47:49 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id x17so22742639wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSdw+42zFeQjk2DGkc/5JCpwWvHgOHoXpertIATsPMg=;
        b=kyY6Gy0JKC+0AUgiybPvuNjn+SU6DV8iudSjb8b55zB8kB4CqhVidPvZfk6mww3B8n
         6tPPi7aTD28MO7gKzrHO+ZFZTkMmX5YCdYvsqIG/OXyXs9ykyLPP5wRNXHSRX0t6RVsh
         IZX4qH8FwqDWynlcIRmrySVkQJImf/gX52fCnR1vlGWe2x9tFDFP0yt7ZfZIHsBm6j36
         kYSmD90/AkP2Qg+2MXUuwV1NFk3p2dA+7dZpdiWsjPuLXQCQpLBU6xTlqxUMgxjOTIMH
         /nQkV9fl8zI6rpYGdiluQ5g7ciMaMfjc9nt2qlBPLrhiHOj/rqFidysvQv8pXgIoMM3b
         SNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSdw+42zFeQjk2DGkc/5JCpwWvHgOHoXpertIATsPMg=;
        b=O5k9gBUM+S7uiSiqTn1iH78+joylTFyzFVgYr5M6U79Gf7eZei1hNMJ7lJSjpy21+4
         SC8tVwOFtt8jw0ZaCst+gQsSVB2ncdL4CnkQy2JenRuxKXihuJ0T07T+ON1evWBbhBw1
         abj1MrPKlFtiKqMqsqN0oXG8KnFXAVpzGfZiRuypJjvi/UJleQYJe1J33czTuWhclOus
         vRN8ml8qdJjoOJzgt0+hzpNwdlhjxu/ixcbxrzrb3g74HzAjVblD9bdKKgk+ROUXHGOt
         B2ib+vhek+LKobwNSDkVPig5pN7oxcK89z1ZTB9uxcA9DaRgjkFRrweqTIm71R6Q5q7I
         qsiQ==
X-Gm-Message-State: ANoB5pmSr4sRGsHwAF02GxBmVsOZXm5C/VjibwfK7CBVSWsQrC1dnFPU
        UNnR18EwonFCVFox34pqpg1a7Q==
X-Google-Smtp-Source: AA0mqf4wfVRsEWf9AFOdhAoE+E+wRnIO6UPQlwSQr5h7WZkHCgo4KnQbZUBu1EEsJEC13nvpyrb1bg==
X-Received: by 2002:a5d:5709:0:b0:241:d71c:5dde with SMTP id a9-20020a5d5709000000b00241d71c5ddemr27080262wrv.678.1669736867789;
        Tue, 29 Nov 2022 07:47:47 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:5011:adcc:fddd:accf])
        by smtp.gmail.com with ESMTPSA id x9-20020a5d6b49000000b002366e3f1497sm14090560wrw.6.2022.11.29.07.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 07:47:47 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     security@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v5 3/3] mm/khugepaged: Invoke MMU notifiers in shmem/file collapse paths
Date:   Tue, 29 Nov 2022 16:47:30 +0100
Message-Id: <20221129154730.2274278-3-jannh@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221129154730.2274278-1-jannh@google.com>
References: <20221129154730.2274278-1-jannh@google.com>
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
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Signed-off-by: Jann Horn <jannh@google.com>
---

Notes:
    v4: no changes
    v5:
     - added ack and reviewed-by

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

