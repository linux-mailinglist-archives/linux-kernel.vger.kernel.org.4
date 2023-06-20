Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5E5736F73
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjFTO6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjFTO6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153EE198B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687273034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XKse4vF5Frqs4bdWsYMKttBmqWRsH1PFiAHwvjH79qA=;
        b=JPxjPY4PDmL9ZbtXTfjKDZnyAmqdVXlsUcdv6agqeCBsGvE547yLchHb49YHBEJpX1Zbbi
        Nvjyn+nZ7jD2UZsHKkJvSJCmPa9aljl8GrOjSoGQvLQleorD79bTjauOfGID4g/AXibfci
        GyXvOOinWQjIU0kBORhebAc8UtfuiSQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-Q6NvzJ07NxKczalwLXSO3g-1; Tue, 20 Jun 2023 10:57:10 -0400
X-MC-Unique: Q6NvzJ07NxKczalwLXSO3g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1552E1064B1B;
        Tue, 20 Jun 2023 14:54:39 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 341B5200A398;
        Tue, 20 Jun 2023 14:54:37 +0000 (UTC)
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
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org
Subject: [PATCH net-next v3 15/18] drdb: Send an entire bio in a single sendmsg
Date:   Tue, 20 Jun 2023 15:53:34 +0100
Message-ID: <20230620145338.1300897-16-dhowells@redhat.com>
In-Reply-To: <20230620145338.1300897-1-dhowells@redhat.com>
References: <20230620145338.1300897-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Since _drdb_sendpage() is now using sendmsg to send the pages rather
sendpage, pass the entire bio in one go using a bvec iterator instead of
doing it piecemeal.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Philipp Reisner <philipp.reisner@linbit.com>
cc: Lars Ellenberg <lars.ellenberg@linbit.com>
cc: "Christoph Böhmwalder" <christoph.boehmwalder@linbit.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: drbd-dev@lists.linbit.com
cc: linux-block@vger.kernel.org
cc: netdev@vger.kernel.org
---

Notes:
    ver #2)
     - Use "unsigned int" rather than "unsigned".

 drivers/block/drbd/drbd_main.c | 77 +++++++++++-----------------------
 1 file changed, 25 insertions(+), 52 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 8a01a18a2550..beba74ae093b 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1520,28 +1520,15 @@ static void drbd_update_congested(struct drbd_connection *connection)
  * As a workaround, we disable sendpage on pages
  * with page_count == 0 or PageSlab.
  */
-static int _drbd_no_send_page(struct drbd_peer_device *peer_device, struct page *page,
-			      int offset, size_t size, unsigned msg_flags)
-{
-	struct socket *socket;
-	void *addr;
-	int err;
-
-	socket = peer_device->connection->data.socket;
-	addr = kmap(page) + offset;
-	err = drbd_send_all(peer_device->connection, socket, addr, size, msg_flags);
-	kunmap(page);
-	if (!err)
-		peer_device->device->send_cnt += size >> 9;
-	return err;
-}
-
-static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *page,
-		    int offset, size_t size, unsigned msg_flags)
+static int _drbd_send_pages(struct drbd_peer_device *peer_device,
+			    struct iov_iter *iter, unsigned int msg_flags)
 {
 	struct socket *socket = peer_device->connection->data.socket;
-	struct bio_vec bvec;
-	struct msghdr msg = { .msg_flags = msg_flags, };
+	struct msghdr msg = {
+		.msg_flags	= msg_flags | MSG_NOSIGNAL,
+		.msg_iter	= *iter,
+	};
+	size_t size = iov_iter_count(iter);
 	int err = -EIO;
 
 	/* e.g. XFS meta- & log-data is in slab pages, which have a
@@ -1550,11 +1537,8 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
 	 * put_page(); and would cause either a VM_BUG directly, or
 	 * __page_cache_release a page that would actually still be referenced
 	 * by someone, leading to some obscure delayed Oops somewhere else. */
-	if (!drbd_disable_sendpage && sendpage_ok(page))
-		msg.msg_flags |= MSG_NOSIGNAL | MSG_SPLICE_PAGES;
-
-	bvec_set_page(&bvec, page, offset, size);
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
+	if (drbd_disable_sendpage)
+		msg.msg_flags &= ~(MSG_NOSIGNAL | MSG_SPLICE_PAGES);
 
 	drbd_update_congested(peer_device->connection);
 	do {
@@ -1587,39 +1571,22 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
 
 static int _drbd_send_bio(struct drbd_peer_device *peer_device, struct bio *bio)
 {
-	struct bio_vec bvec;
-	struct bvec_iter iter;
+	struct iov_iter iter;
 
-	/* hint all but last page with MSG_MORE */
-	bio_for_each_segment(bvec, bio, iter) {
-		int err;
+	iov_iter_bvec(&iter, ITER_SOURCE, bio->bi_io_vec, bio->bi_vcnt,
+		      bio->bi_iter.bi_size);
 
-		err = _drbd_no_send_page(peer_device, bvec.bv_page,
-					 bvec.bv_offset, bvec.bv_len,
-					 bio_iter_last(bvec, iter)
-					 ? 0 : MSG_MORE);
-		if (err)
-			return err;
-	}
-	return 0;
+	return _drbd_send_pages(peer_device, &iter, 0);
 }
 
 static int _drbd_send_zc_bio(struct drbd_peer_device *peer_device, struct bio *bio)
 {
-	struct bio_vec bvec;
-	struct bvec_iter iter;
+	struct iov_iter iter;
 
-	/* hint all but last page with MSG_MORE */
-	bio_for_each_segment(bvec, bio, iter) {
-		int err;
+	iov_iter_bvec(&iter, ITER_SOURCE, bio->bi_io_vec, bio->bi_vcnt,
+		      bio->bi_iter.bi_size);
 
-		err = _drbd_send_page(peer_device, bvec.bv_page,
-				      bvec.bv_offset, bvec.bv_len,
-				      bio_iter_last(bvec, iter) ? 0 : MSG_MORE);
-		if (err)
-			return err;
-	}
-	return 0;
+	return _drbd_send_pages(peer_device, &iter, MSG_SPLICE_PAGES);
 }
 
 static int _drbd_send_zc_ee(struct drbd_peer_device *peer_device,
@@ -1631,10 +1598,16 @@ static int _drbd_send_zc_ee(struct drbd_peer_device *peer_device,
 
 	/* hint all but last page with MSG_MORE */
 	page_chain_for_each(page) {
+		struct iov_iter iter;
+		struct bio_vec bvec;
 		unsigned l = min_t(unsigned, len, PAGE_SIZE);
 
-		err = _drbd_send_page(peer_device, page, 0, l,
-				      page_chain_next(page) ? MSG_MORE : 0);
+		bvec_set_page(&bvec, page, 0, l);
+		iov_iter_bvec(&iter, ITER_SOURCE, &bvec, 1, l);
+
+		err = _drbd_send_pages(peer_device, &iter,
+				       MSG_SPLICE_PAGES |
+				       (page_chain_next(page) ? MSG_MORE : 0));
 		if (err)
 			return err;
 		len -= l;

