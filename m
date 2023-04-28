Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9435B6F1146
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 07:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345189AbjD1FVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 01:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjD1FVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 01:21:01 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8482710
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 22:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6OAvmvT533lykKxhWNTuX9jf67AM7IsF34rgq+aWlXb+w73zmvRjsbNZJhedUPkpXCW+djyMO88L4aO29yx6BJuk9krrek6RtW95u1HVwKjFw8ERaOFRNpmOif3EmHEOR6NXc69nOBzwKEX2Rv2p+D0/LQa8RTj2VLgcgsjIJu10/ztK+lXHGKJY5Sr0DIm6TwUvsk+n909zG2VuYgPkbjnCWQVIWC2eWDI772bxyPYIOgCLkJqDywlmCO9A5AeRpDgelpBHC0UinyrWeXsggK9Ycgm5a03lzTVPmuAneZWkHxkqdk5oSitOQzGdTVKAMfCRTlZK0F6C+NaoivG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAlQQQWRmyd47CWTX5T3qO8/zIv1vQ/I+PxZGe3TwBM=;
 b=BgpUL01IvR5QVh6PHNKfNGfv/f5wXM8728tzvfk4KRxO9apvX9FQZ2WV7ROCiAgRUUzvY5/0ByaLzHsCIvreQhAydH9cBqQucMCMhKFpc4qJaYaxWuMLZs2lLu/DI9oL1Ghhg/pCqdOY5wyZrnUCjf1C09xsV1gruCJtnaIPudSNjtQV/q6hrnxxOJ53c5iqK/j8OB/CXBDPjmxSDFw99LwmCymspyq3B46MspReV9kDvgj7vicwdwbFt5VvFCKbrf5TCIEOr4Tdawln/kpaFv91uOw6Z1i0GCpZCghkAQQN895rsQlucCOFCs1ytXiTRtRd6IIrsHpnDZG7nS0GTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAlQQQWRmyd47CWTX5T3qO8/zIv1vQ/I+PxZGe3TwBM=;
 b=de7Kmj4q61ap/HAx0GoX64qYPMh2AvnuBe7Y3OmO3An5hJl/BQ1OS3FBwnGgDCqCbG+xCd+qle/zzZDIBHNvBEgD/1J7WdabTXf6HJBKqXKDh6t+R3uyeiSAH0erzBcTTWkQ3Rn2VSmQrlYsuvExgHw1BrrCMqNbiDv1Fg3Zsmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Fri, 28 Apr
 2023 05:20:54 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::1891:71ee:fde7:4e1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::1891:71ee:fde7:4e1%7]) with mapi id 15.20.6340.023; Fri, 28 Apr 2023
 05:20:54 +0000
Message-ID: <4b87dee3-fbdf-6057-f2b3-71376a13a742@amd.com>
Date:   Fri, 28 Apr 2023 10:50:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
Content-Language: en-US
To:     Jon Pan-Doh <pandoh@google.com>, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Nadav Amit <namit@vmware.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sudheer Dantuluri <dantuluris@google.com>,
        Gary Zibrat <gzibrat@google.com>
References: <20230426203256.237116-1-pandoh@google.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230426203256.237116-1-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: 054c11d5-bf9f-450b-9c21-08db47a856b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZHWGSloXBF2R8W8qiU6B2hcjSzi11NABTCIjPd8zIi+KBy/I0J3NR2QOtKhrTgkXtc8zb0k/z8sa5W8hjjCEFV4gkaEnZIMHnp2MrmC09nOD8du8AvRwrCFX3Gpfxj2foZDSjR/6a2pb8fR/o5QCVVTZAZjJA0L8MqfTHtaZ9Mi3pk6CxLQdkUSY2mtT85oH5HWwOR9i32dyDHXET2yvzWoIaOa5TPvkuyBnKVktxDtmhpZJNneYUv3349Oi3T8XuvzKrRxBZd3GRpvaGSnqX33+JivEGfcU+yEdk48bhq+SWXtWbhNPnXkQ8leL6scHd52iqQC6c3nWtmX1vdKYlV13qrqd8twDIK0ypAlguuDbO7hEp5nD5sKc7TykueYr4cGYESet1Tug0/E5SseA2uMteBvVdiqr3aBdkqUjwWNN3azA3UrO7QjRkoui+jJ1RO5Mn/5r2oVW1595Z+fTU4Q3g9KbnzSbnHQCraMAJL+J/aJaudnOGtF7DYZ9BomDbSdFPVZ98erwb70M/O4MrWX3cmliZOnhil8zahJjdWUuGhpsDsCp/dsRZTNRYa3jBgLrjyt1R4hToVZpklFVqn8MZQ/cjDml9ImIB/GrPbqpPj5/ijBh6cgahaUZQhkuTu9X8RmGEA3d3v/OXDtZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199021)(316002)(2906002)(4326008)(66946007)(44832011)(66476007)(66556008)(8936002)(8676002)(41300700001)(36756003)(31696002)(86362001)(26005)(53546011)(6512007)(186003)(38100700002)(478600001)(5660300002)(6666004)(6486002)(31686004)(83380400001)(2616005)(6506007)(6636002)(110136005)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTJhckE1ZzlKMWxNQ2lwNVhzcmVMRXlpL1AvcGhMQ2ltNEJ4a096bS9FY1F3?=
 =?utf-8?B?T1ppekdOK25pS0ZPdTlQQ01FZzJVNHFxWnRzRlVwRmpZZnBUVEFxZ3Nkci80?=
 =?utf-8?B?WlhaeENrWnBrZkdHTm01QmtING5hSzJvaGVraEQ4clhzSGptbEZCYnJ2VzM5?=
 =?utf-8?B?cGkwSDBsQWhYL2FGeWxSeDhQTzhnYXcxcTlnRUFISkYwUnlyUHNReUE1cnQ0?=
 =?utf-8?B?bXpuS0ZwWUR2VFRuRHJsclZoV3V4b21oeGY0M3psM0xHeW90V1htaGorZllt?=
 =?utf-8?B?UXNrV0QycTRYYnpjUDZQZG1TUEFuQnMrYS9ZcWIzTnhmQ0dZN2FRY05qNFps?=
 =?utf-8?B?ZG1kWWx6NGFOdytKUWVsVnFIRHFnSXpxTElXRVQ3V0tmc0VDUC9NS25Ta0VK?=
 =?utf-8?B?YU12SUk2T2NsMU95R3N6Y3JFRkUrNGxha2NHRHZqeUZ3bUF4a2VCT0drK0Zt?=
 =?utf-8?B?R0Z1c0JQbWdMRWt2RGpMN3NCQnJZbGlYcFZQZnMyMGxtL0grS0JEdmVpR2F0?=
 =?utf-8?B?UUZ5QndBM3Q3SjVuYjliV3FHNHJVS1hJM3Z3K2pjd3JiVkVPSW9xS2RFOUFh?=
 =?utf-8?B?VmVRam54OUxyL085UkpYanE0ci9YYWxqaXkwMllKL3V4U0hBREsyWk8vWjhK?=
 =?utf-8?B?ck8ybDZHSUx0bmRYQW9CUHdmVnhqRGYwdjNFUjRXUDhPVGlxQVpGUmljVXdQ?=
 =?utf-8?B?c0w5ZjVtMHJaSUtEbEF0QlRyNUExRzk1cHExQXlXaStjMllWZTNlbXpzNk5j?=
 =?utf-8?B?ZUZvM1J5LzdpcUswSThzY0RnVzE4ZSs0NXZOcTE3TzFDc1JjSzlJbFFpMmdm?=
 =?utf-8?B?YWNpYjlZaUtrUHRhNEh5YWdTMmZmb1oyZVp1ZHZEQTlPa1hUazRCQmd6UFlV?=
 =?utf-8?B?Y2VjTXVoVXhZRjZjTTQybWs4MFZkMUU0cUcvcC9TcmdTcWliQVdrS0N0T1Yw?=
 =?utf-8?B?RzlMYW9XUjdsQWZ3VTAvbWJKaDZ3S0RxeFJ2ckdBZkNObHpqYm10QnUvY1Bj?=
 =?utf-8?B?T3d0SURESVFoeS82RmlQQUlwNW1mYy9Ia2dzd0VCeWhVQXlwcWMvSDZ6eE53?=
 =?utf-8?B?Q3Ezc2VwY004SmlVcS8wVDVFdkVYQXo2blkvdE51NVRUZ3FvcGN5cXhMcmo1?=
 =?utf-8?B?ZW5tN2JDZDBvcUNQNmx6TEtxN2NscFVja1RwdHg2NW1hdjRKUVlIQzVjblhI?=
 =?utf-8?B?R1JUcFkvYkRHeTFuL1p3UitJaDhHMWhvYllMS0lNaVFTdkgzdEZxOTBTbWpW?=
 =?utf-8?B?UTQwMG9zRFdocTlnbFB4SVpzWXZFYXRyaFM5M2h0UXlYRDBabDVrRld5c2U5?=
 =?utf-8?B?enBidDhxWTlGVjAwOVFXRmpJYkhZQmtkUHlOL0tqaDEwdlNnNWd4T2Jkb0NC?=
 =?utf-8?B?dFhlUi9lMjd2SjRDejE2c3BKYmo2RXNvc096MUhYSmVWTFI5NENoU1loTzFL?=
 =?utf-8?B?cmdVenNUODZNcFlFU3doMVJoRkJaZFVKRVFpblpXY0VaQWM1T0g5cWpSZFFY?=
 =?utf-8?B?ZGNadWtJOFJ0MlUwdTFEbG40VXk0bitmSWNoaWd4eTNtdGtuVzBITk8yZXVJ?=
 =?utf-8?B?TXJ6N0J0MVo2MGFFOWlORlN4cm1nVFBqK1U2Mmw4bS9iaXl1QmJFMHY4dDAx?=
 =?utf-8?B?RlJYVGJ6L0dxN2plcDhZREpsRXpLUkRqZ2RZQnIySXhmbkV3UEN0ZS9TSVly?=
 =?utf-8?B?NnpVTXVOWEtKRm9Vejc1bUtvdForVmxISkVXZ1JtQWpUSjRtZ3pqaGtvV1Mw?=
 =?utf-8?B?M1UrSU84R21UQjMzL3kyeEtJVDFYd3N1MTBxR0ZNK2pvUUJ3VVMyMmNoZ2pu?=
 =?utf-8?B?WFdCL1RBU0NYQ295bGdIZVF0QU9GbG9YaGFodytyVXJYRWM3bEZrbWFDcW1m?=
 =?utf-8?B?YkUxUUlweVhUaWdQdDJ5UFM2M0hXN0lvWmZOWkczZTZGMTVkUzViL3BoWTNJ?=
 =?utf-8?B?UVBOQmhzTW5CejZWNDd2UEJLSmdoVFYvenFSYXA1TFZCTmFuclJ1Y0RTMWxv?=
 =?utf-8?B?ZjcrbVI1OWVBdlBGYXhDMXlObGp2RnFMUmdyaGEzWThSZnpsa3dNV0VleXVy?=
 =?utf-8?B?eEE5d0xQVmVXMUlJdStvZzlJYUtvQXRsNk5mMjZQV29kUTJFdFh2aitVcWJG?=
 =?utf-8?Q?z5ngxPghQKdz5xoorMWl1o5TV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054c11d5-bf9f-450b-9c21-08db47a856b7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 05:20:53.9533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNHHebHnz0UrP4yw9CqSFDWAUbdi7t7NqoBFpQWeIzhKbYJVX5Z7E+uSGhqwLRGLzNseJrIbmMTwSNG9kMr2ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/2023 2:02 AM, Jon Pan-Doh wrote:
> When running on an AMD vIOMMU, we observed multiple invalidations (of
> decreasing power of 2 aligned sizes) when unmapping a single page.
> 
> Domain flush takes gather bounds (end-start) as size param. However,
> gather->end is defined as the last inclusive address (start + size - 1).
> This leads to an off by 1 error.
> 
> With this patch, verified that 1 invalidation occurs when unmapping a
> single page.
> 
> Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM")
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Tested-by: Sudheer Dantuluri <dantuluris@google.com>
> Suggested-by: Gary Zibrat <gzibrat@google.com>

Thanks!

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


> ---
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 5a505ba5467e..da45b1ab042d 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2378,7 +2378,7 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&dom->lock, flags);
> -	domain_flush_pages(dom, gather->start, gather->end - gather->start, 1);
> +	domain_flush_pages(dom, gather->start, gather->end - gather->start + 1, 1);
>  	amd_iommu_domain_flush_complete(dom);
>  	spin_unlock_irqrestore(&dom->lock, flags);
>  }

