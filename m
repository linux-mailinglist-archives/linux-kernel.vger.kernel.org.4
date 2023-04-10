Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2CA6DC348
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 07:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjDJFYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 01:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJFYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 01:24:22 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3593A30C8
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 22:24:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VffRxgD_1681104256;
Received: from 30.97.49.25(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VffRxgD_1681104256)
          by smtp.aliyun-inc.com;
          Mon, 10 Apr 2023 13:24:17 +0800
Message-ID: <d064267e-8ee6-4259-1cd3-3554b88ce662@linux.alibaba.com>
Date:   Mon, 10 Apr 2023 13:24:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 4/7] erofs: introduce on-disk format for long xattr name
 prefixes
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
 <20230407141710.113882-5-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230407141710.113882-5-jefflexu@linux.alibaba.com>
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
> Besides the predefined xattr name prefixes, introduces long xattr name
> prefixes, which work similarly as the predefined name prefixes, except
> that they are user specified.
> 
> It is especially useful for use cases together with overlayfs like
> Composefs model, which introduces diverse xattr values with only a few
> common xattr names (trusted.overlay.redirect, trusted.overlay.digest,
> and maybe more in the future).  That makes the existing predefined
> prefixes ineffective in both image size and runtime performance.
> 
> When a user specified long xattr name prefix is used, only the trailing
> part of the xattr name apart from the long xattr name prefix will be
> stored in erofs_xattr_entry.e_name.  e_name is empty if the xattr name
> matches exactly as the long xattr name prefix.  All long xattr prefixes
> are stored in the packed or meta inode, which depends if fragments
> feature is enabled or not.
> 
> For each long xattr name prefix, the on-disk format is kept as the same
> as the unique metadata format: ALIGN({__le16 len, data}, 4), where len
> represents the total size of struct erofs_xattr_long_prefix, followed
> by data of struct erofs_xattr_long_prefix itself.
> 
> Each erofs_xattr_long_prefix keeps predefined prefixes (base_index)
> and the remaining prefix string without the trailing '\0'.
> 
> Two fields are introduced to the on-disk superblock, where
> xattr_prefix_count represents the total number of the long xattr name
> prefixes recorded, and xattr_prefix_start represents the start offset of
> recorded name prefixes in the packed/meta inode divided by 4.
> 
> When referring to a long xattr name prefix, the highest bit (bit 7) of
> erofs_xattr_entry.e_name_index is set, while the lower bits (bit 0-6)
> as a whole represents the index of the referred long name prefix among
> all long xattr name prefixes.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/erofs_fs.h | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 44876a97cabd..ea62f83dac40 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -76,7 +76,8 @@ struct erofs_super_block {
>   	__le16 extra_devices;	/* # of devices besides the primary device */
>   	__le16 devt_slotoff;	/* startoff = devt_slotoff * devt_slotsize */
>   	__u8 dirblkbits;	/* directory block size in bit shift */
> -	__u8 reserved[5];
> +	__u8 xattr_prefix_count;	/* # of long xattr name prefixes */
> +	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
>   	__le64 packed_nid;	/* nid of the special packed inode */
>   	__u8 reserved2[24];
>   };
> @@ -229,6 +230,13 @@ struct erofs_xattr_ibody_header {
>   #define EROFS_XATTR_INDEX_LUSTRE            5
>   #define EROFS_XATTR_INDEX_SECURITY          6
>   
> +/*
> + * bit 7 of e_name_index is set when it refers to a long xattr name prefix,
> + * while the remained lower bits represent the index of the prefix.
> + */
> +#define EROFS_XATTR_LONG_PREFIX		0x80
> +#define EROFS_XATTR_LONG_PREFIX_MASK	0x7f
> +
>   /* xattr entry (for both inline & shared xattrs) */
>   struct erofs_xattr_entry {
>   	__u8   e_name_len;      /* length of name */
> @@ -238,6 +246,12 @@ struct erofs_xattr_entry {
>   	char   e_name[];        /* attribute name */
>   };
>   
> +/* long xattr name prefix */
> +struct erofs_xattr_long_prefix {
> +	__u8   base_index;	/* short xattr name prefix index */
> +	char   infix[];		/* infix apart from short prefix */
> +};
> +
>   static inline unsigned int erofs_xattr_ibody_size(__le16 i_xattr_icount)
>   {
>   	if (!i_xattr_icount)
