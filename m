Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115B37486C5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjGEOqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjGEOqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:46:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8F610CF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2090615D5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 14:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40570C433CC;
        Wed,  5 Jul 2023 14:46:33 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qH3m4-003Phk-0s;
        Wed, 05 Jul 2023 10:46:32 -0400
Message-ID: <20230705144632.086008297@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 05 Jul 2023 10:40:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Donglin Peng <pengdonglin@sangfor.com.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Florent Revest <revest@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [for-linus][PATCH 2/3] arm64: ftrace: fix build error with CONFIG_FUNCTION_GRAPH_TRACER=n
References: <20230705144031.702796304@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

It appears that a merge conflict ended up hiding a newly added constant
in some configurations:

arch/arm64/kernel/entry-ftrace.S: Assembler messages:
arch/arm64/kernel/entry-ftrace.S:59: Error: undefined symbol FTRACE_OPS_DIRECT_CALL used as an immediate value

FTRACE_OPS_DIRECT_CALL is still used when CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
is enabled, even if CONFIG_FUNCTION_GRAPH_TRACER is disabled, so change the
ifdef accordingly.

Link: https://lkml.kernel.org/r/20230623152204.2216297-1-arnd@kernel.org

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Donglin Peng <pengdonglin@sangfor.com.cn>
Fixes: 3646970322464 ("arm64: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Florent Revest <revest@chromium.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/arm64/kernel/asm-offsets.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 757d01a68ffd..5ff1942b04fc 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -213,9 +213,9 @@ int main(void)
   DEFINE(FGRET_REGS_X7,			offsetof(struct fgraph_ret_regs, regs[7]));
   DEFINE(FGRET_REGS_FP,			offsetof(struct fgraph_ret_regs, fp));
   DEFINE(FGRET_REGS_SIZE,		sizeof(struct fgraph_ret_regs));
+#endif
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
   DEFINE(FTRACE_OPS_DIRECT_CALL,	offsetof(struct ftrace_ops, direct_call));
-#endif
 #endif
   return 0;
 }
-- 
2.39.2
