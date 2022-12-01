Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C098A63FB00
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiLAWzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiLAWzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:55:40 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FFABE4E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:55:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCZ8gWilM1ZKvBGoYH/5fHU2ahjsjJi2QtH+Uv0cHhAuxuLQorTnmyPkg6UtBLlbsa4BS/LGHcrPf4LD6G3VTkmytzG5S1tKVg/2CeprjYC8ikrGzFpbXt3PNBwZFe09ZAVTTeLietg1GIKiFbBm3YQdEc2GKxNLKHmrqOtIjEJ2nOpyG9+fH0YviETMOu/x21AzjolyLfH5CAiwSqro6DYL1Yint6NTUdp3QMH1KEnOwgLmQtxSmYtzX0vu+V/5tNTpkz44Av8goc9N3ILUC3l9CHpTzfq16GSvro0oOkjdpeWCZEm/iIG9QMn3t4TXIuNk3BnEwodOF8Ar/oOLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gA4Uvotr20jbb7pFcSdOKxsCdRYAqJKkS8gwGQpgMqk=;
 b=TarFvOXtAwtS7wAAyLG8uDZYANWoar+EWdehJbpqKtO4bRSJZSa3LTdB+V84xbuSQzFPDWdp1IMXoOTWWi7vC9YKaTcbqZBAJMfhZBQSlQvv1TZh+/nBec65NrJ5HCUrKC7I6d9cLo5nr5W5hfVzL2+hkLri9WwY3s039Fhaqv4J9WP3ODIUmS6CnuUOCpu6bl5mjxpML90Uh7ZmGosmLXdQ0SfzpoUBcEnqbsRB/7XZrtSefRaTMfJ3xxqveWzP93pjQ0rygYEzGl2fEb1lr6oegEGjEgzXaTBSr29g2pTSxeTCANWubTy7WF9eqa39nQPtQZCKV1hb+MAqH+lrkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gA4Uvotr20jbb7pFcSdOKxsCdRYAqJKkS8gwGQpgMqk=;
 b=sV0It6QeKqCTDorpa/OIlBwbG1V3GFJXRgRs5Bk3Ip5/WY+GKywEJMt1e4PPquRKoQq2P09+d2w/NNnHZRO7eZz3inbMnpd/MITEOEtzRNH+pDc5NbHM8SXcUcKpnXmLuUdvTCp04hYGzAY0gJ1WiPrhBukLhE9GHlAcSl153oksY0zIMwcNzYm7F/taFVZrdiq4ceszbp7e+zkT8IxmPOoM+/uTdj63K54mI/pDS1Y2lRzdeciMJZUuvJKiOMKTwNTfKm5CVTh0TuWrusCsHXN8Mo08DkRW8Q1gI8hOsbrY53P5Oa2JaxFdpKQX0Nis8V8fKo7u6UecYG7UwXuneQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM4PR12MB5892.namprd12.prod.outlook.com (2603:10b6:8:68::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Thu, 1 Dec 2022 22:55:37 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8%3]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 22:55:37 +0000
References: <20221123005752.161003-1-gshan@redhat.com>
 <e8a64b11-98f9-b571-dce9-a60df98e3e5@google.com>
 <c61612f7-b861-39cf-3e73-dbe4d134eec0@redhat.com>
 <871qptrvsw.fsf@nvidia.com> <Y37mC1+LQscJaOk4@casper.infradead.org>
 <51ffd399-7fa3-b2f2-b6e5-61a8b609e350@redhat.com>
 <87o7svreq0.fsf@nvidia.com>
 <2541344f-61d8-96d1-10e9-ba7e1743a299@redhat.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, Gavin Shan <gshan@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com, riel@surriel.com
Subject: Re: [PATCH] mm: migrate: Fix THP's mapcount on isolation
Date:   Fri, 02 Dec 2022 09:35:42 +1100
In-reply-to: <2541344f-61d8-96d1-10e9-ba7e1743a299@redhat.com>
Message-ID: <87zgc6buoq.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0190.namprd05.prod.outlook.com
 (2603:10b6:a03:330::15) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DM4PR12MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: e87887d8-02a9-44ef-6021-08dad3ef292e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7sb5FhtjmTHTi6Tg03ttOrlAN+MSWr9FmARuzS2Osg79yLHOibvhf4m2CTdJEUWAVk45HVtO9BdV2l319Byr3SENk4B00ID4M8d7b9u5fP9w71KJX+bf8ZtJemvqtaEgkUXlrQan0Xe9nKm6pMEof9Vlj+6p6TSI951hiXM9DyzPpTtWtatPH126fQ2bmFvlPI7suQmmbq8WCsmjG+rG6kagjQcGTdH32QABPs3IbYiPQtwGK3G5+wUjTKFC01ew4gSRjiOfxwliqHYn44frpepzC7EvHejGPvyaSUPSmFpcletq4Ly+OFjP4/7T6kzx5YXvj9uSZ6jMB7jUxdgsQeYHQdVuEdr16uOV5alVdtoXIl6cNnJq38XK4BbdvL3LSVcq1lvT+i5p00jDqunbhAZo4Pk6+eOfQFwP3+PR/qciYi01has2T0jnjum9X10WciljkavBk1v2VGPgn5OzkGFE6Or28I8mr7M8QAwwRr2cXAK6cYl9f75IlOhY/3FhVBfQ7bzxRmHAcwzpajmLO1iKEhg4KWMILD29lqvpDbiDMbaJwqa+V4lsBkCJGShYwJ2mmQxokkddMQ0k0+5cHwRQ8+YMXDKtqcuUfUBeXZn37tu4x2bhJNJFEyWlP+0iBVGgv9S+5GqwGZW90Fqong==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199015)(6512007)(86362001)(2906002)(26005)(6506007)(36756003)(186003)(6666004)(2616005)(38100700002)(83380400001)(4326008)(66946007)(66476007)(7416002)(8936002)(66556008)(6486002)(41300700001)(8676002)(5660300002)(478600001)(316002)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hGmH/Iz17vJv1DOCOZw4U/c+uF/tarFV6atC+MFoqib0iL0Eilnitp4Oh5NV?=
 =?us-ascii?Q?9h/5TarXHAXHI4p6nlFxPslXV64q9+JUTTyMfBwwKMet3iJFzIqNYq/Ib49Z?=
 =?us-ascii?Q?CBO4WcxR3tM5B1CSua5+6dz6kaSDSLv85ZVak32Cx52l9dSqRC8/Xx9eyS8i?=
 =?us-ascii?Q?Zv8RHmyt2KCDOGh8WDx7jAD2EqZ51FutJfXOKwbPiPXapCAWBgNhlXkKr7U3?=
 =?us-ascii?Q?bWWs0jh3wq5orIiDOithfipKNwi0T2KGHziG65PNWmlbqEOD6WcWeXxk98KG?=
 =?us-ascii?Q?S0j5tr5JWELkyKzE42Y5X50nbMOSefQ0eLeASdEurthqyWSfTlV2Gf5V/yG8?=
 =?us-ascii?Q?JS2cHZcRv7vrAxemUyRToHFYH7f0/1yPcw01u5oepYzw0JNVcdDDnj8sjZ69?=
 =?us-ascii?Q?OsIMe8FpZmYhkXPfht+fE3E9v0cjLeI+cGAjORvGuM1YcwPhFMk7qZPHsw9z?=
 =?us-ascii?Q?bDac3GQpAF1T3ztQsnUCPk54bsxhYxZUIzUHwHvPLzoNKEfSHrOE+3OMayk6?=
 =?us-ascii?Q?/YE/oo2tK3Q8Pf0hoqrK0astSyPa98ByNFVLNMK2WBIPV9Te4Zx5f6r5rn06?=
 =?us-ascii?Q?2qnImPXxbdHedcyMiAZ86WhV/ig32XA36WinSIZrROMpidm3/e22HqL5am78?=
 =?us-ascii?Q?AqreywesUfstAxPALibFqmWRgZNUPkbCL3qUkxmSQC51d90EMPGa4OIro4II?=
 =?us-ascii?Q?sWd1EGmCYyzrC7GWJ0Ru4DL6LvhOm1uODIIGgJEz9JuCD+/CS3T74C3/KU9s?=
 =?us-ascii?Q?WT0nPWJnbu5Tibfy52dIexB0ICKqXo5EJhxdJYO4p56RR26Ba3KrdjnDa5we?=
 =?us-ascii?Q?B7Zca223hoWtWH0McAqsRYJoCcHLevcuuLdUX2xmGSxPtr84q24gVwUZPJxw?=
 =?us-ascii?Q?Pe9W72DBwdShDjbHEZkAzXY4eOXg3EVBS17Oid54CqtibUPddl8ERUN8c2Ce?=
 =?us-ascii?Q?LJFMuf2HTx0IiZIjrH4kZBCTshOoOgNh4Ws2GJvLERLZtNCSMQTaTNFbWwBH?=
 =?us-ascii?Q?gn2H70CFrZ7nDrHe/X/2Q2uBoGs61VZDWFmKbF1Cq3O4QMiDfKUIhUEQ0w7s?=
 =?us-ascii?Q?0etjrlEi3eleKIjmxlkKrYShi0VTXBQZ4b7EvblXTcxwVIUnho2aPxjSycbM?=
 =?us-ascii?Q?ApVkLBIcdBGP7UIXuRUXDQ9j6IWjIdTGNLg5MyACf8fsw4BmvNvKCMedbvEP?=
 =?us-ascii?Q?wkr8LFFHWTpwTaunSDdAwKCcgeRD88y+jGFbC9gwEnhMER4ZdAhB4cGjkwnl?=
 =?us-ascii?Q?waUS9n1dcT+7E+hu3pOJHU98u5dMyX5cYMoRc48YL0DNyLEe+DuhjP54Q7Ty?=
 =?us-ascii?Q?UzuT0Hmuycgi3kMGlg9ZyOh0xX9lgqhfdA9njBo0UZvb9YJ6YwTC0N54bhOd?=
 =?us-ascii?Q?S/JbdmTC9h01lb3C5ZTR8KQDPzjOXNOsvba2WMfhd2zfUQEQBVJ10fwFbdc7?=
 =?us-ascii?Q?6XWO8126nY5mPi8aPIRGZyUHZ5DZ1AKxJRIUMVQECuH19Z2cxVXkeYYQJjJ5?=
 =?us-ascii?Q?B+rq5lWmLgyzqeMUDEOJM8yPMMdczlV1CIQ0YON/1AcrhF6D2WIKhqaw0PVG?=
 =?us-ascii?Q?MH0o8vDwRLFxA/FULaCfOUZmAOyNnjO/54Rh4Wji?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87887d8-02a9-44ef-6021-08dad3ef292e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 22:55:37.0552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ELz4ZNaUMmw8BZ2mwhPCYam3aojNfWOzzf8InknIGOwje3VSp5TUKtJQV2a0RcEAnr9w8o273PqA9nL7Qonfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5892
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

>>>>> I think you're right. Without a page reference I don't think it is even
>>>>> safe to look at struct page, at least not without synchronisation
>>>>> against memory hot unplug which could remove the struct page. From a
>>>>> quick glance I didn't see anything here that obviously did that though.
>>>> Memory hotplug is the offending party here.  It has to make sure
>>>> that
>>>> everything else is definitely quiescent before removing the struct pages.
>>>> Otherwise you can't even try_get a refcount.
>> Sure, I might be missing something but how can memory hotplug
>> possibly
>> synchronise against some process (eg. try_to_compact_pages) doing
>> try_get(pfn_to_page(random_pfn)) without that process either informing
>> memory hotplug that it needs pages to remain valid long enough to get a
>> reference or detecting that memory hotplug is in the process of
>> offlining pages?
>
> It currently doesn't, and it's been mostly a known theoretical problem
> so far. We've been ignoring these kind of problems because they are
> not easy to sort out and so far never popped up in practice.
>
> First, the correct approach is using pfn_to_online_page() instead of
> pfn_to_page() when in doubt whether the page might already be
> offline. While we're using pfn_to_online_page() already in quite some
> PFN walkers, changes are good that we're still missing some.
>
> Second, essentially anybody (PFN walker) doing a pfn_to_online_page()
> is prone to races with memory offlining. I've discussed this in the
> past with Michal and Dan and one idea was to use RCU to synchronize
> PFN walkers and pfn_to_online_page(), essentially synchronizing
> clearing of the SECTION_IS_ONLINE flag.
>
> Nobody worked on that so far because we've never had actual BUG
> reports. These kind of races are rare, but they are theoretically
> possible.

Thanks for providing some background context here. I have been digging
into these details a bit because GPU drivers using device-private memory
tend to excersise memory hot unplug paths more frequently than what I
suspect is normally the case. I haven't actually seen any real BUG
reports caused by this though, and it's likely the places where they're
likely would involve device-private pages at the moment anyway. So agree
such races are rare.

[...]

>> try_to_compact_pages() -> compact_zone_order() -> compact_zone() ->
>> isolate_migratepages() -> isolate_migratepages_block() ->
>> PageHuge(pfn_to_page(pfn))
>> Again I couldn't see anything in that path that would hold the page
>> stable long enough to safely perform the pfn_to_page() and get a
>> reference. And after a bit of fiddling I was able to trigger the below
>> oops running the compaction_test selftest whilst offlining memory so I
>> don't think it is safe:
>
> Thanks for finding a reproducer. This is exactly the kind of BUG that
> we speculated about in the past but that we haven't seen in practice
> yet.

No worries. The reproducer consisted of running the compaction_test
selftest in a loop on a single NUMA node whilst cycling every memory
block in that node online/offline in parallel (ie. not a particularly
realistic real world workload). Eventually that led to a couple of
different kernel OOPS/BUG backtraces.

> Having that said, I'd be very happy if someone would have time to work
> on proper synchronization and I'd be happy to help
> brainstorming/reviewing :)

I would like to see the synchronisation cleaned up here and am happy to
work on it. I'm unlikely to have much bandwidth to do so before the new
year but any brainstorming/review would certainly be appreciated when I
do find some time though!
