Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C946872F0C2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 02:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbjFNAAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 20:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjFNAAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 20:00:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DA5E5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 16:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686700796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gn8GRtspoLrOWgDx0Lu+JWveuP9Whv2Jn+BImtNwvwA=;
        b=baFayY/9d4HFjv7XU6WKOnHqWqumkeSkzG29h7k8HrzJ/iKMnFD5w0qAeDmqbf0B6dhtQX
        KqT9uQewoBYQkIdJjA3X0A3pokXJJdmz98MU1PlwzCZHiboZLgCpA8/ebh1ZpjGbp0zHEL
        IYUTTaOCWcj8/EK7kMRnEgvF66AcQ+A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-bjQJCsS8Pl6JbBA_CUV8tQ-1; Tue, 13 Jun 2023 19:59:51 -0400
X-MC-Unique: bjQJCsS8Pl6JbBA_CUV8tQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C471F80231B;
        Tue, 13 Jun 2023 23:59:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A6B510BDF;
        Tue, 13 Jun 2023 23:59:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000ae4cbf05fdeb8349@google.com>
References: <000000000000ae4cbf05fdeb8349@google.com>
To:     syzbot <syzbot+d8486855ef44506fd675@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, bpf@vger.kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: stack-out-of-bounds Read in skb_splice_from_iter
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1394610.1686700788.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 14 Jun 2023 00:59:48 +0100
Message-ID: <1394611.1686700788@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.g=
it main

commit b49195695a78f1fb56ecbfd3c3fd14dbe6844088
Author: David Howells <dhowells@redhat.com>
Date:   Wed Jun 14 00:14:32 2023 +0100

    ip, ip6: Handle splice to raw and ping sockets
    =

    Splicing to SOCK_RAW sockets may set MSG_SPLICE_PAGES, but in such a c=
ase,
    __ip_append_data() will call skb_splice_from_iter() to access the 'fro=
m'
    data, assuming it to point to a msghdr struct with an iter, instead of
    using the provided getfrag function to access it.
    =

    In the case of raw_sendmsg(), however, this is not the case and 'from'=
 will
    point to a raw_frag_vec struct and raw_getfrag() will be the frag-gett=
ing
    function.  A similar issue may occur with rawv6_sendmsg().
    =

    Fix this by ignoring MSG_SPLICE_PAGES if getfrag !=3D ip_generic_getfr=
ag as
    ip_generic_getfrag() expects "from" to be a msghdr*, but the other get=
frags
    don't.  Note that this will prevent MSG_SPLICE_PAGES from being effect=
ive
    for udplite.
    =

    This likely affects ping sockets too.  udplite looks like it should be=
 okay
    as it expects "from" to be a msghdr.
    =

    Signed-off-by: David Howells <dhowells@redhat.com>
    Reported-by: syzbot+d8486855ef44506fd675@syzkaller.appspotmail.com
    Link: https://lore.kernel.org/r/000000000000ae4cbf05fdeb8349@google.co=
m/
    Fixes: 2dc334f1a63a ("splice, net: Use sendmsg(MSG_SPLICE_PAGES) rathe=
r than ->sendpage()")
    cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
    cc: David Ahern <dsahern@kernel.org>
    cc: "David S. Miller" <davem@davemloft.net>
    cc: Eric Dumazet <edumazet@google.com>
    cc: Jakub Kicinski <kuba@kernel.org>
    cc: Paolo Abeni <pabeni@redhat.com>
    cc: Jens Axboe <axboe@kernel.dk>
    cc: Matthew Wilcox <willy@infradead.org>
    cc: netdev@vger.kernel.org

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 244fb9365d87..4b39ea99f00b 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1040,7 +1040,8 @@ static int __ip_append_data(struct sock *sk,
 	} else if ((flags & MSG_SPLICE_PAGES) && length) {
 		if (inet->hdrincl)
 			return -EPERM;
-		if (rt->dst.dev->features & NETIF_F_SG)
+		if (rt->dst.dev->features & NETIF_F_SG &&
+		    getfrag =3D=3D ip_generic_getfrag)
 			/* We need an empty buffer to attach stuff to */
 			paged =3D true;
 		else
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index c722cb881b2d..dd845139882c 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1592,7 +1592,8 @@ static int __ip6_append_data(struct sock *sk,
 	} else if ((flags & MSG_SPLICE_PAGES) && length) {
 		if (inet_sk(sk)->hdrincl)
 			return -EPERM;
-		if (rt->dst.dev->features & NETIF_F_SG)
+		if (rt->dst.dev->features & NETIF_F_SG &&
+		    getfrag =3D=3D ip_generic_getfrag)
 			/* We need an empty buffer to attach stuff to */
 			paged =3D true;
 		else

