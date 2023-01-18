Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BE7672651
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjARSIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjARSIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:08:01 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14344ED0C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:07:20 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 36so25103661pgp.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dsa2aocPCtB2N2VNUCoUfZW6dXH2V8Mewh6jLvRwtQc=;
        b=FCuOHZyepTHi7gBVSWYK4ZAG1R1GyXAjt45k7HU/e+J2/TOXkGaIlcMTkWPzL6AQJs
         BMssM/TlCWrrhHpZpPQtl0ThiH8QR3mf7xxrGpZIaSbL8MzCWGNyeOANjOjh3FND7D2T
         mYII1xTpS2gD+55lCre1KufwCRCWo3mtDL5WqrBcukGz2DEPXKCjhklhUhka8yXbngDE
         /EsO5bjZJseBPvvvXS6neG6OZfmOCFLCzjiCanYZ+eK6b90XJNjzWSOi3Kzbhu67t9qU
         ik+hjkBlFex34Vun+CpMe/18dSa2WxgK6YnUM7y1ZyMlqX8PPLOG+m1+vsC2amX+t2Yw
         cmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dsa2aocPCtB2N2VNUCoUfZW6dXH2V8Mewh6jLvRwtQc=;
        b=XtPFTlZWUPiOLv0cnRoOfnhXQNNK8Tez0AXWufOG9QQaoY5G943Poq6vU5+/POZ0Q3
         YZh3+vYMeCcEJaM55gbF+sWPWAqxMTo0i/7cLTQkj38A5KACmyIjx9zd418V49C3P7zC
         e3EmRPJT7aoazHFjhxhIov47l53L4N9OFr6YQePuXX8KqDuyZqacQvJrpmH91TY+Ggwh
         a7+sbgpzTC8bmgnlRRD1yHY3m2bcuOYxZbXZrQWt+a1lMlGce9DATbjffbpI7X31ndoG
         huWbT8LJSBwTvVSTbW6/mbeBFf43wngU/14yBUmYSbrlzjSrr3i3JGLt4jUEo0kly3rr
         U4kQ==
X-Gm-Message-State: AFqh2kq3AKpmsUOxsXaLlgIX1s9yp3EE/xkCf4iIrqCrf1Xw9/I254tG
        wpyOjkyUSGwqJlH54ramWuI=
X-Google-Smtp-Source: AMrXdXvcKEV7N0L+zm7gPu+9r/5SzUMhU9m4gSPiasQJhwN77+MF+E6N0Sq3xmvXdPd7bmPRYrJNRA==
X-Received: by 2002:a62:6302:0:b0:582:848c:6281 with SMTP id x2-20020a626302000000b00582848c6281mr8332366pfb.2.1674065240149;
        Wed, 18 Jan 2023 10:07:20 -0800 (PST)
Received: from google.com ([2620:15c:211:201:68ba:bd93:858:15d5])
        by smtp.gmail.com with ESMTPSA id v15-20020aa799cf000000b0056bc5ad4862sm14068907pfi.28.2023.01.18.10.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 10:07:19 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 18 Jan 2023 10:07:17 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 1/3] mm: return the number of pages successfully paged out
Message-ID: <Y8g1VWkdSwt5SUVo@google.com>
References: <20230117231632.2734737-1-minchan@kernel.org>
 <Y8e3lHsYoWjFWbRU@dhcp22.suse.cz>
 <Y8gn0KQDWC/5CZ/w@google.com>
 <Y8gt5Gb7DPaEI2uN@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8gt5Gb7DPaEI2uN@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 06:35:32PM +0100, Michal Hocko wrote:
> On Wed 18-01-23 09:09:36, Minchan Kim wrote:
> > On Wed, Jan 18, 2023 at 10:10:44AM +0100, Michal Hocko wrote:
> > > On Tue 17-01-23 15:16:30, Minchan Kim wrote:
> > > > The reclaim_pages MADV_PAGEOUT uses needs to return the number of
> > > > pages paged-out successfully, not only the number of reclaimed pages
> > > > in the operation because those pages paged-out successfully will be
> > > > reclaimed easily at the memory pressure due to asynchronous writeback
> > > > rotation(i.e., PG_reclaim with folio_rotate_reclaimable).
> > > > 
> > > > This patch renames the reclaim_pages with paging_out(with hope that
> > > > it's clear from operation point of view) and then adds a additional
> > > > stat in reclaim_stat to represent the number of paged-out but kept
> > > > in the memory for rotation on writeback completion.
> > > > 
> > > > With that stat, madvise_pageout can know how many pages were paged-out
> > > > successfully as well as reclaimed. The return value will be used for
> > > > statistics in next patch.
> > > 
> > > I really fail to see the reson for the rename and paging_out doesn't
> > > even make much sense as a name TBH.
> > 
> > Currently, what we are doing to reclaim memory is
> > 
> > reclaim_folio_list
> >     shrink_folio_list
> >         if (folio_mapped(folio))
> >             try_to_unmap(folio)
> > 
> >         if (folio_test_dirty(folio))
> >             pageout
> > 
> > Based on the structure, pageout is just one of way to reclaim memory.
> > 
> > With MADV_PAGEOUT, what user want to know how many pages
> > were paged out as they requested(from userspace PoV, how many times
> > pages fault happens in future accesses), not the number of reclaimed
> > pages shrink_folio_list returns currently.
> > 
> > In the sense, I wanted to distinguish between reclaim and pageout.
> 
> But MADV_PAGEOUT is documented to trigger memory reclaim in general
> not a pageout. Let me quote from the man page
> : Reclaim a given range of pages.  This is done to free up memory occupied
> : by these pages.

IMO, we need to change the documentation something like this.

 : Try to reclaim a given range of pages. The reclaim carries on the
   unmap pages from address space and then write them out to backing
   storage. It could help to free up memory occupied by these pages
   or improve memory reclaim efficiency.

> 
> Sure anonymous pages can be paged out to the swap storage but with the
> upcomming multi-tiering it can be also "paged out" to a lower tier. All
> that leads to freeing up memory that is currently mapped by that address
> range.

I am not familiar with multi-tiering. However, thing is the operation
of pageout is synchronous or not. If it's synchronous(IOW, when the
pageout returns, the page was really written to the storage), yes,
it can reclaim memory. If the backing storage is asynchrnous device
(which is *major* these days), we cannot reclaim the memory but just
wrote the page to the storage with hope it could help reclaim speed
at next iteration of reclaim.

> 
> Anyway, what do you actually meen by distinguishing between reclaim and
> pageout. Aren't those just two names for the same thing?

reclaim is realy memory freeing but pageout is just one of the way
to achieve the memory freeing, which is not guaranteed depending on
backing storage's speed.
