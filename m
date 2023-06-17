Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4C7733EC8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 08:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjFQGoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 02:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFQGoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 02:44:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F26295E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 23:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686984201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KT3z5MBsLMZkLkeo6Bj0bSQulysSCuM486H4EH/KXBo=;
        b=VRAWhmPyMylPEstOLtaQAjw/lMP4RndNk3TNY4dYL5ih8VrFGP+O1/ztI6vdg2kL1d28/U
        XtOIRQPb4JMFTQ5vM7es9tCwnulREv1rl5efgkcaF36PIbfYMIRZ2SXrsIvPGTK9XjT7RT
        30CIqGetwzgSIzcg3N/VL3YMtYwlR8w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-ZW6hiUcWM0G5bKLmfNojwA-1; Sat, 17 Jun 2023 02:43:18 -0400
X-MC-Unique: ZW6hiUcWM0G5bKLmfNojwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF5773C00086;
        Sat, 17 Jun 2023 06:43:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12E712166B25;
        Sat, 17 Jun 2023 06:43:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZIy82RjpmQMTNafS@corigine.com>
References: <ZIy82RjpmQMTNafS@corigine.com> <20230616161301.622169-1-dhowells@redhat.com> <20230616161301.622169-2-dhowells@redhat.com>
To:     Simon Horman <simon.horman@corigine.com>
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
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH net-next 01/17] net: Copy slab data for sendmsg(MSG_SPLICE_PAGES)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <708509.1686984195.1@warthog.procyon.org.uk>
Date:   Sat, 17 Jun 2023 07:43:15 +0100
Message-ID: <708510.1686984195@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Horman <simon.horman@corigine.com> wrote:

> > +	cache = get_cpu_ptr(&skb_splice_frag_cache);
...
> > +	put_cpu_ptr(skb_splice_frag_cache);
> 
> Hi David,
> 
> I don't think it makes any difference at run-time.
> But to keep Sparse happy, perhaps this ought to be put_cpu_var()

Actually, the problem is a missing "&".  I think I should use put_cpu_ptr() to
match get_cpu_ptr().  It doesn't crash because the argument is ignored.

David

