Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7CD5B6B98
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiIMK0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiIMK0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:26:00 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313D55A15C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:25:59 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id z9-20020a17090a468900b00202fdb32ba1so537224pjf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=jlhxEjacrUXFFi1ZtwUhaZWjvyeFcTUPpP6i3fefSGA=;
        b=f8DwEOjF8b59P9liAfzm1E6WgZtwDe9js4oTGS4Vpmdj0dv6wtgIaNVPbhko8S4ijL
         fZGjCd9LO1mZ1YNjsgonSY604Q4j75Dqisn+5r7klOXWiVanIjc2fI/i/B+mqSKWEsvm
         jaBYyeyfN5BrFBhVAz26fwB0jpGQCfDImv7RMImNXl4CmOdzcfL/jVF6kUjetHAtO7tC
         3vnqhoT/FCEY3HMwnlzCUVQw/kFCpOF3720yWSkInrVP6B+LBRHRz17rqVRH2HfVxleP
         JwFYHHR+vojyO9/NPXaU0dOgMuIfVF56AVXtxF+za3I1P18lCdESNTMqkkHgc6tpiGl3
         kSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=jlhxEjacrUXFFi1ZtwUhaZWjvyeFcTUPpP6i3fefSGA=;
        b=LpVHA8ydpzQz+pRqumm/2ruSHj6v8iG5gOVaUXMVBT+b2n+PKzDs0FLY6JS1EIUyHe
         PYLqwxiH/V4D5E2T0YdMhsySHjniA1GZ/3VVrBWMJC+aJBVBWyQHQp6Xd9Ozif8H2B0+
         76y/QlU05dA33GHiKdUJfv/BhVAxLSbussyEEV58Y/Pi4oggdGiQnL7407MGa7kyeNFh
         ZSWjALvcb9CCfCYYcssrpCYyA3OazsrFhy8SOLzqAjP9NvSfnJyDb3oCNJhG0+gjBJzo
         /tWnDN/FWR5Mc7EN3/FhfDE+oklBhTWGYkCbqPVtbHf9pWDxfRGK3ySMb2qP0RfFsvdR
         spNQ==
X-Gm-Message-State: ACgBeo1MatcOG2yi7S38cwVQOf5f3WSeN7ARH4LAf8kuzQmLpooel55j
        Y/qm1rwaSWYg3lTOuohoJDQL7ioMN50=
X-Google-Smtp-Source: AA6agR4tdC6f5JLWMiJU9LqIhVMUHBU74OPe/LWAUhtSbu6hfgNg8El5ogyAuqWknBCQ7INzbCC6BDoeLiw=
X-Received: from avagin.kir.corp.google.com ([2620:15c:29:204:d94b:8d9d:2b23:6608])
 (user=avagin job=sendgmr) by 2002:a63:211c:0:b0:431:af8c:77e4 with SMTP id
 h28-20020a63211c000000b00431af8c77e4mr27727839pgh.614.1663064758784; Tue, 13
 Sep 2022 03:25:58 -0700 (PDT)
Date:   Tue, 13 Sep 2022 03:25:51 -0700
In-Reply-To: <20220913102551.1121611-1-avagin@google.com>
Mime-Version: 1.0
References: <20220913102551.1121611-1-avagin@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913102551.1121611-3-avagin@google.com>
Subject: [PATCH 2/2] Revert "fs/exec: allow to unshare a time namespace on vfork+exec"
From:   Andrei Vagin <avagin@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Alexey Izbyshev <izbyshev@ispras.ru>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>
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

From: Andrei Vagin <avagin@gmail.com>

This reverts commit 133e2d3e81de5d9706cab2dd1d52d231c27382e5.

Alexey pointed out a few undesirable side effects of the reverted change.
First, it doesn't take into account that CLONE_VFORK can be used with
CLONE_THREAD. Second, a child process doesn't enter a target time name-space,
if its parent dies before the child calls exec. It happens because the parent
clears vfork_done.

Eric W. Biederman suggests installing a time namespace as a task gets a new mm.
It includes all new processes cloned without CLONE_VM and all tasks that call
exec(). This is an user API change, but we think there aren't users that depend
on the old behavior.

It is too late to make such changes in this release, so let's roll back
this patch and introduce the right one in the next release.

Cc: Alexey Izbyshev <izbyshev@ispras.ru>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 fs/exec.c        | 7 -------
 kernel/fork.c    | 5 +----
 kernel/nsproxy.c | 3 +--
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 9a5ca7b82bfc..d046dbb9cbd0 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -65,7 +65,6 @@
 #include <linux/io_uring.h>
 #include <linux/syscall_user_dispatch.h>
 #include <linux/coredump.h>
-#include <linux/time_namespace.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -979,12 +978,10 @@ static int exec_mmap(struct mm_struct *mm)
 {
 	struct task_struct *tsk;
 	struct mm_struct *old_mm, *active_mm;
-	bool vfork;
 	int ret;
 
 	/* Notify parent that we're no longer interested in the old VM */
 	tsk = current;
-	vfork = !!tsk->vfork_done;
 	old_mm = current->mm;
 	exec_mm_release(tsk, old_mm);
 	if (old_mm)
@@ -1029,10 +1026,6 @@ static int exec_mmap(struct mm_struct *mm)
 	tsk->mm->vmacache_seqnum = 0;
 	vmacache_flush(tsk);
 	task_unlock(tsk);
-
-	if (vfork)
-		timens_on_fork(tsk->nsproxy, tsk);
-
 	if (old_mm) {
 		mmap_read_unlock(old_mm);
 		BUG_ON(active_mm != old_mm);
diff --git a/kernel/fork.c b/kernel/fork.c
index 8a9e92068b15..2b6bd511c6ed 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2047,11 +2047,8 @@ static __latent_entropy struct task_struct *copy_process(
 	/*
 	 * If the new process will be in a different time namespace
 	 * do not allow it to share VM or a thread group with the forking task.
-	 *
-	 * On vfork, the child process enters the target time namespace only
-	 * after exec.
 	 */
-	if ((clone_flags & (CLONE_VM | CLONE_VFORK)) == CLONE_VM) {
+	if (clone_flags & (CLONE_THREAD | CLONE_VM)) {
 		if (nsp->time_ns != nsp->time_ns_for_children)
 			return ERR_PTR(-EINVAL);
 	}
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index b4cbb406bc28..eec72ca962e2 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -179,8 +179,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 	if (IS_ERR(new_ns))
 		return  PTR_ERR(new_ns);
 
-	if ((flags & CLONE_VM) == 0)
-		timens_on_fork(new_ns, tsk);
+	timens_on_fork(new_ns, tsk);
 
 	tsk->nsproxy = new_ns;
 	return 0;
-- 
2.37.2.789.g6183377224-goog

