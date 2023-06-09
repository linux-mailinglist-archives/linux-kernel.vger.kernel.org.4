Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863D5729695
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbjFIKPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240924AbjFIKOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:14:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B950C4231
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 03:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686304973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R74bPi2kwyePE/xmRN7KyjHRwIflZ6VoOr6lAl3jXjM=;
        b=X4sPd8sBzYwU+K110FCl7zOTDbjBCuSbkvFdMncuyzY1NkR5jxeq3k7bP0HCbA53y5dt5S
        zspkP2Iwq04M9M2B0k/OgV+COogPXe4hNYd55D0zq0rrmulPPt1pUQXfXlm34BYrFZbico
        RIA+15GxEpURf1kSgRp0U/KhSTpAqm4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-Y2G43H3wN2OR5zQ7GU9neg-1; Fri, 09 Jun 2023 06:02:42 -0400
X-MC-Unique: Y2G43H3wN2OR5zQ7GU9neg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6545785A5BA;
        Fri,  9 Jun 2023 10:02:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EEBF492B0A;
        Fri,  9 Jun 2023 10:02:39 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tom Herbert <tom@herbertland.com>,
        Tom Herbert <tom@quantonium.net>
Subject: [PATCH net-next 5/6] kcm: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Date:   Fri,  9 Jun 2023 11:02:20 +0100
Message-ID: <20230609100221.2620633-6-dhowells@redhat.com>
In-Reply-To: <20230609100221.2620633-1-dhowells@redhat.com>
References: <20230609100221.2620633-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When transmitting data, call down into the transport socket using sendmsg
with MSG_SPLICE_PAGES to indicate that content should be spliced rather
than using sendpage.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Tom Herbert <tom@herbertland.com>
cc: Tom Herbert <tom@quantonium.net>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
---
 net/kcm/kcmsock.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 7dee74430b59..3bcac1453f10 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -641,6 +641,10 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
 
 		for (fragidx = 0; fragidx < skb_shinfo(skb)->nr_frags;
 		     fragidx++) {
+			struct bio_vec bvec;
+			struct msghdr msg = {
+				.msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES,
+			};
 			skb_frag_t *frag;
 
 			frag_offset = 0;
@@ -651,11 +655,13 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
 				goto out;
 			}
 
-			ret = kernel_sendpage(psock->sk->sk_socket,
-					      skb_frag_page(frag),
-					      skb_frag_off(frag) + frag_offset,
-					      skb_frag_size(frag) - frag_offset,
-					      MSG_DONTWAIT);
+			bvec_set_page(&bvec,
+				      skb_frag_page(frag),
+				      skb_frag_size(frag) - frag_offset,
+				      skb_frag_off(frag) + frag_offset);
+			iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1,
+				      bvec.bv_len);
+			ret = sock_sendmsg(psock->sk->sk_socket, &msg);
 			if (ret <= 0) {
 				if (ret == -EAGAIN) {
 					/* Save state to try again when there's

