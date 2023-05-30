Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17906717157
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjE3XIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjE3XIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:08:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3618E1BD
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFAC2634FF
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 23:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E069CC433D2;
        Tue, 30 May 2023 23:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685488066;
        bh=GuvSdzaUaOD4Q3zIVBnUZqy1MMCZ04uhZR3w5/xLIYk=;
        h=From:To:Cc:Subject:Date:From;
        b=KYTlZjPfIIPZCyofqcngIr1OfMwCNXPAJCOL75OMfOpfhcCFbrZG/ZuUxAzsDOI22
         emKY/k1VIsB1NpHH/TyL2noWjd9YrxAAPyMLJQhZRbtq00MMTrVYiRbbBS45aT1PSE
         Fk4cEI6AZXsTTeErOKSTOcAr0mTfm+p2jh/zKhyTj+ho4mFoOMImII5WKtxW3GUr5d
         He7dhmHindDwSW8apSZCYEdJyZtMxUxTQoyARFDBEHT7AmwgjlFnF1knrnHZJvg+Kx
         pUJgh8fYcv67W7v4vz1XH7t7VJZUPK4Q0c5oIy7V07Fd7ENP0Lh7b9eVDwC4rqCKRJ
         Ym+jzObIEndYw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] x86/entry: Move thunk restore code into thunk functions
Date:   Tue, 30 May 2023 16:07:41 -0700
Message-Id: <46aa8aeb716f302e22e1673ae15ee6fe050b41f4.1685488050.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need for both thunk functions to jump to the same shared
thunk restore code which lives outside the thunk function boundaries.
It disrupts i-cache locality and confuses objtool.  Keep it simple by
keeping each thunk's restore code self-contained within the function.

Fixes a bunch of false positive "missing __noreturn" warnings like:

  vmlinux.o: warning: objtool: do_arch_prctl_common+0xf4: preempt_schedule_thunk() is missing a __noreturn annotation

Fixes: fedb724c3db5 ("objtool: Detect missing __noreturn annotations")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305281037.3PaI3tW4-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/entry/thunk_64.S | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index 5e37f41e5f14..27b5da2111ac 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -26,17 +26,7 @@ SYM_FUNC_START(\name)
 	pushq %r11
 
 	call \func
-	jmp  __thunk_restore
-SYM_FUNC_END(\name)
-	_ASM_NOKPROBE(\name)
-	.endm
 
-	THUNK preempt_schedule_thunk, preempt_schedule
-	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
-	EXPORT_SYMBOL(preempt_schedule_thunk)
-	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
-
-SYM_CODE_START_LOCAL(__thunk_restore)
 	popq %r11
 	popq %r10
 	popq %r9
@@ -48,5 +38,11 @@ SYM_CODE_START_LOCAL(__thunk_restore)
 	popq %rdi
 	popq %rbp
 	RET
-	_ASM_NOKPROBE(__thunk_restore)
-SYM_CODE_END(__thunk_restore)
+SYM_FUNC_END(\name)
+	_ASM_NOKPROBE(\name)
+	.endm
+
+THUNK preempt_schedule_thunk, preempt_schedule
+THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
+EXPORT_SYMBOL(preempt_schedule_thunk)
+EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
-- 
2.40.1

