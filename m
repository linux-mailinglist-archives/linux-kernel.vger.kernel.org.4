Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5164A6DFCA4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjDLRYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjDLRYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:24:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFD31726
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:24:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 869B1637CC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD300C433AA;
        Wed, 12 Apr 2023 17:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681320255;
        bh=40bQAl7b9ZRfFX150jDT4Y2Aky1kTJSd3vkEWMdjKys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S/0lStm0fcgmo7O/BpzPF+J6qdMt8uKX4RF6V6vpfoaXb28wNlJpphDYIJwnLZtem
         830qJt9OGn8zMRl6slScF7ONK1esfYPEC9AgaWjmtsi382hw+NCQImblNHRZkpPUlT
         wJ+Y9/2sxgvNV410VG6bCPzmeWZikIbM7Boa+mzaDr54jzqgsEXsp8PKaIn3GiZHkt
         MPywY/uh5qZy74BxqlE/9gR2cCXW7VIdOCM0gzTr165TeeJeWCvZt+Jrd/JL6u+0/L
         vk/Uxq4XkTkmmoqHWZjYa3rDWOiQQnU4Ft2WzZybBMap0d2sUM+4aSq1TfnV8cB1T2
         0xxIuoj3/ujYA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, frederic@kernel.org,
        paulmck@kernel.org, keescook@chromium.org
Subject: [PATCH 2/3] sched: Fix KCSAN noinstr violation
Date:   Wed, 12 Apr 2023 10:24:07 -0700
Message-Id: <cc1b4d73d3a428a00d206242a68fdf99a934ca7b.1681320026.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681320026.git.jpoimboe@kernel.org>
References: <cover.1681320026.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With KCSAN enabled, end_of_stack() can get out-of-lined.  Force it
inline.

Fixes the following warnings:

  vmlinux.o: warning: objtool: check_stackleak_irqoff+0x2b: call to end_of_stack() leaves .noinstr.text section

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/sched/task_stack.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 5e799a47431e..f158b025c175 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -23,7 +23,7 @@ static __always_inline void *task_stack_page(const struct task_struct *task)
 
 #define setup_thread_stack(new,old)	do { } while(0)
 
-static inline unsigned long *end_of_stack(const struct task_struct *task)
+static __always_inline unsigned long *end_of_stack(const struct task_struct *task)
 {
 #ifdef CONFIG_STACK_GROWSUP
 	return (unsigned long *)((unsigned long)task->stack + THREAD_SIZE) - 1;
-- 
2.39.2

