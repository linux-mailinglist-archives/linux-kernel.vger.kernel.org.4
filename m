Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B5873AE7C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 04:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjFWCLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 22:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjFWCLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 22:11:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A133F2122
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 19:11:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C73DA61944
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2FCC433C9;
        Fri, 23 Jun 2023 02:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687486296;
        bh=ZGne4zj9CsGJycq2UzIiziKr2jVISNHV9G2s8oY3T0w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W0+Na6VIE5e9qEtp3Iw5o2+JnUz7ML9MeTL5L5dv4nHrgCds/5mbiypeU8fINlxbS
         4x3mhFwo9JrNJmY97S4wC1Ni+2JoFU7QhQ/jmawOu9qV9IATatO3KF4781zWqCS/vb
         b9cSd5Pr+VBSFGtiNAAxga7SEIrXhJFnGuj0q7i/1JrWVp+nPyDvCpEAOM2dq6j4ZN
         m7VYqX9Dnp+tBjURpxNrHOimQhwCGMpF0zTOdWdKG2TCPLrUtmx8YksTo+3Mp/cDQ4
         hNaMCs2rr6p/b2WhyzsGuzctQXD2mM6WTQzyfXWRZ3YEsrX2Q5iPu7UWvz1vZIb4ob
         tjLGVCUVbt4Jw==
Date:   Thu, 22 Jun 2023 19:11:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH net-next v3 01/18] net: Copy slab data for
 sendmsg(MSG_SPLICE_PAGES)
Message-ID: <20230622191134.54d5cb0b@kernel.org>
In-Reply-To: <1958077.1687474471@warthog.procyon.org.uk>
References: <20230622132835.3c4e38ea@kernel.org>
        <20230622111234.23aadd87@kernel.org>
        <20230620145338.1300897-1-dhowells@redhat.com>
        <20230620145338.1300897-2-dhowells@redhat.com>
        <1952674.1687462843@warthog.procyon.org.uk>
        <1958077.1687474471@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 23:54:31 +0100 David Howells wrote:
> > Maybe it's just me but I'd prefer to keep the clear rule that splice
> > operates on pages not slab objects.  
> 
> sendpage isn't only being used for splice().  Or were you referring to
> splicing pages into socket buffers more generally?

Yes, sorry, any sort of "zero-copy attachment of data onto a socket
queue".

> > SIW is the software / fake implementation of RDMA, right? You couldn't have
> > picked a less important user :(  
> 
> ISCSI and sunrpc could both make use of this, as could ceph and others.  I
> have patches for sunrpc to make it condense into a single bio_vec[] and
> sendmsg() in the server code (ie. nfsd) but for the moment, Chuck wanted me to
> just do the xdr payload.

But to be clear (and I'm not implying that it's not a strong enough
reason) - the only benefit from letting someone pass headers in a slab
object is that the code already uses kmalloc(), right? IOW it could be
changed to use frags without much of a LoC bloat?

> > Maybe we can get Eric to comment. The ability to identify "frag type"
> > seems cool indeed, but I haven't thought about using it to attach
> > slab objects.  
> 
> Unfortunately, you can't attach slab objects.  Their lifetime isn't controlled
> by put_page() or folio_put().  kmalloc()/kfree() doesn't refcount them -
> they're recycled immediately.  Hence why I was copying them.  (Well, you
> could attach, but then you need a callback mechanism).

Right, right, I thought you were saying that _in the future_ we may try
to attach the slab objects as frags (and presumably copy when someone
tries to ref them). Maybe I over-interpreted.

> What I'm trying to do is make it so that the process of calling sock_sendmsg()
> with MSG_SPLICE_PAGES looks exactly the same as without: You fill in a
> bio_vec[] pointing to your protocol header, the payload and the trailer,
> pointing as appropriate to bits of slab, static, stack data or ref'able pages,
> and call sendmsg and then the data will get copied or spliced as appropriate
> to the page type, whether the MSG_SPLICE_PAGES flag is supplied and whether
> the flag is supported.
> 
> There are a couple of things I'd like to avoid: (1) having to call
> sock_sendmsg() more than once per message and (2) having sendmsg allocate more
> space and make a copy of data that you had to copy into a frag before calling
> sendmsg.

If we're not planning to attach the slab objects as frags, then surely
doing kmalloc() + free() in the caller, and then allocating a frag and
copying the data over in the skb / socket code is also inefficient.
Fixing the caller gives all the benefits you want, and then some.

Granted some form of alloc_skb_frag() needs to be added so that callers
don't curse us, I'd start with something based on sk_page_frag().

Or we could pull the coping out into an intermediate helper which
first replaces all slab objects in the iovec with page frags and then
calls sock_sendmsg()? Maybe that's stupid...

Let's hear what others think. If we can't reach instant agreement --
can you strategically separate out the minimal set of changes required
to just kill MSG_SENDPAGE_NOTLAST. IMHO it's worth getting that into
6.5.
