Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028837170B8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjE3W1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjE3W1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FA993
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685485610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tNYdArI3imuxwPg8NiyNMfN64svKTcTa3/gSVgtKOkI=;
        b=LV7znfq4e91+4UgbJAkM30iygE2LqtplhpgJKLc9WPaVBpSKsiHCtKn0YD9LJtMa/asgYP
        L95Y/dVNRMrZN3IaJQ5/w55WtK6vPMoaxsVEZs9ii9EwOu7bMr+5Ye1gjgKur45YSgPte8
        R/l8O1aS4aRgD/A8+J6SbAF4Q7+wbvw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-355-WlHwnQMoPa6At32JsJXk0Q-1; Tue, 30 May 2023 18:26:47 -0400
X-MC-Unique: WlHwnQMoPa6At32JsJXk0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C447D800969;
        Tue, 30 May 2023 22:26:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACFE92166B25;
        Tue, 30 May 2023 22:26:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230526180844.73745d78@kernel.org>
References: <20230526180844.73745d78@kernel.org> <20230524153311.3625329-1-dhowells@redhat.com> <20230524153311.3625329-10-dhowells@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Bug in short splice to socket?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <499790.1685485603.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 30 May 2023 23:26:43 +0100
Message-ID: <499791.1685485603@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> wrote:

> Will the TLS selftests under tools/.../net/tls.c exercise this?

Interesting.  Now that you've pointed me at it, I've tried running it.  Mo=
stly
it passes, but I'm having some problems with the multi_chunk_sendfile test=
s
that time out.  I think that splice_direct_to_actor() has a bug.  The prob=
lem
is this bit of code:

		/*
		 * If more data is pending, set SPLICE_F_MORE
		 * If this is the last data and SPLICE_F_MORE was not set
		 * initially, clears it.
		 */
		if (read_len < len)
			sd->flags |=3D SPLICE_F_MORE;
		else if (!more)
			sd->flags &=3D ~SPLICE_F_MORE;

When used with sendfile(), it sets SPLICE_F_MORE (which causes MSG_MORE to=
 be
passed to the network protocol) if we haven't yet read everything that the
user requested and clears it if we fulfilled what the user requested.

This has the weird effect that MSG_MORE gets kind of inverted.  It's never
seen by the actor if we can read the entire request into the pipe - except=
 if
we hit the EOF first.  If we hit the EOF before we fulfil the entire reque=
st,
we get a short read and SPLICE_F_MORE and thus MSG_MORE *is* set.  The
upstream TLS code ignores it - but I'm changing this with my patches as
sendmsg() then uses it to mark the EOR.

I think we probably need to fix this in some way to check the size of sour=
ce
file - which may not be a regular file:-/  With the attached change, all t=
ests
pass; without it, a bunch of tests fail with timeouts.

David
---
diff --git a/fs/splice.c b/fs/splice.c
index 3e06611d19ae..a7cf216c02a7 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -982,10 +982,21 @@ ssize_t splice_direct_to_actor(struct file *in, stru=
ct splice_desc *sd,
 		 * If this is the last data and SPLICE_F_MORE was not set
 		 * initially, clears it.
 		 */
-		if (read_len < len)
-			sd->flags |=3D SPLICE_F_MORE;
-		else if (!more)
+		if (read_len < len) {
+			struct inode *ii =3D in->f_mapping->host;
+
+			if (ii->i_fop->llseek !=3D noop_llseek &&
+			    pos >=3D i_size_read(ii)) {
+				if (!more)
+					sd->flags &=3D ~SPLICE_F_MORE;
+			} else {
+				sd->flags |=3D SPLICE_F_MORE;
+			}
+
+		} else if (!more) {
 			sd->flags &=3D ~SPLICE_F_MORE;
+		}
+
 		/*
 		 * NOTE: nonblocking mode only applies to the input. We
 		 * must not do the output in nonblocking mode as then we

