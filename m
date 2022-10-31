Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55542613D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJaSj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJaSj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:39:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B309DDF77
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69A53B819A9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2632C433C1;
        Mon, 31 Oct 2022 18:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667241564;
        bh=It14nDJvTqCUwHf/PuycyXWi6Kbor6f6XNY4NSVwgLE=;
        h=From:To:Cc:Subject:Date:From;
        b=BjgfbnyQkRTF0+PkDkOegY6LaF3LwWV0vcYyqsL3bgIUuoftJO1AgskCxUc/LvLSI
         lazDQKYdKatIhtRYHTVuw+X6AFDD77Lyt4q1Y/SL6I/JX5ELPVSSz9Z71+9UrYP1zX
         yoYqsnCZFcs7RWp91IiXeSphXoUaimfoHtLHjKYBkginNuaa203nnreCe0/bx4aEor
         bd4n2WrOnXiP2fP+ucM6f1vNqmPENJI71T19HHkxNPJLLylilyeRKtg3YREQvtpAjw
         NRxBoDsnrHiW9c/W8ghfPvqdv9zYLUDaj7ChG6MmNFT8x+pjT4v68iO8vxVE1/mPx0
         Ivtd/6+a33yzA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: vdso: fix build with llvm
Date:   Tue,  1 Nov 2022 02:29:43 +0800
Message-Id: <20221031182943.2453-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even after commit 89fd4a1df829 ("riscv: jump_label: mark arguments as
const to satisfy asm constraints"), building with CC_OPTIMIZE_FOR_SIZE
+ LLVM=1 can reproduce below build error:

  CC      arch/riscv/kernel/vdso/vgettimeofday.o
In file included from <built-in>:4:
In file included from lib/vdso/gettimeofday.c:5:
In file included from include/vdso/datapage.h:17:
In file included from
include/vdso/processor.h:10:
In file included from
arch/riscv/include/asm/vdso/processor.h:7:
In file included from
include/linux/jump_label.h:112:
arch/riscv/include/asm/jump_label.h:42:3: error:
invalid operand fo
r inline asm constraint 'i'
                "       .option push                            \n\t"
                ^
1 error generated.

I think the problem is when "-Os" is passed as CFLAGS, it's removed by
"CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os" which is
introduced in commit e05d57dcb8c7 ("riscv: Fixup __vdso_gettimeofday
broke dynamic ftrace"), thus no optimization at all for vgettimeofday.c
arm64 does remove "-Os" as well, but it forces "-O2" after removing
"-Os".

I compared the generated vgettimeofday.o with "-O2" and "-Os",
I think no big performance difference. So let's tell the kbuild not
to remove "-Os" rather than follow arm64 style.

vdso related performance can be improved a lot when building kernel with
CC_OPTIMIZE_FOR_SIZE after this commit, ("-Os" VS no optimization)

Fixes: e05d57dcb8c7 ("riscv: Fixup __vdso_gettimeofday broke dynamic ftrace")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index f2e065671e4d..84ac0fe612e7 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -30,7 +30,7 @@ obj-y += vdso.o
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 
 # Disable -pg to prevent insert call site
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE)
 
 # Disable profiling and instrumentation for VDSO code
 GCOV_PROFILE := n
-- 
2.37.2

