Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891B2699B78
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjBPRp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBPRpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:45:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A584C3D2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676569515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2mzxNVMuq5jEQnFVLSN30BEqatt4b1C2xfEjhCs+OpU=;
        b=VipjDgL5MOc8Yx2YLr6KwwiYL0IvN9vaUax5FtU94eiyzR5PvEjIKHkOsZoFkuk5Pas48k
        r1XYtyil1ShK2sYAVEBFOgTXxXk1bXjaMoQRMHBfCllALlTR1wWqSEB1I9DcSYQxA8ZDJw
        e9+aI4FH2e7BCzSrf3wwRjDbE8kapLQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-_BdyFXuUNbSriE5uz1rNgA-1; Thu, 16 Feb 2023 12:45:13 -0500
X-MC-Unique: _BdyFXuUNbSriE5uz1rNgA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D27138041D7;
        Thu, 16 Feb 2023 17:45:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02756492B15;
        Thu, 16 Feb 2023 17:45:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 31GHjBfP024047;
        Thu, 16 Feb 2023 12:45:11 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 31GHjBZ0024043;
        Thu, 16 Feb 2023 12:45:11 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 16 Feb 2023 12:45:11 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Yang Shi <shy828301@gmail.com>
cc:     mgorman@techsingularity.net, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, akpm@linux-foundation.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [v2 PATCH 0/5] Introduce mempool pages bulk allocator
 and use it in dm-crypt
In-Reply-To: <CAHbLzkr4RrKpR1pGZxs7JdB=R539SiNgO2+Fr7X-rVKcBh5tQQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2302161204300.18393@file01.intranet.prod.int.rdu2.redhat.com>
References: <20230214190221.1156876-1-shy828301@gmail.com> <alpine.LRH.2.21.2302150716120.5940@file01.intranet.prod.int.rdu2.redhat.com> <CAHbLzkr4RrKpR1pGZxs7JdB=R539SiNgO2+Fr7X-rVKcBh5tQQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Feb 2023, Yang Shi wrote:

> On Wed, Feb 15, 2023 at 4:23 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> >
> >
> > On Tue, 14 Feb 2023, Yang Shi wrote:
> >
> > >
> > > Changelog:
> > > RFC -> v2:
> > >   * Added callback variant for page bulk allocator and mempool bulk allocator
> > >     per Mel Gorman.
> > >   * Used the callback version in dm-crypt driver.
> > >   * Some code cleanup and refactor to reduce duplicate code.
> > >
> > > rfc: https://lore.kernel.org/linux-mm/20221005180341.1738796-1-shy828301@gmail.com/
> >
> > Hi
> >
> > This seems like unneeded complication to me. We have alloc_pages(), it can
> > allocate multiple pages efficiently, so why not use it?
> 
> The alloc_pages() allocates *contiguous* pages, but dm-crypt doesn't
> need contiguous pages at all. This may incur unnecessary compaction

It doesn't hurt that the pages are contiguous - and allocating and freeing 
a few compound pages is even faster than allocating and freeing many 
0-order pages.

> overhead to the dm-crypt layer when memory is fragmented.

The compaction overhead may be suppressed by the GFP flags (i.e. don't use 
__GFP_DIRECT_RECLAIM).

> The bulk allocator is a good fit to this usecase, which allocates 
> multiple order-0 pages.
> 
> In addition, filesystem writeback doesn't guarantee power-of-2 pages
> every time IIUC. But alloc_pages() just can allocate power-of-2 pages.

So, we can allocate more compound pages for the non-power-of-2 case - see 
the next patch that I'm sending.

> >
> > I suggest to modify crypt_alloc_buffer() to use alloc_pages() and if
> > alloc_pages() fails (either because the system is low on memory or because
> > memory is too fragmented), fall back to the existing code that does
> > mempool_alloc().
> 
> My PoC patches just did this way, but called bulk allocator. There may
> be other potential mepool users as I listed in this cover letter,
> which may get benefits from bulk allocator. So introducing a new bulk
> mempool API seems better for long run although we just have one user
> for now. And it makes other uses easier to gain the benefit by just
> calling the new API.

This mempool bulk refactoring just makes the code bigger. And it is not 
needed - dm-crypt can fall-back to non-bulk mempool allocations.

In the next email, I'm sending a patch that is noticeably smaller and that 
uses alloc_pages()/__free_pages().

Mikulas

