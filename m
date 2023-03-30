Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE36D0D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjC3SQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjC3SQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:16:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BF6EC78
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NEpKJ7AUMjbrtNaWAPLx1nc4ouGcsx20blnZLkDljQ0=; b=vmOB4pUnsAwl4chabYAiIvENHP
        iAm/Q6hdG9EiCMzQGu19KvVNjzemGfH99CUK6IIqTKhHMhBlpsJ7uBCCTyyq0oNGzXYkl5ZrHPY/4
        G5K8xJCLzu/rxePzsFaeQyhONknjqt2kNtpJ+pecT/ecof+kcIJvRdhBgCDrTyvWxR6giZdmZD1Yv
        stW1zDLszpQa+QoWV5QInFyZhHnVJq+4aQAhbgAlBUDxbXket/esN9UDLbUhLlue56zI0+RtNY0vT
        b9REr+6ef9aHRNThfTv+s2rjDW8dJY/g/jLv3MZqxRJRnUVj6vgUhQi+273/RkNQ1UZKQcqzjQ/Hw
        vdK35UlQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1phwoH-00AeHZ-Rw; Thu, 30 Mar 2023 18:15:41 +0000
Date:   Thu, 30 Mar 2023 19:15:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        vishal.moola@gmail.com, muchun.song@linux.dev,
        sidhartha.kumar@oracle.com, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH v4 5/6] mm: convert copy_user_huge_page() to
 copy_user_folio()
Message-ID: <ZCXRzfUKZUgPiscf@casper.infradead.org>
References: <20230330134045.375163-1-zhangpeng362@huawei.com>
 <20230330134045.375163-6-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330134045.375163-6-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 09:40:44PM +0800, Peng Zhang wrote:
> +void copy_user_folio(struct folio *dst, struct folio *src,
> +		      unsigned long addr_hint,
> +		      struct vm_area_struct *vma,
> +		      unsigned int pages_per_huge_page);

Do we really want to pass in pages_per_huge_page here?  We can get
that from folio_nr_pages(dst).

> +++ b/mm/hugetlb.c
> @@ -5097,8 +5097,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  					ret = PTR_ERR(new_folio);
>  					break;
>  				}
> -				copy_user_huge_page(&new_folio->page, ptepage, addr, dst_vma,
> -						    npages);
> +				copy_user_folio(new_folio, page_folio(ptepage), addr, dst_vma,
> +						npages);
>  				put_page(ptepage);

This function should be converted to s/ptepage/pte_folio/, but that's
not for this patch series.

> -	copy_user_huge_page(&new_folio->page, old_page, address, vma,
> -			    pages_per_huge_page(h));
> +	copy_user_folio(new_folio, page_folio(old_page), address, vma,
> +			pages_per_huge_page(h));

Likewise for s/old_page/old_folio/

