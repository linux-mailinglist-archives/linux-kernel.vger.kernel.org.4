Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA266DD073
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjDKDmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjDKDmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:42:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C5840ED
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3yJEJA7JKrn6X2Eq1DK5sKNmhnSJ8itPJyzMlNkM9X4=; b=SrSxtSmL+ma9c2gkF9kou/noHa
        TrG+y9rAR3ZCudLsanQsWmDWwVR9A8NigxLQSKJDm/ORIPYRNNNBICcNVJlbh84pb7+DiiUru+Emm
        DCFZgcu2h78yhOuzSQFYjF7+xeW40oGcxe/3nweBVmVvRT5zDaczVCEyrzK6LV7OEq8Jg5vTa2BpN
        VTcFE5O/TlaRwtLL/CwhucpMv9yV5oOLeetSnE3CGnnIaFTJbpdZeteUpJb9lN4rhEML+ZHibZiTB
        BWq8tK5xFlCLxO1D2kRHhYO+dOpGGeSDMbA156iNqEm6WWBL8swNUlSQgHOg40n5EhW7ikK6FypsB
        XeXfIpmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pm4rh-005H4G-Tg; Tue, 11 Apr 2023 03:40:17 +0000
Date:   Tue, 11 Apr 2023 04:40:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vishal Moola <vishal.moola@gmail.com>
Cc:     Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, sidhartha.kumar@oracle.com,
        muchun.song@linux.dev, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH v5 3/6] userfaultfd: convert copy_huge_page_from_user()
 to copy_folio_from_user()
Message-ID: <ZDTWoTTtS1JcuiI6@casper.infradead.org>
References: <20230331093937.945725-1-zhangpeng362@huawei.com>
 <20230331093937.945725-4-zhangpeng362@huawei.com>
 <CAOzc2pzr7VJRdsx1ud_ceBhbu2XP7Ay72jFETtN8eOt5yR7S=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOzc2pzr7VJRdsx1ud_ceBhbu2XP7Ay72jFETtN8eOt5yR7S=Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 07:28:44PM -0700, Vishal Moola wrote:
> > -               flush_dcache_page(subpage);
> > -
> >                 cond_resched();
> >         }
> > +       flush_dcache_folio(dst_folio);
> >         return ret_val;
> >  }
> 
> Moving the flush_dcache_page() outside the loop to be
> flush_dcache_folio() changes the behavior of the function.
> 
> Initially, if it fails to copy the entire page, the function breaks out
> of the loop and returns the number of unwritten bytes without
> flushing the page from the cache. Now if it fails, it will still flush
> out the page it failed on, as well as any later pages it may not
> have gotten to yet.

I'm not sure this is worth worrying about.  Failing to copy the entire
folio is unlikely, and if we do, flushing the entire folio instead of just
a few pages in it is harmless.  Plus I have patches which significantly
optiise flush_dcache_folio() over flush_dcache_page() (for the majority
of architectures) and so I think this change is actually beneficial in
the long term.
