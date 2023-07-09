Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434C974C62E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjGIP33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjGIP3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:29:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1DC10EA;
        Sun,  9 Jul 2023 08:27:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6188660B80;
        Sun,  9 Jul 2023 15:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80834C433CA;
        Sun,  9 Jul 2023 15:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688916311;
        bh=5HHcFGMfgVh6g/ZxbVoJjneIyvuj4T99YKbgflCQoDo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c7vUGcYUEn2aJmDsxkRxOVniQVi1ZKR9qHY0mPYX5wWzDAeeiGeiZuTslJ7UB2sud
         SDkwQp5Ir+RQ9Q1iFh20Ebwnq/1AwesBh1hczWFc6z1G1/zwvIa2g/prBCW/ip8t2s
         ZZTGyAXw6k/sj7GhKul1evUy3TEHjtgxJW0Yvbj8U+IcfZjdRKsHL3FXp6fu+KeuYz
         SB7CThDZdBxNHlXLt/nTVxpUPlBm+i0Qpmj6qTg/T4sLUFuOE1lW8ntmZsFpaqzW3n
         ty6Dr7LCU9QGwWJaFDrAmwlU0UuATxB+SNSM3bVOTx3Pm4Do7Oe9Nbcn6NwKceUImr
         pIcar+nkQMisg==
Date:   Mon, 10 Jul 2023 00:25:07 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/retpoline,kprobes: Avoid treating rethunk as an
 indirect jump
Message-Id: <20230710002507.dae543b98d1cc1f950a165bd@kernel.org>
In-Reply-To: <9dabd1fc-7445-a305-6632-04f64e012648@suse.com>
References: <20230705081547.25130-1-petr.pavlu@suse.com>
        <20230705081547.25130-3-petr.pavlu@suse.com>
        <20230705085857.GG462772@hirez.programming.kicks-ass.net>
        <20230705232038.3a6d03e18f7bafb14cdfed42@kernel.org>
        <20230705145017.GC4253@hirez.programming.kicks-ass.net>
        <20230706094723.6934105e03f652923796bf7e@kernel.org>
        <20230706071705.GD2833176@hirez.programming.kicks-ass.net>
        <20230706180014.06705096a594b71250ff3c94@kernel.org>
        <20230706113403.GI2833176@hirez.programming.kicks-ass.net>
        <9dabd1fc-7445-a305-6632-04f64e012648@suse.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2023 16:18:29 +0200
Petr Pavlu <petr.pavlu@suse.com> wrote:

> On 7/6/23 13:34, Peter Zijlstra wrote:
> > On Thu, Jul 06, 2023 at 06:00:14PM +0900, Masami Hiramatsu wrote:
> >> On Thu, 6 Jul 2023 09:17:05 +0200
> >> Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >>> On Thu, Jul 06, 2023 at 09:47:23AM +0900, Masami Hiramatsu wrote:
> >>>
> >>>>>> If I understand correctly, all indirect jump will be replaced with JMP_NOSPEC.
> >>>>>> If you read the insn_jump_into_range, I onlu jecks the jump code, not call.
> >>>>>> So the functions only have indirect call still allow optprobe.
> >>>>>
> >>>>> With the introduction of kCFI JMP_NOSPEC is no longer an equivalent to a
> >>>>> C indirect jump.
> >>>>
> >>>> If I understand correctly, kCFI is enabled by CFI_CLANG, and clang is not
> >>>> using jump-tables by default, so we can focus on gcc. In that case
> >>>> current check still work, correct?
> >>>
> >>> IIRC clang can use jump tables, but like GCC needs RETPOLINE=n and
> >>> IBT=n, so effectively nobody has them.
> >>
> >> So if it requires RETPOLINE=n, current __indirect_thunk_start/end checking
> >> is not required, right? (that code is embraced with "#ifdef CONFIG_RETPOLINE")
> > 
> > Correct.
> 
> Thank you both for the explanation.
> 
> If I understand correctly, it means this second patch can be dropped and
> I can instead replace it with a removal of the mentioned check. That
> will also void the main motivation for the first patch but that one
> should be still at least useful to make the LTO_CLANG=y build lay out
> the code in the same way as with other configurations.

Yes, something like removing __indirect_thunk_start/end check and 
disabling insn_is_indirect_jump() when defined(CONFIG_RETPOLINE) ||
 defined(CONFIG_X86_KERNEL_IBT).

kCFI case is also handled later but another series.

Thank you,

> 
> I will post an updated series with these changes.
> 
> -- Petr
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
