Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3D6730E05
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 06:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243011AbjFOEUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 00:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242890AbjFOEUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:20:45 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA2410A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 21:20:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vl9-ymZ_1686802839;
Received: from 30.221.149.215(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vl9-ymZ_1686802839)
          by smtp.aliyun-inc.com;
          Thu, 15 Jun 2023 12:20:41 +0800
Message-ID: <62aa21a7-283a-4860-2a0a-b23ed38e6424@linux.alibaba.com>
Date:   Thu, 15 Jun 2023 12:20:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] erofs: remove unnecessary goto
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230615034539.14286-1-frank.li@vivo.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230615034539.14286-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
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



On 6/15/23 11:45 AM, Yangtao Li wrote:
> It's redundant, let's remove it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/erofs/super.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 811ab66d805e..f48ce692094d 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -1016,10 +1016,8 @@ static int __init erofs_module_init(void)
>  					       sizeof(struct erofs_inode), 0,
>  					       SLAB_RECLAIM_ACCOUNT,
>  					       erofs_inode_init_once);
> -	if (!erofs_inode_cachep) {
> -		err = -ENOMEM;
> -		goto icache_err;
> -	}
> +	if (!erofs_inode_cachep)
> +		return -ENOMEM;
>  
>  	err = erofs_init_shrinker();
>  	if (err)
> @@ -1054,7 +1052,6 @@ static int __init erofs_module_init(void)
>  	erofs_exit_shrinker();
>  shrinker_err:
>  	kmem_cache_destroy(erofs_inode_cachep);
> -icache_err:
>  	return err;
>  }
>  

-- 
Thanks,
Jingbo
