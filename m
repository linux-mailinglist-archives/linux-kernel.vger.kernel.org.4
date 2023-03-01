Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1C46A70B4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCAQTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAQS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:18:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85540302BE;
        Wed,  1 Mar 2023 08:18:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09C2EB810A7;
        Wed,  1 Mar 2023 16:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E432CC433EF;
        Wed,  1 Mar 2023 16:18:53 +0000 (UTC)
Date:   Wed, 1 Mar 2023 11:18:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 3/3] ring_buffer: Use try_cmpxchg instead of cmpxchg
Message-ID: <20230301111850.768f8526@gandalf.local.home>
In-Reply-To: <CAFULd4aGx=kGYYUz0BkFJz3abz97WOwDEgFHAOocT8SWT2oX-Q@mail.gmail.com>
References: <20230228175929.7534-1-ubizjak@gmail.com>
        <20230228175929.7534-4-ubizjak@gmail.com>
        <20230228164346.0691bb11@gandalf.local.home>
        <CAFULd4aGx=kGYYUz0BkFJz3abz97WOwDEgFHAOocT8SWT2oX-Q@mail.gmail.com>
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

On Wed, 1 Mar 2023 10:37:28 +0100
Uros Bizjak <ubizjak@gmail.com> wrote:

> > No, val should not be updated.  
> 
> Please see the definition of try_cmpxchg. The definition is written in
> such a way that benefits loops as well as linear code and in the later
> case depends on the compiler to eliminate assignment to val as a dead
> assignment.

I did read it ;-)

> 
> The above change was done under the assumption that val is unused
> after try_cmpxchg, and can be considered as a temporary
> [Alternatively, the value could be copied to a local temporary and a
> pointer to this local temporary could be passed to try_cmpxchg
> instead. Compiler is smart enough to eliminate the assignment in any
> case.]
> 
> Even in the linear code, the change has considerable effect.
> rb_head_page_replace is inlined in rb_get_reader_page and gcc-10.3.1
> improves code from:
> 
>      ef8:    48 8b 0e                 mov    (%rsi),%rcx
>      efb:    48 83 e1 fc              and    $0xfffffffffffffffc,%rcx
>      eff:    48 83 c9 01              or     $0x1,%rcx
>      f03:    48 89 c8                 mov    %rcx,%rax
>      f06:    f0 48 0f b1 3e           lock cmpxchg %rdi,(%rsi)
>      f0b:    48 39 c1                 cmp    %rax,%rcx
>      f0e:    74 3b                    je     f4b <rb_get_reader_page+0x13b>
> 
> to:
> 
>      ed8:    48 8b 01                 mov    (%rcx),%rax
>      edb:    48 83 e0 fc              and    $0xfffffffffffffffc,%rax
>      edf:    48 83 c8 01              or     $0x1,%rax
>      ee3:    f0 48 0f b1 31           lock cmpxchg %rsi,(%rcx)
>      ee8:    74 3b                    je     f25 <rb_get_reader_page+0x135>

I'm using gcc 12.2.0 and have this;

cmpxchg:

0000000000000e50 <rb_get_reader_page>:
     e50:       41 55                   push   %r13
     e52:       41 54                   push   %r12
     e54:       55                      push   %rbp
     e55:       53                      push   %rbx
     e56:       48 89 fb                mov    %rdi,%rbx
     e59:       9c                      pushf
     e5a:       5d                      pop    %rbp
     e5b:       fa                      cli
     e5c:       81 e5 00 02 00 00       and    $0x200,%ebp
     e62:       0f 85 e6 01 00 00       jne    104e <rb_get_reader_page+0x1fe>
     e68:       48 8d 7b 1c             lea    0x1c(%rbx),%rdi
     e6c:       31 c0                   xor    %eax,%eax
     e6e:       ba 01 00 00 00          mov    $0x1,%edx
     e73:       f0 0f b1 53 1c          lock cmpxchg %edx,0x1c(%rbx)
     e78:       0f 85 e5 01 00 00       jne    1063 <rb_get_reader_page+0x213>
     e7e:       41 bc 03 00 00 00       mov    $0x3,%r12d
     e84:       4c 8b 6b 58             mov    0x58(%rbx),%r13
     e88:       49 8b 55 30             mov    0x30(%r13),%rdx
     e8c:       41 8b 45 18             mov    0x18(%r13),%eax
     e90:       48 8b 4a 08             mov    0x8(%rdx),%rcx
     e94:       39 c8                   cmp    %ecx,%eax
     e96:       0f 82 61 01 00 00       jb     ffd <rb_get_reader_page+0x1ad>
     e9c:       48 8b 52 08             mov    0x8(%rdx),%rdx


try_cmpxchg:

0000000000000e70 <rb_get_reader_page>:
     e70:       41 55                   push   %r13
     e72:       41 54                   push   %r12
     e74:       55                      push   %rbp
     e75:       53                      push   %rbx
     e76:       48 89 fb                mov    %rdi,%rbx
     e79:       9c                      pushf
     e7a:       5d                      pop    %rbp
     e7b:       fa                      cli
     e7c:       81 e5 00 02 00 00       and    $0x200,%ebp
     e82:       0f 85 e0 01 00 00       jne    1068 <rb_get_reader_page+0x1f8>
     e88:       48 8d 7b 1c             lea    0x1c(%rbx),%rdi
     e8c:       31 c0                   xor    %eax,%eax
     e8e:       ba 01 00 00 00          mov    $0x1,%edx
     e93:       f0 0f b1 53 1c          lock cmpxchg %edx,0x1c(%rbx)
     e98:       0f 85 df 01 00 00       jne    107d <rb_get_reader_page+0x20d>
     e9e:       41 bc 03 00 00 00       mov    $0x3,%r12d
     ea4:       4c 8b 6b 58             mov    0x58(%rbx),%r13
     ea8:       49 8b 55 30             mov    0x30(%r13),%rdx
     eac:       41 8b 45 18             mov    0x18(%r13),%eax
     eb0:       48 8b 4a 08             mov    0x8(%rdx),%rcx
     eb4:       39 c8                   cmp    %ecx,%eax
     eb6:       0f 82 5b 01 00 00       jb     1017 <rb_get_reader_page+0x1a7>
     ebc:       48 8b 52 08             mov    0x8(%rdx),%rdx

Which has no difference :-/


> 
> Again, even in linear code the change is able to eliminate the
> assignment to a temporary reg and the compare. Please note that there
> is no move *from* %rax register after cmpxchg, so the compiler
> correctly eliminated unused assignment.
> 
> >  
> > >  }
> > >
> > >  /*
> > > @@ -2055,7 +2052,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
> > >       retries = 10;
> > >       success = false;
> > >       while (retries--) {
> > > -             struct list_head *head_page, *prev_page, *r;
> > > +             struct list_head *head_page, *prev_page;
> > >               struct list_head *last_page, *first_page;
> > >               struct list_head *head_page_with_bit;
> > >
> > > @@ -2073,9 +2070,8 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
> > >               last_page->next = head_page_with_bit;
> > >               first_page->prev = prev_page;
> > >
> > > -             r = cmpxchg(&prev_page->next, head_page_with_bit, first_page);
> > > -
> > > -             if (r == head_page_with_bit) {
> > > +             if (try_cmpxchg(&prev_page->next,
> > > +                             &head_page_with_bit, first_page)) {  
> >
> > No. head_page_with_bit should not be updated.  
> 
> As above, head_page_with_bit should be considered as a temporary, it
> is initialized a couple of lines above cmpxchg and unused after. The
> gcc-10.3.1 compiler even found some more optimization opportunities
> and reordered the code from:
> 
>     1364:    4d 8b 86 38 01 00 00     mov    0x138(%r14),%r8
>     136b:    48 83 ce 01              or     $0x1,%rsi
>     136f:    48 89 f0                 mov    %rsi,%rax
>     1372:    49 89 30                 mov    %rsi,(%r8)
>     1375:    48 89 4f 08              mov    %rcx,0x8(%rdi)
>     1379:    f0 48 0f b1 39           lock cmpxchg %rdi,(%rcx)
>     137e:    48 39 c6                 cmp    %rax,%rsi
>     1381:    74 78                    je     13fb <rb_insert_pages+0xdb>
> 
> to:
> 
>     1343:    48 83 c8 01              or     $0x1,%rax
>     1347:    48 8b bb 38 01 00 00     mov    0x138(%rbx),%rdi
>     134e:    48 89 07                 mov    %rax,(%rdi)
>     1351:    48 89 4e 08              mov    %rcx,0x8(%rsi)
>     1355:    f0 48 0f b1 31           lock cmpxchg %rsi,(%rcx)
>     135a:    41 0f 94 c7              sete   %r15b
>     135e:    75 2f                    jne    138f <rb_insert_pages+0x8f>
> 
> Please also note SETE insn in the above code, this is how the
> "success" variable is handled in the loop. So, besides code size
> improvement, other secondary improvements can be expected from the
> change, too.

For this gcc 12.2.0 did have a different result:

cmpxchg:

    1436:       49 89 c5                mov    %rax,%r13
    1439:       eb 41                   jmp    147c <rb_update_pages+0x7c>
    143b:       48 89 df                mov    %rbx,%rdi
    143e:       e8 bd ed ff ff          call   200 <rb_set_head_page>
    1443:       48 89 c2                mov    %rax,%rdx
    1446:       48 85 c0                test   %rax,%rax
    1449:       74 37                   je     1482 <rb_update_pages+0x82>
    144b:       48 8b 48 08             mov    0x8(%rax),%rcx
    144f:       48 8b bb 30 01 00 00    mov    0x130(%rbx),%rdi
    1456:       48 89 c6                mov    %rax,%rsi
    1459:       4c 8b 83 38 01 00 00    mov    0x138(%rbx),%r8
    1460:       48 83 ce 01             or     $0x1,%rsi
    1464:       48 89 f0                mov    %rsi,%rax
    1467:       49 89 30                mov    %rsi,(%r8)
    146a:       48 89 4f 08             mov    %rcx,0x8(%rdi)
    146e:       f0 48 0f b1 39          lock cmpxchg %rdi,(%rcx)
    1473:       48 39 c6                cmp    %rax,%rsi
    1476:       0f 84 97 01 00 00       je     1613 <rb_update_pages+0x213>
    147c:       41 83 ee 01             sub    $0x1,%r14d
    1480:       75 b9                   jne    143b <rb_update_pages+0x3b>
    1482:       48 8b 43 10             mov    0x10(%rbx),%rax
    1486:       f0 ff 40 08             lock incl 0x8(%rax)

try_cmpxchg:

    1446:       49 89 c4                mov    %rax,%r12
    1449:       41 83 ee 01             sub    $0x1,%r14d
    144d:       0f 84 7b 01 00 00       je     15ce <rb_update_pages+0x1be>
    1453:       48 89 df                mov    %rbx,%rdi
    1456:       e8 c5 ed ff ff          call   220 <rb_set_head_page>
    145b:       48 89 c2                mov    %rax,%rdx
    145e:       48 85 c0                test   %rax,%rax
    1461:       0f 84 67 01 00 00       je     15ce <rb_update_pages+0x1be>
    1467:       48 8b 48 08             mov    0x8(%rax),%rcx
    146b:       48 8b b3 30 01 00 00    mov    0x130(%rbx),%rsi
    1472:       48 83 c8 01             or     $0x1,%rax
    1476:       48 8b bb 38 01 00 00    mov    0x138(%rbx),%rdi
    147d:       48 89 07                mov    %rax,(%rdi)
    1480:       48 89 4e 08             mov    %rcx,0x8(%rsi)
    1484:       f0 48 0f b1 31          lock cmpxchg %rsi,(%rcx)
    1489:       75 be                   jne    1449 <rb_update_pages+0x39>
    148b:       48 89 7a 08             mov    %rdi,0x8(%rdx)
    148f:       4c 89 e6                mov    %r12,%rsi
    1492:       48 89 ef                mov    %rbp,%rdi
    1495:       4c 89 ab 30 01 00 00    mov    %r13,0x130(%rbx)
    149c:       4c 89 ab 38 01 00 00    mov    %r13,0x138(%rbx)
    14a3:       e8 00 00 00 00          call   14a8 <rb_update_pages+0x98>

It's different, but I'm not so sure it's beneficial.

> 
> I think that the above examples demonstrate various improvements that
> can be achieved with effectively a one-line, almost mechanical change
> to the code, even in linear code. It would be unfortunate to not
> consider them.

But with gcc 12.2.0 I don't really see the benefit. And I'm worried that
the side effect of modifying the old variable could cause a bug in the
future, if it is used after the try_cmpxchg(). At least for the second case.

-- Steve

