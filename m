Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F272A6E655A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjDRNGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjDRNGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:06:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A488A7C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:06:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GakGx0H3t+DYcnY9r0b6kNZhJIxOmc/SsKEWalQPrMv4PMAOrDmQrDPbtIC0VtXwIOaBnQldjvMvJ5oT5EC8o843KvSfNJTF1ImJmmRtYn8yYuaOLTDyZYm77Xfi4HJaENitqL2PijUcHzCiVpCqlnYvWDbduiZhol86b1TN2AiSQHvwA849y0QGGvnHk76i6MDlAnZNmA4cd8/JlFAyyQJdLwILUQcOZYvrrO3fUlFhASkeq+qwVRYLCPr+bfWQb2xH9XfCgcwxWToONfOxqeDwHJZDRQJ8FauoKqIk8SG7Wqo3xB1fba+PKl6f2o1tj68n0QXeaI28+gDNhyXKZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXn0Mix0RWh/zSXGmQGb61fUjia05NaZjPUH0/b5Vq8=;
 b=cdHj1BCZODW088aUcr7hcmJpENzdsy8AdMQsAMlfiyvE8qXyHRvgrTi3ZQag8lDUlaNxr1ZpFI2sJ/+iVc6Nz/sM8tt0TyY0ItlLV5re35naGqzmCK+Cqp+2r/y/YSA5NBwbCe8Bm1uaqRoPDBN3frCkuthE4HOxP786zdfxtq9b8M/ANSyI3RPEtrhjiBTx4YTZ4aiX8Dbd4/hjiViKXMQMKnmWCQp4H70/y3qdpIkKnoFglSi1hePBqmbkeQw1NSlSU0WGO1TLPdJv5tJnDbzq8dF8mzvd7j0u7q8YQRZ49Y5Ly7McfhEijs6SZ9QSpPAVDEs5293ZG10WLpjtlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXn0Mix0RWh/zSXGmQGb61fUjia05NaZjPUH0/b5Vq8=;
 b=2DQuBLSxnTEkwql3uEUJQSb0kl2kZzVoahRD0/NHk7tbIULx60S/qXMv11JIy7bSqoagbIuF+0mwz5QtilfbEUaG4CvNn1HEFKqiB1lzP8aHK3Zrzj4yn9j9PR5wEPKAMPzHWYCSV6ClrIVBZ2R8YwLTeAicbnbePXF3nErTkpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7SPRMB0009.namprd12.prod.outlook.com (2603:10b6:8:87::10) by
 DM4PR12MB5892.namprd12.prod.outlook.com (2603:10b6:8:68::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.45; Tue, 18 Apr 2023 13:06:07 +0000
Received: from DS7SPRMB0009.namprd12.prod.outlook.com
 ([fe80::5047:70da:1240:8d0d]) by DS7SPRMB0009.namprd12.prod.outlook.com
 ([fe80::5047:70da:1240:8d0d%5]) with mapi id 15.20.6298.030; Tue, 18 Apr 2023
 13:06:07 +0000
Message-ID: <30c4dc3d-dc49-c533-3af0-3d804aaf1407@amd.com>
Date:   Tue, 18 Apr 2023 18:35:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        John Garry <john.g.garry@oracle.com>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
 <21e49cd7-ee15-5ebd-7805-37d5f347635f@amd.com>
 <54083e3b-cba3-c719-651d-bf99d6eca16d@arm.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <54083e3b-cba3-c719-651d-bf99d6eca16d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::20) To DS7SPRMB0009.namprd12.prod.outlook.com
 (2603:10b6:8:87::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7SPRMB0009:EE_|DM4PR12MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: a1661bd0-dbbd-4f7f-7092-08db400dac53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZ4k1mFzT6dquTAlOwbxu8HfNPkEPQ4OAJxxVlhksaL85+J0iflzfSPLEsfCFsENXBcdILJaO1/WKfoiVt4KXZT10SisgDHwkeNDRXYVNkPM23BxOpF/3x9t0YNcjJoki7jnpKi7SYgeqHq63ym91wq45zySWwxyUsn7+JfqiINEuQ9qHnXOCSnng0f7Fm6Iue2CmTdWbDn6DS4BXu2OU+XKexHuQ9ziz8tILRpgj68JadCz4H0ldX4OlwGdCMtai1pDMFqyf2/Z91Zf/TUjtpcS2qNRMsFI1+T91QAKbm1GSL3kra2E/ebXSPrS2Ywn6MIcAK6C64My8zfGRoIgwn5RlsTUy1mw+xGuEFnTqTXvqGaHTMBFuxJeR1l+AK8tTsezLwxvr9aWJSAHhYf3lfd5mIN2hpqTx35T4b4Q7ftlTRXpaESrrUTisvw2PHgLE0Fe3FL42OQdEPN386dpRMiH2nom3N/RXnlkQiAfK04VsktNJoSK6ofI0kCPTF0eta4t5gyD76MvGoP9ae1BfMbt/luf3iKhXGfAERCaiTeDHR+53gaXo8uPDkjXjWHa1M/DRxrUHgsKeqMLFj5fytf7P+2CnFFlgrQnvjLW8pawcKApVFiao6j64HdiPTUcNKoOC79JnvJBAnRv31vrFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7SPRMB0009.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(26005)(53546011)(186003)(6512007)(41300700001)(6506007)(54906003)(86362001)(2616005)(83380400001)(4326008)(316002)(31696002)(66946007)(66476007)(66556008)(2906002)(8676002)(8936002)(6486002)(6666004)(44832011)(31686004)(38100700002)(36756003)(5660300002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tnd1eWozMG1HZDZQVWJXc0NEZGJpSVhJUnpkbk9WLzNXK2c5TkE0MmFZZ0M2?=
 =?utf-8?B?VEtCcHVZZHVqVFBaekhmb2lWZTZiU25NdTVCVmhmNmJWY01zU2pVb0EwQklo?=
 =?utf-8?B?cmRRa2pBUzNlc2dJT3JpVW1OTmpyTTRkOGFQWDBST0tod2VKd0NyWDV0R1pa?=
 =?utf-8?B?Q1BNUWZvSUE3SjVlZE5uNmRvcTVNVEh6WXdLQVVxRzRUWmxMcUc1emJ3WlZR?=
 =?utf-8?B?dW0zM0s2bXBBRytxRDNKbTRoRFdCR0VWVnJTcEx6ZTlFR3gySTJiZUFPR09a?=
 =?utf-8?B?bTVjU0k5R1E3UXVDUVpremc2dlJYNThva3FhZFF6RE9FSitNVXRtQ09GWkFv?=
 =?utf-8?B?M2EyZTUzM3lGV1VEK09QU1h5bWZDUU92NWwrL2lPczlNMHM4TzVacUhCTk1j?=
 =?utf-8?B?MDREZVFDRW9RemVlaFZ6dGNaWGlJTTY3a05rUkhZc2ZSR2IvMStFWDlYSWtl?=
 =?utf-8?B?dzNmUGMxNDByMjlQU3RJSGQyRFhhVEpjYVRUbUVyOUJyZzdtQVZCelVDQWFZ?=
 =?utf-8?B?b3dBNmlOY0NDby9aRzIyd1BTY2FNcTRpbmNZRllESi9Tdk1PYS9kMkZIbDdx?=
 =?utf-8?B?c05GK0VuS1VNeHlMMTNIK3h6dVd0TCtJa0JlZTc0YVN2eS9nOTJIem1MSTNw?=
 =?utf-8?B?Wlo0ZGtCbEQ1eVZ4NC9WZm5UVG05aFFXZjFsc2hZZkZIRVlyUDJ5blVWbWZx?=
 =?utf-8?B?WkdyV25KeGEyUmZMY0tRcGt0Kys2UjBXOTFlUlpUKzRiVS9iS2J6THZYbzQz?=
 =?utf-8?B?dVdaOXFsbXBWK0cwNUNzU3g3TGs3dktFRlZnRzVnMVd0SkJzZXpvbW9IZEtD?=
 =?utf-8?B?WlJOb0ZKZXgyU3VDaUZaY29GNG9KUGVDbHhyays5NlJHREQ3RnYrL2NQMFFF?=
 =?utf-8?B?cklEeHcrMUZIak55VTI1Y0JDS1VNTm9wYmo1dmZITHArNGtBMVZWd1NGNGJT?=
 =?utf-8?B?dlNyNFM5TzVDZkVka2VBWEUrZHRwV1pNNm5heUhJL29aemx0UHhiK1paT1Nl?=
 =?utf-8?B?Ly92RXNrdmlIbXhOZkhNa25GUkkyVzk2Q0ZZbnZ1MUU0TGVHc0p2QVhPNk0x?=
 =?utf-8?B?Z1Rlb2Nhb3ZDT1BvMFpqTnh3b3FiWWhnYU1LRVJUZ1JpdG9kS0lnWVpMNFRz?=
 =?utf-8?B?bDFBOEtFaHZlMEcyK2U0Q2ZSSkZMemJqaTNZWUw5azVLNHpxME5PUnl3KzE4?=
 =?utf-8?B?ZkU3QitIclBhNVFmZTdCcXUvSVlDcEJWWVFSZlFhdEkzU3ZscTJ4Qi8vKzJl?=
 =?utf-8?B?UTNNd1R0ZHlSeFdFT1pwSCt1TmxSSFRrODZLL05MZzA5SWlSLzRVa1lEa24x?=
 =?utf-8?B?aTV2L09FQjVzaERVMFEvaHF4QVRIVHUzUjlab1BrUGdFeVBkR2I1ZXJsS2Qx?=
 =?utf-8?B?bkp4SGpBT2lrWmF5ZUMyUzZ0eEptODlpd3BnbFo2d01vaWF2WEEwalhZaUdp?=
 =?utf-8?B?Rm8yQVBobXJrbk1NdUExT0lrcXNoaUxoQUMyUXY1SmNiUlYyVGg4QXYxeFhD?=
 =?utf-8?B?WnV0bmJibHA2VldMTEgrS0FVWU1UTkRBWUtuZjRQWFd3ckZHYkdTVWthRWxh?=
 =?utf-8?B?MXdrb0dQOXE3Z002ZlNIUkZ3b0JLd0N5RWJlRG9LdnFCWGpFbGR5NENXc0dC?=
 =?utf-8?B?ZEFxQ1RUSzVXanh1VGJOR2FQTVZwSjVOSndmMm1sQjI0TnY0YUlPNXZDaVQy?=
 =?utf-8?B?c25WU1NDTWhoam05OGM0SWJRaU1zWE13ay9UNWg3dVdxRk9WdkVGL2Z4VUJi?=
 =?utf-8?B?MXRHQUExczU1TWtFSk4zclJzM2NwK2YzbkZWYjBCM1RJSC9JZFpnS1Q0bzdQ?=
 =?utf-8?B?cUxkWTNIenBrazJkLzhoQzVFbDMwZ2J1K1NBWkV1eFE5emIvYVdadnZ3NGpm?=
 =?utf-8?B?TkNXenhjWmFidThRdFB5V2pvOWtvbVBTNlZkUklKdHlHQVNLdy9Da2x6cnhi?=
 =?utf-8?B?MWFHUFhMQ2I2NTdQc0Z3UG1MVkxKdWJ3UFViNkVOb2gwaXN2ejUxd0VGQTBK?=
 =?utf-8?B?MlVCQ1FQV25mc29JNWFwTHUybFhnSGozZ2E1SkxvOU0wbHZVSmRFOVNFNGpX?=
 =?utf-8?B?VmFCc3lIMjRYZlJjM2VvRThSWjdFRitjcWFENmcvZnMwT0JCZ01oQVdZRHJq?=
 =?utf-8?Q?IdVxqwFLiNTAMidNNVMrvHUC0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1661bd0-dbbd-4f7f-7092-08db400dac53
X-MS-Exchange-CrossTenant-AuthSource: DS7SPRMB0009.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 13:06:07.4535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvEPjgwSD5uwqGGVBqrBX6piH7wvissLdcqAdgamLP4rUfizxxLxmRa0tfxnw/x1lcRjnSTJ0JCO4KwDFTthGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5892
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robin,


On 4/18/2023 4:27 PM, Robin Murphy wrote:
> On 2023-04-18 10:23, Vasant Hegde wrote:
>> Robin,
>>
>>
>> On 4/13/2023 7:10 PM, Robin Murphy wrote:
>>> Per the reasoning in commit 4bf7fda4dce2 ("iommu/dma: Add config for
>>> PCI SAC address trick") and its subsequent revert, this mechanism no
>>> longer serves its original purpose, but now only works around broken
>>> hardware/drivers in a way that is unfortunately too impactful to remove.
>>>
>>> This does not, however, prevent us from solving the performance impact
>>> which that workaround has on large-scale systems that don't need it.
>>> Once the 32-bit IOVA space fills up and a workload starts allocating and
>>> freeing on both sides of the boundary, the opportunistic SAC allocation
>>> can then end up spending significant time hunting down scattered
>>> fragments of free 32-bit space, or just reestablishing max32_alloc_size.
>>> This can easily be exacerbated by a change in allocation pattern, such
>>> as by changing the network MTU, which can increase pressure on the
>>> 32-bit space by leaving a large quantity of cached IOVAs which are now
>>> the wrong size to be recycled, but also won't be freed since the
>>> non-opportunistic allocations can still be satisfied from the whole
>>> 64-bit space without triggering the reclaim path.
>>>
>>> However, in the context of a workaround where smaller DMA addresses
>>> aren't simply a preference but a necessity, if we get to that point at
>>> all then in fact it's already the endgame. The nature of the allocator
>>> is currently such that the first IOVA we give to a device after the
>>> 32-bit space runs out will be the highest possible address for that
>>> device, ever. If that works, then great, we know we can optimise for
>>> speed by always allocating from the full range. And if it doesn't, then
>>> the worst has already happened and any brokenness is now showing, so
>>> there's little point in continuing to try to hide it.
>>>
>>> To that end, implement a flag to refine the SAC business into a
>>> per-device policy that can automatically get itself out of the way if
>>> and when it stops being useful.
>>>
>>> CC: Linus Torvalds <torvalds@linux-foundation.org>
>>> CC: Jakub Kicinski <kuba@kernel.org>
>>> Reviewed-by: John Garry <john.g.garry@oracle.com>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>
>> We hit kernel softlockup while running stress-ng test system having 384 CPU and
>> NVMe disk. This patch helped to solve one soft lockup in allocation path.
>>
>>> ---
>>>
>>> v4: Rebase to use the new bitfield in dev_iommu, expand commit message.
>>>
>>>   drivers/iommu/dma-iommu.c | 26 ++++++++++++++++++++------
>>>   drivers/iommu/dma-iommu.h |  8 ++++++++
>>>   drivers/iommu/iommu.c     |  3 +++
>>>   include/linux/iommu.h     |  2 ++
>>>   4 files changed, 33 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index 99b2646cb5c7..9193ad5bc72f 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -630,7 +630,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct
>>> iommu_domain *domain,
>>>   {
>>>       struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>>       struct iova_domain *iovad = &cookie->iovad;
>>> -    unsigned long shift, iova_len, iova = 0;
>>> +    unsigned long shift, iova_len, iova;
>>>         if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
>>>           cookie->msi_iova += size;
>>> @@ -645,15 +645,29 @@ static dma_addr_t iommu_dma_alloc_iova(struct
>>> iommu_domain *domain,
>>>       if (domain->geometry.force_aperture)
>>>           dma_limit = min(dma_limit, (u64)domain->geometry.aperture_end);
>>>   -    /* Try to get PCI devices a SAC address */
>>> -    if (dma_limit > DMA_BIT_MASK(32) && !iommu_dma_forcedac && dev_is_pci(dev))
>>> +    /*
>>> +     * Try to use all the 32-bit PCI addresses first. The original SAC vs.
>>> +     * DAC reasoning loses relevance with PCIe, but enough hardware and
>>> +     * firmware bugs are still lurking out there that it's safest not to
>>> +     * venture into the 64-bit space until necessary.
>>> +     *
>>> +     * If your device goes wrong after seeing the notice then likely either
>>> +     * its driver is not setting DMA masks accurately, the hardware has
>>> +     * some inherent bug in handling >32-bit addresses, or not all the
>>> +     * expected address bits are wired up between the device and the IOMMU.
>>> +     */
>>> +    if (dma_limit > DMA_BIT_MASK(32) && dev->iommu->pci_32bit_workaround) {
>>>           iova = alloc_iova_fast(iovad, iova_len,
>>>                          DMA_BIT_MASK(32) >> shift, false);
>>> +        if (iova)
>>> +            goto done;
>>>   -    if (!iova)
>>> -        iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift,
>>> -                       true);
>>> +        dev->iommu->pci_32bit_workaround = false;
>>> +        dev_notice(dev, "Using %d-bit DMA addresses\n", bits_per(dma_limit));
>>
>> May be dev_notice_once? Otherwise we may see this message multiple time for same
>> device like below:
> 
> Oh, that's a bit irritating. Of course multiple threads can reach this
> in parallel, silly me :(
> 
> I would really prefer the notice to be once per device rather than once
> globally, since there's clearly no guarantee that the first device to

Agree. Makes sense.

> hit this case is going to be the one which is liable to go wrong. Does
> the (untested) diff below do any better?


Thanks for the patch. I have tested and its working fine.

-Vasant

