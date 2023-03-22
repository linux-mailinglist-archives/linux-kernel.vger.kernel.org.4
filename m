Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2476C3F62
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 01:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCVA6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 20:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCVA63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 20:58:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8C44FCF7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 17:58:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5975EB81ACC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A860BC433D2;
        Wed, 22 Mar 2023 00:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679446704;
        bh=toRX1VEKWROf089qGLZl71200WI2q/q0j4TEa7da3VQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pTEH5aZA0xxA8JM+LFq+cPaagnzi4HEJyqbmw6N1PSCpIq5fr05DHdj3Qgd+ilbKc
         DJxjaWTAiYkcCYp22HlrU91LP0wpRp5zUrNt8cuLzInIM/BeW/YzGHd4a5MMHrke4B
         zzkrro1m+q+QdGwKYCRuBNtg0wYi5v52B/SfGumPPkkk/xhxapBi5H+qBKV5K8PaAO
         59xY5/SI4bq7UEd8jgaHC/oWwbvOdiYpWD5hWGB3J7xOiQWSH1hU9+6gqyonfxHZKj
         oZK28m9YRgd1vNATUXcRCIuAdD1KOM7DDjyQM5yr7xXJhfzTMZSl5vsKCvOHVR0yHs
         l2RAf0gfZktmQ==
Date:   Tue, 21 Mar 2023 17:58:21 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] context_tracking: Have ct_state() use
 preempt_disable_notrace()
Message-ID: <20230322005821.oh4pbn4vdf4jrdsh@treble>
References: <20230321204524.44733a13@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230321204524.44733a13@gandalf.local.home>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 08:45:24PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> One of my tests triggered:
> 
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 1 at include/trace/events/preemptirq.h:51 trace_preempt_off+0x7c/0x80
>  Modules linked in:
>  CPU: 0 PID: 1 Comm: init Not tainted 6.3.0-rc3-test-00011-ge11b521a7b69-dirty #31
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
>  RIP: 0010:trace_preempt_off+0x7c/0x80
>  Code: 74 0f 48 8b 78 08 48 89 f2 48 89 de e8 5d f9 ff ff 65 ff 0d 6e d6 ce 68 75 a2 0f 1f 44 00 00 eb 9b e8 28 ea f3 ff 84 c0 75 a5 <0f> 0b eb a1 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
>  RSP: 0000:ffffaf0880013f00 EFLAGS: 00010046
>  RAX: 0000000000000000 RBX: ffffffff97fafe59 RCX: 0000000000000001
>  RDX: 0000000000000000 RSI: ffffffff986f4b71 RDI: ffffffff986fa0dd
>  RBP: ffffffff97fafe59 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>  R13: 0000000000000014 R14: 0000000000000000 R15: 0000000000000000
>  FS:  0000000000000000(0000) GS:ffff8adf7bc00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f125de099c0 CR3: 000000010498a001 CR4: 0000000000170ef0
>  Call Trace:
>   <TASK>
>   irqentry_enter_from_user_mode+0x39/0x80
>   irqentry_enter+0x51/0x60
>   exc_page_fault+0x3d/0x200
>   asm_exc_page_fault+0x26/0x30

I think this was just fixed in -tip today:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=f87d28673b71b35b248231a2086f9404afbb7f28

-- 
Josh
