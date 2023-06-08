Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51397283C1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbjFHPac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjFHPaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:30:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA31172E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:30:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686238226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Doh36h5MvNeJ/Vm/0hQ/IjHXDKu5IT/deKV80kkrhY0=;
        b=2ptY5aFoUBevOA0kxy9LoPR0cumBz3cN12y+jwbc54amsQMZr1dskmhB9VRtBHpEzE7Rwk
        +qybHaW8wnMLsBSy6pGJcvhaXMZ+o7w9tPs07zZahGVC/m1y8seNvY8zf+dCJtRaSoZd8x
        c3ufoXWXhqoc1M40+jUpTW4YljldWeCVo4LVXe+Nxvoi0AvTuZkEP1lEecQP4005uyOFA3
        BYMrqQZNNlmz1roiHXBBOj/rll47VngIDEQGszCDSNqcoHT11qzUJjtzYbGIUjO1cfEqkB
        r2etO9DmbXp9wtb/HeudfaNpRm5bJQpepIgRZHSsExe72EvUQ1Aim3J6RrnyBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686238226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Doh36h5MvNeJ/Vm/0hQ/IjHXDKu5IT/deKV80kkrhY0=;
        b=ZGkpSLRSjsirGy4G9un5OCrho31ufONFrjd4fL0C6/xvsAM82EwA4Mbqg4pdS0oNk6C99b
        kElo6ImchW8SA/Cw==
To:     Jiri Slaby <jslaby@suse.cz>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com
Subject: Re: [PATCH 3/3] x86: Disable running 32bit processes if
 ia32_disabled is passed
In-Reply-To: <4217f682-f0e3-28de-1fb9-634c5df3581a@suse.cz>
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-4-nik.borisov@suse.com> <87legvjxat.ffs@tglx>
 <80f2045b-f276-e127-8e46-87fb6994fb41@suse.com> <87fs73juwa.ffs@tglx>
 <ba15bccd-9580-c20e-ae9c-b8d60f49fa07@suse.com> <87a5xbjpk2.ffs@tglx>
 <875d0ab7-4470-25e2-6c01-72e231aae515@citrix.com> <874jnjj5z2.ffs@tglx>
 <278d7231-ee27-602f-4ba7-45d45d6772b3@citrix.com> <871qimkdft.ffs@tglx>
 <4217f682-f0e3-28de-1fb9-634c5df3581a@suse.cz>
Date:   Thu, 08 Jun 2023 17:30:25 +0200
Message-ID: <87y1kuhsz2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08 2023 at 08:16, Jiri Slaby wrote:
> On 08. 06. 23, 2:25, Thomas Gleixner wrote:
>> I really wish that we could disable syscall32 reliably on AMD and make
>> it raise #UD as it does on Intal.
>
> Sorry, I am likely missing something, but why is not #GP enough when we 
> set CSTAR = 0?

Because you are not getting a #GP.

It will try to execute from virtual address 0 in CPL 0 and with RSP
still pointing to the user space stack. So you have several
possibilities:

1) 0 is mapped in user space and SMEP/SMAP is off.

   Attacker won

2) 0 is not mapped or SMEP is on.

   You get #PF from CPL0 and RSP is still pointing to the user space
   stack. If SMAP is on this results in #DF

   If SMAP is off, kernel uses an attacker controlled stack...

Similar sillies when you set it to a valid kernel address which is not
mapped or lacks X or contains invalid opcode ....

So no. CSTAR _must_ be a valid kernel text address which handles the
32bit syscall. Right now all it does is SYSRETL when IA32_EMULATION is
disabled.

So the only way to handle that is to have proper entry code which
switches to kernel context and then runs "syscall32_kill_myself()" which
kills the process hard and it exits without the chance to attempt a
return to user.

Anything else wont work.

Bah. Was it really necessary to bring this up so I hade to page in the
gory details of this hardware insanity again?

Thanks,

        tglx
