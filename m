Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BCC7145AF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjE2HmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjE2Hlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:41:47 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B43BE1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:41:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vjis6Cv_1685346099;
Received: from 30.221.134.122(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vjis6Cv_1685346099)
          by smtp.aliyun-inc.com;
          Mon, 29 May 2023 15:41:40 +0800
Message-ID: <9d928aa7-31cf-e4c1-8694-0aa63e55b382@linux.alibaba.com>
Date:   Mon, 29 May 2023 15:41:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/5] erofs: introduce erofs_xattr_iter_fixup_aligned()
 helper
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230518024551.123990-1-jefflexu@linux.alibaba.com>
 <20230518024551.123990-2-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230518024551.123990-2-jefflexu@linux.alibaba.com>
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

Hi,

On 2023/5/18 10:45, Jingbo Xu wrote:
> Introduce erofs_xattr_iter_fixup_aligned() helper where
> it.ofs <= EROFS_BLKSIZ is mandatory.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   fs/erofs/xattr.c | 79 +++++++++++++++++++++---------------------------
>   1 file changed, 35 insertions(+), 44 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index bbfe7ce170d2..b79be2a556ba 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -29,6 +29,28 @@ struct xattr_iter {
>   	unsigned int ofs;
>   };
>   
> +static inline int erofs_xattr_iter_fixup(struct xattr_iter *it)
> +{
> +	if (it->ofs < it->sb->s_blocksize)
> +		return 0;
> +
> +	it->blkaddr += erofs_blknr(it->sb, it->ofs);
> +	it->kaddr = erofs_read_metabuf(&it->buf, it->sb, it->blkaddr, EROFS_KMAP);

could we use a new buf interface to init_metabuf at once?

> +	if (IS_ERR(it->kaddr))
> +		return PTR_ERR(it->kaddr);
> +	it->ofs = erofs_blkoff(it->sb, it->ofs);
> +	return 0;
> +}
> +
> +static inline int erofs_xattr_iter_fixup_aligned(struct xattr_iter *it)

Since we're doing cleanup, this name sounds confusing to me
since here the meaning is actually "we don't allow pos >
blksize", IOWs, any pos <= blksize is allowed here, so
'aligned' is not accurate.

Could we think out a better one?

Thanks,
Gao Xiang
