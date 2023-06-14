Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D704F7305AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbjFNRGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbjFNRGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:06:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47068E41
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D120563995
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 17:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95D1C433C0;
        Wed, 14 Jun 2023 17:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686762390;
        bh=r6WmK6pN8JZLuhkdUWl3EWEdgWXW6Xnybl6dJtROQn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nZaXe/FqPg/6fky/CfXosBUmIW2Noo0nes4r5ymfjKVsNeqFuSRyQAxyHOhicbU4t
         xguaueQOiZ7lg7LuC9SFyUrh2P0DrP3BRZFk6aEj9nORUFle74Q5tC3e4MSpJGVIf6
         iAj3cXwcdUq7gEUrskoIk0W5QGsDA6llLPqkweStT0KmYkBlSmlFQOTLsM/fQ1O0Qk
         56pLS9sQSNLyZrPYWsipzdZWhQ0Mv8kFIuGEJ5pgp+58IqvqMeiX8ZtjYPh+F2mr5c
         RBtDCpKC/7v0rAvStUEsSXbFRMkDH0hhOUcuriJEokWCAD6jTa0Zy7HMREtmJj/CK4
         vBbwyiuiVZz3Q==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 3/3] riscv: mm: mark noncoherent_supported as __ro_after_init
Date:   Thu, 15 Jun 2023 00:55:04 +0800
Message-Id: <20230614165504.532-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230614165504.532-1-jszhang@kernel.org>
References: <20230614165504.532-1-jszhang@kernel.org>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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

