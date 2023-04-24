Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA5B6DD70F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDKJks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDKJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:40:25 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9507C30EB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 02:40:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VfrtLsv_1681206015;
Received: from 30.97.49.18(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VfrtLsv_1681206015)
          by smtp.aliyun-inc.com;
          Tue, 11 Apr 2023 17:40:16 +0800
Message-ID: <b47b01fd-feb8-5715-ce9b-dfe1d2a019b6@linux.alibaba.com>
Date:   Tue, 11 Apr 2023 17:40:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v3 6/7] erofs: handle long xattr name prefixes properly
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230410063918.47215-1-jefflexu@linux.alibaba.com>
 <20230411093537.127286-1-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230411093537.127286-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/11 17:35, Jingbo Xu wrote:
> Make .{list,get}xattr routines adapted to long xattr name prefixes.
> When the bit 7 of erofs_xattr_entry.e_name_index is set, it indicates
> that it refers to a long xattr name prefix.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
> v3: introduce infix_len to struct getxattr_iter, and refactor the
> implementation of xattr_entrymatch(), erofs_xattr_long_entrymatch(), and
> xattr_namematch() accordingly.
> 
> The erofs_xattr_long_entrymatch() of v2 version will advance
> it->name.name pointer by pf->infix_len prematurely, as the following
> xattr_namematch() may fail (-ENOATTR) since mismatching.  And then
> it->name.name will be compared with the next xattr entry, while
> it->name.name has been mistakenly modified in the previous round.  This
> will cause -ENOATTR error on the existing xattr.

Yes, please also help add a new erofs-utils testcase for this.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> 
> ---
>   fs/erofs/xattr.c | 68 +++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 56 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 684571e83a2c..a04724c816e5 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -297,17 +297,45 @@ struct getxattr_iter {
>   	struct xattr_iter it;
>   
>   	char *buffer;
> -	int buffer_size, index;
> +	int buffer_size, index, infix_len;
>   	struct qstr name;
>   };
>   
> +static int erofs_xattr_long_entrymatch(struct getxattr_iter *it,
> +				       struct erofs_xattr_entry *entry)
> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(it->it.sb);
> +	struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
> +		(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
> +
> +	if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
> +		return -ENOATTR;
> +
> +	if (it->index != pf->prefix->base_index ||
> +	    it->name.len != entry->e_name_len + pf->infix_len)
> +		return -ENOATTR;
> +
> +	if (memcmp(it->name.name, pf->prefix->infix, pf->infix_len))
> +		return -ENOATTR;
> +
> +	it->infix_len = pf->infix_len;
> +	return 0;
> +}
> +
>   static int xattr_entrymatch(struct xattr_iter *_it,
>   			    struct erofs_xattr_entry *entry)
>   {
>   	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
>   
> -	return (it->index != entry->e_name_index ||
> -		it->name.len != entry->e_name_len) ? -ENOATTR : 0;
> +	/* should also match the infix for long name prefixes */
> +	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX)
> +		return erofs_xattr_long_entrymatch(it, entry);
> +
> +	if (it->index != entry->e_name_index ||
> +	    it->name.len != entry->e_name_len)
> +		return -ENOATTR;
> +	it->infix_len = 0;
> +	return 0;
>   }
>   
>   static int xattr_namematch(struct xattr_iter *_it,
> @@ -315,7 +343,9 @@ static int xattr_namematch(struct xattr_iter *_it,
>   {
>   	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
>   
> -	return memcmp(buf, it->name.name + processed, len) ? -ENOATTR : 0;
> +	if (memcmp(buf, it->name.name + it->infix_len + processed, len))
> +		return -ENOATTR;
> +	return 0;
>   }
>   
>   static int xattr_checkbuffer(struct xattr_iter *_it,
> @@ -487,12 +517,24 @@ static int xattr_entrylist(struct xattr_iter *_it,
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
> +		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
> +			(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
> +
> +		if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
> +			return 1;
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
