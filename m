Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E785F6D03D9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjC3Lub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjC3LuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:50:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D579E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680176978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MgT8q2jy++WQMRLIsrm1uJ/zXUAPqptvzJtFdyenaOc=;
        b=BstHzPWK7beiPSJmnGtls4pvA0NdEVlJnV1XnTUGxPuSSBdWat1RxFxS9ZR3e36PX8iL8b
        xcR5IKqgxaupPRv9OaZe+rzwNAXyRcjr7szD/CrFOh/yUChzWpbiyJh4QjWxbybsTqbXvI
        sqfAI7rIsHaMcIIZxPcxl0AlWjiX7JE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-XelzLDmsP4WGt43mfZhqJw-1; Thu, 30 Mar 2023 07:49:35 -0400
X-MC-Unique: XelzLDmsP4WGt43mfZhqJw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1A543C025C4;
        Thu, 30 Mar 2023 11:49:34 +0000 (UTC)
Received: from ovpn-8-19.pek2.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAB0B2166B33;
        Thu, 30 Mar 2023 11:49:29 +0000 (UTC)
Date:   Thu, 30 Mar 2023 19:49:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk,
        Phillip Lougher <phillip@squashfs.org.uk>, ming.lei@redhat.com
Subject: Re: [PATCH 1/2] block: Rework bio_for_each_segment_all()
Message-ID: <ZCV3Q+TUMvTZZ/Tl@ovpn-8-19.pek2.redhat.com>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <20230327174402.1655365-2-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327174402.1655365-2-kent.overstreet@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 01:44:01PM -0400, Kent Overstreet wrote:
> This patch reworks bio_for_each_segment_all() to be more inline with how
> the other bio iterators work:
> 
>  - bio_iter_all_peek() now returns a synthesized bio_vec; we don't stash
>    one in the iterator and pass a pointer to it - bad. This way makes it
>    clearer what's a constructed value vs. a reference to something
>    pre-existing, and it also will help with cleaning up and
>    consolidating code with bio_for_each_folio_all().
> 
>  - We now provide bio_for_each_segment_all_continue(), for squashfs:
>    this makes their code clearer.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Phillip Lougher <phillip@squashfs.org.uk>
> ---
>  block/bio.c               | 38 ++++++++++++------------
>  block/blk-map.c           | 38 ++++++++++++------------
>  block/bounce.c            | 12 ++++----
>  drivers/md/bcache/btree.c |  8 ++---
>  drivers/md/dm-crypt.c     | 10 +++----
>  drivers/md/raid1.c        |  4 +--
>  fs/btrfs/disk-io.c        | 10 +++----
>  fs/btrfs/extent_io.c      | 52 ++++++++++++++++-----------------
>  fs/btrfs/inode.c          |  8 ++---
>  fs/btrfs/raid56.c         | 18 ++++++------
>  fs/crypto/bio.c           |  8 ++---
>  fs/erofs/zdata.c          |  4 +--
>  fs/ext4/page-io.c         |  8 ++---
>  fs/ext4/readpage.c        |  4 +--
>  fs/f2fs/data.c            | 20 ++++++-------
>  fs/gfs2/lops.c            | 10 +++----
>  fs/gfs2/meta_io.c         |  8 ++---
>  fs/mpage.c                |  4 +--
>  fs/squashfs/block.c       | 48 ++++++++++++++++--------------
>  fs/squashfs/lz4_wrapper.c | 17 ++++++-----
>  fs/squashfs/lzo_wrapper.c | 17 ++++++-----
>  fs/verity/verify.c        |  4 +--
>  include/linux/bio.h       | 31 +++++++++++++++-----
>  include/linux/bvec.h      | 61 ++++++++++++++++++++++-----------------
>  24 files changed, 239 insertions(+), 203 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index ab59a491a8..8d3abe249e 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1170,13 +1170,13 @@ bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
>  
>  void __bio_release_pages(struct bio *bio, bool mark_dirty)
>  {
> -	struct bvec_iter_all iter_all;
> -	struct bio_vec *bvec;
> +	struct bvec_iter_all iter;
> +	struct bio_vec bvec;
>  
> -	bio_for_each_segment_all(bvec, bio, iter_all) {
> -		if (mark_dirty && !PageCompound(bvec->bv_page))
> -			set_page_dirty_lock(bvec->bv_page);
> -		put_page(bvec->bv_page);
> +	bio_for_each_segment_all(bvec, bio, iter) {
> +		if (mark_dirty && !PageCompound(bvec.bv_page))
> +			set_page_dirty_lock(bvec.bv_page);
> +		put_page(bvec.bv_page);
>  	}

bio_for_each_segment_all is supposed to be used by bio which owns the
bvec table, so it is just fine to return bvec pointer by bio_for_each_segment_all
to save extra bvec copy.

And the change becomes not efficient any more.


Thanks,
Ming

