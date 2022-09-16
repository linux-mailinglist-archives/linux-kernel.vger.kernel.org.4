Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0FB5BA39D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 02:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiIPAzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 20:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiIPAzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 20:55:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771EC30F6A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 17:55:11 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MTFr94wvYzmVR1;
        Fri, 16 Sep 2022 08:51:21 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 16 Sep
 2022 08:55:08 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <alankao@andestech.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] riscv/ftrace: Set FTRACE_FORCE_LIST_FUNC if DYNAMIC_FTRACE_WITH_REGS is not set
Date:   Fri, 16 Sep 2022 08:51:35 +0800
Message-ID: <20220916005135.91945-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the following configuration options:

  CONFIG_FUNCTION_TRACER=y
  CONFIG_DYNAMIC_FTRACE is not set
  CONFIG_DYNAMIC_FTRACE_WITH_REGS is not set

Setting function tracer leads to Linux being stuck:

  echo function > /sys/kernel/tracing/current_tracer

The reason is: for static tracing, RISC-V mcount only support passing up
ip and parent_ip, if it does not force list func, some C side effects
occurs, where a function is called without passing a valid third
parameter, then kernel will trap into page fault when jump from mcount
to function_trace_call().

Fix this stuck issue by force kernel to use indirect list trace
function, when CONFIG_DYNAMIC_FTRACE_WITH_REGS is not set.

Fixes: 71e736a7d655 ("riscv/ftrace: Add ARCH_SUPPORTS_FTRACE_OPS support")
Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/riscv/include/asm/ftrace.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 04dad3380041..a9d365e46b52 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -23,7 +23,10 @@
 #define MCOUNT_NAME mcount
 #endif
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 #define ARCH_SUPPORTS_FTRACE_OPS 1
+#endif
+
 #ifndef __ASSEMBLY__
 void MCOUNT_NAME(void);
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
-- 
2.17.1

