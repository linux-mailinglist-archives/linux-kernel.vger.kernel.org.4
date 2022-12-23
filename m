Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB78065511A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 14:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbiLWNyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 08:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWNyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 08:54:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A3E36D7D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671803635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Eo5vy7CxPe4rWaDySLuIjSQPJW2FSEhi4UeYhEr0t7U=;
        b=LMSOnVu9P7Owbxd/3N2eL8YzsM33bdMVGKNa9vAlTzBomOMFSovGvOcIFxYLzK2Vpajz0G
        3v9ouQTc08h3jLzyTYack58NT7S1VV+OtpWW3rkEok/R9K7erEq3vzRfLkg1FLGVgRCkK0
        PNLV8bvUScv5mc1ZV8pob5NhQeFEiHA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-F2dhbJ-yOQ6WjapwTdNjHw-1; Fri, 23 Dec 2022 08:53:54 -0500
X-MC-Unique: F2dhbJ-yOQ6WjapwTdNjHw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C2558F6E82;
        Fri, 23 Dec 2022 13:53:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF82A2026D4B;
        Fri, 23 Dec 2022 13:53:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] rxrpc: Fix oops due to abort delegated to
 rxrpc_input_call_event()
From:   David Howells <dhowells@redhat.com>
To:     marc.dionne@auristor.com
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 23 Dec 2022 13:53:52 +0000
Message-ID: <167180363292.2552292.16128486005167315554.stgit@warthog.procyon.org.uk>
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

When sendmsg or recvmsg delegate an abort to the I/O thread, this is
processed by rxrpc_input_call_event().  But this may get called before the
call is connected, in which case call->conn might be NULL still.  This can
cause an oops, whereby we go on from aborting the call to trying to emit
ACKs and the attempt to allocate a txbuf for the ACK goes splat:

    BUG: kernel NULL pointer dereference, address: 0000000000000000
    ...
    RIP: 0010:rxrpc_alloc_txbuf+0xc0/0x157
    ...
    Call Trace:
     rxrpc_send_ACK+0x50/0x13b
     rxrpc_input_call_event+0x1bc/0x68b
     rxrpc_io_thread+0x1b6/0x45f
     kthread+0xe7/0xef
     ret_from_fork+0x22/0x30

Fix this by going to the cleanup in rxrpc_input_call_event() and skipping
the ACK generation stuff, etc. if we complete the delegation of an ABORT
packet.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---

 net/rxrpc/call_event.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 148bb7fc0415..ce3cad298449 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -395,9 +395,11 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 	}
 
 	abort_code = smp_load_acquire(&call->send_abort);
-	if (abort_code)
+	if (abort_code) {
 		rxrpc_abort_call(call, 0, call->send_abort, call->send_abort_err,
 				 call->send_abort_why);
+		goto out;
+	}
 
 	if (skb && skb->mark == RXRPC_SKB_MARK_ERROR)
 		goto out;


