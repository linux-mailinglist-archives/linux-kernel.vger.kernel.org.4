Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4741260BBCD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiJXVN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiJXVMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:12:47 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0928F2D03A5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:18:40 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z68so1209406iof.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JPXvJb7GM+EHT+c3gsLfQRJKZWgvJXw12WJBYs2S1q8=;
        b=CAjawo8azvzPmnkWrwJTTXW5g/UuHoVhHiq5Y3Vc7LEng9ODKRzlUBrL5yB85Pj0qE
         /rXxwUjjSLZIcVE1SmLUcc88psmI4Zn/xy/7DUmlcFoiqcqChvokQ9MA1DGXkyroDyp6
         lBPNylmVj5VOQP44th9cQHic55MZMk9x/q/NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPXvJb7GM+EHT+c3gsLfQRJKZWgvJXw12WJBYs2S1q8=;
        b=kdY5afChTCmwgqGyLidE3u/kxhvNKLffI2QKwq/zqtAL+hVWn0FiWRQG8hKULv7Zb6
         5mt+W1aX2A+S9g76O64Gqqq1K8Noy6UzGdjZ3ncY23Vm0FOaaulFMzjpQOhldB3IhAjt
         Ojn32w3VJPeX42wgfkxcEOvrB3uu+xbq6PxAgVGIwkTmmy8b/qDg7fsyec5cyNoEv7qZ
         jRGb1muUCiU6ksc1ciXwiKSkzpCouv2WsTp98yRmonVE1NnzfhR8SqO++iAPMmyoGj/I
         YTqD4YWUenahA3u1nF01YS35fOL7zW5JDoWucC7uYomrIJc+aQAZzpkjbR6Yib47pKOs
         AmbQ==
X-Gm-Message-State: ACrzQf2kB706t+L1sJWuMO/HkSP/CSSfYBG0kYMmlwo1XyKdLTz05DY4
        QH+VNKRPEBjzCz5zl2rPeYmEUNVt+E15Nw==
X-Google-Smtp-Source: AMsMyM5+qWlErG9gLXSEJM9RafnJsLpFGFJwX8WbFJLuimJ6Ifj3JinvyBHeTjYt0sQe9poYT86/Uw==
X-Received: by 2002:a05:620a:2888:b0:6cf:5798:9a2d with SMTP id j8-20020a05620a288800b006cf57989a2dmr24128806qkp.508.1666638546505;
        Mon, 24 Oct 2022 12:09:06 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id g21-20020a05620a40d500b006ee8874f5fasm514337qko.53.2022.10.24.12.09.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 12:09:05 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id n130so12050353yba.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:09:05 -0700 (PDT)
X-Received: by 2002:a25:bb44:0:b0:6bb:a336:7762 with SMTP id
 b4-20020a25bb44000000b006bba3367762mr29317736ybk.501.1666638545295; Mon, 24
 Oct 2022 12:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221024114536.44686c83@gandalf.local.home> <CAHk-=wj9xBsbeoiFCBLrr3y_CdMOzNh=fD3rr_kcxYwL6vV0Jw@mail.gmail.com>
 <20221024145250.08cfc147@gandalf.local.home>
In-Reply-To: <20221024145250.08cfc147@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 12:08:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRpCS3oAJHVfByDoaj0-tAhV5a5YKV7QssUdMOAm8bAg@mail.gmail.com>
Message-ID: <CAHk-=wjRpCS3oAJHVfByDoaj0-tAhV5a5YKV7QssUdMOAm8bAg@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Do not verify W^X at boot up
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 11:52 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> It's not just speed up at boot up. It's because text_poke doesn't work at
> early boot up when function tracing is enabled. If I remove the
> SYSTEM_BOOTING checks in text_poke() this happens:

Let's just fix that up.

>
> [    1.013753] BUG: kernel NULL pointer dereference, address: 0000000000000048

This is due to

__get_locked_pte:
   0: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
   5: 48 89 f0              mov    %rsi,%rax
   8: 41 55                push   %r13
   a: 48 c1 e8 24          shr    $0x24,%rax
   e: 41 54                push   %r12
  10: 25 f8 0f 00 00        and    $0xff8,%eax
  15: 55                    push   %rbp
  16: 53                    push   %rbx
  17:* 48 03 47 48          add    0x48(%rdi),%rax <-- trapping instruction
  1b: 0f 84 c4 00 00 00    je     0xe5
  21: 49 89 fc              mov    %rdi,%r12
  24: 48 8b 38              mov    (%rax),%rdi
  27: 48 89 f3              mov    %rsi,%rbx
  2a: 48 89 c5              mov    %rax,%rbp

and that 'addq' seems to be walk_to_pmd() doing

        pgd = pgd_offset(mm, addr);

with a zero mm (that's 'mm->pgd').

And that, in turn, seems to be due to the absolutely disgusing 'poking_mm' hack.

> Interrupts haven't been enabled yet, so things are still rather fragile at
> this point of start up.

I don't think this has anything to do with interrupts. We do need the
page structures etc to be workable, but all the tracing setup needs
that *anyway*.

I suspect it would be fixed by just moving 'poking_init()' earlier. In
many ways I suspect it would make most sense as part of 'mm_init()',
not as a random call fairly late in start_kernel().

In other words, this all smells like "people added special cases
because they didn't want to hunt down the underlying problem".

And then all these special cases beget other special cases.

                 Linus
