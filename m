Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E678E7266D3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjFGRLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjFGRLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:11:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0A61FC2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686157813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E/4eS/lJzQiNy8tMpqwPuOfCnp2B44jW2PUSyg6nSfU=;
        b=XCDxYdsHL5jlCXrzQ63i+8mw3z245fziENv2t644LRJRdQmEa6JtZYT4jTn7C6T09odq7+
        OD3PzHl0zgUDWZ+VpnxteQolKWwAKWY2+04ZMb3cAx8umxXcUy+Z6c9vFrfFVi+lNvqmmZ
        575rVfZBnJ/mwoYKt5RBm4uxt6g6CCE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-iNfVzKGiMs6NtphSbkk2cg-1; Wed, 07 Jun 2023 13:10:12 -0400
X-MC-Unique: iNfVzKGiMs6NtphSbkk2cg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B6FF811E7F;
        Wed,  7 Jun 2023 17:10:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 398402166B26;
        Wed,  7 Jun 2023 17:10:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230607160528.20078-1-kuniyu@amazon.com>
References: <20230607160528.20078-1-kuniyu@amazon.com> <20230607140559.2263470-10-dhowells@redhat.com>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     dhowells@redhat.com, axboe@kernel.dk, borisp@nvidia.com,
        chuck.lever@oracle.com, cong.wang@bytedance.com,
        davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        john.fastabend@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, pabeni@redhat.com, tom@herbertland.com,
        tom@quantonium.net, torvalds@linux-foundation.org,
        willemdebruijn.kernel@gmail.com, willy@infradead.org
Subject: Re: [PATCH net-next v5 09/14] kcm: Use splice_eof() to flush
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2288535.1686157805.1@warthog.procyon.org.uk>
Date:   Wed, 07 Jun 2023 18:10:05 +0100
Message-ID: <2288536.1686157805@warthog.procyon.org.uk>
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

Kuniyuki Iwashima <kuniyu@amazon.com> wrote:

> > +	if (skb_queue_empty(&sk->sk_write_queue))
> 
> nit: would be better to use skb_queue_empty_lockless().

Ok.

David

