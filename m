Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57146722AA4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbjFEPOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjFEPNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:13:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637A01A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685977919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7+4neYa+KPrHcno9XIjF3OujcOMhzN8ihQFE0Ns9n7U=;
        b=caqN73YA+JRAiX+89yLx32ggRo6f8KDLIu6Rh1xMbnmG2iEEnzFE5J//JmSrNs5VzwJzde
        Jg0b6py4USvnfGfWuvaT7r5IJDPbWfPzhItfptD78baT4imoQNkm9q1xFsmfEO71GaYtJU
        QCn1EaNlDDAukUiHc0WMuZdGxaVIkN8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-7F3PerAVOMir1dYQzXhJMg-1; Mon, 05 Jun 2023 11:11:55 -0400
X-MC-Unique: 7F3PerAVOMir1dYQzXhJMg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F28091034AAA;
        Mon,  5 Jun 2023 15:10:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0FDC2166B25;
        Mon,  5 Jun 2023 15:10:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZH32Jp1Iop8FaDtC@corigine.com>
References: <ZH32Jp1Iop8FaDtC@corigine.com> <20230605124600.1722160-1-dhowells@redhat.com> <20230605124600.1722160-4-dhowells@redhat.com>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 03/11] splice, net: Use sendmsg(MSG_SPLICE_PAGES) rather than ->sendpage()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1729073.1685977857.1@warthog.procyon.org.uk>
Date:   Mon, 05 Jun 2023 16:10:57 +0100
Message-ID: <1729074.1685977857@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Horman <simon.horman@corigine.com> wrote:

> I'm assuming the answer is that this cannot occur,
> but I thought I should mention this anyway.
> 
> If the initial value of len is 0 (or less).
> ...
> > +	return spliced ?: ret;
> 
> Then ret will be used uninitialised here.

len shouldn't be <0 as it's size_t.

I don't think it should be possible to get there with len==0 - at least from
userspace.  sys_splice() returns immediately and sys_sendfile() either splices
to a pipe or goes via splice_direct_to_actor() will just drop straight out.
But there are kernel users - nfsd for example - but I don't know if they would
splice directly to a socket.

That said, it's probably worth preclearing ret just to be sure.

David

