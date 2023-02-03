Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E04689CB0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbjBCPFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbjBCPF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:05:28 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B3DA1453
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 07:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7qLqfd/zT7JNgg/tFf8ngVkPA8WMUxu4Pyp8kYe9SCw=; b=CQWt5HnYYEqKe3zzi1h0uaHCK6
        y68K65o74N8REbEhKxfU8Bj4D32Q1eU/m5R/5CYGpj9zc6MzXxiMsqZDz8bQLt7PlR0154t/MsTIh
        G1A+7fn6ODNNJhABJJuQjirD+w1VF+IzGgpuOK7WQhreSQ3apg8Y1TtA0GHbIXAl1lguIUiNk2COZ
        /8wd7NCnu/oN1kvMNDqvediIJde3R+JCZ7DyAmt2jTMvWbzy9Inxw7wV3hqF+0o1fN6n99//ohKYe
        /5NgDMEB45Ohdunt71bK8dWa0zhTdFucfeWGT7f+5v04tlpB9G5cIfhGEnU9Uos3yVf7C4jLVo3m3
        dU0rKxJQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pNxbw-005XPB-2T;
        Fri, 03 Feb 2023 15:04:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7305930012F;
        Fri,  3 Feb 2023 16:04:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57BEE23F3C7F0; Fri,  3 Feb 2023 16:04:55 +0100 (CET)
Date:   Fri, 3 Feb 2023 16:04:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86/alternative: Support relocations in alternatives
Message-ID: <Y90ilxBFMAQZ/dRg@hirez.programming.kicks-ass.net>
References: <Y9py2a5Xw0xbB8ou@hirez.programming.kicks-ass.net>
 <Y90IaYHDbCN9P0OX@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y90IaYHDbCN9P0OX@zn.tnic>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 02:13:13PM +0100, Borislav Petkov wrote:
> On Wed, Feb 01, 2023 at 03:10:33PM +0100, Peter Zijlstra wrote:
> > (sorry for the repost, forgot lkml)
> 
> Btw, you need to rediff this against tip/master. There's alt_instr.flags
> change in there which conflicts with yours.
> 
> > +static void __always_inline
> > +apply_reloc(int n, void *ptr, uintptr_t diff)
> > +{
> > +	switch (n) {
> > +	case 1: apply_reloc_n(8, ptr, diff); break;
> > +	case 2: apply_reloc_n(16, ptr, diff); break;
> > +	case 4: apply_reloc_n(32, ptr, diff); break;
> > +	default: BUG();
> > +	}
> > +}
> > +
> > +static void __init_or_module noinline
> > +apply_relocation(u8 *instr, size_t len, u8 *dest, u8 *src, size_t src_len)
> 
> First param is instr, third is dest.
> 
> at the call site you have
> 
> apply_relocation(insn_buff, a->instrlen, instr, replacement, a->replacementlen);
> 
> and instr is third param. Let's call the function params:
> 
> static void __init_or_module noinline
> apply_relocation(u8 *insn_buff, size_t len, u8 *instr, u8 *repl, size_t repl_len)

How about:

  apply_relocation(u8 *buf, size_t len, u8 *dst, u8 *src, size_t src_len)

Because I get horribly confused by the whole instr and repl thing.

> > +{
> > +	struct insn insn;
> > +	int i = 0;
> > +
> > +	for (;;) {
> > +		if (insn_decode_kernel(&insn, &instr[i]))
> 
> I guess say a warning here so that we catch when it goes into the fields early.

Sure..

> > +			return;
> > +
> > +		switch (insn.opcode.bytes[0]) {
> > +		case 0x0f:
> > +			if (insn.opcode.bytes[1] < 0x80 ||
> > +			    insn.opcode.bytes[1] > 0x8f)
> > +				break;
> > +
> > +			fallthrough;	/* Jcc.d32 */
> > +		case 0x70 ... 0x7f:	/* Jcc.d8 */
> > +		case JMP8_INSN_OPCODE:
> > +		case JMP32_INSN_OPCODE:
> > +		case CALL_INSN_OPCODE:
> > +			u8 *target = src + i + insn.length + insn.immediate.value;
> > +			if (target < src || target > src + src_len) {
> > +				apply_reloc(insn.immediate.nbytes,
> > +					    instr + i + insn_offset_immediate(&insn),
> > +					    src - dest);
> > +			}
> 
> Uff, it took me a while to parse this. So this can be simpler. The basic
> math is:
> 
> 	new_offset = next_rip - target_address;
> 
> where
> 	next_rip = instr + insn.length;
> 
> and I admit that my function was a bit clumsy but I think yours can be
> made simpler while keeping it cleaner.

I'm not sure what you're saying here... so let me walk through the whole
thing (specifically the immediate case, since that's what you quote). So
what we need is:

	src_imm = target - src_next_ip			(1)

what we want is:

	dst_imm = target - dst_next_ip			(2)

so what we do is rework (1) as an expression for target like:

	target = src_imm + src_next_ip			(1a)

and substitute in (2) to get:

	dst_imm = (src_imm + src_next_ip) - dst_next_ip	(3)

Now, since the instruction stream is 'identical' at src and dest
we can state that:

	src_next_ip = src + ip_offset
	dst_next_ip = dst + ip_offset			(4)

Substitute (4) in (3) and observe ip_offset being cancelled out to
obtain:

	dst_imm = src_imm + (src + ip_offset) - (dst + ip_offset)
	        = src_imm + src - dst + ip_offset - ip_offset
	        = src_imm + src - dst			(5)

The very thing I did.

IOW, we can correct the displacement without caring about which actual
instruction in the stream we're correcting since the relative offset is
given by 'src - dst'. IOW, we don't give a crap about insn.length in
this case ;-)

> Also, calling this all "reloc" here is kinda confusing because this is not a
> relocation but the offset from the next RIP to the target of the
> JMP/CALL.

Well, we do relocate the instructions... They go from one place to
another.
