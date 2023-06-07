Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA03E7262D7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240953AbjFGObG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240259AbjFGObD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:31:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2344EBA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686148215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4dKRVpJXGIxcDZ6S9HnUKeAF9KTVhi9D43sPUNTGZ3E=;
        b=hxD5xqAklorDdbSPJRnxY6aPr5JhfjXpoIP1KJ9BzKM+1AwIAEh5UAHKcfOZZ24Y9VL2lr
        z//7gmXHuP3qmNVhRRxxA8wAbkb+guW/TyG20lOjrGrVc/KrTJsN3WOIg7/+H9P9FYtZ7m
        +5BBUTysxZUvLTIXZZrcrWiHdN7zvX4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-a1atBA5ROOKUYcmceGoKpA-1; Wed, 07 Jun 2023 10:06:05 -0400
X-MC-Unique: a1atBA5ROOKUYcmceGoKpA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D03A3C0D849;
        Wed,  7 Jun 2023 14:06:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33FCD403367;
        Wed,  7 Jun 2023 14:06:02 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
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
Subject: [PATCH net-next v5 00/14] splice, net: Rewrite splice-to-socket, fix SPLICE_F_MORE and handle MSG_SPLICE_PAGES in AF_TLS
Date:   Wed,  7 Jun 2023 15:05:45 +0100
Message-ID: <20230607140559.2263470-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are patches to do the following:

 (1) Block MSG_SENDPAGE_* flags from leaking into ->sendmsg() from
     userspace, whilst allowing splice_to_socket() to pass them in.

 (2) Allow MSG_SPLICE_PAGES to be passed into tls_*_sendmsg().  Until
     support is added, it will be ignored and a splice-driven sendmsg()
     will be treated like a normal sendmsg().  TCP, UDP, AF_UNIX and
     Chelsio-TLS already handle the flag in net-next.

 (3) Replace a chain of functions to splice-to-sendpage with a single
     function to splice via sendmsg() with MSG_SPLICE_PAGES.  This allows a
     bunch of pages to be spliced from a pipe in a single call using a
     bio_vec[] and pushes the main processing loop down into the bowels of
     the protocol driver rather than repeatedly calling in with a page at a
     time.

 (4) Provide a ->splice_eof() op[2] that allows splice to signal to its
     output that the input observed a premature EOF and that the caller
     didn't flag SPLICE_F_MORE, thereby allowing a corked socket to be
     flushed.  This attempts to maintain the current behaviour.  It is also
     not called if we didn't manage to read any data and so didn't called
     the actor function.

     This needs routing though several layers to get it down to the network
     protocol.

     [!] Note that I chose not to pass in any flags - I'm not sure it's
     	 particularly useful to pass in the splice flags; I also elected
     	 not to return any error code - though we might actually want to do
     	 that.

 (5) Provide tls_{device,sw}_splice_eof() to flush a pending TLS record if
     there is one.

 (6) Provide splice_eof() for UDP, TCP, Chelsio-TLS and AF_KCM.  AF_UNIX
     doesn't seem to pay attention to the MSG_MORE or MSG_SENDPAGE_NOTLAST
     flags.

 (7) Alter the behaviour of sendfile() and fix SPLICE_F_MORE/MSG_MORE
     signalling[1] such SPLICE_F_MORE is always signalled until we have
     read sufficient data to finish the request.  If we get a zero-length
     before we've managed to splice sufficient data, we now leave the
     socket expecting more data and leave it to userspace to deal with it.

 (8) Make AF_TLS handle the MSG_SPLICE_PAGES internal sendmsg flag.
     MSG_SPLICE_PAGES is an internal hint that tells the protocol that it
     should splice the pages supplied if it can.  Its sendpage
     implementations are then turned into wrappers around that.


I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=sendpage-2-tls

David

Changes
=======
ver #5)
 - In splice_to_socket(), preclear ret in case len == 0.
 - Provide ->splice_eof() for UDP, TCP, Chelsio-TLS and AF_KCM.

ver #4)
 - Switch to using ->splice_eof() to signal premature EOF to the splice
   output[2].

ver #3)
 - Include the splice-to-socket rewrite patch.
 - Fix SPLICE_F_MORE/MSG_MORE signalling.
 - Allow AF_TLS to accept sendmsg() with MSG_SPLICE_PAGES before it is
   handled.
 - Allow a zero-length send() to a TLS socket to flush an outstanding
   record.
 - Address TLS kselftest failure.

ver #2)
 - Dropped the slab data copying.
 - "rls_" should be "tls_".
 - Attempted to fix splice_direct_to_actor().
 - Blocked MSG_SENDPAGE_* from being set by userspace.

Link: https://lore.kernel.org/r/499791.1685485603@warthog.procyon.org.uk/ [1]
Link: https://lore.kernel.org/r/CAHk-=wh=V579PDYvkpnTobCLGczbgxpMgGmmhqiTyE34Cpi5Gg@mail.gmail.com/ [2]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=51c78a4d532efe9543a4df019ff405f05c6157f6 # part 1
Link: https://lore.kernel.org/r/20230524153311.3625329-1-dhowells@redhat.com/ # v1

David Howells (14):
  net: Block MSG_SENDPAGE_* from being passed to sendmsg() by userspace
  tls: Allow MSG_SPLICE_PAGES but treat it as normal sendmsg
  splice, net: Use sendmsg(MSG_SPLICE_PAGES) rather than ->sendpage()
  splice, net: Add a splice_eof op to file-ops and socket-ops
  tls/sw: Use splice_eof() to flush
  tls/device: Use splice_eof() to flush
  ipv4, ipv6: Use splice_eof() to flush
  chelsio/chtls: Use splice_eof() to flush
  kcm: Use splice_eof() to flush
  splice, net: Fix SPLICE_F_MORE signalling in splice_direct_to_actor()
  tls/sw: Support MSG_SPLICE_PAGES
  tls/sw: Convert tls_sw_sendpage() to use MSG_SPLICE_PAGES
  tls/device: Support MSG_SPLICE_PAGES
  tls/device: Convert tls_device_sendpage() to use MSG_SPLICE_PAGES

 .../chelsio/inline_crypto/chtls/chtls.h       |   1 +
 .../chelsio/inline_crypto/chtls/chtls_io.c    |   9 +
 .../chelsio/inline_crypto/chtls/chtls_main.c  |   1 +
 fs/splice.c                                   | 207 +++++++++++---
 include/linux/fs.h                            |   3 +-
 include/linux/net.h                           |   1 +
 include/linux/socket.h                        |   4 +-
 include/linux/splice.h                        |   3 +
 include/net/inet_common.h                     |   1 +
 include/net/sock.h                            |   1 +
 include/net/tcp.h                             |   1 +
 include/net/udp.h                             |   1 +
 net/ipv4/af_inet.c                            |  18 ++
 net/ipv4/tcp.c                                |  16 ++
 net/ipv4/tcp_ipv4.c                           |   1 +
 net/ipv4/udp.c                                |  16 ++
 net/ipv6/af_inet6.c                           |   1 +
 net/ipv6/tcp_ipv6.c                           |   1 +
 net/ipv6/udp.c                                |  18 ++
 net/kcm/kcmsock.c                             |  15 ++
 net/socket.c                                  |  36 +--
 net/tls/tls.h                                 |   2 +
 net/tls/tls_device.c                          | 110 ++++----
 net/tls/tls_main.c                            |   4 +
 net/tls/tls_sw.c                              | 253 ++++++++++--------
 25 files changed, 485 insertions(+), 239 deletions(-)

