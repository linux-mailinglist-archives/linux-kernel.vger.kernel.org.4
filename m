Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AF066258A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 13:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbjAIM2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 07:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237193AbjAIM2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 07:28:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EA551C115
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 04:27:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1EF41042;
        Mon,  9 Jan 2023 04:28:38 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0BD313F67D;
        Mon,  9 Jan 2023 04:27:54 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] arm64: Fix build with CC=clang, CONFIG_FTRACE=y and CONFIG_STACK_TRACER=y
Date:   Mon,  9 Jan 2023 12:27:43 +0000
Message-Id: <20230109122744.1904852-1-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 45bd8951806e ("arm64: Improve HAVE_DYNAMIC_FTRACE_WITH_REGS
selection for clang") fixed the build with the above combination by
splitting HAVE_DYNAMIC_FTRACE_WITH_REGS into separate checks for
Clang and GCC.

commit 26299b3f6ba2 ("ftrace: arm64: move from REGS to ARGS") added the
GCC only check "-fpatchable-function-entry=2" back in unconditionally
which breaks the build.

Remove the unconditional check, because the conditional ones were also
updated to _ARGS in the above commit, so they work correctly on their
own.

Fixes: 26299b3f6ba2 ("ftrace: arm64: move from REGS to ARGS")
Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cf6d1cd8b6dc..c5ccca26a408 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -184,8 +184,6 @@ config ARM64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
-	select HAVE_DYNAMIC_FTRACE_WITH_ARGS \
-		if $(cc-option,-fpatchable-function-entry=2)
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
 		if DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS

base-commit: 5db568e748f6fb7d0d2e1bff4c2698ad4f50b982
-- 
2.25.1

