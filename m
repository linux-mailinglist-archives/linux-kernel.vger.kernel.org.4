Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1645B99E9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiIOLmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiIOLkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455DE65562
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=exdW9cTzIEZMDSgoNhyqMCUVrHrKRGK4pmqnX15phYU=; b=no2RC9g+Fl1lJUrTJbCnpTI7PM
        8E5Vw3y4YJkXDvIi9DPSx+87tEow6N4L05/ecpSOC1bVySHnuuGHc8KH7YbxITV62rveKnop3Z0Oo
        4x4OVwl1fLS5VsmO0NwvEZX6ui/7R5VqtBQ7fURLI4Fwm5pZlSzqGLgWc5OvgaW0zlvTP3LTYY9KK
        SlTbg84ux1B/hABVbDCZRMNO2AMg7H7E4saVydG6+W2+o9AI2u8jVD+hA6B+2P1HFwUnmlhBK3MRw
        QqZfFNfBxRaCuLwioeHePlVveJcJTGlUu9gTFh0HtLtWBvJT4iCP+6Ry8rOctXyocPhk+2pdtKjnX
        ksl36G5g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDY-00Caah-PI; Thu, 15 Sep 2022 11:39:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 022DA30075A;
        Thu, 15 Sep 2022 13:39:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DD7A829AADBE9; Thu, 15 Sep 2022 13:39:38 +0200 (CEST)
Message-ID: <20220915111143.303010511@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:10:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v3 04/59] x86/cpu: Re-enable stackprotector
References: <20220915111039.092790446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Commit 5416c2663517 ("x86: make sure load_percpu_segment has no
stackprotector") disabled the stackprotector for cpu/common.c because of
load_percpu_segment(). Back then the boot stack canary was initialized very
early in start_kernel(). Switching the per CPU area by loading the GDT
caused the stackprotector to fail with paravirt enabled kernels as the
GSBASE was not updated yet. In hindsight a wrong change because it would
have been sufficient to ensure that the canary is the same in both per CPU
areas.

Commit d55535232c3d ("random: move rand_initialize() earlier") moved the
stack canary initialization to a later point in the init sequence. As a
consequence the per CPU stack canary is 0 when switching the per CPU areas,
so there is no requirement anymore to exclude this file.

Add a comment to load_percpu_segment().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/cpu/Makefile |    3 ---
 arch/x86/kernel/cpu/common.c |    3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -16,9 +16,6 @@ KCOV_INSTRUMENT_perf_event.o := n
 # As above, instrumenting secondary CPU boot code causes boot hangs.
 KCSAN_SANITIZE_common.o := n
 
-# Make sure load_percpu_segment has no stackprotector
-CFLAGS_common.o		:= -fno-stack-protector
-
 obj-y			:= cacheinfo.o scattered.o topology.o
 obj-y			+= common.o
 obj-y			+= rdrand.o
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -752,6 +752,9 @@ void __init switch_gdt_and_percpu_base(i
 	 * early mapping is still valid. That means the GSBASE update will
 	 * lose any prior per CPU data which was not copied over in
 	 * setup_per_cpu_areas().
+	 *
+	 * This works even with stackprotector enabled because the
+	 * per CPU stack canary is 0 in both per CPU areas.
 	 */
 	wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
 #else


