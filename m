Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EF466B29C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 17:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjAOQiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 11:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjAOQil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 11:38:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CB1C65D
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 08:38:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D81F60C84
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 16:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C396C433D2;
        Sun, 15 Jan 2023 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673800709;
        bh=4CyV238BW6buQA/dtLPqJucBf3kAZWi8xQWfny1Z+yo=;
        h=From:To:Cc:Subject:Date:From;
        b=PQKd8QgV6dvP8P301dN0tE5afY5Wm9uXtm+/6WQV/iWzp3Quxx3vYQySiASSvQkC8
         FbvHfLy3VREXlVn3JNf7LMLvT3+/BEylZzY+rGg3X6wuXE478LUha2AhQ7sFYLGRsO
         te+kkuWk3/HQbnnCxT48UeZ40o1MWVccAXniOAknsm15KuZGIZtjabm3Ve35IFKYbL
         KfxFbd7dkb9FjyWnU5IUXHNu1pQixVEnTdIdfCbYmBLkaJJncgU2IIOFzduzy4wrad
         EJAkjJ5AF7alpCje0fvesrGUlJNOQBVzNXfBV+/fjBS5h+hN/4BKMaR9wKO7OKl/WV
         8sEGJ3CBR/DGg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: alternative: proceed one more instruction for auipc/jalr pair
Date:   Mon, 16 Jan 2023 00:28:11 +0800
Message-Id: <20230115162811.3146-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.38.1
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

If we patched auipc + jalr pair, we'd better proceed one more
instruction. Andrew pointed out "There's not a problem now, since
we're only adding a fixup for jal, not jalr, but we should
future-proof this and there's no reason to revisit an already fixed-up
instruction anyway."

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Suggested-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/alternative.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index fc341b69bf62..2354c69dc7d1 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -122,6 +122,7 @@ void riscv_alternative_fix_offsets(void *alt_ptr, unsigned int len,
 
 			riscv_alternative_fix_auipc_jalr(alt_ptr + i * sizeof(u32),
 							 insn, insn2, patch_offset);
+			i++;
 		}
 
 		if (riscv_insn_is_jal(insn)) {
-- 
2.38.1

