Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE14636422
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbiKWPkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238355AbiKWPkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:40:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20283FAE5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:40:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF68BB8216D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDE3C433D7;
        Wed, 23 Nov 2022 15:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669218009;
        bh=klemdwhmvdHm8UXMNKhz8vGyWWFdhO3duaUDPADUSqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BSGNtn91mrpp3bPJslAbgOWWcK/5+OU23WPXON7/FejtddmER7EHhkkS7MhuXO4ca
         W0AcRvSsbkvIBDYZ6REPQVDE5h+PZtldLD6nC5VqrbD0EDTg2YR0+Dk0WiZ2b1lo5T
         f+ILD5bLCug436RG/pF8ojzCrvAiCKp/ef8gLaAr6Ty4naE0Evd41erwlbMMHxZkxG
         mwAovIg1UoZDcga8X/4pR/UGIhVdbR0rf5SuCrL3GrWxVvheYVzmWL+OvdtnvYTO1m
         YKOlNf2BVVW8AlIORzuzO1o5NNbkYrJ8z96wXJmgqc+AGB1J9EFf6srFoptvADgZoj
         SLOnrRYMjC/MA==
From:   guoren@kernel.org
To:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, suagrfillet@gmail.com, andy.chiu@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V3 1/5] riscv: ftrace: Fixup panic by disabling preemption
Date:   Wed, 23 Nov 2022 10:39:46 -0500
Message-Id: <20221123153950.2911981-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221123153950.2911981-1-guoren@kernel.org>
References: <20221123153950.2911981-1-guoren@kernel.org>
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

From: Andy Chiu <andy.chiu@sifive.com>

In RISCV, we must use an AUIPC + JALR pair to encode an immediate,
forming a jump that jumps to an address over 4K. This may cause errors
if we want to enable kernel preemption and remove dependency from
patching code with stop_machine(). For example, if a task was switched
out on auipc. And, if we changed the ftrace function before it was
switched back, then it would jump to an address that has updated 11:0
bits mixing with previous XLEN:12 part.

p: patched area performed by dynamic ftrace
ftrace_prologue:
p|      REG_S   ra, -SZREG(sp)
p|      auipc   ra, 0x? ------------> preempted
					...
				change ftrace function
					...
p|      jalr    -?(ra) <------------- switched back
p|      REG_L   ra, -SZREG(sp)
func:
	xxx
	ret

Fixes: fc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")
Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
@Andy, could you give the patch a Signed-off-by? I just copy your most
important comment, so the first author should be you. First, let's fix
the problem caused by my previous patch, and you can continue your
ftrace preemption work.
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7cd981f96f48..1d0e5838b11b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -280,7 +280,7 @@ config ARCH_RV64I
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
-	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
+	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
 	select SWIOTLB if MMU
 
 endchoice
-- 
2.36.1

