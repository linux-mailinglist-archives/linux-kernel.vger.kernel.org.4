Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49847052A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbjEPPrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbjEPPrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:47:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CBF9EC2;
        Tue, 16 May 2023 08:46:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D40DB63278;
        Tue, 16 May 2023 15:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0851EC433A0;
        Tue, 16 May 2023 15:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684251980;
        bh=RmbFIhpMNElq8ZkpNfEGRuhnV3uNnxxGxG17h/UHJGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atImyQCL9jgkPIb7HW0By+bWCRzkUSWQ8RVamtL4cFJzOUPUmO+faoEujXoK+Si5a
         zx2WlozINWvxSz+xwAglfp8G2uB9FBan4qsDVnAWPBUU1vD+GoUszoNWjHVLtiVcPZ
         UujkQhv8ULrWuc2TGKi16vpgj2Qq+iUlbtprJqAH/3/j1+uc26xynSbh5cU035CW+I
         cFfcdAfxPiJuLxjgiKfthyG2t8VGJX//4ONUV6834gMa0UYqdWF9H8tVGctW3+O3kz
         WNOxNYFvjg+BA+yjighlvpQOozjJF4UwCQM7YuQ1RIqh4yYcXfA7sB0hFK3lHZAjVr
         nPQW6GxUJD41w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 01/16] ARM: dma-mapping: hide unused dma_contiguous_early_fixup function
Date:   Tue, 16 May 2023 17:45:50 +0200
Message-Id: <20230516154605.517690-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516154605.517690-1-arnd@kernel.org>
References: <20230516154605.517690-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

The dma_contiguous_early_fixup() function is a global __weak stub
with an arm specific override, but the declaration is in an #ifdef.

If CONFIG_DMA_CMA is disabled, there is no caller and no prototype,
which adds a warning for the definition:

arm/mm/dma-mapping.c:261:13: error: no previous prototype for 'dma_contiguous_early_fixup' [-Werror=missing-prototypes]

Enclose the definition in the same #ifdef as the prototype to avoid
that and save a few bytes of .init.text.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/dma-mapping.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index b4a33358d2e9..bc4ed5ce3e00 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -258,12 +258,14 @@ static struct dma_contig_early_reserve dma_mmu_remap[MAX_CMA_AREAS] __initdata;
 
 static int dma_mmu_remap_num __initdata;
 
+#ifdef CONFIG_DMA_CMA
 void __init dma_contiguous_early_fixup(phys_addr_t base, unsigned long size)
 {
 	dma_mmu_remap[dma_mmu_remap_num].base = base;
 	dma_mmu_remap[dma_mmu_remap_num].size = size;
 	dma_mmu_remap_num++;
 }
+#endif
 
 void __init dma_contiguous_remap(void)
 {
-- 
2.39.2

