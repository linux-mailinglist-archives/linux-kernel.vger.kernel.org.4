Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4755D732F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344055AbjFPLL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjFPLL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:11:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAA5123
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686913842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rZB7JzdcM+W3WnooI0jXz6/MmOAa3ZILp9sqWdRbOG0=;
        b=BVvTJmI3uIjLbysQYCnC7Ak6Tu7zWiikgEUBKJ//GibCVfYbM0TAMa7E5nVr1mZ5K+4Xi0
        iTlvBWBm++BMQbnVirK/rc9c/AYP+9+tkEKADj2X1YSpazsa/4785iYtixhvVXTFMHVSU/
        muNIEqq9BXLJ2Lw9Oy8Le+cfgI5TGJk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-uDkYus20Nqim4-FY4-BJ_Q-1; Fri, 16 Jun 2023 07:10:37 -0400
X-MC-Unique: uDkYus20Nqim4-FY4-BJ_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4867B3804501;
        Fri, 16 Jun 2023 11:10:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0E522166B25;
        Fri, 16 Jun 2023 11:10:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
cc:     dhowells@redhat.com,
        syzbot+13a08c0bf4d212766c3c@syzkaller.appspotmail.com,
        syzbot+14234ccf6d0ef629ec1a@syzkaller.appspotmail.com,
        syzbot+4e2e47f32607d0f72d43@syzkaller.appspotmail.com,
        syzbot+472626bb5e7c59fb768f@syzkaller.appspotmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] crypto: af_alg/hash: Fix recvmsg() after sendmsg(MSG_MORE) 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <427645.1686913832.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 16 Jun 2023 12:10:32 +0100
Message-ID: <427646.1686913832@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an AF_ALG socket bound to a hashing algorithm is sent a zero-length
message with MSG_MORE set and then recvmsg() is called without first
sending another message without MSG_MORE set to end the operation, an oops
will occur because the crypto context and result doesn't now get set up in
advance because hash_sendmsg() now defers that as long as possible in the
hope that it can use crypto_ahash_digest() - and then because the message
is zero-length, it the data wrangling loop is skipped.

Fix this by handling zero-length sends at the top of the hash_sendmsg()
function.  If we're not continuing the previous sendmsg(), then just ignor=
e
the send (hash_recvmsg() will invent something when called); if we are
continuing, then we finalise the request at this point if MSG_MORE is not
set to get any error here, otherwise the send is of no effect and can be
ignored.

Whilst we're at it, remove the code to create a kvmalloc'd scatterlist if
we get more than ALG_MAX_PAGES - this shouldn't happen.

Fixes: c662b043cdca ("crypto: af_alg/hash: Support MSG_SPLICE_PAGES")
Reported-by: syzbot+13a08c0bf4d212766c3c@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/000000000000b928f705fdeb873a@google.com/
Reported-by: syzbot+14234ccf6d0ef629ec1a@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/000000000000c047db05fdeb8790@google.com/
Reported-by: syzbot+4e2e47f32607d0f72d43@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/000000000000bcca3205fdeb87fb@google.com/
Reported-by: syzbot+472626bb5e7c59fb768f@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/000000000000b55d8805fdeb8385@google.com/
Signed-off-by: David Howells <dhowells@redhat.com>
Reported-and-tested-by: syzbot+6efc50cc1f8d718d6cb7@syzkaller.appspotmail.=
com
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
 crypto/algif_hash.c |   38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index dfb048cefb60..0ab43e149f0e 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -76,13 +76,30 @@ static int hash_sendmsg(struct socket *sock, struct ms=
ghdr *msg,
 =

 	lock_sock(sk);
 	if (!continuing) {
-		if ((msg->msg_flags & MSG_MORE))
-			hash_free_result(sk, ctx);
+		/* Discard a previous request that wasn't marked MSG_MORE. */
+		hash_free_result(sk, ctx);
+		if (!msg_data_left(msg))
+			goto done; /* Zero-length; don't start new req */
 		need_init =3D true;
+	} else if (!msg_data_left(msg)) {
+		/*
+		 * No data - finalise the prev req if MSG_MORE so any error
+		 * comes out here.
+		 */
+		if (!(msg->msg_flags & MSG_MORE)) {
+			err =3D hash_alloc_result(sk, ctx);
+			if (err)
+				goto unlock_free;
+			ahash_request_set_crypt(&ctx->req, NULL,
+						ctx->result, 0);
+			err =3D crypto_wait_req(crypto_ahash_final(&ctx->req),
+					      &ctx->wait);
+			if (err)
+				goto unlock_free;
+		}
+		goto done_more;
 	}
 =

-	ctx->more =3D false;
-
 	while (msg_data_left(msg)) {
 		ctx->sgl.sgt.sgl =3D ctx->sgl.sgl;
 		ctx->sgl.sgt.nents =3D 0;
@@ -93,15 +110,6 @@ static int hash_sendmsg(struct socket *sock, struct ms=
ghdr *msg,
 		if (npages =3D=3D 0)
 			goto unlock_free;
 =

-		if (npages > ARRAY_SIZE(ctx->sgl.sgl)) {
-			err =3D -ENOMEM;
-			ctx->sgl.sgt.sgl =3D
-				kvmalloc(array_size(npages,
-						    sizeof(*ctx->sgl.sgt.sgl)),
-					 GFP_KERNEL);
-			if (!ctx->sgl.sgt.sgl)
-				goto unlock_free;
-		}
 		sg_init_table(ctx->sgl.sgl, npages);
 =

 		ctx->sgl.need_unpin =3D iov_iter_extract_will_pin(&msg->msg_iter);
@@ -150,7 +158,9 @@ static int hash_sendmsg(struct socket *sock, struct ms=
ghdr *msg,
 		af_alg_free_sg(&ctx->sgl);
 	}
 =

+done_more:
 	ctx->more =3D msg->msg_flags & MSG_MORE;
+done:
 	err =3D 0;
 unlock:
 	release_sock(sk);
@@ -158,6 +168,8 @@ static int hash_sendmsg(struct socket *sock, struct ms=
ghdr *msg,
 =

 unlock_free:
 	af_alg_free_sg(&ctx->sgl);
+	hash_free_result(sk, ctx);
+	ctx->more =3D false;
 	goto unlock;
 }
 =

