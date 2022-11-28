Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1DD63ACB1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiK1Pei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiK1Peh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:34:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1C55FD2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:34:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAD0161053
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 15:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EB5C433C1;
        Mon, 28 Nov 2022 15:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669649675;
        bh=S8NODlgq6yx6QV34sB+y37vgj9EEiEXVMGyItAX775s=;
        h=From:To:Cc:Subject:Date:From;
        b=f79Po3mBof5dcoujxSful43bPbrxJczrsl0eYLUe2UsHHGS/HlmTKuS3NWehoRbGb
         4EwfJ+1RkWCVOoEsD/j5E2XMNm5f4T+6uuNySlnUkwt0k3BcWOipoLrMSB02ny3ss/
         O4xCi5DS36CE4jorzan095InEXC30vhFd2wcqucxHbdJy8SpGkNyrG1n8EYizw+wIk
         BEtonJAmwDZfOs0v8MF1Qx8ie56EY7LxJBxvNFlDK+mtpgXLexWLigZxoEwGDQ+gUH
         9fenw6T7emij2c+mkWoew8caLViQntHvIcq0WyxXxaJ0IlELEzTevlHuvFoFNOBFEM
         lx9WW97d2W8Sw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: head: use 0 as the default text_offset
Date:   Mon, 28 Nov 2022 23:24:42 +0800
Message-Id: <20221128152442.3403-1-jszhang@kernel.org>
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

Commit 0f327f2aaad6 ("RISC-V: Add an Image header that boot loader can
parse.") adds an image header which "is based on ARM64 boot image
header and provides an opportunity to combine both ARM64 & RISC-V
image headers in future.". At that time, arm64's default text_offset
is 0x80000, this is to give "512 KB of guaranteed BSS space to put
the swapper page tables" as commit cfa7ede20f13 ("arm64: set TEXT_OFFSET
to 0x0 in preparation for removing it entirely") pointed out, but
riscv doesn't need the space, so use 0 as the default text_offset.

Before this patch, booting linux kernel on Sipeed bl808 M1s Dock
with u-boot booti cmd:
[    0.000000] OF: fdt: Ignoring memory range 0x50000000 - 0x50200000
...
[    0.000000]   DMA32    [mem 0x0000000050200000-0x0000000053ffffff]
As can be seen, 2MB DDR(0x50000000 - 0x501fffff) can't be used by
linux.

After this patch, the 64MB DDR is fully usable by linux
[    0.000000]   DMA32    [mem 0x0000000050000000-0x0000000053ffffff]

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/head.S | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index b865046e4dbb..ef95943f7a70 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -38,18 +38,8 @@ ENTRY(_start)
 	.word 0
 #endif
 	.balign 8
-#ifdef CONFIG_RISCV_M_MODE
-	/* Image load offset (0MB) from start of RAM for M-mode */
+	/* Image load offset (0MB) from start of RAM */
 	.dword 0
-#else
-#if __riscv_xlen == 64
-	/* Image load offset(2MB) from start of RAM */
-	.dword 0x200000
-#else
-	/* Image load offset(4MB) from start of RAM */
-	.dword 0x400000
-#endif
-#endif
 	/* Effective size of kernel image */
 	.dword _end - _start
 	.dword __HEAD_FLAGS
-- 
2.37.2

