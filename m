Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57546421D6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 04:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiLEDN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 22:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiLEDN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 22:13:56 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97A713CD8;
        Sun,  4 Dec 2022 19:13:54 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VWMLxrT_1670210030;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VWMLxrT_1670210030)
          by smtp.aliyun-inc.com;
          Mon, 05 Dec 2022 11:13:52 +0800
Date:   Mon, 5 Dec 2022 11:13:50 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, Gao Xiang <xiang@kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs tree with the erofs tree
Message-ID: <Y41h7hz12QXQaSYS@B-P7TQMD6M-0146.local>
References: <20221205092415.56cc6e19@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221205092415.56cc6e19@canb.auug.org.au>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Dec 05, 2022 at 09:24:15AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the vfs tree got a conflict in:
> 
>   fs/erofs/fscache.c
> 
> between commits:
> 
>   89175ef1262d ("erofs: switch to prepare_ondemand_read() in fscache mode")
>   89175ef1262d ("erofs: switch to prepare_ondemand_read() in fscache mode")
> 
> from the erofs tree and commit:
> 
>   89175ef1262d ("erofs: switch to prepare_ondemand_read() in fscache mode")
> 
> from the vfs tree.

Is the commit from the vfs tree correct?

The conflict fix looks good to me (we tend to enable large folios in the
next cycle.)

Thanks,
Gao Xiang

> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc fs/erofs/fscache.c
> index f14886c479bd,4c837be3b6e3..000000000000
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@@ -126,28 -159,47 +126,28 @@@ static int erofs_fscache_read_folios_as
>   
>   	ret = fscache_begin_read_operation(cres, cookie);
>   	if (ret)
>  -		goto out;
>  +		return ret;
>   
>   	while (done < len) {
>  -		subreq = kzalloc(sizeof(struct netfs_io_subrequest),
>  -				 GFP_KERNEL);
>  -		if (subreq) {
>  -			INIT_LIST_HEAD(&subreq->rreq_link);
>  -			refcount_set(&subreq->ref, 2);
>  -			subreq->rreq = rreq;
>  -			refcount_inc(&rreq->ref);
>  -		} else {
>  -			ret = -ENOMEM;
>  -			goto out;
>  -		}
>  -
>  -		subreq->start = pstart + done;
>  -		subreq->len	=  len - done;
>  -		subreq->flags = 1 << NETFS_SREQ_ONDEMAND;
>  +		loff_t sstart = pstart + done;
>  +		size_t slen = len - done;
>  +		unsigned long flags = 1 << NETFS_SREQ_ONDEMAND;
>   
>  -		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
>  -
>  -		source = cres->ops->prepare_read(subreq, LLONG_MAX);
>  -		if (WARN_ON(subreq->len == 0))
>  +		source = cres->ops->prepare_ondemand_read(cres,
>  +				sstart, &slen, LLONG_MAX, &flags, 0);
>  +		if (WARN_ON(slen == 0))
>   			source = NETFS_INVALID_READ;
>   		if (source != NETFS_READ_FROM_CACHE) {
>  -			erofs_err(sb, "failed to fscache prepare_read (source %d)",
>  -				  source);
>  -			ret = -EIO;
>  -			subreq->error = ret;
>  -			erofs_fscache_put_subrequest(subreq);
>  -			goto out;
>  +			erofs_err(sb, "failed to fscache prepare_read (source %d)", source);
>  +			return -EIO;
>   		}
>   
>  -		atomic_inc(&rreq->nr_outstanding);
>  +		refcount_inc(&req->ref);
> - 		iov_iter_xarray(&iter, READ, &req->mapping->i_pages,
> ++		iov_iter_xarray(&iter, ITER_DEST, &req->mapping->i_pages,
>  +				lstart + done, slen);
>   
>  -		iov_iter_xarray(&iter, ITER_DEST, &rreq->mapping->i_pages,
>  -				start + done, subreq->len);
>  -
>  -		ret = fscache_read(cres, subreq->start, &iter,
>  -				   NETFS_READ_HOLE_FAIL,
>  -				   erofc_fscache_subreq_complete, subreq);
>  +		ret = fscache_read(cres, sstart, &iter, NETFS_READ_HOLE_FAIL,
>  +				   erofs_fscache_subreq_complete, req);
>   		if (ret == -EIOCBQUEUED)
>   			ret = 0;
>   		if (ret) {
> @@@ -233,19 -297,17 +233,19 @@@ static int erofs_fscache_data_read_slic
>   		}
>   		iov_iter_zero(PAGE_SIZE - size, &iter);
>   		erofs_put_metabuf(&buf);
>  -		return PAGE_SIZE;
>  +		primary->submitted += PAGE_SIZE;
>  +		return 0;
>   	}
>   
>  +	count = primary->len - primary->submitted;
>   	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> - 		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, count);
>  -		count = len;
> + 		iov_iter_xarray(&iter, ITER_DEST, &mapping->i_pages, pos, count);
>   		iov_iter_zero(count, &iter);
>  -		return count;
>  +		primary->submitted += count;
>  +		return 0;
>   	}
>   
>  -	count = min_t(size_t, map.m_llen - (pos - map.m_la), len);
>  +	count = min_t(size_t, map.m_llen - (pos - map.m_la), count);
>   	DBG_BUGON(!count || count % PAGE_SIZE);
>   
>   	mdev = (struct erofs_map_dev) {


