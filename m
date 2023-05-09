Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C766FBDF8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbjEID5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjEID4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:56:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD3F4C20;
        Mon,  8 May 2023 20:55:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7493D643ED;
        Tue,  9 May 2023 03:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5490C433D2;
        Tue,  9 May 2023 03:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683604549;
        bh=/NTClOL1JcMblfk2EK9fn5y5SROM/eJwelrKFPljaXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMSvuEg+zthy1ObzjDbBh2pm6+/040wHNglk41wGrgARqo5OBgtB5KphI5U+9JlWT
         S/3Xmgz0YYfEBiMsEOC6eJ2LLDbSbfnV/pYtX9m81I3nxnwe48eRY/pVb6FOt01Tip
         RHfq7YsTGS8Y2eqba5JRIEfTErb1pSy6/TDX0JJn3expvoeu/XOpYOaggE2XWs8oQI
         /y1HMPo16s71BPk2FadeLw/36q1loCcK4KcKQfLxurJSMrXDZX/Ujtl7UIAPTU+LYs
         AGilPCLLDkMDdQ8YOdmlBhRSdNg6KZSlg+34X3pW7Puo7XMXMv8krOvRzE6e2ncq/L
         jCvwidoL7QnoA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 2/4] riscv: Unconditionnally select KASAN_VMALLOC if KASAN
Date:   Mon,  8 May 2023 23:55:41 -0400
Message-Id: <20230509035548.60458-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509035548.60458-1-sashal@kernel.org>
References: <20230509035548.60458-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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
index bf602e38962fa..ba62a3846e369 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -102,6 +102,7 @@ config RISCV
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
+	select KASAN_VMALLOC if KASAN
 	select MODULES_USE_ELF_RELA if MODULES
 	select MODULE_SECTIONS if MODULES
 	select OF
-- 
2.39.2

