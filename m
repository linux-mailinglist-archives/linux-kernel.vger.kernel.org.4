Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4D173B248
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjFWIDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjFWIDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:03:45 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6931BE2;
        Fri, 23 Jun 2023 01:03:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VllSQm1_1687507418;
Received: from 30.121.25.227(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VllSQm1_1687507418)
          by smtp.aliyun-inc.com;
          Fri, 23 Jun 2023 16:03:39 +0800
Message-ID: <6f0dfe19-426a-19cd-05f2-7184377b4862@linux.alibaba.com>
Date:   Fri, 23 Jun 2023 16:03:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH][next] ocfs2: remove redundant assignment to variable
 bit_off
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com,
        akpm <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230622102736.2831126-1-colin.i.king@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20230622102736.2831126-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 6/22/23 6:27 PM, Colin Ian King wrote:
> Variable bit_off is being assigned a value that is never read, it is
> being re-assigned a new value in the following while loop. Remove the
> assignment. Cleans up clang scan build warning:
> 
> fs/ocfs2/localalloc.c:976:18: warning: Although the value stored to
> 'bit_off' is used in the enclosing expression, the value is never
> actually read from 'bit_off' [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/localalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
> index c4426d12a2ad..c803c10dd97e 100644
> --- a/fs/ocfs2/localalloc.c
> +++ b/fs/ocfs2/localalloc.c
> @@ -973,7 +973,7 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
>  	la_start_blk = ocfs2_clusters_to_blocks(osb->sb,
>  						le32_to_cpu(la->la_bm_off));
>  	bitmap = la->la_bitmap;
> -	start = count = bit_off = 0;
> +	start = count = 0;
>  	left = le32_to_cpu(alloc->id1.bitmap1.i_total);
>  
>  	while ((bit_off = ocfs2_find_next_zero_bit(bitmap, left, start))
