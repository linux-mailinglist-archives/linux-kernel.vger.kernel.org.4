Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B82E694765
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjBMNs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjBMNsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:48:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C711B578
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676296013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Gd+AM0ivl8H3lv5f0bcfNcViU9oHee8wwcgLJRIkXo=;
        b=BlOUek+Nk/cL7kv43+7d4YUm1Wbn+bJpaEX4XvJSU/OUvivwGm3fOmVu2xtPbxSMbZ7QaW
        K6ic+/ONXwpXwgFh2MUaoJ6rhxzdJ1apyg3tWI7X6ppda6OylbEvpO7BPn0o6PHBhui0ru
        SomSdxvBJ67QfMllgDQFmBsPbClYtuY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-5GjRqJH1Nv2E9X1dNEvJAQ-1; Mon, 13 Feb 2023 08:46:47 -0500
X-MC-Unique: 5GjRqJH1Nv2E9X1dNEvJAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 367EF3C16E82;
        Mon, 13 Feb 2023 13:46:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41D452166B26;
        Mon, 13 Feb 2023 13:46:29 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 3/4] splice: Use init_sync_kiocb() in filemap_splice_read()
Date:   Mon, 13 Feb 2023 13:46:18 +0000
Message-Id: <20230213134619.2198965-4-dhowells@redhat.com>
In-Reply-To: <20230213134619.2198965-1-dhowells@redhat.com>
References: <20230213134619.2198965-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use init_sync_kiocb() in filemap_splice_read() rather than open coding it
and filter out IOCB_NOWAIT since the splice is synchronous.

Requested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: John Hubbard <jhubbard@nvidia.com>
cc: David Hildenbrand <david@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/splice.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 7c0ff187f87a..8b2a9d963bc4 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -419,15 +419,15 @@ static ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 				   size_t len, unsigned int flags)
 {
 	struct folio_batch fbatch;
+	struct kiocb iocb;
 	size_t total_spliced = 0, used, npages;
 	loff_t isize, end_offset;
 	bool writably_mapped;
 	int i, error = 0;
 
-	struct kiocb iocb = {
-		.ki_filp	= in,
-		.ki_pos		= *ppos,
-	};
+	init_sync_kiocb(&iocb, in);
+	iocb.ki_pos = *ppos;
+	iocb.ki_flags &= IOCB_NOWAIT;
 
 	/* Work out how much data we can actually add into the pipe */
 	used = pipe_occupancy(pipe->head, pipe->tail);

