Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EC7736F51
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjFTO43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjFTO4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:56:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05F01A4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687272939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1DmsLXNf6UEopicQGVGHzvB3R+Io/k4xNBk1zidfJPQ=;
        b=SWqBeLrhy/gQnScPumoceKmq5ZZGLq+VcoMS9pGMwb+cV+qfLjBXRG3rUUuUnm8sMwl739
        xB+bbv25vhmvGbb9JiFH/kxXcWmvS9hBOL64dEU0xzVrXD8U/DSBQ/VoSE0CD/RuwRPrBD
        kq/KRn9KfV1hzwh9TjeWlve6vNaVhGw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-q3ToHJJIOfyekEbhjCK1ZA-1; Tue, 20 Jun 2023 10:55:36 -0400
X-MC-Unique: q3ToHJJIOfyekEbhjCK1ZA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0FD23814975;
        Tue, 20 Jun 2023 14:53:55 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D552B492C13;
        Tue, 20 Jun 2023 14:53:53 +0000 (UTC)
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
        linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        ceph-devel@vger.kernel.org
Subject: [PATCH net-next v3 05/18] ceph: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
Date:   Tue, 20 Jun 2023 15:53:24 +0100
Message-ID: <20230620145338.1300897-6-dhowells@redhat.com>
In-Reply-To: <20230620145338.1300897-1-dhowells@redhat.com>
References: <20230620145338.1300897-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

Use sendmsg() and MSG_SPLICE_PAGES rather than sendpage in ceph when
transmitting data.  For the moment, this can only transmit one page at a
time because of the architecture of net/ceph/, but if
write_partial_message_data() can be given a bvec[] at a time by the
iteration code, this would allow pages to be sent in a batch.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: ceph-devel@vger.kernel.org
cc: netdev@vger.kernel.org
---
 net/ceph/messenger_v1.c | 58 ++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 39 deletions(-)

diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
index d664cb1593a7..f082e5c780a3 100644
--- a/net/ceph/messenger_v1.c
+++ b/net/ceph/messenger_v1.c
@@ -74,37 +74,6 @@ static int ceph_tcp_sendmsg(struct socket *sock, struct kvec *iov,
 	return r;
 }
 
-/*
- * @more: either or both of MSG_MORE and MSG_SENDPAGE_NOTLAST
- */
-static int ceph_tcp_sendpage(struct socket *sock, struct page *page,
-			     int offset, size_t size, int more)
-{
-	ssize_t (*sendpage)(struct socket *sock, struct page *page,
-			    int offset, size_t size, int flags);
-	int flags = MSG_DONTWAIT | MSG_NOSIGNAL | more;
-	int ret;
-
-	/*
-	 * sendpage cannot properly handle pages with page_count == 0,
-	 * we need to fall back to sendmsg if that's the case.
-	 *
-	 * Same goes for slab pages: skb_can_coalesce() allows
-	 * coalescing neighboring slab objects into a single frag which
-	 * triggers one of hardened usercopy checks.
-	 */
-	if (sendpage_ok(page))
-		sendpage = sock->ops->sendpage;
-	else
-		sendpage = sock_no_sendpage;
-
-	ret = sendpage(sock, page, offset, size, flags);
-	if (ret == -EAGAIN)
-		ret = 0;
-
-	return ret;
-}
-
 static void con_out_kvec_reset(struct ceph_connection *con)
 {
 	BUG_ON(con->v1.out_skip);
@@ -464,7 +433,6 @@ static int write_partial_message_data(struct ceph_connection *con)
 	struct ceph_msg *msg = con->out_msg;
 	struct ceph_msg_data_cursor *cursor = &msg->cursor;
 	bool do_datacrc = !ceph_test_opt(from_msgr(con->msgr), NOCRC);
-	int more = MSG_MORE | MSG_SENDPAGE_NOTLAST;
 	u32 crc;
 
 	dout("%s %p msg %p\n", __func__, con, msg);
@@ -482,6 +450,10 @@ static int write_partial_message_data(struct ceph_connection *con)
 	 */
 	crc = do_datacrc ? le32_to_cpu(msg->footer.data_crc) : 0;
 	while (cursor->total_resid) {
+		struct bio_vec bvec;
+		struct msghdr msghdr = {
+			.msg_flags = MSG_SPLICE_PAGES,
+		};
 		struct page *page;
 		size_t page_offset;
 		size_t length;
@@ -494,9 +466,12 @@ static int write_partial_message_data(struct ceph_connection *con)
 
 		page = ceph_msg_data_next(cursor, &page_offset, &length);
 		if (length == cursor->total_resid)
-			more = MSG_MORE;
-		ret = ceph_tcp_sendpage(con->sock, page, page_offset, length,
-					more);
+			msghdr.msg_flags |= MSG_MORE;
+
+		bvec_set_page(&bvec, page, length, page_offset);
+		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, length);
+
+		ret = sock_sendmsg(con->sock, &msghdr);
 		if (ret <= 0) {
 			if (do_datacrc)
 				msg->footer.data_crc = cpu_to_le32(crc);
@@ -526,7 +501,10 @@ static int write_partial_message_data(struct ceph_connection *con)
  */
 static int write_partial_skip(struct ceph_connection *con)
 {
-	int more = MSG_MORE | MSG_SENDPAGE_NOTLAST;
+	struct bio_vec bvec;
+	struct msghdr msghdr = {
+		.msg_flags = MSG_SPLICE_PAGES | MSG_MORE,
+	};
 	int ret;
 
 	dout("%s %p %d left\n", __func__, con, con->v1.out_skip);
@@ -534,9 +512,11 @@ static int write_partial_skip(struct ceph_connection *con)
 		size_t size = min(con->v1.out_skip, (int)PAGE_SIZE);
 
 		if (size == con->v1.out_skip)
-			more = MSG_MORE;
-		ret = ceph_tcp_sendpage(con->sock, ceph_zero_page, 0, size,
-					more);
+			msghdr.msg_flags &= ~MSG_MORE;
+		bvec_set_page(&bvec, ZERO_PAGE(0), size, 0);
+		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, size);
+
+		ret = sock_sendmsg(con->sock, &msghdr);
 		if (ret <= 0)
 			goto out;
 		con->v1.out_skip -= ret;

