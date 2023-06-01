Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD55719156
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjFADaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjFADaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:30:05 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EBB123
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 20:30:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vk-fSKn_1685590200;
Received: from 30.97.48.255(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vk-fSKn_1685590200)
          by smtp.aliyun-inc.com;
          Thu, 01 Jun 2023 11:30:01 +0800
Message-ID: <3997637a-b83a-627e-c2be-6beed51f9651@linux.alibaba.com>
Date:   Thu, 1 Jun 2023 11:29:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v5 4/6] erofs: make the size of read data stored in
 buffer_ofs
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230601024347.108469-1-jefflexu@linux.alibaba.com>
 <20230601024347.108469-5-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230601024347.108469-5-jefflexu@linux.alibaba.com>
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



On 2023/6/1 10:43, Jingbo Xu wrote:
> Since now xattr_iter structures have been unified, make the size of the
> read data stored in buffer_ofs.  Don't bother reusing buffer_size for
> this use, which may be confusing.
> 
> This is in preparation for the following further cleanup.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/xattr.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index a691d539ae4f..19f9bf67440c 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -337,7 +337,7 @@ static int xattr_checkbuffer(struct erofs_xattr_iter *it,
>   {
>   	int err = it->buffer_size < value_sz ? -ERANGE : 0;
>   
> -	it->buffer_size = value_sz;
> +	it->buffer_ofs = value_sz;
>   	return !it->buffer ? 1 : err;
>   }
>   
> @@ -370,7 +370,7 @@ static int inline_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
>   		if (ret != -ENOATTR)
>   			break;
>   	}
> -	return ret ? ret : it->buffer_size;
> +	return ret ? ret : it->buffer_ofs;
>   }
>   
>   static int shared_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
> @@ -392,7 +392,7 @@ static int shared_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
>   		if (ret != -ENOATTR)
>   			break;
>   	}
> -	return ret ? ret : it->buffer_size;
> +	return ret ? ret : it->buffer_ofs;
>   }
>   
>   static bool erofs_xattr_user_list(struct dentry *dentry)
