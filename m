Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C3F73BB86
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjFWPW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjFWPWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:22:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FDD19B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:22:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4B9F61A97
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2ECC433CC;
        Fri, 23 Jun 2023 15:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687533730;
        bh=PDmC4YA2NsJQMxRbgNA3iKcTYPuiiTgA/RrritCht8o=;
        h=From:To:Cc:Subject:Date:From;
        b=OyfYhhQ7N237/hBj0FLMeGBea8pEcu3RQWI27ZCWysCZGfIv0vRYz6ctD95U5UHWa
         QRxn2Z1AMJfKwZAW7ntxRBM4P2yKXZh4vZHZ1elQrxHXBM7GVltXBk9yAZqHyWxxax
         cty0ioHXO81m12xAyhfWBtxL4gyI1cdsAy7TbG9WnovHKP36Ilz47rKGv4hhdIro2o
         jJvP+Eslv17xAIwqgJmVe7clfkqizwYlFRnR9bSZz2VzXCbM8515zAKupay8Z3CXKD
         tUMwC/pGoIOmGs6tAcF3YB0pv7V5fWDFcHW0JQvIfE68VDM9AOIS1P7skh9dLMLatO
         5VW6QKj/uE3Rg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Donglin Peng <pengdonglin@sangfor.com.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Florent Revest <revest@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: ftrace: fix build error with CONFIG_FUNCTION_GRAPH_TRACER=n
Date:   Fri, 23 Jun 2023 17:21:55 +0200
Message-Id: <20230623152204.2216297-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

It appears that a merge conflict ended up hiding a newly added constant
in some configurations:

arch/arm64/kernel/entry-ftrace.S: Assembler messages:
arch/arm64/kernel/entry-ftrace.S:59: Error: undefined symbol FTRACE_OPS_DIRECT_CALL used as an immediate value

FTRACE_OPS_DIRECT_CALL is still used when CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
is enabled, even if CONFIG_FUNCTION_GRAPH_TRACER is disabled, so change the
ifdef accordingly.

Fixes: 3646970322464 ("arm64: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/asm-offsets.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 757d01a68ffd0..5ff1942b04fcf 100644
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

