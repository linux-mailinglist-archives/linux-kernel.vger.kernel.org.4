Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1480174D509
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGJMOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjGJMOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:14:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1584DFE;
        Mon, 10 Jul 2023 05:14:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A466460FD8;
        Mon, 10 Jul 2023 12:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA4DC433C7;
        Mon, 10 Jul 2023 12:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688991259;
        bh=uRmPflcHLfzXe1J+lIanercG5gxP43DJIKpzISbfov4=;
        h=From:To:Cc:Subject:Date:From;
        b=RPkV13vTx9RSPN6IsnCOgNJa7lL+jSuOu6XnuBUKqQSnWSJGpEyBGyTDuhwLx4m9f
         OZVmwKtBKxbAjl7EJ1XUM2V1m0iYpzLJNQtKQvu4L6Srb06PpS4N2INXWISV/XIVwu
         FJEbqcyyZHk8gWTacR2D+a8gXO3gV1QFG7UYSpBPSuL3panFFzQ3OlC4MXavabVCWI
         4VwKcIH5rys1YJVIuEOWVBVoo5IRI2ew8NZf/9klFwZemUOGlUEPB26IyrvgQp7Rr5
         10MEXBucYPfTS1HC9GjhDeKzC//b4DzuxKch5VQ2KgXl3R9Phr6wpciY+aaGemJyI1
         dZemgE1cwp7yQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 0/2] x86: kprobes: Fix CFI_CLANG related issues
Date:   Mon, 10 Jul 2023 21:14:13 +0900
Message-Id: <168899125356.80889.17967397360941194229.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Here I tried to fix 2 issues discussed on the previous thread;

https://lore.kernel.org/all/20230706113403.GI2833176@hirez.programming.kicks-ass.net/

- Prohibit probing on __cfi_* preamble symbols, which have the typeid.
- Prohibit probing on compiler generated movl/addl which is used for
  detecting typeid on x86.

I'm not sure how arm64 implemented, but it seems 
cfi_handler()@arch/arm64/kernel/traps.c just reads the registers for 
the typeid instead of decoding the instructions.

I just build tested, since I could not boot the kernel with CFI_CLANG=y.
Would anyone know something about this error?

[    0.141030] MMIO Stale Data: Unknown: No mitigations
[    0.153511] SMP alternatives: Using kCFI
[    0.164593] Freeing SMP alternatives memory: 36K
[    0.165053] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: start_kernel+0x472/0x48b
[    0.166028] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.2-00002-g12b1b2fca8ef #126
[    0.166028] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[    0.166028] Call Trace:
[    0.166028]  <TASK>
[    0.166028]  dump_stack_lvl+0x6e/0xb0
[    0.166028]  panic+0x146/0x2f0
[    0.166028]  ? start_kernel+0x472/0x48b
[    0.166028]  __stack_chk_fail+0x14/0x20
[    0.166028]  start_kernel+0x472/0x48b
[    0.166028]  x86_64_start_reservations+0x24/0x30
[    0.166028]  x86_64_start_kernel+0xa6/0xbb
[    0.166028]  secondary_startup_64_no_verify+0x106/0x11b
[    0.166028]  </TASK>
[    0.166028] ---[ end Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: start_kernel+0x472/0x48b ]---


Thank you,

---

Masami Hiramatsu (Google) (2):
      kprobes: Prohibit probing on CFI preamble symbol
      x86/kprobes: Prohibit probing on compiler generated CFI checking code


 arch/x86/kernel/kprobes/core.c |   34 ++++++++++++++++++++++++++++++++++
 kernel/kprobes.c               |   17 ++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
