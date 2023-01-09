Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5886D661F7F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjAIHz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbjAIHz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:55:29 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A844FDF3B
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 23:55:20 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3097sot6026017;
        Mon, 9 Jan 2023 08:54:50 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3/6] tools/nolibc: restore mips branch ordering in the _start block
Date:   Mon,  9 Jan 2023 08:54:39 +0100
Message-Id: <20230109075442.25963-4-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230109075442.25963-1-w@1wt.eu>
References: <20230109075442.25963-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the compiler used and the optimization options, the sbrk()
test was crashing, both on real hardware (mips-24kc) and in qemu. One
such example is kernel.org toolchain in version 11.3 optimizing at -Os.

Inspecting the sys_brk() call shows the following code:

  0040047c <sys_brk>:
    40047c:       24020fcd        li      v0,4045
    400480:       27bdffe0        addiu   sp,sp,-32
    400484:       0000000c        syscall
    400488:       27bd0020        addiu   sp,sp,32
    40048c:       10e00001        beqz    a3,400494 <sys_brk+0x18>
    400490:       00021023        negu    v0,v0
    400494:       03e00008        jr      ra

It is obviously wrong, the "negu" instruction is placed in beqz's
delayed slot, and worse, there's no nop nor instruction after the
return, so the next function's first instruction (addiu sip,sip,-32)
will also be executed as part of the delayed slot that follows the
return.

This is caused by the ".set noreorder" directive in the _start block,
that applies to the whole program. The compiler emits code without the
delayed slots and relies on the compiler to swap instructions when this
option is not set. Removing the option would require to change the
startup code in a way that wouldn't make it look like the resulting
code, which would not be easy to debug. Instead let's just save the
default ordering before changing it, and restore it at the end of the
_start block. Now the code is correct:

  0040047c <sys_brk>:
    40047c:       24020fcd        li      v0,4045
    400480:       27bdffe0        addiu   sp,sp,-32
    400484:       0000000c        syscall
    400488:       10e00002        beqz    a3,400494 <sys_brk+0x18>
    40048c:       27bd0020        addiu   sp,sp,32
    400490:       00021023        negu    v0,v0
    400494:       03e00008        jr      ra
    400498:       00000000        nop

Fixes: 66b6f755ad45 ("rcutorture: Import a copy of nolibc") #5.0
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-mips.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 5fc5b8029bff..7380093ba9e7 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -192,6 +192,7 @@ struct sys_stat_struct {
 __asm__ (".section .text\n"
     ".weak __start\n"
     ".set nomips16\n"
+    ".set push\n"
     ".set    noreorder\n"
     ".option pic0\n"
     ".ent __start\n"
@@ -210,6 +211,7 @@ __asm__ (".section .text\n"
     "li $v0, 4001\n"              // NR_exit == 4001
     "syscall\n"
     ".end __start\n"
+    ".set pop\n"
     "");
 
 #endif // _NOLIBC_ARCH_MIPS_H
-- 
2.35.3

