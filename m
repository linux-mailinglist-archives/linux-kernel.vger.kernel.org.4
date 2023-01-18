Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B8C672AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjARVrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjARVrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:47:19 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2411218A83
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:47:19 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 69so205044ybn.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s+vb6zEcZT2dbdq498iVIMckBbJXuDk07zbcxhVQhG4=;
        b=J7yQ/TBKIUB403GWhpiGw3SDLkWVutrAoZ1tPjg5bkTHoPIjrTGh9S68w9IME5UeQo
         1rENdf9HwQjTxNUPOJK/6RiNTH1SFKWcVZEVbIvu4gAO2DBd6IwalBHID5eMcTIJvKwv
         sHr/Y/zu+OfgwSiZwteGWlJK6/EVlc4pQ1gM4L8DkxighAHJi4B/8eAHNWFJ870Dnbrr
         W65l/Nn4SN/T/sD3WdJF+7CoWQJ8AowA5AdPtUTV82/TUaLVXSwBzIaeGlNrytF0d5iZ
         qPIlj6ZykbyGzgHQA/uv1pwNI3x5ULPBbAjhk5g8qK3s6gRU4Mtiyep1NYfjNjheL/2t
         N8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+vb6zEcZT2dbdq498iVIMckBbJXuDk07zbcxhVQhG4=;
        b=aBB/QBhK8IcxsnbuunKrwIahkJ1n9Q1FUhgefoPcRRXBbqaf7c00/B/eaaj7YAPzpr
         OehvJDUVy6VJwtDcLYOCaynFpFLH6VoI4CI2qLUWAzRMXVQOotmTT1WiZo2WiqOeZeaf
         7/KyfR0bniBXTfL5OlF7qDwnxO+2Y5I5rhrB4yAKP0iSmot7PEYbnTBQkqTZp3S2MC5h
         n6uJ9C9ci0ammrlzAcdN6STUspqptMERQF7Wc+f47SWZV3J4M/uVUeC7Z8v545XxbY0P
         1O0E5p9zPylTdJXakLAdWVjCd69/RjlqHCSpeJdvHEaMYgkkHhdo6rIuze/Bwe5+XCDi
         x/NA==
X-Gm-Message-State: AFqh2koWw6ZIjZGAc3ojD0sK9nMMGfWBYtwpmXggw7J3BSjW74fMAOn+
        5EKAe98H5JHuB69EPaL+L7PHm0+m+Ghz6dl1sKUqJbT/Ro8uYQ==
X-Google-Smtp-Source: AMrXdXsIYpS0sUY7CnmUQmY8ze9yWidoK2ZwMnN7tc4FsNxkh0i08Y28VNDm1vyHQQtQoig4x3YLIfj6Ghq7oMs7gl8=
X-Received: by 2002:a25:740b:0:b0:7b6:9dcb:6588 with SMTP id
 p11-20020a25740b000000b007b69dcb6588mr973980ybc.251.1674078438272; Wed, 18
 Jan 2023 13:47:18 -0800 (PST)
MIME-Version: 1.0
References: <20230118150703.4024-1-ubizjak@gmail.com> <20230118131825.c6daea81ea1e2dc6aa014f38@linux-foundation.org>
In-Reply-To: <20230118131825.c6daea81ea1e2dc6aa014f38@linux-foundation.org>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 18 Jan 2023 22:47:06 +0100
Message-ID: <CAFULd4ZQGG+N3f7xDuoiNG1jY128pqaH0F4eLKO+fhvSNAbKfA@mail.gmail.com>
Subject: Re: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
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

On Wed, Jan 18, 2023 at 10:18 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Wed, 18 Jan 2023 16:07:03 +0100 Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> > {set,clear}_bits_ll.  x86 CMPXCHG instruction returns success in ZF
> > flag, so this change saves a compare after cmpxchg (and related move
> > instruction in front of cmpxchg).
> >
> > Also, try_cmpxchg implicitly assigns old *ptr value to "old"
> > when cmpxchg fails.
> >
> > Note that the value from *ptr should be read using READ_ONCE to prevent
> > the compiler from merging, refetching or reordering the read.
> >
> > The patch also declares these two functions inline, to ensure inlining.
>
> But why is that better?  This adds a few hundred bytes more text, which
> has a cost.

Originally, both functions are inlined and the size of an object file
is (gcc version 12.2.1, x86_64):

  text    data     bss     dec     hex filename
  4661     480       0    5141    1415 genalloc-orig.o

When try_cmpxchg is used, gcc chooses to not inline set_bits_ll (its
estimate of code size is not very precise when multi-line assembly is
involved), resulting in:

  text    data     bss     dec     hex filename
  4705     488       0    5193    1449 genalloc-noinline.o

And with an inline added to avoid gcc's quirks:

  text    data     bss     dec     hex filename
  4629     480       0    5109    13f5 genalloc.o

Considering that these two changed functions are used only in
genalloc.o, adding inline qualifier is a win, also when comparing to
the original size.

Uros.
