Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48ED7149D8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjE2NFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjE2NFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:05:11 -0400
X-Greylist: delayed 427 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 May 2023 06:05:07 PDT
Received: from hogfather.0x04.net (84-10-63-242.static.chello.pl [84.10.63.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36DCD9
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:05:07 -0700 (PDT)
Received: by hogfather.0x04.net (Postfix, from userid 1000)
        id 746B04A05DE; Mon, 29 May 2023 14:57:58 +0200 (CEST)
From:   =?UTF-8?q?Marcelina=20Ko=C5=9Bcielnicka?= <mwk@0x04.net>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?q?Marcelina=20Ko=C5=9Bcielnicka?= <mwk@0x04.net>
Subject: [PATCH] x86/vdso: Limit vdso allocation to 47-bit address space
Date:   Mon, 29 May 2023 14:57:09 +0200
Message-Id: <20230529125709.1882042-1-mwk@0x04.net>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vdso is normally allocated after the stack, with a random offset.
With ADDR_NO_RANDOMIZE and without 57-bit virtual addressing, the stack is
too close to the canonical address hole to fit the vdso after it, so it
reverts to normal mmap handling, resulting in something like the
following (deterministic) address map:

[...]
7ffff7fc4000-7ffff7fc8000 r--p 00000000 00:00 0                          [vvar]
7ffff7fc8000-7ffff7fca000 r-xp 00000000 00:00 0                          [vdso]
7ffff7fca000-7ffff7fcb000 r--p 00000000 fe:01 1183001                    /usr/lib/ld-linux-x86-64.so.2
7ffff7fcb000-7ffff7ff1000 r-xp 00001000 fe:01 1183001                    /usr/lib/ld-linux-x86-64.so.2
7ffff7ff1000-7ffff7ffb000 r--p 00027000 fe:01 1183001                    /usr/lib/ld-linux-x86-64.so.2
7ffff7ffb000-7ffff7ffd000 r--p 00031000 fe:01 1183001                    /usr/lib/ld-linux-x86-64.so.2
7ffff7ffd000-7ffff7fff000 rw-p 00033000 fe:01 1183001                    /usr/lib/ld-linux-x86-64.so.2
7ffffffde000-7ffffffff000 rw-p 00000000 00:00 0                          [stack]
ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]

However, on a CPU with LA57 support, allocating the vdso after the stack
actually succeeds and results in something like the following:

[...]
7ffff7fca000-7ffff7fcb000 r--p 00000000 fe:01 1183001                    /usr/lib/ld-linux-x86-64.so.2
7ffff7fcb000-7ffff7ff1000 r-xp 00001000 fe:01 1183001                    /usr/lib/ld-linux-x86-64.so.2
7ffff7ff1000-7ffff7ffb000 r--p 00027000 fe:01 1183001                    /usr/lib/ld-linux-x86-64.so.2
7ffff7ffb000-7ffff7ffd000 r--p 00031000 fe:01 1183001                    /usr/lib/ld-linux-x86-64.so.2
7ffff7ffd000-7ffff7fff000 rw-p 00033000 fe:01 1183001                    /usr/lib/ld-linux-x86-64.so.2
7ffffffde000-7ffffffff000 rw-p 00000000 00:00 0                          [stack]
8000001be000-8000001c2000 r--p 00000000 00:00 0                          [vvar]
8000001c2000-8000001c4000 r-xp 00000000 00:00 0                          [vdso]

The resulting map has two problems:

1. The vdso mapping address is non-deterministic, since the
   get_random_u32_below call in vdso_addr is called unconditionally,
   without taking PF_RANDOMIZE into account.
2. The vdso is mapped outside of the legacy 47-bit address space,
   needlessly allocating 4 page tables and violating the principles
   outlined in Documentation/x86/x86_64/5level-paging.rst

This patch forces vdso allocation range to always be within the 47-bit
space, ensuring consistent results between LA57 and non-LA57 systems.

Signed-off-by: Marcelina Kościelnicka <mwk@0x04.net>
---
 arch/x86/entry/vdso/vma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 2738eb28cb2e..1f4bdbadae1e 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -301,8 +301,8 @@ static unsigned long vdso_addr(unsigned long start, unsigned len)
 
 	/* Round the lowest possible end address up to a PMD boundary. */
 	end = (start + len + PMD_SIZE - 1) & PMD_MASK;
-	if (end >= TASK_SIZE_MAX)
-		end = TASK_SIZE_MAX;
+	if (end >= DEFAULT_MAP_WINDOW)
+		end = DEFAULT_MAP_WINDOW;
 	end -= len;
 
 	if (end > start) {
-- 
2.40.1

