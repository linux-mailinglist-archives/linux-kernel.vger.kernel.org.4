Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E8C72A40B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjFIUFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjFIUFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:05:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947B9210D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nwADDUrKoquslbkQhilAcI+nBT8U0StudfpI3E0X6k8=; b=NcFvBnyuPerSHYDFtTbTbpgMsl
        g29ZmA3RI2PklhvWfbuDIjYArmenw63kB1c4h3R7IJ5WYGozbl2yDcicNZan1fQvtiPI2Aro0vj2z
        GXO6r1S92+FtqshiFEKtM5Csem4PHw7apj8CZQlNA9Qj9OGILc/8aUJpXq9TshOfJ9gZbXtZVBLyY
        P3GEHk7pPVHsJfHPp+hPzEDQe4DbUG+vvA8Rx0q3SXe0ojfDVoEWyIpUxs+eP1R5S7lRau1+OToLd
        wjqcEIazR+UfTFxG3K7LBtqYhaR/akVAOdgqXAF9WWWa3HovqZqIlcGmmmYm7W3nV1CjIEBWPSBec
        cl8XCwgw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q7iM2-00GzYo-7p; Fri, 09 Jun 2023 20:05:02 +0000
Date:   Fri, 9 Jun 2023 21:05:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, david@redhat.com, nphamcs@gmail.com,
        jthoughton@google.com
Subject: Re: [PATCH 1/2] mm/filemap: remove hugetlb special casing in
 filemap.c
Message-ID: <ZIOF7pu0hvab7HYa@casper.infradead.org>
References: <20230609194947.37196-1-sidhartha.kumar@oracle.com>
 <20230609194947.37196-2-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609194947.37196-2-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 12:49:46PM -0700, Sidhartha Kumar wrote:
> @@ -850,12 +847,9 @@ static inline loff_t folio_file_pos(struct folio *folio)
>  
>  /*
>   * Get the offset in PAGE_SIZE (even for hugetlb folios).
> - * (TODO: hugetlb folios should have ->index in PAGE_SIZE)
>   */
>  static inline pgoff_t folio_pgoff(struct folio *folio)
>  {
> -	if (unlikely(folio_test_hugetlb(folio)))
> -		return hugetlb_basepage_index(&folio->page);
>  	return folio->index;
>  }
>  

Unfortunately, you can't split the patches like this.  If somebody's
running a git bisect for an entirely different problem and lands on the
boundary between these two patches, they'll have a non-functional kernel
(at least if they're using hugetlbfs).  So these two patches have to be
combined.  Maybe there's another way to split up the patches, but I
don't immediately see it.  Maybe after I read more of them.
