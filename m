Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1A26FBE0D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjEID7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbjEID6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:58:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F271D2FD;
        Mon,  8 May 2023 20:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB05B6313D;
        Tue,  9 May 2023 03:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37F5C433EF;
        Tue,  9 May 2023 03:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683604593;
        bh=aFLz+7G0jLW1WAes9iKwfH6HvfuhdFOyVs6Cc1Uhf/k=;
        h=From:To:Cc:Subject:Date:From;
        b=j+Q6PDmoR1CPifkfUTLNtjgUWdVkFcjnedLZealGXDSU2mgFJpIFeXz9RUAR6pbef
         s64Rb4cwKpd/0+OTiOZMXonwcHl/CGO3XGocKLLBX3XsQNGiNRzsAqz04e2dajEBUv
         3/uX2vPAMYCjm9QWujdZFN5moDkG+f/ViezuAF29dPakgNXTM20xkEpLWnA93E7917
         Fu4lfjfD8VuAkRJ1Uu3OC7bTsGMZ+K58RKCT6WZJRVP1YuC0sNuTCl7ihZTp6L61za
         KOh9IC5tP2bVS5brkTjTALd6NIO7moL0EtdoTfy7zYLiW5MsIn2j6TlIFKqSI5HeqX
         NZFETdLkso4ZA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 1/2] sched: Fix KCSAN noinstr violation
Date:   Mon,  8 May 2023 23:56:26 -0400
Message-Id: <20230509035632.60967-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit e0b081d17a9f4e5c0cbb0e5fbeb1abe3de0f7e4e ]

With KCSAN enabled, end_of_stack() can get out-of-lined.  Force it
inline.

Fixes the following warnings:

  vmlinux.o: warning: objtool: check_stackleak_irqoff+0x2b: call to end_of_stack() leaves .noinstr.text section

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/cc1b4d73d3a428a00d206242a68fdf99a934ca7b.1681320026.git.jpoimboe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched/task_stack.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 4f099d3fed3a9..f1063380e6d8a 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -23,7 +23,7 @@ static inline void *task_stack_page(const struct task_struct *task)
 
 #define setup_thread_stack(new,old)	do { } while(0)
 
-static inline unsigned long *end_of_stack(const struct task_struct *task)
+static __always_inline unsigned long *end_of_stack(const struct task_struct *task)
 {
 #ifdef CONFIG_STACK_GROWSUP
 	return (unsigned long *)((unsigned long)task->stack + THREAD_SIZE) - 1;
-- 
2.39.2

