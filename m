Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B4E6448C3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiLFQIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbiLFQHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:07:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE8A2EF04
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 08:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670342567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=znQW4z4SYi8+QaTrNWHj3KVEHYa3n71qqjUAiVgQv9c=;
        b=BCTkAlqcF0Z55yLbgMywazleHNAtam6teAFQSNNAUZjb/93neOrvok2wq8SrMFTyn6WIPy
        MtUSTOEuV7+iaSOeApkvif7bOMkbCugPlVu+P8ycZqDk6hZH12fcC/mOco08n5WmrDzd/Y
        zOYnSGHNYl9zljI/2g5w1EmaecarmH0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-3hGmvom-N3iEHc874NyDFw-1; Tue, 06 Dec 2022 11:02:43 -0500
X-MC-Unique: 3hGmvom-N3iEHc874NyDFw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96A79811E75;
        Tue,  6 Dec 2022 16:02:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0E0F2166B26;
        Tue,  6 Dec 2022 16:02:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 29/32] rxrpc: Show consumed and freed packets as
 non-dropped in dropwatch
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Dec 2022 16:02:41 +0000
Message-ID: <167034256128.1105287.11921813097806982711.stgit@warthog.procyon.org.uk>
In-Reply-To: <167034231605.1105287.1693064952174322878.stgit@warthog.procyon.org.uk>
References: <167034231605.1105287.1693064952174322878.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set a reason when freeing a packet that has been consumed such that
dropwatch doesn't complain that it has been dropped.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---

 net/rxrpc/skbuff.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/skbuff.c b/net/rxrpc/skbuff.c
index ebe0c75e7b07..944320e65ea8 100644
--- a/net/rxrpc/skbuff.c
+++ b/net/rxrpc/skbuff.c
@@ -63,7 +63,7 @@ void rxrpc_free_skb(struct sk_buff *skb, enum rxrpc_skb_trace why)
 	if (skb) {
 		int n = atomic_dec_return(select_skb_count(skb));
 		trace_rxrpc_skb(skb, refcount_read(&skb->users), n, why);
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_CONSUMED);
 	}
 }
 
@@ -78,6 +78,6 @@ void rxrpc_purge_queue(struct sk_buff_head *list)
 		int n = atomic_dec_return(select_skb_count(skb));
 		trace_rxrpc_skb(skb, refcount_read(&skb->users), n,
 				rxrpc_skb_put_purge);
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_CONSUMED);
 	}
 }


