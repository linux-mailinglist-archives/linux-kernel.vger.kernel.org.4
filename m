Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E945666DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbjALJMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239939AbjALJKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:10:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37105517DE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:06:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C855961F9D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C022C43396;
        Thu, 12 Jan 2023 09:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673514385;
        bh=903dKK56VBWA9nReoduRM1k/JbBxJj/M+VNo1IXCs18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkzjIZCYRCK6N2+ZVzl8WiNt48g3Hu2fgwRlh3Hbc4oMwg/noSl6WUDGeObO6ziYk
         k5ovFfyhTPYCSwMcUXEZqqY80xL49Jd//7LFlnPMoTCU/jdjE8jrbj5FUv/UDBz2qR
         I0SJiveKzzY/R0+MQB2iUzOyGEiCm32/UVLrOVqznPpcCkWM2WIGnEsjDqPBfIrnP5
         cDq/bJeuuIFiiKR9InwSLXJW+w5HCfVlxg4ViTKbCXHbgaSB1hzKeEVP0i1riQ8Bap
         4XibqqcbcZueSFAKpIS4MUrxJu3EgBE9uz5mo/M45fbq27LqtQZxQXElJLP34mzNou
         Ae/gY6/X2C3Sg==
From:   guoren@kernel.org
To:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, suagrfillet@gmail.com, andy.chiu@sifive.com,
        e.shatokhin@yadro.com, guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH -next V7 2/7] riscv: ftrace: Remove wasted nops for !RISCV_ISA_C
Date:   Thu, 12 Jan 2023 04:05:58 -0500
Message-Id: <20230112090603.1295340-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230112090603.1295340-1-guoren@kernel.org>
References: <20230112090603.1295340-1-guoren@kernel.org>
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

From: Guo Ren <guoren@linux.alibaba.com>

When CONFIG_RISCV_ISA_C=n, -fpatchable-function-entry=8 would generate
more nops than we expect. Because it treat nop opcode as 0x00000013
instead of 0x0001.

Dump of assembler code for function dw_pcie_free_msi:
   0xffffffff806fce94 <+0>:     sd      ra,-8(sp)
   0xffffffff806fce98 <+4>:     auipc   ra,0xff90f
   0xffffffff806fce9c <+8>:     jalr    -684(ra) # 0xffffffff8000bbec
<ftrace_caller>
   0xffffffff806fcea0 <+12>:    ld      ra,-8(sp)
   0xffffffff806fcea4 <+16>:    nop /* wasted */
   0xffffffff806fcea8 <+20>:    nop /* wasted */
   0xffffffff806fceac <+24>:    nop /* wasted */
   0xffffffff806fceb0 <+28>:    nop /* wasted */
   0xffffffff806fceb4 <+0>:     addi    sp,sp,-48
   0xffffffff806fceb8 <+4>:     sd      s0,32(sp)
   0xffffffff806fcebc <+8>:     sd      s1,24(sp)
   0xffffffff806fcec0 <+12>:    sd      s2,16(sp)
   0xffffffff806fcec4 <+16>:    sd      s3,8(sp)
   0xffffffff806fcec8 <+20>:    sd      ra,40(sp)
   0xffffffff806fcecc <+24>:    addi    s0,sp,48

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 12d91b0a73d8..ea5a91da6897 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -11,7 +11,11 @@ LDFLAGS_vmlinux :=
 ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
 	LDFLAGS_vmlinux := --no-relax
 	KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
+ifeq ($(CONFIG_RISCV_ISA_C),y)
 	CC_FLAGS_FTRACE := -fpatchable-function-entry=8
+else
+	CC_FLAGS_FTRACE := -fpatchable-function-entry=4
+endif
 endif
 
 ifeq ($(CONFIG_CMODEL_MEDLOW),y)
-- 
2.36.1

