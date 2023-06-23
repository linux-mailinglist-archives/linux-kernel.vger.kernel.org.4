Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582CD73C469
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjFWW5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjFWW5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01E62726
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687560939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CX0szcw738ZS8htZ0RxEmjBFgUMhbKSUPMuc1XxmplE=;
        b=OxYtO5QXs+6anAoo8ybaQoqEkNA/itNeJUDLcB34v0mNy01ePGe8KnQyr6AVPu12FpvQim
        mLXR6tKIkSlkKTIg/Mr78oe0b99sbU+bDPrzxbP7++fTw1VVOnYsP5J5k1L9PfqZOpxlCR
        OtWmSzvesd95qPkZKrj88AxgDg+K4EU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-3sv4_t5gNYKj7bwjVePyIQ-1; Fri, 23 Jun 2023 18:55:34 -0400
X-MC-Unique: 3sv4_t5gNYKj7bwjVePyIQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41DED380451C;
        Fri, 23 Jun 2023 22:55:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C49B40C2063;
        Fri, 23 Jun 2023 22:55:32 +0000 (UTC)
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
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com
Subject: [PATCH net-next v5 06/16] dlm: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
Date:   Fri, 23 Jun 2023 23:55:03 +0100
Message-ID: <20230623225513.2732256-7-dhowells@redhat.com>
In-Reply-To: <20230623225513.2732256-1-dhowells@redhat.com>
References: <20230623225513.2732256-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

When transmitting data, call down a layer using a single sendmsg with
MSG_SPLICE_PAGES to indicate that content should be spliced rather using
sendpage.  This allows ->sendpage() to be replaced by something that can
handle multiple multipage folios in a single transaction.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christine Caulfield <ccaulfie@redhat.com>
cc: David Teigland <teigland@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: cluster-devel@redhat.com
cc: netdev@vger.kernel.org
---
 fs/dlm/lowcomms.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 3d3802c47b8b..5c12d8cdfc16 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1395,8 +1395,11 @@ int dlm_lowcomms_resend_msg(struct dlm_msg *msg)
 /* Send a message */
 static int send_to_sock(struct connection *con)
 {
-	const int msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL;
 	struct writequeue_entry *e;
+	struct bio_vec bvec;
+	struct msghdr msg = {
+		.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT | MSG_NOSIGNAL,
+	};
 	int len, offset, ret;
 
 	spin_lock_bh(&con->writequeue_lock);
@@ -1412,8 +1415,9 @@ static int send_to_sock(struct connection *con)
 	WARN_ON_ONCE(len == 0 && e->users == 0);
 	spin_unlock_bh(&con->writequeue_lock);
 
-	ret = kernel_sendpage(con->sock, e->page, offset, len,
-			      msg_flags);
+	bvec_set_page(&bvec, e->page, len, offset);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
+	ret = sock_sendmsg(con->sock, &msg);
 	trace_dlm_send(con->nodeid, ret);
 	if (ret == -EAGAIN || ret == 0) {
 		lock_sock(con->sock->sk);

