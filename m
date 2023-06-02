Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4215E720A6B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 22:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbjFBUjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 16:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjFBUjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 16:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79767E42
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 13:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685738327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9cFmOTRalrutMLCpPhglIGPnK0Bp8qtiBThh8gpw5mE=;
        b=Zxqx5rW1cM1Ut1CTrIc6avc2KtEGrhLfqyRIozmxLDEvAQxY3R41L8GpdrshfnODjvCaZh
        hu912rpR/BJqwZlUkUuWPZbysZV5hDice7jUptQD6sLKcF0gJLJQGjtMT6GyVZ7g0G6nUm
        pNVcRUwZra39aT4U/bcGeJPwIwQF9uo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-wEvFv4c5MtC6Mv9sV1jM2g-1; Fri, 02 Jun 2023 16:38:45 -0400
X-MC-Unique: wEvFv4c5MtC6Mv9sV1jM2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51E093C13511;
        Fri,  2 Jun 2023 20:38:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D7E12026D49;
        Fri,  2 Jun 2023 20:38:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wh=V579PDYvkpnTobCLGczbgxpMgGmmhqiTyE34Cpi5Gg@mail.gmail.com>
References: <CAHk-=wh=V579PDYvkpnTobCLGczbgxpMgGmmhqiTyE34Cpi5Gg@mail.gmail.com> <CAHk-=wji_2UwFMkUYkygsYRek05NwaQkH-vA=yKQtQS9Js+urQ@mail.gmail.com> <20230524153311.3625329-1-dhowells@redhat.com> <20230524153311.3625329-10-dhowells@redhat.com> <20230526180844.73745d78@kernel.org> <499791.1685485603@warthog.procyon.org.uk> <CAHk-=wgeixW3cc=Ys8eL0_+22FUhqeEru=nzRrSXy1U4YQdE-w@mail.gmail.com> <CAHk-=wghhHghtvU_SzXxAzfaX35BkNs-x91-Vj6+6tnVEhPrZg@mail.gmail.com> <832277.1685630048@warthog.procyon.org.uk> <909595.1685639680@warthog.procyon.org.uk> <20230601212043.720f85c2@kernel.org> <952877.1685694220@warthog.procyon.org.uk> <CAHk-=wjvgL5nyZmpYRWBfab4NKvfQ7NjUvUhE3a3wYTyTEHdfQ@mail.gmail.com> <1227123.1685706296@warthog.procyon.org.uk> <CAHk-=wgyAGUMHmQM-5Eb556z5xiHZB7cF05qjrtUH4F7P-1rSA@mail.gmail.com> <20230602093929.29fd447d@kernel.org> <CAHk-=whgpCNzmQfTAUY7D8P6t9TgzoLx9Uauu7YGQpgZtg-SYg@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
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
Subject: Re: Bug in short splice to socket?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1379960.1685738320.1@warthog.procyon.org.uk>
Date:   Fri, 02 Jun 2023 21:38:40 +0100
Message-ID: <1379961.1685738320@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So a "splice_eof()" sounds fine to me, and we'd make the semantics be
> the current behavior:
> 
>  - splice() sets SPLICE_F_MORE if 'len > read_len'
> 
>  - splice() _clears_ SPLICE_F_MORE if we have hit 'len'
> 
>  - splice always sets SPLICE_F_MORE if it was passed by the user
> 
> BUT with the small new 'splice_eof()' rule that:
> 
>  - if the user did *not* set SPLICE_F_MORE *and* we didn't hit that
> "use all of len" case that cleared SPLICE_F_MORE, *and* we did a
> "->splice_in()" that returned EOF (ie zero), *then* we will also do
> that ->splice_eof() call.
> 
> The above sounds like "stable and possibly useful semantics" to me. It
> would just have to be documented.
> 
> Is that what people want?

That's easier to implement, I think.  That's basically what I was trying to
achieve by sending a zero-length actor call, but this is a cleaner way of
doing it, particularly if it's added as a socket op next to ->sendmsg().

Otherwise I have to build up the input side to try and tell me in advance
whether it thinks we hit an EOF/hole/whatever condition.  The problem is that,
as previously mentioned, it doesn't work for all circumstances - seqfile,
pipes, sockets for instance.

Take the following scenario for example: I could read from a TCP socket,
filling up the pipe-buffer, but not with sufficient data to fulfill the
operation.  Say I drain the TCP socket, but it's still open, so might produce
more data.  I then call the actor, which passes all the data to sendmsg() with
MSG_SPLICE_PAGES and MSG_MORE and clears the buffer.  I then go round again,
but in the meantime, the source socket got shut down with no further data
available and do_splice_to() returns 0.

There's no way to predict this, so having a ->splice_eof() call would handle
this situation.

David

