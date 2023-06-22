Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F2773ACBF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjFVWz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 18:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjFVWz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:55:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C68D1FE6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 15:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687474478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CoZIUtTkYvBb1iCo4vdxE0rm6LAMYX4km4nzgk6efLk=;
        b=iB+TWYmxiUk4w7E7yL0TFGwCYZNEy5KNERvydr/Riro9xh6UVGP6nd3zF0VwFzwZalvHig
        iMnnR2PfqQIOMuYOxUYD0SIJQHQI45Jjl30wszIadR0OIa7aVuQtJug2yVkC35KrgAJIMh
        oXVx5U6SuXHq/vc1e+Q+sv7UY+orNCI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-jZIMhQ75NBCZnOxUMJ0HiA-1; Thu, 22 Jun 2023 18:54:34 -0400
X-MC-Unique: jZIMhQ75NBCZnOxUMJ0HiA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B49101C05EBA;
        Thu, 22 Jun 2023 22:54:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14100C1ED97;
        Thu, 22 Jun 2023 22:54:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230622132835.3c4e38ea@kernel.org>
References: <20230622132835.3c4e38ea@kernel.org> <20230622111234.23aadd87@kernel.org> <20230620145338.1300897-1-dhowells@redhat.com> <20230620145338.1300897-2-dhowells@redhat.com> <1952674.1687462843@warthog.procyon.org.uk>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     dhowells@redhat.com, Eric Dumazet <edumazet@google.com>,
        netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH net-next v3 01/18] net: Copy slab data for sendmsg(MSG_SPLICE_PAGES)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1958076.1687474471.1@warthog.procyon.org.uk>
Date:   Thu, 22 Jun 2023 23:54:31 +0100
Message-ID: <1958077.1687474471@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> wrote:

> Maybe it's just me but I'd prefer to keep the clear rule that splice
> operates on pages not slab objects.

sendpage isn't only being used for splice().  Or were you referring to
splicing pages into socket buffers more generally?

> SIW is the software / fake implementation of RDMA, right? You couldn't have
> picked a less important user :(

ISCSI and sunrpc could both make use of this, as could ceph and others.  I
have patches for sunrpc to make it condense into a single bio_vec[] and
sendmsg() in the server code (ie. nfsd) but for the moment, Chuck wanted me to
just do the xdr payload.

> > This offers the opportunity, at least in the future, to append slab data
> > to an already-existing private fragment in the skbuff.
> 
> Maybe we can get Eric to comment. The ability to identify "frag type"
> seems cool indeed, but I haven't thought about using it to attach
> slab objects.

Unfortunately, you can't attach slab objects.  Their lifetime isn't controlled
by put_page() or folio_put().  kmalloc()/kfree() doesn't refcount them -
they're recycled immediately.  Hence why I was copying them.  (Well, you
could attach, but then you need a callback mechanism).


What I'm trying to do is make it so that the process of calling sock_sendmsg()
with MSG_SPLICE_PAGES looks exactly the same as without: You fill in a
bio_vec[] pointing to your protocol header, the payload and the trailer,
pointing as appropriate to bits of slab, static, stack data or ref'able pages,
and call sendmsg and then the data will get copied or spliced as appropriate
to the page type, whether the MSG_SPLICE_PAGES flag is supplied and whether
the flag is supported.

There are a couple of things I'd like to avoid: (1) having to call
sock_sendmsg() more than once per message and (2) having sendmsg allocate more
space and make a copy of data that you had to copy into a frag before calling
sendmsg.

David

