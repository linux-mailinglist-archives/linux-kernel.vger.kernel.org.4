Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F1F636557
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbiKWQHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237705AbiKWQHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:07:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4641088
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sXPQl1YCs6Mf/k1U0Y2ft9SkDteXobSD5EsA9lUmMoc=; b=wK6p3Ixs4mi/OdEnPqTQiHQPWb
        DO57EVXUpyIl7hGks9JwF6K0xAph5UN4ZTuSvlrjIobF852T6qghB6h575mqOEqjgufwUzWtcq2Gv
        5sooHj86ltRIuoSKDNz3Qcjwspl598rYwsmRr6kdGH9YMbbC+5sCZpJTJEWk3Ggb//DcPCPfK6eXX
        cbUNyEjZBM4xkbhxMAAOcPSkVPW0Px/kqRJw8T5P77fhCT67J2XmvVIGkGhpVNyCc1B7hsk05pYPi
        q8un9ay9sU4Op7tb6/wzJRftYQi4m4Sknal3i2gmJXLP91lW8qf0pSNRV/MGyBix/TVWuf/JFaKQv
        GPglhEwA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxsHF-007nFR-Hj; Wed, 23 Nov 2022 16:07:09 +0000
Date:   Wed, 23 Nov 2022 16:07:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, Gavin Shan <gshan@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com, riel@surriel.com,
        apopple@nvidia.com
Subject: Re: [PATCH] mm: migrate: Fix THP's mapcount on isolation
Message-ID: <Y35FLfDzZjMlwgF4@casper.infradead.org>
References: <20221123005752.161003-1-gshan@redhat.com>
 <e8a64b11-98f9-b571-dce9-a60df98e3e5@google.com>
 <c61612f7-b861-39cf-3e73-dbe4d134eec0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c61612f7-b861-39cf-3e73-dbe4d134eec0@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 09:56:38AM +0100, David Hildenbrand wrote:
> But we do have an even better helper in place already:
> mm/huge_memory.c:can_split_folio()
> 
> Which cares about
> 
> a) Swapcache for THP: each subpage could be in the swapcache
> b) Requires the caller to hold one reference to be safe
> 
> But I am a bit confused about the "extra_pins" for !anon. Where do the
> folio_nr_pages() references come from?

When we add a folio to the page cache, we increment its refcount by
folio_nr_pages() instead of by 1.  I suspect this is no longer needed
(if it was ever needed) and it could be changed.  See
__filemap_add_folio():

        long nr = 1;
        if (!huge) {
                nr = folio_nr_pages(folio);
        folio_ref_add(folio, nr);

> So *maybe* it makes sense to factor out can_split_folio() and call it
> something like: "folio_maybe_additionally_referenced"  [to clearly
> distinguish it from "folio_maybe_dma_pinned" that cares about actual page
> pinning (read/write page content)].
> 
> Such a function could return false positives/negatives due to races and the
> caller would have to hold one reference and be able to deal with the
> semantics.

I don't like the 'pextra_pins' parameter to a generic function ...
