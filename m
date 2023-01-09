Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AA666320E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbjAIU6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbjAIU5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:57:33 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE388CD2F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:57 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i10-20020a25f20a000000b006ea4f43c0ddso10382006ybe.21
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0pkQpuFsTWto6vflu1WV/u0ieoG+9lWN639GtltEg4c=;
        b=aWg1ukrhEhZM2G7oua95ritICYN4v22wUCcY0gEG4tVylqBmv829owF41k3CxkyAaw
         SuqbgaxpvQ3jo7YPBWRSVqYiX7AqAmWKt0XHBKUG5SuIsHysEKVzXAcfr0KHgTcUUWfl
         b8z+Kg1PDae7rSd6mmxN8sCBWlq1F+xCCZRkBLC5iLo/l2X3T6+e58rjDwLcesFby2PU
         TDwKsOLIZU7rmZo8L2TvumA953Nmin0x2oWW50UYSkBp0m/8PkZaL+q137UQ5Jg9l0HG
         VtNsJ9z3uJiIVmCVloCQiu4j8+XoGxPmrLqPQDbiOLf/gZJpQPJ4VggKimmoURCteWUt
         n6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0pkQpuFsTWto6vflu1WV/u0ieoG+9lWN639GtltEg4c=;
        b=2HT4VoEXiwo0QYuQkXrTDpl/bb2eimY0w7iMhMm9DglDMINTpIYeZOWRIFPiF1TAkJ
         weqWHKUwYGwXPgZOAss/EF7A0MELQop6m4azBueeAPr5oftgkP+B+qNr16v3JkU+FV4Z
         Vb8H786bUMn9zrs6FZTNgjBxJ5codPuupPgBIRG4Su7lyG78nYt+unUPVhGETd4FF5Id
         nWWMEk5eRPia+ie0mfMeCdmfPziMD730pujw3AdmajEOcyVnG0X26l2VM0YKWLQGyhXE
         4c2EGYHuf8XPa4V8v0Nm4e59y2hO5zBr/yfH/XaZZZdZ4imy58kR59fdwdIcPcYsXMVS
         2Tqw==
X-Gm-Message-State: AFqh2krA/Vbl0eQCTe8QqhVwmmu8JAwTDZF48pxtRLw5fUAHk+yys7wE
        ptVDKbgJNgyuqSeui3esFbZ9E51Esu0=
X-Google-Smtp-Source: AMrXdXvMFgW5AuRJO7w2AGyv4a3g+CMQq4rAqpoqS9oQdpJUn0mmZFftW7BbnOBV6/f8EJVvUFaCfl4rQG0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a81:e93:0:b0:3d6:233b:7292 with SMTP id
 141-20020a810e93000000b003d6233b7292mr1998513ywo.476.1673297689205; Mon, 09
 Jan 2023 12:54:49 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:22 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-28-surenb@google.com>
Subject: [PATCH 27/41] mm/mmap: prevent pagefault handler from racing with
 mmu_notifier registration
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

Page fault handlers might need to fire MMU notifications while a new
notifier is being registered. Modify mm_take_all_locks to write-lock all
VMAs and prevent this race with fault handlers that would hold VMA locks.
VMAs are locked before i_mmap_rwsem and anon_vma to keep the same
locking order as in page fault handlers.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 30c7d1c5206e..a256deca0bc0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3566,6 +3566,7 @@ static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
  * of mm/rmap.c:
  *   - all hugetlbfs_i_mmap_rwsem_key locks (aka mapping->i_mmap_rwsem for
  *     hugetlb mapping);
+ *   - all vmas marked locked
  *   - all i_mmap_rwsem locks;
  *   - all anon_vma->rwseml
  *
@@ -3591,6 +3592,7 @@ int mm_take_all_locks(struct mm_struct *mm)
 	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
+		vma_write_lock(vma);
 		if (vma->vm_file && vma->vm_file->f_mapping &&
 				is_vm_hugetlb_page(vma))
 			vm_lock_mapping(mm, vma->vm_file->f_mapping);
@@ -3677,6 +3679,7 @@ void mm_drop_all_locks(struct mm_struct *mm)
 		if (vma->vm_file && vma->vm_file->f_mapping)
 			vm_unlock_mapping(vma->vm_file->f_mapping);
 	}
+	vma_write_unlock_mm(mm);
 
 	mutex_unlock(&mm_all_locks_mutex);
 }
-- 
2.39.0

