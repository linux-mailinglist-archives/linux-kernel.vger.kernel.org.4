Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11B36293D6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbiKOJHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiKOJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:06:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A755410C4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:06:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43BFE6157E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DDCC433D6;
        Tue, 15 Nov 2022 09:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668503214;
        bh=lQ25xsrNZM5Z1Ywp9OfLkW92htJuaG7QNPDZY6Gaer0=;
        h=From:To:Cc:Subject:Date:From;
        b=BndV4nbll6dYyq+hmOudIIps0Es6DLuquMKLDoZ0ItQudlQ1X/ev70P8UrHfToCPz
         VdI8+mVlhmV7E7WuDj92mBMzdwGcz7K9TXpX0lVNUrkanYXOsZg8KWIAS8SgyYXzpx
         tpdwQ1iIXDc3jQOs7GKfcUoO/Q97l4xTs0et6XSnRxIdFP+A4wLMh5EaFwCQd6IltR
         Af+FHGuMSl3UvFOeiOP1i7rQRSCgBU/z0vo01MUPWHPLV8ICvhL1aFMhTc5rWWIR/P
         T/2eh11YZWSJITjq9FaiqRV+ZrVF4EZiI118gqIJNrVOXODK7qRZVJS/tQd41mqWne
         SVDwEorwYXLKw==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>,
        Samuel Holland <samuel@sholland.org>
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: mm: Proper page permissions after initmem free
Date:   Tue, 15 Nov 2022 10:06:40 +0100
Message-Id: <20221115090641.258476-1-bjorn@kernel.org>
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

64-bit RISC-V kernels have the kernel image mapped separately to alias
the linear map. The linear map and the kernel image map are documented
as "direct mapping" and "kernel" respectively in [1].

At image load time, the linear map corresponding to the kernel image
is set to PAGE_READ permission, and the kernel image map is set to
PAGE_READ|PAGE_EXEC.

When the initmem is freed, the pages in the linear map should be
restored to PAGE_READ|PAGE_WRITE, whereas the corresponding pages in
the kernel image map should be restored to PAGE_READ, by removing the
PAGE_EXEC permission.

This is not the case. For 64-bit kernels, only the linear map is
restored to its proper page permissions at initmem free, and not the
kernel image map.

In practise this results in that the kernel can potentially jump to
dead __init code, and start executing invalid instructions, without
getting an exception.

Restore the freed initmem properly, by setting both the kernel image
map to the correct permissions.

[1] Documentation/riscv/vm-layout.rst

Fixes: e5c35fa04019 ("riscv: Map the kernel with correct permissions the first time")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
v2: * Do not set the kernel image map to PAGE_WRITE. (Alex)
    * Massaged the commit message a bit.
    
Samuel, I removed your Reviewed-by:/Tested-by: for the v2.
---
 arch/riscv/kernel/setup.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 67ec1fadcfe2..86acd690d529 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -322,10 +322,11 @@ subsys_initcall(topology_init);
 
 void free_initmem(void)
 {
-	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
-		set_kernel_memory(lm_alias(__init_begin), lm_alias(__init_end),
-				  IS_ENABLED(CONFIG_64BIT) ?
-					set_memory_rw : set_memory_rw_nx);
+	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
+		set_kernel_memory(lm_alias(__init_begin), lm_alias(__init_end), set_memory_rw_nx);
+		if (IS_ENABLED(CONFIG_64BIT))
+			set_kernel_memory(__init_begin, __init_end, set_memory_nx);
+	}
 
 	free_initmem_default(POISON_FREE_INITMEM);
 }

base-commit: 22dce2b89d6043d5c3f68384285fff5506109317
-- 
2.37.2

