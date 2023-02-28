Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A6B6A60E7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjB1VEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjB1VEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:04:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EC2274AF;
        Tue, 28 Feb 2023 13:04:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19824B80E65;
        Tue, 28 Feb 2023 21:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B073AC433D2;
        Tue, 28 Feb 2023 21:03:25 +0000 (UTC)
Date:   Tue, 28 Feb 2023 16:03:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
Message-ID: <20230228160324.2a7c1012@gandalf.local.home>
In-Reply-To: <Y/5mguXPPqdP3MZF@google.com>
References: <20230228155121.3416-1-ubizjak@gmail.com>
        <Y/5mguXPPqdP3MZF@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 20:39:30 +0000
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Tue, Feb 28, 2023 at 04:51:21PM +0100, Uros Bizjak wrote:
> > Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> > check_cpu_stall.  x86 CMPXCHG instruction returns success in ZF flag, so
> > this change saves a compare after cmpxchg (and related move instruction in
> > front of cmpxchg).  
> 
> In my codegen, I am not seeing mov instruction before the cmp removed, how
> can that be? The rax has to be populated with a mov before cmpxchg right?
> 
> So try_cmpxchg gives: mov, cmpxchg, cmp, jne
> Where as cmpxchg gives: mov, cmpxchg, mov, jne
> 
> So yeah you got rid of compare, but I am not seeing reduction in moves.
> Either way, I think it is an improvement due to dropping cmp so:

Did you get the above backwards?

Anyway, when looking at the conversion of cmpxchg() to try_cmpxchg() that
Uros sent to me for the ring buffer, the code went from:

0000000000000070 <ring_buffer_record_off>:
      70:       48 8d 4f 08             lea    0x8(%rdi),%rcx
      74:       8b 57 08                mov    0x8(%rdi),%edx
      77:       89 d6                   mov    %edx,%esi
      79:       89 d0                   mov    %edx,%eax
      7b:       81 ce 00 00 10 00       or     $0x100000,%esi
      81:       f0 0f b1 31             lock cmpxchg %esi,(%rcx)
      85:       39 d0                   cmp    %edx,%eax
      87:       75 eb                   jne    74 <ring_buffer_record_off+0x4>
      89:       e9 00 00 00 00          jmp    8e <ring_buffer_record_off+0x1e>
                        8a: R_X86_64_PLT32      __x86_return_thunk-0x4
      8e:       66 90                   xchg   %ax,%ax


  To

00000000000001a0 <ring_buffer_record_off>:
     1a0:       8b 47 08                mov    0x8(%rdi),%eax
     1a3:       48 8d 4f 08             lea    0x8(%rdi),%rcx
     1a7:       89 c2                   mov    %eax,%edx
     1a9:       81 ca 00 00 10 00       or     $0x100000,%edx
     1af:       f0 0f b1 57 08          lock cmpxchg %edx,0x8(%rdi)
     1b4:       75 05                   jne    1bb <ring_buffer_record_off+0x1b>
     1b6:       e9 00 00 00 00          jmp    1bb <ring_buffer_record_off+0x1b>
                        1b7: R_X86_64_PLT32     __x86_return_thunk-0x4
     1bb:       89 c2                   mov    %eax,%edx
     1bd:       81 ca 00 00 10 00       or     $0x100000,%edx
     1c3:       f0 0f b1 11             lock cmpxchg %edx,(%rcx)
     1c7:       75 f2                   jne    1bb <ring_buffer_record_off+0x1b>
     1c9:       e9 00 00 00 00          jmp    1ce <ring_buffer_record_off+0x2e>
                        1ca: R_X86_64_PLT32     __x86_return_thunk-0x4
     1ce:       66 90                   xchg   %ax,%ax


It does add a bit more code, but the fast path seems better (where the
cmpxchg succeeds). That would be:

00000000000001a0 <ring_buffer_record_off>:
     1a0:       8b 47 08                mov    0x8(%rdi),%eax
     1a3:       48 8d 4f 08             lea    0x8(%rdi),%rcx
     1a7:       89 c2                   mov    %eax,%edx
     1a9:       81 ca 00 00 10 00       or     $0x100000,%edx
     1af:       f0 0f b1 57 08          lock cmpxchg %edx,0x8(%rdi)
     1b4:       75 05                   jne    1bb <ring_buffer_record_off+0x1b>
     1b6:       e9 00 00 00 00          jmp    1bb <ring_buffer_record_off+0x1b>
                        1b7: R_X86_64_PLT32     __x86_return_thunk-0x4


Where there's only two moves and no cmp, where the former has 3 moves and a
cmp in the fast path.

-- Steve
