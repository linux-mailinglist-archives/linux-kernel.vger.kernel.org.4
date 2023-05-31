Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573B2717D83
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbjEaLBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjEaLBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845F8129
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 04:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685530827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=97CTgaKk+HjxMsHB1NZqYRmtg/935y1khOuMG78saNk=;
        b=MYCEmZplyZkTpDhH0b5lZtPIWa2nW+xa3zhd+YFwINowjFWw1mpQu7vCBxneQbj9IQZK2b
        QvirN5ttp/FkT+SR9xA9xaJ+UR5uQkcmrEeQEDZqsiN9Vugoz8fne6aSYrxKaO0/WP64KC
        9Voajwis2cR8m4u41UVDfzJHvoXzueE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-3tfZ-SxcM6qaXos3TuNsaQ-1; Wed, 31 May 2023 07:00:21 -0400
X-MC-Unique: 3tfZ-SxcM6qaXos3TuNsaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA646101AA42;
        Wed, 31 May 2023 11:00:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E15D72166B25;
        Wed, 31 May 2023 11:00:18 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Simon Horman <simon.horman@corigine.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] chelsio: Support MSG_SPLICE_PAGES
Date:   Wed, 31 May 2023 12:00:07 +0100
Message-ID: <20230531110008.642903-2-dhowells@redhat.com>
In-Reply-To: <20230531110008.642903-1-dhowells@redhat.com>
References: <20230531110008.642903-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make Chelsio's TLS offload sendmsg() support MSG_SPLICE_PAGES, splicing in
pages from the source iterator if possible and copying the data in
otherwise.

This allows ->sendpage() to be replaced by something that can handle
multiple multipage folios in a single transaction.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Ayush Sawal <ayush.sawal@chelsio.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
---
 .../ethernet/chelsio/inline_crypto/chtls/chtls_io.c  | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
index ae6b17b96bf1..1d08386ac916 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
@@ -1092,7 +1092,17 @@ int chtls_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		if (copy > size)
 			copy = size;
 
-		if (skb_tailroom(skb) > 0) {
+		if (msg->msg_flags & MSG_SPLICE_PAGES) {
+			err = skb_splice_from_iter(skb, &msg->msg_iter, copy,
+						   sk->sk_allocation);
+			if (err < 0) {
+				if (err == -EMSGSIZE)
+					goto new_buf;
+				goto do_fault;
+			}
+			copy = err;
+			sk_wmem_queued_add(sk, copy);
+		} else if (skb_tailroom(skb) > 0) {
 			copy = min(copy, skb_tailroom(skb));
 			if (is_tls_tx(csk))
 				copy = min_t(int, copy, csk->tlshws.txleft);

