Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A355B99DE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiIOLlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiIOLkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444865852F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=kiUBY9L9H1enuPzKP5b8g1QT9pTcpJ/p9g5AdHuOGVs=; b=D5KiYKMbnzJuxG8dlfRrlEU9BF
        Mnz3zkBgRl2jxyILl1gywmBTv8FYbubw48DWekP/yVOveYe5JGUdQJpJalzAC94sCn5+E/tNGSvxY
        yQkGFUi5o7/u7bsalFpyfrJngIco6EREsRvik8gdSSAErifQ+u9yfg9lEFApwNCTCR3lx3Lux7V0F
        y+TNk9/3TmF1+Zd6ziWMX1rFpQ5FsHyB3VRR5RjhGPUDLZtwyKc6I7hAAdwspiAXCIo874g3esmP0
        bOq1mT4Qn/CT5QEXb355NhbEL3+c3rxx6B7BpP7fa8aOT9NKnCDs3zyM2HwZRt1ziE3Bhj/IedYxn
        5wmFngcA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDc-0012N2-9U; Thu, 15 Sep 2022 11:39:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CCAF3301D8A;
        Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 39CA229AADBF6; Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Message-ID: <20220915111144.558544791@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:10:55 +0200
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
Subject: [PATCH v3 16/59] crypto: x86/serpent: Remove redundant alignments
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

SYM_FUNC_START*() and friends already imply alignment, remove custom
alignment hacks to make code consistent. This prepares for future
function call ABI changes.

Also, with having pushed the function alignment to 16 bytes, this
custom alignment is completely superfluous.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S |    2 --
 arch/x86/crypto/serpent-avx2-asm_64.S       |    2 --
 2 files changed, 4 deletions(-)

--- a/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
@@ -550,7 +550,6 @@
 #define write_blocks(x0, x1, x2, x3, t0, t1, t2) \
 	transpose_4x4(x0, x1, x2, x3, t0, t1, t2)
 
-.align 8
 SYM_FUNC_START_LOCAL(__serpent_enc_blk8_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
@@ -604,7 +603,6 @@ SYM_FUNC_START_LOCAL(__serpent_enc_blk8_
 	RET;
 SYM_FUNC_END(__serpent_enc_blk8_avx)
 
-.align 8
 SYM_FUNC_START_LOCAL(__serpent_dec_blk8_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
--- a/arch/x86/crypto/serpent-avx2-asm_64.S
+++ b/arch/x86/crypto/serpent-avx2-asm_64.S
@@ -550,7 +550,6 @@
 #define write_blocks(x0, x1, x2, x3, t0, t1, t2) \
 	transpose_4x4(x0, x1, x2, x3, t0, t1, t2)
 
-.align 8
 SYM_FUNC_START_LOCAL(__serpent_enc_blk16)
 	/* input:
 	 *	%rdi: ctx, CTX
@@ -604,7 +603,6 @@ SYM_FUNC_START_LOCAL(__serpent_enc_blk16
 	RET;
 SYM_FUNC_END(__serpent_enc_blk16)
 
-.align 8
 SYM_FUNC_START_LOCAL(__serpent_dec_blk16)
 	/* input:
 	 *	%rdi: ctx, CTX


