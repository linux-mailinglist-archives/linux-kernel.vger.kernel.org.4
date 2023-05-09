Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3136FBDF9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjEID5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjEID4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:56:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF9F7AB0;
        Mon,  8 May 2023 20:55:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5760643AB;
        Tue,  9 May 2023 03:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2905AC4339E;
        Tue,  9 May 2023 03:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683604536;
        bh=U2HZCyc523SVLQz5mynVDfDuaBCmxXOmqikUU7ycYeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rqhrIwtXHNltQyMjAOYauPzfTavSEStYFKPrRJLDwBl9dkHXQF+Kif9Pe8QTbmSgG
         2JZDgCYJ4mbD97q2pGnDCHSJw/SKvxbqEnBFKUgH7MoRcLOQHVkiARIZyhrB+sSbvT
         9e4/W6O3z+RPbKzyCoH9KT65rlanQ2Btrw338/Korf140t18NVMFqQHn4q4mG3/bVK
         UQi28JCFKDAvWx362RmphtezMcYMsfVPXbpjHwex0S2Lc7siTDa3n1iEEs9iJf5l4N
         ttaAuCy9MlGu55SvqPdacca2b/YSRPEZ5WhDQpIApLk6TxIeZ8PWzoGsP8XBfjB2Vt
         fGrglHBTpvHIA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 3/5] riscv: Unconditionnally select KASAN_VMALLOC if KASAN
Date:   Mon,  8 May 2023 23:55:27 -0400
Message-Id: <20230509035533.60269-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509035533.60269-1-sashal@kernel.org>
References: <20230509035533.60269-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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

From: Alexandre Ghiti <alexghiti@rivosinc.com>

[ Upstream commit 864046c512c2cd8418dc928b91981fb12a80396c ]

If KASAN is enabled, VMAP_STACK depends on KASAN_VMALLOC so enable
KASAN_VMALLOC with KASAN so that we can enable VMAP_STACK by default.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/r/20230203075232.274282-7-alexghiti@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 06b9b2f60b9fb..4e4d077227020 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -113,6 +113,7 @@ config RISCV
 	select HAVE_RSEQ
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
+	select KASAN_VMALLOC if KASAN
 	select MODULES_USE_ELF_RELA if MODULES
 	select MODULE_SECTIONS if MODULES
 	select OF
-- 
2.39.2

