Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3E768997D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjBCNNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjBCNNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:13:21 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE8B302AB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 05:13:18 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED5CE1EC02F2;
        Fri,  3 Feb 2023 14:13:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675429997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=64Las0simtBHZlJy4qllj8qNkBUp8L4knJbkayTgmUo=;
        b=FbG9cm6269RvTGXj66p8cya/iqHNVSmp+bOOFClthToBMh4+e1XvCWFeOmHFCoBTcRd28e
        odiaXb+KFGDSs5AsubS8khIkI4thFdMK9eAOZOoHyXJMs4bHBMJD55JLCtcYo/KgHVSKs4
        0ETb0daD82DC89e+EmPmhTBQmsYVgK0=
Date:   Fri, 3 Feb 2023 14:13:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86/alternative: Support relocations in alternatives
Message-ID: <Y90IaYHDbCN9P0OX@zn.tnic>
References: <Y9py2a5Xw0xbB8ou@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9py2a5Xw0xbB8ou@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 03:10:33PM +0100, Peter Zijlstra wrote:
> (sorry for the repost, forgot lkml)

Btw, you need to rediff this against tip/master. There's alt_instr.flags
change in there which conflicts with yours.

> +static void __always_inline
> +apply_reloc(int n, void *ptr, uintptr_t diff)
> +{
> +	switch (n) {
> +	case 1: apply_reloc_n(8, ptr, diff); break;
> +	case 2: apply_reloc_n(16, ptr, diff); break;
> +	case 4: apply_reloc_n(32, ptr, diff); break;
> +	default: BUG();
> +	}
> +}
> +
> +static void __init_or_module noinline
> +apply_relocation(u8 *instr, size_t len, u8 *dest, u8 *src, size_t src_len)

First param is instr, third is dest.

at the call site you have

apply_relocation(insn_buff, a->instrlen, instr, replacement, a->replacementlen);

and instr is third param. Let's call the function params:

static void __init_or_module noinline
apply_relocation(u8 *insn_buff, size_t len, u8 *instr, u8 *repl, size_t repl_len)

for less confusion pls.

> +{
> +	struct insn insn;
> +	int i = 0;
> +
> +	for (;;) {
> +		if (insn_decode_kernel(&insn, &instr[i]))

I guess say a warning here so that we catch when it goes into the fields early.

> +			return;
> +
> +		switch (insn.opcode.bytes[0]) {
> +		case 0x0f:
> +			if (insn.opcode.bytes[1] < 0x80 ||
> +			    insn.opcode.bytes[1] > 0x8f)
> +				break;
> +
> +			fallthrough;	/* Jcc.d32 */
> +		case 0x70 ... 0x7f:	/* Jcc.d8 */
> +		case JMP8_INSN_OPCODE:
> +		case JMP32_INSN_OPCODE:
> +		case CALL_INSN_OPCODE:
> +			u8 *target = src + i + insn.length + insn.immediate.value;
> +			if (target < src || target > src + src_len) {
> +				apply_reloc(insn.immediate.nbytes,
> +					    instr + i + insn_offset_immediate(&insn),
> +					    src - dest);
> +			}

Uff, it took me a while to parse this. So this can be simpler. The basic
math is:

	new_offset = next_rip - target_address;

where
	next_rip = instr + insn.length;

and I admit that my function was a bit clumsy but I think yours can be
made simpler while keeping it cleaner.

Also, calling this all "reloc" here is kinda confusing because this is not a
relocation but the offset from the next RIP to the target of the
JMP/CALL.

Lemme think about it a bit more.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
