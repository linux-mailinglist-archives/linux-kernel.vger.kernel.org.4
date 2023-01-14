Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784EF66AA0E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 09:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjANIVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 03:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjANIVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 03:21:16 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083B1173A
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 00:21:12 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VZX-xcu_1673684468;
Received: from 192.168.31.66(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZX-xcu_1673684468)
          by smtp.aliyun-inc.com;
          Sat, 14 Jan 2023 16:21:09 +0800
Message-ID: <57611d57-121c-9fe4-777f-d20c96374e75@linux.alibaba.com>
Date:   Sat, 14 Jan 2023 16:21:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] erofs: clean up erofs_iget()
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230113065226.68801-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230113065226.68801-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/23 2:52 PM, Gao Xiang wrote:
> Move inode hash function into inode.c and simplify erofs_iget().
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Since the v2 triggers the compiling error, this v1 is also acceptable
for me.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

> ---
>  fs/erofs/inode.c    | 40 +++++++++++++++++++++-------------------
>  fs/erofs/internal.h |  9 ---------
>  2 files changed, 21 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index d3b8736fa124..57328691582e 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -308,47 +308,49 @@ static int erofs_fill_inode(struct inode *inode)
>  }
>  
>  /*
> - * erofs nid is 64bits, but i_ino is 'unsigned long', therefore
> - * we should do more for 32-bit platform to find the right inode.
> + * ino_t is 32-bits on 32-bit arch. We have to squash the 64-bit value down
> + * so that it will fit.
>   */
> -static int erofs_ilookup_test_actor(struct inode *inode, void *opaque)
> +static ino_t erofs_squash_ino(erofs_nid_t nid)
>  {
> -	const erofs_nid_t nid = *(erofs_nid_t *)opaque;
> +	ino_t ino = (ino_t)nid;
> +
> +	if (sizeof(ino_t) < sizeof(erofs_nid_t))
> +		ino ^= nid >> (sizeof(erofs_nid_t) - sizeof(ino_t)) * 8;
> +	return ino;
> +}
>  
> -	return EROFS_I(inode)->nid == nid;
> +static int erofs_iget5_eq(struct inode *inode, void *opaque)
> +{
> +	return EROFS_I(inode)->nid == *(erofs_nid_t *)opaque;
>  }
>  
> -static int erofs_iget_set_actor(struct inode *inode, void *opaque)
> +static int erofs_iget5_set(struct inode *inode, void *opaque)
>  {
>  	const erofs_nid_t nid = *(erofs_nid_t *)opaque;
>  
> -	inode->i_ino = erofs_inode_hash(nid);
> +	inode->i_ino = erofs_squash_ino(nid);
> +	EROFS_I(inode)->nid = nid;
>  	return 0;
>  }
>  
>  struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid)
>  {
> -	const unsigned long hashval = erofs_inode_hash(nid);
>  	struct inode *inode;
>  
> -	inode = iget5_locked(sb, hashval, erofs_ilookup_test_actor,
> -		erofs_iget_set_actor, &nid);
> +	inode = iget5_locked(sb, erofs_squash_ino(nid), erofs_iget5_eq,
> +			     erofs_iget5_set, &nid);
>  	if (!inode)
>  		return ERR_PTR(-ENOMEM);
>  
>  	if (inode->i_state & I_NEW) {
> -		int err;
> -		struct erofs_inode *vi = EROFS_I(inode);
> -
> -		vi->nid = nid;
> +		int err = erofs_fill_inode(inode);
>  
> -		err = erofs_fill_inode(inode);
> -		if (!err) {
> -			unlock_new_inode(inode);
> -		} else {
> +		if (err) {
>  			iget_failed(inode);
> -			inode = ERR_PTR(err);
> +			return ERR_PTR(err);
>  		}
> +		unlock_new_inode(inode);
>  	}
>  	return inode;
>  }
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index bb8501c0ff5b..168c21f16383 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -480,15 +480,6 @@ int erofs_map_blocks(struct inode *inode,
>  		     struct erofs_map_blocks *map, int flags);
>  
>  /* inode.c */
> -static inline unsigned long erofs_inode_hash(erofs_nid_t nid)
> -{
> -#if BITS_PER_LONG == 32
> -	return (nid >> 32) ^ (nid & 0xffffffff);
> -#else
> -	return nid;
> -#endif
> -}
> -
>  extern const struct inode_operations erofs_generic_iops;
>  extern const struct inode_operations erofs_symlink_iops;
>  extern const struct inode_operations erofs_fast_symlink_iops;

-- 
Thanks,
Jingbo
