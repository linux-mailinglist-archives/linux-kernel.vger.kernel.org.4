Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2999B72A233
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjFIS3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjFIS3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:29:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024DF1730
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:29:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89D4A65A36
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 18:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AEBC433D2;
        Fri,  9 Jun 2023 18:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686335385;
        bh=SGJLakpGQ9+imGHhwroWvQc/1Heuje+5zACglaU2qHc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A2T8P8YR6ss4yJosVhVgMWl3ZvvXT2jEX6kAijUTb5vVRZaZT9jUp7wSn+Iv3h33G
         rl1Oz8XqTaRxrDLZRTxmimF4Uq0zPJ7l86l9hqSa0miqL1EZUYHvyYY5iZLpkChUdy
         7SEGtKdoYwcHaYOOmCL0TSIyIDEgqgjjdQ/QoiTM=
Date:   Fri, 9 Jun 2023 11:29:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tarun Sahu <tsahu@linux.ibm.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        aneesh.kumar@linux.ibm.com, willy@infradead.org,
        sidhartha.kumar@oracle.com, gerald.schaefer@linux.ibm.com,
        linux-kernel@vger.kernel.org, jaypatel@linux.ibm.com
Subject: Re: [PATCH v3] mm/folio: Avoid special handling for order value 0
 in folio_set_order
Message-Id: <20230609112944.fc08936beb29a18f7bfb5ae3@linux-foundation.org>
In-Reply-To: <20230609162907.111756-1-tsahu@linux.ibm.com>
References: <20230609162907.111756-1-tsahu@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Jun 2023 21:59:07 +0530 Tarun Sahu <tsahu@linux.ibm.com> wrote:

> folio_set_order(folio, 0) is used in kernel at two places
> __destroy_compound_gigantic_folio and __prep_compound_gigantic_folio.
> Currently, It is called to clear out the folio->_folio_nr_pages and
> folio->_folio_order.
> 
> For __destroy_compound_gigantic_folio:
> In past, folio_set_order(folio, 0) was needed because page->mapping used
> to overlap with _folio_nr_pages and _folio_order. So if these fields were
> left uncleared during freeing gigantic hugepages, they were causing
> "BUG: bad page state" due to non-zero page->mapping. Now, After
> Commit a01f43901cfb ("hugetlb: be sure to free demoted CMA pages to
> CMA") page->mapping has explicitly been cleared out for tail pages. Also,
> _folio_order and _folio_nr_pages no longer overlaps with page->mapping.
> 
> So, folio_set_order(folio, 0) can be removed from freeing gigantic
> folio path (__destroy_compound_gigantic_folio).

The above appears to be a code cleanup only?

> Another place, folio_set_order(folio, 0) is called inside
> __prep_compound_gigantic_folio during error path. Here,
> folio_set_order(folio, 0) can also be removed if we move
> folio_set_order(folio, order) after for loop.
> 
> The patch also moves _folio_set_head call in __prep_compound_gigantic_folio()
> such that we avoid clearing them in the error path.

And the above also sounds like a code cleanup.

> Also, as Mike pointed out:
> "It would actually be better to move the calls _folio_set_head and
> folio_set_order in __prep_compound_gigantic_folio() as suggested here. Why?
> In the current code, the ref count on the 'head page' is still 1 (or more)
> while those calls are made. So, someone could take a speculative ref on the
> page BEFORE the tail pages are set up."
> 
> This way, folio_set_order(folio, 0) is no more needed. And it will also
> helps removing the confusion of folio order being set to 0 (as _folio_order
> field is part of first tail page).
> 
> Testing: I have run LTP tests, which all passes. and also I have written
> the test in LTP which tests the bug caused by compound_nr and page->mapping
> overlapping.

What bug?  Please describe the end-user visible effects of any bug.

And if a bug is indeed fixed, please let's try to identify a Fixes:
target and let's decide whether a -stable backport is needed.

Thanks.

> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
> 
> Running on older kernel ( < 5.10-rc7) with the above bug this fails while
> on newer kernel and, also with this patch it passes.
> 

