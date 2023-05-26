Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABCE71286E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbjEZOdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243919AbjEZOcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:32:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF34E4A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 07:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685111494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKSB6Rx2bx1fJ9JqD5rxOprNdt4epz1O6h3wMG9pSn8=;
        b=KHOkzd5lRm+ultlkisEB58rMjQoNdqjgUzqkdS71VQZbZR9Rq3YppY9j2Tw0Q9I7Rf4Wad
        7y8nRvP7LiZ9MvAMw0/pl+7rCVnIo1b/5/4GDWjSnj2LlISxrJxwcGhI0Uxju+M2ryOdUV
        3YM2vJdOxdBysX3FgN6QxQ4TrMDcTRQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-jLnS6QVHOfGVhUBPQMxYFw-1; Fri, 26 May 2023 10:31:25 -0400
X-MC-Unique: jLnS6QVHOfGVhUBPQMxYFw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0AC7B3855561;
        Fri, 26 May 2023 14:31:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25EEC140E95D;
        Fri, 26 May 2023 14:31:23 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-crypto@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/8] crypto: af_alg: Indent the loop in af_alg_sendmsg()
Date:   Fri, 26 May 2023 15:31:01 +0100
Message-Id: <20230526143104.882842-6-dhowells@redhat.com>
In-Reply-To: <20230526143104.882842-1-dhowells@redhat.com>
References: <20230526143104.882842-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put the loop in af_alg_sendmsg() into an if-statement to indent it to make
the next patch easier to review as that will add another branch to handle
MSG_SPLICE_PAGES to the if-statement.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-crypto@vger.kernel.org
cc: netdev@vger.kernel.org
---
 crypto/af_alg.c | 50 +++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 8a35f1364ac3..17ecaae50af7 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1030,35 +1030,37 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		if (sgl->cur)
 			sg_unmark_end(sg + sgl->cur - 1);
 
-		do {
-			struct page *pg;
-			unsigned int i = sgl->cur;
+		if (1 /* TODO check MSG_SPLICE_PAGES */) {
+			do {
+				struct page *pg;
+				unsigned int i = sgl->cur;
 
-			plen = min_t(size_t, len, PAGE_SIZE);
+				plen = min_t(size_t, len, PAGE_SIZE);
 
-			pg = alloc_page(GFP_KERNEL);
-			if (!pg) {
-				err = -ENOMEM;
-				goto unlock;
-			}
+				pg = alloc_page(GFP_KERNEL);
+				if (!pg) {
+					err = -ENOMEM;
+					goto unlock;
+				}
 
-			sg_assign_page(sg + i, pg);
+				sg_assign_page(sg + i, pg);
 
-			err = memcpy_from_msg(page_address(sg_page(sg + i)),
-					      msg, plen);
-			if (err) {
-				__free_page(sg_page(sg + i));
-				sg_assign_page(sg + i, NULL);
-				goto unlock;
-			}
+				err = memcpy_from_msg(page_address(sg_page(sg + i)),
+						      msg, plen);
+				if (err) {
+					__free_page(sg_page(sg + i));
+					sg_assign_page(sg + i, NULL);
+					goto unlock;
+				}
 
-			sg[i].length = plen;
-			len -= plen;
-			ctx->used += plen;
-			copied += plen;
-			size -= plen;
-			sgl->cur++;
-		} while (len && sgl->cur < MAX_SGL_ENTS);
+				sg[i].length = plen;
+				len -= plen;
+				ctx->used += plen;
+				copied += plen;
+				size -= plen;
+				sgl->cur++;
+			} while (len && sgl->cur < MAX_SGL_ENTS);
+		}
 
 		if (!size)
 			sg_mark_end(sg + sgl->cur - 1);

