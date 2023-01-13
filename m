Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C979866972A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241497AbjAMMdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241221AbjAMMcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEB84D704;
        Fri, 13 Jan 2023 04:31:10 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KsLuCFgmdU19wUf/VRVgfn19J66nmtUGe6duCuVWibc=;
        b=LQwp5olNcFf1ECD8wyGYGSwX35EAkF2ptPxs/Ks0FvmUfEeDW/qeLpgn7j88sBuM4VkN68
        AkL4JXIAnngkQN+B1rcBJXBu17DFgglFdCrysw5y6sfclTexDgzMj8J4DtzYIOxLtkStwL
        86FsqK+2iB5pnk2xwF6iM/PYqSJBh8ScKIz4GZL3K3b4yP/g/aVD0SFCFDV7gmZY2EPfgQ
        m3WYwo9BtgZIoydEc/XtvL6VRVFJiJJ16JnWuGpZqWunT1TgXGbVH+jWDwrho8elsiQMas
        88lP+/jWJZAiY3UkAHx3HXzHJzuUrlMT9zQa8lUOdyp2HgVshI44CkdRyI7ZtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KsLuCFgmdU19wUf/VRVgfn19J66nmtUGe6duCuVWibc=;
        b=utr/e2RB4T03U5wzmtr3heUdRi1Iv/xzqs4YinoFQQkEwh6DtVpxuB6RKinKZRF+Z7w/af
        f623sHndv9mzs5Bg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Always inline __this_cpu_preempt_check()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195542.089981974@infradead.org>
References: <20230112195542.089981974@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306603.4906.4837361000038231282.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f176d4ccb30747231831f66779697afa6d738b3c
Gitweb:        https://git.kernel.org/tip/f176d4ccb30747231831f66779697afa6d738b3c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:17 +01:00

sched/core: Always inline __this_cpu_preempt_check()

Quite a few unnecessary instrumentation calls are generated via the
no-op __this_cpu_preempt_check() call, if it gets uninlined by the
compiler:

  vmlinux.o: warning: objtool: in_entry_stack+0x9: call to __this_cpu_preempt_check() leaves .noinstr.text section
  vmlinux.o: warning: objtool: default_do_nmi+0x10: call to __this_cpu_preempt_check() leaves .noinstr.text section
  vmlinux.o: warning: objtool: fpu_idle_fpregs+0x41: call to __this_cpu_preempt_check() leaves .noinstr.text section
  vmlinux.o: warning: objtool: kvm_read_and_reset_apf_flags+0x1: call to __this_cpu_preempt_check() leaves .noinstr.text section
  vmlinux.o: warning: objtool: lockdep_hardirqs_on+0xb0: call to __this_cpu_preempt_check() leaves .noinstr.text section
  vmlinux.o: warning: objtool: lockdep_hardirqs_off+0xae: call to __this_cpu_preempt_check() leaves .noinstr.text section
  vmlinux.o: warning: objtool: irqentry_nmi_enter+0x69: call to __this_cpu_preempt_check() leaves .noinstr.text section
  vmlinux.o: warning: objtool: irqentry_nmi_exit+0x32: call to __this_cpu_preempt_check() leaves .noinstr.text section
  vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x9: call to __this_cpu_preempt_check() leaves .noinstr.text section
  vmlinux.o: warning: objtool: acpi_idle_enter+0x43: call to __this_cpu_preempt_check() leaves .noinstr.text section
  vmlinux.o: warning: objtool: acpi_idle_enter_s2idle+0x45: call to __this_cpu_preempt_check() leaves .noinstr.text section

Mark it __always_inline.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195542.089981974@infradead.org
---
 include/linux/percpu-defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index af10715..e60727b 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -310,7 +310,7 @@ extern void __bad_size_call_parameter(void);
 #ifdef CONFIG_DEBUG_PREEMPT
 extern void __this_cpu_preempt_check(const char *op);
 #else
-static inline void __this_cpu_preempt_check(const char *op) { }
+static __always_inline void __this_cpu_preempt_check(const char *op) { }
 #endif
 
 #define __pcpu_size_call_return(stem, variable)				\
