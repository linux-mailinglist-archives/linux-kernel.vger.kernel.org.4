Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F8A732466
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 03:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjFPBCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 21:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjFPBCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 21:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD572972
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 18:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686877284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RVS2CDGv8MXaquA/9hvN5l2wqMBpBpyGhN0hUvKYgmY=;
        b=PjEbJt8SLOmfAPrdPxcbbkS2dfPmg2Cz4mYXSiL75NwTC0ZjYgCUoxz2Sc/2Wy8YsZWVD0
        MqeOdm9iO7ZGXCdtBJiRwEsAwxhOolPBOdxOFfhl7JozezKgMMx+QLvibEf7NmUEdCFEK/
        2c3dXB/79wjVQ8rc1YqKdS5IIh4eBYk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-8n95E3i6MpSxbOBo9j6XVg-1; Thu, 15 Jun 2023 21:01:19 -0400
X-MC-Unique: 8n95E3i6MpSxbOBo9j6XVg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 939E7806000;
        Fri, 16 Jun 2023 01:01:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 815ABC1603B;
        Fri, 16 Jun 2023 01:01:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000b928f705fdeb873a@google.com>
References: <000000000000b928f705fdeb873a@google.com>
To:     syzbot <syzbot+13a08c0bf4d212766c3c@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] general protection fault in shash_async_final
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <415438.1686877276.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 16 Jun 2023 02:01:16 +0100
Message-ID: <415439.1686877276@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

commit c2996e733d4f2d93bdc0fed74022da082b2e6784
Author: David Howells <dhowells@redhat.com>
Date:   Wed Jun 14 13:33:04 2023 +0100

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

    Fix this by handling zero-length sends at the top of the hash_sendmsg(=
)
    function.  If we're not continuing the previous sendmsg(), then just i=
gnore
    the send (hash_recvmsg() will invent something when called); if we are
    continuing, then we finalise the request at this point if MSG_MORE is =
not
    set to get any error here, otherwise the send is of no effect and can =
be
    ignored.
    =

    Whilst we're at it, remove the code to create a kvmalloc'd scatterlist=
 if
    we get more than ALG_MAX_PAGES - this shouldn't happen.
    =

    Fixes: c662b043cdca ("crypto: af_alg/hash: Support MSG_SPLICE_PAGES")
    Reported-by: syzbot+13a08c0bf4d212766c3c@syzkaller.appspotmail.com
    Link: https://lore.kernel.org/r/000000000000b928f705fdeb873a@google.co=
m/
    Reported-by: syzbot+14234ccf6d0ef629ec1a@syzkaller.appspotmail.com
    Link: https://lore.kernel.org/r/000000000000c047db05fdeb8790@google.co=
m/
    Reported-by: syzbot+4e2e47f32607d0f72d43@syzkaller.appspotmail.com
    Link: https://lore.kernel.org/r/000000000000bcca3205fdeb87fb@google.co=
m/
    Reported-by: syzbot+472626bb5e7c59fb768f@syzkaller.appspotmail.com
    Link: https://lore.kernel.org/r/000000000000b55d8805fdeb8385@google.co=
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

