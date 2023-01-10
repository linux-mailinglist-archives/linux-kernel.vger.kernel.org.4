Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED12663A68
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbjAJIFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbjAJIEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:04:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D26237250
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:04:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D621B810FE
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B47C433D2;
        Tue, 10 Jan 2023 08:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673337883;
        bh=5Wa/I8iPWXYq4EtfoTuN8CIETGpW0mcYV16o+ZIQb0s=;
        h=From:To:Cc:Subject:Date:From;
        b=o0n5lmbCHXUilcZgN67fSb0kHZhmYurEURBnz2aANtb7fEmon6LfscWTpyk2UaIId
         7SdowYfjZAQUMsGeSDAG8ozCKW/cqyHZuGuYiZ9XsA3muhdizIP+G1mr94x84TsK5v
         xmWA1EbB2kF0ZnVV8o3m9HnLOytW7kjoK0OxEP1jq8au8NpB3lJstse3KEGW90BFbV
         sS3zptGl4hoe3cFNE60EHZOqKWkRyGdu1ebf2j5oZX4CLyXlAGCAgIaDQatjKEB3Zv
         RLWO++k7/Cjhva2Tc+xJooe556duXejs+KH5mikbkbZRKUEO/gG/+voMMpBF4qbLY/
         5u+rbIEiHIU6g==
From:   guoren@kernel.org
To:     guoren@kernel.org, alexandre.ghiti@canonical.com,
        palmer@dabbelt.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] riscv: pgtable: Fixup comment for KERN_VIRT_SIZE
Date:   Tue, 10 Jan 2023 03:04:19 -0500
Message-Id: <20230110080419.931185-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
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

KERN_VIRT_SIZE is 1/4 of the entries of the page global directory,
not half.

Fixes: f7ae02333d13 ("riscv: Move KASAN mapping next to the kernel mapping")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 4eba9a98d0e3..2a88362dffa5 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -31,7 +31,7 @@
 #define PTRS_PER_PTE    (PAGE_SIZE / sizeof(pte_t))
 
 /*
- * Half of the kernel address space (half of the entries of the page global
+ * Half of the kernel address space (1/4 of the entries of the page global
  * directory) is for the direct mapping.
  */
 #define KERN_VIRT_SIZE          ((PTRS_PER_PGD / 2 * PGDIR_SIZE) / 2)
-- 
2.36.1

