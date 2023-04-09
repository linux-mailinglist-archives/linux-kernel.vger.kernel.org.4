Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A6E6DC0C4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 18:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjDIQyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 12:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDIQyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 12:54:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09902723
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 09:53:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AB3560010
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 16:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3737C433D2;
        Sun,  9 Apr 2023 16:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681059238;
        bh=lU5PXzOuCtb0P141uL0AcENGJqwDqjBgVsAq1JQriIs=;
        h=From:To:Cc:Subject:Date:From;
        b=AJJPdc888e4sifAaYRQuou/jKpxT1oVxvHWSmPMUFNwwQK+VDIY0CQi3V2OiV/fSt
         9HwhtPekYarT5vsVBcMljrrTJdLBo/5AoY8UugYGe4KsvQ0bf7yURTWeKa4qw5L8j3
         PBwGOx5C40FAdMU5P/ExE7YH8rSEl0GSsWBhVcmMP7fgS2BWUGnHEAGfeUpaNMJ3gW
         TIFMWlMxN8kZ836LAvcj/zJOYfArmxp0D4ApsIRpirnFKhR0n3S0KEOCBM+2dDx7jw
         khBz17vCtVKED0IsplwH/elPb/HM+M1FIbW7vgVyH8BCb1jUeNXuox9j2YCyVho0LP
         O9ZR573l5bU9Q==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: enable BUILDTIME_TABLE_SORT for !MMU
Date:   Mon, 10 Apr 2023 00:43:06 +0800
Message-Id: <20230409164306.3801-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUILDTIME_TABLE_SORT works for !MMU as well, so enable it.

Tested on QEMU and FPGA.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c5e42cc37604..212ea28e346b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -50,7 +50,7 @@ config RISCV
 	select ARCH_WANT_LD_ORPHAN_WARN if !XIP_KERNEL
 	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
-	select BUILDTIME_TABLE_SORT if MMU
+	select BUILDTIME_TABLE_SORT
 	select CLINT_TIMER if !MMU
 	select CLONE_BACKWARDS
 	select COMMON_CLK
-- 
2.40.0

