Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1780E6EF00A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbjDZIPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbjDZIPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:15:53 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CB0198C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 01:15:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vh2NU5d_1682496947;
Received: from 30.97.49.10(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vh2NU5d_1682496947)
          by smtp.aliyun-inc.com;
          Wed, 26 Apr 2023 16:15:48 +0800
Message-ID: <4009badd-88f7-33e3-3abc-2c4fef10efab@linux.alibaba.com>
Date:   Wed, 26 Apr 2023 16:15:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs: fold in z_erofs_decompress()
To:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     jefflexu@linux.alibaba.com, huyue2@coolpad.com,
        linux-kernel@vger.kernel.org, zhangwen@coolpad.com
References: <20230426075943.26629-1-zbestahu@gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230426075943.26629-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/26 15:59, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> No need this helper since it's just a simple wrapper for decompress
> method and only one caller.  So, let's fold in directly instead.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
>   fs/erofs/compress.h     | 3 +--
>   fs/erofs/decompressor.c | 8 +-------
>   fs/erofs/zdata.c        | 4 +++-
>   3 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
> index 26fa170090b8..9e423316f5a1 100644
> --- a/fs/erofs/compress.h
> +++ b/fs/erofs/compress.h
> @@ -89,8 +89,7 @@ static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
>   
>   int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
>   			 unsigned int padbufsize);
> -int z_erofs_decompress(struct z_erofs_decompress_req *rq,
> -		       struct page **pagepool);
> +extern const struct z_erofs_decompressor decompressors[];
>   
>   /* prototypes for specific algorithms */
>   int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 7021e2cf6146..5ed82b72a5a5 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -363,7 +363,7 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>   	return 0;
>   }
>   
> -static struct z_erofs_decompressor decompressors[] = {
> +const struct z_erofs_decompressor decompressors[] = {

Please help rename it as erofs_decompressors.

>   	[Z_EROFS_COMPRESSION_SHIFTED] = {
>   		.decompress = z_erofs_transform_plain,
>   		.name = "shifted"
> @@ -383,9 +383,3 @@ static struct z_erofs_decompressor decompressors[] = {
>   	},
>   #endif
>   };
> -
> -int z_erofs_decompress(struct z_erofs_decompress_req *rq,
> -		       struct page **pagepool)
> -{
> -	return decompressors[rq->alg].decompress(rq, pagepool);
> -}
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index a90d37c7bdd7..f5c8ab176b23 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1290,6 +1290,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
>   	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
>   	struct z_erofs_pcluster *pcl = be->pcl;
>   	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
> +	struct z_erofs_decompressor decompressor =
> +				decompressors[pcl->algorithmformat];

Do you really need copy the struct item?
	struct z_erofs_decompressor *dec =
			erofs_decompressors[pcl->algorithmformat];

Otherwise it looks good to me.

Thanks,
Gao Xiang

>   	unsigned int i, inputsize;
>   	int err2;
>   	struct page *page;
> @@ -1333,7 +1335,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
>   	else
>   		inputsize = pclusterpages * PAGE_SIZE;
>   
> -	err = z_erofs_decompress(&(struct z_erofs_decompress_req) {
> +	err = decompressor.decompress(&(struct z_erofs_decompress_req) {
>   					.sb = be->sb,
>   					.in = be->compressed_pages,
>   					.out = be->decompressed_pages,
