Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2322B720136
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjFBMMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjFBMML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:12:11 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1681AE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 05:12:09 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-970028cfb6cso302407966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 05:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685707928; x=1688299928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nu2Etlmi3Eu2Y0bwV0OBeKuPQ/LYJXZotP8yg4CZLQ=;
        b=UI9NyFOt2IlVLwTd5HCvX5s6aS8D4xFOBMap4XnmopE1iIuEycU7ZcvMwwxL/NnFFC
         SJQLsrE6eMviWxXxTOtDHseP5C03E7c2CYhTxeFVGicNXL9gED26UuUdf6Yi5LuwhKQy
         QIKQvGDa0H1plDlmfHJlMCovLD9qA9gNbBlwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685707928; x=1688299928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nu2Etlmi3Eu2Y0bwV0OBeKuPQ/LYJXZotP8yg4CZLQ=;
        b=lBJev0KdBa4xtAJzKHAaRp0u5mRHqI5MbNLIWaDYeXHOq8Her93suQWUdqZeVtYq7y
         H1nFKTtN0aN0UUEIIPUPMnI43p5/Lpz5OCYbpLcsAVKLwaNcldK+8Wu5AnPyDI+5SzqX
         B7BpRpz6k1ww80aeE8JX73vAGSqlx3bOQvz6jdGEBk2e69K7M+To+eANZsUwqsTmEr/E
         4wMY3/D06dHM7NAhBZ6Qz+4yfk7rFiuq91DOfkUv2f7H8C9fG5lqZPaioI5F/JZTSZge
         ZkjKanZcPSySq2s/jBRBCZs6HTZ2XY35cEkLe8LfjPnmrRgIndjeAzC1Eco5B+t39tu5
         xp3g==
X-Gm-Message-State: AC+VfDxd6BTn8uELSeeG2F7QybGUbLDl7G0Ytccakm6ltFVteaF8tF9U
        u1ZBNn2SbC4pzGFdIiUx++5Gs3aUqFnbKC8Sr50Ca85R
X-Google-Smtp-Source: ACHHUZ6y3QTD0fVY7TEYIFIG9esq598UGBuN+UVwEJyPW/ugq/jgvGFWHjBUw/RsJR+2Lk04rzdbZw==
X-Received: by 2002:a17:907:9816:b0:974:326b:f9b2 with SMTP id ji22-20020a170907981600b00974326bf9b2mr8282333ejc.66.1685707928011;
        Fri, 02 Jun 2023 05:12:08 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id h27-20020a1709062ddb00b00965cfc209d5sm695686eji.8.2023.06.02.05.12.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 05:12:05 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51458187be1so2873123a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 05:12:04 -0700 (PDT)
X-Received: by 2002:a05:6402:2027:b0:514:9934:de96 with SMTP id
 ay7-20020a056402202700b005149934de96mr1647596edb.26.1685707924342; Fri, 02
 Jun 2023 05:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wji_2UwFMkUYkygsYRek05NwaQkH-vA=yKQtQS9Js+urQ@mail.gmail.com>
 <20230524153311.3625329-1-dhowells@redhat.com> <20230524153311.3625329-10-dhowells@redhat.com>
 <20230526180844.73745d78@kernel.org> <499791.1685485603@warthog.procyon.org.uk>
 <CAHk-=wgeixW3cc=Ys8eL0_+22FUhqeEru=nzRrSXy1U4YQdE-w@mail.gmail.com>
 <CAHk-=wghhHghtvU_SzXxAzfaX35BkNs-x91-Vj6+6tnVEhPrZg@mail.gmail.com>
 <832277.1685630048@warthog.procyon.org.uk> <909595.1685639680@warthog.procyon.org.uk>
 <20230601212043.720f85c2@kernel.org> <952877.1685694220@warthog.procyon.org.uk>
 <CAHk-=wjvgL5nyZmpYRWBfab4NKvfQ7NjUvUhE3a3wYTyTEHdfQ@mail.gmail.com> <1227123.1685706296@warthog.procyon.org.uk>
In-Reply-To: <1227123.1685706296@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 08:11:47 -0400
X-Gmail-Original-Message-ID: <CAHk-=wgyAGUMHmQM-5Eb556z5xiHZB7cF05qjrtUH4F7P-1rSA@mail.gmail.com>
Message-ID: <CAHk-=wgyAGUMHmQM-5Eb556z5xiHZB7cF05qjrtUH4F7P-1rSA@mail.gmail.com>
Subject: Re: Bug in short splice to socket?
To:     David Howells <dhowells@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 7:45=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > Do what I already suggested: making SPLICE_F_MORE reflect reality.
>
> I'm trying to.  I need MSG_MORE to behave sensibly for what I want.

But you need to stop doing these random hacks to fs/splice.c

The point is, you *CANNOT* make SPLICE_F_MORE reflect reality by
hacking fs/splice.c. Really. The generic layer DOES NOT KNOW, AND
FUNDAMENTALLY CANNOT KNOW if there is more data to be had.

So any of these random patches that try to add heuristics to
fs/splice.c will be rejected out of hand. They simply cannot be
correct.

And no, on the whole I do not believe you have to maintain some
selftest. A selftest failure is worrisome in that it clearly shows
that some behavior changed, but the situation here is

 (a) the current behavior is arguably bad and buggy

 (b) if we want to fix that bug, then the current behavior *will* change

Now, the only question then is whether the self-test actually tests
anything that user space actually depends on, or if it just tests some
random corner case.

So the self-test is certainly a ref flag, but not necessarily a very
meaningful one.

It shows that some user-visible change happened, which is always a big
danger flag, but after all that was the whole *point* of the whole
exercise.  The fact that the self-test caught the change is good,
because it means we had test coverage, but when the behavior is
something we *want* to change, the test failure is not a problem in
itself.

So what I think you should do is to fix the bug right, with a clean
patch, and no crazy hacks. That is something we can then apply and
test. All the while knowing full well that "uhhuh, this is a visible
change, we may have to revert it".

If then some *real* load ends up showing a regression, we may just be
screwed. Our current behavior may be buggy, but we have the rule that
once user space depends on kernel bugs, they become features pretty
much by definition, however much we might dislike it.

At that point, we'll have to see what we can do - if anything.

Basically, what I think the SPLICE_F_MORE rules *should* be (and hey,
I may be missing something) is

 1) if the user set that bit in the flags, then it's always true.

    The user basically told us "I will supply more data even after the
splice has finished", so it doesn't matter if the kernel runs out of
data in the middle.

 2) if the splice read side sees "I was asked for N bytes, but I could
only supply X bytes and I still have more to give", when we should set
SPLICE_F_MORE internally ("temporarily") for the next splice call.

    This is basically the "kernel independently knows that there will
be more data" case.

 3) In the end, this is all "best effort" and to some degree
inevitably a heuristic. We cannot see the future. We may hit that case
#2 and set the "there will be more data" bit, but then get a signal
and finish the splice system call before that more data actually
happens.

    Now, presumably the user will then continue the partial splice
after handling the signal, so (3) is still "right", but obviously we
can't _know_ that.

A corollary to (3) is that the reader side may not always know if
there will be more data to be read. For a file source, it's fairly
clear (modulo the obvious caveats - files can be truncated etc etc).
For other splice sources, the "I still have more to give" may not be
as unambiguous.  It is what it is.

Am I missing some important case? Considering that we clearly do *not*
do a great job at  SPLICE_F_MORE right now, I'd really want the
situation to be either that we just make the code "ClearlyCorrect(tm)"
and simple, or we just leave it alone as "that's our odd behavior,
deal with it".

None of this "let's change this all to be even more complex, and
handle some particular special case the way I want" crap.

Do it right, or don't do it at all.

             Linus
