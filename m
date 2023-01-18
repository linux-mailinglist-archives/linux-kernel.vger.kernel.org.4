Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E099670F00
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjARAsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjARAsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:48:11 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2184A305FB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:35:03 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b10so2644210pjo.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMyeYMVXF7IgjfGC7N762xUCyNeQ/iY6VKDjd0bOVPo=;
        b=jelHYFT7XhuGmISkWzpel1N0dN82mQBHyhmZsZTHL8zMEqD/3hLnEiDSMkctzGjXNc
         vM/xwSxy1MluNKtsDZwsS4DScml7WZd8yGNnFTxRR00Z8fsitUGvpJIt57VRVh3z78a9
         MD0A5AsXP60Pl+ugxLaB3F7GC6dbPLPG2YUIYWW2poJicwRbsf3kbC9jS5d4N//D7vxR
         19L8T2NUHv7EmI2J+JGIBRBK9APoVfXc5fFi+ByNHuLyUoUr8oByZL0Peg1CqSEfVUuE
         nYnWrJCG9WBPTr1c0RmhQsbqLlV2RIG0/66MddJ4exC873lFVuUt9Er+vYNfH7JeQPTI
         imDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMyeYMVXF7IgjfGC7N762xUCyNeQ/iY6VKDjd0bOVPo=;
        b=VAo8nspIsF1FVhcc0ymgyWrvYcTOtFbDKkWW0262GAvs51BCnFyxQM3CFuxmpFHldF
         OwQO8d/tvfV30ZSJlnf7mLLK3rNDdxQQ1o21afYNmkN1c9olVAJr54AfK9rTSMs5HIrx
         bQhkmK1ESXGq3SOV0leZ85348aHg61DbF8oBkFr9jFzAss5mg78GPV7wlipR8By+KzHH
         Ins++/ofVorgUrmaC9FG8AwuMN55HKp+qd0ITPmb13+JFY99HTAbGerPN9tjygTD4jat
         CgSwlZlVnrEDYmwyj4MtibJi+KpwbJVpkJjijl4z7CGr8CKhABHlGdpFabyUaon+zJVd
         hCEA==
X-Gm-Message-State: AFqh2krrlXuHW862XmxItqk9ErqVkp3KuqboKC+0epIMrnuFBYjRHILr
        pDsxNnPlkRyIN3SVYlefgTo=
X-Google-Smtp-Source: AMrXdXtFFhZxSChR1BIqTlxckVoTu/p350oCSqUYDEFyzbpSuqIr1V2b4+b+/xlPZtb/CKOXpEatNA==
X-Received: by 2002:a05:6a20:1456:b0:af:9c75:6699 with SMTP id a22-20020a056a20145600b000af9c756699mr7227993pzi.1.1674002102559;
        Tue, 17 Jan 2023 16:35:02 -0800 (PST)
Received: from google.com ([2620:15c:211:201:27ce:97b5:ee13:dbfe])
        by smtp.gmail.com with ESMTPSA id y22-20020aa78f36000000b0058d92ff8a31sm5437323pfr.187.2023.01.17.16.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 16:35:02 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 17 Jan 2023 16:35:00 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 1/3] mm: return the number of pages successfully paged out
Message-ID: <Y8c+tFfwSTwlRFOk@google.com>
References: <20230117231632.2734737-1-minchan@kernel.org>
 <20230117155312.5464d01c2d639b1ac44f9330@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117155312.5464d01c2d639b1ac44f9330@linux-foundation.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 03:53:12PM -0800, Andrew Morton wrote:
> 
> I'm all hung up on the naming of everything.
> 
> > mm: return the number of pages successfully paged out
> 
> This is a vague title - MM is a big place.  Perhaps "mm/vmscan: ..."
> 
> On Tue, 17 Jan 2023 15:16:30 -0800 Minchan Kim <minchan@kernel.org> wrote:
> 
> > The reclaim_pages MADV_PAGEOUT uses needs to return the number of
> > pages paged-out successfully, not only the number of reclaimed pages
> > in the operation because those pages paged-out successfully will be
> > reclaimed easily at the memory pressure due to asynchronous writeback
> > rotation(i.e., PG_reclaim with folio_rotate_reclaimable).
> 
> So...  what does "paged out" actually mean?  "writeback to backing
> store was initiated"?  From an application's point of view it means "no
> longer in page tables needs a fault to get it back", no?

Yes, both are correct in my view since pageout is initiated after
unmapping the page from page table and think that's better wording
to be in description. Let me use the explanation in the description
at next spin. Thanks.

> 
> > This patch renames the reclaim_pages with paging_out(with hope that
> 
> "page_out" or "pageout" would be better than "paging_out".

pageout was taken from vmscan.c. Then I will use the page_out unless
some suggests better naming.

> 
> > it's clear from operation point of view) and then adds a additional
> > stat in reclaim_stat to represent the number of paged-out but kept
> > in the memory for rotation on writeback completion.
> 
> So it's the number of pages against which we have initiated writeback. 
> Why not call it "nr_writeback" or similar?

Currently, nr_writeback is used to indicate how many times shrink_folio_list
encoutered PG_writeback in the page list.

TLDR: I need to distinguish syncronous writeback and asynchronous
writeback.

Actually, I wanted to use nr_pageout but it would make double counting
from madvise_pageout PoV depending on backing storage's speed.
(For example, madvise_pageout tried 32 pages and 12 pages were swapped
out very quickly so those 12 pages were reclaimed under shrink_folio_list
context so it returns 12. But the other 20 pages were swapped out slowly
due to the device was congested so they were rotated back when the write
was done. In the case, madvise_pageout want to get 32 as successful paging
out's result rather than only 12 pages)

Maybe, nr_pageout_async?

> 
> > With that stat, madvise_pageout can know how many pages were paged-out
> > successfully as well as reclaimed. The return value will be used for
> > statistics in next patch.
> > 
> > ...
> >
> > -unsigned long reclaim_pages(struct list_head *folio_list)
> > +/*
> > + * paging_out - reclaim clean pages and write dirty pages into storage
> > + * @folio_list: pages for paging out
> > + *
> > + * paging_out() writes dirty pages to backing storage and/or reclaim
> > + * clean pages from memory. Returns the number of written/reclaimed pages.
> 
> s/reclaim/reclaims/
> 
> "and/or" it vague - just "or", I think.

Since the page list could have immediate reclaimable pages(A) when backing storage
is enough fast and just written pages(B) when the backing storage is slowed
down, even A + B if the device is congested in the middle of doing
operation, I think "and/or" is right.

> 
> "written/reclaimed" is vague.  "number of reclaimed pages plus the
> number of pages against which writeback was initiated" is precise.

Sure, let me correct it.

Thanks, Andrew.
