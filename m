Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADC670B36F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 05:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjEVDAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 23:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjEVDAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 23:00:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E90EC1;
        Sun, 21 May 2023 20:00:05 -0700 (PDT)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QPhvl5b7HzsSCf;
        Mon, 22 May 2023 10:57:55 +0800 (CST)
Received: from huawei.com (10.67.175.33) by kwepemi500026.china.huawei.com
 (7.221.188.247) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 22 May
 2023 11:00:00 +0800
From:   Lin Yujun <linyujun809@huawei.com>
To:     <bcain@quicinc.com>, <linyujun809@huawei.com>,
        <linas@codeaurora.org>, <rkuo@codeaurora.org>, <arnd@arndb.de>
CC:     <linux-hexagon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] hexagon: Fix unbalanced spinlock in die()
Date:   Mon, 22 May 2023 02:56:08 +0000
Message-ID: <20230522025608.2515558-1-linyujun809@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.33]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500026.china.huawei.com (7.221.188.247)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

die executes holding the spinlock of &die.lock and unlock
it after printing the oops message.
However in the code if the notify_die() returns NOTIFY_STOP
, die() exit with returning 1 but never unlocked the spinlock.

Fix this by adding spin_unlock_irq(&die.lock) before returning.

Fixes: cf9750bae262 ("Hexagon: Provide basic debugging and system trap support.")
Signed-off-by: Lin Yujun <linyujun809@huawei.com>
---
 arch/hexagon/kernel/traps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 6447763ce5a9..b7e394cebe20 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -195,8 +195,10 @@ int die(const char *str, struct pt_regs *regs, long err)
 	printk(KERN_EMERG "Oops: %s[#%d]:\n", str, ++die.counter);
 
 	if (notify_die(DIE_OOPS, str, regs, err, pt_cause(regs), SIGSEGV) ==
-	    NOTIFY_STOP)
+	    NOTIFY_STOP) {
+		spin_unlock_irq(&die.lock);
 		return 1;
+	}
 
 	print_modules();
 	show_regs(regs);
-- 
2.34.1

