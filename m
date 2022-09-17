Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8648A5BB571
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiIQB7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiIQB7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:59:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C86EE44;
        Fri, 16 Sep 2022 18:59:30 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MTvFw1Z8SzBsPD;
        Sat, 17 Sep 2022 09:57:24 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 17 Sep 2022 09:59:29 +0800
Received: from huawei.com (10.67.175.41) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 17 Sep
 2022 09:59:28 +0800
From:   Yipeng Zou <zouyipeng@huawei.com>
To:     <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <guoren@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <hca@linux.ibm.com>, <gor@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <mhiramat@kernel.org>,
        <namit@vmware.com>, <catalin.marinas@arm.com>,
        <peterz@infradead.org>, <mark.rutland@arm.com>
CC:     <liaochang1@huawei.com>, <chris.zjh@huawei.com>,
        <zouyipeng@huawei.com>
Subject: [PATCH 1/2] kprobes: make arch_init_kprobes as weak
Date:   Sat, 17 Sep 2022 09:55:21 +0800
Message-ID: <20220917015522.44583-2-zouyipeng@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220917015522.44583-1-zouyipeng@huawei.com>
References: <20220917015522.44583-1-zouyipeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.41]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function implementation under some arch does nothing.
We can mark it with weak attributes to improve.

Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
---
 arch/csky/kernel/probes/kprobes.c  | 5 -----
 arch/riscv/kernel/probes/kprobes.c | 5 -----
 arch/s390/kernel/kprobes.c         | 5 -----
 arch/x86/kernel/kprobes/core.c     | 5 -----
 kernel/kprobes.c                   | 5 +++++
 5 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
index 3c6e5c725d81..d31b6ab5cea0 100644
--- a/arch/csky/kernel/probes/kprobes.c
+++ b/arch/csky/kernel/probes/kprobes.c
@@ -405,8 +405,3 @@ int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 {
 	return 0;
 }
-
-int __init arch_init_kprobes(void)
-{
-	return 0;
-}
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index e6e950b7cf32..d4577108e5c9 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -362,8 +362,3 @@ int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 {
 	return 0;
 }
-
-int __init arch_init_kprobes(void)
-{
-	return 0;
-}
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 0032bdbe8e3f..aaf9329a7cf4 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -544,11 +544,6 @@ int kprobe_exceptions_notify(struct notifier_block *self,
 }
 NOKPROBE_SYMBOL(kprobe_exceptions_notify);
 
-int __init arch_init_kprobes(void)
-{
-	return 0;
-}
-
 int arch_trampoline_kprobe(struct kprobe *p)
 {
 	return 0;
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 4c3c27b6aea3..e26b336f8b18 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1055,11 +1055,6 @@ int __init arch_populate_kprobe_blacklist(void)
 					 (unsigned long)__entry_text_end);
 }
 
-int __init arch_init_kprobes(void)
-{
-	return 0;
-}
-
 int arch_trampoline_kprobe(struct kprobe *p)
 {
 	return 0;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ca9d834d0b84..23f6d329b53b 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2684,6 +2684,11 @@ void kprobe_free_init_mem(void)
 	mutex_unlock(&kprobe_mutex);
 }
 
+int __init __weak arch_init_kprobes(void)
+{
+	return 0;
+}
+
 static int __init init_kprobes(void)
 {
 	int i, err = 0;
-- 
2.17.1

