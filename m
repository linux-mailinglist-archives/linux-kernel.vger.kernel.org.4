Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A338717DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbjEaLGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjEaLGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E66E52
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 04:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685531074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oo2uxP/MzmHd10a5KbN5Oq58DgcC9fhPDz9XsE6LWiI=;
        b=MCYDYhXw1c/wEc+USh+i2Ag+UmNzXMj7t2JTGX9nRyMxZOaKz7KUvAIOdi8BAmmc9XFD0o
        MkEO7gEq9gwkQ2hV5rd08ctRRL9cefU+moofg0FvkVzNwmaaa6mNhS8Yd4qUvlVtsGTqp8
        s3SS/SnR0eS+Gp6jTOwGOyY03PweuWU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-5MnFPOU1Pei6bNTHzvR1rw-1; Wed, 31 May 2023 07:04:32 -0400
X-MC-Unique: 5MnFPOU1Pei6bNTHzvR1rw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 015F4185A78B;
        Wed, 31 May 2023 11:04:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48C7A112132D;
        Wed, 31 May 2023 11:04:29 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Tom Herbert <tom@herbertland.com>,
        Tom Herbert <tom@quantonium.net>,
        Cong Wang <cong.wang@bytedance.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] kcm: Support MSG_SPLICE_PAGES
Date:   Wed, 31 May 2023 12:04:21 +0100
Message-ID: <20230531110423.643196-2-dhowells@redhat.com>
In-Reply-To: <20230531110423.643196-1-dhowells@redhat.com>
References: <20230531110423.643196-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make AF_KCM sendmsg() support MSG_SPLICE_PAGES.  This causes pages to be
spliced from the source iterator if possible.

This allows ->sendpage() to be replaced by something that can handle
multiple multipage folios in a single transaction.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Tom Herbert <tom@herbertland.com>
cc: Tom Herbert <tom@quantonium.net>
cc: Cong Wang <cong.wang@bytedance.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
---

Notes:
    ver #2)
     - Only account the amount actually copied.
     - Wrap at 80 chars.

 net/kcm/kcmsock.c | 57 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index cfe828bd7fc6..8555ede66333 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -989,29 +989,52 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 			merge = false;
 		}
 
-		copy = min_t(int, msg_data_left(msg),
-			     pfrag->size - pfrag->offset);
+		if (msg->msg_flags & MSG_SPLICE_PAGES) {
+			copy = msg_data_left(msg);
+			if (!sk_wmem_schedule(sk, copy))
+				goto wait_for_memory;
 
-		if (!sk_wmem_schedule(sk, copy))
-			goto wait_for_memory;
+			err = skb_splice_from_iter(skb, &msg->msg_iter, copy,
+						   sk->sk_allocation);
+			if (err < 0) {
+				if (err == -EMSGSIZE)
+					goto wait_for_memory;
+				goto out_error;
+			}
 
-		err = skb_copy_to_page_nocache(sk, &msg->msg_iter, skb,
-					       pfrag->page,
-					       pfrag->offset,
-					       copy);
-		if (err)
-			goto out_error;
+			copy = err;
+			skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
+			sk_wmem_queued_add(sk, copy);
+			sk_mem_charge(sk, copy);
 
-		/* Update the skb. */
-		if (merge) {
-			skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
+			if (head != skb)
+				head->truesize += copy;
 		} else {
-			skb_fill_page_desc(skb, i, pfrag->page,
-					   pfrag->offset, copy);
-			get_page(pfrag->page);
+			copy = min_t(int, msg_data_left(msg),
+				     pfrag->size - pfrag->offset);
+			if (!sk_wmem_schedule(sk, copy))
+				goto wait_for_memory;
+
+			err = skb_copy_to_page_nocache(sk, &msg->msg_iter, skb,
+						       pfrag->page,
+						       pfrag->offset,
+						       copy);
+			if (err)
+				goto out_error;
+
+			/* Update the skb. */
+			if (merge) {
+				skb_frag_size_add(
+					&skb_shinfo(skb)->frags[i - 1], copy);
+			} else {
+				skb_fill_page_desc(skb, i, pfrag->page,
+						   pfrag->offset, copy);
+				get_page(pfrag->page);
+			}
+
+			pfrag->offset += copy;
 		}
 
-		pfrag->offset += copy;
 		copied += copy;
 		if (head != skb) {
 			head->len += copy;

