Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B2B70F47B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjEXKp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjEXKpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:45:55 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4DB13E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:45:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VjNqNUm_1684925148;
Received: from 30.97.48.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjNqNUm_1684925148)
          by smtp.aliyun-inc.com;
          Wed, 24 May 2023 18:45:49 +0800
Message-ID: <4056d17c-6cdf-0248-b36f-1fbb7a3685e8@linux.alibaba.com>
Date:   Wed, 24 May 2023 18:45:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs: remove end parameter from
 z_erofs_pcluster_readmore()
To:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
        jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
References: <20230524101305.22105-1-zbestahu@gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230524101305.22105-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/24 03:13, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> The `end` argument is pointless if it's not backmost.  And we already
> have `headoffset` in struct `*f`, so let's use this offset to get the
> `end` for backmost only instead in this function.
> 
> Also, remove linux/prefetch.h since it's not used anymore after commit
> 386292919c25 ("erofs: introduce readmore decompression strategy").
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> --->   fs/erofs/zdata.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 5cd971bcf95e..b7ebdc8f2135 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2022 Alibaba Cloud
>    */
>   #include "compress.h"
> -#include <linux/prefetch.h>
>   #include <linux/psi.h>
>   #include <linux/cpuhotplug.h>
>   #include <trace/events/erofs.h>
> @@ -1825,16 +1824,16 @@ static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
>    */
>   static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
>   				      struct readahead_control *rac,
> -				      erofs_off_t end,
> -				      struct page **pagepool,
> -				      bool backmost)
> +				      struct page **pagepool, bool backmost)
>   {
>   	struct inode *inode = f->inode;
>   	struct erofs_map_blocks *map = &f->map;
> -	erofs_off_t cur;
> +	erofs_off_t cur, end;
>   	int err;
>   
>   	if (backmost) {
> +		end = f->headoffset +
> +		      rac ? readahead_length(rac) : PAGE_SIZE - 1;

		could we avoid "?:" here for readability?

Thanks,
Gao Xiang
