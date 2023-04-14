Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E153C6E29BA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjDNRyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDNRyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:54:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F29210C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:54:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54fbb2ee579so64040757b3.14
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681494888; x=1684086888;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sxtuJlZyuhJWBSe3BUp1o+R468Jyg7wjt5EQDKL8liw=;
        b=g9SpJgATsQDIYrkaPJd8d+PpBLT6jxYfne0OaHPIARm2IOQH+5ZUzrk668RVIdTFIK
         sxOkrjHFb2IwJhV+Rhhqr+Ms2OhPNi3AodJ+9OY+2GG2/dSng1wTYMa57UFr7FfZAVxI
         Mjh/iCg/xVEVvZMZlFypxHv6CoV31SltYbDHcAJCNrxBVXuHnfWdWgPZy7WTw1rRq2XX
         TXhZzJwJ3E/Ie4KgOXvM9CGQPa5RcER+MZF/7gxO1S4H4wu9t0bNr4IGAKdJ6Cqg7aGH
         BaxrJvra46EdXACNO7xHjaZO0BZXtOmHgL+PMxZE4/oVvLRUiP56FT8IvxbimldOWzpD
         U8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681494888; x=1684086888;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sxtuJlZyuhJWBSe3BUp1o+R468Jyg7wjt5EQDKL8liw=;
        b=a6PAdwh6iKzhaUGvdJsmCMnvJvv/F/B4ciY0hKXWen3QRQ0MOECxeQ172NLcNIDDAs
         NuzYSEJxazm2q/YRkSDoiQ0ivwd57TgBcLVRO/BK/EKeTUfdY3aAjx1gH3IgLx4+/c1P
         ZFhyLrdX/hC3bGmMdfil+0ObFBcNNKcZJ3bW0nRjVD5yZNgcIQAHs1aXEQuRY/1xh7O7
         NOVQEc7CSsmBB03+xiCzGlI1TE1J2VxdnQ1lV+dOd9QGOsG1JZbMVHgyOLrz+u03ZN+y
         C0wEEahKDxYpooSpnfBORTwuwS9JO55VcfQkrhRo3NOjoux1ztn9aBBdiX5fNINQkORb
         EkcA==
X-Gm-Message-State: AAQBX9dQlPl7cbO5uFUM1P5bfN7yydTx0UFza1M4Mpk6a91EIQSo+gQY
        7J0Us05wy0npzhm59IQuXvi0UmzC8dk=
X-Google-Smtp-Source: AKy350avB5MCJ6AGQUDi4bXHuLqjAuOo0YGWC/cK9hfJMcJckV+n+dWeR6kBIWjZnXn/yq9bCXOysK/QEQk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:46c0:7584:f020:e09f])
 (user=surenb job=sendgmr) by 2002:a25:730c:0:b0:b91:b64e:743d with SMTP id
 o12-20020a25730c000000b00b91b64e743dmr1199758ybc.9.1681494888506; Fri, 14 Apr
 2023 10:54:48 -0700 (PDT)
Date:   Fri, 14 Apr 2023 10:54:44 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230414175444.1837474-1-surenb@google.com>
Subject: [PATCH 1/1] mm: do not increment pgfault stats when page fault
 handler retries
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, surenb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the page fault handler requests a retry, we will count the fault
multiple times.  This is a relatively harmless problem as the retry paths
are not often requested, and the only user-visible problem is that the
fault counter will be slightly higher than it should be.  Nevertheless,
userspace only took one fault, and should not see the fact that the
kernel had to retry the fault multiple times.

Fixes: 6b4c9f446981 ("filemap: drop the mmap_sem for all blocking operations")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
Patch applies cleanly over linux-next and mm-unstable

 mm/memory.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1c5b231fe6e3..d88f370eacd1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5212,17 +5212,16 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 
 	__set_current_state(TASK_RUNNING);
 
-	count_vm_event(PGFAULT);
-	count_memcg_event_mm(vma->vm_mm, PGFAULT);
-
 	ret = sanitize_fault_flags(vma, &flags);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 					    flags & FAULT_FLAG_INSTRUCTION,
-					    flags & FAULT_FLAG_REMOTE))
-		return VM_FAULT_SIGSEGV;
+					    flags & FAULT_FLAG_REMOTE)) {
+		ret = VM_FAULT_SIGSEGV;
+		goto out;
+	}
 
 	/*
 	 * Enable the memcg OOM handling for faults triggered in user
@@ -5253,6 +5252,11 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	}
 
 	mm_account_fault(regs, address, flags, ret);
+out:
+	if (!(ret & VM_FAULT_RETRY)) {
+		count_vm_event(PGFAULT);
+		count_memcg_event_mm(vma->vm_mm, PGFAULT);
+	}
 
 	return ret;
 }
-- 
2.40.0.634.g4ca3ef3211-goog

