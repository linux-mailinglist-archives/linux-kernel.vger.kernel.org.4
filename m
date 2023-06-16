Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDB873358B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343913AbjFPQOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240201AbjFPQOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73274359D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686932002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/uSTCkptTsC4xYTqgPPYvFLo6KQm6ldgKXcPsN3l6RA=;
        b=dyif0BDg4cCQUc2PxbFVZkyW4cUKW0rP//ySlFJzmjtUSZXZrk0TeqboB31rwXngErOdPa
        Zr11JATJDKdCrS6vKSsAg42H701U3Qjs2u/eo3GSYDkdGF/vEVAJ50oqBjmOYHkoF0/MqK
        XuBoCZWrit7cqDMvbk5M9y6QwbijKp4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-0Z8wEYp2Nm2gZ4mNz8jpMA-1; Fri, 16 Jun 2023 12:13:19 -0400
X-MC-Unique: 0Z8wEYp2Nm2gZ4mNz8jpMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55C361C05ABF;
        Fri, 16 Jun 2023 16:13:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9325540CF8F6;
        Fri, 16 Jun 2023 16:13:14 +0000 (UTC)
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
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        Boris Pismenny <borisp@nvidia.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, bpf@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH net-next 03/17] tcp_bpf, smc, tls, espintcp: Reduce MSG_SENDPAGE_NOTLAST usage
Date:   Fri, 16 Jun 2023 17:12:46 +0100
Message-ID: <20230616161301.622169-4-dhowells@redhat.com>
In-Reply-To: <20230616161301.622169-1-dhowells@redhat.com>
References: <20230616161301.622169-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As MSG_SENDPAGE_NOTLAST is being phased out along with sendpage(), don't
use it further in than the sendpage methods, but rather translate it to
MSG_MORE and use that instead.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: John Fastabend <john.fastabend@gmail.com>
cc: Jakub Sitnicki <jakub@cloudflare.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: David Ahern <dsahern@kernel.org>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Karsten Graul <kgraul@linux.ibm.com>
cc: Wenjia Zhang <wenjia@linux.ibm.com>
cc: Jan Karcher <jaka@linux.ibm.com>
cc: "D. Wythe" <alibuda@linux.alibaba.com>
cc: Tony Lu <tonylu@linux.alibaba.com>
cc: Wen Gu <guwen@linux.alibaba.com>
cc: Boris Pismenny <borisp@nvidia.com>
cc: Steffen Klassert <steffen.klassert@secunet.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: netdev@vger.kernel.org
cc: bpf@vger.kernel.org
cc: linux-s390@vger.kernel.org
---
 net/ipv4/tcp_bpf.c   |  3 ---
 net/smc/smc_tx.c     |  6 ++++--
 net/tls/tls_device.c |  4 ++--
 net/xfrm/espintcp.c  | 10 ++++++----
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 5a84053ac62b..adcba77b0c50 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -111,9 +111,6 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 		if (has_tx_ulp)
 			msghdr.msg_flags |= MSG_SENDPAGE_NOPOLICY;
 
-		if (flags & MSG_SENDPAGE_NOTLAST)
-			msghdr.msg_flags |= MSG_MORE;
-
 		bvec_set_page(&bvec, page, size, off);
 		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, size);
 		ret = tcp_sendmsg_locked(sk, &msghdr, size);
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 45128443f1f1..9b9e0a190734 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -168,8 +168,7 @@ static bool smc_tx_should_cork(struct smc_sock *smc, struct msghdr *msg)
 	 * should known how/when to uncork it.
 	 */
 	if ((msg->msg_flags & MSG_MORE ||
-	     smc_tx_is_corked(smc) ||
-	     msg->msg_flags & MSG_SENDPAGE_NOTLAST) &&
+	     smc_tx_is_corked(smc)) &&
 	    atomic_read(&conn->sndbuf_space))
 		return true;
 
@@ -306,6 +305,9 @@ int smc_tx_sendpage(struct smc_sock *smc, struct page *page, int offset,
 	struct kvec iov;
 	int rc;
 
+	if (flags & MSG_SENDPAGE_NOTLAST)
+		msg.msg_flags |= MSG_MORE;
+
 	iov.iov_base = kaddr + offset;
 	iov.iov_len = size;
 	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, size);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index b82770f68807..975299d7213b 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -449,7 +449,7 @@ static int tls_push_data(struct sock *sk,
 		return -sk->sk_err;
 
 	flags |= MSG_SENDPAGE_DECRYPTED;
-	tls_push_record_flags = flags | MSG_SENDPAGE_NOTLAST;
+	tls_push_record_flags = flags | MSG_MORE;
 
 	timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
 	if (tls_is_partially_sent_record(tls_ctx)) {
@@ -532,7 +532,7 @@ static int tls_push_data(struct sock *sk,
 		if (!size) {
 last_record:
 			tls_push_record_flags = flags;
-			if (flags & (MSG_SENDPAGE_NOTLAST | MSG_MORE)) {
+			if (flags & MSG_MORE) {
 				more = true;
 				break;
 			}
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 3504925babdb..d3b3f9e720b3 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -205,13 +205,15 @@ static int espintcp_sendskb_locked(struct sock *sk, struct espintcp_msg *emsg,
 static int espintcp_sendskmsg_locked(struct sock *sk,
 				     struct espintcp_msg *emsg, int flags)
 {
-	struct msghdr msghdr = { .msg_flags = flags | MSG_SPLICE_PAGES, };
+	struct msghdr msghdr = {
+		.msg_flags = flags | MSG_SPLICE_PAGES | MSG_MORE,
+	};
 	struct sk_msg *skmsg = &emsg->skmsg;
+	bool more = flags & MSG_MORE;
 	struct scatterlist *sg;
 	int done = 0;
 	int ret;
 
-	msghdr.msg_flags |= MSG_SENDPAGE_NOTLAST;
 	sg = &skmsg->sg.data[skmsg->sg.start];
 	do {
 		struct bio_vec bvec;
@@ -221,8 +223,8 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
 
 		emsg->offset = 0;
 
-		if (sg_is_last(sg))
-			msghdr.msg_flags &= ~MSG_SENDPAGE_NOTLAST;
+		if (sg_is_last(sg) && !more)
+			msghdr.msg_flags &= ~MSG_MORE;
 
 		p = sg_page(sg);
 retry:

