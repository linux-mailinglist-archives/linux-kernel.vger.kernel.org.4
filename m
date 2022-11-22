Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC82633588
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 07:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiKVGzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 01:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKVGzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 01:55:16 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0838F2018C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 22:55:15 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id fz10so8757877qtb.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 22:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mYAqDDk/54FmeYnzSCfE4ubLGzPeGRlE3OkG0R3fi1g=;
        b=0RLPsjsq8XFYFsbBP31qFJbsIjbs3BM99Hd75XBgqLbKxUqoZYlpPLWpIu4K7iAZsv
         KDQoslmgNXaijNZMlDhzaIxhg47IL8/8frC1xBQcmS2HqfZH/6IaGb43LzLTqw0U8OoH
         tlFJX/1st+DaU+CjYO3toBQqOhCyPMaYaI5dXW00F76nvY2xK4jIhi4AjA4EhPVnBIwY
         6RorVI7v7SFsbixEWrgw7ilExM8XtSYriWyNCAlCdPrvWXVNadIoKpTqi+mGhP1qGPen
         AL1uX7jTAc2Hd2OGYxYua2oCEhkSy+bPWR8kLdIrt/yhJp1pW/PX1my5Ob+oJbw2gr6x
         QWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYAqDDk/54FmeYnzSCfE4ubLGzPeGRlE3OkG0R3fi1g=;
        b=qzuWkIK5ngDd9Sbe5aLiKuy30GKY66DxWPHJrFV9RbeWtlzhirgZ67lxrTrUgFm6Zr
         o+j8hZOC8IOZJoEXbc/6+BsfRs35VIoYWs5V1J5CELc6Hdhivj2knYZHpGCvwTIQ5TIy
         20aoT/pDLeDJ3SHSV08AFRIaEKsrxZyr1qfLvmsqdbp9WPz6hyisvk6VBT7hgP8oPehS
         2W1dAhUp9Ov55QbtRFSF+2oz5oQ2PTp5ydFmSNC7YmDNd5AZm/8iW95F8Uhz2+gkBlK+
         Anqvk474dtdl9XtgInP4PlAqN5Gn+NqkB1A83GP6fNzI3agIvYIvjRwSDQyUJ4aOiCX9
         GCSA==
X-Gm-Message-State: ANoB5pmWHvOWWG9dRcgd3lPzrrriWY0ZKI22d8MDhfJsuDQOmAoX9IN3
        n5rFAwjwMGYO54SXzz2j6ecUiw==
X-Google-Smtp-Source: AA0mqf4P6pkD5sHhG+0KqzdmxYPTWy5bEJgBXaYTAAGJzSjBw9ZV52sjvx8xr6k9OKWhuzqNzcWbAw==
X-Received: by 2002:a05:622a:5a96:b0:3a6:3b3a:e8cc with SMTP id fz22-20020a05622a5a9600b003a63b3ae8ccmr11975315qtb.373.1669100114196;
        Mon, 21 Nov 2022 22:55:14 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id bl9-20020a05622a244900b0038b684a1642sm7888922qtb.32.2022.11.21.22.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 22:55:13 -0800 (PST)
Date:   Tue, 22 Nov 2022 01:55:39 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] mm,thp,rmap: rework the use of subpages_mapcount
Message-ID: <Y3xya5802BhoFin0@cmpxchg.org>
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
 <20221121165938.oid3pemsfkaeq3ws@google.com>
 <Y3vI58VtjiAkorUX@cmpxchg.org>
 <Y3xk1hX5QrCZMT4q@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3xk1hX5QrCZMT4q@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 05:57:42AM +0000, Matthew Wilcox wrote:
> On Mon, Nov 21, 2022 at 01:52:23PM -0500, Johannes Weiner wrote:
> > That leaves clearing writeback. This can't hold the page lock due to
> > the atomic context, so currently we need to take lock_page_memcg() as
> > the lock of last resort.
> > 
> > I wonder if we can have cgroup take the xalock instead: writeback
> > ending on file pages always acquires the xarray lock. Swap writeback
> > currently doesn't, but we could make it so (swap_address_space).
> > 
> > The only thing that gives me pause is the !mapping check in
> > __folio_end_writeback. File and swapcache pages usually have mappings,
> > and truncation waits for writeback to finish before axing
> > page->mapping. So AFAICS this can only happen if we call end_writeback
> > on something that isn't under writeback - in which case the test_clear
> > will fail and we don't update the stats anyway. But I want to be sure.
> > 
> > Does anybody know from the top of their heads if a page under
> > writeback could be without a mapping in some weird cornercase?
> 
> I can't think of such a corner case.  We should always wait for
> writeback to finish before removing the page from the page cache;
> the writeback bit used to be (and kind of still is) an implicit
> reference to the page, which means that we can't remove the page
> cache's reference to the page without waiting for writeback.

Great, thanks!

> > If we could ensure that the NR_WRITEBACK decs are always protected by
> > the xalock, we could grab it from mem_cgroup_move_account(), and then
> > kill lock_page_memcg() altogether.
> 
> I'm not thrilled by this idea, but I'm not going to veto it.

Ok, I'm also happy to drop this one.

Certainly, the rmap one is the lowest-hanging fruit. I have the patch
rebased against Hugh's series in mm-unstable; I'll wait for that to
settle down, and then send an updated version to Andrew.
