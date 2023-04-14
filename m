Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C1C6E1CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 08:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDNG3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 02:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNG3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 02:29:00 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291341FE7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 23:28:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vg2TGjn_1681453692;
Received: from 30.97.49.1(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vg2TGjn_1681453692)
          by smtp.aliyun-inc.com;
          Fri, 14 Apr 2023 14:28:13 +0800
Message-ID: <f2cbd4dc-5e24-9d09-4c8c-96d2dc4b2958@linux.alibaba.com>
Date:   Fri, 14 Apr 2023 14:28:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] erofs: fix potential overflow calculating xattr_isize
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230414061810.6479-1-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230414061810.6479-1-jefflexu@linux.alibaba.com>
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



On 2023/4/14 14:18, Jingbo Xu wrote:
> Given on-disk i_xattr_icount is 16 bits and xattr_isize is calculated
> from i_xattr_icount multiplying 4, xattr_isize has a theoretical maximum
> of 256K (64K * 4).
> 
> Thus declare xattr_isize as unsigned int to avoid the potential overflow.
> 
> Fixes: bfb8674dc044 ("staging: erofs: add erofs in-memory stuffs")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Thanks for catching this!
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/internal.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 8a563374b518..c86241a32ab3 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -306,7 +306,7 @@ struct erofs_inode {
>   
>   	unsigned char datalayout;
>   	unsigned char inode_isize;
> -	unsigned short xattr_isize;
> +	unsigned int xattr_isize;
>   
>   	unsigned int xattr_shared_count;
>   	unsigned int *xattr_shared_xattrs;
