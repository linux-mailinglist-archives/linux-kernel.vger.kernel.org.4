Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903D96587DB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 00:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiL1XWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 18:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiL1XWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 18:22:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C6313F2B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 15:22:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B9ACB81913
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 23:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26F8C433D2;
        Wed, 28 Dec 2022 23:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1672269727;
        bh=hld9DWzesHJspBjBdWtXXwcmpnWRtXWYimDUyNVg7lU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NCioxuAfrpjY7ec504lTvTZ+IWhdxj9/I78lN61qo3KmdYRj/MGpD7SMBgOkwepEM
         Nw77NzcT+Km4Y3muHT1eO2fLL+92+9kY2PiCa2UPRa7Dk9ynVw870WBY7YiGrZTv87
         v2OR3+8mOB7G94py+ob8315RACYrmCH0kHdxFVaI=
Date:   Wed, 28 Dec 2022 15:22:06 -0800
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
Subject: Re: [PATCH 5/8] migrate_pages: batch _unmap and _move
Message-Id: <20221228152206.52435aef4072c4cad9087541@linux-foundation.org>
In-Reply-To: <20221227002859.27740-6-ying.huang@intel.com>
References: <20221227002859.27740-1-ying.huang@intel.com>
        <20221227002859.27740-6-ying.huang@intel.com>
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

On Tue, 27 Dec 2022 08:28:56 +0800 Huang Ying <ying.huang@intel.com> wrote:

> In this patch the _unmap and _move stage of the folio migration is
> batched.  That for, previously, it is,
> 
>   for each folio
>     _unmap()
>     _move()
> 
> Now, it is,
> 
>   for each folio
>     _unmap()
>   for each folio
>     _move()
> 
> Based on this, we can batch the TLB flushing and use some hardware
> accelerator to copy folios between batched _unmap and batched _move
> stages.
> 
> ...
>
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1027,8 +1027,32 @@ static void __migrate_folio_extract(struct folio *dst,
>  	dst->private = NULL;
>  }
>  
> +static void migrate_folio_undo_src(struct folio *src,
> +				   int page_was_mapped,
> +				   struct anon_vma *anon_vma,
> +				   struct list_head *ret)
> +{
> +	if (page_was_mapped)
> +		remove_migration_ptes(src, src, false);
> +	if (anon_vma)
> +		put_anon_vma(anon_vma);
> +	folio_unlock(src);
> +	list_move_tail(&src->lru, ret);
> +}
> +
> +static void migrate_folio_undo_dst(struct folio *dst,
> +				   free_page_t put_new_page,
> +				   unsigned long private)
> +{
> +	folio_unlock(dst);
> +	if (put_new_page)
> +		put_new_page(&dst->page, private);
> +	else
> +		folio_put(dst);
> +}

What do the above do?  Are they so obvious that no comments are needed?


>  static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
> -				int force, enum migrate_mode mode)
> +				 int force, bool force_lock, enum migrate_mode mode)
>  {
>  	int rc = -EAGAIN;
>  	int page_was_mapped = 0;
> @@ -1055,6 +1079,11 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>  		if (current->flags & PF_MEMALLOC)
>  			goto out;
>  
> +		if (!force_lock) {
> +			rc = -EDEADLOCK;
> +			goto out;
> +		}

Please document the use of EDEADLOCK in this code.  What does it signify?

>  		folio_lock(src);
>  	}
>  

