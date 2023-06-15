Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD0E731828
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbjFOMIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239068AbjFOMIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE44170E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686830881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BvRHsFB/oRi8HTtrrWbsQwfbB532rVXuG7TnMUDF+bc=;
        b=g5FQAohQr0SXx7iYlW5xtuUOWhJVO2dOTgEJhZfjeSjWwAHKbwhQOq2y++IWzrxTpUnqlQ
        dY80V5rSecCJa4INbwPHwknD2iQuErgKhaWaPhgjH3iYTrUmMKK/8PcBz02I9vyZ4k2XJq
        4L0DbyBNgTKtkwV8GOZqozC5aCedebY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-z09Qo7_-MFOSQSQDj1rioA-1; Thu, 15 Jun 2023 08:07:57 -0400
X-MC-Unique: z09Qo7_-MFOSQSQDj1rioA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D503101CC8D;
        Thu, 15 Jun 2023 12:07:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 161092026D49;
        Thu, 15 Jun 2023 12:07:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000b2585a05fdeb8379@google.com>
References: <000000000000b2585a05fdeb8379@google.com>
To:     syzbot <syzbot+6efc50cc1f8d718d6cb7@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in extract_iter_to_sg
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <89570.1686830867.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 15 Jun 2023 13:07:47 +0100
Message-ID: <89571.1686830867@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.g=
it main

diff --git a/fs/splice.c b/fs/splice.c
index 67ddaac1f5c5..17d692449e83 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -886,7 +886,6 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe,=
 struct file *out,
 			}
 =

 			seg =3D min_t(size_t, remain, buf->len);
-			seg =3D min_t(size_t, seg, PAGE_SIZE);
 =

 			ret =3D pipe_buf_confirm(pipe, buf);
 			if (unlikely(ret)) {
@@ -897,10 +896,9 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe=
, struct file *out,
 =

 			bvec_set_page(&bvec[bc++], buf->page, seg, buf->offset);
 			remain -=3D seg;
-			if (seg >=3D buf->len)
-				tail++;
-			if (bc >=3D ARRAY_SIZE(bvec))
+			if (remain =3D=3D 0 || bc >=3D ARRAY_SIZE(bvec))
 				break;
+			tail++;
 		}
 =

 		if (!bc)
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 457598dfa128..6e70839257f7 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1041,7 +1041,8 @@ static int __ip_append_data(struct sock *sk,
 	} else if ((flags & MSG_SPLICE_PAGES) && length) {
 		if (inet->hdrincl)
 			return -EPERM;
-		if (rt->dst.dev->features & NETIF_F_SG)
+		if (rt->dst.dev->features & NETIF_F_SG &&
+		    getfrag =3D=3D ip_generic_getfrag)
 			/* We need an empty buffer to attach stuff to */
 			paged =3D true;
 		else
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index c06ff7519f19..1e8c90e97608 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1593,7 +1593,8 @@ static int __ip6_append_data(struct sock *sk,
 	} else if ((flags & MSG_SPLICE_PAGES) && length) {
 		if (inet_sk(sk)->hdrincl)
 			return -EPERM;
-		if (rt->dst.dev->features & NETIF_F_SG)
+		if (rt->dst.dev->features & NETIF_F_SG &&
+		    getfrag =3D=3D ip_generic_getfrag)
 			/* We need an empty buffer to attach stuff to */
 			paged =3D true;
 		else

