Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CC3710589
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 07:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjEYF4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 01:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEYF4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 01:56:21 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F67BE7
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 22:56:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VjR-1Ir_1684994174;
Received: from 30.97.48.238(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjR-1Ir_1684994174)
          by smtp.aliyun-inc.com;
          Thu, 25 May 2023 13:56:15 +0800
Message-ID: <c3dbd82a-75c2-969d-02ce-b7a31b29a95e@linux.alibaba.com>
Date:   Thu, 25 May 2023 13:56:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs: don't calculate new start when expanding read
 length
To:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
        jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
References: <20230525055147.13220-1-zbestahu@gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230525055147.13220-1-zbestahu@gmail.com>
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



On 2023/5/25 22:51, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> We only expand the trailing edge and not the leading edge.  So no need
> to obtain new start again.  Let's use the existing ->headoffset instead.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
>   fs/erofs/zdata.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 874fee35af32..bab8dcb8e848 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1828,26 +1828,24 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
>   {
>   	struct inode *inode = f->inode;
>   	struct erofs_map_blocks *map = &f->map;
> -	erofs_off_t cur, end;
> +	erofs_off_t cur, end, headoffset = f->headoffset;


That is not quite useful, or could you merge this info the original patch?

Thanks,
Gao Xiang

>   	int err;
>   
>   	if (backmost) {
>   		if (rac)
> -			end = f->headoffset + readahead_length(rac) - 1;
> +			end = headoffset + readahead_length(rac) - 1;
>   		else
> -			end = f->headoffset + PAGE_SIZE - 1;
> +			end = headoffset + PAGE_SIZE - 1;
>   		map->m_la = end;
>   		err = z_erofs_map_blocks_iter(inode, map,
>   					      EROFS_GET_BLOCKS_READMORE);
>   		if (err)
>   			return;
>   
> -		/* expend ra for the trailing edge if readahead */
> +		/* expand ra for the trailing edge if readahead */
>   		if (rac) {
> -			loff_t newstart = readahead_pos(rac);
> -
>   			cur = round_up(map->m_la + map->m_llen, PAGE_SIZE);
> -			readahead_expand(rac, newstart, cur - newstart);
> +			readahead_expand(rac, headoffset, cur - headoffset);
>   			return;
>   		}
>   		end = round_up(end, PAGE_SIZE);
