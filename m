Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFF8713220
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 05:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbjE0DSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 23:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjE0DSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 23:18:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1057B99
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 20:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hirSS0lNlrtCE60q+oZ9YkZaBfSH5GDFvjqZfjQXkZc=; b=Rb7ZgsJYO4YhTxAlvvlGehrro+
        +JFMNAO1Zax7qSZTOS/BYLujt/b8zOzWAY45Uo6Df5cWgU9uxaCP0tEtfK0UvyYEnC4E6TCgtMr3o
        9I99EQqiaVYROKPMiZq06hBJZHb2FQYof7FgdiyS6LMU9kzLxzjHh+PyTsJpEF5mU+lEJVanhaFAQ
        B34hWYASoYl28bJmL5dHEO/PhjBvMda92T6DA23T59v63v8AP8jzQEzdzit0mQdnFbsF9EMDZ+C73
        iVXIb2cuE+dlQdfFL/SVRDB/mI+wgjw4lC2sauksxu8awaBM6q85px3ixYnoh+btzgUQRs0VBLsLO
        6pWyIXwg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2kRT-003TLK-ER; Sat, 27 May 2023 03:18:07 +0000
Date:   Sat, 27 May 2023 04:18:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        akpm@linux-foundation.org, ying.huang@intel.com,
        mgorman@techsingularity.net, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Khalid Aziz <khalid@kernel.org>
Subject: Re: [PATCH v4] mm, compaction: Skip all non-migratable pages during
 scan
Message-ID: <ZHF2byaRlaX3W6Md@casper.infradead.org>
References: <ZG+99h3zg7POIits@casper.infradead.org>
 <ee093583-71c3-51ba-980f-0facb03b0e23@oracle.com>
 <ZG/I7tYY4uV/32hP@casper.infradead.org>
 <ZG/To8Z3StoVoenU@casper.infradead.org>
 <60367660-f4a3-06dc-4d17-4dbdc733ef74@oracle.com>
 <ZHDh4Jeb/vKY+nGU@casper.infradead.org>
 <f5a37f8d-d888-9085-2f2b-1e350a267396@redhat.com>
 <ZHD+eOMpZpWXNAig@casper.infradead.org>
 <e31cd404-56ce-4cad-fcc3-3a6695f750fa@redhat.com>
 <846b770c-9f63-90a2-0435-ec82484e3f74@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <846b770c-9f63-90a2-0435-ec82484e3f74@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 07:11:05PM -0700, John Hubbard wrote:
> > So any user with 1024 processes can fragment physical memory? :/
> > 
> > Sorry, I'd like to minimize the usage of folio_maybe_dma_pinned().
> 
> I was actually thinking that we should minimize any more cases of
> fragile mapcount and refcount comparison, which then leads to
> Matthew's approach here!

I was wondering if we shouldn't make folio_maybe_dma_pinned() a little
more accurate.  eg:

        if (folio_test_large(folio))
                return atomic_read(&folio->_pincount) > 0;
	return (unsigned)(folio_ref_count(folio) - folio_mapcount(folio)) >=
			GUP_PIN_COUNTING_BIAS;
