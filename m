Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7F073B6A4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjFWLqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjFWLqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:46:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE7119AB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687520723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6qW7QONKdXKQCe18ckz4PBDuqjad2A9AyVw+035R3zM=;
        b=hV3IjCC6kQSZX0A+RbaSNHXKaoiaaaEbGvWFym0bhnEb8gMcqD9dDgzx9a2gIbgF26C6i8
        qp7BxS9bOpxnnIrPiE3CQR4pVhi1NC7APVgj+dyIQhMI+MdvQqBrF4kr6ijLG0pzMdOWQj
        yfvZGrs6R23NLRFjcE9+2k5UntE2lO4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-woVC1FXnMaeEutQKCYvqpQ-1; Fri, 23 Jun 2023 07:45:19 -0400
X-MC-Unique: woVC1FXnMaeEutQKCYvqpQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57BA529AB40B;
        Fri, 23 Jun 2023 11:45:16 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E6FC4087C6F;
        Fri, 23 Jun 2023 11:45:14 +0000 (UTC)
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
        linux-kernel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH net-next v4 13/15] ocfs2: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage()
Date:   Fri, 23 Jun 2023 12:44:23 +0100
Message-ID: <20230623114425.2150536-14-dhowells@redhat.com>
In-Reply-To: <20230623114425.2150536-1-dhowells@redhat.com>
References: <20230623114425.2150536-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

Switch ocfs2 from using sendpage() to using sendmsg() + MSG_SPLICE_PAGES so
that sendpage can be phased out.

Signed-off-by: David Howells <dhowells@redhat.com>

cc: Mark Fasheh <mark@fasheh.com>
cc: Joel Becker <jlbec@evilplan.org>
cc: Joseph Qi <joseph.qi@linux.alibaba.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: ocfs2-devel@oss.oracle.com
cc: netdev@vger.kernel.org
---

Notes:
    ver #4)
     - Use folio_alloc() for o2net_hand, o2net_keep_req and o2net_keep_resp.
    
    ver #2)
     - Wrap lines at 80.

 fs/ocfs2/cluster/tcp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 929a1133bc18..960080753d3b 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -930,19 +930,22 @@ static int o2net_send_tcp_msg(struct socket *sock, struct kvec *vec,
 }
 
 static void o2net_sendpage(struct o2net_sock_container *sc,
-			   void *kmalloced_virt,
-			   size_t size)
+			   void *virt, size_t size)
 {
 	struct o2net_node *nn = o2net_nn_from_num(sc->sc_node->nd_num);
+	struct msghdr msg = {};
+	struct bio_vec bv;
 	ssize_t ret;
 
+	bvec_set_virt(&bv, virt, size);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bv, 1, size);
+
 	while (1) {
+		msg.msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES;
 		mutex_lock(&sc->sc_send_lock);
-		ret = sc->sc_sock->ops->sendpage(sc->sc_sock,
-						 virt_to_page(kmalloced_virt),
-						 offset_in_page(kmalloced_virt),
-						 size, MSG_DONTWAIT);
+		ret = sock_sendmsg(sc->sc_sock, &msg);
 		mutex_unlock(&sc->sc_send_lock);
+
 		if (ret == size)
 			break;
 		if (ret == (ssize_t)-EAGAIN) {

