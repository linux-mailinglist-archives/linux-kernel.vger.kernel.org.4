Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB25630D1D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 09:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiKSIFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 03:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiKSIFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 03:05:03 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99AE6DCF6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 00:05:01 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NDmQS5JjDzmVw8;
        Sat, 19 Nov 2022 16:04:32 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 19 Nov
 2022 16:04:57 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <pmladek@suse.com>, <akpm@linux-foundation.org>,
        <mcgrof@kernel.org>, <elver@google.com>, <gpiccoli@igalia.com>,
        <bigeasy@linutronix.de>, <tangmeng@uniontech.com>,
        <andriy.shevchenko@linux.intel.com>, <yangtiezhu@loongson.cn>,
        <john.ogness@linutronix.de>, <daniel.vetter@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>, <xuqiang36@huawei.com>,
        <weiyongjun1@huawei.com>
Subject: [PATCH RESEND] panic: Add register_panic_notifier and unregister_panic_notifier
Date:   Sat, 19 Nov 2022 08:03:05 +0000
Message-ID: <20221119080305.111863-1-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two methods to manipulate panic_notifier_list and export them.
Subsequently, panic_notifier_list is changed to static variable.

Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
---
 include/linux/panic_notifier.h |  3 +++
 kernel/panic.c                 | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
index 41e32483d7a7..9543d498b90b 100644
--- a/include/linux/panic_notifier.h
+++ b/include/linux/panic_notifier.h
@@ -5,6 +5,9 @@
 #include <linux/notifier.h>
 #include <linux/types.h>
 
+int register_panic_notifier(struct notifier_block *nb);
+int unregister_panic_notifier(struct notifier_block *nb);
+
 extern struct atomic_notifier_head panic_notifier_list;
 
 extern bool crash_kexec_post_notifiers;
diff --git a/kernel/panic.c b/kernel/panic.c
index 75fe389e8814..8f34dbd389cf 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -200,6 +200,18 @@ static void panic_print_sys_info(bool console_flush)
 		ftrace_dump(DUMP_ALL);
 }
 
+int register_panic_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&panic_notifier_list, nb);
+}
+EXPORT_SYMBOL(register_panic_notifier);
+
+int unregister_panic_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&panic_notifier_list, nb);
+}
+EXPORT_SYMBOL(unregister_panic_notifier);
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
-- 
2.17.1

