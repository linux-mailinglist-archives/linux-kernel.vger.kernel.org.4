Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1935866320B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbjAIU54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237750AbjAIU53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:57:29 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939FA8CBFE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:55 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p15-20020a170902a40f00b00192b2bbb7f8so7044568plq.14
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7MiPLggwHMt078/i5i4Bbk0h7mxL/B1TX4Loq0bJkA=;
        b=k/y/f651ouIVm5VYXSBuN3WGA3r0siHAwbforN7cl7XldyaXSobuMoKnfRbHsUp2Zw
         mT4Fy24gz9zLv4V1qPdlGMDZmt4uQYDL7SMguN64hvgl+OPwnYaemI3hYYgdYfqYy2ZE
         RZpsDEbxomOp03K+XTMpAlOj5/FuHalix+oD7gvliXvyOvoSifjWwtoSfq337yDgZBWx
         NsM/wn5sH1zgbh2ZxdX6VDsXj4dH/jKa39D017jsbV+IQ14YXnxgSRRt8KTb8ppwgMfm
         uVAI77HN37Vy1v+4HMEL/4fAI+3c+Ki/ub6d+F+N4Xj5NK0ZJDRKlJXLfRFrsnczSTJ7
         ObUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7MiPLggwHMt078/i5i4Bbk0h7mxL/B1TX4Loq0bJkA=;
        b=LIku4FFdTFF6ymPF/7eEdvuaGF8VODd4zef9wPwsWVyN7n+ez8iX7vNQ4cRwj49n/k
         S9dhCO6YwLOlSl1OEg4pAFziyAGRcTBpnFllDmX5QNp/mlXXXCP30MZgibaroBbzgQTx
         JxrScvPbZ0FfPgc3yiF+5qF2IMLi9B8AV5IV5gitb0sWbt5L71vFek5fhEQy4iPKiWy3
         bVVIRm6BMeY9Yq2PUP/uFJtp1oaz5yNFwNPcT1h4xgDVDnjVMVQfLlr5o6E9EyX8THpV
         bUVE1aTY/VpxvbmnKhYJaKl+lHR/WkiTheus8dYDk76RlgCPWPbYrKyKV77VbA6WSlr0
         pGMw==
X-Gm-Message-State: AFqh2kqEEjVZrY1eS4yk6w+QgWCxkZDLDq4JdXtn1x1wUPKKsbZv0E5E
        yhRxaQFOEi28pTpvRUGJUgqfZyJKbhM=
X-Google-Smtp-Source: AMrXdXscxn+TZfW1mPWgpj2/8Haqh4tY58OgT8gYBU0unalxDUYH6+O0E4BOyMrkarY33KKQg8fQ3JxSbTo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a17:902:8e88:b0:190:becc:7e76 with SMTP id
 bg8-20020a1709028e8800b00190becc7e76mr6134633plb.1.1673297686693; Mon, 09 Jan
 2023 12:54:46 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:21 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-27-surenb@google.com>
Subject: [PATCH 26/41] kernel/fork: assert no VMA readers during its destruction
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

Assert there are no holders of VMA lock for reading when it is about to be
destroyed.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h | 8 ++++++++
 kernel/fork.c      | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 594e835bad9c..c464fc8a514c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -680,6 +680,13 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 	VM_BUG_ON_VMA(vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq), vma);
 }
 
+static inline void vma_assert_no_reader(struct vm_area_struct *vma)
+{
+	VM_BUG_ON_VMA(rwsem_is_locked(&vma->lock) &&
+		      vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq),
+		      vma);
+}
+
 #else /* CONFIG_PER_VMA_LOCK */
 
 static inline void vma_init_lock(struct vm_area_struct *vma) {}
@@ -688,6 +695,7 @@ static inline bool vma_read_trylock(struct vm_area_struct *vma)
 		{ return false; }
 static inline void vma_read_unlock(struct vm_area_struct *vma) {}
 static inline void vma_assert_write_locked(struct vm_area_struct *vma) {}
+static inline void vma_assert_no_reader(struct vm_area_struct *vma) {}
 
 #endif /* CONFIG_PER_VMA_LOCK */
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 1591dd8a0745..6d9f14e55ecf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -485,6 +485,8 @@ static void __vm_area_free(struct rcu_head *head)
 {
 	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
 						  vm_rcu);
+	/* The vma should either have no lock holders or be write-locked. */
+	vma_assert_no_reader(vma);
 	kmem_cache_free(vm_area_cachep, vma);
 }
 #endif
-- 
2.39.0

