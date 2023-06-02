Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B3772057D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbjFBPJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbjFBPJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1D5E52
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685718502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GeaP7/vo94ZZDrAoROnlgLmkpbcL++cZl5U43JLGl7Y=;
        b=ZILjBOuXaBZFx/j7kah5/nSZvZSoEBPDxV/Ao9wvNxs/6wh7n7htuhXZrwIBJEo4rh5fln
        AFKyO+zdQs/qHXTHXN4v8M8iimeStyWHNAe2GhwgXb+PEq2dnRu97PpF8H+ZacToZ/WUzT
        OckRcHLv0cD45SAkfGZuX1Zd2XAoJAQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-r53cRdYeNt22xXrH4BTZSw-1; Fri, 02 Jun 2023 11:08:17 -0400
X-MC-Unique: r53cRdYeNt22xXrH4BTZSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77FF23C0BE49;
        Fri,  2 Jun 2023 15:08:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D52340CFD46;
        Fri,  2 Jun 2023 15:08:14 +0000 (UTC)
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
Subject: [PATCH net-next v3 03/11] tls/sw: Use zero-length sendmsg() without MSG_MORE to flush
Date:   Fri,  2 Jun 2023 16:07:44 +0100
Message-ID: <20230602150752.1306532-4-dhowells@redhat.com>
In-Reply-To: <20230602150752.1306532-1-dhowells@redhat.com>
References: <20230602150752.1306532-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow userspace to end a TLS record without supplying any data by calling
send()/sendto()/sendmsg() with no data and no MSG_MORE flag.  This can be
used to flush a previous send/splice that had MSG_MORE or SPLICE_F_MORE set
or a sendfile() that was incomplete.

Without this, a zero-length send to tls-sw is just ignored.  I think
tls-device will do the right thing without modification.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: Boris Pismenny <borisp@nvidia.com>
cc: John Fastabend <john.fastabend@gmail.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
---
 net/tls/tls_sw.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index cac1adc968e8..6aa6d17888f5 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -945,7 +945,7 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	struct tls_rec *rec;
 	int required_size;
 	int num_async = 0;
-	bool full_record;
+	bool full_record = false;
 	int record_room;
 	int num_zc = 0;
 	int orig_size;
@@ -971,6 +971,9 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		}
 	}
 
+	if (!msg_data_left(msg) && eor)
+		goto just_flush;
+
 	while (msg_data_left(msg)) {
 		if (sk->sk_err) {
 			ret = -sk->sk_err;
@@ -1082,6 +1085,7 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		 */
 		tls_ctx->pending_open_record_frags = true;
 		copied += try_to_copy;
+just_flush:
 		if (full_record || eor) {
 			ret = bpf_exec_tx_verdict(msg_pl, sk, full_record,
 						  record_type, &copied,

