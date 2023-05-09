Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44DF6FBDCF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjEIDzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEIDzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:55:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691784C2C;
        Mon,  8 May 2023 20:55:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A412E61011;
        Tue,  9 May 2023 03:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021A0C433EF;
        Tue,  9 May 2023 03:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683604501;
        bh=ljTxyucIRDttnYxn8OYDAsFD42hJcSoKDHU6eCAObKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HAZt1ENUrgZY9GI4+p7d//qQPmhUMKVS1bc2hpDJ4N9WKi3f9e63aQ/lhBizUi2ly
         qHS/AwfQwB3fPtk8niNnAq6eXuJ2YshYgc5HBMus8N8D89eVJtF9vt2ntG0tIbCorp
         NgJc2bk67mUUh2pwISOWIUX+L0FFaYyDdmOWY8qonYryZ6mwI5HeE8CirtPs56AVBe
         e4eTZrIlUw+qff4M69gZoT6Pg0RbioMfX0b/EXMxhuxjiazSBGQYK4Ph+R3LEde9WU
         ExttBHd/K6HjZA6YiQK22lyUVo+8FGl3574iXMGq6iyx+1Ttg5eGk7KmIapvEVsnst
         QsoCZJp1MMERw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.3 2/7] sched: Fix KCSAN noinstr violation
Date:   Mon,  8 May 2023 23:54:25 -0400
Message-Id: <20230509035455.59524-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509035455.59524-1-sashal@kernel.org>
References: <20230509035455.59524-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 5e799a47431e8..f158b025c1750 100644
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

