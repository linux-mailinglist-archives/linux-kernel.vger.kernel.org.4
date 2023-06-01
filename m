Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B50C719D30
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjFANTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjFANTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:19:39 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A0F124
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:19:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so1319221a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685625576; x=1688217576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9fh93enkgzJnFkHaT1AoRmSykNaubcKRvO4orBZENE=;
        b=BMRLbYcZWRFGS8NzP5yyzosPnpQDUKsuOhZIDqRoXkrGfEJUl1ZrM/SVv/R2n2dI+4
         XM8o2QAfqi49Y99YWc7CErF4Krl4tRyIiBrHfnZSGSxOz7cGMWyQrqgcvpNw4/Ey4Z+S
         JKKbxtJyTK4l+zvVfFpySCANBuYLbxMapFWJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685625576; x=1688217576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9fh93enkgzJnFkHaT1AoRmSykNaubcKRvO4orBZENE=;
        b=HP4DotPRF3TPSZqgRVwohzUEIRUwvCAXfsCs2+KWjiY1EQDHfUvJMVYbgkkewBaqgw
         mefPlLW99hhd9oPBpI0NQiMZtRWSl/051XkSApU9cIsyc0y+qvegAppVfIzKcYFwmCPa
         Z9S6TRCuqjeAslUZ9GDcc5R/ayEPBSRNUI8rsujMSN9tcCmKu7mVtn0C6vqGm9HTTAmG
         6ox1SKxTbf/ibmC01YjhbfOB7EUXrHM3N21a1E36wCJ3hzj7cLlLHNvtAyNTqI5ed/Rl
         cFw87wuWq6+O7JRwjXm6R7x/GaIg6sBbKXfRyW4HdRUamp9U/y64k/q10CRDo8vD+tcj
         MehQ==
X-Gm-Message-State: AC+VfDzOBiuM1Xq51ctF4V5wbAvPnEIRJLat2NSCD/ptjyp/I+/FX0+x
        HS/B6Sv3pd0yAuE4DI1mp+BcCV/SJW/4aFQclZkF0GVb
X-Google-Smtp-Source: ACHHUZ5QvkBXAUXNZA+BZNuPAO4NdUQXmZ6cMEjhJKLFcNY9qI+NqIAleikYsosLLzbIlJ4nTXHKnA==
X-Received: by 2002:a17:907:9722:b0:95e:d448:477 with SMTP id jg34-20020a170907972200b0095ed4480477mr9028792ejc.33.1685625576231;
        Thu, 01 Jun 2023 06:19:36 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id s17-20020a1709064d9100b00969f25b96basm10495132eju.204.2023.06.01.06.19.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 06:19:35 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5147f5efeb5so1351313a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:19:35 -0700 (PDT)
X-Received: by 2002:a17:907:a414:b0:96f:5f44:ea02 with SMTP id
 sg20-20020a170907a41400b0096f5f44ea02mr8514666ejc.8.1685625575183; Thu, 01
 Jun 2023 06:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230524153311.3625329-1-dhowells@redhat.com> <20230524153311.3625329-10-dhowells@redhat.com>
 <20230526180844.73745d78@kernel.org> <499791.1685485603@warthog.procyon.org.uk>
 <CAHk-=wgeixW3cc=Ys8eL0_+22FUhqeEru=nzRrSXy1U4YQdE-w@mail.gmail.com>
In-Reply-To: <CAHk-=wgeixW3cc=Ys8eL0_+22FUhqeEru=nzRrSXy1U4YQdE-w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Jun 2023 09:19:18 -0400
X-Gmail-Original-Message-ID: <CAHk-=wghhHghtvU_SzXxAzfaX35BkNs-x91-Vj6+6tnVEhPrZg@mail.gmail.com>
Message-ID: <CAHk-=wghhHghtvU_SzXxAzfaX35BkNs-x91-Vj6+6tnVEhPrZg@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 9:09=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The reason the old code is garbage is that it sets SPLICE_F_MORE
> entirely in the wrong place. It sets it *after* it has done the
> splice(). That's just crazy.

Clarification, because there are two splice's (from and to): by "after
the splice" I mean after the splice source, of course. It's still set
before the splice _to_ the network.

(But it is still true that I hope the networking code itself then sets
MSG_MORE even if SPLICE_F_MORE wasn't set, if it gets a buffer that is
bigger than what it can handle right now - so there are two
*different* reasons for "more data" - either the source knows it has
more to give, or the destination knows it didn't use everything it
got).

The point is that the splice *source* knows whether there is more data
to be had, and that's where the "there is more" should be set.

But the generic code does *not* know. You add a completely horrendous
hack to kind of approximate that knowledge, but it's *wrong*.

The old code was wrong too, of course. No question about that.

Basically my argument is that the whole "there is more data" should be
set by "->splice_read()" not by some hack in some generic
splice_direct_to_actor() function that is absolutely not supposed to
know about the internals of the source or the destination.

Do we have a good interface for that? No. I get the feeling that to
actually fix this, we'd have to pass in the 'struct splice_desc"
pointer to ->splice_read().

Then the reading side can say "yup, I have more data for you after
this", and it all makes sense at least conceptually.

So please, can we just fix the layering violation, rather than make it wors=
e?

                Linus
