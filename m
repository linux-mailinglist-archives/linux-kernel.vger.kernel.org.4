Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20316720099
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbjFBLp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFBLpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0D6194
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685706307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0/yzPRRzgr0a2u6l5HBVBgW8iyZpj+2he0Zb6/uXfoE=;
        b=CbLtjryOZw1QeR+KIknKExGKbAFL5zoWcDwqe9QdHp/8epSC9UPXINCRbmlL81bvEf463i
        r85JvZpxVY6NPoL8zEgzMeNhLd0sdK+nXzRCId5HJj9l/eofIfRLY8069hoix+9LFDVIbr
        r61tMnHOzJDGPPL+/tyllexk9byPtIs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-18pN8u9yNt6Rjg29hrPxFQ-1; Fri, 02 Jun 2023 07:45:00 -0400
X-MC-Unique: 18pN8u9yNt6Rjg29hrPxFQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55AD9381D4ED;
        Fri,  2 Jun 2023 11:44:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19CB1C154D7;
        Fri,  2 Jun 2023 11:44:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjvgL5nyZmpYRWBfab4NKvfQ7NjUvUhE3a3wYTyTEHdfQ@mail.gmail.com>
References: <CAHk-=wjvgL5nyZmpYRWBfab4NKvfQ7NjUvUhE3a3wYTyTEHdfQ@mail.gmail.com> <CAHk-=wji_2UwFMkUYkygsYRek05NwaQkH-vA=yKQtQS9Js+urQ@mail.gmail.com> <20230524153311.3625329-1-dhowells@redhat.com> <20230524153311.3625329-10-dhowells@redhat.com> <20230526180844.73745d78@kernel.org> <499791.1685485603@warthog.procyon.org.uk> <CAHk-=wgeixW3cc=Ys8eL0_+22FUhqeEru=nzRrSXy1U4YQdE-w@mail.gmail.com> <CAHk-=wghhHghtvU_SzXxAzfaX35BkNs-x91-Vj6+6tnVEhPrZg@mail.gmail.com> <832277.1685630048@warthog.procyon.org.uk> <909595.1685639680@warthog.procyon.org.uk> <20230601212043.720f85c2@kernel.org> <952877.1685694220@warthog.procyon.org.uk>
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
Content-ID: <1227121.1685706296.1@warthog.procyon.org.uk>
Date:   Fri, 02 Jun 2023 12:44:56 +0100
Message-ID: <1227123.1685706296@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Do what I already suggested: making SPLICE_F_MORE reflect reality.

I'm trying to.  I need MSG_MORE to behave sensibly for what I want.

What I have signals SPLICE_F_MORE (and thus MSG_MORE) as long as we haven't
yet read enough data to fulfill the request - and will break out of the loop
if we get a zero-length read.

But this causes a change in behaviour because we then leave the protocol
having seen MSG_MORE set where it didn't previously see that.

This causes "tls -r tls.12_aes_gcm.multi_chunk_sendfile" on the TLS kselftest
to fail.

Now, if we're fine with the change in behaviour, I can make the selftest
observe the short sendfile() and cancel MSG_MORE itself - but that's just a
test program.

So that's the question: Do I have to maintain the current behaviour for the
short-splice case?

David

