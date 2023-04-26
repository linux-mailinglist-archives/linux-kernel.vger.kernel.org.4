Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BC16EEE12
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 08:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239315AbjDZGJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 02:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbjDZGJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 02:09:03 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3012D4E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 23:08:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vh1oidN_1682489329;
Received: from 30.97.49.10(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vh1oidN_1682489329)
          by smtp.aliyun-inc.com;
          Wed, 26 Apr 2023 14:08:51 +0800
Message-ID: <a5a39900-9569-59e8-296f-c5f99b737adc@linux.alibaba.com>
Date:   Wed, 26 Apr 2023 14:08:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] erofs: get rid of name from struct
 z_erofs_decompressor
To:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     jefflexu@linux.alibaba.com, huyue2@coolpad.com,
        linux-kernel@vger.kernel.org, zhangwen@coolpad.com
References: <a0c8b87b5c165750107bbaad6b014c02311b610d.1682481589.git.huyue2@coolpad.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <a0c8b87b5c165750107bbaad6b014c02311b610d.1682481589.git.huyue2@coolpad.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/26 12:10, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> There are no users of the name and we can get this via ->alg if needed.
> Also, move struct z_erofs_decompressor into decompressor.c which is the
> only one to use it.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

I'd like to avoid z_erofs_decompress() function instead honestly.
name strings might be useful if users would like to get runtime
supported algorithms.

Thanks,
Gao Xiang

> ---
>   fs/erofs/compress.h     | 6 ------
>   fs/erofs/decompressor.c | 9 +++++----
>   2 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
> index 26fa170090b8..d161683bda03 100644
> --- a/fs/erofs/compress.h
> +++ b/fs/erofs/compress.h
> @@ -20,12 +20,6 @@ struct z_erofs_decompress_req {
>   	bool inplace_io, partial_decoding, fillgaps;
>   };
>   
> -struct z_erofs_decompressor {
> -	int (*decompress)(struct z_erofs_decompress_req *rq,
> -			  struct page **pagepool);
> -	char *name;
> -};
> -
>   /* some special page->private (unsigned long, see below) */
>   #define Z_EROFS_SHORTLIVED_PAGE		(-1UL << 2)
>   #define Z_EROFS_PREALLOCATED_PAGE	(-2UL << 2)
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 7021e2cf6146..f416ebd6f0dc 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -363,23 +363,24 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>   	return 0;
>   }
>   
> +struct z_erofs_decompressor {
> +	int (*decompress)(struct z_erofs_decompress_req *rq,
> +			  struct page **pagepool);
> +};
> +
>   static struct z_erofs_decompressor decompressors[] = {
>   	[Z_EROFS_COMPRESSION_SHIFTED] = {
>   		.decompress = z_erofs_transform_plain,
> -		.name = "shifted"
>   	},
>   	[Z_EROFS_COMPRESSION_INTERLACED] = {
>   		.decompress = z_erofs_transform_plain,
> -		.name = "interlaced"
>   	},
>   	[Z_EROFS_COMPRESSION_LZ4] = {
>   		.decompress = z_erofs_lz4_decompress,
> -		.name = "lz4"
>   	},
>   #ifdef CONFIG_EROFS_FS_ZIP_LZMA
>   	[Z_EROFS_COMPRESSION_LZMA] = {
>   		.decompress = z_erofs_lzma_decompress,
> -		.name = "lzma"
>   	},
>   #endif
>   };
