Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF14768EBF5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjBHJpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjBHJpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:45:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A54B30E4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:45:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DF45615D4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDEFC4339C;
        Wed,  8 Feb 2023 09:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675849498;
        bh=3E/iTIUJJkvc1INMX+hV7mwu+9e7TWyhmO9W4jtcTrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mklI3sjRGVRE2S0fjtQ9dVh3DGS7T6DusRIAlI0MIptSQ6T8wc46BR/RWzKMyzCHX
         bqKriBixydwP6TDfRV1UevEH+6KQiaaF7FNRWIYCLT3mYQEHHoybn3vEJgwDu9ORhz
         mkE+b83p9fDYJ7YFUkYyzaI3yv6BMqCStFpPcDtdMEjtVPO/BJzv92gqH5+fz0/ZR6
         1V5kOvDfOEWEhOOUkpxHHTePtKRnPwwIZ4dpiDntJ9fUsdHLJoveAJq6uibuo3uON/
         yUjEDN8HKJEajwxJQpiWA5RQ/70KWoqs5HiIAHBVS3THgLiSUGRISJjA5SORYQ1q/M
         AWnU2iR6CPjNg==
Date:   Wed, 8 Feb 2023 11:44:42 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Joe Perches <joe@perches.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [RFC v3 2/4] mm: move PG_slab flag to page_type
Message-ID: <Y+NvCts0JPBmAifu@kernel.org>
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
 <20221218101901.373450-3-42.hyeyoo@gmail.com>
 <15fda061-72d9-2ee9-0e9f-6f0f732a7382@suse.cz>
 <Y9dI88l2YJZfZ8ny@hyeyoo>
 <Y9dRlNhh6O99tg4E@casper.infradead.org>
 <59630801-42b4-22e8-0ef6-5a5b8636dfbd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59630801-42b4-22e8-0ef6-5a5b8636dfbd@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 05:04:01PM +0100, David Hildenbrand wrote:
> On 30.01.23 06:11, Matthew Wilcox wrote:
> > On Mon, Jan 30, 2023 at 01:34:59PM +0900, Hyeonggon Yoo wrote:
> > > > Seems like quite some changes to page_type to accomodate SLAB, which is
> > > > hopefully going away soon(TM). Could we perhaps avoid that?
> > > 
> > > If it could be done with less changes, I'll try to avoid that.
> > 
> > Let me outline the idea I had for removing PG_slab:
> > 
> > Observe that PG_reserved and PG_slab are mutually exclusive.  Also,
> 
> I recall that there are SetPageReserved() calls on pages allocated via slab.

I did a quick scan, and it seems that all allocated reserved pages come
from alloc_pages() or vmalloc().
 
BTW, looking at the current usage of SetPageReserved, it seems that some
are bogus/historical and some would justify a different page type if we are
to have 15 bits for PG_kernel.

> -- 
> Thanks,
> 
> David / dhildenb

-- 
Sincerely yours,
Mike.
