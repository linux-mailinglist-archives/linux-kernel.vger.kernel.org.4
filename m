Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77778696855
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjBNPpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBNPpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:45:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9054129169
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9lU73ZoFhBTcdZN9x08jVIcyX5ECGsitJLIRVZh0T7s=; b=uBbXi5TVSxuXib6uU8k1PJvwA/
        Hqf16+cDeIzpgyYkqCwLiUMikYCzMf978wzRxroKd260Y8fwGxvBLBXcaWpkDmIa2GtypW35QxKVX
        OduYoIxcUA4CuGs3wD0pV5CySgva7mhbTeqcNi8br13zpgudfWuIBMKy/oyCdszwLSVFz/Os9dniu
        kWwutnNBU7IdYY4u15hJEyL99bul9sHsCbmxO2AeR5BbajjOp7v1cQTUu1u6rwq+LHQe7EigjxLUR
        2tXK5rDlsvWguvdMhSy4YHrBNucIBK9bdVe7Dveu3nLoKpbtdJGuhwLYQRRUWnRyeLEYU3h7UmNWW
        XRHFZQFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRxUE-006byz-Q5; Tue, 14 Feb 2023 15:44:54 +0000
Date:   Tue, 14 Feb 2023 15:44:54 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/khugepaged: set THP as uptodate earlier for shmem
Message-ID: <Y+usdhfguWr/aD5x@casper.infradead.org>
References: <20230214075710.2401855-1-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214075710.2401855-1-stevensd@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 04:57:09PM +0900, David Stevens wrote:
>  	/*
> -	 * At this point the hpage is locked and not up-to-date.
> -	 * It's safe to insert it into the page cache, because nobody would
> -	 * be able to map it or use it in another way until we unlock it.
> +	 * Mark hpage as up-to-date before inserting it into the page cache to
> +	 * prevent it from being mistaken for an fallocated but unwritten page.
> +	 * Inserting the unfinished hpage into the page cache is safe because
> +	 * it is locked, so nobody can map it or use it in another way until we
> +	 * unlock it.

No, that's not true.  The data has to be there before we mark it
uptodate.  See filemap_get_pages() for example, used as part of
read().  We don't lock the page unless we need to bring it uptodate
ourselves.
