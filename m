Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BDB73F7E4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjF0Izs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF0Izp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:55:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA13106
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5Ny9L6jimztD807PDMJRDq6FTZIqn8e389Sa7Yo1NDM=; b=BmmXOn2l5bAt41A3KyHsox4giX
        w0RDV4h3UIGlD1tyyWspuGX0XWivbH4zFXG8ZjFvOozxSgG+3uZBKogo20IuwmgHx/5wA87EShGyj
        AbfHAIfpnqJRRk5Po1UEjCzcw+lZwTKS9OoQ9/KM6/8E8Dreadq+8wd2dLY7HyOajLZ4qXbxuHgB+
        f+2bLzwv8vSgXhNnjRRx/mYOA9dzGfMWAiDsmh8GxTYMlqj5SDeZuGUO2OTZQ2kg6FUr0ulT7z4UA
        qbYSrRyQf9G2sMiGEang4TTLSlmh0lVLvWF7el1/pJjb8ifA5bMwnEAjtulWlK2o6SHkovew/IV3u
        khqHCidQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qE4S6-004c72-0J;
        Tue, 27 Jun 2023 08:55:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 526ED300118;
        Tue, 27 Jun 2023 10:53:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 030B9248044D4; Tue, 27 Jun 2023 10:53:31 +0200 (CEST)
Date:   Tue, 27 Jun 2023 10:53:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: objtool: Seeking help for improving switch table processing
Message-ID: <20230627085331.GW4253@hirez.programming.kicks-ass.net>
References: <951e6a05-5f37-a2dc-102e-f0a2e8eebb3e@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <951e6a05-5f37-a2dc-102e-f0a2e8eebb3e@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 10:06:23AM +0000, Christophe Leroy wrote:
> Hello Josh and Peter,
> 
> As mentionned in the cover letter of my series "powerpc/objtool: uaccess 
> validation for PPC32 (v3)" [1], a few  switch table lookup fail, and it 
> would help if you had ideas on how to handle them.
> 
> First one is as follows. First switch is properly detected, second is not.
> 
> 0000 00003818 <vsnprintf>:
> ...
> 0054     386c:	3f 40 00 00 	lis     r26,0	386e: R_PPC_ADDR16_HA	.rodata+0x6c
> 0058     3870:	3f 20 00 00 	lis     r25,0	3872: R_PPC_ADDR16_HA	.rodata+0x4c
> 005c     3874:	7f be eb 78 	mr      r30,r29
> 0060     3878:	3b 5a 00 00 	addi    r26,r26,0	387a: R_PPC_ADDR16_LO 
> .rodata+0x6c		<== First switch table address loaded in r26 register
> 0064     387c:	3b 39 00 00 	addi    r25,r25,0	387e: R_PPC_ADDR16_LO 
> .rodata+0x4c		<== Second switch table address loaded in r25 register
> ...
> 009c     38b4:	41 9d 02 64 	bgt     cr7,3b18 <vsnprintf+0x300>	<== 
> Conditional jump to where second switch is
> 00a0     38b8:	55 29 10 3a 	slwi    r9,r9,2
> 00a4     38bc:	7d 39 48 2e 	lwzx    r9,r25,r9
> 00a8     38c0:	7d 29 ca 14 	add     r9,r9,r25
> 00ac     38c4:	7d 29 03 a6 	mtctr   r9
> 00b0     38c8:	4e 80 04 20 	bctr		<== Dynamic switch branch based on r25 
> register
> ...
> 0300     3b18:	39 29 ff f8 	addi    r9,r9,-8
> 0304     3b1c:	55 2a 06 3e 	clrlwi  r10,r9,24
> 0308     3b20:	2b 8a 00 0a 	cmplwi  cr7,r10,10
> 030c     3b24:	89 3f 00 00 	lbz     r9,0(r31)
> 0310     3b28:	41 9d 01 88 	bgt     cr7,3cb0 <vsnprintf+0x498>
> 0314     3b2c:	55 4a 10 3a 	slwi    r10,r10,2
> 0318     3b30:	7d 5a 50 2e 	lwzx    r10,r26,r10
> 031c     3b34:	7d 4a d2 14 	add     r10,r10,r26
> 0320     3b38:	7d 49 03 a6 	mtctr   r10
> 0324     3b3c:	4e 80 04 20 	bctr		<== Dynamic switch branch based on r26 
> register
> ...

Josh is the one that knows most about the jump table stuff, but I think
he's traveling or something like that atm so he might be a little slow.

Is the problem above that both the .rodata references are before the
conditional jump, such that objtool fails to correlate the indirect jump
and .rodata ?

Looking at mark_func_jump_table() that only seems to consider
unconditional jumps wrt jump-tables and the above doesn't match this
pattern.

Worse is that the two jump tables are interleaved, this means the only
way to untangle things is to actually track the register state :/

Specifically, if GCC wanted it could flip the r25 and r26 loads and then
objtool wouldn't be able to match any of them I think. Because at that
point the first jump-table would match the r26 jump-table or so (I
think, I've not fully considered the current code).

Ho-humm... what a tangle.

So for AARGH64 we also had trouble with jump-tables, but LLVM-BOLT
managed to get that working:

  https://github.com/llvm/llvm-project/blob/main/bolt/lib/Target/AArch64/AArch64MCPlusBuilder.cpp#L458

perhaps we can glean a clue there, but I don't immediately see the same
patterns there.

I can't seem to come up with anything better than tracking the register
state, and effectively working back from 'ctr' to a .rodata. That's
going to be a bit of effort though...
