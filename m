Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C533270F920
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbjEXOuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbjEXOuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE640132
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684939775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nothT9FIq6Z9ycyWUkVIpgNT4wFVAcCVf2ceuhBnnpo=;
        b=N3LVHuhMSGMUeh7t8mh2CLXacIM1bnQev/vNnMjHLFViN1Mt8PAA/VnjcEuQOD9KSr4lLC
        +qwj0hmOS7bpoiFxSQGAg8hCmkTQMmKH80q6IX0lo6W1j8JWAf+RXarfMTXulPzB5sjJcx
        PCeKythOcfkC5L8HL9bZAVA3L5CdP4s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-z3GsRf65Owi5Meq-H94WQA-1; Wed, 24 May 2023 10:49:34 -0400
X-MC-Unique: z3GsRf65Owi5Meq-H94WQA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 272A68007D9;
        Wed, 24 May 2023 14:49:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63B86492B0A;
        Wed, 24 May 2023 14:49:31 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>
Subject: [PATCH net-next 2/4] chelsio: Convert chtls_sendpage() to use MSG_SPLICE_PAGES
Date:   Wed, 24 May 2023 15:49:21 +0100
Message-Id: <20230524144923.3623536-3-dhowells@redhat.com>
In-Reply-To: <20230524144923.3623536-1-dhowells@redhat.com>
References: <20230524144923.3623536-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert chtls_sendpage() to use sendmsg() with MSG_SPLICE_PAGES rather than
directly splicing in the pages itself.

This allows ->sendpage() to be replaced by something that can handle
multiple multipage folios in a single transaction.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Ayush Sawal <ayush.sawal@chelsio.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
---
 .../chelsio/inline_crypto/chtls/chtls_io.c    | 109 ++----------------
 1 file changed, 7 insertions(+), 102 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
index 1d08386ac916..65efd20ec796 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
@@ -1240,110 +1240,15 @@ int chtls_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 int chtls_sendpage(struct sock *sk, struct page *page,
 		   int offset, size_t size, int flags)
 {
-	struct chtls_sock *csk;
-	struct chtls_dev *cdev;
-	int mss, err, copied;
-	struct tcp_sock *tp;
-	long timeo;
-
-	tp = tcp_sk(sk);
-	copied = 0;
-	csk = rcu_dereference_sk_user_data(sk);
-	cdev = csk->cdev;
-	lock_sock(sk);
-	timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
+	struct bio_vec bvec;
+	struct msghdr msg = { .msg_flags = flags | MSG_SPLICE_PAGES, };
 
-	err = sk_stream_wait_connect(sk, &timeo);
-	if (!sk_in_state(sk, TCPF_ESTABLISHED | TCPF_CLOSE_WAIT) &&
-	    err != 0)
-		goto out_err;
-
-	mss = csk->mss;
-	csk_set_flag(csk, CSK_TX_MORE_DATA);
-
-	while (size > 0) {
-		struct sk_buff *skb = skb_peek_tail(&csk->txq);
-		int copy, i;
-
-		if (!skb || (ULP_SKB_CB(skb)->flags & ULPCB_FLAG_NO_APPEND) ||
-		    (copy = mss - skb->len) <= 0) {
-new_buf:
-			if (!csk_mem_free(cdev, sk))
-				goto wait_for_sndbuf;
+	if (flags & MSG_SENDPAGE_NOTLAST)
+		msg.msg_flags |= MSG_MORE;
 
-			if (is_tls_tx(csk)) {
-				skb = get_record_skb(sk,
-						     select_size(sk, size,
-								 flags,
-								 TX_TLSHDR_LEN),
-						     true);
-			} else {
-				skb = get_tx_skb(sk, 0);
-			}
-			if (!skb)
-				goto wait_for_memory;
-			copy = mss;
-		}
-		if (copy > size)
-			copy = size;
-
-		i = skb_shinfo(skb)->nr_frags;
-		if (skb_can_coalesce(skb, i, page, offset)) {
-			skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
-		} else if (i < MAX_SKB_FRAGS) {
-			get_page(page);
-			skb_fill_page_desc(skb, i, page, offset, copy);
-		} else {
-			tx_skb_finalize(skb);
-			push_frames_if_head(sk);
-			goto new_buf;
-		}
-
-		skb->len += copy;
-		if (skb->len == mss)
-			tx_skb_finalize(skb);
-		skb->data_len += copy;
-		skb->truesize += copy;
-		sk->sk_wmem_queued += copy;
-		tp->write_seq += copy;
-		copied += copy;
-		offset += copy;
-		size -= copy;
-
-		if (corked(tp, flags) &&
-		    (sk_stream_wspace(sk) < sk_stream_min_wspace(sk)))
-			ULP_SKB_CB(skb)->flags |= ULPCB_FLAG_NO_APPEND;
-
-		if (!size)
-			break;
-
-		if (unlikely(ULP_SKB_CB(skb)->flags & ULPCB_FLAG_NO_APPEND))
-			push_frames_if_head(sk);
-		continue;
-wait_for_sndbuf:
-		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
-wait_for_memory:
-		err = csk_wait_memory(cdev, sk, &timeo);
-		if (err)
-			goto do_error;
-	}
-out:
-	csk_reset_flag(csk, CSK_TX_MORE_DATA);
-	if (copied)
-		chtls_tcp_push(sk, flags);
-done:
-	release_sock(sk);
-	return copied;
-
-do_error:
-	if (copied)
-		goto out;
-
-out_err:
-	if (csk_conn_inline(csk))
-		csk_reset_flag(csk, CSK_TX_MORE_DATA);
-	copied = sk_stream_error(sk, flags, err);
-	goto done;
+	bvec_set_page(&bvec, page, size, offset);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
+	return chtls_sendmsg(sk, &msg, size);
 }
 
 static void chtls_select_window(struct sock *sk)

