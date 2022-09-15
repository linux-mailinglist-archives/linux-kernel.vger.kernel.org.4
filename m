Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D2C5B9A03
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiIOLod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiIOLlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:41:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E367C778
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=LJYRuy5MUBpvdFzRrxNRJ46Veaw2HYHPfKqWAAmsnTo=; b=eXc7fXSPhCQnNuBfdEJ2OlESIn
        U/sdbRmC/MrxUGBzgzYxPC/SrjVori3reHdwga4ZMbKQ7fKnGl1n8y6v6zwSMcuaD9s1RhfELvChP
        ChpnqMCOoZm+0K/M8SjrHNvMbBlALyXxPeRzC1kikLIx4DTHdntIf15RzjlrBG+bOaGBNwECnf2mW
        HZ5lJ42QOXIj1Vpovirdo3m4kvsGbPFlRPM04G1EHCVyDhQU+IWvpRY01UbnWIiCsDsJYIVsQ3Wmz
        lmcvscElmPVl6/JQxLBaYg/twa9FUFWycLSch5xyiDQKlnfZq9BiHnSpsPkEIE/FrleMgI8Jak323
        +YFyuk6Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDa-00Caao-5Q; Thu, 15 Sep 2022 11:39:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CAC19301C46;
        Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2CA4E29AADBF1; Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Message-ID: <20220915111144.353555711@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:10:53 +0200
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
Subject: [PATCH v3 14/59] crypto: x86/cast5: Remove redundant alignments
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
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
@@ -208,7 +208,6 @@
 
 .text
 
-.align 16
 SYM_FUNC_START_LOCAL(__cast5_enc_blk16)
 	/* input:
 	 *	%rdi: ctx
@@ -282,7 +281,6 @@ SYM_FUNC_START_LOCAL(__cast5_enc_blk16)
 	RET;
 SYM_FUNC_END(__cast5_enc_blk16)
 
-.align 16
 SYM_FUNC_START_LOCAL(__cast5_dec_blk16)
 	/* input:
 	 *	%rdi: ctx


