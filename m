Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3815BFC87
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIUKm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiIUKmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:42:14 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4CE90C53
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:42:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VQO.Rpi_1663756926;
Received: from 30.97.48.63(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VQO.Rpi_1663756926)
          by smtp.aliyun-inc.com;
          Wed, 21 Sep 2022 18:42:06 +0800
Message-ID: <5b74c435-6dec-4346-e237-ad36bfcb9789@linux.alibaba.com>
Date:   Wed, 21 Sep 2022 18:42:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1] mm/vmscan: check the return value of migrate_pages()
To:     Li Zhong <floridsleeves@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org
References: <20220917021257.3840548-1-floridsleeves@gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220917021257.3840548-1-floridsleeves@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/17/2022 10:12 AM, Li Zhong wrote:
> Check the return value of migrate_pages() to check error exeuction.
> 
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>   mm/vmscan.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b2b1431352dc..50aaaa9377e2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1547,6 +1547,7 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
>   {
>   	int target_nid = next_demotion_node(pgdat->node_id);
>   	unsigned int nr_succeeded;
> +	int ret;
>   
>   	if (list_empty(demote_pages))
>   		return 0;
> @@ -1555,10 +1556,13 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
>   		return 0;
>   
>   	/* Demotion ignores all cpuset and mempolicy settings */
> -	migrate_pages(demote_pages, alloc_demote_page, NULL,
> +	ret = migrate_pages(demote_pages, alloc_demote_page, NULL,
>   			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
>   			    &nr_succeeded);
>   
> +	if (ret)
> +		putback_movable_pages(&pagelist);

You can not just put them back into the original lru list, instead the 
caller has handled the failed-to-demote pages, which will try to reclaim 
them.

In addition, the code cannot even be built successfully.
