Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598C16374E2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiKXJNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiKXJNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:13:13 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65E5B7E95
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:13:09 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=zelin.deng@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VVaTOzC_1669281186;
Received: from alinux-host.hz.ali.com(mailfrom:zelin.deng@linux.alibaba.com fp:SMTPD_---0VVaTOzC_1669281186)
          by smtp.aliyun-inc.com;
          Thu, 24 Nov 2022 17:13:07 +0800
From:   Zelin Deng <zelin.deng@linux.alibaba.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Zelin Deng <zelin.deng@linux.alibaba.com>
Subject: [PATCH 1/2] mm/early_ioremap.c: Always build early_memremap_prot() in x86
Date:   Thu, 24 Nov 2022 17:12:45 +0800
Message-Id: <20221124091246.4957-2-zelin.deng@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221124091246.4957-1-zelin.deng@linux.alibaba.com>
References: <20221124091246.4957-1-zelin.deng@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some scenarios, we'd want to specify protection attributes when we
are doing early memory map. As early_memremap_prot() is also defined in
loongarch it's better to select ARCH_USE_MEMREMAP_PROT on X86 config to
avoid redefined error.

Signed-off-by: Zelin Deng <zelin.deng@linux.alibaba.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 48d98a5fe06b..133d7d660b2e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -97,6 +97,7 @@ config X86
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_USE_MEMREMAP_PROT
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAS_ZONE_DMA_SET if EXPERT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
-- 
2.27.0

