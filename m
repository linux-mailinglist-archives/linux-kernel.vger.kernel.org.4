Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639815E5B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIVGDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiIVGDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:03:48 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C459B4431
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:03:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VQQzvIj_1663826617;
Received: from 30.97.48.87(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VQQzvIj_1663826617)
          by smtp.aliyun-inc.com;
          Thu, 22 Sep 2022 14:03:39 +0800
Message-ID: <0a41c051-7d7e-cb1b-8273-192252e74b94@linux.alibaba.com>
Date:   Thu, 22 Sep 2022 14:03:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC 1/6] mm/migrate_pages: separate huge page and normal pages
 migration
To:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
References: <20220921060616.73086-1-ying.huang@intel.com>
 <20220921060616.73086-2-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220921060616.73086-2-ying.huang@intel.com>
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



On 9/21/2022 2:06 PM, Huang Ying wrote:
> This is a preparation patch to batch the page unmapping and moving for
> the normal pages and THPs.  Based on that we can batch the TLB
> shootdown during the page migration and make it possible to use some
> hardware accelerator for the page copying.
> 
> In this patch the huge page (PageHuge()) and normal page and THP
> migration is separated in migrate_pages() to make it easy to change
> the normal page and THP migration implementation.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>   mm/migrate.c | 73 +++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 64 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 571d8c9fd5bc..117134f1c6dc 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1414,6 +1414,66 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   
>   	trace_mm_migrate_pages_start(mode, reason);
>   
> +	for (pass = 0; pass < 10 && retry; pass++) {
> +		retry = 0;
> +
> +		list_for_each_entry_safe(page, page2, from, lru) {
> +			nr_subpages = compound_nr(page);
> +			cond_resched();
> +
> +			if (!PageHuge(page))
> +				continue;
> +
> +			rc = unmap_and_move_huge_page(get_new_page,
> +						put_new_page, private, page,
> +						pass > 2, mode, reason,
> +						&ret_pages);
> +			/*
> +			 * The rules are:
> +			 *	Success: hugetlb page will be put back
> +			 *	-EAGAIN: stay on the from list
> +			 *	-ENOMEM: stay on the from list
> +			 *	-ENOSYS: stay on the from list
> +			 *	Other errno: put on ret_pages list then splice to
> +			 *		     from list
> +			 */
> +			switch(rc) {
> +			case -ENOSYS:
> +				/* Hugetlb migration is unsupported */
> +				nr_failed++;
> +				nr_failed_pages += nr_subpages;
> +				list_move_tail(&page->lru, &ret_pages);
> +				break;
> +			case -ENOMEM:
> +				/*
> +				 * When memory is low, don't bother to try to migrate
> +				 * other pages, just exit.
> +				 */
> +				nr_failed++;
> +				nr_failed_pages += nr_subpages + nr_retry_pages;
> +				goto out;
> +			case -EAGAIN:
> +				retry++;
> +				nr_retry_pages += nr_subpages;
> +				break;
> +			case MIGRATEPAGE_SUCCESS:
> +				nr_succeeded += nr_subpages;
> +				break;
> +			default:
> +				/*
> +				 * Permanent failure (-EBUSY, etc.):
> +				 * unlike -EAGAIN case, the failed page is
> +				 * removed from migration page list and not
> +				 * retried in the next outer loop.
> +				 */
> +				nr_failed++;
> +				nr_failed_pages += nr_subpages;
> +				break;
> +			}
> +		}
> +	}
> +	nr_failed += retry;

Seems we should also record the nr_retry_pages? since the second loop 
will reset the nr_retry_pages.

nr_failed_pages += nr_retry_pages;

Besides, I also agree with Zi Yan's comment to simplify this larger 
function.
