Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517CF6D15B7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 04:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCaCnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 22:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCaCnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 22:43:49 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEADDBEE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 19:43:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vf0Oh9r_1680230623;
Received: from 30.221.134.33(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vf0Oh9r_1680230623)
          by smtp.aliyun-inc.com;
          Fri, 31 Mar 2023 10:43:45 +0800
Message-ID: <10420fbe-a0f2-fd3f-8c04-068c7ce9faab@linux.alibaba.com>
Date:   Fri, 31 Mar 2023 10:43:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/8] erofs: simplify erofs_xattr_generic_get()
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
 <20230330082910.125374-4-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230330082910.125374-4-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/30 16:29, Jingbo Xu wrote:
> erofs_xattr_generic_get() won't be called from xattr handlers other than
> user/trusted/security xattr handler, and thus there's no need of extra
> checking.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

I plan to apply these three patches to -next first, and then look into
the rests.

Thanks,
Gao Xiang

> ---
>   fs/erofs/xattr.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index dc36a0c0919c..d76b74ece2e5 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -432,20 +432,9 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
>   				   struct dentry *unused, struct inode *inode,
>   				   const char *name, void *buffer, size_t size)
>   {
> -	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
> -
> -	switch (handler->flags) {
> -	case EROFS_XATTR_INDEX_USER:
> -		if (!test_opt(&sbi->opt, XATTR_USER))
> -			return -EOPNOTSUPP;
> -		break;
> -	case EROFS_XATTR_INDEX_TRUSTED:
> -		break;
> -	case EROFS_XATTR_INDEX_SECURITY:
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> +	if (handler->flags == EROFS_XATTR_INDEX_USER &&
> +	    !test_opt(&EROFS_I_SB(inode)->opt, XATTR_USER))
> +		return -EOPNOTSUPP;
>   
>   	return erofs_getxattr(inode, handler->flags, name, buffer, size);
>   }
