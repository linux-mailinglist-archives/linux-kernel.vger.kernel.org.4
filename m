Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FD86E4038
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjDQGyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjDQGyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:54:19 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C753DF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:53:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VgELZVh_1681714379;
Received: from 30.97.49.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VgELZVh_1681714379)
          by smtp.aliyun-inc.com;
          Mon, 17 Apr 2023 14:53:00 +0800
Message-ID: <26cdf7b0-5d7d-68ba-da76-1ad800708946@linux.alibaba.com>
Date:   Mon, 17 Apr 2023 14:52:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] erofs: remove unneeded icur field from struct
 z_erofs_decompress_frontend
To:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     jefflexu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        huyue2@coolpad.com, zhangwen@coolpad.com
References: <20230417064136.5890-1-zbestahu@gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230417064136.5890-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/17 14:41, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> The icur field is only used in z_erofs_try_inplace_io(). Let's just use
> a local variable instead. And no need to check if the pcluster is inline
> when setting icur since inline page cannot be used for inplace I/O.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Nope, it's a behavior change.
Other users could feed more inplace I/O pages before I/O submission
to reduce memory consumption, it's common when applying stress model
in low memory scenarios.

Thanks,
Gao Xiang

> ---
>   fs/erofs/zdata.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index f759152feffa..f8bf2b227942 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -554,9 +554,6 @@ struct z_erofs_decompress_frontend {
>   	/* used for applying cache strategy on the fly */
>   	bool backmost;
>   	erofs_off_t headoffset;
> -
> -	/* a pointer used to pick up inplace I/O pages */
> -	unsigned int icur;
>   };
>   
>   #define DECOMPRESS_FRONTEND_INIT(__i) { \
> @@ -707,11 +704,13 @@ static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
>   				   struct z_erofs_bvec *bvec)
>   {
>   	struct z_erofs_pcluster *const pcl = fe->pcl;
> +	/* file-backed online pages are traversed in reverse order */
> +	unsigned int icur = pcl->pclusterpages;
>   
> -	while (fe->icur > 0) {
> -		if (!cmpxchg(&pcl->compressed_bvecs[--fe->icur].page,
> +	while (icur > 0) {
> +		if (!cmpxchg(&pcl->compressed_bvecs[--icur].page,
>   			     NULL, bvec->page)) {
> -			pcl->compressed_bvecs[fe->icur] = *bvec;
> +			pcl->compressed_bvecs[icur] = *bvec;
>   			return true;
>   		}
>   	}
> @@ -877,8 +876,6 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
>   	}
>   	z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
>   				Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
> -	/* since file-backed online pages are traversed in reverse order */
> -	fe->icur = z_erofs_pclusterpages(fe->pcl);
>   	return 0;
>   }
>   
