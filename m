Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0D45B99C9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiIOLk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiIOLkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684C23F32A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=yIoG35cVddrSUYas1ovPM/6azqMQrScMR1ghVWokYpY=; b=qA0BQd460FdShIKOwmAddqtQA3
        2/ZL0+ApsDfdP2+sCn2Gu1iOJ5toPZVoRCHLVDF9qzmdbgciv3nWpafJDUftN8ZWgAhSUz2N104Lr
        dkgMbpj7CujgX+BlCWYP7Rp/UC48XyhAS+5km7ORCHlaArlSnB4mhwL0iRisRXUznMKi/WYNZK1vZ
        Ey00ETJ14bhlU88L5UAi6j7WIYVbP7y3QnPXCIaoqyYfDebLlZDatNm4ggx4r6eQCWB8oORhtsXgG
        MiJIZbhf94V0qDkuPuomsgK8REmDfIuyDs685ilAPBPgPmFvdddPZFply0yi24bJXexMag+e0rlyS
        5lju/0bQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDb-0012Mu-5s; Thu, 15 Sep 2022 11:39:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B637B3010C4;
        Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EF4CA29AADBEC; Thu, 15 Sep 2022 13:39:38 +0200 (CEST)
Message-ID: <20220915111143.614728935@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:10:46 +0200
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
Subject: [PATCH v3 07/59] x86: Sanitize linker script
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

The section ordering in the text section is more than suboptimal:

    ALIGN_ENTRY_TEXT_BEGIN
    ENTRY_TEXT
    ALIGN_ENTRY_TEXT_END
    SOFTIRQENTRY_TEXT
    STATIC_CALL_TEXT
    INDIRECT_THUNK_TEXT

ENTRY_TEXT is in a seperate PMD so it can be mapped into the cpu entry area
when KPTI is enabled. That means the sections after it are also in a
seperate PMD. That's wasteful especially as the indirect thunk text is a
hotpath on retpoline enabled systems and the static call text is fairly hot
on 32bit.

Move the entry text section last so that the other sections share a PMD
with the text before it. This is obviously just best effort and not
guaranteed when the previous text is just at a PMD boundary.

The text section placement needs an overhaul in general. There is e.g. no
point to have debugfs, sysfs, cpuhotplug and other rarely used functions
next to hot path text.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/vmlinux.lds.S |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -132,18 +132,19 @@ SECTIONS
 		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
-		ALIGN_ENTRY_TEXT_BEGIN
-		ENTRY_TEXT
-		ALIGN_ENTRY_TEXT_END
 		SOFTIRQENTRY_TEXT
-		STATIC_CALL_TEXT
-		*(.gnu.warning)
-
 #ifdef CONFIG_RETPOLINE
 		__indirect_thunk_start = .;
 		*(.text.__x86.*)
 		__indirect_thunk_end = .;
 #endif
+		STATIC_CALL_TEXT
+
+		ALIGN_ENTRY_TEXT_BEGIN
+		ENTRY_TEXT
+		ALIGN_ENTRY_TEXT_END
+		*(.gnu.warning)
+
 	} :text =0xcccc
 
 	/* End of text section, which should occupy whole number of pages */


