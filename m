Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D312613D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJaSIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJaSIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:08:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF05636C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:08:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A1E6B819DB
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512F0C433D6;
        Mon, 31 Oct 2022 18:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667239703;
        bh=61NkTIRtTQDjIwj34HexqV/1v6+kaRU2hwR4uoY6668=;
        h=From:To:Cc:Subject:Date:From;
        b=fd+EMPKlIf4RbN8/XgdKYejclCTsYhbFwapr17e367PPTRZu7Zl0/vYawiVi/ZiqI
         k11GcD3hURPp7Nf2llY3Chx1Vfu/fUsbTA2zM2v1Q3f7ejZBx4RNWQXiYvN0AqH44Q
         cu2/Q1vOQdh7ABsRGp4w4MX5xvLPV7V905wxqN48ampidHhRv7HP4a2sKeQ3CgyLwU
         cUPnqgQldXl8hyE6m9kLy/8m7ynMFDS9B8E6LS//sHrMWe/M+EnrV7ttMQ4W/R1kD1
         LB0ePi+geOgbcUq6jNTQ3FDggCeXkXLpQ//4cyBFVGogjOfWBp7YDPwZlruarao2kt
         4KjjU1d8S3nqA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] riscv: vdso: fix section overlapping under some conditions
Date:   Tue,  1 Nov 2022 01:58:42 +0800
Message-Id: <20221031175842.1699-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lkp reported a build error, I tried the config and can reproduce
build error as below:

  VDSOLD  arch/riscv/kernel/vdso/vdso.so.dbg
ld.lld: error: section .note file range overlaps with .text
>>> .note range is [0x7C8, 0x803]
>>> .text range is [0x800, 0x1993]

ld.lld: error: section .text file range overlaps with .dynamic
>>> .text range is [0x800, 0x1993]
>>> .dynamic range is [0x808, 0x937]

ld.lld: error: section .note virtual address range overlaps with .text
>>> .note range is [0x7C8, 0x803]
>>> .text range is [0x800, 0x1993]

Fix it by removing the hardcoding 0x800 and related comments.

Link: https://lore.kernel.org/lkml/202210122123.Cc4FPShJ-lkp@intel.com/#r
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/vdso/vdso.lds.S | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
index 01d94aae5bf5..344209d2e128 100644
--- a/arch/riscv/kernel/vdso/vdso.lds.S
+++ b/arch/riscv/kernel/vdso/vdso.lds.S
@@ -31,13 +31,7 @@ SECTIONS
 
 	.rodata		: { *(.rodata .rodata.* .gnu.linkonce.r.*) }
 
-	/*
-	 * This linker script is used both with -r and with -shared.
-	 * For the layouts to match, we need to skip more than enough
-	 * space for the dynamic symbol table, etc. If this amount is
-	 * insufficient, ld -shared will error; simply increase it here.
-	 */
-	. = 0x800;
+	. = ALIGN(16);
 	.text		: { *(.text .text.*) }		:text
 
 	.data		: {
-- 
2.37.2

