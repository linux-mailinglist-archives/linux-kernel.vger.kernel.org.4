Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F7172F74E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjFNIF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243677AbjFNIFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64A91FDB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686729863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AdExDkio2IavDiEBIZ3Za2q9aIwRCw4IZu4sfOZDrT0=;
        b=HPTXjx+KDsQIRVDYcZQCobrVp9k0HiFyCxANsrScJidoq/i7Thk4No6s/2odYBpzOOVHrm
        oUoYjt0Y4l0Hp84+SOjgrHNtO+A7wOM0rJCTjh8KN7Z9txKIND/8gtQ23HngrcoBkYnVgs
        TzKt6g1qRY7zmrLkF9wzWjDMt2W5WO8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-ikdS9KTKNjSb28DFQ4X47Q-1; Wed, 14 Jun 2023 04:04:19 -0400
X-MC-Unique: ikdS9KTKNjSb28DFQ4X47Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5793810BB3;
        Wed, 14 Jun 2023 08:04:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 080E740C6F5C;
        Wed, 14 Jun 2023 08:04:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
cc:     dhowells@redhat.com,
        syzbot+d8486855ef44506fd675@syzkaller.appspotmail.com,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] ip, ip6: Fix splice to raw and ping sockets
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1410155.1686729856.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 14 Jun 2023 09:04:16 +0100
Message-ID: <1410156.1686729856@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    =

Splicing to SOCK_RAW sockets may set MSG_SPLICE_PAGES, but in such a case,
__ip_append_data() will call skb_splice_from_iter() to access the 'from'
data, assuming it to point to a msghdr struct with an iter, instead of
using the provided getfrag function to access it.

In the case of raw_sendmsg(), however, this is not the case and 'from' wil=
l
point to a raw_frag_vec struct and raw_getfrag() will be the frag-getting
function.  A similar issue may occur with rawv6_sendmsg().

Fix this by ignoring MSG_SPLICE_PAGES if getfrag !=3D ip_generic_getfrag a=
s
ip_generic_getfrag() expects "from" to be a msghdr*, but the other getfrag=
s
don't.  Note that this will prevent MSG_SPLICE_PAGES from being effective
for udplite.

This likely affects ping sockets too.  udplite looks like it should be oka=
y
as it expects "from" to be a msghdr.

Signed-off-by: David Howells <dhowells@redhat.com>
Reported-by: syzbot+d8486855ef44506fd675@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/000000000000ae4cbf05fdeb8349@google.com/
Fixes: 2dc334f1a63a ("splice, net: Use sendmsg(MSG_SPLICE_PAGES) rather th=
an ->sendpage()")
Tested-by: syzbot+d8486855ef44506fd675@syzkaller.appspotmail.com
cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
cc: David Ahern <dsahern@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
---
 net/ipv4/ip_output.c  |    3 ++-
 net/ipv6/ip6_output.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

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

