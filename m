Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186FA6E7413
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjDSHfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjDSHe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:34:57 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AA97EFD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:34:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VgU2AEu_1681889692;
Received: from 30.97.48.60(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VgU2AEu_1681889692)
          by smtp.aliyun-inc.com;
          Wed, 19 Apr 2023 15:34:53 +0800
Message-ID: <e01cdedf-243d-038e-bb77-aea34e39658c@linux.alibaba.com>
Date:   Wed, 19 Apr 2023 15:34:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] migrate_pages_batch: fix statistics for longterm pin
 retry
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
References: <20230416235929.1040194-1-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230416235929.1040194-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/2023 7:59 AM, Huang Ying wrote:
> In commit fd4a7ac32918 ("mm: migrate: try again if THP split is failed
> due to page refcnt"), if the THP splitting fails due to page reference
> count, we will retry to improve migration successful rate.  But the
> failed splitting is counted as migration failure and migration retry,
> which will cause duplicated failure counting.  So, in this patch, this
> is fixed via undoing the failure counting if we decide to retry.  The
> patch is tested via failure injection.

Makes sense to me. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> Fixes: fd4a7ac32918 ("mm: migrate: try again if THP split is failed due to page refcnt")
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> ---
>   mm/migrate.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b34a0f383795..47a1e8445f45 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1743,6 +1743,9 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   							large_retry++;
>   							thp_retry += is_thp;
>   							nr_retry_pages += nr_pages;
> +							/* Undo duplicated failure counting. */
> +							nr_large_failed--;
> +							stats->nr_thp_failed -= is_thp;
>   							break;
>   						}
>   					}
