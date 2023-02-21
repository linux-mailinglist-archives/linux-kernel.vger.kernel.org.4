Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC7969E163
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjBUNgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjBUNgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:36:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303312333C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 05:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ob2cxxBdXr81LLPpENIwzSSrtJCmjBBJ5S46KOzsjZw=; b=no6zPNoy3SCqUF7vV0UdJg0nL2
        w7r3zESpgB4xoxy1RNWEvXGqevOZ90Gfv0aB0hSEVvBtJYCV/RvZWLO8cDKIQhtUqpzMVqSAykrTi
        l9RZY11PLwH+psnpcg+/zD9S1TGrnvsQgy+7OVI4fAV5t0K7S2jaPx712hfTXmGhicy4sk36r/rIR
        gLxHLoBYRetJKSH8uskNRKXnneTkXRGD9virQC4qe3euX4I4+fO7/OC78MWW13P0t20FDowcU+JeK
        kit1Fm6hw9RMcsfbBFJNazrxREh/nqjPhY4aLXA6sIiJoduqYpr6t5R+8QoQQRfOJZJWrZgBanpci
        afzWEhvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUSnz-00Ce2L-I6; Tue, 21 Feb 2023 13:35:39 +0000
Date:   Tue, 21 Feb 2023 13:35:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/hwpoison: convert TTU_IGNORE_HWPOISON to
 TTU_HWPOISON
Message-ID: <Y/TIq05CjrMyg7f0@casper.infradead.org>
References: <20230221085905.1465385-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221085905.1465385-1-naoya.horiguchi@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 05:59:05PM +0900, Naoya Horiguchi wrote:
> After a memory error happens on a clean folio, a process unexpectedly
> receives SIGBUS when it accesses to the error page.  This SIGBUS killing
> is pointless and simply degrades the level of RAS of the system, because
> the clean folio can be dropped without any data lost on memory error
> handling as we do for a clean pagecache.
> 
> When memory_failure() is called on a clean folio, try_to_unmap() is called
> twice (one from split_huge_page() and one from hwpoison_user_mappings()).
> The root cause of the issue is that pte conversion to hwpoisoned entry is
> now done in the first call of try_to_unmap() because PageHWPoison is already
> set at this point, while it's actually expected to be done in the second
> call.  This behavior disturbs the error handling operation like removing
> pagecache, which results in the malfunction described above.
> 
> So convert TTU_IGNORE_HWPOISON into TTU_HWPOISON and set TTU_HWPOISON only
> when we really intend to convert pte to hwpoison entry.  This can prevent
> other callers of try_to_unmap() from accidentally converting to hwpoison
> entries.
> 
> Fixes: a42634a6c07d ("readahead: Use a folio in read_pages()")

How did you choose this Fixes tag?
