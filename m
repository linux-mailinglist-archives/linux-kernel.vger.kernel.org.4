Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5116EFF3D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 04:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242841AbjD0CNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 22:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242707AbjD0CNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 22:13:41 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE1114682;
        Wed, 26 Apr 2023 19:12:39 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bxb+sW2klkyV4BAA--.2295S3;
        Thu, 27 Apr 2023 10:12:38 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxqrYQ2klkZ_U9AA--.18515S3;
        Thu, 27 Apr 2023 10:12:36 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2 1/5] LoongArch: Fix build error if CONFIG_DYNAMIC_FTRACE_WITH_REGS is not set
Date:   Thu, 27 Apr 2023 10:12:28 +0800
Message-Id: <1682561552-32324-2-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1682561552-32324-1-git-send-email-tangyouling@loongson.cn>
References: <1682561552-32324-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxqrYQ2klkZ_U9AA--.18515S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tr13Gw1fWr13ur18Xw43ZFb_yoW8Aw4xpr
        W2kw1DJ3yUKFs7KF9F9ryrWrnrWrZrG34aqa17K34FkrWqq3WUXryUZr1DWa45t3s7WrWf
        ZFyfZrWqya17XwUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjxU4eMKDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can see the following build error on LoongArch if CONFIG_DYNAMIC_FTRACE_WITH_REGS
is not set:

arch/loongarch/kernel/ftrace_dyn.c: In function ‘ftrace_make_call’:
arch/loongarch/kernel/ftrace_dyn.c:167:23: error: implicit declaration of function ‘__get_mod’
  167 |                 ret = __get_mod(&mod, pc);
      |                       ^~~~~~~~~
arch/loongarch/kernel/ftrace_dyn.c:171:24: error: implicit declaration of function ‘get_plt_addr’
  171 |                 addr = get_plt_addr(mod, addr);
      |                        ^~~~~~~~~~~~

The reason is that the __get_mod and get_plt_addr functions will be called
in ftrace_make_{call,nop}.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/kernel/ftrace_dyn.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index 4a3ef8516ccc..c5f4b4681ddc 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -30,8 +30,6 @@ static int ftrace_modify_code(unsigned long pc, u32 old, u32 new, bool validate)
 	return 0;
 }
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-
 #ifdef CONFIG_MODULES
 static inline int __get_mod(struct module **mod, unsigned long addr)
 {
@@ -72,6 +70,7 @@ static unsigned long get_plt_addr(struct module *mod, unsigned long addr)
 }
 #endif
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr, unsigned long addr)
 {
 	u32 old, new;
@@ -102,7 +101,6 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr, unsigned
 
 	return ftrace_modify_code(pc, old, new, true);
 }
-
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
 int ftrace_update_ftrace_func(ftrace_func_t func)
-- 
2.37.1

