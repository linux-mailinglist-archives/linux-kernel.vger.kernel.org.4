Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37256E05FC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjDME1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDME1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:27:20 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AA2170F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:27:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VfzAfT2_1681360036;
Received: from 30.221.133.131(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfzAfT2_1681360036)
          by smtp.aliyun-inc.com;
          Thu, 13 Apr 2023 12:27:17 +0800
Message-ID: <c12b5de6-9591-56ba-85e6-e6292aece7bd@linux.alibaba.com>
Date:   Thu, 13 Apr 2023 12:27:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs: explicit cast blkaddr to u64 before shift
 operation
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, yinxin.x@bytedance.com,
        xiang@kernel.org
References: <20230413035734.15457-1-zhujia.zj@bytedance.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230413035734.15457-1-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/23 11:57 AM, Jia Zhu wrote:
> We should explicitly cast @blkaddr from u32 to u64 before the shift
> operation to return the larger type.
> 
> Fixes: b1c2d99b18ff ("erofs: avoid hardcoded blocksize for subpage block support")
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>  fs/erofs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index aa7f9e4f86fb..6fe9a779fa91 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -35,7 +35,7 @@ void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
>  		  enum erofs_kmap_type type)
>  {
>  	struct inode *inode = buf->inode;
> -	erofs_off_t offset = blkaddr << inode->i_blkbits;
> +	erofs_off_t offset = (erofs_off_t)blkaddr << inode->i_blkbits;
>  	pgoff_t index = offset >> PAGE_SHIFT;
>  	struct page *page = buf->page;
>  	struct folio *folio;

LGTM. Thanks for catching this.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo
