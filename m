Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A7967DCBD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 04:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjA0Dxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 22:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjA0Dxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 22:53:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2968D62240
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 19:53:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABF7AB81F95
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A7BC433EF;
        Fri, 27 Jan 2023 03:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674791616;
        bh=QiRQ0Fl6+onHpSDTLUrFMpUAIIfVHseS/iKmIXAYaWc=;
        h=From:To:Cc:Subject:Date:From;
        b=OzyjQCSOa1wVfANYW40qX3EScWWACX6fBwykJNrXTF2hDppVqv8V3BkTjJiH/eXQY
         rhe7qgjnq8pCOqvYRBxX5C3gg1JWPluGlnbV2/cohPk+ibiC5Il4sqSQF38cACs4lH
         S/hS0gG1MCioogE0Psv0YFrcrlacf86vBgEZ+gwLwzkgs/R4vJXppqxYRLNa09ypq7
         PwqSEKrEl7k8Tn98U2JIAw+37ojxZ7D4gYF40hJNHO0+uG6FH1OSsddXYQen8KO3hq
         V9Wg9IvpS2BhPTyjOm//TSDz1+eUOYHuOlxHE2HEdlMmFCufTmBO1w2CcU5V7HcxrI
         rjYgYYSBgstbw==
From:   guoren@kernel.org
To:     arnd@arndb.de, palmer@rivosinc.com, conor.dooley@microchip.com,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        mark.rutland@arm.com, bjorn@kernel.org, guoren@kernel.org,
        tongtiangen@huawei.com, ajones@ventanamicro.com, andrew@sifive.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2] riscv: Fixup race condition on PG_dcache_clean in flush_icache_pte
Date:   Thu, 26 Jan 2023 22:53:06 -0500
Message-Id: <20230127035306.1819561-1-guoren@kernel.org>
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

In commit 588a513d3425 ("arm64: Fix race condition on PG_dcache_clean
in __sync_icache_dcache()"), we found RISC-V has the same issue as the
previous arm64. The previous implementation didn't guarantee the correct
sequence of operations, which means flush_icache_all() hasn't been
called when the PG_dcache_clean was set. That would cause a risk of page
synchronization.

Fixes: 08f051eda33b ("RISC-V: Flush I$ when making a dirty page executable")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
Changelog:
V2:
 - Optimize commit log
 - Rebase on riscv for-next (20230127)

V1:
https://lore.kernel.org/linux-riscv/20221023133205.3493564-2-guoren@kernel.org/
---
 arch/riscv/mm/cacheflush.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 3cc07ed45aeb..fcd6145fbead 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -90,8 +90,10 @@ void flush_icache_pte(pte_t pte)
 	if (PageHuge(page))
 		page = compound_head(page);
 
-	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
+	if (!test_bit(PG_dcache_clean, &page->flags)) {
 		flush_icache_all();
+		set_bit(PG_dcache_clean, &page->flags);
+	}
 }
 #endif /* CONFIG_MMU */
 
-- 
2.36.1

