Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D68656D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiL0QkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiL0QkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:40:04 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65910BE21
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:40:03 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a17so12836286wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cw3nBe3CGhcfnKtGwrrNWBSIrYIsB4PimiF7AYGIkj4=;
        b=l5DU0CeFe/Dwop56+d8FNknh5cU6SnidV++R9cHeQIXvg7VzQ7ecmIE4aviNn2thWi
         OWFWAuqQDHTp2Pnl97gRhlgDA2lDWBfNo1VJX8lXp3thu20jrelYp9j176omTpVhsVWH
         zwAjMSfFdC+HP/O/ByKDpQowpHjoUu1leo26o8kRG50JQzY1fHokM0KhbZWLQ2B083q8
         F4RBN3k8obZXKe+8GHNsgascjxxU4cfZzLvnNogsPt5OuCMgvkIpaHkWNrFR9ud9ee/Y
         O6N0gvWOLfJc+57v5l5wQ3Tjal9qKa4dEKRg7RdMXuPjb9EGYDwVT72DP+dr4Cbua+mg
         E09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cw3nBe3CGhcfnKtGwrrNWBSIrYIsB4PimiF7AYGIkj4=;
        b=fUq2DyGwKTWfWbz30bJvwKAIrA9JOFLZ3c47CeJTGZW9Nc4S+MVN9rWfnAbCXC348h
         PvINn74wAR/z09H36sM/PWdZBWAh1Wkah1zY59Wi/ofjGHAG8HZyZSpRYPMn0HQTp0/v
         No5jqYAHSRjXl+aq5Qt6Ztoxm2Xs2W39wnIvVl3p7UC6KBeEcUk6vgptEeEmm8inxJF7
         2dEaa8qf60GwdIkGEHj3Amhj7+j8hd4xi7JJEKAMhdGN/ffOy3wDWPtY+S37LJTD9Qbn
         Jy5de6lPmzrWURFrGhO7ulNA5tt64uJKsxL0IFMv9+lNDKk8a67ofANx7fDYpDpU/wm0
         In8Q==
X-Gm-Message-State: AFqh2kr0tXcAYjT9CDpsjKpJe90S35/OOJFNkvKveCf+PPWFJt+Rzk5M
        0deMtSbOf1fyfmzR//AfsBuis67bP0j81dmfNLFYqA==
X-Google-Smtp-Source: AMrXdXu37Vk/sOFghLi4oCjsH9UWemvjpnq5KxtAAXVQ7A6H1wyebOwPsYEKIK8EfK2+MyuEkI1bmcmn0EzCzJh7sAY=
X-Received: by 2002:adf:8b93:0:b0:26b:361a:52f1 with SMTP id
 o19-20020adf8b93000000b0026b361a52f1mr1096779wra.655.1672159201919; Tue, 27
 Dec 2022 08:40:01 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-36-jthoughton@google.com> <Y6TQaZaB+PKObfNs@x1n>
In-Reply-To: <Y6TQaZaB+PKObfNs@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 27 Dec 2022 11:39:50 -0500
Message-ID: <CADrL8HV+v9NgJyX87Dd6XMYPqe1mUNqxYxJX520Xr2x9SktdZw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 35/47] userfaultfd: require UFFD_FEATURE_EXACT_ADDRESS
 when using HugeTLB HGM
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
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

On Thu, Dec 22, 2022 at 4:47 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Oct 21, 2022 at 04:36:51PM +0000, James Houghton wrote:
> > @@ -1990,6 +1990,17 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
> >               ~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
> >  #ifndef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> >       uffdio_api.features &= ~UFFD_FEATURE_MINOR_HUGETLBFS_HGM;
> > +#else
> > +
> > +     ret = -EINVAL;
> > +     if ((uffdio_api.features & UFFD_FEATURE_MINOR_HUGETLBFS_HGM) &&
> > +         !(uffdio_api.features & UFFD_FEATURE_EXACT_ADDRESS))
>
> This check needs to be done upon "features" or "ctx_features", rather than
> "uffdio_api.features".  The latter is the one we'll report to the user only.

Ack, thanks Peter. I'm going to drop this patch given the API change
(switching to MADV_SPLIT).

- James
