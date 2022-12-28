Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587A36587D7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 00:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiL1XRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 18:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiL1XRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 18:17:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70F913D77
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 15:17:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9DA961645
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 23:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2FFC433EF;
        Wed, 28 Dec 2022 23:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1672269457;
        bh=w3Rr9ivFjnV3esspD85qFy2NhTPDUghMYW5Ck9kdk10=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Eq9n3BwVPz9gSgeeWeqlP+VVTCilTbLEiOWa7G9/tNTYlilXjazrIGwcV5D0NwaWF
         KVLQcC4Eq5BNimUIMLMOi9rdEPTAUMvytFEBUaJR+pZOLA9IiLukXjRcFDb0nyqBFD
         19oTrX8kCxgCZciOFh3YUtD70hZF0q8v6Wp4MMH0=
Date:   Wed, 28 Dec 2022 15:17:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 2/8] migrate_pages: separate hugetlb folios migration
Message-Id: <20221228151735.e855bde30c1782bb45b97930@linux-foundation.org>
In-Reply-To: <20221227002859.27740-3-ying.huang@intel.com>
References: <20221227002859.27740-1-ying.huang@intel.com>
        <20221227002859.27740-3-ying.huang@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2022 08:28:53 +0800 Huang Ying <ying.huang@intel.com> wrote:

> This is a preparation patch to batch the folio unmapping and moving
> for the non-hugetlb folios.  Based on that we can batch the TLB
> shootdown during the folio migration and make it possible to use some
> hardware accelerator for the folio copying.
> 
> In this patch the hugetlb folios and non-hugetlb folios migration is
> separated in migrate_pages() to make it easy to change the non-hugetlb
> folios migration implementation.
> 
> ...
>
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1404,6 +1404,87 @@ struct migrate_pages_stats {
>  	int nr_thp_split;
>  };
>  
> +static int migrate_hugetlbs(struct list_head *from, new_page_t get_new_page,
> +			    free_page_t put_new_page, unsigned long private,
> +			    enum migrate_mode mode, int reason,
> +			    struct migrate_pages_stats *stats,
> +			    struct list_head *ret_folios)
> +{
> +	int retry = 1;
> +	int nr_failed = 0;
> +	int nr_retry_pages = 0;
> +	int pass = 0;
> +	struct folio *folio, *folio2;
> +	int rc = 0, nr_pages;
> +
> +	for (pass = 0; pass < 10 && retry; pass++) {

Why 10?

> +		retry = 0;
> +		nr_retry_pages = 0;
> +
> +		list_for_each_entry_safe(folio, folio2, from, lru) {
> +			if (!folio_test_hugetlb(folio))
> +				continue;
> +
> +			nr_pages = folio_nr_pages(folio);
> +
> +			cond_resched();
> +
> +			rc = unmap_and_move_huge_page(get_new_page,
> +						      put_new_page, private,
> +						      &folio->page, pass > 2, mode,
> +						      reason, ret_folios);
> +			/*
> +			 * The rules are:
> +			 *	Success: hugetlb folio will be put back
> +			 *	-EAGAIN: stay on the from list
> +			 *	-ENOMEM: stay on the from list
> +			 *	-ENOSYS: stay on the from list
> +			 *	Other errno: put on ret_folios list
> +			 */
> +			switch(rc) {
> +			case -ENOSYS:
> +				/* Hugetlb migration is unsupported */
> +				nr_failed++;
> +				stats->nr_failed_pages += nr_pages;
> +				list_move_tail(&folio->lru, ret_folios);
> +				break;
> +			case -ENOMEM:
> +				/*
> +				 * When memory is low, don't bother to try to migrate
> +				 * other folios, just exit.
> +				 */
> +				nr_failed++;
> +				stats->nr_failed_pages += nr_pages;
> +				goto out;
> +			case -EAGAIN:
> +				retry++;
> +				nr_retry_pages += nr_pages;
> +				break;
> +			case MIGRATEPAGE_SUCCESS:
> +				stats->nr_succeeded += nr_pages;
> +				break;
> +			default:
> +				/*
> +				 * Permanent failure (-EBUSY, etc.):
> +				 * unlike -EAGAIN case, the failed folio is
> +				 * removed from migration folio list and not
> +				 * retried in the next outer loop.
> +				 */
> +				nr_failed++;
> +				stats->nr_failed_pages += nr_pages;
> +				break;
> +			}
> +		}
> +	}
> +out:
> +	nr_failed += retry;
> +	stats->nr_failed_pages += nr_retry_pages;
> +	if (rc != -ENOMEM)
> +		rc = nr_failed;
> +
> +	return rc;
> +}

The interpretation of the return value of this function is somewhat
unobvious.

I suggest that this function be fully commented.

Why does a retry contribute to nr_failed.  What is the interpretation
of nr_failed.  etcetera.



