Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A31D6C7330
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCWWhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjCWWhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:37:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D56623C6C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:37:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52C55B8227C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA471C4339B;
        Thu, 23 Mar 2023 22:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679611041;
        bh=e+h2mUJYZuNyVdV99tfY2YFd4SgSC26RuV1oY/psovU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h6GWOthwrssi8xkFClxadiP4fsPn5GIG7nQamIY8sYfhhsWtohT49zxN6MgRzoMQe
         EnUxpHaQd1zFig97QJDRow9It5swMIU5mburl17t/gEtQuJdG82Nxq7bKEWKOQrGnQ
         j5wT0jtgEPG7JK/Qy5VuM8WrBoralmvcUeZM2y54QElvSmr32PJadazV3ncgH4Fsmq
         Ee4NduAs4qZuH01wlre5VO9BBKqJJuzm2rqjSLiuCyra0JyLWvRysMI26iwmofjH+/
         dhTFurYdG4canFngXpu9AOGI9yqbm5Qzr967AHwa2X7uKGrO8xidyIbexWGuB1C2N4
         fhm/EsVNNpUwA==
Date:   Thu, 23 Mar 2023 15:37:20 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Hans Holmberg <hans.holmberg@wdc.com>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        damien.lemoal@wdc.com, aravind.ramesh@wdc.com, hans@owltronix.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] f2fs: preserve direct write semantics when buffering
 is forced
Message-ID: <ZBzUoJ9sydeS4TpI@google.com>
References: <20230220122004.26555-1-hans.holmberg@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220122004.26555-1-hans.holmberg@wdc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20, Hans Holmberg wrote:
> In some cases, e.g. for zoned block devices, direct writes are
> forced into buffered writes that will populate the page cache
> and be written out just like buffered io.
> 
> Direct reads, on the other hand, is supported for the zoned
> block device case. This has the effect that applications
> built for direct io will fill up the page cache with data
> that will never be read, and that is a waste of resources.
> 
> If we agree that this is a problem, how do we fix it?
> 
> A) Supporting proper direct writes for zoned block devices would
> be the best, but it is currently not supported (probably for
> a good but non-obvious reason). Would it be feasible to
> implement proper direct IO?
> 
> B) Avoid the cost of keeping unwanted data by syncing and throwing
> out the cached pages for buffered O_DIRECT writes before completion.
> 
> This patch implements B) by reusing the code for how partial
> block writes are flushed out on the "normal" direct write path.
> 
> Note that this changes the performance characteristics of f2fs
> quite a bit.
> 
> Direct IO performance for zoned block devices is lower for
> small writes after this patch, but this should be expected
> with direct IO and in line with how f2fs behaves on top of
> conventional block devices.
> 
> Another open question is if the flushing should be done for
> all cases where buffered writes are forced.
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> ---
>  fs/f2fs/file.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index ecbc8c135b49..4e57c37bce35 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4513,6 +4513,19 @@ static const struct iomap_dio_ops f2fs_iomap_dio_write_ops = {
>  	.end_io = f2fs_dio_write_end_io,
>  };
>  
> +static void f2fs_flush_buffered_write(struct address_space *mapping,
> +				      loff_t start_pos, loff_t end_pos)
> +{
> +	int ret;
> +
> +	ret = filemap_write_and_wait_range(mapping, start_pos, end_pos);
> +	if (ret < 0)
> +		return;
> +	invalidate_mapping_pages(mapping,
> +				 start_pos >> PAGE_SHIFT,
> +				 end_pos >> PAGE_SHIFT);
> +}
> +
>  static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
>  				   bool *may_need_sync)
>  {
> @@ -4612,14 +4625,9 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
>  
>  			ret += ret2;
>  
> -			ret2 = filemap_write_and_wait_range(file->f_mapping,
> -							    bufio_start_pos,
> -							    bufio_end_pos);
> -			if (ret2 < 0)
> -				goto out;
> -			invalidate_mapping_pages(file->f_mapping,
> -						 bufio_start_pos >> PAGE_SHIFT,
> -						 bufio_end_pos >> PAGE_SHIFT);
> +			f2fs_flush_buffered_write(file->f_mapping,
> +						  bufio_start_pos,
> +						  bufio_end_pos);
>  		}
>  	} else {
>  		/* iomap_dio_rw() already handled the generic_write_sync(). */
> @@ -4717,8 +4725,22 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	inode_unlock(inode);
>  out:
>  	trace_f2fs_file_write_iter(inode, orig_pos, orig_count, ret);
> +
>  	if (ret > 0 && may_need_sync)
>  		ret = generic_write_sync(iocb, ret);
> +
> +	/* If buffered IO was forced, flush and drop the data from
> +	 * the page cache to preserve O_DIRECT semantics
> +	 */
> +	if (ret > 0 && !dio && (iocb->ki_flags & IOCB_DIRECT)) {
> +		struct file *file = iocb->ki_filp;
> +		loff_t end_pos = orig_pos + ret - 1;
> +
> +		f2fs_flush_buffered_write(file->f_mapping,
> +					  orig_pos,
> +					  end_pos);

I applied a minor change:

        /* If buffered IO was forced, flush and drop the data from
         * the page cache to preserve O_DIRECT semantics
         */
-       if (ret > 0 && !dio && (iocb->ki_flags & IOCB_DIRECT)) {
-               struct file *file = iocb->ki_filp;
-               loff_t end_pos = orig_pos + ret - 1;
-
-               f2fs_flush_buffered_write(file->f_mapping,
+       if (ret > 0 && !dio && (iocb->ki_flags & IOCB_DIRECT))
+               f2fs_flush_buffered_write(iocb->ki_filp->f_mapping,
                                          orig_pos,
-                                         end_pos);
-       }
+                                         orig_pos + ret - 1);

        return ret;
 }


> +	}
> +
>  	return ret;
>  }
>  
> -- 
> 2.25.1
