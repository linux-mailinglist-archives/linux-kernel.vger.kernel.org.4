Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBC770ED20
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbjEXFcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239437AbjEXFb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:31:57 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422D81BC
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 22:31:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDyGVugq9xSa3Osx+pnXHjbTx0pzlOcXzehsptl/xs2x6AR2EwDU5of9oLTim212v2mQiEaCYU7RrcYxInurhshsMV+UWOBRszCoD5Gtf9vBCRbln8zaNfpIY24Z9sIq1czvXFOybHTaAVsXAM4pnQPtX9vQByelwQK3LyQU0J79PadPXTXqTeTnHSLtrzTddIxczB2kd0vhRqs5PRxTdJf53zVFFqAmKG+z+F+rriGVAG4r9cXbFyNINMr92ul/WRUcqx2LWDEIqFqBZ06xvGtlfh8dQTSSXTUy87o7r8Qu5MjKLCWA5q4z8ONzdNJZpfUf0MzUpzL0Vz8+MRiCpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WWpUbaBze0g/DRrTNIOwii8OJZ06hPiGJZ7Ii4gS1o=;
 b=LaMCxYm5d/5nDH4qKTDEGLTISO3Xzf/1TWFcuQvAIG4R8kbLw76Z0UHd0LRtFMFl/A1v/iqmAb9EEcNmNy0S7VVFnu6o5f/jl06Unfv9kiqLk8neTy653cje5kD4ifevAEbj/g8u5Rok6GD6DnwiDihod0ym3XHAupuEKnkZhFn6Nb4w/mn7M1etdnILl+SNnTsRdvT0+bT8coHiQZHIDK9HOBNT2u1r2KBVGYEMzlSK8eoDHis2yMbeaol01W38Ln8NNezSvxDoxKtQIcB7qp/1gFvi4xBbqH8Hm8aZAvn5QcS8aZg2I+wZNAYV5VVcTcku3g7hv+dBQXc2esFTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WWpUbaBze0g/DRrTNIOwii8OJZ06hPiGJZ7Ii4gS1o=;
 b=eFj4qQ3FYyNyDifC0XbdYo243zjELlvlMCh3HkZcKfgaLSmPYgqlxO9EEJzKbRfQ72kTZjm3JyZ4VuXnTws9OOjeh+2XEeYFCpcyfRRu2jU834dS6HKPbbR+LkORgiMzY4WKB7mYeedBsOn6ffrqKjIk0J7nK35dhP1H/fT5ZgkGbUD28c/7VCfnJDtN2665Xyusy+sZuvtpfIo4I2ENKkzW5JVOrx7gY2fvlAaium0ed1KeVPrZU973hxf240laF/FHLVbBtr95wmRJdH4Ag32powM6iyxdi8YSMtWow5H9JgYuRzLjwLs1lwlc0i44xXn4ak7r+jRrDCKkhbbiqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 05:31:51 +0000
Received: from DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::dc79:d410:23d3:f718]) by DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::dc79:d410:23d3:f718%5]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 05:31:50 +0000
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <2edc4657-b6ff-3d6e-2342-6b60bfccc5b@google.com>
 <0e3c5937-2f04-25d9-98eb-01e4c2b04150@linux.dev>
 <87353n9354.fsf@nvidia.com>
 <1d5d7f30-1a6a-5ea1-165f-65d34e7658e9@linux.dev>
 <89461cb2-ec2c-719c-8a50-1f76e8048ef@google.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Qi Zheng <qi.zheng@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 13/31] mm/hmm: retry if pte_offset_map() fails
Date:   Wed, 24 May 2023 15:16:06 +1000
In-reply-to: <89461cb2-ec2c-719c-8a50-1f76e8048ef@google.com>
Message-ID: <874jo270sg.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0118.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20b::7) To DM6PR12MB3179.namprd12.prod.outlook.com
 (2603:10b6:5:183::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3179:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf21eb8-72b9-41fa-6096-08db5c182cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vj4eu1XZwcOV1rHQXAD2g0wBlEy2NvvSE/wE/tc3EFBEXiUYcZCXLYrC/6+WfACZO1ucyaEQy6zjsGtHqW8loNIWuczcJ/j4t04PNFVUXHPps59xK+90ROeCpDttAZJM/4LpzUw0dNPhne5Y8cqonRbFOPz8npPKspQK78wwoAmC5Mdj/E4ftbDXQvpmUDJUC/9j5ShVqXW159ifXbWSAHTDaeGNdzBkYpivbzvzm/wQHbxZ3MUY6vTqhVD1MtJpeSbkaDW/V1Ql4E+em8VES/fltVz4hHDjsOyOQY3ZOp3HIea6TD+N+KDh6GrbSuGO6tzrDJzFFn6LDeq3YEbAG27JN6TOxICmyd3ZyOlmi5+lYYDzhzB80yA5JWwUUOy6GkYSCKqTlW6EHXv4CW2IBPIehi4VFSCA7TxcV0RjaBO8glDTi8Ozw/ystikNaw6WqdVU25WI1DJWSfOBCq78o39KWxLcNX1ko4O9CfcQpP+PvZmUfXORy198SRBpaWJJkSRsv1idITvgBrS+96Na1G95jowz8fKejyK3mg7iVOsJ/UKRa1WrGEkjF9sf6BFU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199021)(6512007)(26005)(53546011)(186003)(6506007)(7406005)(7416002)(2616005)(36756003)(2906002)(38100700002)(41300700001)(6486002)(316002)(54906003)(6666004)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(86362001)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J60p+9bFxR6JBeWKv3zRVjt0mU2Pk63bRMVO3qQhtpkPV+27GyzcxmoyzB/K?=
 =?us-ascii?Q?uDv8vXlxdfHYOndrqGiEnehHhhZK0ezx2uc5dVtEYuCG4IZWS3XyPn6uAf1e?=
 =?us-ascii?Q?jIDCIRX9KqcaZpDxEmHOmisZKrJ9aMea8ych9EuYGAJCxWoTBl7THDi390bZ?=
 =?us-ascii?Q?B9lwHnj0bilRqdtwRnpU7P4J2us1M81tlMJUzsuDs5siD1rQR+kHFeaB6Bvd?=
 =?us-ascii?Q?+Yf6m1A28H3QaEpT3FX9d1fXi9dqsH3fbzkqBji9NpHsv2d57bDuEfqxiBbt?=
 =?us-ascii?Q?hZ6v1uywLWvwWHWmYsdNd0ERpygxXQfi0wU5oQnUE0IK5jmmR7PW31zlh6lM?=
 =?us-ascii?Q?Z7G5x2cVAlmNd0SX8KhIuYScBq/e5WZOO+8f1DW4GzHXqsu+y7F0KB92yZXG?=
 =?us-ascii?Q?wJw4Ox5pq/4+j5qgjkLtgX8p8Z3u4H4vWDESMBuGaXlxXIQn9bQ9Q1Sj1hXn?=
 =?us-ascii?Q?umsZOCw0kCgEur8qV34tNA1Bnf9uk3fvOhC/Hm+eikKcpEDWYdGaLaWmHLRe?=
 =?us-ascii?Q?4/8DiiY+Kw2bK2ilTny/+s1CW4UPAnWpp5yn6K6dWYvSGpkH6sSQXqyZXFRJ?=
 =?us-ascii?Q?8dFvgsoExzy+SKdTiV6HnlEj4gC0wdx2sFtDO0UNE56cZ9hSWLwdaZN6+yz6?=
 =?us-ascii?Q?cZd55NGVmvncVhhLue6566aoLYgxG49GJl46HAVP/o6VyP1mJCN+7SmCU69w?=
 =?us-ascii?Q?Dlr5/UOftxUDY6vTkJYkIbHD5tQAGQLgAxrk0c+IHo4oK7URtwZNks5/iUnw?=
 =?us-ascii?Q?IPyd135v/HzrY0kGob38zfD8uU3YEpnj9wZ4agOVuHfmhccgnFQ8wMAb6bQD?=
 =?us-ascii?Q?gjwFOKkjdcNiq+QiKVpHByZBsl7iJizDTXkS0+cFRrRhwM6zEELLxJPHw8m2?=
 =?us-ascii?Q?x7iz5g1JHJ9itNot+BO7eVBv6/fXZ1QQS1PwP2H5bkIYnbp6MSH8MHEJ1e95?=
 =?us-ascii?Q?WmhbApn8U97s6BYTkqzf1S3aqImaIR5vEbm3V7D4YeSvBPzdtTKVd66nGZu4?=
 =?us-ascii?Q?32iaehwI3gZiJxqNFjoIMueLauXxYd++WYBwu6HV1VytN1asiEi6Xeq/NPno?=
 =?us-ascii?Q?cY+mnbup1Pe6GSo9l4KhHTStK4FkiXY9Tm8q3NOhFgkeQsKztIvFCwAKWe4C?=
 =?us-ascii?Q?XpvONhiQT9TWd7ebU55SgslbxZr5sfxBDoSNIDNa8cyA6anEO3x3uc1nJ+Wp?=
 =?us-ascii?Q?IjzSm4JCETybFCoUOE2o0/wsB5zPnKeEUIGsliKH7VtRMtacvrLBGQlwXA8c?=
 =?us-ascii?Q?yRc+gD8c2OSVAsRyamh9bf+1Cb33Yzldmj80LScds9zCWQzHHQLw4R7Ryy2O?=
 =?us-ascii?Q?TIzbb0ostXYzCO01FuorDGs62aj+qqc1/EdQwydMoP32wV1e6GbCPqYuqvc6?=
 =?us-ascii?Q?+jD/vtCyb4LX0VhZ/ONBapMohUSJMLHnxZ33Irs7PgJl4cjk3qIgXnmODaMH?=
 =?us-ascii?Q?vrQxOaJR+xDtL4DrNM4e50lxTbn9K6BvFHe9AgLQ4cmYC9gKNzqeA/rdzpa7?=
 =?us-ascii?Q?0d/gvAVKM3UDKEz6WTmwnY886vt2s4gNFjNvEQvjLebx6OSsdtTcTz1HbuuG?=
 =?us-ascii?Q?N/Sy3VSRuSomwon9QVIEjB6QMoCLhvhtNiXpVJbG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf21eb8-72b9-41fa-6096-08db5c182cd3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 05:31:50.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6bzlxpmetbLgrd3nOGpfmiwjqjKLFyT8w8didXoPT2yfXoeibws4Tzq+mpsWtZdeIUCpe31F1SSaGvCXtEj7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hugh Dickins <hughd@google.com> writes:

> On Tue, 23 May 2023, Qi Zheng wrote:
>> On 2023/5/23 10:39, Alistair Popple wrote:
>> > Qi Zheng <qi.zheng@linux.dev> writes:
>> >> On 2023/5/22 13:05, Hugh Dickins wrote:
>> >>> hmm_vma_walk_pmd() is called through mm_walk, but already has a goto
>> >>> again loop of its own, so take part in that if pte_offset_map() fails.
>> >>> Signed-off-by: Hugh Dickins <hughd@google.com>
>> >>> ---
>> >>>    mm/hmm.c | 2 ++
>> >>>    1 file changed, 2 insertions(+)
>> >>> diff --git a/mm/hmm.c b/mm/hmm.c
>> >>> index e23043345615..b1a9159d7c92 100644
>> >>> --- a/mm/hmm.c
>> >>> +++ b/mm/hmm.c
>> >>> @@ -381,6 +381,8 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>> >>>     }
>> >>>      	ptep = pte_offset_map(pmdp, addr);
>> >>> +	if (!ptep)
>> >>> +		goto again;
>> >>>     for (; addr < end; addr += PAGE_SIZE, ptep++, hmm_pfns++) {
>> >>>      int r;
>> >>>    
>> >>
>> >> I haven't read the entire patch set yet, but taking a note here.
>> >> The hmm_vma_handle_pte() will unmap pte and then call
>> >> migration_entry_wait() to remap pte, so this may fail, we need to
>> >> handle this case like below:
>> > 
>> > I don't see a problem here. Sure, hmm_vma_handle_pte() might return
>> > -EBUSY but that will get returned up to hmm_range_fault() which will
>> > retry the whole thing again and presumably fail when looking at the PMD.
>> 
>> Yeah. There is no problem with this and the modification to
>> migration_entry_wait() can be simplified. My previous thought was that
>> we can finish the retry logic in hmm_vma_walk_pmd() without handing it
>> over to the caller. :)
>
> Okay, Alistair has resolved this one, thanks, I agree; but what is
> "the modification to migration_entry_wait()" that you refer to there?
>
> I don't think there's any need to make it a bool, it's normal for there
> to be races on entry to migration_entry_wait(), and we're used to just
> returning to caller (and back up to userspace) when it does not wait.

Agreed. I didn't spot any places where returning to the caller without
actually waiting would cause looping. I assume any retries or refaults
will find the cleared PMD and fault/error out in some other manner
anyway.

hmm_range_fault() is the only place that might have been a bit special,
but it looks fine to me so:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Hugh

