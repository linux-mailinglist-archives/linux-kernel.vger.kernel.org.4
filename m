Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85095F85B6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 17:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJHPES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 11:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJHPEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 11:04:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928BA4DF3A
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 08:04:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D84DB80B6E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 15:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4FCC433C1;
        Sat,  8 Oct 2022 15:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665241452;
        bh=J+gfA2GKcuRxn0BEYcHVwUZ7oMqdte5iqfeI/xohk88=;
        h=From:To:Cc:Subject:Date:From;
        b=Jf2DOxvz9yFjX1VXkMwTAfJE15c8TB2RlK0FcletkolNdtbcf7zekJ4zE2BOmuXQp
         QlMfgcuPHuPsqtcQxuTK7McBdDwBa03K0WTPjxfpWUyBD7TsKyuj1mmU336oKMOclJ
         hD2N/j2/rXQwOoMfPqWdpBslW8A39vf4NNb4IpNx/nwYeMPpimtM8Ndt//ofpWWY6i
         GIe5dStefpbt9BlLRqduIuFuRTXRIzBQMzFOIp7is/ULxf2rQpt47Cd3KM99t4uuYp
         7DPaGl1uAlFPQ9WwzzrHbRJNo2T3cm8dFcYMZ5HYQ1ht1qrCD7K+AQfVURhKhcObU0
         E6sm2v844bAEQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Samuel Holland <samuel@sholland.org>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v2] riscv: jump_label: mark arguments as const to satisfy asm constraints
Date:   Sat,  8 Oct 2022 22:54:37 +0800
Message-Id: <20221008145437.491-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel reported that the static branch usage in cpu_relax() breaks
building with CONFIG_CC_OPTIMIZE_FOR_SIZE:

In file included from <command-line>:
./arch/riscv/include/asm/jump_label.h: In function 'cpu_relax':
././include/linux/compiler_types.h:285:33: warning: 'asm' operand 0
probably does not match constraints
  285 | #define asm_volatile_goto(x...) asm goto(x)
      |                                 ^~~
./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro
'asm_volatile_goto'
   41 |         asm_volatile_goto(
      |         ^~~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:285:33: error: impossible constraint
in 'asm'
  285 | #define asm_volatile_goto(x...) asm goto(x)
      |                                 ^~~
./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro
'asm_volatile_goto'
   41 |         asm_volatile_goto(
      |         ^~~~~~~~~~~~~~~~~
make[1]: *** [scripts/Makefile.build:249:
arch/riscv/kernel/vdso/vgettimeofday.o] Error 1
make: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2

Maybe "-Os" prevents GCC from detecting that the key/branch arguments
can be treated as constants and used as immediate operands. Inspired
by x86's commit 864b435514b2("x86/jump_label: Mark arguments as const to
satisfy asm constraints"), and as pointed out by Steven: "The "i"
constraint needs to be a constant.", let's do similar modifications to
riscv.

Tested by CC_OPTIMIZE_FOR_SIZE + gcc and CC_OPTIMIZE_FOR_SIZE + clang.

Link: https://lore.kernel.org/linux-riscv/20220922060958.44203-1-samuel@sholland.org/
Link: https://lore.kernel.org/all/20210212094059.5f8d05e8@gandalf.local.home/
Fixes: 8eb060e10185 ("arch/riscv: add Zihintpause support")
Reported-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---

since v1:
 - add Reported-by, Reviewed-by, Fixes and Link tag

 arch/riscv/include/asm/jump_label.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/jump_label.h b/arch/riscv/include/asm/jump_label.h
index 38af2ec7b9bf..6d58bbb5da46 100644
--- a/arch/riscv/include/asm/jump_label.h
+++ b/arch/riscv/include/asm/jump_label.h
@@ -14,8 +14,8 @@
 
 #define JUMP_LABEL_NOP_SIZE 4
 
-static __always_inline bool arch_static_branch(struct static_key *key,
-					       bool branch)
+static __always_inline bool arch_static_branch(struct static_key * const key,
+					       const bool branch)
 {
 	asm_volatile_goto(
 		"	.option push				\n\t"
@@ -35,8 +35,8 @@ static __always_inline bool arch_static_branch(struct static_key *key,
 	return true;
 }
 
-static __always_inline bool arch_static_branch_jump(struct static_key *key,
-						    bool branch)
+static __always_inline bool arch_static_branch_jump(struct static_key * const key,
+						    const bool branch)
 {
 	asm_volatile_goto(
 		"	.option push				\n\t"
-- 
2.37.2

