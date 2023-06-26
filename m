Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA4873E5B5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjFZQsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjFZQsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:48:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE79E58
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687798049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fp7NYqoM5z0bSwzLsBWghLbX9STVi+P7gOwNpkntF38=;
        b=D2IZ8ka/9jnKvM8P8vXbhsF/Gv19ljq/Q2UWfDjp2KwCDWYUIiEr63PpkLZ37urESbQp2I
        +qmhAHh+gLHgqVEy5nGEUuxPjVzpSvSR0Wzsmz76oa6J3YKaT01DCNweQpweYwGmdqLp8u
        qWkUF5mV0amsJ/gqvfGTS1x922ZyohU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-Aud61ZMvNmehWcwn64FoYg-1; Mon, 26 Jun 2023 12:46:53 -0400
X-MC-Unique: Aud61ZMvNmehWcwn64FoYg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C31088CC42;
        Mon, 26 Jun 2023 16:44:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89B0A400F5A;
        Mon, 26 Jun 2023 16:44:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOi1vP8AyL=nsqDw-QKjPsC8wMsEnq+hSh29PobADYLm-L9ZNg@mail.gmail.com>
References: <CAOi1vP8AyL=nsqDw-QKjPsC8wMsEnq+hSh29PobADYLm-L9ZNg@mail.gmail.com> <20230623225513.2732256-1-dhowells@redhat.com> <20230623225513.2732256-4-dhowells@redhat.com> <CAOi1vP9vjLfk3W+AJFeexC93jqPaPUn2dD_4NrzxwoZTbYfOnw@mail.gmail.com> <3068221.1687788027@warthog.procyon.org.uk>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Subject: Re: [PATCH net-next v5 03/16] ceph: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3084678.1687797883.1@warthog.procyon.org.uk>
Date:   Mon, 26 Jun 2023 17:44:43 +0100
Message-ID: <3084679.1687797883@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

Ilya Dryomov <idryomov@gmail.com> wrote:

> > This is now committed to net-next.
> 
> This needs to be dropped from linux-next because both this and
> especially the other (net/ceph/messenger_v2.c) patch introduce
> regressions.

net-next, not linux-next.  I'm not sure they drop things from there rather
than reverting them.

David

