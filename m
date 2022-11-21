Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BB5631969
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 06:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiKUFQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 00:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKUFQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 00:16:00 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994102E9E5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 21:15:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clwOzOtFnfTvWQDsqIw/QTmCwtPOshNAwpkaSGO4CbCrmEF2l/n8xyyMbrOgBkj7cEQ9Q842/PO8TpVtYZPNqcguMJ0m/FtAypwhUnapOlqK2Eary3z+3/ToQra8KPxMqD7WzXOvmWkdM/nYcRCoIeU2NaYO8439IHGcJU78NTg6r6tiRPcA2LXII+Ak2YLh1yeoDO/nublRpnCtnvsQ51KGVsVYlfo4F4ivWiYL96wl/yT0wkQrhhW+c0P7+xW1CIwClHbzUO17rShKRMUVLg/s1Y/L99f0Q150GMBVzeY1PGKj+eXAioWBv3/OlueB5ZufIa9gHxEUzNU43ep6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBNuI6lTrvrdyMS5QAItBD4nb5WPi5v/1vfTB9RZiTA=;
 b=WSl7cS13E0vQJL94bmLFBgYMNafRR6fzHgqslWBU8D6Vob9c19O4hVpWQz1T1pHFv8lNGo1MvZUkmQk/hecYRkfhEWxip64tZswuOb34OPp1NPiGlNWOW5gYir+f8iHzo3kTV+tp2brThZ3Ha7FIbGv4BuLvnDESKZDBJu4Ii1ZAHCKOkhIuqlvcZiv01vWWmJl523exzh4N5WGP4YOcPLp2h6jatiCVtHIgqzkt9Hv4CTlLgkhD7IvDOaLKUkxuncVwegxqaFyqTEzT5hVDv61VaNBRGCjCibMXkTFqNVSx7+K1DWHbmM7PGaDiGkoRpjvSXcnzMcnGIJA3GDaGxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBNuI6lTrvrdyMS5QAItBD4nb5WPi5v/1vfTB9RZiTA=;
 b=GGb4muDJbT32mArCkCwPgE17LmnIT99I4yBE/rvsJGPSYQHV8SFFW8npp3x2Cj3V/BN1cBVxiYpHj6RbnHcTWng6JSQ4MqqDZYnowhWHe6tbngGBrYEEKFynWSzyzYRdkUXcNx7xzsBYy8vkPDK9kB+QI7GcTRR4OL/GkmrAxCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by DS0PR12MB6558.namprd12.prod.outlook.com (2603:10b6:8:d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Mon, 21 Nov
 2022 05:15:56 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::fba4:3934:b658:d058]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::fba4:3934:b658:d058%5]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 05:15:56 +0000
Message-ID: <dfc6bdde-7e5d-44e8-8549-7d61a0f18bb5@amd.com>
Date:   Mon, 21 Nov 2022 10:45:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
From:   Raghavendra K T <raghavendra.kt@amd.com>
Subject: Re: [PATCH v4 0/7] mm: Remember a/d bits for migration entries
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220811161331.37055-1-peterx@redhat.com>
X-Mozilla-News-Host: news://nntp.lore.kernel.org
Content-Language: en-US
In-Reply-To: <20220811161331.37055-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0227.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::14) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|DS0PR12MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: 0959f570-9612-4cbe-defb-08dacb7f77f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZOSMr0i0/hyhG1JgfHL9QfVnZWnH94s09tFIJd4CdJK8z8sS8ek1TqpcHt8E8SeLYTpPFZdjqbJWlckvW3VxckIkO4T9nhhRsJxkoDfEIseXv9yu9+T/P2xVIekQXCIuhNXKhh7GFMIVE/FPgU+Ml85i3zgyW4XPQ75QeCBY1i2+SFCERj7WjWfSMviq9e1dRUHAYQ8p9sLe00HVlYw4xjQsyMvGbyyQE16BqldnjBMGB7VPT5sd5EOEZYXOtUDUXkgK82B79f8BGRZPZKY+W21N2O4hHzwmXFtJ7llwnQYVvXqMjQhYN9cptoLfZRH63F764nSsUfkHddI6eLcrvA5xsH9bNcRfkTRe50GUE4BdFgYrYmpYiIKidyayp5MKj6gtVydMO12nXLUqVjYDffuxRZM14uOAwS1/tNdMHcyE2pYqgrgaNiIeF6jgpDVL9O7Mp52/kf0Gna/7aHpj9EtwIu574E69eyMmMM/aqh64PZkVgsLvlPlE7N1h2yDi0106rmetNQHNfIPYseiKyrc9HDrNKPE/bLwzwIuFCTsgdqY0dtrDPKVOuliWmknxkKLdcBly5T4p6SaWqJCT/jzjgFiG1XwGfUBBp/c58PQdWnHdLAUnxJsCxJynO6aJQp7ZP8fbUbT7iD3wgEDoSG2psUnu6ekHhSzgMJv3CDwJQWxwQ+3VQlQ9VkWyafHIkVtPCAlGBzDW2JTCs+0hJhR3opmV2DmT9MF7xP4dlU7VWAsv1ecWTyc9aKpha/Fa+EHGPD+nqXvIgkG7RCwLpcE5Vku6OzGYf2MNI7UdGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199015)(6512007)(478600001)(53546011)(8936002)(6666004)(7416002)(36756003)(41300700001)(966005)(6506007)(6486002)(26005)(2906002)(5660300002)(186003)(38100700002)(2616005)(31696002)(83380400001)(66946007)(66476007)(66556008)(31686004)(316002)(54906003)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUpPb0NIWjlVbCtNbHdIVjJWakFEaUZHTENzbGpONG80bXZhKzI0bG9qai9E?=
 =?utf-8?B?ZnRpNi9tQlJVQTY0TWh4cWp0MXE3Vjg2a3JnNVZrNEVOckFBcXUvNDNWclBS?=
 =?utf-8?B?ZHVIWmVnS1c2d0pMMjA0Slc1RTV3bEFOUHNDQ3IvSDRoLzNDaWN4dzAxNEww?=
 =?utf-8?B?UHc1UWw2UUoxdDdlODNrckF2YkdFTnFuQjU5T2NXNzZTMGk2TEVaeHFFV2JL?=
 =?utf-8?B?bDlER2c4VlVYS0xUQ25ibWt4U243cVVNQkw2cFRnSXROVWlZcjY3eVJzd21x?=
 =?utf-8?B?aWxUN2tVNGVkUnIrNHVDQjR5bXZUQllObnhmR0pDNVEwWjd6TzhocnFVV0Ur?=
 =?utf-8?B?SVZsQ1FoNkcxK2dXRFp4V0VaTkx1NDRCdjBrUGFHdU15SWthak4yUmZDODlr?=
 =?utf-8?B?T2hUWFlVRFlLd1RQMUprVUNVLzk5Zy9hRnlvNWpXWEhzUzVTVFlsTHJweFBM?=
 =?utf-8?B?bFRmTllpd3ZKRnZnZVlyYzVQcFExaVNFaEc5cm5LWWxJUmVXUy9helFaLzFB?=
 =?utf-8?B?Ung0azNGWHNkd0lCN2g4ZkZpcmdOSmE1a2R0ZzdzY056R3Bva3prS3hDNXNY?=
 =?utf-8?B?eUZFa3BZV2ZlYWsvcHN4cDZ5SVl3dVpuK2RuMTVmaEhkVFFXVTZWMzRDMWo0?=
 =?utf-8?B?MlJSY2lLUkxVSHd2TnZTa0lZMWtwY1FHR2QrUUEwZHpXR1loWmFkNVc4aGNL?=
 =?utf-8?B?Z3FXRUJhUHdVN3lyWDhZYU5zWThKWHkyenFtRThoTGpodXRuMWlEUmtJck5y?=
 =?utf-8?B?K3V4dXNHM0VGNU5sMDNUdzIrai9oaTlxaUZ0allzNkoxVWlZcUNlOWJyZUM1?=
 =?utf-8?B?bFFqbFdmUThoWHBtKzVESHJkZ1FMcG94ZzZQdEQ4aHdGTnZvaGJtdFV1RlZs?=
 =?utf-8?B?YUFONCtkN3MzaGhac3pXU1BtQktnbGRKUHVodWE1S1RrdTAyL2VyT29zOXlv?=
 =?utf-8?B?UXZNTUFYNC9wdFpuWVRmTlgvMEZUNEc3d2VlVnRDU3RCRmQ0bzNJUmlOWHhE?=
 =?utf-8?B?S3kvaG1iRVdTZXJvU1puRHJlM2djMWpYMjRWYVdaNlgyOTVXeFNrNUt1N0Iw?=
 =?utf-8?B?NGgxQUpuODF6ZWdKMjE4YjBNMC82SjE2VlBDVExQOFg1MmtLNlBLMTlwbFl1?=
 =?utf-8?B?Q3RyQmwrSmRKWndoUjRiV2ppZGozVWlMTWdvcnB5b1I0YWFYcmF3bFpFODho?=
 =?utf-8?B?NFB4SUFhYm5qaHltNGNxOXdQZUlBVHI0MEw0NnhxbXp1UHhWWjY1bHFoZlhJ?=
 =?utf-8?B?L0JlSWpvOHRRVnh1Q0NYRWhqdUdCRWZJdGF0SWgrU21GQ2NYRW91dUxTbnhM?=
 =?utf-8?B?a0ZkSjNkM1kzUjdYM1NkSGFxYWppWUZ6ak9KR0s3dFVPS3UyY3FBVDg0c1My?=
 =?utf-8?B?Y2FuNUZXTWhVQkJhNDc3WkQxS1FPdlgweFZsUUZwWEJYaXpKbkIzYlVMVWJL?=
 =?utf-8?B?c0Z3aTQyM0dMSTdtV3VjQW91UktzbUxSWHAzL2w1WjVWTnU5OGpnS1ozME5u?=
 =?utf-8?B?QVoxOWp0SnhIRHI2K29OWFFFMlBvcnRrYlk3aDJadjFTd1NiaUZtVkluSklZ?=
 =?utf-8?B?WmF5VHJuV0YyUDl1RGZPN1VDUy85b29Fa3VBb1Mva05ZQlFueGpOMXVuNS81?=
 =?utf-8?B?aUZMMzhwQnphOCtxOEpUWU5xdG5hTm5aSzVNUktYaHJtRlVQTFNUZFdMcUh5?=
 =?utf-8?B?ZFBFK2dTMXN0TFZmWE1ZQjJDcnhhYlRmKzFlS1dIcG9xQUEwazRNNlhPdEl2?=
 =?utf-8?B?NjNXVnhEYWcrT1BxeHV6eThDQnVOSHA2UmZSRHA2YVd3Tmd6aDVuaG1lSG9i?=
 =?utf-8?B?Vm9JS1piVTNyZ1RTTlBWSTlGQmdvSDBzSi9mR2xBN0huYjA3cVRIb0tqenVh?=
 =?utf-8?B?cDVWV0pIUUtORE84S2Iwd3R3dDJiVmE4ZS9MQ1Bld0RHNXlyVGFuL3I1bUMr?=
 =?utf-8?B?anE0SjhOeHFYdnRUeHduSHZLeTJsdllRU28vY1ZyQ2QvYU05YlpyT0U0Zmxt?=
 =?utf-8?B?M2JPTEpTZXhwUzBybUtEZmpxeC9LcGk3Q0NMdzM4QlUwYmZwTUw0WHE2UVBx?=
 =?utf-8?B?RUJSdlh1SU44NitocWdhQ2VnZ3RrNTJjT2lTWk5KRHN2enJ5ekRIYTdGbDd3?=
 =?utf-8?Q?WaYMeqlroODEbtFSAgChbE2vQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0959f570-9612-4cbe-defb-08dacb7f77f2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 05:15:56.3318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KhdFc0FiRvyhyh1D+xuPFX1n68/C6hAmpJ6HdkuhByBW5ee547xzEjgoxDjQia2vbzfZqryNx2qAyUVbdHUqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6558
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/2022 9:43 PM, Peter Xu wrote:
> v4:
> - Added r-bs for Ying
> - Some cosmetic changes here and there [Ying]
> - Fix smaps to only dump PFN for pfn swap entries for both pte/pmd [Ying]
> - Remove max_swapfile_size(), export swapfile_maximum_size variable [Ying]
> - In migrate_vma_collect_pmd() only read A/D if pte_present()
> 
> rfc: https://lore.kernel.org/all/20220729014041.21292-1-peterx@redhat.com
> v1:  https://lore.kernel.org/all/20220803012159.36551-1-peterx@redhat.com
> v2:  https://lore.kernel.org/all/20220804203952.53665-1-peterx@redhat.com
> v3:  https://lore.kernel.org/all/20220809220100.20033-1-peterx@redhat.com
> 
> Problem
> =======
> 
> When migrate a page, right now we always mark the migrated page as old &
> clean.
> 
> However that could lead to at least two problems:
> 
>    (1) We lost the real hot/cold information while we could have persisted.
>        That information shouldn't change even if the backing page is changed
>        after the migration,
> 
>    (2) There can be always extra overhead on the immediate next access to
>        any migrated page, because hardware MMU needs cycles to set the young
>        bit again for reads, and dirty bits for write, as long as the
>        hardware MMU supports these bits.
> 
> Many of the recent upstream works showed that (2) is not something trivial
> and actually very measurable.  In my test case, reading 1G chunk of memory
> - jumping in page size intervals - could take 99ms just because of the
> extra setting on the young bit on a generic x86_64 system, comparing to 4ms
> if young set.
> 
> This issue is originally reported by Andrea Arcangeli.
> 
> Solution
> ========
> 
> To solve this problem, this patchset tries to remember the young/dirty bits
> in the migration entries and carry them over when recovering the ptes.
> 
> We have the chance to do so because in many systems the swap offset is not
> really fully used.  Migration entries use swp offset to store PFN only,
> while the PFN is normally not as large as swp offset and normally smaller.
> It means we do have some free bits in swp offset that we can use to store
> things like A/D bits, and that's how this series tried to approach this
> problem.
> 
> max_swapfile_size() is used here to detect per-arch offset length in swp
> entries.  We'll automatically remember the A/D bits when we find that we
> have enough swp offset field to keep both the PFN and the extra bits.
> 
> Since max_swapfile_size() can be slow, the last two patches cache the
> results for it and also swap_migration_ad_supported as a whole.
> 
> Known Issues / TODOs
> ====================
> 
> We still haven't taught madvise() to recognize the new A/D bits in
> migration entries, namely MADV_COLD/MADV_FREE.  E.g. when MADV_COLD upon a
> migration entry.  It's not clear yet on whether we should clear the A bit,
> or we should just drop the entry directly.
> 
> We didn't teach idle page tracking on the new migration entries, because
> it'll need larger rework on the tree on rmap pgtable walk.  However it
> should make it already better because before this patchset page will be old
> page after migration, so the series will fix potential false negative of
> idle page tracking when pages were migrated before observing.
> 
> The other thing is migration A/D bits will not start to working for private
> device swap entries.  The code is there for completeness but since private
> device swap entries do not yet have fields to store A/D bits, even if we'll
> persistent A/D across present pte switching to migration entry, we'll lose
> it again when the migration entry converted to private device swap entry.
> 
> Tests
> =====
> 
> After the patchset applied, the immediate read access test [1] of above 1G
> chunk after migration can shrink from 99ms to 4ms.  The test is done by
> moving 1G pages from node 0->1->0 then read it in page size jumps.  The
> test is with Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz.
> 
> Similar effect can also be measured when writting the memory the 1st time
> after migration.
> 
> After applying the patchset, both initial immediate read/write after page
> migrated will perform similarly like before migration happened.

I was able to test on AMD EPYC 64 core 2 numa node (Milan) 3.72 GHz 
clocked system

am seeing the similar improvement for the test mentioned above (swap-young)

base: (6.0)
--------------
Write (node 0) took 562202 (us)
Read (node 0) took 7790 (us)
Move to node 1 took 474876(us)
Move to node 0 took 642805(us)
Read (node 0) took 81364 (us)
Write (node 0) took 12887 (us)
Read (node 0) took 5202 (us)
Write (node 0) took 4533 (us)
Read (node 0) took 5229 (us)
Write (node 0) took 4558 (us)
Read (node 0) took 5198 (us)
Write (node 0) took 4551 (us)
Read (node 0) took 5218 (us)
Write (node 0) took 4534 (us)

patched
-------------
Write (node 0) took 250232 (us)
Read (node 0) took 3262 (us)
Move to node 1 took 640636(us)
Move to node 0 took 449051(us)
Read (node 0) took 2966 (us)
Write (node 0) took 2720 (us)
Read (node 0) took 2891 (us)
Write (node 0) took 2560 (us)
Read (node 0) took 2899 (us)
Write (node 0) took 2568 (us)
Read (node 0) took 2890 (us)
Write (node 0) took 2568 (us)
Read (node 0) took 2897 (us)
Write (node 0) took 2563 (us)

Please feel free to add FWIW
Tested-by: Raghavendra K T <raghavendra.kt@amd.com>

> 
> Patch Layout
> ============
> 
> Patch 1-2:  Cleanups from either previous versions or on swapops.h macros.
> 
> Patch 3-4:  Prepare for the introduction of migration A/D bits
> 
> Patch 5:    The core patch to remember young/dirty bit in swap offsets.
> 
> Patch 6-7:  Cache relevant fields to make migration_entry_supports_ad() fast.
> 
> Please review, thanks.
> 
> [1] https://github.com/xzpeter/clibs/blob/master/misc/swap-young.c
> 
> Peter Xu (7):
>    mm/x86: Use SWP_TYPE_BITS in 3-level swap macros
>    mm/swap: Comment all the ifdef in swapops.h
>    mm/swap: Add swp_offset_pfn() to fetch PFN from swap entry
>    mm/thp: Carry over dirty bit when thp splits on pmd
>    mm: Remember young/dirty bit for page migrations
>    mm/swap: Cache maximum swapfile size when init swap
>    mm/swap: Cache swap migration A/D bits support
> 
>   arch/arm64/mm/hugetlbpage.c           |   2 +-
>   arch/x86/include/asm/pgtable-3level.h |   8 +-
>   arch/x86/mm/init.c                    |   2 +-
>   fs/proc/task_mmu.c                    |  20 +++-
>   include/linux/swapfile.h              |   5 +-
>   include/linux/swapops.h               | 145 +++++++++++++++++++++++---
>   mm/hmm.c                              |   2 +-
>   mm/huge_memory.c                      |  27 ++++-
>   mm/memory-failure.c                   |   2 +-
>   mm/migrate.c                          |   6 +-
>   mm/migrate_device.c                   |   6 ++
>   mm/page_vma_mapped.c                  |   6 +-
>   mm/rmap.c                             |   5 +-
>   mm/swapfile.c                         |  15 ++-
>   14 files changed, 214 insertions(+), 37 deletions(-)
> 

