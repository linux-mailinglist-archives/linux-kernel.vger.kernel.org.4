Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24C15EA83B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbiIZOTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiIZOSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:18:25 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B6EB188BF7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:28:08 -0700 (PDT)
Received: from 4.cn (unknown [10.20.4.148])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx72uvmjFjbDkiAA--.59138S2;
        Mon, 26 Sep 2022 20:27:27 +0800 (CST)
From:   Jun Yi <yijun@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Qing Zhang <zhangqing@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Mao Bibo <maobibo@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] LoongArch: Fixup do_ri csr_era
Date:   Mon, 26 Sep 2022 20:27:27 +0800
Message-Id: <20220926122727.2310118-1-yijun@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx72uvmjFjbDkiAA--.59138S2
X-Coremail-Antispam: 1UD129KBjvdXoWrury7ZrykZrWxZryxJF17Awb_yoWxurg_A3
        W29w1UWa1rAw4Syw1Uur4fGFyqvay8KF1Fk3Z2vrWkCFn8Jw4Yy3y5A3Z8ArnIgFWrGrs8
        Z39rJrn0kFy8tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbs8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
        1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
        cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
        ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: p1lm30o6or00hjvr0hdfq/1tbiAQABAWMxll4ANgABss
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

csr_era of pt_regs in do_ri should not add 4 to point to the
next instruction.

Signed-off-by: Jun Yi <yijun@loongson.cn>
---
 arch/loongarch/kernel/traps.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index aa1c95aaf595..ec888eda3d45 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -477,8 +477,6 @@ asmlinkage void noinstr do_ri(struct pt_regs *regs)
 
 	die_if_kernel("Reserved instruction in kernel code", regs);
 
-	compute_return_era(regs);
-
 	if (unlikely(get_user(opcode, era) < 0)) {
 		status = SIGSEGV;
 		current->thread.error_code = 1;
-- 
2.31.1

