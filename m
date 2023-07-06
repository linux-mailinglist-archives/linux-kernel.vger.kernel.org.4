Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993217497D4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjGFJAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGFJAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:00:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5031A1BC8;
        Thu,  6 Jul 2023 02:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB165618CB;
        Thu,  6 Jul 2023 09:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1132DC433C7;
        Thu,  6 Jul 2023 09:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688634018;
        bh=kUhi5w1JB2IJs4oDFUOm+9QXAiYHR4Uf/ijhCdJFvfQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jQ/F1QlXtsreGV/oJu2cGL/Xln/At0TcYnAd7nPR9SNSr/y39AqZicf4eJJui0j22
         7IM+cM/XiQjOZ87wKh+HlUbqAgK6e4qMRRsVaGvlZ1DrHZLHwwDgKx+lAuX6Zn76LZ
         D4YhqcAo8Vv69FGRRsZELYkGZqbAkF39ziHJSgx4ts+Gpw1NoSH/+1MgP6DDETl79r
         cY7JnVt7p5DunRUPPPcmaLmV1LtYuDGZr6aPOFPUPxVMRbL4IuEe2Dr5ptelFYR5CJ
         NY+1wzfvP820rsv4gp6TRGnhrHUPaIWYoSoGxpRCkXW1u/TDx54xBnA5YHlHSClwiW
         PQxpan39yZwJg==
Date:   Thu, 6 Jul 2023 18:00:14 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/retpoline,kprobes: Avoid treating rethunk as an
 indirect jump
Message-Id: <20230706180014.06705096a594b71250ff3c94@kernel.org>
In-Reply-To: <20230706071705.GD2833176@hirez.programming.kicks-ass.net>
References: <20230705081547.25130-1-petr.pavlu@suse.com>
        <20230705081547.25130-3-petr.pavlu@suse.com>
        <20230705085857.GG462772@hirez.programming.kicks-ass.net>
        <20230705232038.3a6d03e18f7bafb14cdfed42@kernel.org>
        <20230705145017.GC4253@hirez.programming.kicks-ass.net>
        <20230706094723.6934105e03f652923796bf7e@kernel.org>
        <20230706071705.GD2833176@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Thu, 6 Jul 2023 09:17:05 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jul 06, 2023 at 09:47:23AM +0900, Masami Hiramatsu wrote:
> 
> > > > If I understand correctly, all indirect jump will be replaced with JMP_NOSPEC.
> > > > If you read the insn_jump_into_range, I onlu jecks the jump code, not call.
> > > > So the functions only have indirect call still allow optprobe.
> > > 
> > > With the introduction of kCFI JMP_NOSPEC is no longer an equivalent to a
> > > C indirect jump.
> > 
> > If I understand correctly, kCFI is enabled by CFI_CLANG, and clang is not
> > using jump-tables by default, so we can focus on gcc. In that case
> > current check still work, correct?
> 
> IIRC clang can use jump tables, but like GCC needs RETPOLINE=n and
> IBT=n, so effectively nobody has them.

So if it requires RETPOLINE=n, current __indirect_thunk_start/end checking
is not required, right? (that code is embraced with "#ifdef CONFIG_RETPOLINE")

> 
> The reason I did mention kCFI though is that kCFI has a larger 'indirect
> jump' sequence, and I'm not sure we've thought about what can go
> sideways if that's optprobed.

If I understand correctly, kCFI checks only indirect function call (check
pointer), so no jump tables. Or does it use indirect 'jump' ?

> 
> I suspect the UD2 that's in there will go 'funny' if it's relocated into
> an optprobe, as in, it'll not be recognised as a CFI fail.

UD2 can't be optprobed (kprobe neither) because it can change the dumped
BUG address...

Thank you,
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
