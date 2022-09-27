Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6955EB621
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 02:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiI0AOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 20:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiI0AON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 20:14:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1690CA2A90
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBj+YwAx/q4JvYRdRd0woC5Tlktvh0pAuL0y+PUPiD/SwfnrZJ1NGoaSLIWIcUQn5pS09+SyHSo7IklWOLdrs/SSzt9fHSW2K5o8z5N1/4jFATJV8SJMKQPtyOFGQVc11tWhawQGqII06SxSiuLktcF6TcJAGw4/UDPmyt19Dw0qbGDUNnJBroJDaimJl67l/fGfLtO7hu8aJ7wIf5ndkw88Jnz3w7rzJXP3t+1mKyBja8F5EsCH3zTw/83Pn0bV/CtSPFD0d7plD3rfn2T9FYr9UkURI64AGcyvV92QgSlBSWaTjaBXHRVjmmTgi9wnIx+X7QsrSzEpy6LTmHEKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSHhiHuN0hQSORGriSnuR5Olmpi1I/HhwJ9otc3KPY0=;
 b=gTqfESb3FbWzDuL6wDJxxxyKbOpMk1qsq6gc8Gha3DhakXvV9kdmvehjvEe1imM4GRGVuwpk5YI+Gd9GvEfvIJEHR07beRS7pTg4AS29i2R9tV26EUopYGCDQfYDaEe3oqwU+j1LbF9O+JPwNXnPJrlYpWpUHZ6NMnFc88XZZAoDAqUoWw5KM+g0vzZO7hzLo0C9mvfl9RqdfHA0FUK4Yarn/HL+iKZMtSPvvJexzlKcbhIPyqqNpwf7nG+ee3drZrX24tlC1aJdE5NUyJHeKGPL5+pK7a07zYR1h8vQmiB370k1N6YGGRWwt60xCZfKDQa3fCtvvAnov8U75lNmGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSHhiHuN0hQSORGriSnuR5Olmpi1I/HhwJ9otc3KPY0=;
 b=PEJShuAM/yFVyyMeLRYf5oPa8bgxWHIYo0HfnTyTo2+CFAkiENZhSg6G3ObefDPIcHKEo+DUyuAA/x6lcVYHCAMUywKU8sLRb8HZLh3v83mEKuv9X0fb6GN3iUCmn1rSAzkPz3CJujjWfG07VPya/r8QYgCfk1EYvrfIvaM2cqSthrnhbl9QLlhI5KeICvSoKpCZbmOS0e7WdXo7bri/r0GXll1w+dgZgixCxdr6aH+dCOy0NZ2+Z8D2Cdw4nRQHboKtClp/PEEkBwnyxFQ6N9sQf0EVS4vEfP1/uNZ2Z9LzW4cySA8eQ1nMUA938W1/jfqx/ynfWOTr5/ywiosLDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Tue, 27 Sep
 2022 00:14:09 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4064:6c13:72e5:a936]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4064:6c13:72e5:a936%5]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 00:14:09 +0000
References: <20220921060616.73086-1-ying.huang@intel.com>
 <20220921060616.73086-3-ying.huang@intel.com>
 <87o7v2lbn4.fsf@nvdebian.thelocal>
 <CAHbLzkpPNbggD+AaT7wFQXkKqCS2cXnq=Xv3m4WuHLMBWGTmpQ@mail.gmail.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 2/6] mm/migrate_pages: split unmap_and_move() to _unmap()
 and _move()
Date:   Tue, 27 Sep 2022 10:02:33 +1000
In-reply-to: <CAHbLzkpPNbggD+AaT7wFQXkKqCS2cXnq=Xv3m4WuHLMBWGTmpQ@mail.gmail.com>
Message-ID: <87fsgdllmb.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0010.ausprd01.prod.outlook.com
 (2603:10c6:10:1fa::19) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: e765e27b-3213-49c5-cf8d-08daa01d32df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRyKfb6JxlYwYOJYuSTQ73GIprIIoJP6TqUEBaB/U2B8RB2FfZlaVXdIPOCCkURYiSbGz/zDQ/PGMa6RRCRmWHgNCDeY15QZG7bUDSKXJRTe8BWFayuvJqZNV4H0zZf30h9ILwn9R44vVaBwG3Pqlzea6iU6G6SbDrxXDk8C7pmFGOVLXYTHna+rRc3sJo/MjyVd4rCvSliQGQvHB90XAizFLoqMH5ISFKfqMTcHmOwbENuBb0qbKfHsQ9AZz/QxHISq5XJ8G2PQ8j8cUeT/+NKT4Lffq3ECBuX4LJ2CP2/bnnRpnYe6t3EU3OAZd+6bMVP45ItmUL9oS8X3DMzFKaBkQNS8wj1xnJnQxzgIzSfjgdQkk6UdSjkV9amWQI5/AXARVhOc6fi9dEbz51UaQjf2v9cbMeGH946gt9yfIE7RPsysKLRvbZJ2vvQaSQihINTyqn6sGKA97s2VOjAFOLDyFEDAFsXGDFZPKqgyQM0Zxxrg4lX0grjuvgUAEPCFhdCOwZX8x1cx5rdZOhWBlQAQxZVjTMETaG4Tmqy2aOCdFCwiDyBBlaZf+zef0VMjDrl71/ym5u4QwARYFfGwgGwkp5EJEpA0FOaIYNqAVnmjrLfbg0cFxQd9lksHMfnN9P45Sg9WJDZuhTY0p7nslzy1+eR433ylR+Z2c/8FAjsv+upJiOQRc/oRN5qEY+VJ3aV0MhGFI8sybTB9RINTNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(186003)(83380400001)(66899012)(6486002)(53546011)(54906003)(5660300002)(6916009)(316002)(2906002)(9686003)(26005)(6512007)(6666004)(66556008)(30864003)(66476007)(38100700002)(8676002)(4326008)(66946007)(86362001)(41300700001)(478600001)(8936002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SumzRYvrT0vi5vN4MHPnyGzo7MByOvqgWUdYFjn8lXc4NznRMzbFXhrvnruM?=
 =?us-ascii?Q?HDCPllDN2P9S4geOK7B5618EeRv2PlAd5bgZUn2BMuVN49MHHAxCqbFKV8+l?=
 =?us-ascii?Q?kfDLpEw9voK/HtJ0IgKG8wHbTbpCcYFVk5i6vRsA0RvqCQGveXvq0jI6nY21?=
 =?us-ascii?Q?q9eCXrGzHsN8ezl4k8Xj6qt8q4pFh8Tlcmk7WvSRvQwJN7XEbaImtE34bvuq?=
 =?us-ascii?Q?wl5IOym/EvPOwYL3aEUaiCNcuGOnW+lXJLlGLvahX5y9mHGHaG606n2+cqQb?=
 =?us-ascii?Q?KIttlINsdXUcNVAkoP/G51HZoYjFWfico3ORBzphsDy7aqKgAFDbS6UpbJNp?=
 =?us-ascii?Q?nRp8wk1fNMeVmhblOapc9mouvyJzzAsx72A9d3C4HEY1x95R+2yd6FFPMnu2?=
 =?us-ascii?Q?xJed1lujdwsYXrnTJ7E2f0qSC4N3rNiH4+6ly6iAajYJo/DP+eGyUm3WFpjH?=
 =?us-ascii?Q?jx7KlfaOdy19m+RMGMRhfCgYpYpXktnAAQZl14h0j7CfA8g7cLn4as3GllbF?=
 =?us-ascii?Q?5fvkHaKRuorxUkiqmnkvnK0AfM5buheZWqvFFICzYbRN4Or0nKrBW7E7tAAv?=
 =?us-ascii?Q?iHq3TGBrSuBJt2Qf+NojnKydLpcjAM1ol80wGPlrB7Vy1pmwC2qjxykrFZ7X?=
 =?us-ascii?Q?cTYyssrd/7GgDBQsRS4CxZWucO2sm6YX7Q/EqAb3gy/IZ9WGdwy2CxrwlvhI?=
 =?us-ascii?Q?0JtMFHnXtPqSJLwBeAh6nB+8qXBGlCtNgfEoZDTOAmo+EpkWQa1IYObypJRz?=
 =?us-ascii?Q?tTze76Zdyl+9mMF3XoFh4N27NnPtBMc84ZpIoqxb46hkD6r1vjVSRj1dNUFj?=
 =?us-ascii?Q?cx1MbEt2mXxiQUP3StuiJw0XhTFiLMZ8SWp0LLGPVb7tr2SdsjCsfGEkfuyP?=
 =?us-ascii?Q?XWIbBNb6xDzBEltXvyjhRPoWDyUFSX0K0tBTpmKX2js2jmXURPbl/3O98pmi?=
 =?us-ascii?Q?i6o8cU5/KKlGAbjRRDSvQRYqmY4BJf4KISKcB6HwDtKHjAqqLix2/kYVSBbv?=
 =?us-ascii?Q?r0iXCaH9kXf08YvP5jbODO2JL2JGLETxfrhTgMBXgmKCdRTVohPNFE0eak1A?=
 =?us-ascii?Q?OvDlceL5uUOIBb+3DBPyvi0YFh7txmnVjD33wl0ENN8dMThf2lahm4O7u8bo?=
 =?us-ascii?Q?ras/E28AMakXS3e0TUyOvKz6Ejb3NL1CB1Wl2KaPl7gyV4GZyowwfqcagz60?=
 =?us-ascii?Q?qDLHIeqC7k15pNR+qD2voeutqdRH9DZl9qedV+C+Yfn8P8VSpHD7AR9TvnEZ?=
 =?us-ascii?Q?O8OnaksgK6GbbhaThwQq8VsS3mvFF6iogZRIPdf8LuyjKwvQZZQv3wep2NHb?=
 =?us-ascii?Q?aU74uiVDDP0JE8C6gcq1Nxz2QYg0kqhw+xgKmGw83fea0pLVC6qd1kWY436O?=
 =?us-ascii?Q?PoqtLpCvihxGXMcrrb8+jAHXkB79Q55dG9mSlabMBiGL6qjvCifjzgwy7Y3p?=
 =?us-ascii?Q?hN6QTOjT0VsSMDIzUgcQZA8RgZqSHYISrA5Pw9ZmLnC90QO4u+fCtzl2gl52?=
 =?us-ascii?Q?lbiqMuLeudj7ZvdVhTyYTbzIm9Gh6nyUXZH81S/UJjf0f91zeFo1PSqgOwpr?=
 =?us-ascii?Q?mTqfg7wm8CCpPo0lm4tH9d4eLt2UOW3FC5z0VIRX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e765e27b-3213-49c5-cf8d-08daa01d32df
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 00:14:09.7026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bniKUpR7+Ol7t3umK4mrUJ0fbjSCDcIPQrH1bMKwaUnLjl6BO7UWz28/kcN8tHHI5SzNoqiD0Eu3nedoo4HVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yang Shi <shy828301@gmail.com> writes:

> On Mon, Sep 26, 2022 at 2:37 AM Alistair Popple <apopple@nvidia.com> wrote:
>>
>>
>> Huang Ying <ying.huang@intel.com> writes:
>>
>> > This is a preparation patch to batch the page unmapping and moving
>> > for the normal pages and THP.
>> >
>> > In this patch, unmap_and_move() is split to migrate_page_unmap() and
>> > migrate_page_move().  So, we can batch _unmap() and _move() in
>> > different loops later.  To pass some information between unmap and
>> > move, the original unused newpage->mapping and newpage->private are
>> > used.
>>
>> This looks like it could cause a deadlock between two threads migrating
>> the same pages if force == true && mode != MIGRATE_ASYNC as
>> migrate_page_unmap() will call lock_page() while holding the lock on
>> other pages in the list. Therefore the two threads could deadlock if the
>> pages are in a different order.
>
> It seems unlikely to me since the page has to be isolated from lru
> before migration. The isolating from lru is atomic, so the two threads
> unlikely see the same pages on both lists.

Oh thanks! That is a good point and I agree since lru isolation is
atomic the two threads won't see the same pages. migrate_vma_setup()
does LRU isolation after locking the page which is why the potential
exists there. We could potentially switch that around but given
ZONE_DEVICE pages aren't on an lru it wouldn't help much.

> But there might be other cases which may incur deadlock, for example,
> filesystem writeback IIUC. Some filesystems may lock a bunch of pages
> then write them back in a batch. The same pages may be on the
> migration list and they are also dirty and seen by writeback. I'm not
> sure whether I miss something that could prevent such a deadlock from
> happening.

I'm not overly familiar with that area but I would assume any filesystem
code doing this would already have to deal with deadlock potential.

>>
>> > Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> > Cc: Zi Yan <ziy@nvidia.com>
>> > Cc: Yang Shi <shy828301@gmail.com>
>> > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> > Cc: Oscar Salvador <osalvador@suse.de>
>> > Cc: Matthew Wilcox <willy@infradead.org>
>> > ---
>> >  mm/migrate.c | 164 ++++++++++++++++++++++++++++++++++++++-------------
>> >  1 file changed, 122 insertions(+), 42 deletions(-)
>> >
>> > diff --git a/mm/migrate.c b/mm/migrate.c
>> > index 117134f1c6dc..4a81e0bfdbcd 100644
>> > --- a/mm/migrate.c
>> > +++ b/mm/migrate.c
>> > @@ -976,13 +976,32 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
>> >       return rc;
>> >  }
>> >
>> > -static int __unmap_and_move(struct page *page, struct page *newpage,
>> > +static void __migrate_page_record(struct page *newpage,
>> > +                               int page_was_mapped,
>> > +                               struct anon_vma *anon_vma)
>> > +{
>> > +     newpage->mapping = (struct address_space *)anon_vma;
>> > +     newpage->private = page_was_mapped;
>> > +}
>> > +
>> > +static void __migrate_page_extract(struct page *newpage,
>> > +                                int *page_was_mappedp,
>> > +                                struct anon_vma **anon_vmap)
>> > +{
>> > +     *anon_vmap = (struct anon_vma *)newpage->mapping;
>> > +     *page_was_mappedp = newpage->private;
>> > +     newpage->mapping = NULL;
>> > +     newpage->private = 0;
>> > +}
>> > +
>> > +#define MIGRATEPAGE_UNMAP            1
>> > +
>> > +static int __migrate_page_unmap(struct page *page, struct page *newpage,
>> >                               int force, enum migrate_mode mode)
>> >  {
>> >       struct folio *folio = page_folio(page);
>> > -     struct folio *dst = page_folio(newpage);
>> >       int rc = -EAGAIN;
>> > -     bool page_was_mapped = false;
>> > +     int page_was_mapped = 0;
>> >       struct anon_vma *anon_vma = NULL;
>> >       bool is_lru = !__PageMovable(page);
>> >
>> > @@ -1058,8 +1077,8 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>> >               goto out_unlock;
>> >
>> >       if (unlikely(!is_lru)) {
>> > -             rc = move_to_new_folio(dst, folio, mode);
>> > -             goto out_unlock_both;
>> > +             __migrate_page_record(newpage, page_was_mapped, anon_vma);
>> > +             return MIGRATEPAGE_UNMAP;
>> >       }
>> >
>> >       /*
>> > @@ -1085,11 +1104,41 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>> >               VM_BUG_ON_PAGE(PageAnon(page) && !PageKsm(page) && !anon_vma,
>> >                               page);
>> >               try_to_migrate(folio, 0);
>> > -             page_was_mapped = true;
>> > +             page_was_mapped = 1;
>> > +     }
>> > +
>> > +     if (!page_mapped(page)) {
>> > +             __migrate_page_record(newpage, page_was_mapped, anon_vma);
>> > +             return MIGRATEPAGE_UNMAP;
>> >       }
>> >
>> > -     if (!page_mapped(page))
>> > -             rc = move_to_new_folio(dst, folio, mode);
>> > +     if (page_was_mapped)
>> > +             remove_migration_ptes(folio, folio, false);
>> > +
>> > +out_unlock_both:
>> > +     unlock_page(newpage);
>> > +out_unlock:
>> > +     /* Drop an anon_vma reference if we took one */
>> > +     if (anon_vma)
>> > +             put_anon_vma(anon_vma);
>> > +     unlock_page(page);
>> > +out:
>> > +
>> > +     return rc;
>> > +}
>> > +
>> > +static int __migrate_page_move(struct page *page, struct page *newpage,
>> > +                            enum migrate_mode mode)
>> > +{
>> > +     struct folio *folio = page_folio(page);
>> > +     struct folio *dst = page_folio(newpage);
>> > +     int rc;
>> > +     int page_was_mapped = 0;
>> > +     struct anon_vma *anon_vma = NULL;
>> > +
>> > +     __migrate_page_extract(newpage, &page_was_mapped, &anon_vma);
>> > +
>> > +     rc = move_to_new_folio(dst, folio, mode);
>> >
>> >       /*
>> >        * When successful, push newpage to LRU immediately: so that if it
>> > @@ -1110,14 +1159,11 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>> >               remove_migration_ptes(folio,
>> >                       rc == MIGRATEPAGE_SUCCESS ? dst : folio, false);
>> >
>> > -out_unlock_both:
>> >       unlock_page(newpage);
>> > -out_unlock:
>> >       /* Drop an anon_vma reference if we took one */
>> >       if (anon_vma)
>> >               put_anon_vma(anon_vma);
>> >       unlock_page(page);
>> > -out:
>> >       /*
>> >        * If migration is successful, decrease refcount of the newpage,
>> >        * which will not free the page because new page owner increased
>> > @@ -1129,18 +1175,31 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>> >       return rc;
>> >  }
>> >
>> > -/*
>> > - * Obtain the lock on page, remove all ptes and migrate the page
>> > - * to the newly allocated page in newpage.
>> > - */
>> > -static int unmap_and_move(new_page_t get_new_page,
>> > -                                free_page_t put_new_page,
>> > -                                unsigned long private, struct page *page,
>> > -                                int force, enum migrate_mode mode,
>> > -                                enum migrate_reason reason,
>> > -                                struct list_head *ret)
>> > +static void migrate_page_done(struct page *page,
>> > +                           enum migrate_reason reason)
>> > +{
>> > +     /*
>> > +      * Compaction can migrate also non-LRU pages which are
>> > +      * not accounted to NR_ISOLATED_*. They can be recognized
>> > +      * as __PageMovable
>> > +      */
>> > +     if (likely(!__PageMovable(page)))
>> > +             mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
>> > +                                 page_is_file_lru(page), -thp_nr_pages(page));
>> > +
>> > +     if (reason != MR_MEMORY_FAILURE)
>> > +             /* We release the page in page_handle_poison. */
>> > +             put_page(page);
>> > +}
>> > +
>> > +/* Obtain the lock on page, remove all ptes. */
>> > +static int migrate_page_unmap(new_page_t get_new_page, free_page_t put_new_page,
>> > +                           unsigned long private, struct page *page,
>> > +                           struct page **newpagep, int force,
>> > +                           enum migrate_mode mode, enum migrate_reason reason,
>> > +                           struct list_head *ret)
>> >  {
>> > -     int rc = MIGRATEPAGE_SUCCESS;
>> > +     int rc = MIGRATEPAGE_UNMAP;
>> >       struct page *newpage = NULL;
>> >
>> >       if (!thp_migration_supported() && PageTransHuge(page))
>> > @@ -1151,19 +1210,48 @@ static int unmap_and_move(new_page_t get_new_page,
>> >               ClearPageActive(page);
>> >               ClearPageUnevictable(page);
>> >               /* free_pages_prepare() will clear PG_isolated. */
>> > -             goto out;
>> > +             list_del(&page->lru);
>> > +             migrate_page_done(page, reason);
>> > +             return MIGRATEPAGE_SUCCESS;
>> >       }
>> >
>> >       newpage = get_new_page(page, private);
>> >       if (!newpage)
>> >               return -ENOMEM;
>> > +     *newpagep = newpage;
>> >
>> > -     newpage->private = 0;
>> > -     rc = __unmap_and_move(page, newpage, force, mode);
>> > +     rc = __migrate_page_unmap(page, newpage, force, mode);
>> > +     if (rc == MIGRATEPAGE_UNMAP)
>> > +             return rc;
>> > +
>> > +     /*
>> > +      * A page that has not been migrated will have kept its
>> > +      * references and be restored.
>> > +      */
>> > +     /* restore the page to right list. */
>> > +     if (rc != -EAGAIN)
>> > +             list_move_tail(&page->lru, ret);
>> > +
>> > +     if (put_new_page)
>> > +             put_new_page(newpage, private);
>> > +     else
>> > +             put_page(newpage);
>> > +
>> > +     return rc;
>> > +}
>> > +
>> > +/* Migrate the page to the newly allocated page in newpage. */
>> > +static int migrate_page_move(free_page_t put_new_page, unsigned long private,
>> > +                          struct page *page, struct page *newpage,
>> > +                          enum migrate_mode mode, enum migrate_reason reason,
>> > +                          struct list_head *ret)
>> > +{
>> > +     int rc;
>> > +
>> > +     rc = __migrate_page_move(page, newpage, mode);
>> >       if (rc == MIGRATEPAGE_SUCCESS)
>> >               set_page_owner_migrate_reason(newpage, reason);
>> >
>> > -out:
>> >       if (rc != -EAGAIN) {
>> >               /*
>> >                * A page that has been migrated has all references
>> > @@ -1179,20 +1267,7 @@ static int unmap_and_move(new_page_t get_new_page,
>> >        * we want to retry.
>> >        */
>> >       if (rc == MIGRATEPAGE_SUCCESS) {
>> > -             /*
>> > -              * Compaction can migrate also non-LRU pages which are
>> > -              * not accounted to NR_ISOLATED_*. They can be recognized
>> > -              * as __PageMovable
>> > -              */
>> > -             if (likely(!__PageMovable(page)))
>> > -                     mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
>> > -                                     page_is_file_lru(page), -thp_nr_pages(page));
>> > -
>> > -             if (reason != MR_MEMORY_FAILURE)
>> > -                     /*
>> > -                      * We release the page in page_handle_poison.
>> > -                      */
>> > -                     put_page(page);
>> > +             migrate_page_done(page, reason);
>> >       } else {
>> >               if (rc != -EAGAIN)
>> >                       list_add_tail(&page->lru, ret);
>> > @@ -1405,6 +1480,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>> >       int pass = 0;
>> >       bool is_thp = false;
>> >       struct page *page;
>> > +     struct page *newpage = NULL;
>> >       struct page *page2;
>> >       int rc, nr_subpages;
>> >       LIST_HEAD(ret_pages);
>> > @@ -1493,9 +1569,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>> >                       if (PageHuge(page))
>> >                               continue;
>> >
>> > -                     rc = unmap_and_move(get_new_page, put_new_page,
>> > -                                             private, page, pass > 2, mode,
>> > +                     rc = migrate_page_unmap(get_new_page, put_new_page, private,
>> > +                                             page, &newpage, pass > 2, mode,
>> >                                               reason, &ret_pages);
>> > +                     if (rc == MIGRATEPAGE_UNMAP)
>> > +                             rc = migrate_page_move(put_new_page, private,
>> > +                                                    page, newpage, mode,
>> > +                                                    reason, &ret_pages);
>> >                       /*
>> >                        * The rules are:
>> >                        *      Success: page will be freed
