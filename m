Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18016F241B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 12:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjD2KLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 06:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjD2KLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 06:11:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B20219A0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 03:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682763013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=vXxBktH3cHV7+Leg2kx7Rf8co9gFb3d5SPKnMmXtxww=;
        b=gkhNynjryF6T+18W7Sxqtgx7FkGtblTfXw8f7oernrG3eKH8bKXnchfdRUm5tmqrDUqH+S
        v8Abcsmn+jIt1vq4EdTW84Cso80unXXHT/tWlUjXEJK/XMb9iFsUYPrOHAbZVs7DWV/yRx
        1+13uHvjqOMDUHVrCO2PHE8mVFuvLbA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-sBBlU5ESOEqv14wyfl36og-1; Sat, 29 Apr 2023 06:10:09 -0400
X-MC-Unique: sBBlU5ESOEqv14wyfl36og-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B0AD811E7B;
        Sat, 29 Apr 2023 10:10:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.26])
        by smtp.corp.redhat.com (Postfix) with SMTP id E08C72166B26;
        Sat, 29 Apr 2023 10:10:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 29 Apr 2023 12:09:57 +0200 (CEST)
Date:   Sat, 29 Apr 2023 12:09:55 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Vernon Lovejoy <vlovejoy@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/show_trace_log_lvl: ensure stack pointer is aligned,
 again
Message-ID: <20230429100955.GA20567@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vernon Lovejoy <vlovejoy@redhat.com>

The commit e335bb51cc15 ("x86/unwind: Ensure stack pointer is aligned")
tried to align the stack pointer in show_trace_log_lvl(), otherwise the
"stack < stack_info.end" check can't guarantee that the last read does
not go past the end of the stack.

However, we have the same problem with the initial value of the stack
pointer, it can also be unaligned. So without this patch this trivial
kernel module

	#include <linux/module.h>

	static int init(void)
	{
		asm volatile("sub    $0x4,%rsp");
		dump_stack();
		asm volatile("add    $0x4,%rsp");

		return -EAGAIN;
	}

	module_init(init);
	MODULE_LICENSE("GPL");

crashes the kernel.

Fixes: e335bb51cc15 ("x86/unwind: Ensure stack pointer is aligned")
Signed-off-by: Vernon Lovejoy <vlovejoy@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/kernel/dumpstack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 0bf6779187dd..f82d896eb99d 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -195,7 +195,6 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	printk("%sCall Trace:\n", log_lvl);
 
 	unwind_start(&state, task, regs, stack);
-	stack = stack ? : get_stack_pointer(task, regs);
 	regs = unwind_get_entry_regs(&state, &partial);
 
 	/*
@@ -214,7 +213,10 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	 * - hardirq stack
 	 * - entry stack
 	 */
-	for ( ; stack; stack = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
+	for (stack = PTR_ALIGN(stack ?: get_stack_pointer(task, regs), sizeof(long));
+	     stack;
+	     stack = PTR_ALIGN(stack_info.next_sp, sizeof(long)))
+	{
 		const char *stack_name;
 
 		if (get_stack_info(stack, task, &stack_info, &visit_mask)) {
-- 
2.25.1.362.g51ebf55


