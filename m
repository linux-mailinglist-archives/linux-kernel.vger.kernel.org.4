Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6C05F71F9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiJFXmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiJFXmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:42:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA585B7EE0;
        Thu,  6 Oct 2022 16:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=EHXjKJCl8P229+ixHF+hwry+sLAzC+giK/HCO4UhZtM=; b=rdbs0XlVMVxA2TXDEOYmo3yly1
        q/rGmxrWlhuDOOfvnNidJy50/DJ8nB5+ObMV2EOuIm7w6jsOgg0Q9xTlZ1LXB4flXR52icvhMjSLK
        8Ojueht35o3yVb5joRTEBzK4Iv3ssNZ/TSgUluoYYEKwbdiFS54MXp7Rx1IdIJKtEsQupYYlGEqQm
        rsuSB6+6aBNGkmzOMWqtI+BMllrEaqhL4jYN0JRt/t8mTwfXYiVxCRCfBzVmFhmqTf3RTsFCIOUip
        n0rQhOcAS3O2Ytdq7vpD59YHTP4Lh/+dQkMDzq/FI043EyJFxMB9MPSJLQyGA/i0LDXtaf8JjWBxq
        aJoQ27Jg==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogaVt-001WuB-5Z; Thu, 06 Oct 2022 23:42:49 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org
Subject: [PATCH] sh: init: use OF_EARLY_FLATTREE for early init
Date:   Thu,  6 Oct 2022 16:42:40 -0700
Message-Id: <20221006234240.7755-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_OF_EARLY_FLATTREE and CONFIG_SH_DEVICE_TREE are not set,
SH3 build fails with a call to early_init_dt_scan(), so in
arch/sh/kernel/setup.c and arch/sh/kernel/head_32.S, use
CONFIG_OF_EARLY_FLATTREE instead of CONFIG_OF_FLATTREE.

Fixes this build error:
../arch/sh/kernel/setup.c: In function 'sh_fdt_init':
../arch/sh/kernel/setup.c:262:26: error: implicit declaration of function 'early_init_dt_scan' [-Werror=implicit-function-declaration]
  262 |         if (!dt_virt || !early_init_dt_scan(dt_virt)) {

Fixes: 03767daa1387 ("sh: fix build regression with CONFIG_OF && !CONFIG_OF_FLATTREE")
Fixes: eb6b6930a70f ("sh: fix memory corruption of unflattened device tree")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/kernel/head_32.S |    6 +++---
 arch/sh/kernel/setup.c   |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -244,7 +244,7 @@ void __init __weak plat_early_device_set
 {
 }
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 void __ref sh_fdt_init(phys_addr_t dt_phys)
 {
 	static int done = 0;
@@ -326,7 +326,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Let earlyprintk output early console messages */
 	sh_early_platform_driver_probe("earlyprintk", 1, 1);
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 #ifdef CONFIG_USE_BUILTIN_DTB
 	unflatten_and_copy_device_tree();
 #else
--- a/arch/sh/kernel/head_32.S
+++ b/arch/sh/kernel/head_32.S
@@ -64,7 +64,7 @@ ENTRY(_stext)
 	ldc	r0, r6_bank
 #endif
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 	mov	r4, r12		! Store device tree blob pointer in r12
 #endif
 	
@@ -315,7 +315,7 @@ ENTRY(_stext)
 10:		
 #endif
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 	mov.l	8f, r0		! Make flat device tree available early.
 	jsr	@r0
 	 mov	r12, r4
@@ -346,7 +346,7 @@ ENTRY(stack_start)
 5:	.long	start_kernel
 6:	.long	cpu_init
 7:	.long	init_thread_union
-#if defined(CONFIG_OF_FLATTREE)
+#if defined(CONFIG_OF_EARLY_FLATTREE)
 8:	.long	sh_fdt_init
 #endif
 
