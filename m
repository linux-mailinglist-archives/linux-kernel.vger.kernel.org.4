Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB9765FAD0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 06:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjAFFGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 00:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjAFFGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 00:06:13 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200F16AD86
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 21:06:10 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VYyGFtH_1672981567;
Received: from 30.97.49.39(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VYyGFtH_1672981567)
          by smtp.aliyun-inc.com;
          Fri, 06 Jan 2023 13:06:08 +0800
Message-ID: <cbd4bc97-4ffb-45c5-8c3c-b9b81b20d813@linux.alibaba.com>
Date:   Fri, 6 Jan 2023 13:06:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs: fix kvcalloc() misuse with __GFP_NOFAIL
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com
References: <20230106031937.113318-1-hsiangkao@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230106031937.113318-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/6 11:19, Gao Xiang wrote:
> As reported by syzbot [1], kvcalloc() cannot work with  __GFP_NOFAIL.
> Let's use kcalloc() instead.
> 
> [1] https://lore.kernel.org/r/0000000000007796bd05f1852ec2@google.com
> Reported-by: syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com

Fixes: fe3e5914e6dc ("erofs: try to leave (de)compressed_pages on stack if possible")
Fixes: 4f05687fd703 ("erofs: introduce struct z_erofs_decompress_backend")

> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/zdata.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index ccf7c55d477f..08e982c77985 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1032,12 +1032,12 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
>   
>   	if (!be->decompressed_pages)
>   		be->decompressed_pages =
> -			kvcalloc(be->nr_pages, sizeof(struct page *),
> -				 GFP_KERNEL | __GFP_NOFAIL);
> +			kcalloc(be->nr_pages, sizeof(struct page *),
> +				GFP_KERNEL | __GFP_NOFAIL);
>   	if (!be->compressed_pages)
>   		be->compressed_pages =
> -			kvcalloc(pclusterpages, sizeof(struct page *),
> -				 GFP_KERNEL | __GFP_NOFAIL);
> +			kcalloc(pclusterpages, sizeof(struct page *),
> +				GFP_KERNEL | __GFP_NOFAIL);
>   
>   	z_erofs_parse_out_bvecs(be);
>   	err2 = z_erofs_parse_in_bvecs(be, &overlapped);
