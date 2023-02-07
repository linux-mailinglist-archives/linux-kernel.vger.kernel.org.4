Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D671F68D173
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjBGI1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjBGI1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:27:21 -0500
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20BA1A94A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 00:27:19 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vb6WRLm_1675758436;
Received: from 30.221.130.169(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vb6WRLm_1675758436)
          by smtp.aliyun-inc.com;
          Tue, 07 Feb 2023 16:27:17 +0800
Message-ID: <c08e9251-79ef-d43c-27e2-c5b5e535f322@linux.alibaba.com>
Date:   Tue, 7 Feb 2023 16:27:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/6] erofs: get rid of erofs_inode_datablocks()
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/23 5:30 PM, Gao Xiang wrote:
> erofs_inode_datablocks() has the only one caller, let's just get
> rid of it entirely.  No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/erofs/internal.h |  6 ------
>  fs/erofs/namei.c    | 18 +++++-------------
>  2 files changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 08ba817d6551..c18af21ba9c4 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -344,12 +344,6 @@ static inline erofs_off_t erofs_iloc(struct inode *inode)
>  		(EROFS_I(inode)->nid << sbi->islotbits);
>  }
>  
> -static inline unsigned long erofs_inode_datablocks(struct inode *inode)
> -{
> -	/* since i_size cannot be changed */
> -	return DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
> -}
> -
>  static inline unsigned int erofs_bitrange(unsigned int value, unsigned int bit,
>  					  unsigned int bits)
>  {
> diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
> index b64a108fac92..966eabc61c13 100644
> --- a/fs/erofs/namei.c
> +++ b/fs/erofs/namei.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2022, Alibaba Cloud
>   */
>  #include "xattr.h"
> -
>  #include <trace/events/erofs.h>
>  
>  struct erofs_qstr {
> @@ -87,19 +86,13 @@ static struct erofs_dirent *find_target_dirent(struct erofs_qstr *name,
>  	return ERR_PTR(-ENOENT);
>  }
>  
> -static void *find_target_block_classic(struct erofs_buf *target,
> -				       struct inode *dir,
> -				       struct erofs_qstr *name,
> -				       int *_ndirents)
> +static void *erofs_find_target_block(struct erofs_buf *target,
> +		struct inode *dir, struct erofs_qstr *name, int *_ndirents)
>  {
> -	unsigned int startprfx, endprfx;
> -	int head, back;
> +	int head = 0, back = DIV_ROUND_UP(dir->i_size, EROFS_BLKSIZ) - 1;
> +	unsigned int startprfx = 0, endprfx = 0;
>  	void *candidate = ERR_PTR(-ENOENT);
>  
> -	startprfx = endprfx = 0;
> -	head = 0;
> -	back = erofs_inode_datablocks(dir) - 1;
> -
>  	while (head <= back) {
>  		const int mid = head + (back - head) / 2;
>  		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> @@ -180,8 +173,7 @@ int erofs_namei(struct inode *dir, const struct qstr *name, erofs_nid_t *nid,
>  	qn.end = name->name + name->len;
>  
>  	ndirents = 0;
> -
> -	de = find_target_block_classic(&buf, dir, &qn, &ndirents);
> +	de = erofs_find_target_block(&buf, dir, &qn, &ndirents);
>  	if (IS_ERR(de))
>  		return PTR_ERR(de);
>  

-- 
Thanks,
Jingbo
