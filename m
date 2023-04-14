Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20B26E262A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjDNOs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjDNOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:48:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237C3BB9A;
        Fri, 14 Apr 2023 07:48:01 -0700 (PDT)
Date:   Fri, 14 Apr 2023 14:47:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681483677;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8/9e9YsQ2EUkL2LLf8mvhm3+zBTdxBKufAnVicgwPsc=;
        b=xLkFIGKhh/AWA/QYbZWgstdjw/rmTRRfinBUl0RbvXAny1CzyehJyIrpyxZtrw1OARMSY7
        uBLZ8w3j4lnxIPRqHceYo8aSc1feKrtULcHXtmgAVeGS7ZBcsmw38oz/d59ExPr3P9ru4W
        BwYEHrjk7tQWj7hZpYoSNhBSxTOvQAOoVqRhbWoxqti13TdxW8Nho9em1ZL1hE62RJDmCI
        c8fjHoCHuok0wcEPGWHe18Q5AuPj3mXpHVHOJ1/sF5UcPB0PIDIYKHFj8f6dQjSCLpa7yb
        NEJpQMtqFZzObWVld6+sjJIjtDH0ilXQTH/+CiRiu7Ot8tt9LrzsHH7Swff88Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681483677;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8/9e9YsQ2EUkL2LLf8mvhm3+zBTdxBKufAnVicgwPsc=;
        b=Qo7H2OMUhT59Yb5HofyXRZuJcPHFYPuIA2EYbIPlCmZiPn/mpVKcLhaM/XUsXMZJ5yG3+H
        wtkw04tiDzGj55Aw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] sched: Fix KCSAN noinstr violation
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <cc1b4d73d3a428a00d206242a68fdf99a934ca7b.1681320026.git.jpoimboe@kernel.org>
References: <cc1b4d73d3a428a00d206242a68fdf99a934ca7b.1681320026.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168148367716.404.4222570877291738976.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e0b081d17a9f4e5c0cbb0e5fbeb1abe3de0f7e4e
Gitweb:        https://git.kernel.org/tip/e0b081d17a9f4e5c0cbb0e5fbeb1abe3de0f7e4e
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 10:24:07 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 16:08:26 +02:00

sched: Fix KCSAN noinstr violation

With KCSAN enabled, end_of_stack() can get out-of-lined.  Force it
inline.

Fixes the following warnings:

  vmlinux.o: warning: objtool: check_stackleak_irqoff+0x2b: call to end_of_stack() leaves .noinstr.text section

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/cc1b4d73d3a428a00d206242a68fdf99a934ca7b.1681320026.git.jpoimboe@kernel.org
---
 include/linux/sched/task_stack.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 5e799a4..f158b02 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -23,7 +23,7 @@ static __always_inline void *task_stack_page(const struct task_struct *task)
 
 #define setup_thread_stack(new,old)	do { } while(0)
 
-static inline unsigned long *end_of_stack(const struct task_struct *task)
+static __always_inline unsigned long *end_of_stack(const struct task_struct *task)
 {
 #ifdef CONFIG_STACK_GROWSUP
 	return (unsigned long *)((unsigned long)task->stack + THREAD_SIZE) - 1;
