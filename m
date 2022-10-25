Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B0060C61E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiJYILy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiJYILv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:11:51 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1484B82753
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:11:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cd/0bLh86Nkt5WgQlpfqtfo9s4J19ybBVlbPqRsQ85+C0qiG/nXJo1/R44QYBqMqAHYJoW/2s3NUh1Qt6xOU+k2BqbqZ6DgYVplaIglwQuLq0Bg1pKZpPjzrVRIUtYIv/39goHc0MojYnIWfeCr1xKKmmfTi9svKK6M/nqaAjAm/5qQ2u8ophaxjInJD8UB5bHcX7KfMRF8WJ4QjOwoM16aYd9AUbviy4ascAZus+M5HsOg4/NeFueIWryqQDGKO2egPY4wkYJqG2PjbXf/96x+dHVCVxvXqd6nqjbNntUfb/NFQrYhP9S8348bgRPNF3dPRKCcCJhr78QfUoxKo7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4al4q7NBjauOz9mYSEmpZppQBwWkUWYFyQlbG9KeiE=;
 b=UjmCWQHT3rMAwIJR+Rd4PUjHavrgpvVSUUjJbC6VotGXv0CesGEcbv5qlx4byrcLB3o+FbethrADVr2/h5aMosMgCS1cPhbLoqNQPnvO+YSfmsjDWeELMavpJnoqLlxJm1lBqanyRPJ2nYV+8M3wuB6JhM9HhtPm9M81D5xfNHz1VVj0SskkPZEkptKz6+IMkm31wZ8RaUwWCDfg81IVp34Tgnt9ffWjmsrjYhpVcaZY2OG7NSzDEBpT7Ig7kr4KTlx5jstgn6LnGmNrjJlYmGPbHxFHgbjtgn4y6vSmQhHbRjPcVDZWJ8Q67NVvc4fz87hmu8vwarELXiormQwryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4al4q7NBjauOz9mYSEmpZppQBwWkUWYFyQlbG9KeiE=;
 b=kHagWowVJH1pIzvTAHe/lz1vNUt38HJR+7poqk1g9cSJSPFQbEEB8pq36lsreOHVIkIOSD7tzfWsD7ty2fzwuzcrTgb778EFFbdPIXskb3DXKqQulzfkYwSDAyzq2fcU/N/k7oUKk7j+21ctQZI9DMp9WG4fK3Th8VmjcMdF9ZIKQfwVbUeoRpU/PjU6IDJQDYlavPF3Nc3AL2ZdHOpRZn6DHCTk78r/6Dsl1ui+C3LG93hOVeEUt3OhQtM7PNr8u7jGu1JxS9YAKVV8PffqdCnOS1UA+XAzIk+TlRltxT3eBHqiHscSuIKGUAGaUzP7+oD3Gv6NIdyHSdRjbQ9+zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 08:11:45 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6ed5:b1a6:b935:a4d8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6ed5:b1a6:b935:a4d8%7]) with mapi id 15.20.5723.034; Tue, 25 Oct 2022
 08:11:45 +0000
References: <20221022111403.531902164@infradead.org>
 <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <CAHk-=wjoGnHVVp5pcb69C6HtnJ_avqQo_b5NK-X9bgoDDw_XbA@mail.gmail.com>
 <CAG48ez3KMuM2aLpc8SvGiqZvv1KFc7E2DBZ4CLzxQeFhrMN_-w@mail.gmail.com>
 <Y1dWQ+YQyiz3V9Sp@casper.infradead.org>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>, x86@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
Date:   Tue, 25 Oct 2022 18:54:10 +1100
In-reply-to: <Y1dWQ+YQyiz3V9Sp@casper.infradead.org>
Message-ID: <87fsfcuxu6.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0137.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::22) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|MN2PR12MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e878204-243e-4d72-70ea-08dab6608e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L75hi+sLPaSsKHWB6OU0e8D2nOhbZs/z/94Q00QjzKxaJi1QzFpkrZHj1fuPi8nbmzAFfESHzy1X70mVc7LY5vllMlnRGdvQ/m13gRoyIsYARPNTpVjUxWsgz4IFXmi2qID3S04LZgGDXJVBL0ib+tFiwfeAOzFI9qJUDOVRdHzw4nUMNHSGc3Nsj384NiQ6MWMKJhjsyn0Bv+IPEYfnWRt0Y47Uie5GNtYmYPJhRPl1ai1DSdWAXrKPTkPnLHg6F+flJDfP+0zjhjDqN7Iw4uNcFQSamncXOAbM4txJCN/xFsDIXStTlevBa7HuML4Far42PoeOxz8pfkaeGxLZhDOPJCnx4cXYIFymaYxPOR4f0+66KQYeKpUByf9TpqTDTxjw/8pLfG/UsEIFNu6SfwMSkm/0ROTKfSEGM6hJtxnfPBqI4LZQuwySVpkZSt+QchEAiSbAM/kcCBU6v9SbSfmpR81vzPg71DJYJ5E5pP2C+rcEhgc/KPiDxv/B2SAOKWrnPi76NJQ4xhFAhoEsNydXgqUgScBojRRW4My2puK2iq21IqIBUrO8obxDkfkVOcgIs9TNBDNPOpi07TpOuZegiLFbB0KM6+/1lGJZsqHHa2f1hG+bRM1DoXvjIk82Pui2s0zFMJ3FVJuPUkwhDFhXC9oUhJIux4R5N5w41dZC2av8IlYpzpPLRb2zlD0NCAFp/8QvbImAMg2e9Y9vcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199015)(86362001)(36756003)(38100700002)(2906002)(83380400001)(8936002)(7416002)(5660300002)(6666004)(6506007)(186003)(2616005)(6512007)(26005)(478600001)(54906003)(6916009)(8676002)(316002)(66946007)(66556008)(66476007)(41300700001)(6486002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O3IiGLMfexRed2OSAcCX2QNKjuesm5SDK4bVJ0qJEJ4Fyqa2d1S0NSZ3AS1w?=
 =?us-ascii?Q?/LRN8PtcIh7VTj2pmtJBWqrZJ3NUQ/Ud9U377QA34jhZ2+40ak6frwXIzFaN?=
 =?us-ascii?Q?uopmqWkjWB72461/qho6N7BAy2pB+vWfsivqIOMdSZIVU+BcBQzb4WPRkaHr?=
 =?us-ascii?Q?LlSHuf7Axr7g+j1jtdLdnfAwMTPBS7Koh2nmUxAk9OMs4qpPcA6ZqdIZ64vN?=
 =?us-ascii?Q?oSN5ULZiPupjeMyZ8v+0YZ+2MvVdQEsBU/oI2cgOKj4DJb/jaPF5LIFwyie3?=
 =?us-ascii?Q?ae+/LNX18bkD/yNrSFV4aivzJCgq8Iwa27RuuSjy10cfXC7nV2sgxrRXmxHk?=
 =?us-ascii?Q?eSf+oMv6cwWOFMAJAXcgi88Pf5axUtQg62zMbN9JWMHDu1lAWHMMUYME0zAg?=
 =?us-ascii?Q?Y2OvYYX+ysizzENhcCc4lZrDa9nuS/bRlHr17lA0y63igt4TpTKBYt5iCKqa?=
 =?us-ascii?Q?OhoBd5E2iHiVQiEQl7VMh1+eNHfuE1XMjsk43j2/GxNeBlStps49adnkmvC9?=
 =?us-ascii?Q?6KmfIB9FSyz/IghkIqkpR3iJzNxu7/P49dbyegdmEILGqUP8kURgHof3Ntt9?=
 =?us-ascii?Q?B3YtM8w6e1ZfcrdnGOGQXQIT4pBbMKVw2jyS4Gu5uHjUmnT1jX4rrZFkNIfl?=
 =?us-ascii?Q?tLPTDxK0akco4yMWVDPwQXVsUBHf1jqNohtv9d5ip95BYoMuhirtqxQhEGa/?=
 =?us-ascii?Q?KxrhOgA0ZcMQZXtmHQV/i9fXdYioeqMNfJv/UjDhMTQ3j1161QaLbCDTbpvB?=
 =?us-ascii?Q?Bl53WiQ3ySABfdEdHz0cI4NWyA3nwCPoaFYGK0QhC6P4002NdzuEbOQk6CnG?=
 =?us-ascii?Q?bnQdBhbsf44WFvHn0fdAoKb2PSPORos71djYyV//E1t/RltHFQ4ATnaBi5bR?=
 =?us-ascii?Q?Tk4F4EaAce441WRI+7CD4r/r2p9YngpjQ9GcNpMmSTnKEZzZuduCjqxyGqRv?=
 =?us-ascii?Q?EmNoGSp36ncWH+7ihmMurVEZ+CXWrYym8hBWj99iB2rLUR+6BhNOynfCtA8X?=
 =?us-ascii?Q?gi4olbDR+xTo7ArmvtJAos6JZbujGpX/veGxKg6FJ/8d2LB9bcg/TKLDVtjl?=
 =?us-ascii?Q?OstvFr/zxo8bnbLqnSVizh2Mzf0m0+PFSTVwZxNvuUDhZsg1mR6vqpB7cfwp?=
 =?us-ascii?Q?qa2/R0I8BQshUUUkh+Oe5p4K6xXF+orN1jQg6ZFCT+/3hqeLZIxhW+UsCA9b?=
 =?us-ascii?Q?bzkhisePWQaHjC99M0a019KMeVlmYXrpqy8jOFwfdYK9iSkscsfm8W/bnBHm?=
 =?us-ascii?Q?WsurXLE5L5clWLuIwlrLcGzacvWs9r1AVULZNJN2A955IGXoVFdOhpznqL95?=
 =?us-ascii?Q?xxmK30YtLgZ+7Is07cQIyApcEnADFrIAn8ZN7leKBAce3dJCvhlfXXXTDqwS?=
 =?us-ascii?Q?38UTN2fY+0sH+owbkqsZ8WRlpJ19TPO0dHF+Jz2RSqW9PTlBLQyFFMkdLToJ?=
 =?us-ascii?Q?1bRsSqzrO72LEX4WzsvkLYalyZbWbcQuDdpncHbqrHFLcvmNKW0DHM2hVVuc?=
 =?us-ascii?Q?vCXHHQ12nV4XhK+2EZG8EnMIFip1ysJobSiT78lyrYD2Is4yIkxhEVDdBLW+?=
 =?us-ascii?Q?PWVFQsdDCmC+fse9rfUcG+z4ANBtcwEtj2LXDSFA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e878204-243e-4d72-70ea-08dab6608e40
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 08:11:44.9331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fiHup5dWlb4f7QXtKIMd2Y7eM5oqEhTmf5hFjU7iSD4kEbgbAVCoweDDiJ6X789K8dMe1wweP7RcOOEwih8qEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Oct 24, 2022 at 10:23:51PM +0200, Jann Horn wrote:
>> """
>> This guarantees that the page tables that are being walked
>> aren't freed concurrently, but at the end of the walk, we
>> have to grab a stable reference to the referenced page.
>> For this we use the grab-reference-and-revalidate trick
>> from above again:
>> First we (locklessly) load the page
>> table entry, then we grab a reference to the page that it
>> points to (which can fail if the refcount is zero, in that
>> case we bail), then we recheck that the page table entry
>> is still the same, and if it changed in between, we drop the
>> page reference and bail.
>> This can, again, grab a reference to a page after it has
>> already been freed and reallocated. The reason why this is
>> fine is that the metadata structure that holds this refcount,
>> `struct folio` (or `struct page`, depending on which kernel
>> version you're looking at; in current kernels it's `folio`
>> but `struct page` and `struct folio` are actually aliases for
>> the same memory, basically, though that is supposed to maybe
>> change at some point) is never freed; even when a page is
>> freed and reallocated, the corresponding `struct folio`
>> stays. This does have the fun consequence that whenever a
>> page/folio has a non-zero refcount, the refcount can
>> spuriously go up and then back down for a little bit.
>> (Also it's technically not as simple as I just described it,
>> because the `struct page` that the PTE points to might be
>> a "tail page" of a `struct folio`.
>> So actually we first read the PTE, the PTE gives us the
>> `page*`, then from that we go to the `folio*`, then we
>> try to grab a reference to the `folio`, then if that worked
>> we check that the `page` still points to the same `folio`,
>> and then we recheck that the PTE is still the same.)
>> """
>
> Nngh.  In trying to make this description fit all kernels (with
> both pages and folios), you've complicated it maximally.  Let's
> try a more simple explanation:
>
> First we (locklessly) load the page table entry, then we grab a
> reference to the folio that contains it (which can fail if the
> refcount is zero, in that case we bail), then we recheck that the
> page table entry is still the same, and if it changed in between,
> we drop the folio reference and bail.
> This can, again, grab a reference to a folio after it has
> already been freed and reallocated. The reason why this is
> fine is that the metadata structure that holds this refcount,
> `struct folio` is never freed; even when a folio is
> freed and reallocated, the corresponding `struct folio`
> stays.

I'm probably missing something obvious but how is that synchronised
against memory hotplug? AFAICT if it isn't couldn't the pages be freed
and memory removed? In that case the above would no longer hold because
(I think) the metadata structure could have been freed.

> This does have the fun consequence that whenever a
> folio has a non-zero refcount, the refcount can
> spuriously go up and then back down for a little bit.
> (Also it's slightly more complex than I just described,
> because the PTE that we just loaded might be in the middle of
> being reallocated into a different folio.
> So actually we first read the PTE, translate the PTE into the
> `page*`, then from that we go to the `folio*`, then we
> try to grab a reference to the `folio`, then if that worked
> we check that the `page` is still in the same `folio`,
> and then we recheck that the PTE is still the same.  Older kernels
> did not make a clear distinction between pages and folios, so
> it was even more confusing.)
>
>
> Better?
