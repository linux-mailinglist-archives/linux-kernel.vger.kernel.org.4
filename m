Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AADF7029FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbjEOKFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240626AbjEOKEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:04:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360132D69
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:03:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D93A668BEB; Mon, 15 May 2023 12:03:52 +0200 (CEST)
Date:   Mon, 15 May 2023 12:03:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Liard <pliard@google.com>, hch@lst.de,
        linux-kernel@vger.kernel.org, squashfs-devel@lists.sourceforge.net,
        kernel@axis.com
Subject: Re: [PATCH v2] squashfs: cache partial compressed blocks
Message-ID: <20230515100352.GA24402@lst.de>
References: <20230510-squashfs-cache-v2-1-42a501a17569@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510-squashfs-cache-v2-1-42a501a17569@axis.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 03:18:05PM +0200, Vincent Whitchurch wrote:
> +static int squashfs_bio_read_cached(struct bio *fullbio, struct address_space *cache_mapping,
> +				    u64 index, int length, u64 read_start, u64 read_end,
> +				    int page_count)

Please avoid the unreadable formatting and do something like:

static int squashfs_bio_read_cached(struct bio *fullbio,
		struct address_space *cache_mapping, u64 index, int length,
		u64 read_start, u64 read_end, int page_count)


> +		if (!bio || idx != prev_io_idx + 1) {
> +			unsigned int remaining_pages;
> +			unsigned int this_nr_pages;
> +
> +submit_and_retry:
> +			remaining_pages = page_count - idx;
> +			this_nr_pages = min(remaining_pages, BIO_MAX_VECS);
> +			bio = blk_next_bio(bio, bdev, this_nr_pages, REQ_OP_READ,
> +					   GFP_NOIO);
> +			bio->bi_iter.bi_sector = fullbio->bi_iter.bi_sector +
> +						 idx * (PAGE_SIZE / SECTOR_SIZE);
> +		}
> +
> +		retlen = bio_add_page(bio, bv->bv_page, bv->bv_len, bv->bv_offset);
> +		if (retlen != bv->bv_len)
> +			goto submit_and_retry;

Adding data payload to a bio while passing full bio_vec is usually
a sign that instead you should do a (partial) clone of the bio instead.
I think this is such a case.

>  static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
>  			     struct bio **biop, int *block_offset)
>  {
>  	struct squashfs_sb_info *msblk = sb->s_fs_info;
> +	struct inode *cache_inode = msblk->cache_inode;
> +	struct address_space *cache_mapping = cache_inode ? cache_inode->i_mapping : NULL;

Unless I'm badly misreading the squashfs_fill_super changes,
cache_inode can't ever be NULL here or anywhere else in the I/O
code.
