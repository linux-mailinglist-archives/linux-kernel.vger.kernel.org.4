Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7376A4841
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjB0Rih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjB0RiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:38:00 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F79241CB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:31 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id v24-20020a631518000000b00502e6bfe335so2167605pgl.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2RRQaU516ZwpTlJ/IPA+DGjHt1op6pQWjJsnPIcYfuA=;
        b=oOzu68rhqFvQUE3xPXRgC65GI9mEeLvvYxOtiIzpOqVj22Kyf5G6v2nWjVGklLxMvP
         HmGHsiBCF1KS106jCim6ns3MdM+isHFIB2cW4BN/lGs8dwWcRP4ETfa+ag2t0c8ooDBq
         IbM6nmgazseNTIyYCuuyg4z6GzI60o3WZCSdFyA+NgXZEZsvKFhXlvHjg7yVejPrN9tm
         lKdZz9wSXLCbvII2MlT1JIIh3E3Pzy0qhZRWTGIGZxssznyrIga0ZMQq7hZXO4CZPVOT
         3YmHDK/l7fYrKAyqOPLY4x/QliUuYuXk7UtTVeDvzP6SJegWWyEijbowKlqNMovXBpqB
         mtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RRQaU516ZwpTlJ/IPA+DGjHt1op6pQWjJsnPIcYfuA=;
        b=jcU6H5mVSyO3ErOUDb6RS6eVDqxmZDyby8xcukn3AZWCc5lDopn2+6AG55heeopR6B
         FdsqudeO5vpMMg8MZxDE+cW0tSZRkmNxpoB2YGb7r1kP9V3H05tm6CYFhy8wkgLgC5FI
         JnNyGKx6GYPUlh2XDqHb/vihKKJ5JcLlTUyBISmiyb0LHD3xzt879Si0jutstz0u69Qe
         F9IJs3EurM4/r42P+eq2pdPcXAgym3Edgcc6O6fDm921m9oT0A/xGoqhXSs3mhb/wfj2
         +IDgC2dCTiOBt+oEG52se0GKMsWje2Vn5UoHCqY3C6gIX6yGoMTpvOuyRkeHk+B4Uivy
         +01Q==
X-Gm-Message-State: AO0yUKWii97jrWm1f5Cs2U5euQeg++2nAqqn17NUdC24PvT9qulkgIaJ
        jHwZznYjGhIPSAUhICyZfn2A4VZ7ai0=
X-Google-Smtp-Source: AK7set/2J8KUumsEZ/0orhhZ+Y6s/zP6QMsk4a+yqlkwHuIWJVWfr/HftGogZhR0NE5sVdiuRfgOT6Lze5Y=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a62:8387:0:b0:593:974c:cba7 with SMTP id
 h129-20020a628387000000b00593974ccba7mr6413186pfe.5.1677519446727; Mon, 27
 Feb 2023 09:37:26 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:20 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-22-surenb@google.com>
Subject: [PATCH v4 21/33] mm/mmap: prevent pagefault handler from racing with
 mmu_notifier registration
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Suren Baghdasaryan <surenb@google.com>
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

Page fault handlers might need to fire MMU notifications while a new
notifier is being registered. Modify mm_take_all_locks to write-lock all
VMAs and prevent this race with page fault handlers that would hold VMA
locks. VMAs are locked before i_mmap_rwsem and anon_vma to keep the same
locking order as in page fault handlers.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index ec745586785c..b947d82e8522 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3486,6 +3486,7 @@ static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
  * of mm/rmap.c:
  *   - all hugetlbfs_i_mmap_rwsem_key locks (aka mapping->i_mmap_rwsem for
  *     hugetlb mapping);
+ *   - all vmas marked locked
  *   - all i_mmap_rwsem locks;
  *   - all anon_vma->rwseml
  *
@@ -3508,6 +3509,13 @@ int mm_take_all_locks(struct mm_struct *mm)
 
 	mutex_lock(&mm_all_locks_mutex);
 
+	mas_for_each(&mas, vma, ULONG_MAX) {
+		if (signal_pending(current))
+			goto out_unlock;
+		vma_start_write(vma);
+	}
+
+	mas_set(&mas, 0);
 	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
@@ -3597,6 +3605,7 @@ void mm_drop_all_locks(struct mm_struct *mm)
 		if (vma->vm_file && vma->vm_file->f_mapping)
 			vm_unlock_mapping(vma->vm_file->f_mapping);
 	}
+	vma_end_write_all(mm);
 
 	mutex_unlock(&mm_all_locks_mutex);
 }
-- 
2.39.2.722.g9855ee24e9-goog

