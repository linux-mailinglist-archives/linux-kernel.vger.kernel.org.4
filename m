Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD086E6F87
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjDRWlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjDRWlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:41:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB78A248
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681857615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=88WLzUQfui8MOyB5NEFokobl+41u8GpMubwgrVgH7UQ=;
        b=Q+iR+24ow2YPAm1IAEbJ4CibZ8O8viGtSzMVHo8qtqS/8EthsMQGdJqP30PbuV1K869Q7z
        weQaiiOs3PIYmVL5VUL1DrZ3Hy95a8x1KHFtyg2lCn2UG0brYrfYruiOvc2MnoSW1/hv4G
        wa23QBRzJ9TqxnuPHaDmsZL4QlKTWAs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-ld5D_CZpP5eRYdorAN4ycA-1; Tue, 18 Apr 2023 18:40:09 -0400
X-MC-Unique: ld5D_CZpP5eRYdorAN4ycA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 290F3101A531;
        Tue, 18 Apr 2023 22:40:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE26540BC798;
        Tue, 18 Apr 2023 22:40:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
cc:     dhowells@redhat.com, Paulo Alcantara <pc@manguebit.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Long Li <longli@microsoft.com>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix unbuffered read
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 18 Apr 2023 23:40:07 +0100
Message-ID: <1692048.1681857607@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


If read() is done in an unbuffered manner, such that, say,
cifs_strict_readv() goes through cifs_user_readv() and thence
__cifs_readv(), it doesn't recognise the EOF and keeps indicating to
userspace that it returning full buffers of data.

This is due to ctx->iter being advanced in cifs_send_async_read() as the
buffer is split up amongst a number of rdata objects.  The iterator count
is then used in collect_uncached_read_data() in the non-DIO case to set the
total length read - and thus the return value of sys_read().  But since the
iterator normally gets used up completely during splitting, ctx->total_len
gets overridden to the full amount.

However, prior to that in collect_uncached_read_data(), we've gone through
the list of rdatas and added up the amount of data we actually received
(which we then throw away).

Fix this by removing the bit that overrides the amount read in the non-DIO
case and just going with the total added up in the aforementioned loop.

This was observed by mounting a cifs share with multiple channels, e.g.:

	mount //192.168.6.1/test /test/ -o user=3Dshares,pass=3D...,max_channels=
=3D6

and then reading a 1MiB file on the share:

	strace cat /xfstest.test/1M  >/dev/null

Through strace, the same data can be seen being read again and again.
=20=20=20=20
Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rather =
than a page list")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <smfrench@gmail.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
cc: Long Li <longli@microsoft.com>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
---
 fs/cifs/file.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 321f9b7c84c9..f8877dc91cc5 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4010,7 +4010,6 @@ static void
 collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 {
 	struct cifs_readdata *rdata, *tmp;
-	struct iov_iter *to =3D &ctx->iter;
 	struct cifs_sb_info *cifs_sb;
 	int rc;
=20
@@ -4076,9 +4075,6 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 		kref_put(&rdata->refcount, cifs_readdata_release);
 	}
=20
-	if (!ctx->direct_io)
-		ctx->total_len =3D ctx->len - iov_iter_count(to);
-
 	/* mask nodata case */
 	if (rc =3D=3D -ENODATA)
 		rc =3D 0;

