Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F195692B5F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjBJXfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjBJXep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:34:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159CB7E3F9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 15:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676071960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nghgmX+bncPINiD3wsT1CpIOvgAN1XoBCxD2UY2cfe0=;
        b=JRR9BoHJFgkN8eZUt3KufHI98+nLQhX1LxME6RYjZ2qyrX8fCW8lyBo/UJcTAhPV/W9eCc
        xp2mE02pF4UNFhO4TOWQt1D2ZpTgYNL2YtLuAa/jKBMyglC86ICsQ6hRaiWTRXPZr+D+oi
        xgME4xCqH6HHTMMUi+18Rw6/oUKEYZU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-vDZId1jcMpaD_5ERbR-ZKQ-1; Fri, 10 Feb 2023 18:32:34 -0500
X-MC-Unique: vDZId1jcMpaD_5ERbR-ZKQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97A6585A588;
        Fri, 10 Feb 2023 23:32:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09F322026D68;
        Fri, 10 Feb 2023 23:32:31 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steve French <sfrench@samba.org>
Subject: [PATCH 10/11] cifs: DIO to/from KVEC-type iterators should now work
Date:   Fri, 10 Feb 2023 23:32:04 +0000
Message-Id: <20230210233205.1517459-11-dhowells@redhat.com>
In-Reply-To: <20230210233205.1517459-1-dhowells@redhat.com>
References: <20230210233205.1517459-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DIO to/from KVEC-type iterators should now work as the iterator is passed
down to the socket in non-RDMA/non-crypto mode and in RDMA or crypto mode
care is taken to handle vmap/vmalloc correctly and not take page refs when
building a scatterlist.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Tom Talpey <tom@talpey.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
---
 fs/cifs/file.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index f3cedec9d22a..a5d54ae6aaa6 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3546,16 +3546,6 @@ static ssize_t __cifs_writev(
 	struct cifs_aio_ctx *ctx;
 	int rc;
 
-	/*
-	 * iov_iter_get_pages_alloc doesn't work with ITER_KVEC.
-	 * In this case, fall back to non-direct write function.
-	 * this could be improved by getting pages directly in ITER_KVEC
-	 */
-	if (direct && iov_iter_is_kvec(from)) {
-		cifs_dbg(FYI, "use non-direct cifs_writev for kvec I/O\n");
-		direct = false;
-	}
-
 	rc = generic_write_checks(iocb, from);
 	if (rc <= 0)
 		return rc;
@@ -4089,16 +4079,6 @@ static ssize_t __cifs_readv(
 	loff_t offset = iocb->ki_pos;
 	struct cifs_aio_ctx *ctx;
 
-	/*
-	 * iov_iter_get_pages_alloc() doesn't work with ITER_KVEC,
-	 * fall back to data copy read path
-	 * this could be improved by getting pages directly in ITER_KVEC
-	 */
-	if (direct && iov_iter_is_kvec(to)) {
-		cifs_dbg(FYI, "use non-direct cifs_user_readv for kvec I/O\n");
-		direct = false;
-	}
-
 	len = iov_iter_count(to);
 	if (!len)
 		return 0;

