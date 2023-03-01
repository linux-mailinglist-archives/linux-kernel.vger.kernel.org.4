Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B426C6A69E2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCAJhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAJhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:37:43 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F9F36FE3;
        Wed,  1 Mar 2023 01:37:41 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-53852143afcso351138407b3.3;
        Wed, 01 Mar 2023 01:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677663460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ix2cTJ5poXO6sf2WHrZdG809NIHDssM/Y5iE6G3Gwn8=;
        b=HQXZQ2KMPLABE6R6K1ZM/JtqrU9TfM9hvUkU+QW08g+Wzz2AEsV3sa0tSJOHnwXRTG
         vQRZlLsf5eOMknXf+laDH8zNw1YgWjuuL4Bj/V2R78evpAH9cAks2ZahUFuneZCniJyo
         nxd5oZ+GvF5U2sh6FILMKBxnyKcvgZ/0qghF0oMCGLNzYoL1E+trS/9xmekonc5wLAhS
         RAhphiL9mGNvDf/lM7jSS4oa2wYPhHS45MI6BpnZjaPWRotT1woTm/q46ej84RoZg4Bp
         pKdcAiN/yYhBBIBIDp0vzmsVzifwcbuW2+KchVf1BOnNqEHWthzf2q+U66zE9llGSxil
         WKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677663460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ix2cTJ5poXO6sf2WHrZdG809NIHDssM/Y5iE6G3Gwn8=;
        b=NxNeBq5TCJ+fQyjIf0CMguDJ8NoK5F/YYUueXj3Dne/8OiHxrBfn6l0HhWlbwoQ9lk
         U0Ob0TxRPjEgAlN7SzMHSHqFTTl7VJNvpkar5OT9vBo9ZPLsfmvFGHViT2xs7/fIjVUJ
         n3UuQftzmNDF3/KCotSnzshqSeYpJzqE8AxMA3c2/2DQUJgQ/m0oylQTvrkRM6JvgruD
         CXfVz+sRkDIPzFFEIkpqN28EExvoDtd6J4lY6RGog5bMFhy3R5gofgH/Q0FLjIdMDvLA
         sGAq4a+3cVzpg47wNkhiEoflZFfncCNQW43Bz4+h4nceRF2Ay9BbEzXyledC8i7AMx6X
         5riA==
X-Gm-Message-State: AO0yUKV65Mhj3927IxaWxBHNG4IaSHpLardF5hs4WVVMR+9OWHlvKPtM
        7puvJ2we784cV93Y4Cx+KZbbo71azOUUQTs0DfmFuClzIT8urMKx
X-Google-Smtp-Source: AK7set8eiJkbWsvTq6/Q499fyAsEuzZ5T6PpGR9MTYsVGiC3Z2njszUyAQHid+zE1fx2aFMlVSJxlxHf3l1k2pXZ6y0=
X-Received: by 2002:a81:b305:0:b0:536:155a:b73d with SMTP id
 r5-20020a81b305000000b00536155ab73dmr3594480ywh.2.1677663460520; Wed, 01 Mar
 2023 01:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20230228175929.7534-1-ubizjak@gmail.com> <20230228175929.7534-4-ubizjak@gmail.com>
 <20230228164346.0691bb11@gandalf.local.home>
In-Reply-To: <20230228164346.0691bb11@gandalf.local.home>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 1 Mar 2023 10:37:28 +0100
Message-ID: <CAFULd4aGx=kGYYUz0BkFJz3abz97WOwDEgFHAOocT8SWT2oX-Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] ring_buffer: Use try_cmpxchg instead of cmpxchg
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 10:43 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 28 Feb 2023 18:59:29 +0100
> Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old.
> > x86 CMPXCHG instruction returns success in ZF flag, so this change
> > saves a compare after cmpxchg (and related move instruction in
> > front of cmpxchg).
> >
> > Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
> > fails. There is no need to re-read the value in the loop.
> >
> > No functional change intended.
>
> As I mentioned in the RCU thread, I have issues with some of the changes
> here.
>
> >
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > ---
> >  kernel/trace/ring_buffer.c | 20 ++++++++------------
> >  1 file changed, 8 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 4188af7d4cfe..8f0ef7d12ddd 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -1493,14 +1493,11 @@ static bool rb_head_page_replace(struct buffer_page *old,
> >  {
> >       unsigned long *ptr = (unsigned long *)&old->list.prev->next;
> >       unsigned long val;
> > -     unsigned long ret;
> >
> >       val = *ptr & ~RB_FLAG_MASK;
> >       val |= RB_PAGE_HEAD;
> >
> > -     ret = cmpxchg(ptr, val, (unsigned long)&new->list);
> > -
> > -     return ret == val;
> > +     return try_cmpxchg(ptr, &val, (unsigned long)&new->list);
>
> No, val should not be updated.

Please see the definition of try_cmpxchg. The definition is written in
such a way that benefits loops as well as linear code and in the later
case depends on the compiler to eliminate assignment to val as a dead
assignment.

The above change was done under the assumption that val is unused
after try_cmpxchg, and can be considered as a temporary
[Alternatively, the value could be copied to a local temporary and a
pointer to this local temporary could be passed to try_cmpxchg
instead. Compiler is smart enough to eliminate the assignment in any
case.]

Even in the linear code, the change has considerable effect.
rb_head_page_replace is inlined in rb_get_reader_page and gcc-10.3.1
improves code from:

     ef8:    48 8b 0e                 mov    (%rsi),%rcx
     efb:    48 83 e1 fc              and    $0xfffffffffffffffc,%rcx
     eff:    48 83 c9 01              or     $0x1,%rcx
     f03:    48 89 c8                 mov    %rcx,%rax
     f06:    f0 48 0f b1 3e           lock cmpxchg %rdi,(%rsi)
     f0b:    48 39 c1                 cmp    %rax,%rcx
     f0e:    74 3b                    je     f4b <rb_get_reader_page+0x13b>

to:

     ed8:    48 8b 01                 mov    (%rcx),%rax
     edb:    48 83 e0 fc              and    $0xfffffffffffffffc,%rax
     edf:    48 83 c8 01              or     $0x1,%rax
     ee3:    f0 48 0f b1 31           lock cmpxchg %rsi,(%rcx)
     ee8:    74 3b                    je     f25 <rb_get_reader_page+0x135>

Again, even in linear code the change is able to eliminate the
assignment to a temporary reg and the compare. Please note that there
is no move *from* %rax register after cmpxchg, so the compiler
correctly eliminated unused assignment.

>
> >  }
> >
> >  /*
> > @@ -2055,7 +2052,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
> >       retries = 10;
> >       success = false;
> >       while (retries--) {
> > -             struct list_head *head_page, *prev_page, *r;
> > +             struct list_head *head_page, *prev_page;
> >               struct list_head *last_page, *first_page;
> >               struct list_head *head_page_with_bit;
> >
> > @@ -2073,9 +2070,8 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
> >               last_page->next = head_page_with_bit;
> >               first_page->prev = prev_page;
> >
> > -             r = cmpxchg(&prev_page->next, head_page_with_bit, first_page);
> > -
> > -             if (r == head_page_with_bit) {
> > +             if (try_cmpxchg(&prev_page->next,
> > +                             &head_page_with_bit, first_page)) {
>
> No. head_page_with_bit should not be updated.

As above, head_page_with_bit should be considered as a temporary, it
is initialized a couple of lines above cmpxchg and unused after. The
gcc-10.3.1 compiler even found some more optimization opportunities
and reordered the code from:

    1364:    4d 8b 86 38 01 00 00     mov    0x138(%r14),%r8
    136b:    48 83 ce 01              or     $0x1,%rsi
    136f:    48 89 f0                 mov    %rsi,%rax
    1372:    49 89 30                 mov    %rsi,(%r8)
    1375:    48 89 4f 08              mov    %rcx,0x8(%rdi)
    1379:    f0 48 0f b1 39           lock cmpxchg %rdi,(%rcx)
    137e:    48 39 c6                 cmp    %rax,%rsi
    1381:    74 78                    je     13fb <rb_insert_pages+0xdb>

to:

    1343:    48 83 c8 01              or     $0x1,%rax
    1347:    48 8b bb 38 01 00 00     mov    0x138(%rbx),%rdi
    134e:    48 89 07                 mov    %rax,(%rdi)
    1351:    48 89 4e 08              mov    %rcx,0x8(%rsi)
    1355:    f0 48 0f b1 31           lock cmpxchg %rsi,(%rcx)
    135a:    41 0f 94 c7              sete   %r15b
    135e:    75 2f                    jne    138f <rb_insert_pages+0x8f>

Please also note SETE insn in the above code, this is how the
"success" variable is handled in the loop. So, besides code size
improvement, other secondary improvements can be expected from the
change, too.

I think that the above examples demonstrate various improvements that
can be achieved with effectively a one-line, almost mechanical change
to the code, even in linear code. It would be unfortunate to not
consider them.

Uros.
