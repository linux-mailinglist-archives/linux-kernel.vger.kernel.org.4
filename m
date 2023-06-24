Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A48873C462
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjFWW5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjFWW5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C8A2729
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687560940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B4yhQOVBi6GuvWYD5vpVZMpw478eQsHtbdlO705ACPw=;
        b=EwjY/W/gerF5QkBYGedSMotly4w/K9OW/FqfHJw4Mshkr2TmbLEn2urG3fpmDP6ABxyunR
        D66iGpwRH+PIxuJ5h6QiBNBQLxne22UEtXPfoW9/rd3JWN7L0dyV3feXZIJf2Gl8QWXGK4
        Mr6ptnQWwN0KKj+fhii8lH5WC8fvVEk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-0YWi76drOuGNHDR7iFGrzg-1; Fri, 23 Jun 2023 18:55:33 -0400
X-MC-Unique: 0YWi76drOuGNHDR7iFGrzg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4F31858EED;
        Fri, 23 Jun 2023 22:55:31 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 370D2200C0CD;
        Fri, 23 Jun 2023 22:55:30 +0000 (UTC)
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
        linux-kernel@vger.kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Subject: [PATCH net-next v5 05/16] rds: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
Date:   Fri, 23 Jun 2023 23:55:02 +0100
Message-ID: <20230623225513.2732256-6-dhowells@redhat.com>
In-Reply-To: <20230623225513.2732256-1-dhowells@redhat.com>
References: <20230623225513.2732256-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When transmitting data, call down into TCP using a single sendmsg with
MSG_SPLICE_PAGES to indicate that content should be spliced.

To make this work, the data is assembled in a bio_vec array and attached to
a BVEC-type iterator.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-rdma@vger.kernel.org
cc: rds-devel@oss.oracle.com
cc: netdev@vger.kernel.org
---

Notes:
    ver #4)
     - Reduce change to only call sendmsg on a page at a time.

 net/rds/tcp_send.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/rds/tcp_send.c b/net/rds/tcp_send.c
index 8c4d1d6e9249..7d284ac7e81a 100644
--- a/net/rds/tcp_send.c
+++ b/net/rds/tcp_send.c
@@ -72,9 +72,10 @@ int rds_tcp_xmit(struct rds_connection *conn, struct rds_message *rm,
 {
 	struct rds_conn_path *cp = rm->m_inc.i_conn_path;
 	struct rds_tcp_connection *tc = cp->cp_transport_data;
+	struct msghdr msg = {};
+	struct bio_vec bvec;
 	int done = 0;
 	int ret = 0;
-	int more;
 
 	if (hdr_off == 0) {
 		/*
@@ -111,15 +112,17 @@ int rds_tcp_xmit(struct rds_connection *conn, struct rds_message *rm,
 			goto out;
 	}
 
-	more = rm->data.op_nents > 1 ? (MSG_MORE | MSG_SENDPAGE_NOTLAST) : 0;
 	while (sg < rm->data.op_nents) {
-		int flags = MSG_DONTWAIT | MSG_NOSIGNAL | more;
-
-		ret = tc->t_sock->ops->sendpage(tc->t_sock,
-						sg_page(&rm->data.op_sg[sg]),
-						rm->data.op_sg[sg].offset + off,
-						rm->data.op_sg[sg].length - off,
-						flags);
+		msg.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT | MSG_NOSIGNAL;
+		if (sg + 1 < rm->data.op_nents)
+			msg.msg_flags |= MSG_MORE;
+
+		bvec_set_page(&bvec, sg_page(&rm->data.op_sg[sg]),
+			      rm->data.op_sg[sg].length - off,
+			      rm->data.op_sg[sg].offset + off);
+		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1,
+			      rm->data.op_sg[sg].length - off);
+		ret = sock_sendmsg(tc->t_sock, &msg);
 		rdsdebug("tcp sendpage %p:%u:%u ret %d\n", (void *)sg_page(&rm->data.op_sg[sg]),
 			 rm->data.op_sg[sg].offset + off, rm->data.op_sg[sg].length - off,
 			 ret);
@@ -132,8 +135,6 @@ int rds_tcp_xmit(struct rds_connection *conn, struct rds_message *rm,
 			off = 0;
 			sg++;
 		}
-		if (sg == rm->data.op_nents - 1)
-			more = 0;
 	}
 
 out:

