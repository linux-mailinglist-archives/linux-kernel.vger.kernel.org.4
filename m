Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9879D739FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjFVLpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjFVLpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:45:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9D5198
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+BhRaW8LJ0oFZlmeLIyUm12tgrUbyFfd68xPlAxbVpE=; b=fMJt4AOMjXc4uuWTLSapOMlRAe
        lNyyrb8ba1QPINqj48d7uvTSg6HJNkjQ/OTKcxea50O8qGe0M2uS48Dn4XTB8JhBvAe8XWJngfRnj
        IUkGNxyeNO8o/Zt+4rVthJMvUmP7A9y69xZTAK3/3jSIdwTdc3r30yhTI/v0aa3iSLfV2WFUMNPl7
        XDrSXKyWq4Q+TiGwXTt3BtD5z4DGRtC/h2Y7am/d9ww/HXdbDbzq+DFhXoWghUOMHkcFR705kePnz
        IgCHMCT9MQgsbY37VkMsaH4FOOpEmbV12S8yNkr96WJN3XJ0+qJp3etev5hKrn9B/rbLZ4ZprcVfW
        3pBztRUw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qCIkL-001AnW-0d;
        Thu, 22 Jun 2023 11:45:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B9860300137;
        Thu, 22 Jun 2023 13:45:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A8EFE24263360; Thu, 22 Jun 2023 13:45:04 +0200 (CEST)
Date:   Thu, 22 Jun 2023 13:45:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Naveen N Rao <naveen@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 09/14] objtool: Add INSN_RETURN_CONDITIONAL
Message-ID: <20230622114504.GK4253@hirez.programming.kicks-ass.net>
References: <cover.1687430631.git.christophe.leroy@csgroup.eu>
 <c25524d42cb03b1acfb7ab325b9e8881befba53b.1687430631.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c25524d42cb03b1acfb7ab325b9e8881befba53b.1687430631.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 12:54:31PM +0200, Christophe Leroy wrote:
> Most functions have an unconditional return at the end, like
> this one:
> 
> 	00000000 <is_exec_fault>:
> 	   0:	81 22 04 d0 	lwz     r9,1232(r2)
> 	   4:	38 60 00 00 	li      r3,0
> 	   8:	2c 09 00 00 	cmpwi   r9,0
> 	   c:	4d 82 00 20 	beqlr		<== Conditional return
> 	  10:	80 69 00 a0 	lwz     r3,160(r9)
> 	  14:	54 63 00 36 	clrrwi  r3,r3,4
> 	  18:	68 63 04 00 	xori    r3,r3,1024
> 	  1c:	7c 63 00 34 	cntlzw  r3,r3
> 	  20:	54 63 d9 7e 	srwi    r3,r3,5
> 	  24:	4e 80 00 20 	blr		<== Unconditional return
> 
> But other functions like this other one below only have
> conditional returns:
> 
> 	00000028 <pte_update.isra.0>:
> 	  28:	81 25 00 00 	lwz     r9,0(r5)
> 	  2c:	2c 08 00 00 	cmpwi   r8,0
> 	  30:	7d 29 30 78 	andc    r9,r9,r6
> 	  34:	7d 27 3b 78 	or      r7,r9,r7
> 	  38:	54 84 65 3a 	rlwinm  r4,r4,12,20,29
> 	  3c:	81 23 00 18 	lwz     r9,24(r3)
> 	  40:	41 82 00 58 	beq     98 <pte_update.isra.0+0x70>
> 	  44:	7d 29 20 2e 	lwzx    r9,r9,r4
> 	  48:	55 29 07 3a 	rlwinm  r9,r9,0,28,29
> 	  4c:	2c 09 00 0c 	cmpwi   r9,12
> 	  50:	41 82 00 08 	beq     58 <pte_update.isra.0+0x30>
> 	  54:	39 00 00 80 	li      r8,128
> 	  58:	2c 08 00 01 	cmpwi   r8,1
> 	  5c:	90 e5 00 00 	stw     r7,0(r5)
> 	  60:	4d a2 00 20 	beqlr+		<== Conditional return
> 	  64:	7c e9 3b 78 	mr      r9,r7
> 	  68:	39 40 00 00 	li      r10,0
> 	  6c:	39 4a 00 04 	addi    r10,r10,4
> 	  70:	7c 0a 40 00 	cmpw    r10,r8
> 	  74:	91 25 00 04 	stw     r9,4(r5)
> 	  78:	91 25 00 08 	stw     r9,8(r5)
> 	  7c:	38 a5 00 10 	addi    r5,r5,16
> 	  80:	91 25 ff fc 	stw     r9,-4(r5)
> 	  84:	4c 80 00 20 	bgelr		<== Conditional return
> 	  88:	55 49 60 26 	slwi    r9,r10,12
> 	  8c:	7d 29 3a 14 	add     r9,r9,r7
> 	  90:	91 25 00 00 	stw     r9,0(r5)
> 	  94:	4b ff ff d8 	b       6c <pte_update.isra.0+0x44>
> 	  98:	39 00 00 04 	li      r8,4
> 	  9c:	4b ff ff bc 	b       58 <pte_update.isra.0+0x30>
> 
> If conditional returns are decoded as INSN_OTHER, objtool considers
> that the second function never returns.
> 
> If conditional returns are decoded as INSN_RETURN, objtool considers
> that code after that conditional return is dead.
> 
> To overcome this situation, introduce INSN_RETURN_CONDITIONAL which
> is taken as a confirmation that a function is not noreturn but still
> sees following code as reachable.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  tools/objtool/check.c                | 2 +-
>  tools/objtool/include/objtool/arch.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 0fcf99c91400..8977cdf93f54 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -259,7 +259,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
>  	func_for_each_insn(file, func, insn) {
>  		empty = false;
>  
> -		if (insn->type == INSN_RETURN)
> +		if (insn->type == INSN_RETURN || insn->type == INSN_RETURN_CONDITIONAL)
>  			return false;
>  	}
>  
> diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
> index 2b6d2ce4f9a5..84ba75112934 100644
> --- a/tools/objtool/include/objtool/arch.h
> +++ b/tools/objtool/include/objtool/arch.h
> @@ -19,6 +19,7 @@ enum insn_type {
>  	INSN_CALL,
>  	INSN_CALL_DYNAMIC,
>  	INSN_RETURN,
> +	INSN_RETURN_CONDITIONAL,
>  	INSN_CONTEXT_SWITCH,
>  	INSN_BUG,
>  	INSN_NOP,
> -- 
> 2.40.1
> 
