Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5173466DE64
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbjAQNLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbjAQNK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:10:59 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD27241DE
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:10:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMsEeZI8qCeRfvfDxFXQ3wTghDv9ljSHpTHjaAqVJsq51ZUVANuI0XandzA074KJgSGiBdmYZFE+K3nZpr7JzZrvjB57pWJ4awQ64vFr/GKEs6CEuNWnJ7OOdVWn9Xd5P2DuZENv5r/xGsTBqOp9kbe+6e/8ROk7a7gkjapXFEyL6gk8LiZF9MR+zl+j9QGl4E/n6ys7AplqPcl5mdHfTJbkhboLvpWlTBMWOk3GYwvV9AFR1pBjfL44vsT1rx1q6Mfhk7KLUKh5/PPDILqb8WlFqpGQ0dDs/E87Jmno9VTP4Aakuk24Jd4mSQKvS226NuE7EfwdhLOaQTX1jF1vGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjN2jfs+UaO0xFDWl2pRW1rpEzdBMc5RygdVeLdu218=;
 b=H6f/t6nCY3vvMIOkTwO9csN7K955FJezW4Iuk/pxzDc9Ck10PlF6RmBI7LrwI+wc/TT7Y0LUFgyUC/3L78KQV2sx1CuAa8rrsEOa6LQ7sNRKeYdV/uAgYzi5wE5ZyzEb0Dt9si9A76CUs5mx1N7O06DQlEc/uqm1QaTSqYdQB6hSfYrQS9NROv/zH7Jy50SHLry1LA54kuqeNWu8WSecFKJz3+Ri0fr4B0hBdlfDP+/+Af/kjxGPaIkJ+LWFI5QqNrLF5fHGU1xU4IPWNJ9dqL0Kc6SvVG2yvA6AOOX6+sTY6dj1wsnz2BA+WsQhcTgDZ4Qtpaxll+DwbuCBQpXnTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjN2jfs+UaO0xFDWl2pRW1rpEzdBMc5RygdVeLdu218=;
 b=vTHRIvnMbNCO9NilQ3Fw7OfEYf54bIFFNrpIusofgSPP5rmdHWyFr6TxYOmaySQlb/GIIUI/YWnJ4Z92Wl0JONYzadd458xac6K9DR1FtuLJy9B+Crwz1R2Kw8yT+gjdFBpQkcmV7/PX8vmZ8/2q8OPYiAXC/wQ/JjM+6kiaGew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 13:10:51 +0000
Received: from IA1PR12MB6481.namprd12.prod.outlook.com
 ([fe80::a5ce:541c:39fe:9370]) by IA1PR12MB6481.namprd12.prod.outlook.com
 ([fe80::a5ce:541c:39fe:9370%5]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 13:10:51 +0000
Message-ID: <209a6ebd-b83c-d1c7-7e36-c109b09779f3@amd.com>
Date:   Tue, 17 Jan 2023 07:10:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/4] iommu/amd: Force SNP-enabled VFIO domain to 4K page
 size
Content-Language: en-US
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
 <20230110143137.54517-5-suravee.suthikulpanit@amd.com>
From:   Eric van Tassell <evantass@amd.com>
In-Reply-To: <20230110143137.54517-5-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:335::11) To IA1PR12MB6481.namprd12.prod.outlook.com
 (2603:10b6:208:3aa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6481:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: f27effd6-c37e-4e5a-8017-08daf88c423f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPlKhGwfFD0eBRW+s3Rxjb/lV7X8KqpQPXZgaq2wya/dPvIRegjmZlEOGH6doKTroMiUzI/lDTOkYOi+8emekhgGQD5Miy8BqmUtYHtYwmSArX6ZzEc4hNHkecrHmIx/KLpvzKh0HoeL1a6xlIwzlqiAhOuG2j2f/5UrGsBINq2a0uYk0HiW8C1A5aE20XFQNFd8fFc4GSXBeLSRAdqUBm/u5uw8fdIaj/cOjnkkRXu5bfszTTqaDUURgIQ/GGm7Y5mjjUeJxzs7WIP2KkNz4MLAT3F5K7hhmCIHja7rslXijhu1QAW/Oh34bciJw1Y7CiWzqafOn9HNvMsR1ntFqsvnWjtnZkzNiYiAP++Qrodm13E0Evb6CHRhfUhmiY1eKJy1+ZD/DPiRYEcb6eb87zb+ljk42gA0lK0RHiUAuS2/v3MQ3KASVlmOslkLj9MsQ/c2wjF5jtOSDYlbM+E0aRgAHa9y3iCE8Nn327SHEsWrKj82BUEDr0jTUeqVAXy972M0rQ40csPNi2lsQqcBMQMwMV/FmmIILtdPQzWgN7xB0b9YWRZmQfE03pbxu0uz6Q47T7axTtgI/fHohtPAPoZFF76INZ29B4o6rAdB4tAe5+Q0De61mRPD+a+WGllh14mtfgu9Es6SQd41jkYilme15q0781uRTjYBPR9YdfM3GLOXkc6ppMJ5SVVS0cfvkoktaRQQFD8Q7T8AA6XNEsIe+2DQnEw5lInlhWEhitI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199015)(31686004)(36756003)(8936002)(8676002)(66556008)(66476007)(66946007)(31696002)(2906002)(5660300002)(38100700002)(478600001)(6486002)(316002)(41300700001)(53546011)(2616005)(26005)(6512007)(186003)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0dyZEtkSHA4cnRxRHB1ejNKek1pMDBEMzEvY1BwSkNPR0M3blhZM3l0Sy9I?=
 =?utf-8?B?SlpZNDFpVmwwYm1UVTBna0xLVys2b3FIZ3ZQelM4eE95WWlDNEZMV3Z3VUNG?=
 =?utf-8?B?YUVHSzRuRXNBd2ZlNnI0d1NPaDF0Znhidi9lVHAyWE9ZR0o4Qm9KYXdyeEJL?=
 =?utf-8?B?b0MzWjFJVE90MytkSEhqeGJsQ3dhZHpvVjRvWmhRVFVocWc1N1licVNQdzV3?=
 =?utf-8?B?NkQxTWc2N3UwWnBESkJPelE2YzFJUCtyK1R1TGJaMmRIaXNvNmN6U3NEMk05?=
 =?utf-8?B?NTVMQWFaWXl6bHJRSXRMU05TVGdzQWhGUmI4TEtKRW1mekRNeVhRb1YwWEo3?=
 =?utf-8?B?QVJ4YU9xOTVvL0NHSEpONm5QakR2a1Vrc3VzMGlNRGNmSnVJUjNyTTBVQ1ow?=
 =?utf-8?B?WDhnQldBZ3NqUTBUd1BlK0JTNUxITG1QWmhDckJPd2hRcDh1b2MyMFh5QjEy?=
 =?utf-8?B?MVV1b1dkdXluMy9QOUJ0dmZyTHNrV2JwNEFldkR4N3pvVHRnVmdXc1dPMi81?=
 =?utf-8?B?eTJxTVRva2Npd3N4V1hvZDJRTmE5ZlVnbUxCL3liOHJnbGVPMFJDcFlDOE1r?=
 =?utf-8?B?c0xPdm1PeFFLVE9xVHhXbDZxK0V4M2h6eVg4NllJK0JobWk0L1Q0cjcxY0JP?=
 =?utf-8?B?SzBPOXdwMlNWNlFTcDEwSkM0ZlJVRW9XU1crL3lWZndmMXQ1VTRTenl1KzQv?=
 =?utf-8?B?NW5kTXhwT1h1SG1vVjZLeVI5aU40OHBXRjFLeTk4VFFZb0F4SzljNVg3bjBL?=
 =?utf-8?B?Ry9UMkQ0OUdTenNHWGlCeTJlM3FMUlQ5dk5BQTJkcGM4ZnNsS00yT05SOEVF?=
 =?utf-8?B?QjlmTXNiQURpbFVINnl3UU1TdVFYS3FpOWdoRmFUOXFpcitMbVVNV2RBclBu?=
 =?utf-8?B?TzN6Zm5qQmRyRWk0UTk2UGdjWGp6MlVtUzduajBqVzlCZlZCL3lyR2M5SXcv?=
 =?utf-8?B?RWsyOVRBZFVJM2FrMEs0QlR3RG1xWTE5YWNjVm41K3JmcHhlR2dDSXNXcTVD?=
 =?utf-8?B?YWlaVldnclNkRlV5a2ZTVUNYZ1BST2tqQkZKRW8vckNiRkJ2VUx4b3pWZm9N?=
 =?utf-8?B?SFZiS1NtZlBLenhwUWJLTUxCeDloN1UxYUN5MWxIN2dDODBIQTNQVUpmVEhx?=
 =?utf-8?B?WVlsNEdmdFdxZHczcHprdmQ5dHFTUmxTM29EcnZZaTJ3ZVJZVDBYeS93WFFl?=
 =?utf-8?B?enN3UkZQRnVzMHdkMitFb2xqelpyK2RKTTUvWmRVMlBZLzcyMUlhU2YrOHEx?=
 =?utf-8?B?NzNZZ1lFNmxqdURYNHQ0cXRqT1ZjL1JVY1NZVHdreERWUHVDUXBVTU5GUjBy?=
 =?utf-8?B?alFLTy9CWXBrd0tVdEQ4Wnp2Z2RYcUNKNk53dzRlUlFTYms3emt6SFRPalg2?=
 =?utf-8?B?V3hRcGtsNXgvOHFXTGQ4N3J2MEpObk96RmxzVStlZmZVUzFoL21tV0loMG90?=
 =?utf-8?B?MXNvN3NSL0ltc2VwdmRTbldYZE90UEhWYlhaYmpwbXNwNVQrKzVwWGl3dzhV?=
 =?utf-8?B?NHBaZFExWnRvd0M4c1BhajlJSzg4QjN6MGhLVTBsMmg2YjlFVDQxSUhQcmlX?=
 =?utf-8?B?d3hIcVNHSVlZUTJER3IyMk5vNEczVjZHbkNFajZjUFVxa0FDUmhKQjd6S20w?=
 =?utf-8?B?NlRGWStIdnV2SU0rL1IvSEdpNGxFT1BKUEJvV2VMK3l6UHpJWXByQWlSbWxB?=
 =?utf-8?B?eEpQZXE0Lzc5RUdQRUhma3N0YnMzdkZocWhZVkEyWC9RZDFyN3pFS3F0QjJ6?=
 =?utf-8?B?T0tCcE1yQmlBVTlTWUttUFpDMWJkN3lQZURJb3UzbXhlckFOTkRtNm4vanJk?=
 =?utf-8?B?MTY4TEs1SHNRUXVDaEtkUUNEa1NIclV4R1lpdHUwWWhvKy9UcTA2TTRvWkFC?=
 =?utf-8?B?VGRaQStUZERKVmpGSm5qM0Z5elB3TEJ2OVdOdmw3SWR2eFJMZXFBRHdXWE9h?=
 =?utf-8?B?aGEwYjhwTXBpN2NzTko4NkkyQW5OY1JENTdpS0YwUTNFZ0V3bS9IbUtMR2Jv?=
 =?utf-8?B?dlZzNlZQKzZLUHdrRUIxMFhnNEtITzNjQ2ZLcFM1bGs2Smxya2tjbkNtamlj?=
 =?utf-8?B?WHBqUmxmclN1MnAveXgwVGpNTHcxMVMxd3o2VldvRGM5UzRQQVliWk55bnF1?=
 =?utf-8?Q?9ZkPVCmOhn03SNTP5ClBmSDNW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27effd6-c37e-4e5a-8017-08daf88c423f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:10:51.8143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+M9PSEHPzVRqxrE7wBWFmx72cpDIrV5XCTEglRsEDnLzo3ABa+6ZiLC/RSkhuinDiUx9di4BgV1RUGxhRqXEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/10/23 08:31, Suravee Suthikulpanit wrote:
> SNP only supports 2M and 4K page sizes. Other page sizes requires
> page smashing to supported sizes. For SNP-enabled guests
> with pass-through devices (via VFIO), it also requires RMP and IOMMU
> page sizes to match.
>
> To simplify the support, for SNP-enabled guest, SNP will smash guest pages
> to 4K page size only, and IOMMU driver will setup the IOMMU v1 page table
> for the VFIO domain of the guest to match the 4K page size.
>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/amd_iommu_types.h |  2 ++
>   drivers/iommu/amd/iommu.c           | 28 ++++++++++++++++++++++++++++
>   2 files changed, 30 insertions(+)
>
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index ad124959a26a..5249ac18ce6e 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -279,6 +279,7 @@
>   #define AMD_IOMMU_PGSIZES	((~0xFFFUL) & ~(2ULL << 38))
>   /* 4K, 2MB, 1G page sizes are supported */
>   #define AMD_IOMMU_PGSIZES_V2	(PAGE_SIZE | (1ULL << 21) | (1ULL << 30))
> +#define AMD_IOMMU_PGSIZES_4K	(PAGE_SIZE)
>   
>   /* Bit value definition for dte irq remapping fields*/
>   #define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
> @@ -440,6 +441,7 @@
>   #define PD_IOMMUV2_MASK		(1UL << 3) /* domain has gcr3 table */
>   #define PD_GIOV_MASK		(1UL << 4) /* domain enable GIOV support */
>   #define PD_VFIO_MASK		(1UL << 5) /* domain enable VFIO support */
> +#define PD_SNP_MASK		(1UL << 6) /* domain enable SNP support */
>   
>   extern bool amd_iommu_dump;
>   #define DUMP_printk(format, arg...)				\
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index a03723930f70..9a1b010a7d00 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2422,6 +2422,33 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
>   	return true;97921e769dda1
>   }
>   
> +static void amd_iommu_set_kvm(struct iommu_domain *domain, struct kvm *kvm)
> +{
> +	struct protection_domain *pdom = to_pdomain(domain);
> +
> +	if (!amd_iommu_snp_en || !amd_iommu_svm_ops ||
> +	    !pdom || !(pdom->flags & PD_VFIO_MASK))
> +		return;
> +
> +	/*
> +	 * The parameter kvm can be NULL when calling from kvm_vfio_group_del()
> +	 * and kvm_vfio_destroy().
> +	 */
> +	if (!kvm ||
> +	    !amd_iommu_svm_ops->is_snp_guest ||
> +	    !amd_iommu_svm_ops->is_snp_guest(kvm))
> +		return;
> +
> +	/*
> +	 * VFIO Domain for SNP guest requires IOMMU and RMP page-size to match,
> +	 * which can only support 4K and 2M. Currently, only support 4K
> +	 * IOMMU page-size.
> +	 */
> +	pdom->flags |= PD_SNP_MASK;
> +	pdom->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_4K;
> +	pr_debug("%s: Force domain %u page size to 4K.\n", __func__, pdom->id);
> +}
> +


In my opinion the name of this function is to generic and doesn't 
describe what it does.

I'd prefer something like amd_iommu_set_4k_pgsz()


>   const struct iommu_ops amd_iommu_ops = {
>   	.capable = amd_iommu_capable,
>   	.domain_alloc = amd_iommu_domain_alloc,
> @@ -2444,6 +2471,7 @@ const struct iommu_ops amd_iommu_ops = {
>   		.iotlb_sync	= amd_iommu_iotlb_sync,
>   		.free		= amd_iommu_domain_free,
>   		.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
> +		.set_kvm	= amd_iommu_set_kvm,
>   	}
>   };
>   
