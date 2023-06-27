Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28442740664
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 00:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjF0WOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 18:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjF0WOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:14:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9571FCD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:14:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 638AB61239
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 22:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC2FC433C0;
        Tue, 27 Jun 2023 22:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687904084;
        bh=PWkigw51oTYP+QIZeGiN4X++ycxgw6EELB6XK+Bx1vw=;
        h=From:To:Cc:Subject:Date:From;
        b=XerVoOK0uI9k692hzjtE2HMcyTWHTJoxtigXk8K/TM2i4cLAstZzJUvN/wvW5VQV7
         9CbGCLwjBq2zY7ai8tLoMx/tvETP2XXCmcmTK3awbJjL2I9YG4n6J62BVOLq4NO0kQ
         qra5WzkLK+50FtAsXyEjZ6YjX2ohn6iibEdHs3OQwfuwWntIv2WbCiSEiB58hwkll/
         Qa4SAp3+YAuUlBT3CQTMHCuhGHU9Tu9tyYdQHc2QhsIBGcDQV8oT/L0ogXTM2smj4I
         W4TK3yme41VLqb6d6m+0X3U2tc9zeGn2FJk00ofzWBKbg1WOw6/R2iyeh3VaAxbPfl
         v/KFm8MsUuItw==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, vishal.moola@gmail.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au
Subject: [PATCH] Revert "nios2: Convert __pte_free_tlb() to use ptdescs"
Date:   Tue, 27 Jun 2023 17:14:30 -0500
Message-Id: <20230627221430.464073-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6ebe94baa2b9ddf3ccbb7f94df6ab26234532734.

The patch "nios2: Convert __pte_free_tlb() to use ptdescs" was supposed
to go together with a patchset that Vishal Moola had planned taking it
through the mm tree. By just having this patch, all NIOS2 builds are
broken.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/nios2/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index ce6bb8e74271..ecd1657bb2ce 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -28,10 +28,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)					\
-	do {								\
-		pagetable_pte_dtor(page_ptdesc(pte));			\
-		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
+#define __pte_free_tlb(tlb, pte, addr)				\
+	do {							\
+		pgtable_pte_page_dtor(pte);			\
+		tlb_remove_page((tlb), (pte));			\
 	} while (0)
 
 #endif /* _ASM_NIOS2_PGALLOC_H */
-- 
2.25.1

