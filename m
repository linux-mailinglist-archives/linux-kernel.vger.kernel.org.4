Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47250606BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 01:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJTXKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 19:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJTXKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 19:10:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA2C181DBD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:10:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64CD7B829D5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4975C433D7;
        Thu, 20 Oct 2022 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666307431;
        bh=mUpbVk88P/mHn7wzd4hWdjMZS2XKckhiC09mVv8+CR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ehMi1fvQNWw095PkzZee/r/S05Cfb9H4aW9z4jXRGvY3sPJIyvcYtCWZdhvoUYZXu
         keqjwYbmF6BIuLlH8wExXeRqNNcXC/BfEgHahHYyvYz79eC7w7Bi3ni7Xe+4ygra/S
         Y4TxILrWa7uCCl7/1tA7i/gR5jx4e7A5SiU6EiwqPOR+cPEh/TxFk2cH+X3LNGXzxO
         HU7RtV08MS2L6hMUkdzApEqH5+y6oaFPg0/1rXpPy6TtCJRPWjuun5jxlJxG/3F6u+
         1f6iaQ7hKUjqV1zkRcLcukaJZpkT7utRyd8MogG8qBMgvazaC7v097Nue1nJA+qJaT
         Se6wZUcEe48Lg==
Date:   Thu, 20 Oct 2022 16:10:28 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [PATCH v3 48/59] x86/retbleed: Add SKL return thunk
Message-ID: <Y1HVZKW4o0KRsMtq@dev-arch.thelio-3990X>
References: <20220915111039.092790446@infradead.org>
 <20220915111147.890071690@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915111147.890071690@infradead.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Thomas,

On Thu, Sep 15, 2022 at 01:11:27PM +0200, Peter Zijlstra wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> To address the Intel SKL RSB underflow issue in software it's required to
> do call depth tracking.
> 
> Provide a return thunk for call depth tracking on Intel SKL CPUs.
> 
> The tracking does not use a counter. It uses uses arithmetic shift
> right on call entry and logical shift left on return.
> 
> The depth tracking variable is initialized to 0x8000.... when the call
> depth is zero. The arithmetic shift right sign extends the MSB and
> saturates after the 12th call. The shift count is 5 so the tracking covers
> 12 nested calls. On return the variable is shifted left logically so it
> becomes zero again.
> 
>  CALL	 	   	RET
>  0: 0x8000000000000000	0x0000000000000000
>  1: 0xfc00000000000000	0xf000000000000000
> ...
> 11: 0xfffffffffffffff8	0xfffffffffffffc00
> 12: 0xffffffffffffffff	0xffffffffffffffe0
> 
> After a return buffer fill the depth is credited 12 calls before the next
> stuffing has to take place.
> 
> There is a inaccuracy for situations like this:
> 
>    10 calls
>     5 returns
>     3 calls
>     4 returns
>     3 calls
>     ....
> 
> The shift count might cause this to be off by one in either direction, but
> there is still a cushion vs. the RSB depth. The algorithm does not claim to
> be perfect, but it should obfuscate the problem enough to make exploitation
> extremly difficult.
> 
> The theory behind this is:
> 
> RSB is a stack with depth 16 which is filled on every call. On the return
> path speculation "pops" entries to speculate down the call chain. Once the
> speculative RSB is empty it switches to other predictors, e.g. the Branch
> History Buffer, which can be mistrained by user space and misguide the
> speculation path to a gadget.
> 
> Call depth tracking is designed to break this speculation path by stuffing
> speculation trap calls into the RSB which are never getting a corresponding
> return executed. This stalls the prediction path until it gets resteered,
> 
> The assumption is that stuffing at the 12th return is sufficient to break
> the speculation before it hits the underflow and the fallback to the other
> predictors. Testing confirms that it works. Johannes, one of the retbleed
> researchers. tried to attack this approach but failed.
> 
> There is obviously no scientific proof that this will withstand future
> research progress, but all we can do right now is to speculate about it.
> 
> The SAR/SHL usage was suggested by Andi Kleen.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This commit is now in -next as commit 5d8213864ade ("x86/retbleed: Add
SKL return thunk"). I just bisected an immediate reboot on my AMD test
system when starting a virtual machine with QEMU + KVM to it (see the
bisect log below). My Intel test systems do not show this.
Unfortunately, I do not have much more information, as there are no logs
in journalctl, which makes sense as the reboot occurs immediately after
I hit the enter key for the QEMU command.

If there is any further information I can provide or patches I can test
for further debugging, I am more than happy to do so.

Cheers,
Nathan

# bad: [acee3e83b493505058d1e48fce167f623dac1a05] Add linux-next specific files for 20221020
# good: [aae703b02f92bde9264366c545e87cec451de471] Merge tag 'for-6.1-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect start 'acee3e83b493505058d1e48fce167f623dac1a05' 'aae703b02f92bde9264366c545e87cec451de471'
# good: [fb28ef66ac24412f3afde4587c66c1ff5396df53] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
git bisect good fb28ef66ac24412f3afde4587c66c1ff5396df53
# bad: [937c5137a567b139c5e598b85501c33e717630cf] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect bad 937c5137a567b139c5e598b85501c33e717630cf
# good: [4f134b9b72eae392d0b76087f66c6f8be0e1777e] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
git bisect good 4f134b9b72eae392d0b76087f66c6f8be0e1777e
# good: [eed519a2892f2cd630d51d0627fc811f021b38c4] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
git bisect good eed519a2892f2cd630d51d0627fc811f021b38c4
# good: [e7d4821209b2e01017d90750c516f3b2ff318825] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git
git bisect good e7d4821209b2e01017d90750c516f3b2ff318825
# bad: [b2e9dfe54be4d023124d588d6f03d16a9c0d2507] x86/bpf: Emit call depth accounting if required
git bisect bad b2e9dfe54be4d023124d588d6f03d16a9c0d2507
# good: [5b71ac8a2a3185da34a6556e791b533b48183a41] x86: Fixup asm-offsets duplicate
git bisect good 5b71ac8a2a3185da34a6556e791b533b48183a41
# good: [fe54d0793796ccdb213d8ea7bff0b49903b6afaa] x86/alternatives: Provide text_poke_copy_locked()
git bisect good fe54d0793796ccdb213d8ea7bff0b49903b6afaa
# bad: [5d8213864ade86b48fc492584ea86d65a62f892e] x86/retbleed: Add SKL return thunk
git bisect bad 5d8213864ade86b48fc492584ea86d65a62f892e
# good: [e81dc127ef69887c72735a3e3868930e2bf313ed] x86/callthunks: Add call patching for call depth tracking
git bisect good e81dc127ef69887c72735a3e3868930e2bf313ed
# good: [770ae1b709528a6a173b5c7b183818ee9b45e376] x86/returnthunk: Allow different return thunks
git bisect good 770ae1b709528a6a173b5c7b183818ee9b45e376
# good: [52354973573cc260ff2fc661cb28ff8eaa7b879b] x86/asm: Provide ALTERNATIVE_3
git bisect good 52354973573cc260ff2fc661cb28ff8eaa7b879b
# first bad commit: [5d8213864ade86b48fc492584ea86d65a62f892e] x86/retbleed: Add SKL return thunk
