Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33446726870
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjFGSWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjFGSVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:21:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0441FDB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686162027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IkTAZr7FImbpw2xGK0s50kcwLgB1Jva9F8sfMs3my/4=;
        b=ioAUqIfG4h4zxyH8Cb+PFoSyJwFhiQ6Sdn1OuIZdQfT5A22FMzguHPfsuvhyXj4UffFxcA
        p5qsukxaYB94sk8mypg/gIPQ/5WZZdAYd1HkyJtl/AxLU9Z2BCVWehQgugw+TqivtIX1Xq
        OuMmmKxUwMEaQa7DXwWY45MuZ4D9FQ8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-fnwzd9GMNVGNYa4DGCVeZg-1; Wed, 07 Jun 2023 14:20:09 -0400
X-MC-Unique: fnwzd9GMNVGNYa4DGCVeZg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89E833806704;
        Wed,  7 Jun 2023 18:20:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 692A51121314;
        Wed,  7 Jun 2023 18:20:00 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 06/14] tls/device: Use splice_eof() to flush
Date:   Wed,  7 Jun 2023 19:19:12 +0100
Message-ID: <20230607181920.2294972-7-dhowells@redhat.com>
In-Reply-To: <20230607181920.2294972-1-dhowells@redhat.com>
References: <20230607181920.2294972-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow splice to end a TLS record after prematurely ending a splice/sendfile
due to getting an EOF condition (->splice_read() returned 0) after splice
had called TLS with a sendmsg() with MSG_MORE set when the user didn't set
MSG_MORE.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/CAHk-=wh=V579PDYvkpnTobCLGczbgxpMgGmmhqiTyE34Cpi5Gg@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: Boris Pismenny <borisp@nvidia.com>
cc: John Fastabend <john.fastabend@gmail.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
---
 net/tls/tls.h        |  1 +
 net/tls/tls_device.c | 23 +++++++++++++++++++++++
 net/tls/tls_main.c   |  2 ++
 3 files changed, 26 insertions(+)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 4922668fefaa..d002c3af1966 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -116,6 +116,7 @@ ssize_t tls_sw_splice_read(struct socket *sock, loff_t *ppos,
 			   size_t len, unsigned int flags);
 
 int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
+void tls_device_splice_eof(struct socket *sock);
 int tls_device_sendpage(struct sock *sk, struct page *page,
 			int offset, size_t size, int flags);
 int tls_tx_records(struct sock *sk, int flags);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 9ef766e41c7a..439be833dcf9 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -590,6 +590,29 @@ int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	return rc;
 }
 
+void tls_device_splice_eof(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+	struct tls_context *tls_ctx = tls_get_ctx(sk);
+	union tls_iter_offset iter;
+	struct iov_iter iov_iter = {};
+
+	if (!tls_is_partially_sent_record(tls_ctx))
+		return;
+
+	mutex_lock(&tls_ctx->tx_lock);
+	lock_sock(sk);
+
+	if (tls_is_partially_sent_record(tls_ctx)) {
+		iov_iter_bvec(&iov_iter, ITER_SOURCE, NULL, 0, 0);
+		iter.msg_iter = &iov_iter;
+		tls_push_data(sk, iter, 0, 0, TLS_RECORD_TYPE_DATA, NULL);
+	}
+
+	release_sock(sk);
+	mutex_unlock(&tls_ctx->tx_lock);
+}
+
 int tls_device_sendpage(struct sock *sk, struct page *page,
 			int offset, size_t size, int flags)
 {
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 82ec5c654f32..7b9c83dd7de2 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1044,10 +1044,12 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 #ifdef CONFIG_TLS_DEVICE
 	prot[TLS_HW][TLS_BASE] = prot[TLS_BASE][TLS_BASE];
 	prot[TLS_HW][TLS_BASE].sendmsg		= tls_device_sendmsg;
+	prot[TLS_HW][TLS_BASE].splice_eof	= tls_device_splice_eof;
 	prot[TLS_HW][TLS_BASE].sendpage		= tls_device_sendpage;
 
 	prot[TLS_HW][TLS_SW] = prot[TLS_BASE][TLS_SW];
 	prot[TLS_HW][TLS_SW].sendmsg		= tls_device_sendmsg;
+	prot[TLS_HW][TLS_SW].splice_eof		= tls_device_splice_eof;
 	prot[TLS_HW][TLS_SW].sendpage		= tls_device_sendpage;
 
 	prot[TLS_BASE][TLS_HW] = prot[TLS_BASE][TLS_SW];

