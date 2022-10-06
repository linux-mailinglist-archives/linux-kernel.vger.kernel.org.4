Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAB95F6243
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiJFIFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiJFIFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4AC33A3C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D80D96188A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D81C43142;
        Thu,  6 Oct 2022 08:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665043521;
        bh=FRHPtnT6RXzTDlWEaASb9BMb9gXuCOQWF/Rtin4YmmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSTomXSeFi/V62uHnwmu+wmfan1lT+N4ClPoCFuEC7a/cOOu43co6UEzLYw2bCTd8
         QDbnQUaJhSb/H2I+S5ETP1CbFYU4rHXd7H2Cs3sIZBTcIC7qMhrMm8Zy+APmPTvdT1
         rE5POG4SZu9VPcyyzzAmibgp70JnUDfHgL6ZVQPwIFlqn6ivEdQYkzskjWIf8Hbvu4
         UL/b+67As+G79Hj9Lo1VaU8/+oKmNaxb87yeZN8XGnbyyvifykGuDQ4eftUsYqxFgf
         4CJ3AaRZvQ8PLkma3MiUO7gdT+kenspKI5ol8dGGGrYkgbKHobeEE3Ef6T07mDaAdk
         3twnT04m5OELA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: alternative: constify alternative_has_feature_* argument
Date:   Thu,  6 Oct 2022 15:55:42 +0800
Message-Id: <20221006075542.2658-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221006075542.2658-1-jszhang@kernel.org>
References: <20221006075542.2658-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inspired by x86 commit 864b435514b2("x86/jump_label: Mark arguments as
const to satisfy asm constraints"), constify alternative_has_feature_*
argument to satisfy asm constraints. And Steven in [1] also pointed
out that "The "i" constraint needs to be a constant."

Tested with building a simple external kernel module with "O0".

Before the patch, got similar gcc warnings and errors as below:

In file included from <command-line>:
In function ‘alternative_has_feature_likely’,
    inlined from ‘system_capabilities_finalized’ at
arch/arm64/include/asm/cpufeature.h:440:9,
    inlined from ‘arm64_preempt_schedule_irq’ at
arch/arm64/kernel/entry-common.c:264:6:
include/linux/compiler_types.h:285:33: warning:
‘asm’ operand 0 probably does not match constraints
  285 | #define asm_volatile_goto(x...) asm goto(x)
      |                                 ^~~
arch/arm64/include/asm/alternative-macros.h:232:9:
note: in expansion of macro ‘asm_volatile_goto’
  232 |         asm_volatile_goto(
      |         ^~~~~~~~~~~~~~~~~
include/linux/compiler_types.h:285:33: error:
impossible constraint in ‘asm’
  285 | #define asm_volatile_goto(x...) asm goto(x)
      |                                 ^~~
arch/arm64/include/asm/alternative-macros.h:232:9:
note: in expansion of macro ‘asm_volatile_goto’
  232 |         asm_volatile_goto(
      |         ^~~~~~~~~~~~~~~~~

After the patch, the simple external test kernel module is built fine
with "-O0".

[1]https://lore.kernel.org/all/20210212094059.5f8d05e8@gandalf.local.home/

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/arm64/include/asm/alternative-macros.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/alternative-macros.h b/arch/arm64/include/asm/alternative-macros.h
index 3622e9f4fb44..bdf1f6bcd010 100644
--- a/arch/arm64/include/asm/alternative-macros.h
+++ b/arch/arm64/include/asm/alternative-macros.h
@@ -224,7 +224,7 @@ alternative_endif
 #include <linux/types.h>
 
 static __always_inline bool
-alternative_has_feature_likely(unsigned long feature)
+alternative_has_feature_likely(const unsigned long feature)
 {
 	compiletime_assert(feature < ARM64_NCAPS,
 			   "feature must be < ARM64_NCAPS");
@@ -242,7 +242,7 @@ alternative_has_feature_likely(unsigned long feature)
 }
 
 static __always_inline bool
-alternative_has_feature_unlikely(unsigned long feature)
+alternative_has_feature_unlikely(const unsigned long feature)
 {
 	compiletime_assert(feature < ARM64_NCAPS,
 			   "feature must be < ARM64_NCAPS");
-- 
2.37.2

