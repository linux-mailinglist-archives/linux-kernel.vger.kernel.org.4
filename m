Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3956D6EDA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbjDDVWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbjDDVWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218E34EDA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680643297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gsMxgLwi5eUVcBhQhI32IDdSM+QagF5X2xNccwIYBYA=;
        b=MlI2tPMUSj6c/GNoddXzkL4FKXnOCpp0P4ke0C9EV5nZ/qGeAciJds58iMzJKQVuigDj70
        jYNH0+2BlDavHY/nOXktM5mm4hD5FrbdYsyjl8txi+1Cx2B2mDYLhRGtD/V9FK6HwBJ2of
        W/ME1zYz87oPG+anFUn0KiGFOAgSNN0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-uuOe8nhuOYS6VxtEK2rOTA-1; Tue, 04 Apr 2023 17:21:35 -0400
X-MC-Unique: uuOe8nhuOYS6VxtEK2rOTA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-5bb2d463855so26226d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 14:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680643295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsMxgLwi5eUVcBhQhI32IDdSM+QagF5X2xNccwIYBYA=;
        b=BeC38eyEY3sdbF+deQVS638oCMAfVTyhxxt+USl/1c3fiD3n7BJB6Npr1c4Px83XUX
         qd9BtfpDTtI/TK09IrKo/qyTFAQcmwz0OFfwyawisDv1DZses7PiBcO8LH4UJACB/f2H
         +WmybiJJERd8smxYbuIEcef8yXkH87t2K0xzAnWay0sXqZAUFo06VAiE+5Z1eRsgGFsV
         PHNzOvRgZwtkKu8xJiXnFDYZ/PA7MU3enW/ySCWcYiYTJWm7Klyv+Lhf88T9/YmkXMYp
         YJMR8f8/kq9QHdKnx2zoUb2VhymqOSMBmrUoUF92+Edrn7cBM7iWq12Jbp6Y5jE3IWcf
         f9SA==
X-Gm-Message-State: AAQBX9ejtPWMCoiawj4W9nj8f3ICr85SWKjuRFF32Ya5SrVMbg4ypgy1
        hPBrAB5tDimkNV5vPWd4WdR4ithGB7IKEzw2nb3v1VKJApSZwoNYwedV4u+iBRuakQGp+PY7xQr
        mgOiI/fxlIAdaCCCV7w2PcnNJ
X-Received: by 2002:a05:6214:5283:b0:5ab:28aa:2418 with SMTP id kj3-20020a056214528300b005ab28aa2418mr137496qvb.5.1680643294836;
        Tue, 04 Apr 2023 14:21:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z5G3zlEuI6W9NLsv9PcRg2wlevGozJifkmCtjgALWcuBkKDAlM0pkKRYAYK2uHBL9g7DG2Nw==
X-Received: by 2002:a05:6214:5283:b0:5ab:28aa:2418 with SMTP id kj3-20020a056214528300b005ab28aa2418mr137479qvb.5.1680643294498;
        Tue, 04 Apr 2023 14:21:34 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id p12-20020a0cf68c000000b005dd8b9345f8sm3643736qvn.144.2023.04.04.14.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 14:21:33 -0700 (PDT)
Date:   Tue, 4 Apr 2023 17:21:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] mm/khugepaged: maintain page cache uptodate flag
Message-ID: <ZCyU26ZLSKqLj+kA@x1n>
References: <20230404120117.2562166-1-stevensd@google.com>
 <20230404120117.2562166-5-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230404120117.2562166-5-stevensd@google.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 09:01:17PM +0900, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Make sure that collapse_file doesn't interfere with checking the
> uptodate flag in the page cache by only inserting hpage into the page
> cache after it has been updated and marked uptodate. This is achieved by
> simply not replacing present pages with hpage when iterating over the
> target range.
> 
> The present pages are already locked, so replacing them with the locked
> hpage before the collapse is finalized is unnecessary. However, it is
> necessary to stop freezing the present pages after validating them,
> since leaving long-term frozen pages in the page cache can lead to
> deadlocks. Simply checking the reference count is sufficient to ensure
> that there are no long-term references hanging around that would the
> collapse would break. Similar to hpage, there is no reason that the
> present pages actually need to be frozen in addition to being locked.
> 
> This fixes a race where folio_seek_hole_data would mistake hpage for
> an fallocated but unwritten page. This race is visible to userspace via
> data temporarily disappearing from SEEK_DATA/SEEK_HOLE. This also fixes
> a similar race where pages could temporarily disappear from mincore.
> 
> Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  mm/khugepaged.c | 79 ++++++++++++++++++-------------------------------
>  1 file changed, 29 insertions(+), 50 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 7679551e9540..a19aa140fd52 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1855,17 +1855,18 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
>   *
>   * Basic scheme is simple, details are more complex:
>   *  - allocate and lock a new huge page;
> - *  - scan page cache replacing old pages with the new one
> + *  - scan page cache, locking old pages
>   *    + swap/gup in pages if necessary;
> - *    + keep old pages around in case rollback is required;
> + *  - copy data to new page
> + *  - handle shmem holes
> + *    + re-validate that holes weren't filled by someone else
> + *    + check for userfaultfd

PS: some of the changes may belong to previous patch here, but not
necessary to repost only for this, just in case there'll be a new one.

>   *  - finalize updates to the page cache;
>   *  - if replacing succeeds:
> - *    + copy data over;
> - *    + free old pages;
>   *    + unlock huge page;
> + *    + free old pages;
>   *  - if replacing failed;
> - *    + put all pages back and unfreeze them;
> - *    + restore gaps in the page cache;
> + *    + unlock old pages
>   *    + unlock and free huge page;
>   */
>  static int collapse_file(struct mm_struct *mm, unsigned long addr,
> @@ -1913,12 +1914,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  		}
>  	} while (1);
>  
> -	/*
> -	 * At this point the hpage is locked and not up-to-date.
> -	 * It's safe to insert it into the page cache, because nobody would
> -	 * be able to map it or use it in another way until we unlock it.
> -	 */
> -
>  	xas_set(&xas, start);
>  	for (index = start; index < end; index++) {
>  		page = xas_next(&xas);
> @@ -2076,12 +2071,16 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  		VM_BUG_ON_PAGE(page != xas_load(&xas), page);
>  
>  		/*
> -		 * The page is expected to have page_count() == 3:
> +		 * We control three references to the page:
>  		 *  - we hold a pin on it;
>  		 *  - one reference from page cache;
>  		 *  - one from isolate_lru_page;
> +		 * If those are the only references, then any new usage of the
> +		 * page will have to fetch it from the page cache. That requires
> +		 * locking the page to handle truncate, so any new usage will be
> +		 * blocked until we unlock page after collapse/during rollback.
>  		 */
> -		if (!page_ref_freeze(page, 3)) {
> +		if (page_count(page) != 3) {
>  			result = SCAN_PAGE_COUNT;
>  			xas_unlock_irq(&xas);
>  			putback_lru_page(page);

Personally I don't see anything wrong with this change to resolve the dead
lock.  E.g. fast gup race right before unmapping the pgtables seems fine,
since we'll just bail out with >3 refcounts (or fast-gup bails out by
checking pte changes).  Either way looks fine here.

So far it looks good to me, but that may not mean much per the history on
what I can overlook.  It'll be always good to hear from Hugh and others.

-- 
Peter Xu

