Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7E35F4047
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiJDJrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJDJrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:47:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD9B1146C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:44:46 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s206so12276432pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=v8JjkvCpfLlkeZvz/tjk0YSPzHE99iGy886vZSLL+dQ=;
        b=QqKxOKxyM50XH3J9Fp8A7ADMJbwLSgTDVP5+fU04KREh10DLBwXPL76c738u3puD12
         CYxWGgvPxRgNs9xW0qiUY0aXzLjvbE3e/zx9s5Giv/3zFxv0sHr9Ej6o2LZ9bIYNtRj4
         njaue7Rvkk2B3JvBNQD/BcPccQsX1TQA/eJuHhJERPew3Uk4L2c1Qi4kiQ2xMMS3qmSR
         b676KGP4VNyNSvv33bBdjQbIJcyGlZkpwgIQF9uuPbl3T9xZXukywYRnhnH4WoGsT+lj
         /+VDbkaKefiMHX0nBt7zXrVPA9tzizw2uo+DDgr4WR45NemutoBr2MDwXB8kCrOgZATk
         ohIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=v8JjkvCpfLlkeZvz/tjk0YSPzHE99iGy886vZSLL+dQ=;
        b=qC0DkuSpqG6XCFn98PMGaoVbIUySiTgqWuw4z/SD/XmJFTab2DEY8r3suuoeWuD220
         mPDW4WjKIkGPZU4DIGfHspxTWRwBaXvtMHbGPZb8KZNEo3TU/OnKG33+1GwXJII6/MSb
         eDmEXCZsIEGqZ7R8kxC+XR+E08pMh/4UI0UBWD+6EE5MfXfA+9l7cpRgpwf8LHTD8Bh+
         gJxVJAU97GThc4i0pTBgsYz1iqW2WeojjIizFlN2ucAC2MBXvwGDj628ZQLKT9OMXkRr
         Ra3X08bclsg04yE3QGRqnTeAVqzKWzxoZr6Yan/Hgx1ej/KRCnaWd+19za+qr+urxyFA
         ER6g==
X-Gm-Message-State: ACrzQf0dtckN0d+VxqrTwYwUMCgK0mA1OYgjzepwJ/ycbGmJKkr+vq/B
        Zecmv0eXrXJl3HKxYYxwG18=
X-Google-Smtp-Source: AMsMyM5gIOYKIXhDbUhlxY5L7Jy2jjv7zqyPKii83Quig5BvN3nQ7Bpe9tWD4IBClY6ludSDquByiw==
X-Received: by 2002:a63:5a63:0:b0:42f:e143:80d4 with SMTP id k35-20020a635a63000000b0042fe14380d4mr22942366pgm.456.1664876653212;
        Tue, 04 Oct 2022 02:44:13 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (123-243-1-173.tpgi.com.au. [123.243.1.173])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902ea0d00b0016d72804664sm8560450plg.205.2022.10.04.02.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 02:44:10 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] exit: Detect and fix irq disabled state in oops
Date:   Tue,  4 Oct 2022 19:44:01 +1000
Message-Id: <20221004094401.708299-1-npiggin@gmail.com>
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

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/exit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/exit.c b/kernel/exit.c
index 84021b24f79e..fa696765f694 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -738,6 +738,7 @@ void __noreturn do_exit(long code)
 	struct task_struct *tsk = current;
 	int group_dead;
 
+	WARN_ON(irqs_disabled());
 	WARN_ON(tsk->plug);
 
 	kcov_task_exit(tsk);
@@ -865,6 +866,11 @@ void __noreturn make_task_dead(int signr)
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

