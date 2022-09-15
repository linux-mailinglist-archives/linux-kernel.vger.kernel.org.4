Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F795B99FD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiIOLoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiIOLlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:41:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C85076956
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=SRnNkt6hDAocphBeeJEDz/2BjTiGPSIHa9g4nx269kU=; b=tnG3kvwTlIRX+GxaH06iEyTjWc
        RVu/h4U/LV7H2q4whqLG9tz5ChE6VEft+pObZoduusNgL71/PbbiCI4mSds3iex0sxgXYOtho5ErZ
        WKFRFNs9t4bMIXMksEUi1aSLa1WwKri4b6Gzl6U9bEsmIPpOZcYoj7HYTNQQp2eT9263k6XpAE7Gy
        Oef8nO8nFu7ZmDKfxCBPDyec+owGY4L+YXYKZarHzUzeVVZW0sW5W18I8wxDHteCi+G7SkpY1WULa
        xv2wTZugArszpRUEvdNBsIn6zKqt0YQl1iU+U/07SEhZZIDmm42MKwVF95ZzVyw15+3MwADfR4Vo6
        EDgjcdPg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDj-0012Qq-FJ; Thu, 15 Sep 2022 11:39:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 01A1D302EA5;
        Thu, 15 Sep 2022 13:39:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DC4B829AADBEC; Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Message-ID: <20220915111147.265598113@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:11:21 +0200
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
Subject: [PATCH v3 42/59] x86/entry: Make some entry symbols global
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

paranoid_entry(), error_entry() and xen_error_entry() have to be
exempted from call accounting by thunk patching because they are
before UNTRAIN_RET.

Expose them so they are available in the alternative code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -327,7 +327,8 @@ SYM_CODE_END(ret_from_fork)
 #endif
 .endm
 
-SYM_CODE_START_LOCAL(xen_error_entry)
+SYM_CODE_START(xen_error_entry)
+	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
@@ -906,7 +907,8 @@ SYM_CODE_END(xen_failsafe_callback)
  * R14 - old CR3
  * R15 - old SPEC_CTRL
  */
-SYM_CODE_START_LOCAL(paranoid_entry)
+SYM_CODE_START(paranoid_entry)
+	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
@@ -1041,7 +1043,8 @@ SYM_CODE_END(paranoid_exit)
 /*
  * Switch GS and CR3 if needed.
  */
-SYM_CODE_START_LOCAL(error_entry)
+SYM_CODE_START(error_entry)
+	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 
 	PUSH_AND_CLEAR_REGS save_ret=1


