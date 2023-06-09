Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E92728E91
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 05:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjFIDb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 23:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFIDb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 23:31:26 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DCB30ED
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 20:31:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VkgUALR_1686281479;
Received: from 30.97.48.228(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VkgUALR_1686281479)
          by smtp.aliyun-inc.com;
          Fri, 09 Jun 2023 11:31:20 +0800
Message-ID: <7b0ac912-6606-0a76-608d-59f8e2b113ea@linux.alibaba.com>
Date:   Fri, 9 Jun 2023 11:31:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v6 1/5] erofs: use absolute position in xattr iterator
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
        huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230608113020.66626-1-jefflexu@linux.alibaba.com>
 <20230608113020.66626-2-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230608113020.66626-2-jefflexu@linux.alibaba.com>
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



On 2023/6/8 19:30, Jingbo Xu wrote:
> Replace blkaddr/ofs with pos in 'struct erofs_xattr_iter'.
> 
> After erofs_bread() is introduced to replace raw page cache APIs for
> metadata I/Os handling, xattr_iter_fixup() is no longer needed anymore.
> 
> In addition, it is also unnecessary to check if the iterated position is
> span over the block boundary as absolute offset is used instead of
> blkaddr + offset pairs.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

...

>   
> @@ -399,9 +365,10 @@ static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
>   
>   	for (i = 0; i < vi->xattr_shared_count; ++i) {
>   		xsid = vi->xattr_shared_xattrs[i];
> -		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
> -		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
> -		it->it.kaddr = erofs_bread(&it->it.buf, it->it.blkaddr, EROFS_KMAP);
> +		it->it.pos = erofs_pos(sb, EROFS_SB(sb)->xattr_blkaddr) +
> +				       xsid * sizeof(__u32);

					^ sizeof(__le32); ?

> +		it->it.kaddr = erofs_bread(&it->it.buf,
> +				erofs_blknr(sb, it->it.pos), EROFS_KMAP);
>   		if (IS_ERR(it->it.kaddr))
>   			return PTR_ERR(it->it.kaddr);
>   
> @@ -604,9 +571,10 @@ static int shared_listxattr(struct listxattr_iter *it)
>   
>   	for (i = 0; i < vi->xattr_shared_count; ++i) {
>   		xsid = vi->xattr_shared_xattrs[i];
> -		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
> -		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
> -		it->it.kaddr = erofs_bread(&it->it.buf, it->it.blkaddr, EROFS_KMAP);
> +		it->it.pos = erofs_pos(sb, EROFS_SB(sb)->xattr_blkaddr) +
> +				       xsid * sizeof(__u32);

					^ sizeof(__le32); ?


Otherwise it looks good to me.

Thanks,
Gao Xiang
