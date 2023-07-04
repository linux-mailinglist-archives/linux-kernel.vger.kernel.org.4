Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C61E7466B7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 03:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGDBAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 21:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGDBAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 21:00:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BD4136
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 18:00:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E60761017
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 01:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F99AC433C8;
        Tue,  4 Jul 2023 01:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688432406;
        bh=MXEys2E3ebeRfuAMK0DK9Y1JAWgYItda1NlZ4Ml4tAY=;
        h=From:To:Cc:Subject:Date:From;
        b=Xdelt5iKzAzXP8FeIZ/EEjKyFuqIK/Y2AYQ0elzbE8cfG0jq1iouQYhwXdyQAP7FU
         niNKE23QECbXgkeryxZAS2RcJZomY8PdhNeQLm7kiCctbukYK6hasStvIXKW4iwfkJ
         9tGG9JgHcoZUK9/K21ZFZjgljbrJ128ZrxHh+jNRWihHsaVxAHdkS6ZNcvWob8cQkR
         1yLy2nEyj/Fe3g/Svv/Sr/bnVD4UYhoF7PlsTUugkL1/K542AgQjdUtkOwFDtfril+
         76IQ8wy50jMtjSDDYa20kpex9Cwq9A/ZTadtSaYVkd8bMDT33gd8eFqp7QEgN1gapw
         RUrcUyRJLKmTQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     surenb@google.com, Liam.Howlett@oracle.com,
        torvalds@linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH] arch/arm64/mm/fault: Fix undeclared variable error in do_page_fault()
Date:   Tue,  4 Jul 2023 01:00:03 +0000
Message-Id: <20230704010003.86352-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ae870a68b5d1 ("arm64/mm: Convert to using
lock_mm_and_find_vma()") made do_page_fault() to use 'vma' even if
CONFIG_PER_VMA_LOCK is not defined, but the declaration is still in the
ifdef.  As a result, building kernel without the config fails with
undeclared variable error as below:

    arch/arm64/mm/fault.c: In function 'do_page_fault':
    arch/arm64/mm/fault.c:624:2: error: 'vma' undeclared (first use in this function); did you mean 'vmap'?
      624 |  vma = lock_mm_and_find_vma(mm, addr, regs);
          |  ^~~
          |  vmap

Fix it by moving the declaration out of the ifdef.

Fixes: ae870a68b5d1 ("arm64/mm: Convert to using lock_mm_and_find_vma()")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 arch/arm64/mm/fault.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 9d78ff78b0e3..b8c80f7b8a5f 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -536,9 +536,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	unsigned long vm_flags;
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
 	unsigned long addr = untagged_addr(far);
-#ifdef CONFIG_PER_VMA_LOCK
 	struct vm_area_struct *vma;
-#endif
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
-- 
2.25.1

