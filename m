Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEF16748B8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjATBSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjATBSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:18:45 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAC5A45F2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 17:18:35 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id a9-20020a17090a740900b0022a0e51fb17so947501pjg.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 17:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dp+p2SN13aJ2wkNmfLpNrfn1VGslI5t3iZF9IkcVRtI=;
        b=FuBzfbd4XnNHA1z3iu0MNuy9pTQxDzWZtH6J+halqMqcg23oS+1w/nDGDglomvdNxK
         59qJoX4n4M6ifryr/JCkb2zN8/NHrn1TPwcO4cnvqAI3BbS0jbaqa2zG57+eUXbaVJfl
         +Yfu0GSELFT2hKfpavsqZakqDQac0cKWn/jmLm0jv8T7N705xgrT/KtUs2wO29aITISX
         3z96MZPmfRgYlp9QA+G73ZKMaI+gUNV/g7efyKgRJQ2hb8BUm5SYHeIoCNw1zDhuGEZI
         tdYbjU77H0c2CGiuJIeS7+b0ymnaA8hRka4CZVG1VvOjC9akEM/TCNl6F0hHr3JZq+Im
         gVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dp+p2SN13aJ2wkNmfLpNrfn1VGslI5t3iZF9IkcVRtI=;
        b=ov1DmnNsW2fmltCJl3ABhrQ6BLqPtFpwPpEfxzilj1lYO6cq1Bd8E4QbvkzcYyEaZj
         p2LSYn9ArpoKc4LYXIxN7F7kh9/aRCJ6Mxp3nG7S761FL8YBIVXQA2eE+xW3ITmXQj2k
         GXwA+Ofnzj86BK9kyFhu/xZn3l+UWheJUdpx+fe3lMmyWCBhlfWgL0ieWyItf/AucwEz
         z3y4c9rQ83K2XuutFmvWoItCzWOOS+cu1XYpRqXSrLr6XCQJZG63DNFSJz3PRVyKbaxR
         bTLA0N1v4KM/YncsfEOsttZ3qk3ebH6IgsqvMCRWinoPpWrSfyps1SP3bp3/o4Y6rGw3
         h22w==
X-Gm-Message-State: AFqh2kpO1QvTHxLCljUxixvQZYZxbjdwX+ctDr+5K8vgb469rAY/XmhC
        73qGOt0vd++z49YP2xguxck=
X-Google-Smtp-Source: AMrXdXtK8xuoN35RtpK0cqwiDLtXi8ME7R2HDGRn9C32xGAAjuSk7bdzvAzaSgewgQdlZz3JFRFvGw==
X-Received: by 2002:a17:902:e542:b0:194:4a0e:3024 with SMTP id n2-20020a170902e54200b001944a0e3024mr15974132plf.62.1674177515030;
        Thu, 19 Jan 2023 17:18:35 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (193-116-102-45.tpgi.com.au. [193.116.102.45])
        by smtp.gmail.com with ESMTPSA id bb3-20020a170902bc8300b00189c4b8ca21sm946445plb.18.2023.01.19.17.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 17:18:34 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH] exit: Detect and fix irq disabled state in oops
Date:   Fri, 20 Jan 2023 11:18:20 +1000
Message-Id: <20230120011820.2664120-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a task oopses with irqs disabled, this can cause various cascading
problems in the oops path such as sleep-from-invalid warnings, and
potentially worse.

Since commit 0258b5fd7c712 ("coredump: Limit coredumps to a single
thread group"), the unconditional irq enable in coredump_task_exit()
will "fix" the irq state to be enabled early in do_exit(), so currently
this may not be triggerable, but that is coincidental and fragile.

Detect and fix the irqs_disabled() condition in the oops path before
calling do_exit(), similarly to the way in_atomic() is handled.

Link: https://lore.kernel.org/lkml/20221004094401.708299-1-npiggin@gmail.com/
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Hi Peter,

Would you consider taking this through the sched tree?

Thanks,
Nick

 kernel/exit.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/exit.c b/kernel/exit.c
index 15dc2ec80c46..bccfa4218356 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -807,6 +807,8 @@ void __noreturn do_exit(long code)
 	struct task_struct *tsk = current;
 	int group_dead;
 
+	WARN_ON(irqs_disabled());
+
 	synchronize_group_exit(tsk, code);
 
 	WARN_ON(tsk->plug);
@@ -938,6 +940,11 @@ void __noreturn make_task_dead(int signr)
 	if (unlikely(!tsk->pid))
 		panic("Attempted to kill the idle task!");
 
+	if (unlikely(irqs_disabled())) {
+		pr_info("note: %s[%d] exited with irqs disabled\n",
+			current->comm, task_pid_nr(current));
+		local_irq_enable();
+	}
 	if (unlikely(in_atomic())) {
 		pr_info("note: %s[%d] exited with preempt_count %d\n",
 			current->comm, task_pid_nr(current),
-- 
2.37.2

