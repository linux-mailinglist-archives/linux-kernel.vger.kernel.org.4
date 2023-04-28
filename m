Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D2A6F14C9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjD1J7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346069AbjD1J6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:58:43 -0400
Received: from out0-204.mail.aliyun.com (out0-204.mail.aliyun.com [140.205.0.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0896197
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 02:58:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047198;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---.STDfsIh_1682675647;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STDfsIh_1682675647)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:54:07 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RFC 41/43] x86/mm: Sort address_markers array when X86 PIE is enabled
Date:   Fri, 28 Apr 2023 17:51:21 +0800
Message-Id: <2b9d5ec2452ad34418f3ddcd1e60c99dfb769909.1682673543.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When X86 PIE is enabled, kernel image is allowed to relocated in top
512G, then kernel image address could be below EFI range address. So
sort address_markers array to make the order right.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Thomas Garnier <thgarnie@chromium.org>
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/mm/dump_pagetables.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index df1a708a038a..81aa1c0b39cc 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -17,6 +17,7 @@
 #include <linux/highmem.h>
 #include <linux/pci.h>
 #include <linux/ptdump.h>
+#include <linux/sort.h>
 
 #include <asm/e820/types.h>
 
@@ -436,6 +437,27 @@ void ptdump_walk_pgd_level_checkwx(void)
 	ptdump_walk_pgd_level_core(NULL, &init_mm, INIT_PGD, true, false);
 }
 
+#ifdef CONFIG_X86_PIE
+static int __init address_markers_sort_cmp(const void *pa, const void *pb)
+{
+	struct addr_marker *a = (struct addr_marker *)pa;
+	struct addr_marker *b = (struct addr_marker *)pb;
+
+	return (a->start_address > b->start_address) -
+	       (a->start_address < b->start_address);
+}
+
+static void __init address_markers_sort(void)
+{
+	sort(&address_markers[0], ARRAY_SIZE(address_markers), sizeof(address_markers[0]),
+	     address_markers_sort_cmp, NULL);
+}
+#else
+static void __init address_markers_sort(void)
+{
+}
+#endif
+
 static int __init pt_dump_init(void)
 {
 	/*
@@ -467,6 +489,8 @@ static int __init pt_dump_init(void)
 	address_markers[LDT_NR].start_address = LDT_BASE_ADDR;
 # endif
 #endif
+	address_markers_sort();
+
 	return 0;
 }
 __initcall(pt_dump_init);
-- 
2.31.1

