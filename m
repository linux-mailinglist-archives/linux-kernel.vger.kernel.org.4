Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC5B60D544
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiJYULw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiJYULj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:11:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5AA7A750
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=r0O1A5cCcJcSiywQeCYs1n88surn5b369qkAVUdXrbY=; b=lXH6RCe64PDOftKZYiV3BSdSyS
        Vf1YajQ1pZNPPNyQeqhAcoDkxeQj5Is8ivCIMW3x3XmccSusppC8cnqbdfOuogRx++v9KLbJk2+FS
        vKcmnUCExsnpkZCRQjpAxbICl/rwWmRyLS+M5zl4S+Ed/K8w3XxhMhnoTVd9zLNCrdtK5eNfxn2GZ
        5Q673p1zDJAdZWkFqjyPy76VGJCRUkjlldj9bVTI6C6Wnuxwa9hI9WPqynq1sPiKCW/Pq1j8sfhuF
        2SdWITEeeOM9+UhF5F86Tw8iHl2ehnBp2Kgwq9wiAZodatkH570UAwSYos3mqZv5svKsFSJcK9s1X
        JSQHdeYA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onQGh-006OK4-Sv; Tue, 25 Oct 2022 20:11:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B41D5300446;
        Tue, 25 Oct 2022 22:11:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 99DC920117B33; Tue, 25 Oct 2022 22:11:22 +0200 (CEST)
Message-ID: <20221025201057.945960823@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 25 Oct 2022 22:07:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, rostedt@goodmis.org,
        dave.hansen@intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        keescook@chromium.org, seanjc@google.com
Subject: [PATCH 4/5] x86/ftrace: Remove SYSTEM_BOOTING exceptions
References: <20221025200656.951281799@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that text_poke is available before ftrace, remove the
SYSTEM_BOOTING exceptions.

Specifically, this cures a W+X case during boot.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |   10 ----------
 arch/x86/kernel/ftrace.c      |    3 +--
 2 files changed, 1 insertion(+), 12 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1681,11 +1681,6 @@ void __ref text_poke_queue(void *addr, c
 {
 	struct text_poke_loc *tp;
 
-	if (unlikely(system_state == SYSTEM_BOOTING)) {
-		text_poke_early(addr, opcode, len);
-		return;
-	}
-
 	text_poke_flush(addr);
 
 	tp = &tp_vec[tp_vec_nr++];
@@ -1707,11 +1702,6 @@ void __ref text_poke_bp(void *addr, cons
 {
 	struct text_poke_loc tp;
 
-	if (unlikely(system_state == SYSTEM_BOOTING)) {
-		text_poke_early(addr, opcode, len);
-		return;
-	}
-
 	text_poke_loc_init(&tp, addr, opcode, len, emulate);
 	text_poke_bp_batch(&tp, 1);
 }
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -415,8 +415,7 @@ create_trampoline(struct ftrace_ops *ops
 
 	set_vm_flush_reset_perms(trampoline);
 
-	if (likely(system_state != SYSTEM_BOOTING))
-		set_memory_ro((unsigned long)trampoline, npages);
+	set_memory_ro((unsigned long)trampoline, npages);
 	set_memory_x((unsigned long)trampoline, npages);
 	return (unsigned long)trampoline;
 fail:


