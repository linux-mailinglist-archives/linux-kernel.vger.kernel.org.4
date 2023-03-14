Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC98F6BA14E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjCNVQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjCNVQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1940941B61
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678828561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l1S6ZGAmfPeeMbczfA0ranezCsJrkelQbLrqGcFpuM0=;
        b=dGonEABJ1h9bfwIVTiYsBMsv9OmiCH4DwUfF37XntXrVUF3CdB2O0sx3NTZQzxL0aGmghx
        43fGiwjYb6KAVNtJ0U3yyIaAHgZ2C8NLmvgZCUeeAeBg+BLKZ9H1c1yYgjgwjJku9mqCwA
        KhmHj36cX+ud86W6FPsOssMVG7u+mUY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-5WPA3pIjPxuOlksm0f2Vlw-1; Tue, 14 Mar 2023 17:15:59 -0400
X-MC-Unique: 5WPA3pIjPxuOlksm0f2Vlw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 297B71869B6F;
        Tue, 14 Mar 2023 21:15:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54495400F55;
        Tue, 14 Mar 2023 21:15:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZBCvdKQskS46qyV3@infradead.org>
References: <ZBCvdKQskS46qyV3@infradead.org> <20230308165251.2078898-1-dhowells@redhat.com> <20230308165251.2078898-3-dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v17 02/14] splice: Make do_splice_to() generic and export it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3771086.1678828554.1@warthog.procyon.org.uk>
Date:   Tue, 14 Mar 2023 21:15:54 +0000
Message-ID: <3771087.1678828554@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> > -static long do_splice_to(struct file *in, loff_t *ppos,
> > -			 struct pipe_inode_info *pipe, size_t len,
> > -			 unsigned int flags)
> > +long vfs_splice_read(struct file *in, loff_t *ppos,
> 
> The (pre-existing) long here is odd given that ->splice_read
> returns a ssize_t.  This might be a good time to fix that up.

There's a while lot of places in splice.c that use long rather than ssize_t.
I can produce a separate patch that changes them all, but that should perhaps
be separate to this.

David

