Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE95644887
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiLFQBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbiLFQAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:00:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D8625280
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670342349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nmigP3k6Qx9QEVAMxcTnG9wC9LGTkqBwXTGblbqUYvo=;
        b=cVWO+UsqSRmvqj0ZsCFHiOWS9HKnvrUsMng+mYfINVNxMKI8QYFP/EuGDD536EJWqH5imb
        X1K+C3ryitYSiHi5G1rtzPkxk7VZnW+IeRwIu6d9r+IVXcZl6m/E8Kp/fWLZSaKhvvbuVW
        Wir4w27n3ot35HTEIFK6Yy3Y1cXCyc4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-uhWI_sMSOWaY62kUaHjUVw-1; Tue, 06 Dec 2022 10:59:05 -0500
X-MC-Unique: uhWI_sMSOWaY62kUaHjUVw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F14AB3C02B7C;
        Tue,  6 Dec 2022 15:59:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 589B6492B04;
        Tue,  6 Dec 2022 15:59:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 03/32] rxrpc: Simplify rxrpc_implicit_end_call()
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Dec 2022 15:59:01 +0000
Message-ID: <167034234176.1105287.11630154459420260928.stgit@warthog.procyon.org.uk>
In-Reply-To: <167034231605.1105287.1693064952174322878.stgit@warthog.procyon.org.uk>
References: <167034231605.1105287.1693064952174322878.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rxrpc_implicit_end_call() can be simplified a bit as it should call
rxrpc_disconnect_call() now that it's being run in process context.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---

 net/rxrpc/input.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index d0e20e946e48..dbd92f09c2ca 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -998,8 +998,6 @@ void rxrpc_input_call_packet(struct rxrpc_call *call, struct sk_buff *skb)
  */
 void rxrpc_implicit_end_call(struct rxrpc_call *call, struct sk_buff *skb)
 {
-	struct rxrpc_connection *conn = call->conn;
-
 	switch (READ_ONCE(call->state)) {
 	case RXRPC_CALL_SERVER_AWAIT_ACK:
 		rxrpc_call_completed(call);
@@ -1014,8 +1012,5 @@ void rxrpc_implicit_end_call(struct rxrpc_call *call, struct sk_buff *skb)
 	}
 
 	rxrpc_input_call_event(call, skb);
-
-	spin_lock(&conn->bundle->channel_lock);
-	__rxrpc_disconnect_call(conn, call);
-	spin_unlock(&conn->bundle->channel_lock);
+	rxrpc_disconnect_call(call);
 }


