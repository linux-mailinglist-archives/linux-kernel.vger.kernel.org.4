Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4346D8F1D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbjDFGMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDFGMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:12:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D8B7AA6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 23:12:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfWZxM4xEox+aXqJdoUYAARvfEc995spORcUJjroa66wRwswRPI6oNdYNtm2yYm/SB6fRlNUKA3LQNBJbHqwhaxjna6OyVhemxnsjB8w9/4lKjqLsFinXMEXrJsEmYnapTinE5HNjlRHe4xkCsB9TX6tlTGe6IupGE7NJO5Db1Rh1Szku4XZYB421aqtTr/15s7qY7oYJhpcY04Udi8D3JVJ9TkNxRiGPUuQ8fHFpLNEryD6e9r5zHFm51mtqu0JBqhCBJtxAzo0tfueVHHMDZTUPqFHRFLPI2hLjRcnUF7FW6rGcCLeMsG79kEFlKTOTlIRw622SkzFbx09i+r6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKNfCgm0qeQv7OgraaeGmnuee0XB4JXhDGvY39mbPQw=;
 b=HrBTRQ0yvvw5d+usZ3NgEqWToCqgrnsfctukxOkjEMwlnTX/PcRyHYLnUCj2ozM64/fK61pSl8x4CLaGzdW2IioZVcMPG2OS9VTh5Fz5Om30idSl7OYyZ+K2Onyc/SRuj6wf4V8T3779PIL+xyC1rIyO0ulyR51rSHAnY1u4H5WHKufZ6ci5Alcxt/h+igfUPjq2q/LNCXUaSEE13RcM0TzC7JPQGC6u2lkaETFBjRmIBpnLp6Lc9X2fhFYDQy4szWaOghxThg7p6xVwF26CgXInCA8Ttn1kLvqUfbKd3ChdBBzLWm6SvtbU/K5TVe0Tg9O19AiJ5yX8buNkOQko6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKNfCgm0qeQv7OgraaeGmnuee0XB4JXhDGvY39mbPQw=;
 b=i/UMB/THHzG4z1PAS8cFEGIvOQQh2OEWyvx6RsSWAmmihsKrh7l1s8cc9ZxWNQ5YXUz1DjAJWb4/QlUMHwIv6jV7rlQByz4hLqfRdS8whJOz+rJG1xUaU+y2/GHEeex+Oixee2EOXRHwyerbrf/d7z3ai6WgEzRYqmspSkBfB1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7SPRMB0009.namprd12.prod.outlook.com (2603:10b6:8:87::10) by
 PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Thu, 6 Apr 2023 06:12:40 +0000
Received: from DS7SPRMB0009.namprd12.prod.outlook.com
 ([fe80::57de:d785:91de:d205]) by DS7SPRMB0009.namprd12.prod.outlook.com
 ([fe80::57de:d785:91de:d205%8]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 06:12:40 +0000
Message-ID: <d34c7fca-1510-4565-3c23-4923174a66eb@amd.com>
Date:   Thu, 6 Apr 2023 11:42:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu: amd: Set page size bitmap during V2 domain
 allocation
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
References: <20230404072742.1895252-1-jsnitsel@redhat.com>
 <k6cz5w66mfse7ztgtfy6ux4bjasg64dhbjnliybybcvmoywrs3@gehaolzeh3ph>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <k6cz5w66mfse7ztgtfy6ux4bjasg64dhbjnliybybcvmoywrs3@gehaolzeh3ph>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::9) To DS7SPRMB0009.namprd12.prod.outlook.com
 (2603:10b6:8:87::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7SPRMB0009:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: c446253a-8dec-485e-1063-08db3665ed0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cuOl/FLbwrxpUdev3XckCuTBdpqRIfsMTq24TNISyHENp4zsZT3WTIJNS5/NyxVGC1OmOzyc+abLpKetCW5pu6UggUiE2LKeqbqt2xEmQkhvAlaxpCzDkpxyB+go9LqVyzA8Svtcs3O0ggrX1Pf3WNy58s36Ew7dP9QYxtZewug9dkkR9gkQ6FZBlGPSdvjCy3w3W+76TGClKrpAySjOOpPxtSmlU7aSF1Ejuuom/Ztx/mQbCH6mNk+CoeGopUz5GYk03/OMU5OLT0mp6/orhSOINshq88sY2t02rxKTZ3Qw9DyYbObwfAEwEd+Pn2PVNjWTiS1GCzpdVuNg5qhIVMUQKdSV1WWnI1Z+LaQk4MYFri2q7RjsiFnyvLjXfUiecWfNbfEXzXEgGdPoqPlt1f6K8cWH4XfMfBvibwiuavJQIUShG+SQQ9Y0UWJCFWG4xgvspldZJqP7xHED00AW3lK4iqdBYwSd5g14FW07u4PKe4apT3mxhxcS2HV/YagXVkDMsDRgQeHCgOJChcydpV2D/svUG4+jaijaVHYR+6cmdaEpB1kTDO7Gl3Xf71lCc8IJghl7iuite1atXT4fXAtB30rJXgE6Ad+SNqVdgP1ZMklOK/L0CRatRyauVDib+HpLfL0hGx72mEZ9hWHizA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7SPRMB0009.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(31696002)(6666004)(6486002)(36756003)(83380400001)(2616005)(38100700002)(86362001)(6506007)(6512007)(53546011)(26005)(186003)(66946007)(44832011)(66476007)(66556008)(8676002)(54906003)(316002)(5660300002)(4326008)(2906002)(41300700001)(8936002)(31686004)(66899021)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1FmS1A0MFkwWW4zcWxjMGsxUGpvbnR4SThhSk4yRURsV0hBNnhFMWMwM3VS?=
 =?utf-8?B?L2NsMUZTWjFyNkQybS95RTB0WkZwTlFsZElaWXlxOE9QbW9jRDlCcWRlTHZT?=
 =?utf-8?B?M1dNWFRCS3F3ajVCUnFpQnB1ajJlQXhvUit2WnFadGhlUG5PNVFqN21QZjR1?=
 =?utf-8?B?SGhYK1pUdlBONmNQNEhlL1NmK0pDQVV0blBSZlduK1J0SkxGUzdRV1IvUlV3?=
 =?utf-8?B?VTZ6N1JaVmZZYWxobDJwRHV2YWkzbTJMUUxOWlczSHJORWZ4QXBaSHBpanVD?=
 =?utf-8?B?Y2UvTndNc3BoK1FkbTdaamFSSHBzSjlyRStDY21DdnhJY3VMcVVvM3dtWElo?=
 =?utf-8?B?eEd4NldubTdpSE5OaG0rRisxaXJlb1gwVWVkdUFxamJKQjdSMFBuK2Q3RnR2?=
 =?utf-8?B?SUw5anN3dTJsa1RTc0d5dTcrOGdTNmVXSW9JZW45SElGWlhRZjJuckRRcUhX?=
 =?utf-8?B?MVlKUUJVS0ZaYkpEbmJvV0J3cktYRTFTWjRVNTg4aFJIQzdoM2FSY25Ca1JB?=
 =?utf-8?B?S2dPeEplTWpldnczK3RGZXk0V3BxcnZWT2pqc2RYbThFbWs0R0pHZUgvWFBo?=
 =?utf-8?B?TUZiaVY2M01XMm9NSm9YbnpSOGp1aE1YK3FVU0pmYmlCa0ozaFJtekYva2tK?=
 =?utf-8?B?djk5VzRyYXJiSFBGZmlkNWdoQVZaVXdQQzhiNERaMDd5T2xWUndCUklPUktR?=
 =?utf-8?B?cUl3dms5S1pHdThONVpOVWhwVjRkZVdDYi9IK3E2bjhPWnZWQlFQM2NQOTl5?=
 =?utf-8?B?OXdlTTh1VUtFcEp1eVQ3OHcrMWZVbTBkSEdDalRVWi9pcVdqaUJqYUdWYzJ2?=
 =?utf-8?B?c3pJYThaVHJtTCtKRWxYMGhNSlNxMHl4QWlLcWRzY2xzK3h1Rm1LdWp4UXlr?=
 =?utf-8?B?UkRoQ0N5MGUwb2xNNDlrUzFGOUY0cWR5RThqNjd5dEJsN28yaGllMm1wMkRy?=
 =?utf-8?B?SmltOEhTLzJpV09zMkw5dkVjbE54TnFrYzV1QnZsVzlBYVdSUXZ6Yks5TTNP?=
 =?utf-8?B?Y2NrQVEyeUt6WkQxbjIvSG5MVG5KVVJmeEpmVlNSZkhmRUZlTEtnQjBYOElY?=
 =?utf-8?B?N29qMlhxYVBqQjY5T25ZU3lwQjBaeS9YNHJmYmcwYlBITFVmRi9GczFLVms5?=
 =?utf-8?B?aTdZZ2NZVlhHY01sUkJ6b0gzZ050M1dIYTZxd09mU05USDZUSlh3ZHNQb1pF?=
 =?utf-8?B?dzc1MWdic3o3VHlRSC9HTVZqeVM2cjZ3WWIwczhUQUtsSkNNNmlPMkFINnhx?=
 =?utf-8?B?M3RlS3I1S1laQXJkNE9qYkhjNGVmd3ZYUTl1eDNGVmFhbytkSWVMQ1BLd2RW?=
 =?utf-8?B?L2hmV2tIay9aY2tvZ2hUVmR0S2UyRWxKSnFCZDRTTVNYWEUrd3Ard213aUdE?=
 =?utf-8?B?alFGWHVac2lNOEdIcXhxOGZKY2tXTkVMUnprN2tNeCtkS1BRMlJvQTBmN0ow?=
 =?utf-8?B?R2I3eGFMQ1JocFozWmxMYnU3NUlKdnp3bG1qbCtHVTVSSWgzMmd2OWFRTngz?=
 =?utf-8?B?NjNjSlR3SkM0TW9yR0w4QUlobC9Hd20rT3VZclcxNnNwaVJxbVhqN2xlU0ZV?=
 =?utf-8?B?VkpwYkx0WjJVazk3ZXl0T2lCczkyMXFPOFp1UEgxWGxna1J4OGdraUFJNG51?=
 =?utf-8?B?NlBDeTZUNGxqN2I4clF5NGxNTFAydTRvZVV1ZUx0YW5PV1RhSmNDZElQblRO?=
 =?utf-8?B?TkJsN2FPcXVhZjREOTByUGRFSVpGV0dPczVUV2xEbnQxOE5taXpvZGg3em5T?=
 =?utf-8?B?WVcyM01PeXZDTVlSaXppNkpvYk1JMGY4bnRkRnMydDdPY0RLa2FwdjJYeEM4?=
 =?utf-8?B?VFJZY1JaM29wbWsvN3lJS1p3S2NCZEpXV25acDdVUkhja2pqNDdMakZFbmlh?=
 =?utf-8?B?a3c1d3NBMGJpN3o4UDd6VHorZUg5ZEF3ZnVQTHRGcDN4KzZCTXZ1MC8zODBu?=
 =?utf-8?B?VkZyaWlMZHNyYXlYQXJPaUhwSkJyVGZQUURKK1RkdUtheXdJRmhwL0dHSEJm?=
 =?utf-8?B?cGN4Y1ROTU11cG00Vi9uVlNDcDlzdVJUeDc5NTBJTVpHcGdKeFU4OVBaUDN5?=
 =?utf-8?B?dWM4aDk3cFdCbnZ5czVHYTFpQWUzL3djNWM5Ky9hUktWUjVNaS9lOE5VamVr?=
 =?utf-8?Q?iEGu8wlhfKoMqVI6cjE2tsakR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c446253a-8dec-485e-1063-08db3665ed0a
X-MS-Exchange-CrossTenant-AuthSource: DS7SPRMB0009.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 06:12:40.3118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hR+xH+kdzzrDT6l8fZ8dHx+nh4FegruHkwQoLC3atgihf+b4L8+JDoWOKlpM8flDm0TfZRoF3h/mibY6BpwlDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerry,

On 4/4/2023 9:58 PM, Jerry Snitselaar wrote:
> On Tue, Apr 04, 2023 at 12:27:42AM -0700, Jerry Snitselaar wrote:
>> With the addition of the V2 page table support, the domain page size
>> bitmap needs to be set prior to iommu core setting up direct mappings
>> for reserved regions. When reserved regions are mapped, if this is not
>> done, it will be looking at the V1 page size bitmap when determining
>> the page size to use in iommu_pgsize(). When it gets into the actual
>> amd mapping code, a check of see if the page size is supported can
>> fail, because at that point it is checking it against the V2 page size
>> bitmap which only supports 4K, 2M, and 1G.
>>
>> Add a check to __iommu_domain_alloc() to not override the
>> bitmap if it was already set by the iommu ops domain_alloc() code path.
>>
>> Cc: Vasant Hegde <vasant.hegde@amd.com>
>> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Fixes: 4db6c41f0946 ("iommu/amd: Add support for using AMD IOMMU v2 page table for DMA-API")
>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> 
> 
> 
> I'm still not sure this is the best solution. Feels odd with adding a
> check to core code to handle something one of the drivers has
> done. Another thought was something like arm does, with amd_iommu_ops
> dropping the const and setting the default page size bitmap in
> iommu_init_pci(), but I think that would still require adding
> something in the protection domain/init code to deal with it forcing
> v1, so it would still require a check in the core code.
> 

I am not familiar with how arm paging works. But in AMD case we decide the page
table during protection domain allocation. Also we can have different page size
for different domains. (like one domain in v1 and another in v2 page mode).

> Would adding an op make more sense, with a generic op doing what the
> core code currently does for setting the default? Or am I overthinking
> this?

IMO adding another ops is not required. I think current fix is good enough.
Thanks for debugging/fixing this issue.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>


-Vasant

> 
> snits
> 
>> ---
>>  drivers/iommu/amd/iommu.c | 6 ++----
>>  drivers/iommu/iommu.c     | 9 +++++++--
>>  2 files changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 5a505ba5467e..167da5b1a5e3 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -1666,10 +1666,6 @@ static void do_attach(struct iommu_dev_data *dev_data,
>>  	domain->dev_iommu[iommu->index] += 1;
>>  	domain->dev_cnt                 += 1;
>>  
>> -	/* Override supported page sizes */
>> -	if (domain->flags & PD_GIOV_MASK)
>> -		domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
>> -
>>  	/* Update device table */
>>  	set_dte_entry(iommu, dev_data->devid, domain,
>>  		      ats, dev_data->iommu_v2);
>> @@ -2048,6 +2044,8 @@ static int protection_domain_init_v2(struct protection_domain *domain)
>>  
>>  	domain->flags |= PD_GIOV_MASK;
>>  
>> +	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
>> +
>>  	if (domain_enable_v2(domain, 1)) {
>>  		domain_id_free(domain->id);
>>  		return -ENOMEM;
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 10db680acaed..256a38371120 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1964,8 +1964,13 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>>  		return NULL;
>>  
>>  	domain->type = type;
>> -	/* Assume all sizes by default; the driver may override this later */
>> -	domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
>> +	/*
>> +	 * If not already set, assume all sizes by default; the driver
>> +	 * may override this later
>> +	 */
>> +	if (!domain->pgsize_bitmap)
>> +		domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
>> +
>>  	if (!domain->ops)
>>  		domain->ops = bus->iommu_ops->default_domain_ops;
>>  
>> -- 
>> 2.38.1
>>
> 
