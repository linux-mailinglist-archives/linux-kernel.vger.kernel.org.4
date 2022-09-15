Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5055B99E6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiIOLmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiIOLki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBADF4BD16
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=LME5focdSzJ5De+xp1zvzMFJmKhIAe15paOq2fqAc04=; b=mLaZD07mNbpA6Hu6Nkr2inMjSG
        TmYtuV41j5/Z06g3ayJPyIS9XhkSbWoLiuhu6vGn1gvlsNtH+5MgrnrE2l67Ii1WcoPCDjurHuoQx
        sBsy6TT7x3UJGW4hbai92wsr6KI1kPQgv68wrRsXzug1ziIJ2MDuM5u/hsFddiQVsqEDqTbNMhjsr
        BMzXVUKfkfKdQ7q5yBrJZsVefooNjFsGculBjNreaivPC0KLtFuIaHZNrAVLf/Ov2kfcnJcImu4E8
        LebduAN1jZCJf/GDVMVv662quVypvU23Vpgg1oJC2ajzXe6xuF2B/UCCQwkIsj2IqqmeLRL4rok86
        /LGlirmg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDi-0012Qg-W0; Thu, 15 Sep 2022 11:39:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0DC4302D92;
        Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B327E29AADBE4; Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Message-ID: <20220915111146.643451455@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:11:15 +0200
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
Subject: [PATCH v3 36/59] ftrace: Add HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
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

From: Peter Zijlstra <peterz@infradead.org>

x86 will shortly start using -fpatchable-function-entry for purposes
other than ftrace, make sure the __patchable_function_entry section
isn't merged in the mcount_loc section.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/vmlinux.lds.h |   11 ++++++++++-
 kernel/trace/Kconfig              |    6 ++++++
 tools/objtool/check.c             |    3 ++-
 3 files changed, 18 insertions(+), 2 deletions(-)

--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -159,6 +159,14 @@
 #define MEM_DISCARD(sec) *(.mem##sec)
 #endif
 
+#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
+#define KEEP_PATCHABLE		KEEP(*(__patchable_function_entries))
+#define PATCHABLE_DISCARDS
+#else
+#define KEEP_PATCHABLE
+#define PATCHABLE_DISCARDS	*(__patchable_function_entries)
+#endif
+
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 /*
  * The ftrace call sites are logged to a section whose name depends on the
@@ -177,7 +185,7 @@
 #define MCOUNT_REC()	. = ALIGN(8);				\
 			__start_mcount_loc = .;			\
 			KEEP(*(__mcount_loc))			\
-			KEEP(*(__patchable_function_entries))	\
+			KEEP_PATCHABLE				\
 			__stop_mcount_loc = .;			\
 			ftrace_stub_graph = ftrace_stub;	\
 			ftrace_ops_list_func = arch_ftrace_ops_list_func;
@@ -1029,6 +1037,7 @@
 
 #define COMMON_DISCARDS							\
 	SANITIZER_DISCARDS						\
+	PATCHABLE_DISCARDS						\
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.modinfo)							\
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -51,6 +51,12 @@ config HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	 This allows for use of regs_get_kernel_argument() and
 	 kernel_stack_pointer().
 
+config HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
+	bool
+	help
+	  If the architecture generates __patchable_function_entries sections
+	  but does not want them included in the ftrace locations.
+
 config HAVE_FTRACE_MCOUNT_RECORD
 	bool
 	help
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4196,7 +4196,8 @@ static int validate_ibt(struct objtool_f
 		    !strcmp(sec->name, "__bug_table")			||
 		    !strcmp(sec->name, "__ex_table")			||
 		    !strcmp(sec->name, "__jump_table")			||
-		    !strcmp(sec->name, "__mcount_loc"))
+		    !strcmp(sec->name, "__mcount_loc")			||
+		    strstr(sec->name, "__patchable_function_entries"))
 			continue;
 
 		list_for_each_entry(reloc, &sec->reloc->reloc_list, list)


