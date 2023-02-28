Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B9F6A5319
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 07:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjB1GhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 01:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjB1GhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 01:37:04 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C6735A7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 22:37:03 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id ne1so6172025qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 22:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677566222;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UnSMc2eC7TT8GRaOBiducGgakN8v8m1KKOplmSAdLhE=;
        b=LPQbwZTeR4hbSO7sOvb0sBRtbQOloGT3priC/yF1nfWcaDZ7Gn0LcaX1UcK1/7fu4j
         WTB9sLxP4oT1BSF6P7tVWlsyhC3foajVBh00efjVpBq46ybMNEFhL9gbeYvwbl9DvqEn
         9Uj4CSv4cjSh1P30IC5Zv28/RsZQ6p4SYJB0W60Qw/tlmJGTHDriygdgMsvcZPi7RnPO
         6dswOJ0YiOpgQ75mdCm940NT53/ctFW02t/CL59u/KypdjdywIXXlHU6JdW2iTNcdq2C
         cO3xiANcsrVaWArdsRhxz6JxDjNmwQ1XMQt0bHsMokiaalk/MjuLuzAYFX7qkYkqZASd
         f74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677566222;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnSMc2eC7TT8GRaOBiducGgakN8v8m1KKOplmSAdLhE=;
        b=ZvLFIoMPF9suixJJQSGkBcF3HFgjP4pp3ThUwdkZVbpDVPZPRMMY//btxL4zf/tc+a
         1IsBQWU7V09Wgdo1F0xP742ZN1FYWHCaMPQ+AKBWArKyvToegfBjdMGgZ+Sl94xUdCEf
         YDP2bOoExzhEKzeVstkrpVCPmLDooe2wpKRHqIpQ6/ez6DICNb8QUVls/0odgy0Ug/SC
         F/J4Hrr+nZDC6+sUz6qYefN2cWZGQx9OZ6C2edLP0sieurEJMt54N9cs2d3yLLmhjsey
         K/sdVvDnS3w7q4ZNKdz+CKVU9q/MylAcrX7tA20wsdHN/74X0EvJA+S8RVZZtBLLkx0Y
         r3Fg==
X-Gm-Message-State: AO0yUKVse7zyYJGjmDQEWiCjPMpsLBseNqUkGwG23RQ9t6lmLmy+sRP0
        cPcyj6wS/BcKe697VMgVas/W9A==
X-Google-Smtp-Source: AK7set+MKUxY0/5FkPLn5n3grygqwxv6M5lR7jdEadEZQK6/eX+4HhqaOK6x7xm0KM9Nu4SpuNVbHg==
X-Received: by 2002:a05:6214:2582:b0:56f:c948:411b with SMTP id fq2-20020a056214258200b0056fc948411bmr3683651qvb.29.1677566222383;
        Mon, 27 Feb 2023 22:37:02 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a190-20020a3798c7000000b00742aff9574asm3483768qke.65.2023.02.27.22.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 22:37:01 -0800 (PST)
Date:   Mon, 27 Feb 2023 22:36:59 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Huang Ying <ying.huang@intel.com>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefan Roesch <shr@devkernel.io>, Tejun Heo <tj@kernel.org>,
        Xin Hao <xhao@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 3/3] migrate_pages: try migrate in batch asynchronously
 firstly
In-Reply-To: <20230224141145.96814-4-ying.huang@intel.com>
Message-ID: <bdc873-3367-9aa7-79c6-91c68fecac41@google.com>
References: <20230224141145.96814-1-ying.huang@intel.com> <20230224141145.96814-4-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023, Huang Ying wrote:

> When we have locked more than one folios, we cannot wait the lock or
> bit (e.g., page lock, buffer head lock, writeback bit) synchronously.
> Otherwise deadlock may be triggered.  This make it hard to batch the
> synchronous migration directly.
> 
> This patch re-enables batching synchronous migration via trying to
> migrate in batch asynchronously firstly.  And any folios that are
> failed to be migrated asynchronously will be migrated synchronously
> one by one.
> 
> Test shows that this can restore the TLB flushing batching performance
> for synchronous migration effectively.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Hugh Dickins <hughd@google.com>

I'm not sure whether my 48 hours on two machines counts for a
Tested-by: Hugh Dickins <hughd@google.com>
or not; but it certainly looks like you've fixed my deadlock.

> Cc: "Xu, Pengfei" <pengfei.xu@intel.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Stefan Roesch <shr@devkernel.io>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Xin Hao <xhao@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/migrate.c | 65 ++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 55 insertions(+), 10 deletions(-)

I was initially disappointed, that this was more complicated than I had
thought it should be; but came to understand why.  My "change the mode
to MIGRATE_ASYNC after the first" model would have condemned most of the
MIGRATE_SYNC batch of pages to be handled as lightly as MIGRATE_ASYNC:
not good enough, you're right be trying harder here.

> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 91198b487e49..c17ce5ee8d92 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1843,6 +1843,51 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  	return rc;
>  }
>  
> +static int migrate_pages_sync(struct list_head *from, new_page_t get_new_page,
> +		free_page_t put_new_page, unsigned long private,
> +		enum migrate_mode mode, int reason, struct list_head *ret_folios,
> +		struct list_head *split_folios, struct migrate_pages_stats *stats)
> +{
> +	int rc, nr_failed = 0;
> +	LIST_HEAD(folios);
> +	struct migrate_pages_stats astats;
> +
> +	memset(&astats, 0, sizeof(astats));
> +	/* Try to migrate in batch with MIGRATE_ASYNC mode firstly */
> +	rc = migrate_pages_batch(from, get_new_page, put_new_page, private, MIGRATE_ASYNC,
> +				 reason, &folios, split_folios, &astats,
> +				 NR_MAX_MIGRATE_PAGES_RETRY);

I wonder if that and below would better be NR_MAX_MIGRATE_PAGES_RETRY / 2.

Though I've never got down to adjusting that number (and it's not a job
to be done in this set of patches), those 10 retries sometimes terrify
me, from a latency point of view.  They can have such different weights:
in the unmapped case, 10 retries is okay; but when a pinned page is mapped
into 1000 processes, the thought of all that unmapping and TLB flushing
and remapping is terrifying.

Since you're retrying below, halve both numbers of retries for now?

> +	stats->nr_succeeded += astats.nr_succeeded;
> +	stats->nr_thp_succeeded += astats.nr_thp_succeeded;
> +	stats->nr_thp_split += astats.nr_thp_split;
> +	if (rc < 0) {
> +		stats->nr_failed_pages += astats.nr_failed_pages;
> +		stats->nr_thp_failed += astats.nr_thp_failed;
> +		list_splice_tail(&folios, ret_folios);
> +		return rc;
> +	}
> +	stats->nr_thp_failed += astats.nr_thp_split;
> +	nr_failed += astats.nr_thp_split;
> +	/*
> +	 * Fall back to migrate all failed folios one by one synchronously. All
> +	 * failed folios except split THPs will be retried, so their failure
> +	 * isn't counted
> +	 */
> +	list_splice_tail_init(&folios, from);
> +	while (!list_empty(from)) {
> +		list_move(from->next, &folios);
> +		rc = migrate_pages_batch(&folios, get_new_page, put_new_page,
> +					 private, mode, reason, ret_folios,
> +					 split_folios, stats, NR_MAX_MIGRATE_PAGES_RETRY);

NR_MAX_MIGRATE_PAGES_RETRY / 2 ?

> +		list_splice_tail_init(&folios, ret_folios);
> +		if (rc < 0)
> +			return rc;
> +		nr_failed += rc;
> +	}
> +
> +	return nr_failed;
> +}
> +
>  /*
>   * migrate_pages - migrate the folios specified in a list, to the free folios
>   *		   supplied as the target for the page migration
> @@ -1874,7 +1919,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
>  {
>  	int rc, rc_gather;
> -	int nr_pages, batch;
> +	int nr_pages;
>  	struct folio *folio, *folio2;
>  	LIST_HEAD(folios);
>  	LIST_HEAD(ret_folios);
> @@ -1890,10 +1935,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	if (rc_gather < 0)
>  		goto out;
>  
> -	if (mode == MIGRATE_ASYNC)
> -		batch = NR_MAX_BATCHED_MIGRATION;
> -	else
> -		batch = 1;
>  again:
>  	nr_pages = 0;
>  	list_for_each_entry_safe(folio, folio2, from, lru) {
> @@ -1904,16 +1945,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  		}
>  
>  		nr_pages += folio_nr_pages(folio);
> -		if (nr_pages >= batch)
> +		if (nr_pages >= NR_MAX_BATCHED_MIGRATION)
>  			break;
>  	}
> -	if (nr_pages >= batch)
> +	if (nr_pages >= NR_MAX_BATCHED_MIGRATION)
>  		list_cut_before(&folios, from, &folio2->lru);
>  	else
>  		list_splice_init(from, &folios);
> -	rc = migrate_pages_batch(&folios, get_new_page, put_new_page, private,
> -				 mode, reason, &ret_folios, &split_folios, &stats,
> -				 NR_MAX_MIGRATE_PAGES_RETRY);
> +	if (mode == MIGRATE_ASYNC)
> +		rc = migrate_pages_batch(&folios, get_new_page, put_new_page, private,
> +					 mode, reason, &ret_folios, &split_folios, &stats,
> +					 NR_MAX_MIGRATE_PAGES_RETRY);
> +	else
> +		rc = migrate_pages_sync(&folios, get_new_page, put_new_page, private,
> +					mode, reason, &ret_folios, &split_folios, &stats);
>  	list_splice_tail_init(&folios, &ret_folios);
>  	if (rc < 0) {
>  		rc_gather = rc;
> -- 
> 2.39.1
