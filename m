Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE7073B682
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjFWLp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjFWLpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:45:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E3019A1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687520673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KlEQlnpOjZiSHUS7OxgI6wZGWzaJEkPBvY7BF7ShyJU=;
        b=eLnX48nx5uh4NKNDjWnhtgeL3AmMcXdBiZXzboFsMizjnnmA3F4r4+Z3n+diqQefN10qIR
        1RIbaGjodp/5Q3dJYZFUpNUy/s/l+BbrwN5vwyBlxqmd10JaXcnxfux3sQG1XQ9+ypIV1y
        EHvtth3Peoa0JBRrpBfHVF6f27L9Pkc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-Pk1hBEtjO36qplPUo1NwqA-1; Fri, 23 Jun 2023 07:44:30 -0400
X-MC-Unique: Pk1hBEtjO36qplPUo1NwqA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3DD5185A792;
        Fri, 23 Jun 2023 11:44:29 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E8532166B25;
        Fri, 23 Jun 2023 11:44:28 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 00/15] splice, net: Switch over users of sendpage() and remove it
Date:   Fri, 23 Jun 2023 12:44:10 +0100
Message-ID: <20230623114425.2150536-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

Here's the final set of patches towards the removal of sendpage.  All the
drivers that use sendpage() get switched over to using sendmsg() with
MSG_SPLICE_PAGES.

The following changes are made:

 (1) Make the protocol drivers behave according to MSG_MORE, not
     MSG_SENDPAGE_NOTLAST.  The latter is restricted to turning on MSG_MORE
     in the sendpage() wrappers.

 (2) Fix ocfs2 to allocate its global protocol buffers with folio_alloc()
     rather than kzalloc() so as not to invoke the !sendpage_ok warning in
     skb_splice_from_iter().

 (3) Make ceph/rds, skb_send_sock, dlm, nvme, smc, ocfs2, drbd and iscsi
     use sendmsg(), not sendpage and make them specify MSG_MORE instead of
     MSG_SENDPAGE_NOTLAST.

 (4) Kill off sendpage and clean up MSG_SENDPAGE_NOTLAST.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=sendpage-3-killsb

David

Changes
=======
ver #4)
 - Drop the copy-slab-to-fragment code from skb_splice_from_iter().
 - Slim down the driver changes to only do one page at a time.
 - Drop the siw and drbd page aggregation single-sendmsg patches.
 - Make nvme/host cancel MSG_SPLICE_PAGES if !sendpage_ok.
 - Break out the ocfs2 protocol buffer allocation fix into its own patch.
 - Simplify the ocfs2 protocol data transmission.

ver #3)
 - Remove duplicate decl of skb_splice_from_iter().
 - In tcp_bpf, reset msg_flags on each iteration to clear MSG_MORE.
 - In tcp_bpf, set MSG_MORE if there's more data in the sk_msg.
 - Split the nvme patch into host and target patches.

ver #2)
 - Wrapped some lines at 80.
 - Fixed parameter to put_cpu_ptr() to have an '&'.
 - Use "unsigned int" rather than "unsigned".
 - Removed duplicate word in comment.
 - Filled in the commit message on the last patch.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=51c78a4d532efe9543a4df019ff405f05c6157f6 # part 1
Link: https://lore.kernel.org/r/20230616161301.622169-1-dhowells@redhat.com/ # v1
Link: https://lore.kernel.org/r/20230617121146.716077-1-dhowells@redhat.com/ # v2
Link: https://lore.kernel.org/r/20230620145338.1300897-1-dhowells@redhat.com/ # v3





David Howells (15):
  tcp_bpf, smc, tls, espintcp, siw: Reduce MSG_SENDPAGE_NOTLAST usage
  net: Use sendmsg(MSG_SPLICE_PAGES) not sendpage in skb_send_sock()
  ceph: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
  ceph: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage()
  rds: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
  dlm: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
  nvme-tcp: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
  nvmet-tcp: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
  smc: Drop smc_sendpage() in favour of smc_sendmsg() + MSG_SPLICE_PAGES
  drbd: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage()
  iscsi: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
  ocfs2: Fix use of slab data with sendpage
  ocfs2: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage()
  sock: Remove ->sendpage*() in favour of sendmsg(MSG_SPLICE_PAGES)
  net: Kill MSG_SENDPAGE_NOTLAST

 Documentation/bpf/map_sockmap.rst             | 10 +-
 Documentation/filesystems/locking.rst         |  2 -
 Documentation/filesystems/vfs.rst             |  1 -
 Documentation/networking/scaling.rst          |  4 +-
 crypto/af_alg.c                               | 28 ------
 crypto/algif_aead.c                           | 22 +----
 crypto/algif_rng.c                            |  2 -
 crypto/algif_skcipher.c                       | 14 ---
 drivers/block/drbd/drbd_main.c                | 12 ++-
 drivers/infiniband/sw/siw/siw_qp_tx.c         |  5 +-
 .../chelsio/inline_crypto/chtls/chtls.h       |  2 -
 .../chelsio/inline_crypto/chtls/chtls_io.c    | 14 ---
 .../chelsio/inline_crypto/chtls/chtls_main.c  |  1 -
 drivers/nvme/host/tcp.c                       | 49 +++++-----
 drivers/nvme/target/tcp.c                     | 46 ++++++----
 drivers/scsi/iscsi_tcp.c                      | 26 ++----
 drivers/scsi/iscsi_tcp.h                      |  2 -
 drivers/target/iscsi/iscsi_target_util.c      | 15 +--
 fs/dlm/lowcomms.c                             | 10 +-
 fs/nfsd/vfs.c                                 |  2 +-
 fs/ocfs2/cluster/tcp.c                        | 38 ++++----
 include/crypto/if_alg.h                       |  2 -
 include/linux/net.h                           |  8 --
 include/linux/socket.h                        |  4 +-
 include/net/inet_common.h                     |  2 -
 include/net/sock.h                            |  6 --
 include/net/tcp.h                             |  4 -
 net/appletalk/ddp.c                           |  1 -
 net/atm/pvc.c                                 |  1 -
 net/atm/svc.c                                 |  1 -
 net/ax25/af_ax25.c                            |  1 -
 net/caif/caif_socket.c                        |  2 -
 net/can/bcm.c                                 |  1 -
 net/can/isotp.c                               |  1 -
 net/can/j1939/socket.c                        |  1 -
 net/can/raw.c                                 |  1 -
 net/ceph/messenger_v1.c                       | 58 ++++--------
 net/ceph/messenger_v2.c                       | 91 ++++---------------
 net/core/skbuff.c                             | 50 +++++-----
 net/core/sock.c                               | 35 +------
 net/dccp/ipv4.c                               |  1 -
 net/dccp/ipv6.c                               |  1 -
 net/ieee802154/socket.c                       |  2 -
 net/ipv4/af_inet.c                            | 21 -----
 net/ipv4/tcp.c                                | 43 +--------
 net/ipv4/tcp_bpf.c                            | 28 +-----
 net/ipv4/tcp_ipv4.c                           |  1 -
 net/ipv4/udp.c                                | 15 ---
 net/ipv4/udp_impl.h                           |  2 -
 net/ipv4/udplite.c                            |  1 -
 net/ipv6/af_inet6.c                           |  3 -
 net/ipv6/raw.c                                |  1 -
 net/ipv6/tcp_ipv6.c                           |  1 -
 net/kcm/kcmsock.c                             | 20 ----
 net/key/af_key.c                              |  1 -
 net/l2tp/l2tp_ip.c                            |  1 -
 net/l2tp/l2tp_ip6.c                           |  1 -
 net/llc/af_llc.c                              |  1 -
 net/mctp/af_mctp.c                            |  1 -
 net/mptcp/protocol.c                          |  2 -
 net/netlink/af_netlink.c                      |  1 -
 net/netrom/af_netrom.c                        |  1 -
 net/packet/af_packet.c                        |  2 -
 net/phonet/socket.c                           |  2 -
 net/qrtr/af_qrtr.c                            |  1 -
 net/rds/af_rds.c                              |  1 -
 net/rds/tcp_send.c                            | 23 ++---
 net/rose/af_rose.c                            |  1 -
 net/rxrpc/af_rxrpc.c                          |  1 -
 net/sctp/protocol.c                           |  1 -
 net/smc/af_smc.c                              | 29 ------
 net/smc/smc_stats.c                           |  2 +-
 net/smc/smc_stats.h                           |  1 -
 net/smc/smc_tx.c                              | 19 +---
 net/smc/smc_tx.h                              |  2 -
 net/socket.c                                  | 48 ----------
 net/tipc/socket.c                             |  3 -
 net/tls/tls.h                                 |  6 --
 net/tls/tls_device.c                          | 24 +----
 net/tls/tls_main.c                            |  9 +-
 net/tls/tls_sw.c                              | 37 +-------
 net/unix/af_unix.c                            | 19 ----
 net/vmw_vsock/af_vsock.c                      |  3 -
 net/x25/af_x25.c                              |  1 -
 net/xdp/xsk.c                                 |  1 -
 net/xfrm/espintcp.c                           | 10 +-
 .../perf/trace/beauty/include/linux/socket.h  |  1 -
 tools/perf/trace/beauty/msg_flags.c           |  5 +-
 88 files changed, 229 insertions(+), 747 deletions(-)

