Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA9674B327
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjGGOjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjGGOjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:39:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ECC1FC4;
        Fri,  7 Jul 2023 07:39:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DB7F619C4;
        Fri,  7 Jul 2023 14:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E802AC433C8;
        Fri,  7 Jul 2023 14:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688740758;
        bh=NI7RBLeyQ5xQGmyWwqLDZomiDo2pHyAV8zW7+8DEiZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RCFGi+BIYCM+8/xBFPEBpeiZjLRAEMBCUQsMysFT/3wOugpYZHGTDlRZxS+Co6WyH
         7+ZRrnw6hB8uf1XJ3p7IBpaKSHc+g1Im89OST48r58zG+VdPtvlwYa9iLVDvlBXr9T
         q0SFGDsplQWu1qmlobnCehaQ3kIE2Cka+aSaLi0MJHQVmydG+exkIYXM2dPH/qGtNZ
         biKcV4OXb7p+7U8ykud2HnxqkrXmNdOTrit70dU44ciQugWbRzS8Gxwx4r8/MN1Ez8
         Vjfxu0FCvndbjrl9nFAFzq9SGwc843LdpuMUzRIEfwFEKeLUV2GAFq07RzOc07fjTb
         BcKQ4hxku/j8w==
Date:   Fri, 7 Jul 2023 23:39:13 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/retpoline,kprobes: Avoid treating rethunk as an
 indirect jump
Message-Id: <20230707233913.976ecfb1a312d03f9b07a2b2@kernel.org>
In-Reply-To: <20230706113403.GI2833176@hirez.programming.kicks-ass.net>
References: <20230705081547.25130-1-petr.pavlu@suse.com>
        <20230705081547.25130-3-petr.pavlu@suse.com>
        <20230705085857.GG462772@hirez.programming.kicks-ass.net>
        <20230705232038.3a6d03e18f7bafb14cdfed42@kernel.org>
        <20230705145017.GC4253@hirez.programming.kicks-ass.net>
        <20230706094723.6934105e03f652923796bf7e@kernel.org>
        <20230706071705.GD2833176@hirez.programming.kicks-ass.net>
        <20230706180014.06705096a594b71250ff3c94@kernel.org>
        <20230706113403.GI2833176@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2023 13:34:03 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jul 06, 2023 at 06:00:14PM +0900, Masami Hiramatsu wrote:
> > On Thu, 6 Jul 2023 09:17:05 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Thu, Jul 06, 2023 at 09:47:23AM +0900, Masami Hiramatsu wrote:
> > > 
> > > > > > If I understand correctly, all indirect jump will be replaced with JMP_NOSPEC.
> > > > > > If you read the insn_jump_into_range, I onlu jecks the jump code, not call.
> > > > > > So the functions only have indirect call still allow optprobe.
> > > > > 
> > > > > With the introduction of kCFI JMP_NOSPEC is no longer an equivalent to a
> > > > > C indirect jump.
> > > > 
> > > > If I understand correctly, kCFI is enabled by CFI_CLANG, and clang is not
> > > > using jump-tables by default, so we can focus on gcc. In that case
> > > > current check still work, correct?
> > > 
> > > IIRC clang can use jump tables, but like GCC needs RETPOLINE=n and
> > > IBT=n, so effectively nobody has them.
> > 
> > So if it requires RETPOLINE=n, current __indirect_thunk_start/end checking
> > is not required, right? (that code is embraced with "#ifdef CONFIG_RETPOLINE")
> 
> Correct.
> 
> > > 
> > > The reason I did mention kCFI though is that kCFI has a larger 'indirect
> > > jump' sequence, and I'm not sure we've thought about what can go
> > > sideways if that's optprobed.
> > 
> > If I understand correctly, kCFI checks only indirect function call (check
> > pointer), so no jump tables. Or does it use indirect 'jump' ?
> 
> Yes, it's indirect function calls only.
> 
> Imagine our function (bar) doing an indirect call, it will (as clang
> always does) have the function pointer in r11:
> 
> bar:
> 	...
> 	movl	$(-0x12345678),%r10d
> 	addl	-15(%r11), %r10d
> 	je	1f
> 	ud2
> 1:	call	__x86_indirect_thunk_r11
> 
> 
> 
> And then the function it calls (foo) looks like:
> 
> __cfi_foo:
> 	movl	$0x12345678, %eax
> 	.skip	11, 0x90
> foo:
> 	endbr
> 	....
> 
> 
> 
> So if the caller (in bar) and the callee (foo) have the same hash value
> (0x12345678 in this case) then it will be equal and we continue on our
> merry way.
> 
> However, if they do not match, we'll trip that #UD and the
> handle_cfi_failure() will try and match the address to
> __{start,stop}__kcfi_traps[]. Additinoally decode_cfi_insn() will try
> and decode that whole call sequence in order to obtain the target
> address and typeid (hash).

Thank you for the explanation! This helps me!

> 
> optprobes might disturb this code.

So either optprobe or kprobes (any text instrumentation) do not touch
__cfi_FUNC symbols light before FUNC.

> 
> > > I suspect the UD2 that's in there will go 'funny' if it's relocated into
> > > an optprobe, as in, it'll not be recognised as a CFI fail.
> > 
> > UD2 can't be optprobed (kprobe neither) because it can change the dumped
> > BUG address...
> 
> Right, same problem here. But could the movl/addl be opt-probed? That
> would wreck decode_cfi_insn(). Then again, if decode_cfi_insn() fails,
> we'll get report_cfi_failure_noaddr(), which is less informative.

Ok, so if that sequence is always expected, I can also prohibit probing it.
Or, maybe it is better to generalize the API to access original instruction
which is used from kprobes, so that decode_cfi_insn() can get the original
(non-probed) insn.

> 
> So it looks like nothing too horrible happens...
> 
> 


Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
