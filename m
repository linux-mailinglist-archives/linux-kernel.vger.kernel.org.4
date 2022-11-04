Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA05D619413
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiKDKD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiKDKDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:03:20 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68EC2B19F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 03:03:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VTwgtpI_1667556191;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VTwgtpI_1667556191)
          by smtp.aliyun-inc.com;
          Fri, 04 Nov 2022 18:03:13 +0800
Date:   Fri, 4 Nov 2022 18:03:11 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org, zhujia.zj@bytedance.com,
        yinxin.x@bytedance.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] erofs: put metabuf in error path in fscache mode
Message-ID: <Y2TjX/xJYenOEb6k@B-P7TQMD6M-0146.local>
References: <20221104054028.52208-1-jefflexu@linux.alibaba.com>
 <20221104054028.52208-2-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221104054028.52208-2-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 01:40:27PM +0800, Jingbo Xu wrote:
> For tail packing layout, put metabuf when error is encountered.
> 
> Fixes: 1ae9470c3e14 ("erofs: clean up .read_folio() and .readahead() in fscache mode")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/fscache.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index fe05bc51f9f2..83559008bfa8 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -287,8 +287,10 @@ static int erofs_fscache_data_read(struct address_space *mapping,
>  			return PTR_ERR(src);
>  
>  		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, PAGE_SIZE);
> -		if (copy_to_iter(src + offset, size, &iter) != size)
> +		if (copy_to_iter(src + offset, size, &iter) != size) {
> +			erofs_put_metabuf(&buf);
>  			return -EFAULT;
> +		}
>  		iov_iter_zero(PAGE_SIZE - size, &iter);
>  		erofs_put_metabuf(&buf);
>  		return PAGE_SIZE;
> -- 
> 2.19.1.6.gb485710b
