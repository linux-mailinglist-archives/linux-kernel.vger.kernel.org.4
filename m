Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C7262692E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 12:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbiKLLg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 06:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiKLLgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 06:36:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC867D2EF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:36:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90788B80833
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 11:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B5DC433D6;
        Sat, 12 Nov 2022 11:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668252979;
        bh=hDVkWMmXvy2usab42Pc4A58JK6SsyDaWks6I8QgP8bk=;
        h=From:To:Cc:Subject:Date:From;
        b=SjXafSr5zGyfTqqO0sFinbDUJUaU5S/UA2HoFSWvFS5lMOl+CUuzlfdh9RcQaFQNy
         pnNseQmagf4UeJB/kNtF0bHhmJbvvFMEh4LXdiRN5rOJ7UchYwfZHGhlgYcfXMGPoW
         w1J4SMKXVuV7bWpegZPcFmyz1KkzM2ciLMNAZQCsnK6dQwN2Kx1pD1uRQwi+3YSf68
         v7KSJT9/V8E7HXuAHMZ45SjsL3YkRG6PcdzYEriMdI5JhTVr0kKWa+raZqQr/oV7T7
         VuyCJIamdjNv+GPCZmSHQTvbfwpvJZHJ8qeehk03cGxrMkKI14Qpj3AOzu97LWUIIs
         3gvvZETRV/IXA==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: mm: Proper page permissions after initmem free
Date:   Sat, 12 Nov 2022 12:35:43 +0100
Message-Id: <20221112113543.3165646-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.37.2
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

From: Björn Töpel <bjorn@rivosinc.com>

64-bit RISC-V kernels have the kernel image mapped separately, and in
addition to the linear map. When the kernel is loaded, the linear map
of kernel image is set to PAGE_READ permission, and the kernel map is
set to PAGE_READ and PAGE_EXEC.

When the initmem is freed, the corresponding pages in the linear map
should be restored to PAGE_READ and PAGE_WRITE. The corresponding
pages in the kernel map should also be restored to PAGE_READ and
PAGE_WRITE, by removing the PAGE_EXEC permission, and adding
PAGE_WRITE.

This is not the case. For 64-bit kernels, only the linear map is
restored to its proper page permissions at initmem free, and not the
kernelmap.

In practise this results in that the kernel can potentially jump to
dead __init code, and start executing invalid 0xcc instructions,
without getting an exception.

Restore the freed initmem properly, by setting both the alias (kernel
map) and the linear map to the correct permissions.

Fixes: e5c35fa04019 ("riscv: Map the kernel with correct permissions the first time")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/kernel/setup.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index ad76bb59b059..361e635070fe 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -321,10 +321,12 @@ subsys_initcall(topology_init);
 
 void free_initmem(void)
 {
-	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
-		set_kernel_memory(lm_alias(__init_begin), lm_alias(__init_end),
-				  IS_ENABLED(CONFIG_64BIT) ?
-					set_memory_rw : set_memory_rw_nx);
+	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
+		if (IS_ENABLED(CONFIG_64BIT))
+			set_kernel_memory(lm_alias(__init_begin), lm_alias(__init_end),
+					  set_memory_rw);
+		set_kernel_memory(__init_begin, __init_end, set_memory_rw_nx);
+	}
 
 	free_initmem_default(POISON_FREE_INITMEM);
 }

base-commit: 442bcbfd2c5401587b983e34bed0b407214735c3
-- 
2.37.2

