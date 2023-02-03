Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377DF688F1E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 06:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjBCFwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 00:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjBCFwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 00:52:35 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C45C5247
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 21:52:33 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VanVKHo_1675403550;
Received: from 30.97.48.205(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VanVKHo_1675403550)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 13:52:30 +0800
Message-ID: <cc67566e-6b49-c351-b8e7-9c842df8325e@linux.alibaba.com>
Date:   Fri, 3 Feb 2023 13:52:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] erofs: call erofs_map_dev() inside erofs_map_blocks()
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Cc:     linux-kernel@vger.kernel.org
References: <20230203035303.35082-1-jefflexu@linux.alibaba.com>
 <20230203035303.35082-4-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230203035303.35082-4-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/3 11:53, Jingbo Xu wrote:
> For now erofs_map_blocks() is always followed by erofs_map_dev().
> Make erofs_map_dev() called inside erofs_map_blocks() to reduce code
> duplication.

Could we just integrate mdev into struct erofs_map_blocks?

BTW, I still think erofs_map_dev() is useful since it can handle
non-inode IO requests, so let's keep this rather than mergeing all
code into erofs_map_blocks()

Thanks,
Gao Xiang

> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   fs/erofs/data.c     | 21 ++++++++++-----------
>   fs/erofs/fscache.c  | 20 ++------------------
>   fs/erofs/internal.h |  3 ++-
>   3 files changed, 14 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 32e66d29968f..cbe7a6d6846d 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -116,7 +116,8 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>   	return 0;
>   }
>   
> -int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
> +int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map,
> +		     struct erofs_map_dev *mdev)
>   {
>   	struct super_block *sb = inode->i_sb;
>   	struct erofs_inode *vi = EROFS_I(inode);
> @@ -188,8 +189,14 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
>   out_unlock:
>   	erofs_put_metabuf(&buf);
>   out:
> -	if (!err)
> +	if (!err) {
>   		map->m_llen = map->m_plen;
> +		*mdev = (struct erofs_map_dev) {
> +			.m_deviceid = map->m_deviceid,
> +			.m_pa = map->m_pa,
> +		};
> +		err = erofs_map_dev(sb, mdev);
> +	}
>   	trace_erofs_map_blocks_exit(inode, map, EROFS_GET_BLOCKS_RAW, err);
>   	return err;
>   }
> @@ -253,15 +260,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   	map.m_la = offset;
>   	map.m_llen = length;
>   
> -	ret = erofs_map_blocks(inode, &map);
> -	if (ret < 0)
> -		return ret;
> -
> -	mdev = (struct erofs_map_dev) {
> -		.m_deviceid = map.m_deviceid,
> -		.m_pa = map.m_pa,
> -	};
> -	ret = erofs_map_dev(inode->i_sb, &mdev);
> +	ret = erofs_map_blocks(inode, &map, &mdev);
>   	if (ret)
>   		return ret;
>   
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 7f1ef2ffc4db..140ccacc1043 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -229,7 +229,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
>   	int ret;
>   
>   	map.m_la = pos;
> -	ret = erofs_map_blocks(inode, &map);
> +	ret = erofs_map_blocks(inode, &map, &mdev);
>   	if (ret)
>   		return ret;
>   
> @@ -270,14 +270,6 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
>   	count = min_t(size_t, map.m_llen - (pos - map.m_la), count);
>   	DBG_BUGON(!count || count % PAGE_SIZE);
>   
> -	mdev = (struct erofs_map_dev) {
> -		.m_deviceid = map.m_deviceid,
> -		.m_pa = map.m_pa,
> -	};
> -	ret = erofs_map_dev(sb, &mdev);
> -	if (ret)
> -		return ret;
> -
>   	req = erofs_fscache_req_chain(primary, count);
>   	if (IS_ERR(req))
>   		return PTR_ERR(req);
> @@ -377,15 +369,7 @@ static int erofs_fscache_share_file_open(struct inode *inode, struct file *filp)
>   	struct file *realfile;
>   	int ret;
>   
> -	ret = erofs_map_blocks(inode, &map);
> -	if (ret)
> -		return ret;
> -
> -	mdev = (struct erofs_map_dev) {
> -		.m_deviceid = map.m_deviceid,
> -		.m_pa = map.m_pa,
> -	};
> -	ret = erofs_map_dev(inode->i_sb, &mdev);
> +	ret = erofs_map_blocks(inode, &map, &mdev);
>   	if (ret)
>   		return ret;
>   
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 323c2c775023..c54dec32a868 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -502,7 +502,8 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
>   int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
>   int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   		 u64 start, u64 len);
> -int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
> +int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map,
> +		     struct erofs_map_dev *mdev);
>   
>   /* inode.c */
>   static inline unsigned long erofs_inode_hash(erofs_nid_t nid)
