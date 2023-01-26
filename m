Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF3367D245
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjAZQ7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjAZQ7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:59:31 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E121527499
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:59:29 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id n7so2428878wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=neDGA3ZoiU4GEtv5HBc+8mGFjglFh5fImPAsKZ4CGNA=;
        b=Y9aKhvCdAeSa/x+9sluyhUTp4oQvpT3oy9WWedj87O3Ft+0zx8hCq0sH+J/+hsnW/n
         PpsJcEESfRYV+/b5qNWeUsplTBvA5dz5gnoadRgGvWYZjy/auuHJvPyIdbWYBZCKB5xp
         r5rxUcFwA7u0zXU1XJO851zbSyH6RrjaZq1R0pOyF6/POCMmnG8UJ56QcLz4MJY8b+EW
         PW6KfMGOaG44wSKUDn0Ce7tzkA81kRaoD5E++rtmJlkfTUvlAZMZoFiC5lvb18EM7T9r
         3YdTw01gik5GHyWtwHvcFbUU/HquYcvJwIfX3CcPJO0/a2r5V8PmU1t3Ne6agzrUcF0X
         bCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=neDGA3ZoiU4GEtv5HBc+8mGFjglFh5fImPAsKZ4CGNA=;
        b=oLZaWhvoVbYY9aUdUhu1V+MkfiUxiGh2UkZGQ98GqcE/T21NDnLL4hEZ/PfVIKXZIy
         +ypRpTvQyXbSbieyIz43S+US2YNN6PU5iN6Om8VJXgTmLaAix+RICqKK3dMM0TuivimK
         l/Xxe46pBu7ao+XkEpI4fAPbqMzFOVtGzLIYNHRy9RRRnpJtQJwXOdmj85z31YSMfFtQ
         1J9bo9JMqpub1s3FyEMS6yg+BsOw6QcYPq3f86xC6171U5wEGu/XCqgpwuoHLjSHS3FU
         sqkXtdN0bwg3+Jdb6DGEA6fH4ZiUR5oggVr5Jw1q8crHsrGxGwx5Je9fBx8iZFppIFyf
         UUgw==
X-Gm-Message-State: AO0yUKVu8p1xhBve58lMEkfHMKuF9P/7WjBsIbcZIm6TJOcsC8zw1iZu
        kIkgK2G0cl01gt8giqtXvkfQ2HGw3pZuNdkl6paz+w==
X-Google-Smtp-Source: AK7set+0Bk/K1r68hC2EVR99RRGeNZ+S3IbX8/b1rRgetk3VUJRNEcZ3nNxrMlDvYshlplWdmB2KgHCX3NBVZw8N5A0=
X-Received: by 2002:adf:a54c:0:b0:2bf:b373:149a with SMTP id
 j12-20020adfa54c000000b002bfb373149amr375162wrb.355.1674752368212; Thu, 26
 Jan 2023 08:59:28 -0800 (PST)
MIME-Version: 1.0
References: <Y8BtJzBLTpw5IR+H@x1n> <CADrL8HUi-j4ais45Xq8Jpb6a7DsWiXrKNeJfsqBRMi1Lier8xA@mail.gmail.com>
 <Y8B8mW2zSWDDwp7G@x1n> <06423461-c543-56fe-cc63-cabda6871104@redhat.com>
 <CADrL8HUdg1Fr=tLEQRkDjeTzNzzSM6EPhvDgzURxSZSBMLgjoQ@mail.gmail.com>
 <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com> <Y8gRpEonhXgqfb41@x1n>
 <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
 <Y8hITxr/BBMuO6WX@monkey> <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey> <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
In-Reply-To: <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 26 Jan 2023 08:58:51 -0800
Message-ID: <CADrL8HV92DaNm5bUwcOxsG8Lg4yLT6F13KWSbjkySPNAsgCfpA@mail.gmail.com>
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for walk_hugetlb_range
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 11:42 AM James Houghton <jthoughton@google.com> wrote:
>
> On Thu, Jan 19, 2023 at 9:32 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 01/19/23 08:57, James Houghton wrote:
> > > FWIW, what makes the most sense to me right now is to implement the
> > > THP-like scheme and mark HGM as mutually exclusive with the vmemmap
> > > optimization. We can later come up with a scheme that lets us retain
> > > compatibility. (Is that what you mean by "this can be done somewhat
> > > independently", Mike?)
> >
> > Sort of, I was only saying that getting the ref/map counting right seems
> > like a task than can be independently worked.  Using the THP-like scheme
> > is good.
>
> Ok! So if you're ok with the intermediate mapping sizes, it sounds
> like I should go ahead and implement the THP-like scheme.

It turns out that the THP-like scheme significantly slows down
MADV_COLLAPSE: decrementing the mapcounts for the 4K subpages becomes
the vast majority of the time spent in MADV_COLLAPSE when collapsing
1G mappings. It is doing 262k atomic decrements, so this makes sense.

This is only really a problem because this is done between
mmu_notifier_invalidate_range_start() and
mmu_notifier_invalidate_range_end(), so KVM won't allow vCPUs to
access any of the 1G page while we're doing this (and it can take like
~1 second for each 1G, at least on the x86 server I was testing on).

- James
