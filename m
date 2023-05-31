Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D352F717D84
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbjEaLBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbjEaLBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6B8123
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 04:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685530831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nBkFTCC6CO9wuSqa6TDRZsc4R0OnF4ofoS5g5iSEfa8=;
        b=dmjuwmsojq7lfQIeNhHGPAKSj0VbaoR2AdtBb20CowDX1oC8XW7rmuYnnTIWkEElWxuS9U
        goPAoRfCgDM2DHCwvEI+iva2hkOwmGGJmF4WG+VzM6v6m3IcOh5LU8jCRuSujhUW0WEIlb
        k/jZ65+pH26upt0p6LJHT2dK/iwQzJM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-W82jFm1ZNtOC3nNUdxtyIw-1; Wed, 31 May 2023 07:00:27 -0400
X-MC-Unique: W82jFm1ZNtOC3nNUdxtyIw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90765811E78;
        Wed, 31 May 2023 11:00:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86FBF421C3;
        Wed, 31 May 2023 11:00:21 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Simon Horman <simon.horman@corigine.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] chelsio: Convert chtls_sendpage() to use MSG_SPLICE_PAGES
Date:   Wed, 31 May 2023 12:00:08 +0100
Message-ID: <20230531110008.642903-3-dhowells@redhat.com>
In-Reply-To: <20230531110008.642903-1-dhowells@redhat.com>
References: <20230531110008.642903-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Notes:
    ver #2)
     - Do reverse-xmas tree variables.

 .../chelsio/inline_crypto/chtls/chtls_io.c    | 109 ++----------------
 1 file changed, 7 insertions(+), 102 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
index 1d08386ac916..5724bbbb6ee0 100644
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
+	struct msghdr msg = { .msg_flags = flags | MSG_SPLICE_PAGES, };
+	struct bio_vec bvec;
 
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

