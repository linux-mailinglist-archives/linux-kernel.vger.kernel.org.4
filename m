Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E9D729690
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbjFIKOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjFIKN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7D64207
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 03:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686304956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SombcmEIcaRaYVTgKnrWY9WG1lMYc9bVEGm8HvALgWY=;
        b=HpAXq3K//AihhBMuij0fVC/aR/b5Y9NWj+E5Bgt4kFHB47HHOlMR7AqDhmYFbVMGwN+b9i
        +Rwrq+Xkm1JIRu72IgSX7eQqd61bNSmvIJGHJNQgkL33N9+6VRrhlhGwbSFvESfaLUjul3
        krNFDb/Sw0r2OxhcuGvgCnC4cjh1JBA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-qreM6B3JMVajOcjyMrQ3tQ-1; Fri, 09 Jun 2023 06:02:25 -0400
X-MC-Unique: qreM6B3JMVajOcjyMrQ3tQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 383D3803791;
        Fri,  9 Jun 2023 10:02:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B3271121314;
        Fri,  9 Jun 2023 10:02:23 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/6] splice, net: Some miscellaneous MSG_SPLICE_PAGES changes
Date:   Fri,  9 Jun 2023 11:02:15 +0100
Message-ID: <20230609100221.2620633-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

Now that the splice_to_socket() has been rewritten so that nothing now uses
the ->sendpage() file op[1], some further changes can be made, so here are
some miscellaneous changes that can now be done.

 (1) Remove the ->sendpage() file op.

 (2) Remove hash_sendpage*() from AF_ALG.

 (3) Make sunrpc send multiple pages in single sendmsg() call rather than
     calling sendpage() in TCP (or maybe TLS).

 (4) Make tcp_bpf_sendpage() a wrapper around tcp_bpf_sendmsg().

 (5) Make AF_KCM use sendmsg() when calling down to TCP and then make it
     send entire fragment lists in single sendmsg calls.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=sendpage-3-misc

David

Link: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=fd5f4d7da29218485153fd8b4c08da7fc130c79f [1]

David Howells (6):
  Remove file->f_op->sendpage
  algif: Remove hash_sendpage*()
  sunrpc: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
  tcp_bpf: Make tcp_bpf_sendpage() go through
    tcp_bpf_sendmsg(MSG_SPLICE_PAGES)
  kcm: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
  kcm: Send multiple frags in one sendmsg()

 crypto/algif_hash.c        |  66 --------------------
 include/linux/fs.h         |   1 -
 include/linux/sunrpc/svc.h |  11 ++--
 include/net/kcm.h          |   2 +-
 net/ipv4/tcp_bpf.c         |  49 +++------------
 net/kcm/kcmsock.c          | 120 ++++++++++++++++---------------------
 net/sunrpc/svcsock.c       |  38 ++++--------
 7 files changed, 77 insertions(+), 210 deletions(-)

