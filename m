Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FDF5B8AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiINOq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiINOqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:46:24 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A96865541
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMQl+agBWWumIirGfN5p9hMaUtYGoOUmBlxar0rHJhAULMJhA7e8ONXNPHO6Q9UPAEf2FH6xuoOSIiR921IX+y0JJ11MUYGAzmVbluMWk7/3EiaaulgGZqlS2xoXhzMEqp1DMefU0JwzdC+aT5NTkxIkGlR6BscD4A4Of5fh9ghDQBWtyJE+f8BsUwfeWg4b4ZNzyASVeoUSZv7KGadNxV/DyHFNmMiBR4MZWp5vuCyboD1e1fhd1kq8ydnnr70XyVg9+XSP64PwTf+/g/MeXehV1EIcJVHNCF6LTvw+24GqF29ETwIrTRN0ULzWVCTZJe2Cs77NL3iT0OpD1w2CeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/XGCWfao35wR+T7I//9+PLICRNOOJ9WBXcRqCVey5c=;
 b=S0bCkUHZlkBmytVkC2IvZjrvXrL2tB3ZTaWxfaIDmoUUnYo0e6H8pmjRAgPnBvXXbBzWGaqf8D5+9gUZmoZqR3wR6gYjDQIIMExYe7bD1Wu3rYMI9b6/gaYGIGeOua7PtmFFS7hRLi0h1CXEPRBQMQIVm1eVN9ZeABHxl2vFTDbjbWT3IpzNJKSiYdQA00KRG2d6+66BYlcIJMPlL2QwoAf9jdk9ed7EAo2NG1TQlcWJM4OAyeuEEwVg8DgB3yVSnxxlgTd5vHujye/VYXB93fMzUlxpFw8LDh2K+6HkGiSz7TDbodWk1dDxADLGG0g08pvhRissyDzaiCPVH/gfCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/XGCWfao35wR+T7I//9+PLICRNOOJ9WBXcRqCVey5c=;
 b=sfhBSkSO5OuzGngPNA5vLBVR5yw71PRgk8UXi/xnJnVvkIvl/Xa1rPE7q4MG/vfhUcK8U4WD+9YjDc65ODauMczaR0klud+mBWFRv2FeMuNwe5fRMVDPj0hsK7fl7C8FvMiAfuZMFWc8dhBLB/QQ7D5vo31oqgAEQJHBtRh4VHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 14:46:21 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::fead:76e:aef5:b431]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::fead:76e:aef5:b431%7]) with mapi id 15.20.5612.016; Wed, 14 Sep 2022
 14:46:20 +0000
Message-ID: <2430049f-bcb3-466b-fbed-03b4cd0e895a@amd.com>
Date:   Wed, 14 Sep 2022 20:16:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 02/13] iommu/amd: Drop unnecessary checks in
 amd_iommu_attach_device()
Content-Language: en-US
To:     Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
        suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com
Cc:     jgg@nvidia.com, kevin.tian@intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220914051451.10304-1-nicolinc@nvidia.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20220914051451.10304-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::21) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4131a3-f253-476f-7412-08da965fe344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 41iPHC+NkRPH85jfhXaHPx9HGskGGgr0E83ZJpN3rh5LJfbo3D83LEhQKegE+owxK4imOfn+/VlhpC4eThHjoFmzEhBzpndBuq6NuvxQVp5Mw65HFGci70YipJwKBg7cMDco1kxavhGkFyMLu5nBF76ihNmKMGwqTQw8NTQClzxjD0mISvvCCvmlIz6pyXH79f25Hstanbel0BxNbzleF/4vgVIsnZo6J7WQo6JzfhwXVbwAWhLQ7wrOX1WhrP3choHORlhEb+jhR+1fY+Hf4rySrnCmzGP7Qr2BfBcNoPtA7uxg4ty8sB7N2Ayp7mZRpkcUq6CIShnmziOViJN9T+mxMi7RMJkvafBHj+aa6Eod/Nyi61MW5V4Mu+gjylvJrvELkPNnS77DC03UKsx0/AuELgoU0GIJIWNpmsA/JAByBIhReb/yrlkGJ0FfbQgQnnOk9eSMhdPvJbqktwOvfto7zqN0wJH2V0WUqspiJg9gUK84rAWVdQCd6DMgTLFVcHk9CSzVC2reo8Y9syaSV2496n8JnUYv0ZGdQA5rEUaotys+x3CuULtsIE7o5hHxHYqOHlLQjXWEfWNk2J7cYIa2/HQv2U+YsHnId2V8S7UBdXS3o6goxw+YqN8DPma6Gztcfsjv/PZFeDdARe0vHvy7KIn+GsiZJVNuhiLbA/FRZVcmrCIMJwdJxF0Z9VJcapxkazpdYGUxIn0F5drt4z3sRlC6IzaA3X+Euo7HhbOp/09DQkEpjXWWETFKWLZVvF5T0wvgijjzt9lpTKzRWKk5GCK54/c4K+0owOgtqK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6043.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199015)(5660300002)(6666004)(36756003)(66476007)(2616005)(31686004)(6506007)(316002)(66556008)(86362001)(44832011)(26005)(2906002)(38100700002)(186003)(31696002)(6486002)(53546011)(8936002)(41300700001)(6512007)(66946007)(4326008)(8676002)(478600001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yng0OFFaWVd1UHZvSzhIV0RRSEY2WUtlSzJwc1BSU3FRVEVmVGZ6ZndWWE5T?=
 =?utf-8?B?UDZlVFRyR1BQdWlQeHFQWDZMek9DQzBDV21ndllHZ0E2L0Y3M2ViOGtQMlZE?=
 =?utf-8?B?QWRVYVR0NUI3VE11WnUwOW54OXRiV1NBNmpTbUdac2lQUDFWWmlTSFA2Zllv?=
 =?utf-8?B?MFRySUl4bnpzcmpXanpManovYWNVZXJYSHRVM0syRVlJWEkyNm8vWjVWTXlB?=
 =?utf-8?B?SlZPcFFHcWVHVms4MjVrTDI3R1NEMHAzdFhHdDhhQTJpRWMxeEhwMFNreHQ2?=
 =?utf-8?B?NkkzNFd0T3Y5L0tsS0hZZzNJcGcxY2EzWFpJTmJLY3ZpNDNZSDlHd1M1TUxt?=
 =?utf-8?B?bTBTeFc5bzBRUWJtK3kvaFdUZnRyUTN3R0tRMVVaNk52VjRyVDNpU3hIREVR?=
 =?utf-8?B?YWNpa2xCajAwN0t1YXZpTDRTeW93aHVLYXZocG1tY0Rxd0luaEpINWZiQkI5?=
 =?utf-8?B?ZlVvVm9aU3lVbzMxZmk3QmxEOGhTejEyVzl3cDhYVzNOS29vOHlyS2hnTmVo?=
 =?utf-8?B?QzcvN0tvRGxlbkhXcm1LYjZvc3Z1ZjVzRVRyQU1uUU5UTTFZaHJlQmE4VStC?=
 =?utf-8?B?M0ppbVhtMG5kNmhOd0RORm1WUWdjZmlBUmxwalAyZ21qUkxkRlVuSTlSSzlT?=
 =?utf-8?B?Q1htWWhZTytUR2lGM1MrWlFNdm05TDBkc1lhWFhpUGZrczhNb09YYlExcU4x?=
 =?utf-8?B?alNSdFVPb2NhQTNRUXg0bGJXT1ZtR01ua2daMGN1TzBPVkt4NFdNSTBmSUxy?=
 =?utf-8?B?SGF1Wk1BZDJqM2NOL25VajVkaHIyenZ3Y3JlWXVrR3RKdkVydHNqTS9ZQkVz?=
 =?utf-8?B?NUJ4MnVpQ0VpVWs3YzUwWFZvaWJmUGJqS2U1MDdSVm12YXpyOVZwaWhJcldy?=
 =?utf-8?B?dVZBck52Z2VhSUpqbTJaRXhxcnpkdGRIRWpHWEROWGltYkM5aWMrc0R3dEYr?=
 =?utf-8?B?Y3JQWHcvUy9KN1hCdnpNdi9lSm1qSlBFS2JscThNRENUOEhaNXlCUGczekVu?=
 =?utf-8?B?S0ZyYVVoUmZSQVE2LzBGZmY3QnNKSnhDUjJuMmNIa1FBdDlGR1M2ZU0rRk1j?=
 =?utf-8?B?T3laWWJ4cStjVWc2V2xQa1hzVksvNWFPcWE2ZlN4Ylk1RmRvUkRBNk5ZbjNo?=
 =?utf-8?B?bzZIYk1NYmVkZ1NybkJLcXRqblhBR0J3S2EwWFJ1YTByazJVOUlaL0NWdEZB?=
 =?utf-8?B?YkZWSEdWdHhvTmhsT0szYUVmeG1KYjlaQW1nUjREcG43TjhzbEY4WGpzMFdG?=
 =?utf-8?B?M0NqOVBzU1RReXNqR0VaM0tGR3BPcmVTazU4NGJiU1VpbEEwRm1CWXFJYWZL?=
 =?utf-8?B?aDhhYklXN1RlT1R1NE9PeWp3VEljTXJNWjNISEpKTThrQXJlMXFTWE5lYmdN?=
 =?utf-8?B?blFvMVNtNXQ3Y1FmcklFQldhUHYzOHE2K2lmTmJhWFlTZWowK1hJY2JBSVFB?=
 =?utf-8?B?djRITXVOT2doamlkNFk1ZnVBbnpoQ3IvMXJ6ejJJQXgwY28wS25GNmxmdFBT?=
 =?utf-8?B?dnJrSjhKa1ZNSE9KTHdJTWFkVjFSc3hrRjhCSGxSOURZZVNHQ1JFKzEyQmxi?=
 =?utf-8?B?YzlqTTRtYlRPQ2JtQ1dwNTZ2M2s1eG8vM2xPWUd0d2VYSUFFOEhNSGtWSkpn?=
 =?utf-8?B?TzNFYVN4a2V0SS9WUzRzMU4zWGFVZVZwNEJFbE45OExHZ1hvbGlkcjlIekVO?=
 =?utf-8?B?UFh5ZCtSK0hZdmk0WWpFL1EwTUlwU1FVTC9aamRCUXdqdm1jYlNnaWNSV05m?=
 =?utf-8?B?TDdaN2dmT2pIaWcvWktnWXNnY1lhRGZrYkpTak5melc2ZDg4WWNJRVpFRG8x?=
 =?utf-8?B?S3ZoQVdaNlJBRUFCWkJTbUFLVHhnZFhGNjdWY3ByZG1TSHI4Nk9VNnBMMExG?=
 =?utf-8?B?TWJPNk9HcDVENUhMcEVJYWxjQWlQYUk3dWVnNitkNHFpd3krczFkWUl6anZm?=
 =?utf-8?B?T05tTGNvaGZIck9kS0x5VDBtNU5URzNWcStpMVVWbmFkMWF4ci9TMjBGaXRQ?=
 =?utf-8?B?Wlc0OTVDaklYbm5ydC9MbkpvaGtpbmZIMms0czRaUXhITnRRQU01VkxzQXFG?=
 =?utf-8?B?NHhRYS91Mm1TTndxZm10TXZ3TERDRk9nSEk3ZDgvRnoxNFp4bjB6U1NpbDlw?=
 =?utf-8?Q?6GNfFYerk/bGoMdHL1u84/HxN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4131a3-f253-476f-7412-08da965fe344
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 14:46:20.6882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saMSe1KskcoaOd96ANrqqY7Y5EAp2jhsGb/yfjKJDlxWj9TN8QMl+W6EuaDM6boGFmJ2cQEJRCdtz6BgORRbTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/2022 10:44 AM, Nicolin Chen wrote:
> The same checks are done in amd_iommu_probe_device(). If any of them fails
> there, then the device won't get a group, so there's no way for it to even
> reach amd_iommu_attach_device any more.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Looks good to me.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> ---
>  drivers/iommu/amd/iommu.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 828672a46a3d..930d9946b9f7 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2135,21 +2135,13 @@ static void amd_iommu_detach_device(struct iommu_domain *dom,
>  static int amd_iommu_attach_device(struct iommu_domain *dom,
>  				   struct device *dev)
>  {
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>  	struct protection_domain *domain = to_pdomain(dom);
> -	struct iommu_dev_data *dev_data;
> -	struct amd_iommu *iommu;
> +	struct amd_iommu *iommu = rlookup_amd_iommu(dev);
>  	int ret;
>  
> -	if (!check_device(dev))
> -		return -EINVAL;
> -
> -	dev_data = dev_iommu_priv_get(dev);
>  	dev_data->defer_attach = false;
>  
> -	iommu = rlookup_amd_iommu(dev);
> -	if (!iommu)
> -		return -EINVAL;
> -
>  	if (dev_data->domain)
>  		detach_device(dev);
>  

