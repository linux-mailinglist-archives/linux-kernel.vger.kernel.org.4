Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C28672B44
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjARW1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjARW11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:27:27 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B1145F50
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:27:26 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r18so49279pgr.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XzT6tcMoPuV/QggwB0QXKgN3cl46TMzc6H/ouwo3mVg=;
        b=bbAeMSmeP6JoA+5DoswtzjHoQsPmQFHgSdQRPy5jeXvljrxh1I/SjqKLIutvxN5VyK
         h6NlgHW8FlhKnhqdEfJ+L5388aWlzxFGFOp/JB1HgqjR/Hvs1q7OLlD6RBInmQv5mrX4
         4aaserrSq/oKdiOmHWk3b4gHc344LCO0ISEH3oiu9uj33wXsqDsBhVab8JwataP0ihw0
         w9d9Bz8YQaci2wJf09Hqj6Xd2jTjJ6+XQupv+st3yCHYfbddBJ7wN82INtpkXoC3RYRI
         b2bhBxY192hy9CK9jCZboJI+OVa04CjpucMQAfrnOhiPSShhkabwtY58mmLAk8oFYGIh
         hZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzT6tcMoPuV/QggwB0QXKgN3cl46TMzc6H/ouwo3mVg=;
        b=aBPJCrenBD6wWVmaLqhKrRJnKBEXrUtaKx2jgG0IeCVBLwhD1P8jFPSLslrvKz75D7
         S87+4oKjDhEhmMttH/pZfEW7IFSX4kIwDf5nktjoaIUMSUfOpUjC1zcyEZzkonXH/M9a
         OGIpHuwr0ryBEDsyDiAkmFTqUeKH2iPKSfxopf+Qus9TGleRHs7vG0OiWXEwKtJg2hBn
         gWiNoMCBc3wpmGv21cbFbpQ5WuAHJJJjegjuP7BK7oKU6+St+fVMTFbr/3/YW0orUa9r
         KNFAzesJ9jmsgZkeJEnxAhErajprQIShSmiSnAFdt6cjXnAmp+N6ulDGg+3ShOtBf7sK
         GPHg==
X-Gm-Message-State: AFqh2krCF9LsggyJXIzpEpGi59hpN3PdrKJsKXTeNmfn1kiR30whjYvJ
        wP8JRdG+qVi6YLoTrOv6vrpPYIN91o4=
X-Google-Smtp-Source: AMrXdXs4EWU9F1AHYysKSRmgwyi0ECCBveuxtNBqw2Na1oDUMvm3NQrjdrqAaD/pwHyLKT880oQcSw==
X-Received: by 2002:a62:1d12:0:b0:56c:232e:395e with SMTP id d18-20020a621d12000000b0056c232e395emr9765646pfd.15.1674080845926;
        Wed, 18 Jan 2023 14:27:25 -0800 (PST)
Received: from google.com ([2620:15c:211:201:68ba:bd93:858:15d5])
        by smtp.gmail.com with ESMTPSA id s29-20020aa78bdd000000b0058d9e7bed75sm6780305pfd.60.2023.01.18.14.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 14:27:25 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 18 Jan 2023 14:27:23 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 1/3] mm: return the number of pages successfully paged out
Message-ID: <Y8hyS3yVnxXTsFIz@google.com>
References: <20230117231632.2734737-1-minchan@kernel.org>
 <Y8e3lHsYoWjFWbRU@dhcp22.suse.cz>
 <Y8gn0KQDWC/5CZ/w@google.com>
 <Y8gt5Gb7DPaEI2uN@dhcp22.suse.cz>
 <Y8g1VWkdSwt5SUVo@google.com>
 <Y8hjNm+kB8WquUH6@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8hjNm+kB8WquUH6@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:23:02PM +0100, Michal Hocko wrote:
> On Wed 18-01-23 10:07:17, Minchan Kim wrote:
> > On Wed, Jan 18, 2023 at 06:35:32PM +0100, Michal Hocko wrote:
> > > On Wed 18-01-23 09:09:36, Minchan Kim wrote:
> > > > On Wed, Jan 18, 2023 at 10:10:44AM +0100, Michal Hocko wrote:
> > > > > On Tue 17-01-23 15:16:30, Minchan Kim wrote:
> > > > > > The reclaim_pages MADV_PAGEOUT uses needs to return the number of
> > > > > > pages paged-out successfully, not only the number of reclaimed pages
> > > > > > in the operation because those pages paged-out successfully will be
> > > > > > reclaimed easily at the memory pressure due to asynchronous writeback
> > > > > > rotation(i.e., PG_reclaim with folio_rotate_reclaimable).
> > > > > > 
> > > > > > This patch renames the reclaim_pages with paging_out(with hope that
> > > > > > it's clear from operation point of view) and then adds a additional
> > > > > > stat in reclaim_stat to represent the number of paged-out but kept
> > > > > > in the memory for rotation on writeback completion.
> > > > > > 
> > > > > > With that stat, madvise_pageout can know how many pages were paged-out
> > > > > > successfully as well as reclaimed. The return value will be used for
> > > > > > statistics in next patch.
> > > > > 
> > > > > I really fail to see the reson for the rename and paging_out doesn't
> > > > > even make much sense as a name TBH.
> > > > 
> > > > Currently, what we are doing to reclaim memory is
> > > > 
> > > > reclaim_folio_list
> > > >     shrink_folio_list
> > > >         if (folio_mapped(folio))
> > > >             try_to_unmap(folio)
> > > > 
> > > >         if (folio_test_dirty(folio))
> > > >             pageout
> > > > 
> > > > Based on the structure, pageout is just one of way to reclaim memory.
> > > > 
> > > > With MADV_PAGEOUT, what user want to know how many pages
> > > > were paged out as they requested(from userspace PoV, how many times
> > > > pages fault happens in future accesses), not the number of reclaimed
> > > > pages shrink_folio_list returns currently.
> > > > 
> > > > In the sense, I wanted to distinguish between reclaim and pageout.
> > > 
> > > But MADV_PAGEOUT is documented to trigger memory reclaim in general
> > > not a pageout. Let me quote from the man page
> > > : Reclaim a given range of pages.  This is done to free up memory occupied
> > > : by these pages.
> > 
> > IMO, we need to change the documentation something like this.
> > 
> >  : Try to reclaim a given range of pages. The reclaim carries on the
> >    unmap pages from address space and then write them out to backing
> >    storage. It could help to free up memory occupied by these pages
> >    or improve memory reclaim efficiency.
> 
> But this is not what the implementation does nor should it be specific
> about what reclaim actual can do. The specific implementation of the
> reclaim is an implementation detail.
>  
> > > Sure anonymous pages can be paged out to the swap storage but with the
> > > upcomming multi-tiering it can be also "paged out" to a lower tier. All
> > > that leads to freeing up memory that is currently mapped by that address
> > > range.
> > 
> > I am not familiar with multi-tiering. However, thing is the operation
> > of pageout is synchronous or not. If it's synchronous(IOW, when the
> > pageout returns, the page was really written to the storage), yes,
> > it can reclaim memory. If the backing storage is asynchrnous device
> > (which is *major* these days), we cannot reclaim the memory but just
> > wrote the page to the storage with hope it could help reclaim speed
> > at next iteration of reclaim.
> 
> I am sorry but I do not follow. Synchronicity of the reclaim should be
> completely irrelevant. Even swapout (pageout from your POV AFAIU) can be
> async or sync.
>  
> > > Anyway, what do you actually meen by distinguishing between reclaim and
> > > pageout. Aren't those just two names for the same thing?
> > 
> > reclaim is realy memory freeing but pageout is just one of the way
> > to achieve the memory freeing, which is not guaranteed depending on
> > backing storage's speed.
> 
> Try to think about it some more. Do you really want the MADV_PAGEOUT to
> be so specific about how the memory reclaim is achieved? How do you
> reflect new ways of reclaiming memory - e.g. memory demotion when the
> primary memory gets freed by migrating the content to a slower type of
> memory yet not write it out to ultra slow swap storage (which is just
> yet another tier that cannot be accessed directly without an explicit
> IO)?

I understand your concern now and believe better implementation would
account the number of virtual address scanning and the number of page
*unmapped from page table* so we don't need to worry what types of
paging out happens(e.g., write it to slower storage or demote it to
lower tier. In the end, userspace will see the paging in, anyway.)

"Unmapped the page from page table and demotes the page to secondary
 device. User would see page fault when the next access happen"

If you agree it, yeah, I don't need to change anything in vmscan.c.
Instead, I could do everything in madvise.c

Let me know if you have other concern or suggestion.

Thanks, Michal.
