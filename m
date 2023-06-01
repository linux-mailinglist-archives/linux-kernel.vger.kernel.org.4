Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F1171A21F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbjFAPMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjFAPMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:12:41 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B728F123
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:12:38 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2af30a12e84so14120151fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685632356; x=1688224356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ph7ftW5cejm+zmzrjTmdD1HUI/Koyz77q7cE4rVNfqE=;
        b=IMhCo74zneEuKMWiRVobthi+gLDn7dJxBRgHxTAOes2/kMwkR9caK9KBYWCPzw6WLg
         zFrc5cHUsczAYMJLH7gq/BaaNu4dxy9mZVnwfTJlLcg2yjoFq2nWT5AwfV37/bd9D2NI
         4/aKFd0Y+cutsBT8LL8il+hHP2+jzjmrNIif0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632356; x=1688224356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ph7ftW5cejm+zmzrjTmdD1HUI/Koyz77q7cE4rVNfqE=;
        b=BqF075tzfH94AByOfbVxxhgfP3lwuh6YqLpozyMCzQEQp7iWG/IcMQMU5XH/2Fe8MR
         9Ah0UoC1xX4saYtes6EMEiDfysus1mcnl8Hvb1Ja+9gq9iOIfHLZs88Guz+4Wntix47P
         pK/TQ1FcGEPTFPOu6IL/OQpYDl1W7smvtYIRzLew6+ItS3XBgWM3ZjjyaMAHJ2PtjH7B
         sritBWWZgpjFJtvKzQKaEIOWMQTCeq0c/QKEji8MRkvXzd9/FZ61KH8CLQ7Gz46FCJ0h
         lD4dWbhP5b97M07ifWNxoUT09eMAa2/2PUrA3vsE19iF8oKQ9FzPLJ6NeaUujmwHuobv
         rDGQ==
X-Gm-Message-State: AC+VfDySYspGV5ACxriKnbq/qJGD9QBYpa+eruPKBoRmQvrEmVWbfvoT
        pyu2BGYSFYI3phbZcCznwgfyu7Xp0VBLbpHpPJ5bqtfy
X-Google-Smtp-Source: ACHHUZ77O5vA6s71HAviH4qFbGFJ68tDH7QdKOmMWpeaLI8E5pquGzj1rf7Gtgbjs8YTawmc13eLQQ==
X-Received: by 2002:a2e:a176:0:b0:2a8:bdff:8556 with SMTP id u22-20020a2ea176000000b002a8bdff8556mr5220274ljl.13.1685632356239;
        Thu, 01 Jun 2023 08:12:36 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id r3-20020a170906a20300b00965ffb8407asm10618122ejy.87.2023.06.01.08.12.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 08:12:35 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-96fe88cd2fcso126401866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:12:35 -0700 (PDT)
X-Received: by 2002:a17:907:a42a:b0:96f:912d:7922 with SMTP id
 sg42-20020a170907a42a00b0096f912d7922mr7892507ejc.53.1685632355228; Thu, 01
 Jun 2023 08:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230524153311.3625329-1-dhowells@redhat.com> <20230524153311.3625329-10-dhowells@redhat.com>
 <20230526180844.73745d78@kernel.org> <499791.1685485603@warthog.procyon.org.uk>
 <CAHk-=wgeixW3cc=Ys8eL0_+22FUhqeEru=nzRrSXy1U4YQdE-w@mail.gmail.com>
 <CAHk-=wghhHghtvU_SzXxAzfaX35BkNs-x91-Vj6+6tnVEhPrZg@mail.gmail.com> <832277.1685630048@warthog.procyon.org.uk>
In-Reply-To: <832277.1685630048@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Jun 2023 11:12:17 -0400
X-Gmail-Original-Message-ID: <CAHk-=wji_2UwFMkUYkygsYRek05NwaQkH-vA=yKQtQS9Js+urQ@mail.gmail.com>
Message-ID: <CAHk-=wji_2UwFMkUYkygsYRek05NwaQkH-vA=yKQtQS9Js+urQ@mail.gmail.com>
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

On Thu, Jun 1, 2023 at 10:34=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> At the moment, it transcribes 16 pages at a time.  I could make it set
> MSG_MORE only if (a) SPLICE_F_MORE was passed into the splice() syscall o=
r (b)
> there's yet more data in the buffer.

That would at least be a good first step.

> However, this might well cause a malfunction in UDP, for example.  MSG_MO=
RE
> corks the current packet, so if I ask sendfile() say shove 32K into a pac=
ket,
> if, say, 16K is read from the source and entirely transcribed into the pa=
cket,

If you use splice() for UDP, I don't think you would normally expect
to get all that well-defined packet boundaries.

That said, I think *this* part of splice_direct_to_actor() is correct:

                if (read_len < len)
                        sd->flags |=3D SPLICE_F_MORE;    <- WRONG
                else if (!more)
                        sd->flags &=3D ~SPLICE_F_MORE; <- CORRECT

ie if we've used up all of the 'len' argument, *and* 'more' wasn't set
in the incoming flags, then at that point we should clear
SPLICE_F_MORE.

So that means that UDP packets boundaries will be honored at the
'splice()' system call 'len' argument.

Obviously packet boundaries might happen before that - ie depending on
what the packet size limits are.

But the "set SPLICE_F_MORE" bit is just wrong. The generic code simply
does not know enough to make that determination.

> if I understand what you're proposing, MSG_MORE wouldn't get set and the
> packet would be transmitted early.

No, I'm saying that MSG_MORE should be set depending on what the
splice *input* says.

If the splice input knows that it has more to give but stopped early
for whatever reason (typically that the splice pipe buffers filled up,
but that's not necessarily the *only* reason), then it should set
SPLICE_F_MORE.

But this is literally only something that the input side *can* know.

And as you mention, some input sides cannot know even that. Regular
files typically know if there is more data. Other dynamic sources may
simply not know. And if they know, they just shouldn't set
SPLICE_F_MORE.

Of course, SPLICE_F_MORE may then be set because the *user* passed in
that flag, but that's a completely separate issue. The user may pass
in that flag because the user wants maximally sized packets, and knows
that other things will be fed into the destination (not even
necessarily through splice) after the splice.

So you really have multiple different reasons why SPLICE_F_MORE might
get set, but that

                if (read_len < len)

is *not* a valid reason. And no, extending that logic with more random
logic is still not a valid reason.

            Linus
