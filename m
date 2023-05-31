Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFE5717741
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjEaGzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjEaGzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:55:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC7B99
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 23:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685516139; x=1717052139;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UFSml6hwovXPnPPLEAgehY+PnzdPYS+g67eWgAj+2kY=;
  b=TU0bvKGP2ySSnpLImjWdITYHcfLwUboC3N7TmRL6QqSt31qizniakV17
   wi7pM7p7np+Ydjxzajj9oPL1ScFIIU62TOyq39MzWleCnGAjib7FWkln0
   YOpVVHHuL/+GGBH0E5nW//JO32FggV/wm+9n/xXc2jyzzLF2IPJ6x9kn3
   XSN3QwKUM9/ES6l74MyNZBM4FPOqidDiQc+BFS2DcMgEYtCiEZLQ0L5zV
   phEA/xYefPPHQTdpMMaj0JnzCiJXyKkuA18egxyklgnTzRMP2kyDaISxh
   Mg52OlotwMuJgZXUr/3DXQr+pDO6Bo01sYN0oMY7pgVz9WW3HcvIAOJVD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="334775892"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="334775892"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 23:55:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="881058939"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="881058939"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 30 May 2023 23:55:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 23:55:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 23:55:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 23:55:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 23:55:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vi2rDWEitphPOF7OfeHmCcFeMN2A5wow/2UQgx4sT+RWXyJ/FYQWUJ3+zjZggLBUGKKRql5rs//j1Rg39oaQhs+S+K05Bjl7n5LJ4ThD06VEs2qz3w7KFZEa/KkL0vR2YmQHrNlGrTAkNHzouid8FDyTl933PqM103d259vaoVGDVT8/6W8ZQS33EWwQH4LE7abRUPA8K1dck8xSAnJ/dEEh6xf4jDi9wojhcOxCxgwBVG9S4rO3w8QZ7vNkVFvEh+nMu7HwUtFYWH/zNFM3blSuMvSBNfE4wAFHKgfP2iQIGM+dirWbA+lOVbbajXHJfeNHQQ/9LKVYlwN+/R3+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXEmfBjEg07Sf+EwWxmEGFMfyoqsV1Z8gY2mwbHsJLg=;
 b=UYq8Uoht2ZjPcB8smhsT519uGmBthYETcLfH+CFME/k9VzH+L4Nri9BavsJpPPfO0Vkrvf80ykuiJOf/ffdND6fsi/s0Gf+cWp6EEiaLaqTMNqt8YB/wl85YaHP7Sy0eDBblFw30HC73XyDrRYG2Tw6ysTRqh8SEI2xuN73YJIfgr91rlP7lp+fwX0bpmxVdI4ASQ1K2RIUkj8DgQybpEvtDU8OWibUSFBP3b6sOeeYEkbzeRCx6UEsbytz776CRdhnrtm07Dp8Vt+I07dnZSuw8OejPum4ZZLAeog/txbj0bBxj3RiVNolOwT9xf4YBDuKC9ybcPpKBHy+Yuul4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB4138.namprd11.prod.outlook.com (2603:10b6:5:19a::31)
 by SA1PR11MB8447.namprd11.prod.outlook.com (2603:10b6:806:3ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 06:55:35 +0000
Received: from DM6PR11MB4138.namprd11.prod.outlook.com
 ([fe80::a01f:d6e:1b90:3cb9]) by DM6PR11MB4138.namprd11.prod.outlook.com
 ([fe80::a01f:d6e:1b90:3cb9%5]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 06:55:35 +0000
Message-ID: <35cff015-2408-b7bf-976a-b0ac8cfd6857@intel.com>
Date:   Wed, 31 May 2023 14:55:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] iommu/vt-d: Remove the dead code in init_iommu_hw()
Content-Language: en-CA
To:     Baolu Lu <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
        <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20230530092503.152926-1-yanfei.xu@intel.com>
 <20230530092503.152926-2-yanfei.xu@intel.com>
 <3d7ce5c1-c248-a14a-2dc4-79449da9aa43@linux.intel.com>
From:   Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <3d7ce5c1-c248-a14a-2dc4-79449da9aa43@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::33)
 To DM6PR11MB4138.namprd11.prod.outlook.com (2603:10b6:5:19a::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB4138:EE_|SA1PR11MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a90a920-2344-4e09-9434-08db61a4082a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRyTEtkDoD7xJLbS+aDQEJfk9VQP4t9VwNbPe+/U6rvVwHdxC4X0PoudC03qeaR7HCP+6UkEsj7mWTpNs36ZCDml2cdIQmCrOSnVSuvmY8yuFhyFWoxgzepXYS6egeQJcv4Zsc2I4X5TvqjvqYfoZFsU0Uh0JPrF0fifJXjwv/UJzlIOtaZSr4ISNG2qlc5CoNEKOB/puVRwn5eDqHnci+CE7uqdevMTHZdkqSIoth4uOoBrtnAOIAJo9OTT8mewFnhmxf84f4aF4oVRm9vmQjIOAw2GhBVCxa9bdDDp182A4+i1ERrV3ZlCmlHezbnwiuTIoQMAWh7v+l7DW5WnEf1abOIOxQRS6ttD0H5NXxSQ+WZEgi28NOleEcmOe8F19npiAfoUmcNwnPAoS/b40/jBUWlPGfFCv8DviPGLu/hd22tvwlA8zGiF0SA6zr3uPuqsrumfbq7fDkA3IkRTN5aIjIcHuQWtxaJ0T7qLF/i3e/UmKlGEvZofF02SvbtGvEDBBlPYbEcVXJohzUQMt6Lx86R7a+ulbJdYWZ6W/6t8Detg/B3Aw7prznHzJyge4vMzk6LvX16g21s1RjIwtgN+wakvVHy/sLrTbQDRcmEqDwY6fZEfN1Nf8McJQ83CBv/SwnucHBnK3R0UfQqlhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4138.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(6486002)(478600001)(6666004)(186003)(36756003)(26005)(6506007)(6512007)(53546011)(83380400001)(2616005)(38100700002)(86362001)(31696002)(82960400001)(316002)(4326008)(41300700001)(66946007)(66556008)(66476007)(44832011)(31686004)(8936002)(8676002)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTdoMjlkVkN2VlNlRklxRHVlZXZTMlU1MnRFczhjTUdYR2RPVjBuK042Uk5i?=
 =?utf-8?B?UW50cGR4SHUzS081U2NtR1FVdU0xR0JxcjhBeHZUWjQ4aVpqdy9jRFo0a0dn?=
 =?utf-8?B?L20zSTI2cXF2M3c0YVFveEFnTDFGeVZtMnBRVTVWK1BIY0Q4SUhuZS9IUWxI?=
 =?utf-8?B?OVB3YVF4RWZwVEhCNDBIWmhNSCtBeDZiaWFDVGtvV2VGLzIwNm5XY09GNTZC?=
 =?utf-8?B?NWxkTmJmay9xbzhibWFyVW1rc1ZXV1pWZXFHQ2EyQ24wSW5Wa2VtVUJsNUl1?=
 =?utf-8?B?RFlhWVVxbjNzNWRJOU1hc3l0SjFvUVB1Tm1QTGhhaW5PRnI1M0NaZUloTlFZ?=
 =?utf-8?B?RnVET3AwM2I1OFJkd0M0WVhJandlSGpabnNsNmJnQmdkSlRld1ZRdVAzTVJo?=
 =?utf-8?B?WUdiWWlZckJFaWRtNVNWbnpIR3NzZlloUEdOeDN0bVJoTnNIN2ZCREZVZUFv?=
 =?utf-8?B?cXQ5SjJOZTBFUUNHZVZOVzdNUy9BSnNFb2lnbGZDUWhRS2g4ejA5QllCQXBS?=
 =?utf-8?B?dk94SytkL28raWhzREsrd1M5SDlLMVUzMTlKZmd1anZMUFN6MzNJWnpndWtL?=
 =?utf-8?B?L25WQWFQWHloSUsvZDMwQU5NTHhxWVo2NjI1S0pqb1krNlppS08yNHlKWlFE?=
 =?utf-8?B?azlIN2VJdWhkWEVkb1ZjVjRsL0s0R0toTmxlU2o0MnUwelpaMGw3RHhwY0J3?=
 =?utf-8?B?bmI0T1VGUFpxQklsa3gyeTBJOE8rL1pBclplcG9PT3d3bEVGRGhaRGY2RjNo?=
 =?utf-8?B?cXZuQkhRY3VIMmdvM25pakQrTi9qZ2F1d0lQQU9tUDRtaDlGMnFENlp5azN3?=
 =?utf-8?B?bGoxcG8xYkQ1ZXIxeENUbUhJbGhFd2syZmo1L0tIaTRjTm9LZjhmUWlvSHlh?=
 =?utf-8?B?Zkw3VWpzdU9SNFRBbEFLSGwzbDBaR2FCMkhTMVd6TnJlQU90a09mcHo1N0JF?=
 =?utf-8?B?Qmc3akNwWFVEUzh3cWc1R3I0QjVRSmsrZXJVbmQxcXdlek4rYWZKbUxSMEJF?=
 =?utf-8?B?WVAvOXJlYklXNDBlQ05XU0NtdUNra3F4ejQ1YUsya2ZHUEV5a3lXMW1xYzNu?=
 =?utf-8?B?dXljM1hhNXJwMzhVWGZRNDN5bXVXSnVzTitOa0YrSCswWjVQdzEreDBwa2tL?=
 =?utf-8?B?cVkxQVVnbjc5QkhXQzY1ZXU5VSt0VTVtbGFJa1UzVDRFUThEV05HMDRBNks5?=
 =?utf-8?B?ZkVKM2wvdlc2RlJCU252UU9sSWtNM3BLOUdjNnJaT3ZFTDZYaVJVRldSTGZk?=
 =?utf-8?B?aXVJeTBlNS9pNGw1VFBxZDZhbWhtV2VWMC84ZzgxUTRDYW1ENmpGZS9DK1Jv?=
 =?utf-8?B?eVhFSHRwWk9vOFZVeFQyZkdOc2M1em56Rll2RFNSeDVkS2c5OFJMSGp4dXIr?=
 =?utf-8?B?Rkd1U1hvZXRPdFlaa0JUdTFOalZ0NTdxYjV6V2dTZUthTGMyRUN4RTIrTnI5?=
 =?utf-8?B?YUU4aUsrQ1pmWnJpR0s3VFNQRG1aa3VLb1NCVzE0aVVxU09pbTlZUHJXbFE3?=
 =?utf-8?B?Vnc0dkdnWFJoRENWYlNZaHJkZi9kMHE4Qkd4cnhKbGN5SlhUK0lqc3dqZG01?=
 =?utf-8?B?NzBWTEUyZmthVFdlZldPenJBSzZZRHJPd3JYcEZsMUhXUE1DU1UxcFo3OWR1?=
 =?utf-8?B?UXYvNXJEdkFJUGdoZHFoSVJPenV3cng0c2tMNmVKUGlVWTYxa1Z4UUkxdHNS?=
 =?utf-8?B?T1FFUlhyclNLVndBYnZIK0RqdVpXVy9hWTNRVHFkTXRiRUdGa01jdHA2RUhn?=
 =?utf-8?B?NUFXdWUvdVRjc3duLzJHeFlFZjY0ZjM4Y3g4OE9EYzRKRytRV0x3dGE3Mm84?=
 =?utf-8?B?R3oyOUZWUUF1UVU1TkZ6bjNRVFI0dkVZSGtrT3ZpZjlISEkwVW03OXhsdi9O?=
 =?utf-8?B?TjlnWDFPZk1zOThXakw5T2lUVFVNUi9GamFENkVwVklobVZqL0xobnV5ZTI1?=
 =?utf-8?B?ajdLOHFXVmpxZ3VXbWcxeE11YllyU28zVUFOUnkxN1NqSGQ2NndqRVRZQUNr?=
 =?utf-8?B?SW9QVm5CS3ltR3VxeVo4dy9mdHIxZVY2bEE1eWpYUGxNaTQ3MXFCN2x1ZGdH?=
 =?utf-8?B?MGNzVWVtQThpMHR0NDJTRnc3QXdjTzVVa1p2RCtNVGh4eVpoOEdlbHZvT1g2?=
 =?utf-8?Q?gXqclLyhSJtqrJEo7u/Fx3hya?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a90a920-2344-4e09-9434-08db61a4082a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4138.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 06:55:34.6991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfgB39rwmxNB8co+WYtZ9NBtVOF6OBxHfvM59ZuH2e/Q+5FD+2EdMNsyffNKxk4/IQKgLDsOsLtUaoBDyzQlbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8447
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On 5/31/2023 11:24 AM, Baolu Lu wrote:
> On 5/30/23 5:25 PM, Yanfei Xu wrote:
>> After 'commit 2a41ccee2fdc ("iommu/vt-d: Change
>> iommu_enable/disable_translation to return void")', init_iommu_hw() only
>> returns 0. If statement for return value of this function is 
>> meaningless.
>> Hence change init_iommu_hw() to return viod and remove the dead code of
>> if statement in init_iommu_hw()
>>
>> Signed-off-by: Yanfei Xu<yanfei.xu@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 12 ++----------
>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 8096273b034c..e98f1b122b49 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -2963,7 +2963,7 @@ static void __init init_no_remapping_devices(void)
>>   }
>>     #ifdef CONFIG_SUSPEND
>> -static int init_iommu_hw(void)
>> +static void init_iommu_hw(void)
>>   {
>>       struct dmar_drhd_unit *drhd;
>>       struct intel_iommu *iommu = NULL;
>> @@ -2988,8 +2988,6 @@ static int init_iommu_hw(void)
>>           iommu_enable_translation(iommu);
>>           iommu_disable_protect_mem_regions(iommu);
>>       }
>> -
>> -    return 0;
>
> 2966 static int init_iommu_hw(void)
> 2967 {
> 2968         struct dmar_drhd_unit *drhd;
> 2969         struct intel_iommu *iommu = NULL;
> 2970
> 2971         for_each_active_iommu(iommu, drhd)
> 2972                 if (iommu->qi)
> 2973                         dmar_reenable_qi(iommu);
>
> dmar_reenable_qi() still possibly returns an error number. It's better
> to pass this error number to the caller of init_iommu_hw()?
>
Event dmar_reenable_qi can return error number, but there is no caller
check it. As below, only these two places invoke it:
1. init_iommu_hw->dmar_reenable_qi
2. reenable_irq_remapping->dmar_reenable_qi

I think we can also convert dmar_reenable_qi() to return void:
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index a3414afe11b0..1432483c79e8 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -2112,13 +2112,10 @@ int __init enable_drhd_fault_handling(void)
  /*
   * Re-enable Queued Invalidation interface.
   */
-int dmar_reenable_qi(struct intel_iommu *iommu)
+void dmar_reenable_qi(struct intel_iommu *iommu)
  {
-       if (!ecap_qis(iommu->ecap))
-               return -ENOENT;
-
-       if (!iommu->qi)
-               return -ENOENT;
+       WARN_ON(!iommu->qi || !ecap_qis(iommu->ecap))
+               return;

         /*
          * First disable queued invalidation.
@@ -2130,8 +2127,6 @@ int dmar_reenable_qi(struct intel_iommu *iommu)
          * invalidation.
          */
         __dmar_enable_qi(iommu);
-
-       return 0;
  }

 From my understanding, dmar_reenable_qi() is used in suspend/resume case,
so the extended cap of an existing IOMMU hardware is unlikely changed. As
for the check of iommu->qi, if dmar_reenable_qi() can be invoked all is
depended on the no-NULL of iommu->qi at first. How about using WARN_ON for
both of them to simply this function.

Thanks,
Yanfei

> 2974
> 2975         for_each_iommu(iommu, drhd) {
> 2976                 if (drhd->ignored) {
>
> Best regards,
> baolu
