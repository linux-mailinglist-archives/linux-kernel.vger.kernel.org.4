Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A491173B67F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjFWLpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjFWLpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:45:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98361BD6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687520679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=96le6Nv7f7Jm2em1nCUehde2Ld5Ng9GbgAM0NyDY2H8=;
        b=GRItEYNn6zJzGvbtkBSraybGGsAphwjYOb9MStMtxpIZ0pe/8S7VmwP9alSCnszjcw519/
        NH6ot+z2Cz3uop+o2MjXldpMtvG3EjsEtqQ3r3W79ZvOK0gCfrWpT3+ldJiV1i/zCqPfk4
        6lz3AsJBFRFjHSLcCkrtcubSEDI/UUY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-bx3c_Z3YOMW40JuokbnynQ-1; Fri, 23 Jun 2023 07:44:35 -0400
X-MC-Unique: bx3c_Z3YOMW40JuokbnynQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 520C68E44E6;
        Fri, 23 Jun 2023 11:44:35 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E13781121314;
        Fri, 23 Jun 2023 11:44:33 +0000 (UTC)
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
Subject: [PATCH net-next v4 02/15] net: Use sendmsg(MSG_SPLICE_PAGES) not sendpage in skb_send_sock()
Date:   Fri, 23 Jun 2023 12:44:12 +0100
Message-ID: <20230623114425.2150536-3-dhowells@redhat.com>
In-Reply-To: <20230623114425.2150536-1-dhowells@redhat.com>
References: <20230623114425.2150536-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sendmsg() with MSG_SPLICE_PAGES rather than sendpage in
skb_send_sock().  This causes pages to be spliced from the source iterator
if possible.

This allows ->sendpage() to be replaced by something that can handle
multiple multipage folios in a single transaction.

Note that this could perhaps be improved to fill out a bvec array with all
the frags and then make a single sendmsg call, possibly sticking the header
on the front also.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
---

Notes:
    ver #2)
     - Wrap lines at 80.

 net/core/skbuff.c | 50 ++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index fee2b1c105fe..6c5915efbc17 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2989,32 +2989,32 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 }
 EXPORT_SYMBOL_GPL(skb_splice_bits);
 
-static int sendmsg_unlocked(struct sock *sk, struct msghdr *msg,
-			    struct kvec *vec, size_t num, size_t size)
+static int sendmsg_locked(struct sock *sk, struct msghdr *msg)
 {
 	struct socket *sock = sk->sk_socket;
+	size_t size = msg_data_left(msg);
 
 	if (!sock)
 		return -EINVAL;
-	return kernel_sendmsg(sock, msg, vec, num, size);
+
+	if (!sock->ops->sendmsg_locked)
+		return sock_no_sendmsg_locked(sk, msg, size);
+
+	return sock->ops->sendmsg_locked(sk, msg, size);
 }
 
-static int sendpage_unlocked(struct sock *sk, struct page *page, int offset,
-			     size_t size, int flags)
+static int sendmsg_unlocked(struct sock *sk, struct msghdr *msg)
 {
 	struct socket *sock = sk->sk_socket;
 
 	if (!sock)
 		return -EINVAL;
-	return kernel_sendpage(sock, page, offset, size, flags);
+	return sock_sendmsg(sock, msg);
 }
 
-typedef int (*sendmsg_func)(struct sock *sk, struct msghdr *msg,
-			    struct kvec *vec, size_t num, size_t size);
-typedef int (*sendpage_func)(struct sock *sk, struct page *page, int offset,
-			     size_t size, int flags);
+typedef int (*sendmsg_func)(struct sock *sk, struct msghdr *msg);
 static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
-			   int len, sendmsg_func sendmsg, sendpage_func sendpage)
+			   int len, sendmsg_func sendmsg)
 {
 	unsigned int orig_len = len;
 	struct sk_buff *head = skb;
@@ -3034,8 +3034,9 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		memset(&msg, 0, sizeof(msg));
 		msg.msg_flags = MSG_DONTWAIT;
 
-		ret = INDIRECT_CALL_2(sendmsg, kernel_sendmsg_locked,
-				      sendmsg_unlocked, sk, &msg, &kv, 1, slen);
+		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &kv, 1, slen);
+		ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
+				      sendmsg_unlocked, sk, &msg);
 		if (ret <= 0)
 			goto error;
 
@@ -3066,11 +3067,18 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		slen = min_t(size_t, len, skb_frag_size(frag) - offset);
 
 		while (slen) {
-			ret = INDIRECT_CALL_2(sendpage, kernel_sendpage_locked,
-					      sendpage_unlocked, sk,
-					      skb_frag_page(frag),
-					      skb_frag_off(frag) + offset,
-					      slen, MSG_DONTWAIT);
+			struct bio_vec bvec;
+			struct msghdr msg = {
+				.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT,
+			};
+
+			bvec_set_page(&bvec, skb_frag_page(frag), slen,
+				      skb_frag_off(frag) + offset);
+			iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1,
+				      slen);
+
+			ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
+					      sendmsg_unlocked, sk, &msg);
 			if (ret <= 0)
 				goto error;
 
@@ -3107,16 +3115,14 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 int skb_send_sock_locked(struct sock *sk, struct sk_buff *skb, int offset,
 			 int len)
 {
-	return __skb_send_sock(sk, skb, offset, len, kernel_sendmsg_locked,
-			       kernel_sendpage_locked);
+	return __skb_send_sock(sk, skb, offset, len, sendmsg_locked);
 }
 EXPORT_SYMBOL_GPL(skb_send_sock_locked);
 
 /* Send skb data on a socket. Socket must be unlocked. */
 int skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset, int len)
 {
-	return __skb_send_sock(sk, skb, offset, len, sendmsg_unlocked,
-			       sendpage_unlocked);
+	return __skb_send_sock(sk, skb, offset, len, sendmsg_unlocked);
 }
 
 /**

