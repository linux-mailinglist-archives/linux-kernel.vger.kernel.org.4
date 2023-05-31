Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A2171802B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbjEaMqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjEaMqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:46:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B8F98
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685537136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=B4bV2oROch/HC6XHubXydMRA7S2+n/L3VG/EIF3GuPE=;
        b=Yhg86ib+az/SJjOKErOie2JcAHQ/2UqI4eF6v/sXG9xmEIZqw2xnpYGR+NCR5EA9feXClT
        4i+8yuc46CKGCasAsiUFc44YjTr3z5Jxne16mBL2CiBqu37H610ZC8hmNXFHUh1ZyCv3t9
        zpZ8sy0LRoRveYmTlvZqUdlc8rRueSI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613--ohwPo-MMEyGn577YeFRZA-1; Wed, 31 May 2023 08:45:33 -0400
X-MC-Unique: -ohwPo-MMEyGn577YeFRZA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7588185A793;
        Wed, 31 May 2023 12:45:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8A25492B0A;
        Wed, 31 May 2023 12:45:30 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
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
Subject: [PATCH net-next v2 0/6] splice, net: Handle MSG_SPLICE_PAGES in AF_TLS
Date:   Wed, 31 May 2023 13:45:22 +0100
Message-ID: <20230531124528.699123-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are patches to make AF_TLS handle the MSG_SPLICE_PAGES internal
sendmsg flag.  MSG_SPLICE_PAGES is an internal hint that tells the protocol
that it should splice the pages supplied if it can.  Its sendpage
implementations are then turned into wrappers around that.

The following changes are made:

 (1) The first patch fixes MSG_MORE signalling in splice_direct_to_actor().

     The problem is that MSG_MORE is asserted if a short splice from a file
     occurs because we hit the EOF[1].  This is fixed by checking the EOF
     if the file is seekable.

 (2) Implement MSG_SPLICE_PAGES support in the AF_TLS-sw sendmsg and make
     tls_sw_sendpage() just a wrapper around sendmsg().

 (3) Implement MSG_SPLICE_PAGES support in AF_TLS-device and make
     tls_device_sendpage() just a wrapper around sendmsg().

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=sendpage-2-tls

David

Changes
=======
ver #2)
 - Dropped the slab data copying.
 - "rls_" should be "tls_".
 - Attempted to fix splice_direct_to_actor().
 - Blocked MSG_SENDPAGE_* from being set by userspace.

Link: https://lore.kernel.org/r/499791.1685485603@warthog.procyon.org.uk/ [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=51c78a4d532efe9543a4df019ff405f05c6157f6 # part 1
Link: https://lore.kernel.org/r/20230524153311.3625329-1-dhowells@redhat.com/ # v1

David Howells (6):
  splice, net: Fix MSG_MORE signalling in splice_direct_to_actor()
  net: Block MSG_SENDPAGE_* from being passed to sendmsg() by userspace
  tls/sw: Support MSG_SPLICE_PAGES
  tls/sw: Convert tls_sw_sendpage() to use MSG_SPLICE_PAGES
  tls/device: Support MSG_SPLICE_PAGES
  tls/device: Convert tls_device_sendpage() to use MSG_SPLICE_PAGES

 fs/splice.c            |  17 +++-
 include/linux/socket.h |   4 +-
 net/tls/tls_device.c   |  94 ++++++++----------
 net/tls/tls_sw.c       | 211 +++++++++++++++--------------------------
 4 files changed, 131 insertions(+), 195 deletions(-)

