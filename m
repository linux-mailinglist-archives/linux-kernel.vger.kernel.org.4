Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998BC633741
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiKVIfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiKVIf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:35:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0E2419A0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yHp1AsAmHyPZmizl0nTdscJwTXgkYHDTI8L4G1VCVVM=; b=jgPGJOpa9YOcOQPUxq0blvWWHO
        5bgOleZB/sfY7n2RW0YoJeqFNbnGsHbun8HLBA7va6I2dkb84pYnGGAgnjqXPN5DMA+xU3zu6c+oX
        J36ghDx3K3UsKkjquR5oDDpXqElsGrwP/rkxwtwiaW0EkaBxlK891r7OWHy7chygUum//xGbe+2so
        7l7fnDtI3x2Ft2Wz95BQh2iXpCtyzgeQJ8y/UX3kKQDHF8k7+7aUhWTLFcGlB0tvGqmrXCruXtVO7
        3i444E6IxwLDt8gPY94MQRGkQ9BTWVdO0LktlpDflWMxs+H0q6NJxSl8Wt0nr5IqZZSbnL9PG/+oP
        fgOiTezw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxOkW-0067UV-KJ; Tue, 22 Nov 2022 08:35:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9A56E300322;
        Tue, 22 Nov 2022 09:35:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1839C2D65BCDA; Tue, 22 Nov 2022 09:35:17 +0100 (CET)
Date:   Tue, 22 Nov 2022 09:35:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: objtool warning for next-20221118
Message-ID: <Y3yJxQJ9DwxTx7km@hirez.programming.kicks-ass.net>
References: <20221121040736.GA3738360@paulmck-ThinkPad-P17-Gen-1>
 <Y3thrQxfcvZSXFlr@hirez.programming.kicks-ass.net>
 <20221121145215.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <20221122051605.4hcbslwxez2trdvt@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122051605.4hcbslwxez2trdvt@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 09:16:05PM -0800, Josh Poimboeuf wrote:

> It's complaining about an unreachable instruction after a call to
> arch_cpu_idle_dead().  In this case objtool detects the fact
> arch_cpu_idle_dead() doesn't return due to its call to the
> non-CONFIG_SMP version of play_dead().  But GCC has no way of detecting
> that because the caller is in another translation unit.
> 
> As far as I can tell, that function should never return.  Though it
> seems to have some dubious semantics (see xen_pv_play_dead() for
> example, which *does* seem to return?).  I'm thinking it would be an
> improvement to enforce that noreturn behavior across all arches and
> platforms, sprinkling __noreturn and BUG() on arch_cpu_idle_dead() and
> maybe some of it callees, where needed.
> 
> Peter, what do you think?  I could attempt a patch.

I'm thinking the Xen case makes all this really rather difficult :/

While normally a CPU is brought up through a trampoline, Xen seems to
have implemented it by simply returning from play_dead(), and afaict
that is actually a valid way to go about doing it.

Perhaps the best way would be to stick a REACHABLE annotation in
arch_cpu_idle_dead() or something?

---
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c21b7347a26d..0354be027eb0 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -712,6 +712,7 @@ void arch_cpu_idle_enter(void)
 void arch_cpu_idle_dead(void)
 {
 	play_dead();
+	asm(ASM_REACHABLE);
 }
 
 /*
