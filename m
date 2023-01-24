Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469CA67934F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjAXInH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjAXInF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:43:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB41732533
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:43:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 97B9C1FE48;
        Tue, 24 Jan 2023 08:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674549783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1L6jNEqHgkJYh08ukn5C7mfhjQwusejPRDSpTQePYWU=;
        b=w0x7aNUjbTCn0ZUsSzjHZaiChAWPPgpfb6hl31osinXEPa/hA3x9RoX4IL+xre+r/G7ERD
        zMY1+09d/sCK6EfMZG/2e5X8XonjIW2vhALDvh9sBzqRZwAScbaW3S1VgnOTIEZbAlYGLF
        HY909DZ5gWl0D9+tPTG/+FoTFhjuUZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674549783;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1L6jNEqHgkJYh08ukn5C7mfhjQwusejPRDSpTQePYWU=;
        b=rCVQTce0iZSjSqk3+UjCJUGyn2pUAeZ+0AkRT94V3GV6u0V+/v5md8agrKS9M0aswuIAf8
        mJt8578i/a4SHhCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BFD513487;
        Tue, 24 Jan 2023 08:43:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CIwhIheaz2MpOQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 08:43:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1BD8BA06B5; Tue, 24 Jan 2023 09:43:03 +0100 (CET)
Date:   Tue, 24 Jan 2023 09:43:03 +0100
From:   Jan Kara <jack@suse.cz>
To:     Vladislav Efanov <VEfanov@ispras.ru>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] udf: Reserve bits for Bitmap Descriptor buffers
Message-ID: <20230124084303.pn7glett53qh6pcp@quack3>
References: <20230120090858.1591519-1-VEfanov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120090858.1591519-1-VEfanov@ispras.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20-01-23 12:08:58, Vladislav Efanov wrote:
> Bits, which are related to Bitmap Descriptor logical blocks,
> are not reset when buffer headers are allocated for them. As the
> result, these logical blocks can be treated as free and
> be used for other blocks.This can cause usage of one buffer header
> for several types of data. UDF issues WARNING in this situation:
> 
> WARNING: CPU: 0 PID: 2703 at fs/udf/inode.c:2014
>   __udf_add_aext+0x685/0x7d0 fs/udf/inode.c:2014
> 
> RIP: 0010:__udf_add_aext+0x685/0x7d0 fs/udf/inode.c:2014
> Call Trace:
>  udf_setup_indirect_aext+0x573/0x880 fs/udf/inode.c:1980
>  udf_add_aext+0x208/0x2e0 fs/udf/inode.c:2067
>  udf_insert_aext fs/udf/inode.c:2233 [inline]
>  udf_update_extents fs/udf/inode.c:1181 [inline]
>  inode_getblk+0x1981/0x3b70 fs/udf/inode.c:885
> 
> Found by Linux Verification Center (linuxtesting.org) with syzkaller.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>

Thanks for the analysis and the fix. Two notes below:

> diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
> index 8e597db4d971..52dab5b63715 100644
> --- a/fs/udf/balloc.c
> +++ b/fs/udf/balloc.c
> @@ -37,6 +37,7 @@ static int read_block_bitmap(struct super_block *sb,
>  {
>  	struct buffer_head *bh = NULL;
>  	int retval = 0;
> +	int i;
>  	struct kernel_lb_addr loc;
>  
>  	loc.logicalBlockNum = bitmap->s_extPosition;
> @@ -47,6 +48,12 @@ static int read_block_bitmap(struct super_block *sb,
>  		retval = -EIO;
>  
>  	bitmap->s_block_bitmap[bitmap_nr] = bh;
> +	/* Reserve bits for Space Bitmap buffer headers. */
> +	if (bh && !bitmap_nr)
> +		for (i = 0; i < bitmap->s_nr_groups; i++)
> +			udf_clear_bit(bitmap->s_extPosition + i +
> +				      (sizeof(struct spaceBitmapDesc) << 3),
> +				      bh->b_data);
>  	return retval;
>  }

Rather than just siletly making blocks allocated, we should test whether
the block is allocated and if not, return an error (-EFSCORRUPTED) and
refuse to use the filesystem.

Also with 512-byte blocksize one block describes 2MB of the filesystem so
for a filesystem larger than 8GB bitmap->s_nr_groups can be larger than a
number of bits in a block. So we need to be a bit more careful when
verifying the bitmap.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
