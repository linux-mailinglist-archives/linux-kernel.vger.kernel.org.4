Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6A7660F33
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 14:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjAGNgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 08:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjAGNgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 08:36:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDA7115D
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 05:36:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA480B80EBF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 13:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6882AC433F1;
        Sat,  7 Jan 2023 13:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673098568;
        bh=V792wXFwxvPtjCh6mve4UN0IqpgiVRIo4oWLOTpVhcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s7tw01/FJa7C+JS9FZn2vOZ1EHRhzYsw4UqVMHAqi+KSlSeQe11jXV0Z0nBNBHqUq
         lgt/sMmwoJSGgpgzejN67lpJZYcSogDUvOGDUXWwVIT4DgT/cRD16fPc9UTPCmi+M3
         LXQc5TwDcZqfJmuhyWwCYXbCbdaXZRZtxGZrDaotUQjfmSzMfrtgKyLnx/c0z1QlvW
         SlCvNWugTwm827ZEnjOS9zXnUeUmAPZmAG4/tr6Ra6Ne1jM2RMlo9eDIxJn/XVp+jW
         IM5OA0GxZjo74KJ36V6CHx9C+G9PFmAUJPuZ7ZDQb39yb+hZ4RBUViYyGBNvu7V6nl
         0CjAy+71op0kA==
From:   guoren@kernel.org
To:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, suagrfillet@gmail.com, andy.chiu@sifive.com,
        e.shatokhin@yadro.com, guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next V6 1/7] riscv: ftrace: Fixup panic by disabling preemption
Date:   Sat,  7 Jan 2023 08:35:43 -0500
Message-Id: <20230107133549.4192639-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230107133549.4192639-1-guoren@kernel.org>
References: <20230107133549.4192639-1-guoren@kernel.org>
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

Fixes: afc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")
Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e2b656043abf..ee0d39b26794 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -138,7 +138,7 @@ config RISCV
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
-	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
+	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
 
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
-- 
2.36.1

