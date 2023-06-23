Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79B373BF0A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 21:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjFWToo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 15:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFWTon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 15:44:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4276B2705
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 12:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687549434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BybjfG9PIBiqP0H/EMXr01t+EtZxTWT+jQSFanPQg3I=;
        b=PdhDg3oszTLnnAsVzhy/DzfztBp0SYaPuPUPdTbBuXGXtGO15DZ620u46jAJZ6XtRwRthF
        3aJbjgoIXkTLEJiSVwzf4AY/YzVkMXKcyVmwTdT0LZa5fSdOmp11sz4Zy+MQtz7H3diHiD
        yj2w7k792SItMhAQVaGiuUjLRd3BdTk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-QaxqV_GGPc-UL_KKq1DTLg-1; Fri, 23 Jun 2023 15:43:46 -0400
X-MC-Unique: QaxqV_GGPc-UL_KKq1DTLg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BDBF835262;
        Fri, 23 Jun 2023 19:43:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF0B4207B2BC;
        Fri, 23 Jun 2023 19:43:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230623100040.4ebbeeb2@kernel.org>
References: <20230623100040.4ebbeeb2@kernel.org> <20230623114425.2150536-1-dhowells@redhat.com> <20230623114425.2150536-4-dhowells@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        ceph-devel@vger.kernel.org
Subject: Re: [PATCH net-next v4 03/15] ceph: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2611114.1687549406.1@warthog.procyon.org.uk>
Date:   Fri, 23 Jun 2023 20:43:26 +0100
Message-ID: <2611115.1687549406@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

> >  		if (length == cursor->total_resid)
> > -			more = MSG_MORE;
> > -		ret = ceph_tcp_sendpage(con->sock, page, page_offset, length,
> > -					more);
> > +			msghdr.msg_flags |= MSG_MORE;
> 
> Should the condition also be flipped here, like you did below?
> (can be a follow up if so)

Yeah - the "==" in the if-statement needs flipping to "!=".  I can send a
follow-up patch for it or respin if you prefer.

David

