Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42566B2728
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjCIOkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjCIOkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:40:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FCB5FEB2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:39:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4BC2B81F66
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED21C433EF;
        Thu,  9 Mar 2023 14:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678372791;
        bh=ntChJKalWPnMjCls5ag5q3azt2PJ3UUhYpF2y+sjJR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ke6SxSZYDQMs+UK3Y8cXPvnRSlOpbkP2B2Y8c5zGh83FZEuy56dl0XCQIEzlm5KCE
         8lFbv01f8kDxxHRtvh1DS/tGfdHJF7ADwZfbXSJVBjV0xFY/Ia0TW1HBnqmUY9ujLZ
         URH35oxzWT84LvuOOam7Y8MKpGauqioQPV5Xu4afi4cuMZ3dFMgr6NgK9Int+8bG/v
         CiJSHucSMYeUq7n4Nff5MPxjNDUHZKzu56v1yo/ww9B6wpZZ0yl0FDp7xr4D/rCvEQ
         udbTwUAOaeQwLMc+J0WVtkCFA/o7BpXWLxXoQWoZnBkMVwx296374Ja+sYL/jMy0Bl
         pjWeqmHp1r8vw==
Date:   Thu, 9 Mar 2023 16:39:36 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "song@kernel.org" <song@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Message-ID: <ZAnvqKtZdaD7FsdT@kernel.org>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <47b5156d814b88ec894f38d245d0a09061112f85.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47b5156d814b88ec894f38d245d0a09061112f85.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 01:56:37AM +0000, Edgecombe, Rick P wrote:
> On Wed, 2023-03-08 at 11:41 +0200, Mike Rapoport wrote:
> > +
> > +static inline void __free_one_page(struct page *page, unsigned int
> > order,
> > +                                  bool cache_refill)
> > +{
> > +       unsigned long pfn = page_to_pfn(page);
> > +       unsigned long buddy_pfn;
> > +       unsigned long combined_pfn;
> > +       struct page *buddy;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&free_area->lock, flags);
> > +
> > +       if (cache_refill) {
> > +               set_pageblock_unmapped(page);
> > +               free_area[order].nr_cached++;
> > +       }
> > +
> > +       while (order < MAX_ORDER - 1) {
> > +               buddy = find_unmapped_buddy_page_pfn(page, pfn,
> > order,
> > +                                                    &buddy_pfn);
> > +               if (!buddy)
> > +                       break;
> > +
> > +               del_page_from_free_list(buddy, order);
> > +               combined_pfn = buddy_pfn & pfn;
> > +               page = page + (combined_pfn - pfn);
> > +               pfn = combined_pfn;
> > +               order++;
> > +       }
> > +
> > +       set_unmapped_order(page, order);
> > +       add_to_free_list(page, order);
> > +       spin_unlock_irqrestore(&free_area->lock, flags);
> > +}
> > +
> 
> The page has to be zeroed before it goes back on the list, right? I
> didn't see it.

You are right, I missed it.

-- 
Sincerely yours,
Mike.
