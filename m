Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F13732C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjFPKAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjFPKAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:00:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF71A30E9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686909569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wfjaC6MUnoKN+p3hX3zNRvhT+UuQZxURXW0656kBJ/E=;
        b=MwEToWAjamXdL/wvoiWIQ6YC0TQJh6HC5ugr7MQ6XUJechGoa02FHbjxzACMr/f8rEYmhG
        xV9gGi+julcB0E6P07/Tjs/iJo7YPHMx/XThPjRa0J1OR1cOT9rRxuRpWcJKfSIkBy4hJ5
        t4ZgZN7A1mlMHf9X3g0IXtn1sIAVg4g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-XEibdNdxP4CBxR5I7g7f6A-1; Fri, 16 Jun 2023 05:59:27 -0400
X-MC-Unique: XEibdNdxP4CBxR5I7g7f6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A05231C0758D;
        Fri, 16 Jun 2023 09:59:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E0DE2166B25;
        Fri, 16 Jun 2023 09:59:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAF=yD-LLCoSTH1Jb+EFmpmTVO+Oo7Hjg6xcF4T2wR96QkjHZRw@mail.gmail.com>
References: <CAF=yD-LLCoSTH1Jb+EFmpmTVO+Oo7Hjg6xcF4T2wR96QkjHZRw@mail.gmail.com> <1410156.1686729856@warthog.procyon.org.uk> <20230615222327.15e85c55@kernel.org>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com, Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org,
        syzbot+d8486855ef44506fd675@syzkaller.appspotmail.com,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ip, ip6: Fix splice to raw and ping sockets
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <424201.1686909563.1@warthog.procyon.org.uk>
Date:   Fri, 16 Jun 2023 10:59:23 +0100
Message-ID: <424202.1686909563@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> Disabling splicing if not ip_generic_getfrag sounds great to me.

I have a patch in the works that passes msghdr through getfrag that allows
this to work if we definitely want to splice into raw and icmp sockets.

David

