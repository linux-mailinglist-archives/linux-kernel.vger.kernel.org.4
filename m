Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93A4717ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjEaIxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbjEaIw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81E9124
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685523120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WGo4qtRQ4pkJVWaEUVypZ+1I1vSFSgJTj8gN/jNbr24=;
        b=gdIAnc/w2P6UWFdUZ+zqkF6egz/AAl0gKEF2kl0Q4TIoCpbkLGtzxhvTDz7XQJUI6ebrqR
        gPnLIrDEj+7UZhnFLys+3qYwmlFHsp5XGAm/cQDGO1HmP2DlHp5XmAAkbfhY9F+4aH1aA5
        Uam+Cno+V7OV02Nb36rswnCI0AIsW7s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-6A7MVqTQNyGeS8sO5Uaxog-1; Wed, 31 May 2023 04:51:57 -0400
X-MC-Unique: 6A7MVqTQNyGeS8sO5Uaxog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD993280BC41;
        Wed, 31 May 2023 08:51:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FE4B40E6A43;
        Wed, 31 May 2023 08:51:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230526201202.1cd35fe9@kernel.org>
References: <20230526201202.1cd35fe9@kernel.org> <20230524144923.3623536-1-dhowells@redhat.com> <20230524144923.3623536-4-dhowells@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tom Herbert <tom@herbertland.com>,
        Tom Herbert <tom@quantonium.net>
Subject: Re: [PATCH net-next 3/4] kcm: Support MSG_SPLICE_PAGES
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <574369.1685523113.1@warthog.procyon.org.uk>
Date:   Wed, 31 May 2023 09:51:53 +0100
Message-ID: <574370.1685523113@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 24 May 2023 15:49:22 +0100 David Howells wrote:
> > +			err = skb_splice_from_iter(skb, &msg->msg_iter, copy,
> > +						   sk->sk_allocation);
> > +			if (err < 0) {
> > +				if (err == -EMSGSIZE)
> > +					goto wait_for_memory;
> > +				goto out_error;
> > +			}
> >  
> 
> should there be a:
> 
> 		copy = err;
> or:
> 		copy -= msg_data_left(msg);
> 
> or some such here? Can we safely assume that skb_splice_from_iter() will
> copy all or nothing? 

Yeah.  Good point.  I didn't add one because the normal operation code doesn't
do that - but I guess that's all-or-nothing.

David

