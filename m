Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A283873650D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjFTHoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjFTHoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:44:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DF81706
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687246994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VKzVYTJU+Kltp7JOyEJXeiIKJE1OQId0BQJZ+m/qLVY=;
        b=YPVgSCpj6mrecIZgPi3zIwC8m/2UVUDDE+rJfqkdf7Tni9BfAhVtgeRM/3/SH29FT13eip
        K4lm7f6LRAoFCrDEB1U2LGTR6gUglFCTl4+0jbRjeUrl3bEpEYY74P9xMpRoxsIMHhSj9w
        Ko+py18S991J1ZiSZ4/yBLu6ALqvzyo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-C9n_X4hTPNCb8NjxbJyQtg-1; Tue, 20 Jun 2023 03:43:10 -0400
X-MC-Unique: C9n_X4hTPNCb8NjxbJyQtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10CBA809F8F;
        Tue, 20 Jun 2023 07:43:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0746B112132D;
        Tue, 20 Jun 2023 07:43:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000c6527105fe7fdab8@google.com>
References: <000000000000c6527105fe7fdab8@google.com>
To:     syzbot <syzbot+88f4b1e6cf88da11f5cd@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] general protection fault in shash_ahash_update
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1221048.1687246988.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 20 Jun 2023 08:43:08 +0100
Message-ID: <1221049.1687246988@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.g=
it main

    crypto: af_alg/hash: Fix recvmsg() after sendmsg(MSG_MORE)
    =

    If an AF_ALG socket bound to a hashing algorithm is sent a zero-length
    message with MSG_MORE set and then recvmsg() is called without first
    sending another message without MSG_MORE set to end the operation, an =
oops
    will occur because the crypto context and result doesn't now get set u=
p in
    advance because hash_sendmsg() now defers that as long as possible in =
the
    hope that it can use crypto_ahash_digest() - and then because the mess=
age
    is zero-length, it the data wrangling loop is skipped.
    =

    Fix this by always making a pass of the loop, even in the case that no=
 data
    is provided to the sendmsg().
    =

    Fix also extract_iter_to_sg() to handle a zero-length iterator by retu=
rning
    0 immediately.
    =

    Whilst we're at it, remove the code to create a kvmalloc'd scatterlist=
 if
    we get more than ALG_MAX_PAGES - this shouldn't happen.
    =

    Fixes: c662b043cdca ("crypto: af_alg/hash: Support MSG_SPLICE_PAGES")
    Reported-by: syzbot+13a08c0bf4d212766c3c@syzkaller.appspotmail.com
    Link: https://lore.kernel.org/r/000000000000b928f705fdeb873a@google.co=
m/
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

diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index dfb048cefb60..1176533a55c9 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -83,26 +83,14 @@ static int hash_sendmsg(struct socket *sock, struct ms=
ghdr *msg,
 =

 	ctx->more =3D false;
 =

-	while (msg_data_left(msg)) {
+	do {
 		ctx->sgl.sgt.sgl =3D ctx->sgl.sgl;
 		ctx->sgl.sgt.nents =3D 0;
 		ctx->sgl.sgt.orig_nents =3D 0;
 =

 		err =3D -EIO;
 		npages =3D iov_iter_npages(&msg->msg_iter, max_pages);
-		if (npages =3D=3D 0)
-			goto unlock_free;
-
-		if (npages > ARRAY_SIZE(ctx->sgl.sgl)) {
-			err =3D -ENOMEM;
-			ctx->sgl.sgt.sgl =3D
-				kvmalloc(array_size(npages,
-						    sizeof(*ctx->sgl.sgt.sgl)),
-					 GFP_KERNEL);
-			if (!ctx->sgl.sgt.sgl)
-				goto unlock_free;
-		}
-		sg_init_table(ctx->sgl.sgl, npages);
+		sg_init_table(ctx->sgl.sgl, max_t(size_t, npages, 1));
 =

 		ctx->sgl.need_unpin =3D iov_iter_extract_will_pin(&msg->msg_iter);
 =

@@ -111,7 +99,8 @@ static int hash_sendmsg(struct socket *sock, struct msg=
hdr *msg,
 		if (err < 0)
 			goto unlock_free;
 		len =3D err;
-		sg_mark_end(ctx->sgl.sgt.sgl + ctx->sgl.sgt.nents - 1);
+		if (len > 0)
+			sg_mark_end(ctx->sgl.sgt.sgl + ctx->sgl.sgt.nents - 1);
 =

 		if (!msg_data_left(msg)) {
 			err =3D hash_alloc_result(sk, ctx);
@@ -148,7 +137,7 @@ static int hash_sendmsg(struct socket *sock, struct ms=
ghdr *msg,
 =

 		copied +=3D len;
 		af_alg_free_sg(&ctx->sgl);
-	}
+	} while (msg_data_left(msg));
 =

 	ctx->more =3D msg->msg_flags & MSG_MORE;
 	err =3D 0;
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index e97d7060329e..77a7b18ee751 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -1340,7 +1340,7 @@ ssize_t extract_iter_to_sg(struct iov_iter *iter, si=
ze_t maxsize,
 			   struct sg_table *sgtable, unsigned int sg_max,
 			   iov_iter_extraction_t extraction_flags)
 {
-	if (maxsize =3D=3D 0)
+	if (!maxsize || !iter->count)
 		return 0;
 =

 	switch (iov_iter_type(iter)) {

