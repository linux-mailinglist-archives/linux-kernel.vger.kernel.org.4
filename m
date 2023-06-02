Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32785720820
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbjFBRFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbjFBRFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:05:37 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86FD1A4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:05:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f4bdcde899so3092403e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 10:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685725534; x=1688317534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzyEvgFM4vBLAnySBJOk0orGfxOVuDft8i1c0mN6AA4=;
        b=OdE+LoDd65ZZj9zVyGZSCZI9qn8+CWDC1g0qNCCO5bxb2PxD4AuWpDU0mP4o/OmjJa
         CTHR2yrZII1XYV+S1LJBNxsSqQLh6MzdM2wB6owS+beTpTG7Jlwelw8cx9b4yA4ZotJD
         nTW/I4WZZMaLkZUAO4MKf5l3MefPR2PmIurMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685725534; x=1688317534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzyEvgFM4vBLAnySBJOk0orGfxOVuDft8i1c0mN6AA4=;
        b=cqeanNbMiPrZlHkDJOWjTdlyG43FiTjjfcPAE6HiitIfEPfmwWYtGOmCh3XKuiY7jm
         7HeDDiwxq+cUAQiaykPKgE5Tl8eyjoCy7xbfyAr6ktdKc8133jg13Wlqyc57u5gYXjrd
         cW4bQyOWD8GnV3FEYnFqteooTmcHlnXJ2JxA6ENC55qefo71mxynAXq00sKwXHsYZ3IL
         p1lLfIG8AVG69ioRgtfe0LHwd3dtrl4p8BhsoXI/x6ZRRQ0uvkOl0lmzI/xd7uYY9KUn
         jMWdl/csouyGgp3ibjyv3ZwsGBNf1LKvU+HaP+FXB5KrO+VmKvxoVuwm0k8BCkQFGk2N
         FHqw==
X-Gm-Message-State: AC+VfDxUjDHqRWfBY3Ry2YbG6YSeyIJCF4B8w3d5LwC1kZhrRO0aCHOr
        RgP8U5jHvtG6lEktSshqW+Ffe1YkF207cAfD7YDbbubt
X-Google-Smtp-Source: ACHHUZ4JizgI/0mwru3cm4vZRX6PihXP2QzVR7UUHoYQ8jXXyLZUmvWL3r7XzhoH0MvOuo5VPyDDBA==
X-Received: by 2002:ac2:5223:0:b0:4f6:b34:a026 with SMTP id i3-20020ac25223000000b004f60b34a026mr2155695lfl.60.1685725533833;
        Fri, 02 Jun 2023 10:05:33 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id x24-20020aa7d398000000b0051499320435sm882252edq.14.2023.06.02.10.05.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 10:05:31 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51478f6106cso3327352a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 10:05:31 -0700 (PDT)
X-Received: by 2002:aa7:d6d7:0:b0:50d:9de4:5664 with SMTP id
 x23-20020aa7d6d7000000b0050d9de45664mr1810734edr.40.1685725531338; Fri, 02
 Jun 2023 10:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wji_2UwFMkUYkygsYRek05NwaQkH-vA=yKQtQS9Js+urQ@mail.gmail.com>
 <20230524153311.3625329-1-dhowells@redhat.com> <20230524153311.3625329-10-dhowells@redhat.com>
 <20230526180844.73745d78@kernel.org> <499791.1685485603@warthog.procyon.org.uk>
 <CAHk-=wgeixW3cc=Ys8eL0_+22FUhqeEru=nzRrSXy1U4YQdE-w@mail.gmail.com>
 <CAHk-=wghhHghtvU_SzXxAzfaX35BkNs-x91-Vj6+6tnVEhPrZg@mail.gmail.com>
 <832277.1685630048@warthog.procyon.org.uk> <909595.1685639680@warthog.procyon.org.uk>
 <20230601212043.720f85c2@kernel.org> <952877.1685694220@warthog.procyon.org.uk>
 <CAHk-=wjvgL5nyZmpYRWBfab4NKvfQ7NjUvUhE3a3wYTyTEHdfQ@mail.gmail.com>
 <1227123.1685706296@warthog.procyon.org.uk> <CAHk-=wgyAGUMHmQM-5Eb556z5xiHZB7cF05qjrtUH4F7P-1rSA@mail.gmail.com>
 <20230602093929.29fd447d@kernel.org> <CAHk-=whgpCNzmQfTAUY7D8P6t9TgzoLx9Uauu7YGQpgZtg-SYg@mail.gmail.com>
In-Reply-To: <CAHk-=whgpCNzmQfTAUY7D8P6t9TgzoLx9Uauu7YGQpgZtg-SYg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 13:05:14 -0400
X-Gmail-Original-Message-ID: <CAHk-=wh=V579PDYvkpnTobCLGczbgxpMgGmmhqiTyE34Cpi5Gg@mail.gmail.com>
Message-ID: <CAHk-=wh=V579PDYvkpnTobCLGczbgxpMgGmmhqiTyE34Cpi5Gg@mail.gmail.com>
Subject: Re: Bug in short splice to socket?
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
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

On Fri, Jun 2, 2023 at 12:53=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And no, I don't think "splice_end()" can be that exact semantics -
> even if it's simple - exactly because splice() is an interruptible
> operation, so the "end" of a splice() is simply not a stable thing.

Just to harp some more on this - if SPLICE_F_MORE is seen as purely a
performance hit, with no real semantic value, and will still set
random packet boundaries but we want big packets for all the _usual_
cases, then I think something like "splice_end()" can be a fine
solution regardless of exact semantics.

Alternatively, if we make it the rule that "splice_end()" is only
called on EOF situations - so signals etc do not matter - then the
semantics would be stable and sound fine to me too.

In that second case, I'd like to literally name it that way, and
actually call it "splice_eof()". Because I'd like to really make it
very clear what the semantics would be.

So a "splice_eof()" sounds fine to me, and we'd make the semantics be
the current behavior:

 - splice() sets SPLICE_F_MORE if 'len > read_len'

 - splice() _clears_ SPLICE_F_MORE if we have hit 'len'

 - splice always sets SPLICE_F_MORE if it was passed by the user

BUT with the small new 'splice_eof()' rule that:

 - if the user did *not* set SPLICE_F_MORE *and* we didn't hit that
"use all of len" case that cleared SPLICE_F_MORE, *and* we did a
"->splice_in()" that returned EOF (ie zero), *then* we will also do
that ->splice_eof() call.

The above sounds like "stable and possibly useful semantics" to me. It
would just have to be documented.

Is that what people want?

I don't think it's conceptually any different from my suggestion of
saying "->splice_read() can set SPLICE_F_MORE if it has more to give",
just a different implementation that doesn't require changes on the
splice_read() side.

                 Linus
