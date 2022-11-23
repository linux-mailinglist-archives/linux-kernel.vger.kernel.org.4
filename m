Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD166365D1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbiKWQ2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239135AbiKWQ2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:28:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F49129CBF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:27:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B67761DE6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159E0C433C1;
        Wed, 23 Nov 2022 16:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669220875;
        bh=RbFg5SUvS3xFJJRTRaVHi2bX1Rc8bI0Z/xmm4da0qQw=;
        h=From:To:Cc:Subject:Date:From;
        b=gTvnwSCYZ0wF4boR8aVWXndodyYNlX7xtCHMDLuAKCVA9rq6Kcy+XPbwZB+efS2sP
         ePy9soNF95TLT+xdeDx5hY66ofX4M9nWWEtUP2oVJkcIDl6CXtAINIpYPyHA5sRVjq
         +PLEp5/RNeu7JXuUlmd81XnM3hbOYziJKTKrJcI/BT/esU864J02NRp4hvzm/HtR68
         DayvsbEUfIBGyYFs9YEY1pUqFA3L9wWbqLw4FzJ7OkhXzCSSeUgnZomdKkrBtthhJp
         WmzttKvBIcFq5ymMgoGJk+JCunnO3LDK/QIHXlX1NveT3hhFXckFAc2NgBNRus6z2a
         W8kK6Qt0M+IDg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>
Subject: [RFC PATCH] riscv: vdso: remove hardcoded 0x800 .text section start addr
Date:   Thu, 24 Nov 2022 00:18:05 +0800
Message-Id: <20221123161805.1579-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
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

It seems the hardcoded 0x800 isn't necessary, but removing it brings a
small vdso.so and aligns with other architectures.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/vdso/vdso.lds.S | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
index 150b1a572e61..7be7e618d59c 100644
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
+	. = ALIGN(4);
 	.text		: { *(.text .text.*) }		:text
 
 	.data		: {
-- 
2.37.2

