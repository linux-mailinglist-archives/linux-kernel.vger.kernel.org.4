Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1488E6173B0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 02:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiKCBVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 21:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiKCBVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 21:21:33 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BAF12745;
        Wed,  2 Nov 2022 18:21:32 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N2m9S0GdMzJnQ1;
        Thu,  3 Nov 2022 09:18:36 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 09:21:30 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <chenhuacai@kernel.org>, <jiaxun.yang@flygoat.com>,
        <tsbogend@alpha.franken.de>, <tangyouling@loongson.cn>,
        <hejinyang@loongson.cn>
CC:     <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liaochang1@huawei.com>
Subject: [PATCH] MIPS: Loongson64: Add WARN_ON on kexec related kmalloc failed
Date:   Thu, 3 Nov 2022 09:18:15 +0800
Message-ID: <20221103011815.139424-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add WARN_ON on kexec related kmalloc failed, avoid to pass NULL pointer
to following memcpy and loongson_kexec_prepare.

Fixes: 6ce48897ce47 ("MIPS: Loongson64: Add kexec/kdump support")
Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/mips/loongson64/reset.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/loongson64/reset.c b/arch/mips/loongson64/reset.c
index 758d5d26aaaa..e420800043b0 100644
--- a/arch/mips/loongson64/reset.c
+++ b/arch/mips/loongson64/reset.c
@@ -16,6 +16,7 @@
 #include <asm/bootinfo.h>
 #include <asm/idle.h>
 #include <asm/reboot.h>
+#include <asm/bug.h>
 
 #include <loongson.h>
 #include <boot_param.h>
@@ -159,8 +160,17 @@ static int __init mips_reboot_setup(void)
 
 #ifdef CONFIG_KEXEC
 	kexec_argv = kmalloc(KEXEC_ARGV_SIZE, GFP_KERNEL);
+	if (WARN_ON(!kexec_argv))
+		return -ENOMEM;
+
 	kdump_argv = kmalloc(KEXEC_ARGV_SIZE, GFP_KERNEL);
+	if (WARN_ON(!kdump_argv))
+		return -ENOMEM;
+
 	kexec_envp = kmalloc(KEXEC_ENVP_SIZE, GFP_KERNEL);
+	if (WARN_ON(!kexec_envp))
+		return -ENOMEM;
+
 	fw_arg1 = KEXEC_ARGV_ADDR;
 	memcpy(kexec_envp, (void *)fw_arg2, KEXEC_ENVP_SIZE);
 
-- 
2.17.1

