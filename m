Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8066DC35E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 07:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjDJFyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 01:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDJFyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 01:54:03 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A784B2D58
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 22:54:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VfgWm51_1681106037;
Received: from 30.97.49.25(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VfgWm51_1681106037)
          by smtp.aliyun-inc.com;
          Mon, 10 Apr 2023 13:53:58 +0800
Message-ID: <cb6f5267-f424-7565-2dac-329097cafd24@linux.alibaba.com>
Date:   Mon, 10 Apr 2023 13:53:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 6/7] erofs: handle long xattr name prefixes properly
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
 <20230407141710.113882-7-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230407141710.113882-7-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/7 22:17, Jingbo Xu wrote:
> Make .{list,get}xattr routines adapted to long xattr name prefixes.
> When the bit 7 of erofs_xattr_entry.e_name_index is set, it indicates
> that it refers to a long xattr name prefix.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   fs/erofs/xattr.c | 60 +++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 52 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 684571e83a2c..8d81593655e8 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -301,11 +301,39 @@ struct getxattr_iter {
>   	struct qstr name;
>   };
>   
> +static int erofs_xattr_long_entrymatch(struct getxattr_iter *it,
> +				       struct erofs_xattr_entry *entry)
> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(it->it.sb);
> +	u8 idx = entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK;
> +	struct erofs_xattr_prefix_item *pf;
> +
> +	if (idx >= sbi->xattr_prefix_count)
> +		return -ENOATTR;
> +
> +	pf = &sbi->xattr_prefixes[idx];

	struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes + idx;

	if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
		return -ENOATTR;

?


> +	if (it->index != pf->prefix->base_index)
> +		return -ENOATTR;
> +
> +	if (strncmp(it->name.name, pf->prefix->infix, pf->infix_len))
> +		return -ENOATTR;
> +
> +	it->name.name += pf->infix_len;
> +	it->name.len -= pf->infix_len;
> +	if (it->name.len != entry->e_name_len)
> +		return -ENOATTR;
> +	return 0;
> +}
> +
>   static int xattr_entrymatch(struct xattr_iter *_it,
>   			    struct erofs_xattr_entry *entry)
>   {
>   	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
>   
> +	/* should also match the infix for long name prefixes */
> +	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX)
> +		return erofs_xattr_long_entrymatch(it, entry);
> +
>   	return (it->index != entry->e_name_index ||
>   		it->name.len != entry->e_name_len) ? -ENOATTR : 0;
>   }
> @@ -487,12 +515,26 @@ static int xattr_entrylist(struct xattr_iter *_it,
>   {
>   	struct listxattr_iter *it =
>   		container_of(_it, struct listxattr_iter, it);
> -	unsigned int prefix_len;
> -	const char *prefix;
> -
> -	const struct xattr_handler *h =
> -		erofs_xattr_handler(entry->e_name_index);
> +	unsigned int base_index = entry->e_name_index;
> +	unsigned int prefix_len, infix_len = 0;
> +	const char *prefix, *infix = NULL;
> +	const struct xattr_handler *h;
> +
> +	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX) {
> +		struct erofs_sb_info *sbi = EROFS_SB(_it->sb);
> +		u8 idx = entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK;
> +		struct erofs_xattr_prefix_item *pf;
> +
> +		if (idx >= sbi->xattr_prefix_count)
> +			return 1;
> +
> +		pf = &sbi->xattr_prefixes[idx];

		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes + idx;

		if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
			return 1;
?


Otherwise it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang


> +		infix = pf->prefix->infix;
> +		infix_len = pf->infix_len;
> +		base_index = pf->prefix->base_index;
> +	}
>   
> +	h = erofs_xattr_handler(base_index);
>   	if (!h || (h->list && !h->list(it->dentry)))
>   		return 1;
>   
> @@ -500,16 +542,18 @@ static int xattr_entrylist(struct xattr_iter *_it,
>   	prefix_len = strlen(prefix);
>   
>   	if (!it->buffer) {
> -		it->buffer_ofs += prefix_len + entry->e_name_len + 1;
> +		it->buffer_ofs += prefix_len + infix_len +
> +					entry->e_name_len + 1;
>   		return 1;
>   	}
>   
> -	if (it->buffer_ofs + prefix_len
> +	if (it->buffer_ofs + prefix_len + infix_len +
>   		+ entry->e_name_len + 1 > it->buffer_size)
>   		return -ERANGE;
>   
>   	memcpy(it->buffer + it->buffer_ofs, prefix, prefix_len);
> -	it->buffer_ofs += prefix_len;
> +	memcpy(it->buffer + it->buffer_ofs + prefix_len, infix, infix_len);
> +	it->buffer_ofs += prefix_len + infix_len;
>   	return 0;
>   }
>   
