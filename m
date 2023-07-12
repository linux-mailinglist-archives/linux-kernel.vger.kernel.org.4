Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354EC750C9A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjGLPdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjGLPdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:33:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770561BD5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:33:36 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so3615479b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689176016; x=1691768016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O0/uT8T+DtOLvk7VVHi5K8JLtFZW6znqNmYr+1FCVNQ=;
        b=I197g5CscXpNWZfXCqw9Nsb5mJv8G5XpBZT/OYVf8CptOJYLfNnqfQ2ixdFez8gbWA
         T4c6RdaEK8Cn/q9chQcoPPv46YBI1/DtTajt6PZXWakSWLz9cvRiQjIC6cbtcFOibRI5
         k/xCGU5h9+uqK7tRQyj66Msen5o7yvPShKFxuzBmxXochmensY7vVYRR72c/I0PuyFDp
         ZhWjQyJAHfssaqBrPSHu8tC9zCjzXXiTuEFEn2yls+QiFrm5nJZoArTjYBYPX4kSE4CS
         VzoD9LsYQnHHXC6n2a0lnTM5B4ph1YVEFnrq4Tf9raghUEBvOHZCs1jf+YThvDqvok13
         yfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689176016; x=1691768016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0/uT8T+DtOLvk7VVHi5K8JLtFZW6znqNmYr+1FCVNQ=;
        b=UF9patJrIakRNSTXIIqQ0VFVo6Ud4DI2OuI0IRbHcpIwLffPdPpEIi23HjjPP8ClVU
         kHGcirVEw9sE/OmmI0bSc5fy9PjvKND+r4sntPcDZJ4GyEoXj65MIcX1kwpyhMktyM+m
         G/EoSUNMRC2gnEjUqxNRB9FCOkBPJww1m9aan1hwL6x2FGjq1Rf8YM15V7xUxD3dFpbs
         tcAqENTYrTNkxKuKPpytaa/MPu7HljBcOSNZxl9VOt5T93tdKfI1rycVg+mlcEmdSIlL
         RhC7lq5lYy+jG77KDA+B9G3W8zozIBHKDF/YxctvXXqJs6CYDlVlE8cqZQ/7/Wkuh2AG
         8phQ==
X-Gm-Message-State: ABy/qLb3j10hwCUzYBe5ceMbs7SfvUKETBgBP0TDbTAwWq3BEqyxeIf5
        CfTZQ0y+kkDblkNKbv5t5fI+WbEI3b1V/bx9
X-Google-Smtp-Source: APBJJlHOwo17FD0A39dUGvVcQKoC9G9ifAuQaKtZDz1kJLhYjOW6vxq8Qm5LsSSAqKQISzNavloanQ==
X-Received: by 2002:a05:6a20:734a:b0:131:b3fa:eaaa with SMTP id v10-20020a056a20734a00b00131b3faeaaamr8314425pzc.61.1689176015789;
        Wed, 12 Jul 2023 08:33:35 -0700 (PDT)
Received: from ubuntu2204.. (2001-b400-e231-d5e5-7975-cda9-d4af-3c25.emome-ip6.hinet.net. [2001:b400:e231:d5e5:7975:cda9:d4af:3c25])
        by smtp.gmail.com with ESMTPSA id t16-20020a62ea10000000b0063b898b3502sm3739241pfh.153.2023.07.12.08.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:33:35 -0700 (PDT)
From:   Chin Yik Ming <yikming2222@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, Chin Yik Ming <yikming2222@gmail.com>
Subject: [PATCH] sched: Fixed typo
Date:   Wed, 12 Jul 2023 23:33:27 +0800
Message-Id: <20230712153327.3171-1-yikming2222@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task_struct's state member is prefixed by "__"

Signed-off-by: Chin Yik Ming <yikming2222@gmail.com>
---
 include/linux/sched.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 609bde814..942c61dce 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -75,14 +75,14 @@ struct user_event_mm;
  * Task state bitmask. NOTE! These bits are also
  * encoded in fs/proc/array.c: get_task_state().
  *
- * We have two separate sets of flags: task->state
+ * We have two separate sets of flags: task->__state
  * is about runnability, while task->exit_state are
  * about the task exiting. Confusing, but this way
  * modifying one set can't modify the other one by
  * mistake.
  */
 
-/* Used in tsk->state: */
+/* Used in tsk->__state: */
 #define TASK_RUNNING			0x00000000
 #define TASK_INTERRUPTIBLE		0x00000001
 #define TASK_UNINTERRUPTIBLE		0x00000002
@@ -92,7 +92,7 @@ struct user_event_mm;
 #define EXIT_DEAD			0x00000010
 #define EXIT_ZOMBIE			0x00000020
 #define EXIT_TRACE			(EXIT_ZOMBIE | EXIT_DEAD)
-/* Used in tsk->state again: */
+/* Used in tsk->__state again: */
 #define TASK_PARKED			0x00000040
 #define TASK_DEAD			0x00000080
 #define TASK_WAKEKILL			0x00000100
@@ -173,7 +173,7 @@ struct user_event_mm;
 #endif
 
 /*
- * set_current_state() includes a barrier so that the write of current->state
+ * set_current_state() includes a barrier so that the write of current->__state
  * is correctly serialised wrt the caller's subsequent test of whether to
  * actually sleep:
  *
@@ -196,9 +196,9 @@ struct user_event_mm;
  *   wake_up_state(p, TASK_UNINTERRUPTIBLE);
  *
  * where wake_up_state()/try_to_wake_up() executes a full memory barrier before
- * accessing p->state.
+ * accessing p->__state.
  *
- * Wakeup will do: if (@state & p->state) p->state = TASK_RUNNING, that is,
+ * Wakeup will do: if (@state & p->__state) p->__state = TASK_RUNNING, that is,
  * once it observes the TASK_UNINTERRUPTIBLE store the waking CPU can issue a
  * TASK_RUNNING store which can collide with __set_current_state(TASK_RUNNING).
  *
-- 
2.34.1

