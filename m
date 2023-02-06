Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5872668C00F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjBFO3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBFO3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:29:17 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3784730C4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:29:16 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B5FDA1EC067D;
        Mon,  6 Feb 2023 15:29:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675693754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zwzqalE4/Rjb5RtDU4ACU2k23pCh4TbVsdgfL0LfdXw=;
        b=qrjccl6jZGnG5XLsqGWrCwH/CwIFJa6qkxMEqY8GZUmh2sF3BW5Fs/yediAfMx4gHz2yvT
        P6gD4aXXfCGTNQ3xeBK5bmy8YiQWQoj/RcY4X8AJxBazu5MnCs3NdbvNIDayhwDc+/tKLo
        526Vh+A641mYefDvSeS3+gJAvUmCFpw=
Date:   Mon, 6 Feb 2023 15:29:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86/alternative: Support relocations in alternatives
Message-ID: <Y+EOtNlYLg1VsqiN@zn.tnic>
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
> +apply_relocation(u8 *instr, size_t len, u8 *dest, u8 *src, size_t src_len)
> +{
> +	struct insn insn;
> +	int i = 0;
> +
> +	for (;;) {
> +		if (insn_decode_kernel(&insn, &instr[i]))
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

Ok, here's an addition to convert to 2-byte JMPs. I'll do a proper diff
after you refresh yours ontop but this is how it looks like. It
basically does one more pass on the instr[] array bytes after the
relocation and only for JMP rel32off insns, i.e., opcode 0xe9.

Example would be:

[    1.059455] SMP alternatives: feat: 3*32+21, old: (fpu_clone+0x115/0x290 (ffffffff8102e2e5) len: 5), repl: (ffffffff898ac1b6, len: 5)
[    1.060747] SMP alternatives: apply_reloc: n: 4, ptr: 0xffffffff82203d93, diff: 0x887ded1
										   ^^^^^^^^^^

That's the diff you pass to apply_reloc_n()

[    1.062692] SMP alternatives: ffffffff8102e2e5:   old_insn: e9 dd b8 6a 08
[    1.063452] SMP alternatives: ffffffff898ac1b6:   rpl_insn: e9 41 21 78 f7

But the end offset is simply 0x15. (0x12 with the 5-byte JMP).

So we can just as well do JMP rel8off which takes a signed byte as an
offset. And slap a 3-byte NOP after that:

[    1.064211] SMP alternatives: ffffffff8102e2e5: final_insn: eb 15 0f 1f 00

		...
		case JMP32_INSN_OPCODE:
		case CALL_INSN_OPCODE:
			u8 *target = src + i + insn.length + insn.immediate.value;
			u8 opcode = instr[i];

			if (target < src || target > src + src_len) {
				apply_reloc(insn.immediate.nbytes,
					    instr + i + insn_offset_immediate(&insn),
					    src - dest);

#define JMP_SIZE_DIFF	JMP32_INSN_SIZE - JMP8_INSN_SIZE
				if (opcode == JMP32_INSN_OPCODE) {
					s32 jmp_off;

					jmp_off = *(s32 *)(instr + i + insn_offset_immediate(&insn));
					jmp_off += JMP_SIZE_DIFF;

					/* Turn it into a 2-byte JMP if new offset allows. */
					if (jmp_off >= -128 && jmp_off <= 127) {
						instr[i] = JMP8_INSN_OPCODE;
						instr[i + 1] = (s8)jmp_off;
						add_nops(instr + i + 2, JMP_SIZE_DIFF);
					}
				}
			}
		}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
