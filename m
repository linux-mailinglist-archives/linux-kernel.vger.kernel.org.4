Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5311C655104
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 14:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbiLWNaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 08:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbiLWNaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 08:30:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE70B1DC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671802163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VvD5WoRcVCyUBj6AIlF+qids3aC+FV9CJvkUAki9soU=;
        b=AYqay1NCW13/anCLEjQtQ+MGMsINp290C+/eisEjj3QgQkuHTeGQroqddnS3Ex0RBSoQ8B
        fky1Hofe1BF5CxqZE5tz/Ea6oMsl40TxT0RQSjbwq8rWpLFfsLr84k9H9ogcbnl7VYEsMW
        sAVF7/+e9oxBbh/zOOPna6p619FqZ7A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-fIf4VAwANFeEED7cN8yb-w-1; Fri, 23 Dec 2022 08:29:21 -0500
X-MC-Unique: fIf4VAwANFeEED7cN8yb-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91F4685C6E0;
        Fri, 23 Dec 2022 13:29:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0DF32026D4B;
        Fri, 23 Dec 2022 13:29:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] rxrpc: Fix aborting of unexposed client calls
From:   David Howells <dhowells@redhat.com>
To:     marc.dionne@auristor.com
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 23 Dec 2022 13:29:20 +0000
Message-ID: <167180216018.2546024.11271443310737773038.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a client call gets completed early, before any DATA packets have been
transmitted, say by getting interrupted by a signal, it may still cause the
transmission of an ABORT packet (which is pointless).

Further, because the call didn't go through rxrpc_expose_client_call(), the
connection channel's call counter didn't get incremented.  This means that
the next call on that channel will have the same callNumber, and the server
will probably just abort it, causing an I/O error in kafs.

This, for example, can sometimes be induced with git checkout as that uses
an alarm to advance the progress display.  The signal generated may
interrupt the call whilst it's waiting for a channel, but the call still
sets up even if it is pending an abort, and then sends an abort instead of
the first data.

Fix this by the following means:

 (1) Always mark service calls as exposed (RXRPC_CALL_EXPOSED).

 (2) Don't mark client calls as exposed until they have data to transmit.

 (3) Don't send an ABORT packet unless exposed.

 (4) Do the connection of client calls after processing call-pokes so that
     early aborts have a chance to get dealt with first (it narrows the
     window, but can't eliminate it).

Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---

 net/rxrpc/call_event.c  |    6 ++++--
 net/rxrpc/call_object.c |    1 +
 net/rxrpc/call_state.c  |    3 ++-
 net/rxrpc/io_thread.c   |    6 +++---
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 91df6fbede9c..148bb7fc0415 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -305,9 +305,11 @@ static void rxrpc_decant_prepared_tx(struct rxrpc_call *call)
 {
 	struct rxrpc_txbuf *txb;
 
-	if (rxrpc_is_client_call(call) &&
-	    !test_bit(RXRPC_CALL_EXPOSED, &call->flags))
+	if (!test_bit(RXRPC_CALL_EXPOSED, &call->flags)) {
+		if (list_empty(&call->tx_sendmsg))
+			return;
 		rxrpc_expose_client_call(call);
+	}
 
 	while ((txb = list_first_entry_or_null(&call->tx_sendmsg,
 					       struct rxrpc_txbuf, call_link))) {
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 45cc16c1be15..75b6ad542fdc 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -455,6 +455,7 @@ void rxrpc_incoming_call(struct rxrpc_sock *rx,
 	call->cong_tstamp	= skb->tstamp;
 
 	rxrpc_set_call_state(call, RXRPC_CALL_SERVER_SECURING);
+	__set_bit(RXRPC_CALL_EXPOSED, &call->flags);
 
 	spin_lock(&conn->state_lock);
 
diff --git a/net/rxrpc/call_state.c b/net/rxrpc/call_state.c
index 59a5588805ac..fae42f733e85 100644
--- a/net/rxrpc/call_state.c
+++ b/net/rxrpc/call_state.c
@@ -49,7 +49,8 @@ bool rxrpc_abort_call(struct rxrpc_call *call, rxrpc_seq_t seq,
 	if (!rxrpc_set_call_completion(call, RXRPC_CALL_LOCALLY_ABORTED,
 				       abort_code, error))
 		return false;
-	rxrpc_send_abort_packet(call);
+	if (test_bit(RXRPC_CALL_EXPOSED, &call->flags))
+		rxrpc_send_abort_packet(call);
 	return true;
 }
 
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index 48e8bfd6e2ef..34d4a3a5cb72 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -435,9 +435,6 @@ int rxrpc_io_thread(void *data)
 				       &local->client_conn_flags))
 			rxrpc_discard_expired_client_conns(local);
 
-		if (!list_empty(&local->new_client_calls))
-			rxrpc_connect_client_calls(local);
-
 		/* Deal with calls that want immediate attention. */
 		if ((call = list_first_entry_or_null(&local->call_attend_q,
 						     struct rxrpc_call,
@@ -452,6 +449,9 @@ int rxrpc_io_thread(void *data)
 			continue;
 		}
 
+		if (!list_empty(&local->new_client_calls))
+			rxrpc_connect_client_calls(local);
+
 		/* Process received packets and errors. */
 		if ((skb = __skb_dequeue(&rx_queue))) {
 			struct rxrpc_skb_priv *sp = rxrpc_skb(skb);


