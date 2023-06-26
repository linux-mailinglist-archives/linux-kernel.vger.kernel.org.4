Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9D773E6F6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjFZRxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjFZRxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:53:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCED2186
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687801980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=U0jdL86siHwlmmEuSMUbE77fE/D9k5fCITc4XgRrAv8=;
        b=KTIqPFu/qljTHM9BUbd6DuXX71aa4VZyG2AymrTUKRuFsm4DDJC8GgrGTuNSBjIYoYqzUe
        oY4bKPmU8WHatNWKLDuiJscvK2KHQkObG/vrI6rO2kCFiPbcbBYiZ9JsrdbKR2NpCvBZ7G
        JDCp0eTzo7KxwNFaeH2CW5al4njrrIg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-NzV_VP4POByTJyTsFbHNeA-1; Mon, 26 Jun 2023 13:52:56 -0400
X-MC-Unique: NzV_VP4POByTJyTsFbHNeA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BDCA3C100A1;
        Mon, 26 Jun 2023 17:52:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6C6B14682F9;
        Mon, 26 Jun 2023 17:52:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, netdev@vger.kernel.org
cc:     dhowells@redhat.com, Xiubo Li <xiubli@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] libceph: Partially revert changes to support MSG_SPLICE_PAGES
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3101880.1687801973.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 26 Jun 2023 18:52:53 +0100
Message-ID: <3101881.1687801973@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

    =

Fix the mishandling of MSG_DONTWAIT and also reinstates the per-page
checking of the source pages (which might have come from a DIO write by
userspace) by partially reverting the changes to support MSG_SPLICE_PAGES
and doing things a little differently.  In messenger_v1:
    =

 (1) The ceph_tcp_sendpage() is resurrected and the callers reverted to us=
e
     that.

 (2) The callers now pass MSG_MORE unconditionally.  Previously, they were
     passing in MSG_MORE|MSG_SENDPAGE_NOTLAST and then degrading that to
     just MSG_MORE on the last call to ->sendpage().

 (3) Make ceph_tcp_sendpage() a wrapper around sendmsg() rather than
     sendpage(), setting MSG_SPLICE_PAGES if sendpage_ok() returns true on
     the page.

In messenger_v2:

 (4) Bring back do_try_sendpage() and make the callers use that.

 (5) Make do_try_sendpage() use sendmsg() for both cases and set
     MSG_SPLICE_PAGES if sendpage_ok() is set.

Note that libceph is using sendpage_ok() for this, but it should not reall=
y
be considered exhaustive in this regard - this is, however, what libceph i=
s
doing upstream.

Fixes: 40a8c17aa770 ("ceph: Use sendmsg(MSG_SPLICE_PAGES) rather than send=
page")
Fixes: fa094ccae1e7 ("ceph: Use sendmsg(MSG_SPLICE_PAGES) rather than send=
page()")
Reported-by: Ilya Dryomov <idryomov@gmail.com>
Link: https://lore.kernel.org/r/CAOi1vP9vjLfk3W+AJFeexC93jqPaPUn2dD_4Nrzxw=
oZTbYfOnw@mail.gmail.com/
Link: https://lore.kernel.org/r/CAOi1vP_Bn918j24S94MuGyn+Gxk212btw7yWeDrRc=
W1U8pc_BA@mail.gmail.com/
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
 net/ceph/messenger_v1.c |   57 +++++++++++++++++++------------
 net/ceph/messenger_v2.c |   87 ++++++++++++++++++++++++++++++++++++++----=
------
 2 files changed, 105 insertions(+), 39 deletions(-)

diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
index 814579f27f04..1ee58cbaf151 100644
--- a/net/ceph/messenger_v1.c
+++ b/net/ceph/messenger_v1.c
@@ -74,6 +74,38 @@ static int ceph_tcp_sendmsg(struct socket *sock, struct=
 kvec *iov,
 	return r;
 }
 =

+/*
+ * @more: either or both of MSG_MORE and MSG_SENDPAGE_NOTLAST
+ */
+static int ceph_tcp_sendpage(struct socket *sock, struct page *page,
+			     int offset, size_t size, int more)
+{
+	struct msghdr msg =3D {
+		.msg_flags =3D MSG_DONTWAIT | MSG_NOSIGNAL | more,
+	};
+	struct bio_vec bvec;
+	int ret;
+
+	/*
+	 * sendpage cannot properly handle pages with page_count =3D=3D 0,
+	 * we need to fall back to sendmsg if that's the case.
+	 *
+	 * Same goes for slab pages: skb_can_coalesce() allows
+	 * coalescing neighboring slab objects into a single frag which
+	 * triggers one of hardened usercopy checks.
+	 */
+	if (sendpage_ok(page))
+		msg.msg_flags |=3D MSG_SPLICE_PAGES;
+
+	bvec_set_page(&bvec, page, size, offset);
+
+	ret =3D sock_sendmsg(sock, &msg);
+	if (ret =3D=3D -EAGAIN)
+		ret =3D 0;
+
+	return ret;
+}
+
 static void con_out_kvec_reset(struct ceph_connection *con)
 {
 	BUG_ON(con->v1.out_skip);
@@ -450,10 +482,6 @@ static int write_partial_message_data(struct ceph_con=
nection *con)
 	 */
 	crc =3D do_datacrc ? le32_to_cpu(msg->footer.data_crc) : 0;
 	while (cursor->total_resid) {
-		struct bio_vec bvec;
-		struct msghdr msghdr =3D {
-			.msg_flags =3D MSG_SPLICE_PAGES,
-		};
 		struct page *page;
 		size_t page_offset;
 		size_t length;
@@ -465,13 +493,8 @@ static int write_partial_message_data(struct ceph_con=
nection *con)
 		}
 =

 		page =3D ceph_msg_data_next(cursor, &page_offset, &length);
-		if (length !=3D cursor->total_resid)
-			msghdr.msg_flags |=3D MSG_MORE;
-
-		bvec_set_page(&bvec, page, length, page_offset);
-		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, length);
-
-		ret =3D sock_sendmsg(con->sock, &msghdr);
+		ret =3D ceph_tcp_sendpage(con->sock, page, page_offset, length,
+					MSG_MORE);
 		if (ret <=3D 0) {
 			if (do_datacrc)
 				msg->footer.data_crc =3D cpu_to_le32(crc);
@@ -501,22 +524,14 @@ static int write_partial_message_data(struct ceph_co=
nnection *con)
  */
 static int write_partial_skip(struct ceph_connection *con)
 {
-	struct bio_vec bvec;
-	struct msghdr msghdr =3D {
-		.msg_flags =3D MSG_SPLICE_PAGES | MSG_MORE,
-	};
 	int ret;
 =

 	dout("%s %p %d left\n", __func__, con, con->v1.out_skip);
 	while (con->v1.out_skip > 0) {
 		size_t size =3D min(con->v1.out_skip, (int)PAGE_SIZE);
 =

-		if (size =3D=3D con->v1.out_skip)
-			msghdr.msg_flags &=3D ~MSG_MORE;
-		bvec_set_page(&bvec, ZERO_PAGE(0), size, 0);
-		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, size);
-
-		ret =3D sock_sendmsg(con->sock, &msghdr);
+		ret =3D ceph_tcp_sendpage(con->sock, ceph_zero_page, 0, size,
+					MSG_MORE);
 		if (ret <=3D 0)
 			goto out;
 		con->v1.out_skip -=3D ret;
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index 87ac97073e75..139b61598f4f 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -117,38 +117,89 @@ static int ceph_tcp_recv(struct ceph_connection *con=
)
 	return ret;
 }
 =

+static int do_sendmsg(struct socket *sock, struct iov_iter *it)
+{
+	struct msghdr msg =3D { .msg_flags =3D CEPH_MSG_FLAGS };
+	int ret;
+
+	msg.msg_iter =3D *it;
+	while (iov_iter_count(it)) {
+		ret =3D sock_sendmsg(sock, &msg);
+		if (ret <=3D 0) {
+			if (ret =3D=3D -EAGAIN)
+				ret =3D 0;
+			return ret;
+		}
+
+		iov_iter_advance(it, ret);
+	}
+
+	WARN_ON(msg_data_left(&msg));
+	return 1;
+}
+
+static int do_try_sendpage(struct socket *sock, struct iov_iter *it)
+{
+	struct msghdr msg =3D {};
+	struct bio_vec bv;
+	int ret;
+
+	if (WARN_ON(!iov_iter_is_bvec(it)))
+		return -EINVAL;
+
+	while (iov_iter_count(it)) {
+		msg.msg_flags =3D CEPH_MSG_FLAGS;
+		if (sendpage_ok(bv.bv_page))
+			msg.msg_flags |=3D MSG_SPLICE_PAGES;
+
+		/* iov_iter_iovec() for ITER_BVEC */
+		bvec_set_page(&bv, it->bvec->bv_page,
+			      min(iov_iter_count(it),
+				  it->bvec->bv_len - it->iov_offset),
+			      it->bvec->bv_offset + it->iov_offset);
+
+		/*
+		 * MSG_SPLICE_PAGES cannot properly handle pages with
+		 * page_count =3D=3D 0, we need to fall back to sendmsg if
+		 * that's the case.
+		 *
+		 * Same goes for slab pages: skb_can_coalesce() allows
+		 * coalescing neighboring slab objects into a single frag
+		 * which triggers one of hardened usercopy checks.
+		 */
+		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bv, 1, bv.bv_len);
+		ret =3D sock_sendmsg(sock, &msg);
+		if (ret <=3D 0) {
+			if (ret =3D=3D -EAGAIN)
+				ret =3D 0;
+			return ret;
+		}
+
+		iov_iter_advance(it, ret);
+	}
+
+	return 1;
+}
+
 /*
  * Write as much as possible.  The socket is expected to be corked,
  * so we don't bother with MSG_MORE here.
  *
  * Return:
- *  >0 - done, nothing (else) to write
+ *   1 - done, nothing (else) to write
  *   0 - socket is full, need to wait
  *  <0 - error
  */
 static int ceph_tcp_send(struct ceph_connection *con)
 {
-	struct msghdr msg =3D {
-		.msg_iter	=3D con->v2.out_iter,
-		.msg_flags	=3D CEPH_MSG_FLAGS,
-	};
 	int ret;
 =

-	if (WARN_ON(!iov_iter_is_bvec(&con->v2.out_iter)))
-		return -EINVAL;
-
-	if (con->v2.out_iter_sendpage)
-		msg.msg_flags |=3D MSG_SPLICE_PAGES;
-
 	dout("%s con %p have %zu try_sendpage %d\n", __func__, con,
 	     iov_iter_count(&con->v2.out_iter), con->v2.out_iter_sendpage);
-
-	ret =3D sock_sendmsg(con->sock, &msg);
-	if (ret > 0)
-		iov_iter_advance(&con->v2.out_iter, ret);
-	else if (ret =3D=3D -EAGAIN)
-		ret =3D 0;
-
+	if (con->v2.out_iter_sendpage)
+		ret =3D do_try_sendpage(con->sock, &con->v2.out_iter);
+	else
+		ret =3D do_sendmsg(con->sock, &con->v2.out_iter);
 	dout("%s con %p ret %d left %zu\n", __func__, con, ret,
 	     iov_iter_count(&con->v2.out_iter));
 	return ret;

