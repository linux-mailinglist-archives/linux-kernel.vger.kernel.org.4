Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FA870F78B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjEXNYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbjEXNYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:24:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF332B6
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:24:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79D1863303
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 13:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE71C433EF;
        Wed, 24 May 2023 13:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684934656;
        bh=X7w8UNBEZj68xoYR2+1fzYHN1lzC2y2GrI0EwehDjsk=;
        h=From:To:Cc:Subject:Date:From;
        b=FLq4/MnXaZ6eJCMpPSag8E23usYfdLGrPnSBlHVhAgabRu7U8V+uwZHsFtnpICY7k
         NfA6c416MaBVqIjhbewttDxwAO4dCAYiMavTYtF+tdsn8KRBPZJvoBJKDN+cPTUO3j
         qehqPW4nDLe3SiC9miRmYVhumkrU/a4/vyiFkQ2wmOjly6+L5Cl+KSqc9YR4yxJxDv
         Fsm8eLSE3zEsOJagRcd8mGUeZaPa/MjVvdlxS2Y+HaLRBrrbwZCzyjL997lIQMDR0u
         oZjUVo1tG5+H7Dtg8FxWuYn2U9awNGjVuG/XsKp+hJOI7mtI6zIBGmzbBOidleMP77
         yuf1G+DOrcoQg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH] arm64: mm: pass original fault address to handle_mm_fault() in PER_VMA_LOCK block
Date:   Wed, 24 May 2023 21:13:05 +0800
Message-Id: <20230524131305.2808-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
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

When reading the arm64's PER_VMA_LOCK support code, I found a bit
difference between arm64 and other arch when calling handle_mm_fault()
during VMA lock-based page fault handling: the fault address is masked
before passing to handle_mm_fault(). This is also different from the
usage in mmap_lock-based handling. I think we need to pass the
original fault address to handle_mm_fault() as we did in
commit 84c5e23edecd ("arm64: mm: Pass original fault address to
handle_mm_fault()").

If we go through the code path further, we can find that the "masked"
fault address can cause mismatched fault address between perf sw
major/minor page fault sw event and perf page fault sw event:

do_page_fault
  perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, ..., addr)   // orig addr
  handle_mm_fault
    mm_account_fault
      perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, ...) // masked addr

Fixes: cd7f176aea5f ("arm64/mm: try VMA lock-based page fault handling first")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/arm64/mm/fault.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index cb21ccd7940d..6045a5117ac1 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -600,8 +600,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		vma_end_read(vma);
 		goto lock_mmap;
 	}
-	fault = handle_mm_fault(vma, addr & PAGE_MASK,
-				mm_flags | FAULT_FLAG_VMA_LOCK, regs);
+	fault = handle_mm_fault(vma, addr, mm_flags | FAULT_FLAG_VMA_LOCK, regs);
 	vma_end_read(vma);
 
 	if (!(fault & VM_FAULT_RETRY)) {
-- 
2.40.1

