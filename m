Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D99742C07
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjF2SnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjF2SnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:43:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD26F2681
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:43:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51d9bf5411aso1087097a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688064182; x=1690656182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mmhtpqqkJ1KWVH50RxZoMJvMId6WkP/xoN83CJAGivM=;
        b=HMvzagF0myuZ+UEdT1gsNRXhKxGSBimD2rqEuTr2VRNZ9qRno9HbCh6BzpHJy28qbH
         KluJwSPOl8jfxmmq1Qp/P0x58Sv9de2mRH4oS1qbqFLdwHyaar456CsbLQUT10Goc3Bo
         cMJfyTsXV3cekEN8+x/aSW6zoSGGaAr3oceeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688064182; x=1690656182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmhtpqqkJ1KWVH50RxZoMJvMId6WkP/xoN83CJAGivM=;
        b=YE+QWbW3jzABqI0Cf+rSoMrqC0cLxhJpVuL1yN0J3hShdqUwR3FxXQvKJmlKso0QUZ
         7ZRQj3rMYVxUmCd/4ayj6xF+6JVkXrFyd7Q88N9Cr3iODa7a6HLaCnhqYLpUML/aJKMr
         dgoqvBqpKZeVaUQbtRVcPc0jOPpP07RQRdR2HWBmN6hpbz55H9+Y/Vp/SCkHxsTwuTaQ
         LihY8XFkwwbVgyNvRj3aQvSBON5Fy6wg5pu4aCLImj+PFuDQjWhiGbKdX3iIEqbbo9ci
         NR9OjHeWjV6mx9cYH/4fvQCQnNbZeL0hXDmq0HBzyRtiHoKHPAoFiZ15e7tg8xztpoZh
         /xjw==
X-Gm-Message-State: ABy/qLY0Jgn1FMcMqt762q5uuj2ZQ2rQU1q/ngx/O1+lUFLAHunmM6gP
        SJuFoFlm+7q1ly57qO42yfHMRoi4vkzNyOKHNlDTM1VY
X-Google-Smtp-Source: APBJJlHCQz2SHdUgzlWiZ3EObnb9OUc9Rh2zdWtMyYCL+7ydQN9D3wikThg04BNXgXLP3IXCh3eheg==
X-Received: by 2002:a05:6402:50b:b0:51d:e421:cdd1 with SMTP id m11-20020a056402050b00b0051de421cdd1mr83887edv.18.1688064181985;
        Thu, 29 Jun 2023 11:43:01 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id o7-20020aa7dd47000000b0051bf57aa0c6sm6053629edw.87.2023.06.29.11.43.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 11:43:01 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51d9bf5411aso1087070a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:43:01 -0700 (PDT)
X-Received: by 2002:aa7:c690:0:b0:51d:9693:5124 with SMTP id
 n16-20020aa7c690000000b0051d96935124mr81608edq.19.1688064180790; Thu, 29 Jun
 2023 11:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com> <CAHk-=wiDwfyj0CCupT-oEToqsNLcbsTQdcgDupF=ZETUjJQJtQ@mail.gmail.com>
 <4bd92932-c9d2-4cc8-b730-24c749087e39@mattwhitlock.name> <CAHk-=whYWEUU69nY6k4j1_EQnQDNPy4TqAMvpf1UA111UDdmYg@mail.gmail.com>
In-Reply-To: <CAHk-=whYWEUU69nY6k4j1_EQnQDNPy4TqAMvpf1UA111UDdmYg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 11:42:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgG_2cmHgZwKjydi7=iimyHyN8aessnbM9XQ9ufbaUz9g@mail.gmail.com>
Message-ID: <CAHk-=wgG_2cmHgZwKjydi7=iimyHyN8aessnbM9XQ9ufbaUz9g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] splice: Fix corruption in data spliced to pipe
To:     Matt Whitlock <kernel@mattwhitlock.name>
Cc:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 at 11:19, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, we also have SPLICE_F_GIFT. [..]
>
> Now, I would actually not disagree with removing that part. It's
> scary. But I think we don't really have any users (ok, fuse and some
> random console driver?)

Side note: maybe I should clarify. I have grown to pretty much hate
splice() over the years, just because it's been a constant source of
sorrow in so many ways.

So I'd personally be perfectly ok with just making vmsplice() be
exactly the same as write, and turn all of vmsplice() into just "it's
a read() if the pipe is open for read, and a write if it's open for
writing".

IOW, effectively get rid of vmsplice() entirely, just leaving it as a
legacy name for an interface.

What I *absolutely* don't want to see is to make vmsplice() even more
complicated, and actively slower in the process. Unmapping it from the
source, removing it from the VM, is all just crazy talk.

If you want to be really crazy, I can tell you how to make for some
truly stupendously great benchmarks: make a plain "write()" system
call look up the physical page, check if it's COW'able, and if so,
mark it read-only in the source and steal the page. Now write() has
taken a snapshot of the source, and can use that page for the pipe
buffer as-is. It won't change, because if the user writes to it, the
user will just take a page fault and force a COW.

Then, to complete the thing, make 'read()' of a pipe able to just take
the page, and insert it into the destination VM (it's ok to make it
writable at that point).

You can get *wonderful* performance numbers from benchmarks with that.

I know, because I did exactly that long long ago. So long ago that I
think I had a i486 that had memory throughput measured in megabytes.
And my pipe throughput benchmark got gigabytes per second!

Of course, that benchmark relied entirely on the source of the write()
never actually writing to the page, and the reader never actually
bothering to touch the page. So it was gigabytes on a pretty bad
benchmark. But it was quite impressive.

I don't think those patches ever got posted publicly, because while
very impressive on benchmarks, it obviously was absolutely horrendous
in real life, because in real life the source of the pipe data would
(a) not usually be page-aligned anyway, and (b) even if it was and
triggered this wonderful case, it would then re-use the buffer and
take a COW fault, and now the overhead of faulting, allocating a new
page, copying said page, was obviously higher than just doing all that
in the pipe write() code without any faulting overhead.

But splice() (and vmsplice()) does conceptually come from that kind of
background.

It's just that it was never as lovely and as useful as it promised to
be. So I'd actually be more than happy to just say "let's decommission
splice entirely, just keeping the interfaces alive for backwards
compatibility"

                     Linus
