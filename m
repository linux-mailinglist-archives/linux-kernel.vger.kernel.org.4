Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66D173D153
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjFYOLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjFYOKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:10:55 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB7B1B1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 07:10:53 -0700 (PDT)
X-QQ-mid: bizesmtp73t1687702208t869bq9s
Received: from localhost.localdomain ( [112.2.230.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 25 Jun 2023 22:10:04 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: TVZM0Uoyj00c0bZeOtQsMG0DaWKF8k5IP29sSaNKu2IqHl0SZUO1pXN9aQB5m
        So+nB8VGz5FuKu2vXt+QJgjvfdapKB5QFP/nycPWDjuq5n+govmjlnnfC3eg5zAOuPs3RLJ
        tidw5jfJcMk/f3odNds/Y35dsaNOgrDwb/1JqzDV+lozOChS18Qcsa48sKJp4BW5GTiQIy+
        uENrBlNboO9pUCSceB6gdweAS2JHCzmhrhNjhlZNzbmvK9cEFaJe9JopuWLI/HG/hHN1hbp
        YC5V/dL5eDx0XIYB3rpFxJsYuPt+2YzAPJHuZUvik2ApM8SgDnrqQS532EawfgLqH9EsUe7
        JIjbNrfBR84Y/3K7AbHzIySaufKumCejpKOrEBPytWTAKTadhs=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11597191393074232432
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, robh+dt@kernel.org, frowand.list@gmail.com,
        ajones@ventanamicro.com, alexghiti@rivosinc.com,
        mpe@ellerman.id.au, arnd@arndb.de, songshuaishuai@tinylab.org,
        rppt@kernel.org, samuel@sholland.org, panqinglin2020@iscas.ac.cn,
        conor.dooley@microchip.com, anup@brainfault.org,
        xianting.tian@linux.alibaba.com, anshuman.khandual@arm.com,
        heiko@sntech.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH V1 1/3] Revert "RISC-V: mark hibernation as nonportable"
Date:   Sun, 25 Jun 2023 22:09:29 +0800
Message-Id: <20230625140931.1266216-2-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230625140931.1266216-1-songshuaishuai@tinylab.org>
References: <20230625140931.1266216-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ed309ce522185583b163bd0c74f0d9f299fe1826.

With the commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the
linear mapping") reverted, the MIN_MEMBLOCK_ADDR points the kernel
load address which was placed at a PMD boundary. And firmware always
correctly mark resident memory, or memory protected with PMP as
per the devicetree specification and/or the UEFI specification.

So those regions will not be mapped in the linear mapping and they
can be safely saved/restored by hibernation.

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 arch/riscv/Kconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5966ad97c30c..17b5fc7f54d4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -800,11 +800,8 @@ menu "Power management options"
 
 source "kernel/power/Kconfig"
 
-# Hibernation is only possible on systems where the SBI implementation has
-# marked its reserved memory as not accessible from, or does not run
-# from the same memory as, Linux
 config ARCH_HIBERNATION_POSSIBLE
-	def_bool NONPORTABLE
+	def_bool y
 
 config ARCH_HIBERNATION_HEADER
 	def_bool HIBERNATION
-- 
2.20.1

