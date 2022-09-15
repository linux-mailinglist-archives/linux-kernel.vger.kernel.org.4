Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EBE5B99DD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiIOLlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiIOLkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ABC57887
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=rYTe1/x3ip/EZzdOhJZl34EC0tPUaA+4E/+HaK9TnVE=; b=nIGHeFvFlqdtHuqKzYEm3lPR6K
        FSFwiIeDRpSY3QxPZRgW7ht3oZGmSbYcLIJVL1usPJw0r2uuTgOekDk8OxRIVCEW8LcRpQrKD6Hce
        KJrTNvhQQINCnz5yERfCwJ/ZLfsf0Kwr3JrqamnNqIV1R7VGo3KP+Ef01f76gVbQLE9wrVwvdYmIQ
        pp9eFJxF1DaoXOkoZ+fE2zzRKIDT44zzrMsJjv3SJb49AokP8MS0G0b8pDMhXzWPji4P/AkEIFUBP
        ECHg8bDxA6Vv5TUUaw1rGZ98rDsvgiB8tillS/E+61amXGToFnDbN/aiesw8kXIp9JxYZG/djI/Gr
        F6dD6NuA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDn-0012Tf-VJ; Thu, 15 Sep 2022 11:39:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 12465302ECC;
        Thu, 15 Sep 2022 13:39:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 02B7E29AADBF3; Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Message-ID: <20220915111147.787711192@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:11:26 +0200
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
Subject: [PATCH v3 47/59] x86/asm: Provide ALTERNATIVE_3
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

Fairly straight forward adaptation/extention of ALTERNATIVE_2.

Required for call depth tracking.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/alternative.h |   33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -364,6 +364,7 @@ static inline int alternatives_text_rese
 #define old_len			141b-140b
 #define new_len1		144f-143f
 #define new_len2		145f-144f
+#define new_len3		146f-145f
 
 /*
  * gas compatible max based on the idea from:
@@ -371,7 +372,8 @@ static inline int alternatives_text_rese
  *
  * The additional "-" is needed because gas uses a "true" value of -1.
  */
-#define alt_max_short(a, b)	((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))
+#define alt_max_2(a, b)		((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))
+#define alt_max_3(a, b, c)	(alt_max_2(alt_max_2(a, b), c))
 
 
 /*
@@ -383,8 +385,8 @@ static inline int alternatives_text_rese
 140:
 	\oldinstr
 141:
-	.skip -((alt_max_short(new_len1, new_len2) - (old_len)) > 0) * \
-		(alt_max_short(new_len1, new_len2) - (old_len)),0x90
+	.skip -((alt_max_2(new_len1, new_len2) - (old_len)) > 0) * \
+		(alt_max_2(new_len1, new_len2) - (old_len)),0x90
 142:
 
 	.pushsection .altinstructions,"a"
@@ -401,6 +403,31 @@ static inline int alternatives_text_rese
 	.popsection
 .endm
 
+.macro ALTERNATIVE_3 oldinstr, newinstr1, feature1, newinstr2, feature2, newinstr3, feature3
+140:
+	\oldinstr
+141:
+	.skip -((alt_max_3(new_len1, new_len2, new_len3) - (old_len)) > 0) * \
+		(alt_max_3(new_len1, new_len2, new_len3) - (old_len)),0x90
+142:
+
+	.pushsection .altinstructions,"a"
+	altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f
+	altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f
+	altinstruction_entry 140b,145f,\feature3,142b-140b,146f-145f
+	.popsection
+
+	.pushsection .altinstr_replacement,"ax"
+143:
+	\newinstr1
+144:
+	\newinstr2
+145:
+	\newinstr3
+146:
+	.popsection
+.endm
+
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
 #define ALTERNATIVE_TERNARY(oldinstr, feature, newinstr_yes, newinstr_no) \
 	ALTERNATIVE_2 oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\


