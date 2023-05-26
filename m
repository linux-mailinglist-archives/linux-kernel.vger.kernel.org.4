Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B03712B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242374AbjEZRLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242406AbjEZRLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:11:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B6F1B7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:11:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0A276519D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 17:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AA0C4339B;
        Fri, 26 May 2023 17:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685121076;
        bh=EFBwhFd9h5qljpxdSxEUl1LBAOZbrYHCRzIQKTfr4Eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqSdc9yjds0qBut4705CgMnspNEGuyhW+e1aoMQmGPboAeGFMDVvjfNAGTjvZCgZv
         CyuYU9rrIt276VNDMQ4RkYntlG86VMvrqucBi6vr9aM+tc8munbsrRU0TZpnlEXrxc
         UGbQiDbl21o6r6XyAlFF1w10ARU6M7vWRz3B2aYMqI5DQUtHVw/A/DH9hNaGuGnefq
         O6dfGs+cFxuthKDzH5KyY70wbvnLgHdK9ilEpFIxbOUNcSZfn3hMsTYojY3Ejmoy6I
         Y241nSqbxB7/nDNx99+A1sYt/6FtGfU2htL7glI0+OfpQ/GhvsPp02cit4tp7RJgfa
         7kyyc8Qnzh61Q==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 3/6] riscv: mm: mark noncoherent_supported as __ro_after_init
Date:   Sat, 27 May 2023 00:59:55 +0800
Message-Id: <20230526165958.908-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230526165958.908-1-jszhang@kernel.org>
References: <20230526165958.908-1-jszhang@kernel.org>
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

The noncoherent_supported indicates whether the HW is coherent or not,
it won't change after booting, mark it as __ro_after_init.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/mm/dma-noncoherent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index d919efab6eba..d51a75864e53 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -10,7 +10,7 @@
 #include <linux/mm.h>
 #include <asm/cacheflush.h>
 
-static bool noncoherent_supported;
+static bool noncoherent_supported __ro_after_init;
 
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 			      enum dma_data_direction dir)
-- 
2.40.1

