Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8725720575
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbjFBPIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbjFBPIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830BD136
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685718484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=z63L2vi8cak2/v6n5QmH0cCWe2aDh0Ir21QTFKTQsGs=;
        b=ZRcYpr4hgbPBYR+5gAp87Y/wclj9HstN7E2V7euH3zPwwyhN3H0t5nPyGkmdbKhqVnxgY7
        rk+7oscu044oUqXUXtOAzvkYu2E4GYTnunbtyz03KaznoMFC1pRcdO3XfES0nteI8d7D7R
        fF47o1AcdzE7XPvNDyArq562kEJMhLc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-1kRgGqq9PU6KXfpvdf7AVg-1; Fri, 02 Jun 2023 11:07:59 -0400
X-MC-Unique: 1kRgGqq9PU6KXfpvdf7AVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC2A9185A7AB;
        Fri,  2 Jun 2023 15:07:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47A892166B25;
        Fri,  2 Jun 2023 15:07:55 +0000 (UTC)
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
Subject: [PATCH net-next v3 00/11] splice, net: Rewrite splice-to-socket, fix SPLICE_F_MORE and handle MSG_SPLICE_PAGES in AF_TLS
Date:   Fri,  2 Jun 2023 16:07:41 +0100
Message-ID: <20230602150752.1306532-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

 (3) Allow tls/sw to be given a zero-length send()/sendto()/sendmsg()
     without MSG_MORE set to allow userspace ot flush the pending record.

 (4) Replace a chain of functions to splice-to-sendpage with a single
     function to splice via sendmsg() with MSG_SPLICE_PAGES.  This allows a
     bunch of pages to be spliced from a pipe in a single call using a
     bio_vec[] and pushes the main processing loop down into the bowels of
     the protocol driver rather than repeatedly calling in with a page at a
     time.

 (5) Alter the behaviour of sendfile() and fix SPLICE_F_MORE/MSG_MORE
     signalling[1] such SPLICE_F_MORE is always signalled until we have
     read sufficient data to finish the request.  If we get a zero-length
     before we've managed to splice sufficient data, we now leave the
     socket expecting more data and leave it to userspace to deal with it.

 (6) Address the now failing TLS multi_chunk_sendfile kselftest by putting
     in a zero-length send() to end the record.

 (7) Make AF_TLS handle the MSG_SPLICE_PAGES internal sendmsg flag.
     MSG_SPLICE_PAGES is an internal hint that tells the protocol that it
     should splice the pages supplied if it can.  Its sendpage
     implementations are then turned into wrappers around that.

 (8) Provide some sample programs for driving AF_ALG (hash & encrypt), TCP,
     TLS, UDP and AF_UNIX.

Here are some simple timings, taking the best timing for each out of
several runs.  In the following table, samples added in the last patch were
used for the first five columns and the tls kselftest for the last:

	Patches	unix-	tcp-send	tls-send	tls
		   send					kselftest
			10G	lo	10G	lo
	=======	=======	=======	=======	=======	=======	=======
	none	0.516	0.469	0.492	3.121	3.082	1.152
	splice	0.470	0.452	0.471	3.074	3.041	0.294
	all	0.469	0.440	0.475	3.077	3.041	0.345

the times are all in seconds.  The "none" row is with none of the patches
applied; "splice" is up to the splice-to-sendpage replacement; and "all" is
with all the patches applied.  The "10G" column is going to a server on a
different box by 10G ethernet and the "lo" column is going to a server on
the same box by the loopback device.

I think the apparent improvement is from cutting out a layer in the splice
stack and pushing more than one page in a single sendmsg.  The improvement
in the tls selftest column is particularly marked.

The following sample and selftest commands were used:
	unix-sink /tmp/sock &		# server
	unix-send -ds 256M /tmp/sock	# client
	tcp-sink &			# server
	tcp-send -ds 256M 127.0.0.1	# client - loopback
	tcp-send -ds 256M 192.168.6.1	# client - 10G ethernet
	tls-sink &			# server
	tls-send -ds 256M 127.0.0.1	# client - loopback
	tls-send -ds 256M 192.168.6.1	# client - 10G ethernet
	tls -r tls.12_aes_gcm.multi_chunk_sendfile

where 256M is a 256MiB file to be read in its entirety unless otherwise
specified, -d indicates O_DIRECT and -s asks for splice (if input is a
pipe) or sendfile (if input not a pipe) to be used.


I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=sendpage-2-tls

David

Changes
=======
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
Link: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=51c78a4d532efe9543a4df019ff405f05c6157f6 # part 1
Link: https://lore.kernel.org/r/20230524153311.3625329-1-dhowells@redhat.com/ # v1

David Howells (11):
  net: Block MSG_SENDPAGE_* from being passed to sendmsg() by userspace
  tls: Allow MSG_SPLICE_PAGES but treat it as normal sendmsg
  tls/sw: Use zero-length sendmsg() without MSG_MORE to flush
  splice, net: Use sendmsg(MSG_SPLICE_PAGES) rather than ->sendpage()
  splice, net: Fix SPLICE_F_MORE signalling in splice_direct_to_actor()
  tls: Address behaviour change in multi_chunk_sendfile kselftest
  tls/sw: Support MSG_SPLICE_PAGES
  tls/sw: Convert tls_sw_sendpage() to use MSG_SPLICE_PAGES
  tls/device: Support MSG_SPLICE_PAGES
  tls/device: Convert tls_device_sendpage() to use MSG_SPLICE_PAGES
  net: Add samples for network I/O and splicing

 fs/splice.c                       | 176 ++++++++++++++++++------
 include/linux/fs.h                |   2 -
 include/linux/socket.h            |   4 +-
 include/linux/splice.h            |   2 +
 net/socket.c                      |  26 +---
 net/tls/tls_device.c              |  97 ++++++-------
 net/tls/tls_sw.c                  | 217 +++++++++++-------------------
 samples/Kconfig                   |  14 ++
 samples/Makefile                  |   1 +
 samples/net/Makefile              |  13 ++
 samples/net/alg-encrypt.c         | 206 ++++++++++++++++++++++++++++
 samples/net/alg-hash.c            | 147 ++++++++++++++++++++
 samples/net/splice-out.c          | 147 ++++++++++++++++++++
 samples/net/tcp-send.c            | 177 ++++++++++++++++++++++++
 samples/net/tcp-sink.c            |  80 +++++++++++
 samples/net/tls-send.c            | 188 ++++++++++++++++++++++++++
 samples/net/tls-sink.c            | 104 ++++++++++++++
 samples/net/udp-send.c            | 156 +++++++++++++++++++++
 samples/net/udp-sink.c            |  84 ++++++++++++
 samples/net/unix-send.c           | 151 +++++++++++++++++++++
 samples/net/unix-sink.c           |  54 ++++++++
 tools/testing/selftests/net/tls.c |   6 +-
 22 files changed, 1792 insertions(+), 260 deletions(-)
 create mode 100644 samples/net/Makefile
 create mode 100644 samples/net/alg-encrypt.c
 create mode 100644 samples/net/alg-hash.c
 create mode 100644 samples/net/splice-out.c
 create mode 100644 samples/net/tcp-send.c
 create mode 100644 samples/net/tcp-sink.c
 create mode 100644 samples/net/tls-send.c
 create mode 100644 samples/net/tls-sink.c
 create mode 100644 samples/net/udp-send.c
 create mode 100644 samples/net/udp-sink.c
 create mode 100644 samples/net/unix-send.c
 create mode 100644 samples/net/unix-sink.c

