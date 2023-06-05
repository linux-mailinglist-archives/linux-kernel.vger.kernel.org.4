Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1D1722BF8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjFEPxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFEPxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9603094
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685980339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sbYi2SqNkU8HcJmItNwFRpx+Pi9dAFWzLYDLig6jfuY=;
        b=X5DwuWYsrNzsGJbneDvKQ/kBBVUwayju279pQT+jCSOIN8rHJemCeRcBG78ooge8SphsEE
        TzBHpfuML8kBzdCuZmN5RIrZHFVipazdfwKwZ0HRnylD8eIVsQkdjdKCqn9z+4mIkjUUZZ
        Q2N/2YOBlVfIp94pYmmfnsWWK4NikQE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-mCEpg48XNU-DQyoEqEYCzA-1; Mon, 05 Jun 2023 11:52:16 -0400
X-MC-Unique: mCEpg48XNU-DQyoEqEYCzA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5604B811E8F;
        Mon,  5 Jun 2023 15:52:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 436CB403174;
        Mon,  5 Jun 2023 15:52:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <e94820ba53924e96b31ac983c84269f8@AcuMS.aculab.com>
References: <e94820ba53924e96b31ac983c84269f8@AcuMS.aculab.com> <20230524153311.3625329-1-dhowells@redhat.com> <20230524153311.3625329-10-dhowells@redhat.com> <20230526180844.73745d78@kernel.org> <499791.1685485603@warthog.procyon.org.uk> <CAHk-=wgeixW3cc=Ys8eL0_+22FUhqeEru=nzRrSXy1U4YQdE-w@mail.gmail.com> <CAHk-=wghhHghtvU_SzXxAzfaX35BkNs-x91-Vj6+6tnVEhPrZg@mail.gmail.com> <832277.1685630048@warthog.procyon.org.uk> <CAHk-=wji_2UwFMkUYkygsYRek05NwaQkH-vA=yKQtQS9Js+urQ@mail.gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     dhowells@redhat.com,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        "Boris Pismenny" <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Bug in short splice to socket?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1732083.1685980332.1@warthog.procyon.org.uk>
Date:   Mon, 05 Jun 2023 16:52:12 +0100
Message-ID: <1732084.1685980332@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> wrote:

> > > However, this might well cause a malfunction in UDP, for example.
> > > MSG_MORE corks the current packet, so if I ask sendfile() say shove 32K
> > > into a packet, if, say, 16K is read from the source and entirely
> > > transcribed into the packet,
> > 
> > If you use splice() for UDP, I don't think you would normally expect
> > to get all that well-defined packet boundaries.
> 
> Especially since (assuming I've understood other bits of this thread)
> the splice() can get split into multiple sendmsg() calls for other
> reasons.

Yes - with SPLICE_F_MORE/MSG_MORE set on all but the last piece.  The issue is
what happens if the input side gets a premature EOF after we've passed a chunk
with MSG_MORE set when the caller didn't indicate SPLICE_F_MORE?

> What semantics are you trying to implement for AF_TLS?

As I understand it, deasserting MSG_MORE causes a record boundary to be
interposed on TLS.

> MSG_MORE has different effects on different protocols.

Do you mean "different protocols" in relation to TLS specifically? Software vs
device vs device-specific like Chelsio-TLS?

> For UDP the next data is appended to the datagram being built.
> (This is really pretty pointless, doing it in the caller will be faster!)

Splice with SPLICE_F_MORE seems to work the same as sendmsg with MSG_MORE
here.  You get an error if you try to append with splice or sendmsg more than
a single packet will hold.

> For TCP it stops the pending data being sent immediately.
> And more data is appended.
> I'm pretty sure it gets sent on timeout.

Yeah - corking is used by some network filesystem protocols, presumably to
better place RPC messages into TCP packets.

> For SCTP the data chunk created for the sendmsg() isn't sent immediately.
> Any more sendmsg(MSG_MORE) get queued until a full ethernet packet
> is buffered.
> The pending data is sent on timeout.
> This is pretty much the only way to get two (or more) DATA chunks
> into an ethernet frame when Nagle is disabled.

SCTP doesn't support sendpage, so that's not an issue.

> But I get the impression AF_TLS is deciding not to encode/send
> the data because 'there isn't enough'.
> That seems wrong.
> 
> Note that you can't use a zero length sendmsg() to flush pending
> data - if there is no pending data some protocols will send a 
> zero length data message.
> A socket option/ioctl (eg UNCORK) could be (ab)used to force
> queued data be sent.

Yeah - I've changed that, see v4.  I've implemented Linus's ->splice_eof()
idea.

David

