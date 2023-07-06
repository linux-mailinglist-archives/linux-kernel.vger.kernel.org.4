Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F3F749AB5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjGFLe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjGFLe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:34:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952511727;
        Thu,  6 Jul 2023 04:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eKY/Uo90bROTMojvs7v+DqKoFW8MQafmKj7nGaM0SMo=; b=DS4GEvci5dv0oamCOC8VOMsYPA
        0qb9WGqNf7NESEYk7b1y7Osv20dwQHcCS9hxAUM9a0Kg3EyoKgjr3KtTEK6G00Kzk0Q0vpTsLFyu3
        BnqDv6OmsoMjZezdt6+ARvuS8VWFYBy8hhY99/TqjRsBxVAPKXyxw5QrYt+f/Gh8aVePQFIEaJwYm
        xQ7nHlpRYUm6VaGEyIMHBKNrUQiulWEXU6mPfZ/wG79dlNH3MHz92m0TJ45Q+8VYc4yfYhD5jeT50
        vIyQPrxKgLiEk3tehEFDobHnfRFfJG6uorDiESVx8yce88JpLJkQpC4iv7kKFZPYabjgX1GjwuDSK
        A4/bxYsg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHNFN-00DZN3-24;
        Thu, 06 Jul 2023 11:34:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 936FC300095;
        Thu,  6 Jul 2023 13:34:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C085200BDD20; Thu,  6 Jul 2023 13:34:03 +0200 (CEST)
Date:   Thu, 6 Jul 2023 13:34:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/retpoline,kprobes: Avoid treating rethunk as an
 indirect jump
Message-ID: <20230706113403.GI2833176@hirez.programming.kicks-ass.net>
References: <20230705081547.25130-1-petr.pavlu@suse.com>
 <20230705081547.25130-3-petr.pavlu@suse.com>
 <20230705085857.GG462772@hirez.programming.kicks-ass.net>
 <20230705232038.3a6d03e18f7bafb14cdfed42@kernel.org>
 <20230705145017.GC4253@hirez.programming.kicks-ass.net>
 <20230706094723.6934105e03f652923796bf7e@kernel.org>
 <20230706071705.GD2833176@hirez.programming.kicks-ass.net>
 <20230706180014.06705096a594b71250ff3c94@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706180014.06705096a594b71250ff3c94@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 06:00:14PM +0900, Masami Hiramatsu wrote:
> On Thu, 6 Jul 2023 09:17:05 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Jul 06, 2023 at 09:47:23AM +0900, Masami Hiramatsu wrote:
> > 
> > > > > If I understand correctly, all indirect jump will be replaced with JMP_NOSPEC.
> > > > > If you read the insn_jump_into_range, I onlu jecks the jump code, not call.
> > > > > So the functions only have indirect call still allow optprobe.
> > > > 
> > > > With the introduction of kCFI JMP_NOSPEC is no longer an equivalent to a
> > > > C indirect jump.
> > > 
> > > If I understand correctly, kCFI is enabled by CFI_CLANG, and clang is not
> > > using jump-tables by default, so we can focus on gcc. In that case
> > > current check still work, correct?
> > 
> > IIRC clang can use jump tables, but like GCC needs RETPOLINE=n and
> > IBT=n, so effectively nobody has them.
> 
> So if it requires RETPOLINE=n, current __indirect_thunk_start/end checking
> is not required, right? (that code is embraced with "#ifdef CONFIG_RETPOLINE")

Correct.

> > 
> > The reason I did mention kCFI though is that kCFI has a larger 'indirect
> > jump' sequence, and I'm not sure we've thought about what can go
> > sideways if that's optprobed.
> 
> If I understand correctly, kCFI checks only indirect function call (check
> pointer), so no jump tables. Or does it use indirect 'jump' ?

Yes, it's indirect function calls only.

Imagine our function (bar) doing an indirect call, it will (as clang
always does) have the function pointer in r11:

bar:
	...
	movl	$(-0x12345678),%r10d
	addl	-15(%r11), %r10d
	je	1f
	ud2
1:	call	__x86_indirect_thunk_r11



And then the function it calls (foo) looks like:

__cfi_foo:
	movl	$0x12345678, %eax
	.skip	11, 0x90
foo:
	endbr
	....



So if the caller (in bar) and the callee (foo) have the same hash value
(0x12345678 in this case) then it will be equal and we continue on our
merry way.

However, if they do not match, we'll trip that #UD and the
handle_cfi_failure() will try and match the address to
__{start,stop}__kcfi_traps[]. Additinoally decode_cfi_insn() will try
and decode that whole call sequence in order to obtain the target
address and typeid (hash).

optprobes might disturb this code.

> > I suspect the UD2 that's in there will go 'funny' if it's relocated into
> > an optprobe, as in, it'll not be recognised as a CFI fail.
> 
> UD2 can't be optprobed (kprobe neither) because it can change the dumped
> BUG address...

Right, same problem here. But could the movl/addl be opt-probed? That
would wreck decode_cfi_insn(). Then again, if decode_cfi_insn() fails,
we'll get report_cfi_failure_noaddr(), which is less informative.

So it looks like nothing too horrible happens...


