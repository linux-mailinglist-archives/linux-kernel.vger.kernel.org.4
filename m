Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5097736F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjFTO7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbjFTO6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84AA1BEF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687273057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2HlaXseyq5U5o1i8LIFlWuZ5rATyuHBFais1x2nt408=;
        b=h7GrBAeAcdQwyfb7vFB7U11NlmIKokVTCaoRae8F2AjAvfPeHZ8rL31QcTgGCEDKlLfvX6
        vZPrySDL1068WnOf+e4LUxXZ6BxTbHOk9ZAo3WDe0JsPU1WzHGDvTnBczsCbvUlB6/L/9C
        rfxoU9a8ijODj6d1bvruO6f2GG2JQvk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-QZ1cyihYMfqFmIoZXCbVIQ-1; Tue, 20 Jun 2023 10:57:28 -0400
X-MC-Unique: QZ1cyihYMfqFmIoZXCbVIQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88D0B29ABA3F;
        Tue, 20 Jun 2023 14:54:36 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E58D02166B26;
        Tue, 20 Jun 2023 14:54:33 +0000 (UTC)
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
Subject: [PATCH net-next v3 14/18] drbd: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage()
Date:   Tue, 20 Jun 2023 15:53:33 +0100
Message-ID: <20230620145338.1300897-15-dhowells@redhat.com>
In-Reply-To: <20230620145338.1300897-1-dhowells@redhat.com>
References: <20230620145338.1300897-1-dhowells@redhat.com>
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

Use sendmsg() conditionally with MSG_SPLICE_PAGES in _drbd_send_page()
rather than calling sendpage() or _drbd_no_send_page().

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
     - Wrap lines at 80.

 drivers/block/drbd/drbd_main.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 83987e7a5ef2..8a01a18a2550 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1540,7 +1540,8 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
 		    int offset, size_t size, unsigned msg_flags)
 {
 	struct socket *socket = peer_device->connection->data.socket;
-	int len = size;
+	struct bio_vec bvec;
+	struct msghdr msg = { .msg_flags = msg_flags, };
 	int err = -EIO;
 
 	/* e.g. XFS meta- & log-data is in slab pages, which have a
@@ -1549,33 +1550,35 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
 	 * put_page(); and would cause either a VM_BUG directly, or
 	 * __page_cache_release a page that would actually still be referenced
 	 * by someone, leading to some obscure delayed Oops somewhere else. */
-	if (drbd_disable_sendpage || !sendpage_ok(page))
-		return _drbd_no_send_page(peer_device, page, offset, size, msg_flags);
+	if (!drbd_disable_sendpage && sendpage_ok(page))
+		msg.msg_flags |= MSG_NOSIGNAL | MSG_SPLICE_PAGES;
+
+	bvec_set_page(&bvec, page, offset, size);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
 
-	msg_flags |= MSG_NOSIGNAL;
 	drbd_update_congested(peer_device->connection);
 	do {
 		int sent;
 
-		sent = socket->ops->sendpage(socket, page, offset, len, msg_flags);
+		sent = sock_sendmsg(socket, &msg);
 		if (sent <= 0) {
 			if (sent == -EAGAIN) {
 				if (we_should_drop_the_connection(peer_device->connection, socket))
 					break;
 				continue;
 			}
-			drbd_warn(peer_device->device, "%s: size=%d len=%d sent=%d\n",
-			     __func__, (int)size, len, sent);
+			drbd_warn(peer_device->device, "%s: size=%d len=%zu sent=%d\n",
+				  __func__, (int)size, msg_data_left(&msg),
+				  sent);
 			if (sent < 0)
 				err = sent;
 			break;
 		}
-		len    -= sent;
-		offset += sent;
-	} while (len > 0 /* THINK && device->cstate >= C_CONNECTED*/);
+	} while (msg_data_left(&msg)
+		 /* THINK && device->cstate >= C_CONNECTED*/);
 	clear_bit(NET_CONGESTED, &peer_device->connection->flags);
 
-	if (len == 0) {
+	if (!msg_data_left(&msg)) {
 		err = 0;
 		peer_device->device->send_cnt += size >> 9;
 	}

