Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACFB6EBC49
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 03:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjDWBax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 21:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDWBav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 21:30:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9528B10E2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 18:30:50 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Q3rKY2rXbzKtCK;
        Sun, 23 Apr 2023 09:29:53 +0800 (CST)
Received: from huawei.com (10.67.175.83) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 23 Apr
 2023 09:30:48 +0800
From:   ruanjinjie <ruanjinjie@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH RESEND] riscv: fix kprobe __user string arg print fault issue
Date:   Sun, 23 Apr 2023 09:29:12 +0800
Message-ID: <20230423012912.890965-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On riscv qemu platform, when add kprobe event on do_sys_open() to show
filename string arg, it just print fault as follow:

echo 'p:myprobe do_sys_open dfd=$arg1 filename=+0($arg2):string flags=$arg3
mode=$arg4' > kprobe_events

bash-166     [000] ...1.   360.195367: myprobe: (do_sys_open+0x0/0x84)
dfd=0xffffffffffffff9c filename=(fault) flags=0x8241 mode=0x1b6

bash-166     [000] ...1.   360.219369: myprobe: (do_sys_open+0x0/0x84)
dfd=0xffffffffffffff9c filename=(fault) flags=0x8241 mode=0x1b6

bash-191     [000] ...1.   360.378827: myprobe: (do_sys_open+0x0/0x84)
dfd=0xffffffffffffff9c filename=(fault) flags=0x98800 mode=0x0

As riscv do not select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE,
the +0($arg2) addr is processed as a kernel address though it is a
userspace address, cause the above filename=(fault) print. So select
ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE to avoid the issue, after that the
kprobe trace is ok as below:

bash-166     [000] ...1.    96.767641: myprobe: (do_sys_open+0x0/0x84)
dfd=0xffffffffffffff9c filename="/dev/null" flags=0x8241 mode=0x1b6

bash-166     [000] ...1.    96.793751: myprobe: (do_sys_open+0x0/0x84)
dfd=0xffffffffffffff9c filename="/dev/null" flags=0x8241 mode=0x1b6

bash-177     [000] ...1.    96.962354: myprobe: (do_sys_open+0x0/0x84)
dfd=0xffffffffffffff9c filename="/sys/kernel/debug/tracing/events/kprobes/"
flags=0x98800 mode=0x0

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index eb7f29a412f8..c51f0d3227af 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -26,6 +26,7 @@ config RISCV
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MMIOWB
 	select ARCH_HAS_PMEM_API
+	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP if MMU
 	select ARCH_HAS_SET_MEMORY if MMU
-- 
2.25.1

