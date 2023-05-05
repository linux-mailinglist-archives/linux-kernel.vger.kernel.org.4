Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E2E6F88A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjEESec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjEESe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:34:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672801816B
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:34:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0EE963CDA
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D7BC433EF;
        Fri,  5 May 2023 18:34:24 +0000 (UTC)
Date:   Fri, 5 May 2023 19:34:21 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        nd@arm.com, broonie@kernel.org, szabolcs.nagy@arm.com
Subject: Re: [PATCH 3/4] mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
Message-ID: <ZFVMLQHObyP4Na+j@arm.com>
References: <20230504170942.822147-1-revest@chromium.org>
 <20230504170942.822147-4-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504170942.822147-4-revest@chromium.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 07:09:41PM +0200, Florent Revest wrote:
> This extends the current PR_SET_MDWE prctl arg with a bit to indicate
> that the process doesn't want MDWE protection to propagate to children.
> 
> To implement this no-inherit mode, the tag in current->mm->flags must be
> absent from MMF_INIT_MASK. This means that the encoding for "MDWE but
> without inherit" is different in the prctl than in the mm flags. This
> leads to a bit of bit-mangling in the prctl implementation.

That bit mangling is not that bad but it complicates the code a bit,
especially if we'll add new bits in the future. We also need to check
both the original and the no-inherit bits for each feature.

Another question is whether we want to support more fine-grained
inheriting or just a big knob that disables inheriting for all the
(future) MDWE flags.

I think a somewhat simpler way would be to clear the flags on fork(),
either based on a big MMF_HAS_MDWE_NO_INHERIT knob or individual ones.
Something like below (completely untested):

diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 0ee96ea7a0e9..ca83a0c8d19c 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -91,4 +91,12 @@ static inline int get_dumpable(struct mm_struct *mm)
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK)

 #define MMF_VM_MERGE_ANY	29
+
+#define MMF_INIT_FLAGS(flags)	({				\
+	unsigned long new_flags = flags;			\
+	if (new_flags & (1UL << MMF_HAS_MDWE_NO_INHERIT))	\
+		new_flags &= ~(1UL << MMF_HAS_MDWE_MASK);	\
+	new_flags & MMF_INIT_MASK;				\
+})
+
 #endif /* _LINUX_SCHED_COREDUMP_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index ed4e01daccaa..53f0b68a5451 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1288,7 +1288,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	hugetlb_count_init(mm);

 	if (current->mm) {
-		mm->flags = current->mm->flags & MMF_INIT_MASK;
+		mm->flags = MMF_INIT_FLAGS(current->mm->flags);
 		mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
 	} else {
 		mm->flags = default_dump_filter;

The checks in MMF_INIT_FLAGS() can grow in time if we add more bits in
there but we still only keep a single flag that determines whether the
feature is enabled (maybe that's more like bikeshedding at this moment
when we have a single bit).


(fun remark: I see you cc'ed nd@arm.com'; that's not a real person, it's
what our IT folk asked us to add on cc so that the Exchange server
doesn't append the legal disclaimer; most lists are covered already
without such cc but I guess people feel safer to add it, just in case)

-- 
Catalin
