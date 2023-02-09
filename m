Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A49690031
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBIGGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBIGGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:06:08 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54B915C83
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 22:06:05 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VbEcEWi_1675922761;
Received: from 30.97.49.34(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VbEcEWi_1675922761)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 14:06:03 +0800
Message-ID: <fcb92d78-fc5a-8f51-8a1b-75fd878cf8a1@linux.alibaba.com>
Date:   Thu, 9 Feb 2023 14:06:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/4] erofs: relinquish volume with mutex held
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        zhujia.zj@bytedance.com
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
References: <20230209051838.33297-1-jefflexu@linux.alibaba.com>
 <20230209051838.33297-4-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230209051838.33297-4-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/9 13:18, Jingbo Xu wrote:
> Relinquish fscache volume with mutex held.  Otherwise if a new domain is
> registered when the old domain with the same name gets removed from the
> list but not relinquished yet, fscache may complain the collision.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

Do we need to backport this to old kernels?
IOWs, whether "Fixes:" tag is needed?

Thanks,
Gao Xiang

> ---
>   fs/erofs/fscache.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 2f5930e177cc..a6f030966147 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -328,8 +328,8 @@ static void erofs_fscache_domain_put(struct erofs_domain *domain)
>   			kern_unmount(erofs_pseudo_mnt);
>   			erofs_pseudo_mnt = NULL;
>   		}
> -		mutex_unlock(&erofs_domain_list_lock);
>   		fscache_relinquish_volume(domain->volume, NULL, false);
> +		mutex_unlock(&erofs_domain_list_lock);
>   		kfree(domain->domain_id);
>   		kfree(domain);
>   		return;
