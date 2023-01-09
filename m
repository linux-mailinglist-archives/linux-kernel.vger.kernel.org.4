Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D1D6631F7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbjAIU4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbjAIUz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:55:26 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7DC85C89
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:28 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n203-20020a2572d4000000b0078f09db9888so10253981ybc.18
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mttq8CcSxh6pk/PDvvqo/9XfYX/awSV+YKJHUec4DWQ=;
        b=EbLgVpiNWauCxYsPhZzluNh8i7Jc9od95XU7q4baD/bZuTFbACugKjaBqwn3ZlwjPK
         DyA2dJROokooe1X9hWF9cqxx7R8dzaLC4TQ2VgG1K6ZzCrV6Cn+bNgWtTm8qKV2EPlQI
         C3EgQy0lx8995KoeqPGehRxKjsY9DJj6pO/ydpCP34y4VCDsA5lFDA9xaQObsm54nagL
         gf/rqX49ePSI64VKn0w7yUB28hwRSupVRZyvn8G3inMqKMvhkMvaFS5iHqspfhqeeQGW
         sJQNxcx4h1OW/3tP5B8wZxgrbXFTXvC0zscvDZLigjE3sBlwiKuCEIrG4zHiBAmIFXhN
         sp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mttq8CcSxh6pk/PDvvqo/9XfYX/awSV+YKJHUec4DWQ=;
        b=5WJWiABhMZgyLmuOtlK7476/RvLzIHRadz5DxklX2oNNchRgDf7QOrcl0lXIaZM+rR
         7O24E38Nz2hBt7D+DiRjiCO+1yiKZDKuzWP9ukYeejYHZajSfiHQdDsKU8TQBEZ7HgBW
         apwQwp1VnW7eRKAGg1XNscCrG+AOmXQ42AcJdYvIY9V3HaTX4krx165n1zmvN8git6eq
         vwP0VngLOFBFdeyl/QJoXnzPX8m2iTucptrA4TyGz1N1XqzBYAQa+P6m8WYVw1UiGhzC
         Ux0N6YN/hxCCgIYmHF8jyTxndRI/dpTieLuhPMg1EOjQsk/qNRfHvp4BeeJkx2l1Im3e
         pfsQ==
X-Gm-Message-State: AFqh2kr+c5dm96RGEXRTWU5v36UFKfwg817i4Mzjp6MmS1mYFm3LGt0a
        vXuLccAOiUf8JRBm3tkW8mzcDf/sL3Q=
X-Google-Smtp-Source: AMrXdXsB8fbMiTP1DYP5J5XEU88bTBTK0YYISNp2DJzOoqciXF/+cmYxWMxqmdOzbjRBqH/+xJjk8vQehVo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a25:850e:0:b0:6f8:42d8:2507 with SMTP id
 w14-20020a25850e000000b006f842d82507mr8097864ybk.110.1673297667509; Mon, 09
 Jan 2023 12:54:27 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:13 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-19-surenb@google.com>
Subject: [PATCH 18/41] mm/khugepaged: write-lock VMA while collapsing a huge page
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Protect VMA from concurrent page fault handler while collapsing a huge
page. Page fault handler needs a stable PMD to use PTL and relies on
per-VMA lock to prevent concurrent PMD changes. pmdp_collapse_flush(),
set_huge_pmd() and collapse_and_free_pmd() can modify a PMD, which will
not be detected by a page fault handler without proper locking.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/khugepaged.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5376246a3052..d8d0647f0c2c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1032,6 +1032,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 
+	vma_write_lock(vma);
 	anon_vma_lock_write(vma->anon_vma);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, NULL, mm,
@@ -1503,6 +1504,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		goto drop_hpage;
 	}
 
+	/* Lock the vma before taking i_mmap and page table locks */
+	vma_write_lock(vma);
+
 	/*
 	 * We need to lock the mapping so that from here on, only GUP-fast and
 	 * hardware page walks can access the parts of the page tables that
@@ -1690,6 +1694,7 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
 				result = SCAN_PTE_UFFD_WP;
 				goto unlock_next;
 			}
+			vma_write_lock(vma);
 			collapse_and_free_pmd(mm, vma, addr, pmd);
 			if (!cc->is_khugepaged && is_target)
 				result = set_huge_pmd(vma, addr, pmd, hpage);
-- 
2.39.0

