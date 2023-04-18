Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850996E5D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjDRJX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjDRJX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:23:26 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E163C0E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7zbuQbo/T2nKz3rFwgKfuXRh0010mMH9DmnHbCPhMZAJw4Z3PsQG7nVoQ4AwJXvpH/wrgP2xU436D+USXbENZnHHQKpZeq2mY6ZuDfi9jKz0v8itzri8EgAz7yzTixfmsR7s4I3+6/7q5SpCaNqRJkM7/xddFe10C3dfEECVt/P9fbh60R5gzmxu7NtN42BJhM2rOfDm66bh24eZ79KuV09Payq4+4OBW8wosTYHAuXnFaGIqWDSAxI2oXJ83LyvyUZ8v7u76fPdLsLu2uRWcb0S5a1/6JXymFZ+JOu2KZkOZEVo+Mmonu4M9BKTOZ+CHJV+O0p86Pgfi9v9XhSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlo76PsH9FgqEzuiKzdE7Le9Gy8NOi4ZyA6OBYrukf4=;
 b=YEWux+vEfhLJRcsUIsX/XIHF2RCuJKlbYnrOh1iKUVoxgQrZ3idGwIN6DjHoC8KMfIl4EeQa0MFD3cidmvDpU6bYplieCPsYEtvUS8V12IWAnyUd3p0pmfa4eBfzv5+XDE36GmrVa3YYit9JhWWoqqSusECydgepwmHYU2wSLlSba6PS5t16lq+8DJ9FvUfeY5yypKOcnnu25VQAqMeaqXJmBta/NGuJB4JnEXDhIPdnSm9v+JRHyvNPpesD/KJbywPqAD4+qq7A93Kq0HFvZFxGF8lzqt+0lOao9pJncBlfHKARKEbKaUt/EBpdx2C+R+21/SpiFmmj/rAMiVNJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlo76PsH9FgqEzuiKzdE7Le9Gy8NOi4ZyA6OBYrukf4=;
 b=DbHeWuX4NKV1wCQNwLv7yoO8iK9gSQbiUbeBnQuxdESxe3w/SykRFSodl3poBD22GgahUUOjo6bI6IU/gWessuIqqrtHXjDb3Elazcq9InvO1/FQAcXI24uOhJ9awHl4DJ8nXMPhmxPLihw1C6wBxW6p5sPocafts7UHEYEEuvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7SPRMB0009.namprd12.prod.outlook.com (2603:10b6:8:87::10) by
 SA1PR12MB6946.namprd12.prod.outlook.com (2603:10b6:806:24d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 09:23:22 +0000
Received: from DS7SPRMB0009.namprd12.prod.outlook.com
 ([fe80::5047:70da:1240:8d0d]) by DS7SPRMB0009.namprd12.prod.outlook.com
 ([fe80::5047:70da:1240:8d0d%5]) with mapi id 15.20.6298.030; Tue, 18 Apr 2023
 09:23:21 +0000
Message-ID: <21e49cd7-ee15-5ebd-7805-37d5f347635f@amd.com>
Date:   Tue, 18 Apr 2023 14:53:08 +0530
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
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::31) To DS7SPRMB0009.namprd12.prod.outlook.com
 (2603:10b6:8:87::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7SPRMB0009:EE_|SA1PR12MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c13396-8e70-4ef8-8753-08db3fee8db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+lHeehiz24lGzLt1cS/Em1/5cx7VP+HmhlBXhvu6b34KephmznwaiEYsrdUulIMQPjO/IFiXBI/gtlXWAmQRl0zcQjhq13Ut2A9cFt/BATfpdd/Jrr8lrghLdiI2lnN5ZBhkdn75bPHLSpKdfl4fNdHGg5IpQZkcmj0bF7BeOXz1YZS7zhEn3JOxCc0TnpqTVz6Ui57Q9/L7XSBe4JLnXZcLyhXH+8aUdUSgl2W+yCzkjrFyMPBmlIis26rmc3lrrXlLPs+GEMZPEvtHv7NWYr8XMy9XD6JAkVizFBYyVjWYDsxJHI6NT5Ls82xU9w7hLnpu579i+ET9IIRju8D6OZSNpigEjHZ2GLYyiSZGy27D7jECsFWgC1/GLxh1jnVbthhqQRlGnHbBUg/zNt2bYT7ckYBtcuh7l+59sdZlsEVFExqHQ2kZylKx5cyLIhy1JwNrOLo2Dqfjn8ES/JfdJnLapxT//iL7nhTxELkCTQKPyGF6nb2FlkmCk8dGx8W+HWQnK5pruxoRE1fSJVA4zJzWJfUvhfDk034v9FtNHlX4CDJRMokNNhcTYKwUiGjG37+gqoosBwv84pATce1UvhoKuhnQUFkl/H1sXLaA34gyq85dJcEdHjvUz0yrwYMCzesQIANRJBpmO9rMKUCNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7SPRMB0009.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(478600001)(6666004)(38100700002)(8936002)(8676002)(316002)(41300700001)(4326008)(66556008)(66946007)(54906003)(66476007)(186003)(2906002)(53546011)(6512007)(26005)(6506007)(86362001)(31696002)(83380400001)(36756003)(2616005)(31686004)(5660300002)(6486002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L09tZmJkSTd1WXJvbEI2aHZhVk5mTytWRTZuTG5qTS92NXV5a2VnbGQ5TEky?=
 =?utf-8?B?cGhEZUYzOFVicWZMc256OHR1cXowRk5jbVJhdW1WdWgyajgzV09aTkNsalNX?=
 =?utf-8?B?bzdUWFRYL0VHNkhmbkd5ZVhodW9zcjBYbWNaVURqUmlYN0NCY0JEaklSb1lr?=
 =?utf-8?B?WlIyQ0dOM01CYnU0dHRTUjIvYjEycEJQb29TeElYMnJRNkN1dVozTGt4ZlR0?=
 =?utf-8?B?bEMzK21reThITTNSenJ2a25Lb1NzNy96Sk5zNVRpQzA0bGtvSFVvc016SVJZ?=
 =?utf-8?B?bmZYZm5pTHZ3NjUvdDFaMDhlUFF5YzMyLzRMRFZVdXA0S1Q1M0t1U2RGdThn?=
 =?utf-8?B?ZXhSMWkwSGJCcGsybnZGNC9GaWMrbmYwS0ovczN3YllMRWNQVkk4U3NHQkFp?=
 =?utf-8?B?WmtPN2x6ZlgweGQ2NWlsU2VwT3dmeGs0ays0UlJBMjhqV3k0UHFhd0ZtTUc0?=
 =?utf-8?B?bmdVMGM2SGV2cDBySnh3dmx0aEZ4NUNENExEU2V1aFEzVElmQXhpT05SWFV6?=
 =?utf-8?B?aEJGNlVXbitwM3gxalRmV3BlUXFJaXZOODY5UkIwYnUxeDJ0YjIvcHgxS3Fm?=
 =?utf-8?B?TVdiWHdaeWRiekdnTUtXQXREb3lST0ZnaTl3TDlGUnRTWFZzR2lkbGtqeXQ0?=
 =?utf-8?B?dkpPNXRmbk1XaStQeUE5RWljM1YzZlp4TmNkVnJJY3JPOFlwL3FaaHd4YzUx?=
 =?utf-8?B?K1o2UTZuZWFETzlEV1FuczZvK2N4OU1sUTlNSTlVOFZPSS8vZzZNdC9PcGxR?=
 =?utf-8?B?QzRQWlpOWXg1bFQyc2VGNWluTDBRZVIrejYwUklkc2RRWDBLZW1WUkQ1d2ZJ?=
 =?utf-8?B?KzdHUEVPQi9jcmNKdmxrNlhZMTlhVjNCN0lHNXRTT3NaZFN0bGJxSlNsOC9q?=
 =?utf-8?B?eFdzZjVZRS8zNGdMY1FrVzhqd0VvN1NMa2FTRm5ORDJhK3ZpcElKMER0M0cv?=
 =?utf-8?B?c2dpV0dSQWJJOEkwVHFTZzJBUDRaUSt1T3o5dHh3SDdoY2IvSXBkOHRUc0V3?=
 =?utf-8?B?cXNLZko2aG1Jb3JVL3BXZ0R2UW5aZVhIVFQrb3RHQmI5QS9MR1NuQWVUcENB?=
 =?utf-8?B?clBDVnZsWjlTaGdEaHo5TU14RXBHbHFQVm1xbVJFbnJZZXhvSXNCa3cxdyto?=
 =?utf-8?B?a2FwMkoxVlE4TDRIOHRyUWs5OUttUG1lMmhxK2p3bXhQdEE5bDFadWF0M3ZL?=
 =?utf-8?B?bzloVnh2WTQ4elE4bkRkL3duTVNPeTk2WWNobnBVeFVLcng4cHMzZWlLbzFk?=
 =?utf-8?B?STQ0blFHL2FhWHorZ3BIbkVMdWhLRFdwMlhwNzR0UG9mWm1wVG9YcGgvdTA2?=
 =?utf-8?B?RURtcUVIc3dNYjBteTc5cW5UNUpYOUVYWFQ1YTNZS1NBRTVKVFBoR29vOVVq?=
 =?utf-8?B?eGJ0ODdlQXZjcFZZWkk2cmZZTmE5ZVBpcUR1V0NvYllYRjhWcmZNUmxZM3hh?=
 =?utf-8?B?QUE0S1hNL1didDZhQ1BzY2pLQU1yS2tkd2M4U3dlRVl2UEFUVHpnVHFScS9x?=
 =?utf-8?B?V2lXb1ovZDd2ckJ1ak1rMVk1NUg5aWJWTFBXNHBKS1RZUktQNUtmUEpMY04r?=
 =?utf-8?B?bnk5a1Q5UkQwcWpwenBJMVZsWENiUGZEb1dNb3dxckdZWHF2Y0VXK0pLRTVn?=
 =?utf-8?B?ZHZ4KzNuQjk1SDVmdW9OQVdMNmlKdXQzZ0dGcUhUcHlBVFBtVXJaRjdUN3lz?=
 =?utf-8?B?eXJKL1ptQm5VT3V0VjZ5RlR0NnE0SGJUT3V0N0ZycGN0VVBOQ0ErakdpUmlB?=
 =?utf-8?B?dWtyTGdsT21xcW5Rays5Rmc1b2llOUloRmtxVnIyWWF5WFVwMHVUM0VJM3N5?=
 =?utf-8?B?NEpDWmlJMXZBa2twWStSbHBmUGVtK005UnJXeDV6ZUI5Sis5TDJhY2xBVzdB?=
 =?utf-8?B?NHk5bUt6UUZCMkRjUUNPUnluZ1JUZERZVGJXSE5wQmJxQWJaWHBsY0lOQW0x?=
 =?utf-8?B?enNEZmt0MHRRdnpjYmowclhKWjBWdjBRSzRGcThhL2t6M2lXYlJsY0FqeWhl?=
 =?utf-8?B?K2k1Nkw2cVpTWlAyUElQOFN0ekltTjNGKzVmWWpJZndHc0pZbU1jUnRIOUlQ?=
 =?utf-8?B?dHFGbW5xck5UTitVUmRqa3pybDB0Q25MNVdXZ2ZqaFppeU9SbWRZelYvTWlQ?=
 =?utf-8?Q?NvJgoCi8m1HqxGPU+Pv514Fw7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c13396-8e70-4ef8-8753-08db3fee8db5
X-MS-Exchange-CrossTenant-AuthSource: DS7SPRMB0009.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 09:23:21.6552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Onqr1tExBRxAhKN9J7PORLQNcwtqxKfkJI0UFjE5AZtxEd6vbzPgDsDKYwvFStQRC50HRzfhr4Onc6i7Mfrsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6946
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


On 4/13/2023 7:10 PM, Robin Murphy wrote:
> Per the reasoning in commit 4bf7fda4dce2 ("iommu/dma: Add config for
> PCI SAC address trick") and its subsequent revert, this mechanism no
> longer serves its original purpose, but now only works around broken
> hardware/drivers in a way that is unfortunately too impactful to remove.
> 
> This does not, however, prevent us from solving the performance impact
> which that workaround has on large-scale systems that don't need it.
> Once the 32-bit IOVA space fills up and a workload starts allocating and
> freeing on both sides of the boundary, the opportunistic SAC allocation
> can then end up spending significant time hunting down scattered
> fragments of free 32-bit space, or just reestablishing max32_alloc_size.
> This can easily be exacerbated by a change in allocation pattern, such
> as by changing the network MTU, which can increase pressure on the
> 32-bit space by leaving a large quantity of cached IOVAs which are now
> the wrong size to be recycled, but also won't be freed since the
> non-opportunistic allocations can still be satisfied from the whole
> 64-bit space without triggering the reclaim path.
> 
> However, in the context of a workaround where smaller DMA addresses
> aren't simply a preference but a necessity, if we get to that point at
> all then in fact it's already the endgame. The nature of the allocator
> is currently such that the first IOVA we give to a device after the
> 32-bit space runs out will be the highest possible address for that
> device, ever. If that works, then great, we know we can optimise for
> speed by always allocating from the full range. And if it doesn't, then
> the worst has already happened and any brokenness is now showing, so
> there's little point in continuing to try to hide it.
> 
> To that end, implement a flag to refine the SAC business into a
> per-device policy that can automatically get itself out of the way if
> and when it stops being useful.
> 
> CC: Linus Torvalds <torvalds@linux-foundation.org>
> CC: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

We hit kernel softlockup while running stress-ng test system having 384 CPU and
NVMe disk. This patch helped to solve one soft lockup in allocation path.

> ---
> 
> v4: Rebase to use the new bitfield in dev_iommu, expand commit message.
> 
>  drivers/iommu/dma-iommu.c | 26 ++++++++++++++++++++------
>  drivers/iommu/dma-iommu.h |  8 ++++++++
>  drivers/iommu/iommu.c     |  3 +++
>  include/linux/iommu.h     |  2 ++
>  4 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 99b2646cb5c7..9193ad5bc72f 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -630,7 +630,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>  {
>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>  	struct iova_domain *iovad = &cookie->iovad;
> -	unsigned long shift, iova_len, iova = 0;
> +	unsigned long shift, iova_len, iova;
>  
>  	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
>  		cookie->msi_iova += size;
> @@ -645,15 +645,29 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>  	if (domain->geometry.force_aperture)
>  		dma_limit = min(dma_limit, (u64)domain->geometry.aperture_end);
>  
> -	/* Try to get PCI devices a SAC address */
> -	if (dma_limit > DMA_BIT_MASK(32) && !iommu_dma_forcedac && dev_is_pci(dev))
> +	/*
> +	 * Try to use all the 32-bit PCI addresses first. The original SAC vs.
> +	 * DAC reasoning loses relevance with PCIe, but enough hardware and
> +	 * firmware bugs are still lurking out there that it's safest not to
> +	 * venture into the 64-bit space until necessary.
> +	 *
> +	 * If your device goes wrong after seeing the notice then likely either
> +	 * its driver is not setting DMA masks accurately, the hardware has
> +	 * some inherent bug in handling >32-bit addresses, or not all the
> +	 * expected address bits are wired up between the device and the IOMMU.
> +	 */
> +	if (dma_limit > DMA_BIT_MASK(32) && dev->iommu->pci_32bit_workaround) {
>  		iova = alloc_iova_fast(iovad, iova_len,
>  				       DMA_BIT_MASK(32) >> shift, false);
> +		if (iova)
> +			goto done;
>  
> -	if (!iova)
> -		iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift,
> -				       true);
> +		dev->iommu->pci_32bit_workaround = false;
> +		dev_notice(dev, "Using %d-bit DMA addresses\n", bits_per(dma_limit));

May be dev_notice_once? Otherwise we may see this message multiple time for same
device like below:

[  172.017120] nvme 0000:41:00.0: Using 64-bit DMA addresses
[  172.022955] nvme 0000:41:00.0: Using 64-bit DMA addresses
[  172.028720] nvme 0000:41:00.0: Using 64-bit DMA addresses
[  172.031815] nvme 0000:41:00.0: Using 64-bit DMA addresses
[  172.031816] nvme 0000:41:00.0: Using 64-bit DMA addresses
[  172.038727] nvme 0000:41:00.0: Using 64-bit DMA addresses
[  172.038726] nvme 0000:41:00.0: Using 64-bit DMA addresses
[  172.038917] nvme 0000:41:00.0: Using 64-bit DMA addresses
[  172.038968] nvme 0000:41:00.0: Using 64-bit DMA addresses
[  172.038970] nvme 0000:41:00.0: Using 64-bit DMA addresses
[  172.039007] nvme 0000:41:00.0: Using 64-bit DMA addresses
[  172.039091] nvme 0000:41:00.0: Using 64-bit DMA addresses
[  172.039102] nvme 0000:41:00.0: Using 64-bit DMA addresses

Otherwise patch worked fine for us.

Tested-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

