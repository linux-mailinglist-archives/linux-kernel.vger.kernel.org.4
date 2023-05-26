Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B30712B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242473AbjEZRL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242337AbjEZRLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:11:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926F8E55
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:11:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29AB261648
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 17:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374DBC433D2;
        Fri, 26 May 2023 17:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685121074;
        bh=xGXWKrOp0g9viGaeP46hlIuMnd4eCZ7qokxGpnJ/fzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=inb6fwAeTMyK2wSbEr0nuGmmPotGctpAFAas68FOu4FXw2az1r0gk6rZbi+5aV0h5
         m4OTi/vkC0xVo5GTCgTkRkG73mXt852HxHcds0NLIr1prkeDvnwR35p44PQEvIl6cy
         yiSGbH8nOzCslfwRqUU068U0GxfMvlzcryYaJZugLD0oW6QzFdR4E6aOzmTF8JuRDS
         2E4BuuxBKV+OGh4lFzfjSK7OfQQmJG6g09pKeZsR9d5KkR2MBKUakQsKttJ8oqYShU
         j0wk75Exd01x45Uaxs8towiqvb/su72IxbpAqoT33JD5OogB3dtjS4/aCddv+IDty7
         ib60VxxrBdFdw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 2/6] riscv: mm: mark CBO relate initialization funcs as __init
Date:   Sat, 27 May 2023 00:59:54 +0800
Message-Id: <20230526165958.908-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230526165958.908-1-jszhang@kernel.org>
References: <20230526165958.908-1-jszhang@kernel.org>
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

The two functions cbo_get_block_size() and riscv_init_cbo_blocksizes()
are only called during booting, mark them as __init.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/mm/cacheflush.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index fca532ddf3ec..fbc59b3f69f2 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -104,9 +104,9 @@ EXPORT_SYMBOL_GPL(riscv_cbom_block_size);
 unsigned int riscv_cboz_block_size;
 EXPORT_SYMBOL_GPL(riscv_cboz_block_size);
 
-static void cbo_get_block_size(struct device_node *node,
-			       const char *name, u32 *block_size,
-			       unsigned long *first_hartid)
+static void __init cbo_get_block_size(struct device_node *node,
+				      const char *name, u32 *block_size,
+				      unsigned long *first_hartid)
 {
 	unsigned long hartid;
 	u32 val;
@@ -126,7 +126,7 @@ static void cbo_get_block_size(struct device_node *node,
 	}
 }
 
-void riscv_init_cbo_blocksizes(void)
+void __init riscv_init_cbo_blocksizes(void)
 {
 	unsigned long cbom_hartid, cboz_hartid;
 	u32 cbom_block_size = 0, cboz_block_size = 0;
-- 
2.40.1

