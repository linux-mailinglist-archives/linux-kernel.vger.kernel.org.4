Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44F367D28F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjAZRGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjAZRG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:06:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204842F7BD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:06:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 02E63CE2386
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 17:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7439AC4339B;
        Thu, 26 Jan 2023 17:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674752782;
        bh=ZvStsc5ZtEWBoYSz9j8G0L0vCieAFt37Hxf2WaPKWWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rb/s6IV3YcxZ4VRJQvCzKHhmseUDBTzSjrE4vMAt2T4RfuOHyH99josgXNwDAZjk4
         1n5ppRrKyBdEeLEItArSfRfL6vt0zUqPslv/sjyaNQ3aZErHap+aFy6ZdotoNNvoat
         QwlhZeArvCbJIUdm73XaXSsSQhDQb3MRgN6kcBHAtHRPvIyGr1c2DnKfQaO80IVr+L
         j/OiOfCE8Ot4T9ULk2AvtHmiLQIFvtCiUuBV5Hg1G/V0GKIucx7skHdI7+9cnVwuuy
         ECWwGY51kbg8gm6e1YjyOi5bALvymqIfMByitwME+oq9LKdcrCw4ONNLkt69NeB62n
         qWp/MSASdtLdw==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        mhiramat@kernel.org, conor.dooley@microchip.com,
        penberg@kernel.org, mark.rutland@arm.com, jrtc27@jrtc27.com,
        andy.chiu@sifive.com, zong.li@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greentime Hu <greentime.hu@sifive.com>
Subject: [PATCH -next V3 1/2] riscv: jump_label: Fixup unaligned arch_static_branch function
Date:   Thu, 26 Jan 2023 12:06:06 -0500
Message-Id: <20230126170607.1489141-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230126170607.1489141-1-guoren@kernel.org>
References: <20230126170607.1489141-1-guoren@kernel.org>
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

Runtime code patching must be done at a naturally aligned address, or we
may execute on a partial instruction.

We have encountered problems traced back to static jump functions during
the test. We switched the tracer randomly for every 1~5 seconds on a
dual-core QEMU setup and found the kernel sucking at a static branch
where it jumps to itself.

The reason is that the static branch was 2-byte but not 4-byte aligned.
Then, the kernel would patch the instruction, either J or NOP, with two
half-word stores if the machine does not have efficient unaligned
accesses. Thus, moments exist where half of the NOP mixes with the other
half of the J when transitioning the branch. In our particular case, on
a little-endian machine, the upper half of the NOP was mixed with the
lower part of the J when enabling the branch, resulting in a jump that
jumped to itself. Conversely, it would result in a HINT instruction when
disabling the branch, but it might not be observable.

ARM64 does not have this problem since all instructions must be 4-byte
aligned.

Fixes: ebc00dde8a97 ("riscv: Add jump-label implementation")
Link: https://lore.kernel.org/linux-riscv/20220913094252.3555240-6-andy.chiu@sifive.com/
Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/jump_label.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/jump_label.h b/arch/riscv/include/asm/jump_label.h
index 6d58bbb5da46..14a5ea8d8ef0 100644
--- a/arch/riscv/include/asm/jump_label.h
+++ b/arch/riscv/include/asm/jump_label.h
@@ -18,6 +18,7 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
 					       const bool branch)
 {
 	asm_volatile_goto(
+		"	.align		2			\n\t"
 		"	.option push				\n\t"
 		"	.option norelax				\n\t"
 		"	.option norvc				\n\t"
@@ -39,6 +40,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key * const ke
 						    const bool branch)
 {
 	asm_volatile_goto(
+		"	.align		2			\n\t"
 		"	.option push				\n\t"
 		"	.option norelax				\n\t"
 		"	.option norvc				\n\t"
-- 
2.36.1

