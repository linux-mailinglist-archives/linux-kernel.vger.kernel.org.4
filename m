Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB35727603
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 06:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjFHESE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 00:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjFHESA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:18:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD321270D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 21:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5OTGSUGqVbJJzxJYhX2Wr7YCDVi42I8fHAm0xSqMzAeyi8ylbIPKLG1X8xMPLYkywUmlsyPKuEyhtHf6XaPCX0eZGivCvHsr+ER+b6VV1dwlChIomFOzeprprIdqFJqtibzYa8NGUWUXalcBIQqugXHy09fwTZ3/OmTPR0gEQ8YQcF7omIWWEuQTkASPrBqZMtF5YFVavbOiA6SQmScGGAawXsF6s0i1dZAyVTMpHBZSw2dtE4MLCjPjrHhcVOiEDX0oLrBZKkl7J0myT/7fx6a5OyWFUffSV9LIzQrPtQNLnW0hHHO//l4VGVnuCudxkyKMgPxBUG5va6SUiIqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucdEStJMsNjMqD2bN5YNiAdxD8j/GAX0I0WEdie/OLo=;
 b=OUlo8CTY9t1h+JgI9XBSCzc7G7rqmMTOcaFBMihREqkm3Zkgf8DxJRD4kp/F0hoTMwjNZEPuLnAm7JAPHJoNQXkhmKpc7vfe/2jeOFsb+hTP/cD9eeSywdGh3bvwrEWL6Q7AGV8FDplg+c8RD0vV43PxX0ysT1sg/NB5l8gJwTJ7ZnCbILPDtkTtYR8a4h3P1VD7SEwJ3LRRMafYPn3DBx9GgLb72ppocXpyuUt7LPqE1K7Zr6xrc59/cUNI42WRUndEhX8sqoD7TOLzhvjP6YT7O1ONit9cjraFpKOoBmxl/buys8khEJPQzchhXx/bx86SGnIOVMBhNVBM8IdGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucdEStJMsNjMqD2bN5YNiAdxD8j/GAX0I0WEdie/OLo=;
 b=Q7CSFQ4yATIFkdkMM12iETuKQsmEMOtc06uvaTjnQHDN/hSKVWbBp0UgI/yCofcjo72NXxIEoFM5Hll6oAkHt6e0ZCZW8PahCRY3hFddm3ja92pSY5FynxvUz0+8LVd5YC1Qe6ELF7LaPFbbsMFkoHaCjBOTV1eOByeBGiZvdx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Thu, 8 Jun 2023 04:17:56 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99%4]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 04:17:56 +0000
Message-ID: <af26f1e2-da2e-814d-0a8c-5209bba12aba@amd.com>
Date:   Thu, 8 Jun 2023 09:47:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] iommu/amd: Fix possible memory leak of 'domain'
Content-Language: en-US
To:     Su Hui <suhui@nfschina.com>, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     kevin.tian@intel.com, jgg@ziepe.ca, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230608021933.856045-1-suhui@nfschina.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230608021933.856045-1-suhui@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 2508cd21-ea48-4589-f0e6-08db67d755f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 66s8sMGOMemkQTGA5qhOyqTOuz8YJfFv7q5TBspWDYVbf/wBo/Ff7opNuO0NZx+2tLZ5Ko0ubMx+d0dHSmSV8FAaLnuCHBUi52KXfjjkwpQzfLAlW0wVX0GgyuloQ3ksVynRRBFihiRbqZpuQ5U0vDGlb4TdDMRpF5kmgb9e+FfCpwc+G1B6R8MfXhTIEgrtlHHELOUzVP6BWkOl3IMUSICg9D2/UJGOWnQk+Xi/NmfgXNLp5mxCHIdFp8ua9wbqmyZ5jMxmQC8BIZV3RwPEDlQIAPipWKq5rfPlq7mxIoTRQRinBgyV2V1BvmqcN/ICuQBfXaKI4cEldSbfDzvOEUF3NBnnuxbKDyCwKjWbUV9MAq4GbFpP8/59fQDz4hmEJaeeA8L8v8fIXarvWxAnGzWXYELJHJQgXbHmUTyJ9y+OO7UORhJ+hpJp23lQ1MpyQtBtt+F+J2P6tO7+DSE0OffkGvaVWWLt4IeosFge4EX/1sxMzRlY2oOFC0yjduIOliavsqX8Jm2J3K7B18VXbJlrZENWavKzC7onjOf6urdOY1AUwlWw4kuO8LFX5WCXHiiuPnItFook4CxNjQfcP8ucPXum/PTju+7JtwOmIoopdKMvVm/WoDyUb6uEw3mlxi7woS9JWYB4en2AOd0EWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199021)(2906002)(44832011)(36756003)(38100700002)(31696002)(110136005)(66476007)(478600001)(8936002)(6666004)(4326008)(66946007)(6486002)(316002)(66556008)(8676002)(41300700001)(83380400001)(2616005)(6506007)(186003)(6512007)(86362001)(53546011)(26005)(5660300002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE9PWlRaQ1lOOFk2RGYzQjBkM2lPeGF1UGN4eVZSb3kxYUdhaUlJdW1ibVB3?=
 =?utf-8?B?eXQvUHAzZUkyUjFWTjhxb2o2ejlmUzhZYXVzcTRKRHBEcWZBUU5seWJnSUl3?=
 =?utf-8?B?emZGTlhSdUsrZUhKejEwQ2gyMkV6SWVNRE8zZmZnRFU2SnJML0MxYzlmcHBI?=
 =?utf-8?B?WGh5TnNRVGl2TXVvcUZZVFpLTkk5bmlTazZoMmVZQVR1UEVRanozYVU2b1BD?=
 =?utf-8?B?RDZIS09hMU4rOWh6ak0ycFBlSEpCTUhRL1MyRTNOUlM1cU81ekpWOWJvamVD?=
 =?utf-8?B?ZnRSRHo0QUJtdlVtaDFjWm1nQVk0Z2xydmFtblVwWHhtR2ZjempGM25RbnM1?=
 =?utf-8?B?VDN2czNLekloTWdTMEQzSEVpa0NXSVFwMGVHRE5mVE5MTHh1THl5YTNpcGNP?=
 =?utf-8?B?ZElFQzBQTWhROUR4TjJ4alZkd3F2UFIydDQ0NDk4c3BIMG5hVmc0SnlJUFdF?=
 =?utf-8?B?STBsNjB3Sm1KeTdPY1Rid0U5L0ZVN1JJRU11ZHFweUZvZVNRRElCcXZhd2tC?=
 =?utf-8?B?RkhPV1JkVFlxZ09NV0gwY29GMEVwTlRPalV4T3FNa2ZRbEZRWVF5SGVLNWpB?=
 =?utf-8?B?V0RtVWxqWEhrRE5wYi91cnRqM2NIZi9JQjlPUzJHcVdSTGhwYy9UMG9QOThF?=
 =?utf-8?B?ajZpTEtla0VZc1hRb1BnbGxENjZiOFRkZGNQWlJNYkVzUDZjR3ZwLzlya3Ra?=
 =?utf-8?B?Umx5U3ptTTJGV3Y3d0ZaYkg3UmFmSndSL2o4RVQ1ckVTeGJ3ajg1NTNpdXM3?=
 =?utf-8?B?VjRrK053VzUyM0d6aWRQR3BwKzBOL1YxM3VRNzZQWTFOVXVPMWZWeFJZMDlz?=
 =?utf-8?B?OXA4RERLTkhyb1g2aXBBckVqTVlOanlSaWEwbDF1OUZFWkJyL0hzSlFyQnVs?=
 =?utf-8?B?K3FhbjlWTXFSVEVsUFNnazZ2dVdpZ1lQVGthS1lHd2tjWnRmdG1HV05ZWlBD?=
 =?utf-8?B?djN2dVlVd2J3K2hzc2Z5by9CbUttUDR1TFpSTzdGdXhyc2lEVkNORW8zTVpB?=
 =?utf-8?B?Qy9idnM5TktYTDlaWk1GRTAzZDBGdi84NDBmREduV3Vwc3M1SUlYNlMyRGoz?=
 =?utf-8?B?c3FVYm5QL0FVQk5rT1JZYWxTaGhOU0JkblZBUkZCZ0ZQVEl6SEw3MUxPeklK?=
 =?utf-8?B?VUpyWi9ZTkFweTVMWG85OWNLRmxzTlBZTEpNYVpCL0NoVkw2YkkrdGtSRE9n?=
 =?utf-8?B?Q3dGT2xYTFVjTEt0WFZMVkwrb1hDWjhSWm9vS003TDdLbno0c3h5SVhUT3Rl?=
 =?utf-8?B?UmpmSXNoaitzMTZkQXRwMW91SEsrbDdUWFZjLzlWc2xkaVRCUnZ3OXVrUCtZ?=
 =?utf-8?B?WXNrQ3hlN2ZXNm5RK2VHcnp4cm5hZ0FYWmVtckgrNUxnWHpDTGZlb3ltUmpn?=
 =?utf-8?B?TDhrL21wTTBxbFZuRzZHazArNE9EUmtZQ0dNYVdCOUtFRTBHbmt0QzZocUU5?=
 =?utf-8?B?dUdCTEJiTmRsZmR3VlBiRmsxaW9IZmN3SFJKbS80K2Z2OWNOTHlBNTNKZCtP?=
 =?utf-8?B?bXhqYzhHMFRVR3dpN3lMZ1RuY2FWQzNCaHRtUjFzLzdadWRHR29YWGc2NlZv?=
 =?utf-8?B?VVZyMzVQTlVJR0kxaXVIMjJhRUpWUnJ3YzJJRmdFVDBSeVJqaU9sM3hyZ281?=
 =?utf-8?B?TmxEYmJaYTdERElhSjdJbVJQcnFLZFdSb0h4eWROVHJoaVBNc2c3Q3l4a1dW?=
 =?utf-8?B?VGE2WW00WXM2NFZWZWVCVnJOaWU2bjREZlpTNXpMV3ZMUmFibjRXeXhPNXBm?=
 =?utf-8?B?QUFmR29XcWdIT0JsdEtYaklNbjNYSTdKVU50K2IwOEdJZ3RJVVV4TzlUcUFK?=
 =?utf-8?B?ZlJsVW95bUJMMFp3R09PRW55NGNHNzRPVEwwQmdLaGxReGpvRTJJc0RKUGh1?=
 =?utf-8?B?Sk1WdTNEZGlxMklPZXE5b28wRHNYMWhmU01vcU5Kc3VodTJISHgxWGxMNkpY?=
 =?utf-8?B?REI5VzRSNEpFTUVxbVN2ZnovOWNnNDRMRzZVQVh5V0FLcFhpVTJ2WDJTazE0?=
 =?utf-8?B?dnNhWkdVZU1SL04vVDBWZ3V6WmJFd3ZldVM2b0ZPK0p5ZEppNm9hTkdSK1Ey?=
 =?utf-8?B?OWc0QmVJZVBXWFVpdjhhaVlpVHZEdk9PMlRLbjg5L2c3QVNza1pwbjRmcVFN?=
 =?utf-8?Q?nH2rDDgfwc0JpLZmZb1AEkK7e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2508cd21-ea48-4589-f0e6-08db67d755f7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 04:17:56.4177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtUqp9RwVtUgZyDbiIK2V9OS5JQP5OBChkhcVIKDVd/H1ENz0/6DK4RzdC7o8aK4n0N0sPwxdWDug7FznbK45w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/2023 7:49 AM, Su Hui wrote:
> Move allocation code down to avoid memory leak.
> 
> Fixes: 29f54745f245 ("iommu/amd: Add missing domain type checks")
> Signed-off-by: Su Hui <suhui@nfschina.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>


-Vasant


> ---
> Changes in v2:
> 	change code order is better and more consistent with other
> drivers. 
>  drivers/iommu/amd/iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index dc1ec6849775..e8a2e5984acb 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2078,10 +2078,6 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>  	int mode = DEFAULT_PGTABLE_LEVEL;
>  	int ret;
>  
> -	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> -	if (!domain)
> -		return NULL;
> -
>  	/*
>  	 * Force IOMMU v1 page table when iommu=pt and
>  	 * when allocating domain for pass-through devices.
> @@ -2097,6 +2093,10 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>  		return NULL;
>  	}
>  
> +	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> +	if (!domain)
> +		return NULL;
> +
>  	switch (pgtable) {
>  	case AMD_IOMMU_V1:
>  		ret = protection_domain_init_v1(domain, mode);

