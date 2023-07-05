Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211A07485E0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjGEOU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjGEOUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:20:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05881CF;
        Wed,  5 Jul 2023 07:20:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95042615A6;
        Wed,  5 Jul 2023 14:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752BBC433C7;
        Wed,  5 Jul 2023 14:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688566845;
        bh=z/CWJ9bb+yjQolWWLOC4JS5f8lXSCPfPpbPQ2Xusczw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fYyYlYX+ZurP+YqyF3nn8q/OALGRjoa/2YbS0Ya0oyx2qNLvupJ9zrJhwsGH4xwD6
         xavynTTYB/Ye4ptn8ajOPB7CItdKdx+gQF145LaxWDuceF+ezFun8iC+anudzrRLNx
         B5WGYNJZ4s/WOo9NcwmDk7vkLOIYmgtkwkGCvDtcQUnG++/fKMlA+E1egMWPjoSet1
         Ig31CopoGO+b/KNyBlRe9VJ0WM0hFB2OJ8F519nXFHtwIUcepNTexkcxwH7XqvOWFy
         Nk14jAxvu1YYbdDFQ3P+pKu3lDzNpWAp9DY+0WUtmbO4gTyp3Bf6Cnbs/dXJxTvBxR
         26lkyE2SfbJ2w==
Date:   Wed, 5 Jul 2023 23:20:38 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mhiramat@kernel.org, samitolvanen@google.com,
        x86@kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/retpoline,kprobes: Avoid treating rethunk as an
 indirect jump
Message-Id: <20230705232038.3a6d03e18f7bafb14cdfed42@kernel.org>
In-Reply-To: <20230705085857.GG462772@hirez.programming.kicks-ass.net>
References: <20230705081547.25130-1-petr.pavlu@suse.com>
        <20230705081547.25130-3-petr.pavlu@suse.com>
        <20230705085857.GG462772@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 10:58:57 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Jul 05, 2023 at 10:15:47AM +0200, Petr Pavlu wrote:
> > Functions can_optimize() and insn_is_indirect_jump() consider jumps to
> > the range [__indirect_thunk_start, __indirect_thunk_end] as indirect
> > jumps and prevent use of optprobes in functions containing them.
> 
> Why ?!? I mean, doing an opt-probe of an indirect jump/call instruction
> itself doesn't really make sense and I can see why you'd want to not do
> that. But why disallow an opt-probe if there's one in the function as a
> whole, but not the probe target?

Here we need to clarify the reason why functions which have indirect jumps
are not allowed to use opt-probe. Since optprobe can replace multiple 
instructions with a jump, if any jmp (is used for jump inside same function)
jumps to the second and subsequent instructions replaced by optprobe's jump,
that target instruction can not be optimized.

The problem of indirect jump (which jumps to the same function) is that
we don't know which addresses will be the target of the indirect jump.
So, for safety, I disallow optprobe for such function. In that case, normal
kprobe is used because it replaces only one instruction.

If I understand correctly, all indirect jump will be replaced with JMP_NOSPEC.
If you read the insn_jump_into_range, I onlu jecks the jump code, not call.
So the functions only have indirect call still allow optprobe.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
