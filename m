Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6C86E6F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjDRWVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjDRWVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:21:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565298A58
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:21:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E819463416
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 22:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0967EC433D2;
        Tue, 18 Apr 2023 22:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681856470;
        bh=PTrG+mr+PdluSGweJxje7TrtnEwJCDyxTOe2OFhcWXc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o4yUqM6oVUNoacmu1wWtJ75bIma2UAQusUEEfSQDbnr8ycc7zG7TyurxZtbnKeUDL
         TBk0m9j3yOEq3SCIomqxKpY32xsyvhbqkrPwe5VQlKv+E3aJwxLOpEBLAV6uR+bF11
         YU8vax5sSMXE2DBHdiUybWcvepUPAxhbNcBwPx+Q=
Date:   Tue, 18 Apr 2023 15:21:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vishal Moola <vishal.moola@gmail.com>,
        Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mike.kravetz@oracle.com,
        sidhartha.kumar@oracle.com, muchun.song@linux.dev,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH v5 3/6] userfaultfd: convert copy_huge_page_from_user()
 to copy_folio_from_user()
Message-Id: <20230418152109.32a90ebecc905ae60e2d072f@linux-foundation.org>
In-Reply-To: <ZDTWoTTtS1JcuiI6@casper.infradead.org>
References: <20230331093937.945725-1-zhangpeng362@huawei.com>
        <20230331093937.945725-4-zhangpeng362@huawei.com>
        <CAOzc2pzr7VJRdsx1ud_ceBhbu2XP7Ay72jFETtN8eOt5yR7S=Q@mail.gmail.com>
        <ZDTWoTTtS1JcuiI6@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 04:40:17 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Thu, Apr 06, 2023 at 07:28:44PM -0700, Vishal Moola wrote:
> > > -               flush_dcache_page(subpage);
> > > -
> > >                 cond_resched();
> > >         }
> > > +       flush_dcache_folio(dst_folio);
> > >         return ret_val;
> > >  }
> > 
> > Moving the flush_dcache_page() outside the loop to be
> > flush_dcache_folio() changes the behavior of the function.
> > 
> > Initially, if it fails to copy the entire page, the function breaks out
> > of the loop and returns the number of unwritten bytes without
> > flushing the page from the cache. Now if it fails, it will still flush
> > out the page it failed on, as well as any later pages it may not
> > have gotten to yet.
> 
> I'm not sure this is worth worrying about.  Failing to copy the entire
> folio is unlikely, and if we do, flushing the entire folio instead of just
> a few pages in it is harmless.  Plus I have patches which significantly
> optiise flush_dcache_folio() over flush_dcache_page() (for the majority
> of architectures) and so I think this change is actually beneficial in
> the long term.

Thanks, I'll send the series in for the next merge window as-is.  If
others remain unhappy with the flushing issue, please propose something
during the next -rc cycle.

