Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA9C5B99D4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiIOLlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiIOLkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D7F4D254
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=zQlKGQHBFgjVvjoX8AWmJKxWpsURbcGwMojDrLJkF48=; b=oLFRm731mRprOVVcavos11zRaa
        w2Bc+B1UcRnoNCdMQmqJ81JxsSOZA68QYje3oReh+dxShqIvQOi+CunnQzJ2c+cOC3fyF6jZ5noqc
        wTtQZTm1/zDxDo4M2fyJ7ILLsFv0aO8gnrwvsZkkcam3rzuALKc1n3ZVZFjTTkKmNuH+tfc7h8Pzp
        iXhl0E1kosRxi+EylD4iY84olQxz47F8foKlsLvV3/qV4aif+KFIlx9u8iskL9pF3ugzHnYDlBUdo
        0EEyK8Fwhi7EvgqS1VVAI/kfEpQVWtJtru09x1MGH+w4PvH1EKkZHB5ipoJONwVJ6xA2jkr4MP7oH
        Rqiu+pIA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDe-0012Nt-08; Thu, 15 Sep 2022 11:39:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC5DA302D68;
        Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9B1222BA7B112; Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Message-ID: <20220915111146.224130589@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:11:11 +0200
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
Subject: [PATCH v3 32/59] objtool: Allow STT_NOTYPE -> STT_FUNC+0 tail-calls
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

Allow STT_NOTYPE to tail-call into STT_FUNC, per definition STT_NOTYPE
is not a sub-function of the STT_FUNC.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1370,6 +1370,16 @@ static void add_return_call(struct objto
 
 static bool same_function(struct instruction *insn1, struct instruction *insn2)
 {
+	if (!insn1->func && !insn2->func)
+		return true;
+
+	/* Allow STT_NOTYPE -> STT_FUNC+0 tail-calls */
+	if (!insn1->func && insn1->func != insn2->func)
+		return false;
+
+	if (!insn2->func)
+		return true;
+
 	return insn1->func->pfunc == insn2->func->pfunc;
 }
 
@@ -1487,18 +1497,19 @@ static int add_jump_destinations(struct
 			    strstr(jump_dest->func->name, ".cold")) {
 				insn->func->cfunc = jump_dest->func;
 				jump_dest->func->pfunc = insn->func;
-
-			} else if (!same_function(insn, jump_dest) &&
-				   is_first_func_insn(file, jump_dest)) {
-				/*
-				 * Internal sibling call without reloc or with
-				 * STT_SECTION reloc.
-				 */
-				add_call_dest(file, insn, jump_dest->func, true);
-				continue;
 			}
 		}
 
+		if (!same_function(insn, jump_dest) &&
+		    is_first_func_insn(file, jump_dest)) {
+			/*
+			 * Internal sibling call without reloc or with
+			 * STT_SECTION reloc.
+			 */
+			add_call_dest(file, insn, jump_dest->func, true);
+			continue;
+		}
+
 		insn->jump_dest = jump_dest;
 	}
 


