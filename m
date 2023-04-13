Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A163A6E0609
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDMEgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMEge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:36:34 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F073C39
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:36:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VfzAjd0_1681360590;
Received: from 30.97.49.11(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VfzAjd0_1681360590)
          by smtp.aliyun-inc.com;
          Thu, 13 Apr 2023 12:36:30 +0800
Message-ID: <9687e2ce-e0ba-da9e-7b20-d83c56b156c8@linux.alibaba.com>
Date:   Thu, 13 Apr 2023 12:36:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] erofs: explicit cast blkaddr to u64 before shift
 operation
To:     Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jefflexu@linux.alibaba.com,
        yinxin.x@bytedance.com, xiang@kernel.org
References: <20230413035734.15457-1-zhujia.zj@bytedance.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230413035734.15457-1-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/13 11:57, Jia Zhu wrote:
> We should explicitly cast @blkaddr from u32 to u64 before the shift
> operation to return the larger type.
> 
> Fixes: b1c2d99b18ff ("erofs: avoid hardcoded blocksize for subpage block support")
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Let's fold it into the original patch.

Thanks,
Gao Xiang

> ---
>   fs/erofs/data.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index aa7f9e4f86fb..6fe9a779fa91 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -35,7 +35,7 @@ void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
>   		  enum erofs_kmap_type type)
>   {
>   	struct inode *inode = buf->inode;
> -	erofs_off_t offset = blkaddr << inode->i_blkbits;
> +	erofs_off_t offset = (erofs_off_t)blkaddr << inode->i_blkbits;
>   	pgoff_t index = offset >> PAGE_SHIFT;
>   	struct page *page = buf->page;
>   	struct folio *folio;
