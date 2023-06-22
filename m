Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6648C73A916
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjFVTl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjFVTlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A261FDF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 12:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687462867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZ2Xje2ved2ulckSwXdjtr8v/wsld5XIT0hNVNJkMSk=;
        b=NNo8f3BedSC8Y7M8NKoG0FG4oTMe3r0Q+SRavANC8kf6rjkiALwQ9MUieLL1J29tWHmreJ
        97JUltFnog79mMuEr9GRLpbzVGnIQq6Od7Lk+zccDWDWGcUWOsajWYipPZ7JgLk5PUbdHX
        K2TWk90400OwfF4RwvTzoCO6vixphJs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-zM8z2jPxM6Ge_eoEK0X5CQ-1; Thu, 22 Jun 2023 15:41:03 -0400
X-MC-Unique: zM8z2jPxM6Ge_eoEK0X5CQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2762A282380B;
        Thu, 22 Jun 2023 19:40:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1AEC492B01;
        Thu, 22 Jun 2023 19:40:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230622111234.23aadd87@kernel.org>
References: <20230622111234.23aadd87@kernel.org> <20230620145338.1300897-1-dhowells@redhat.com> <20230620145338.1300897-2-dhowells@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH net-next v3 01/18] net: Copy slab data for sendmsg(MSG_SPLICE_PAGES)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1952673.1687462843.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 22 Jun 2023 20:40:43 +0100
Message-ID: <1952674.1687462843@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> wrote:

> > If sendmsg() is passed MSG_SPLICE_PAGES and is given a buffer that con=
tains
> > some data that's resident in the slab, copy it rather than returning E=
IO.
> =

> How did that happen? I thought MSG_SPLICE_PAGES comes from former
> sendpage users and sendpage can't operate on slab pages.

Some of my patches, take the siw one for example, now aggregate all the bi=
ts
that make up a message into a single sendmsg() call, including any protoco=
l
header and trailer in the same bio_vec[] as the payload where before it wo=
uld
have to do, say, sendmsg+sendpage+sendpage+...+sendpage+sendmsg.

I'm trying to make it so that I make the minimum number of sendmsg calls
(ie. 1 where possible) and the loop that processes the data is inside of t=
hat.
This offers the opportunity, at least in the future, to append slab data t=
o an
already-existing private fragment in the skbuff.

> The locking is to local_bh_disable(). Does the milliont^w new frag
> allocator have any additional benefits?

It is shareable because it does locking.  Multiple sockets of multiple
protocols can share the pages it has reserved.  It drops the lock around c=
alls
to the page allocator so that GFP_KERNEL/GFP_NOFS can be used with it.

Without this, the page fragment allocator would need to be per-socket, I
think, or be done further up the stack where the higher level drivers woul=
d
have to have a fragment bucket per whatever unit they use to deal with the
lack of locking.

Doing it here makes cleanup simpler since I just transfer my ref on the
fragment to the skbuff frag list and it will automatically be cleaned up w=
ith
the skbuff.

Willy suggested that I just allocate a page for each thing I want to copy,=
 but
I would rather not do that for, say, an 8-byte bit of protocol data.

David

