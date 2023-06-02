Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1E2720588
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbjFBPJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbjFBPJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:09:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AD0E41
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685718524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1bosU+FfxRloSp1wkQbe5FyZjgR/CpUzjqQmhn8VOU=;
        b=XSK5j4vASOImozX0qe4hzxcz/uK711ej2eOOYUvLPorXWnzfvrjm2/H6gZPd+1pUk/mhq4
        3TM6gXr4JjzwBqvLndNFc3mmmNgIWc2Y/jA+kXXxV6KsShIk26mryVROjXPm8sS1NNoG0z
        TGdTkp4BPsku9ypYK26VBu6ahaaX8So=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-i_fo6rKYNaiI2OVO_0s6fw-1; Fri, 02 Jun 2023 11:08:41 -0400
X-MC-Unique: i_fo6rKYNaiI2OVO_0s6fw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A77CA8028B2;
        Fri,  2 Jun 2023 15:08:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 785D0492B0C;
        Fri,  2 Jun 2023 15:08:37 +0000 (UTC)
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
Subject: [PATCH net-next v3 09/11] tls/device: Support MSG_SPLICE_PAGES
Date:   Fri,  2 Jun 2023 16:07:50 +0100
Message-ID: <20230602150752.1306532-10-dhowells@redhat.com>
In-Reply-To: <20230602150752.1306532-1-dhowells@redhat.com>
References: <20230602150752.1306532-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make TLS's device sendmsg() support MSG_SPLICE_PAGES.  This causes pages to
be spliced from the source iterator if possible.

This allows ->sendpage() to be replaced by something that can handle
multiple multipage folios in a single transaction.

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
 net/tls/tls_device.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 9ef766e41c7a..f2f1aff19e4a 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -509,6 +509,29 @@ static int tls_push_data(struct sock *sk,
 			tls_append_frag(record, &zc_pfrag, copy);
 
 			iter_offset.offset += copy;
+		} else if (copy && (flags & MSG_SPLICE_PAGES)) {
+			struct page_frag zc_pfrag;
+			struct page **pages = &zc_pfrag.page;
+			size_t off;
+
+			rc = iov_iter_extract_pages(iter_offset.msg_iter,
+						    &pages, copy, 1, 0, &off);
+			if (rc <= 0) {
+				if (rc == 0)
+					rc = -EIO;
+				goto handle_error;
+			}
+			copy = rc;
+
+			if (WARN_ON_ONCE(!sendpage_ok(zc_pfrag.page))) {
+				iov_iter_revert(iter_offset.msg_iter, copy);
+				rc = -EIO;
+				goto handle_error;
+			}
+
+			zc_pfrag.offset = off;
+			zc_pfrag.size = copy;
+			tls_append_frag(record, &zc_pfrag, copy);
 		} else if (copy) {
 			copy = min_t(size_t, copy, pfrag->size - pfrag->offset);
 
@@ -572,6 +595,9 @@ int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	union tls_iter_offset iter;
 	int rc;
 
+	if (!tls_ctx->zerocopy_sendfile)
+		msg->msg_flags &= ~MSG_SPLICE_PAGES;
+
 	mutex_lock(&tls_ctx->tx_lock);
 	lock_sock(sk);
 

