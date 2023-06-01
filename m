Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D00B7191F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 06:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjFAEsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 00:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFAEr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 00:47:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1DDD1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 21:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685594875; x=1717130875;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=etl4QXDnJjVWFgxKdJVqsdR5er9ViOKxIIYC1A+xLcM=;
  b=ctma1F/R+DQNmrWpbOjqpVm9iUMumr1BgZenjiSIpieh3hbz72PTOL4a
   k2jSJZbAnsP0KYFxSGRz60r8NLYwOH3/iZNtTfHHIP2G5HHMRTx6i/Hvq
   PyDlSnuirYew55YGZUKl08zDWXGBRaZ7r/+QwsxShaWQWl5GzV7ksSpCO
   b7AFP1Gjmb5SpTrDd32zd0kB/m5SoeHowKbFjiCVMQv+zHOJlcVZr29Hm
   oAWSlk5+iyJ0bxNeJH4X6D3D0S4l7M7TBY/lz7KXTv/qYPrkjaKFtSPby
   FPc4/5MHXqHeI2/YE2EP81J8wEu2Atnzsvwen7C9NzUB7cPmj6vHUHSoy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="340050464"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="340050464"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 21:47:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="796987384"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="796987384"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 31 May 2023 21:47:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 21:47:53 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 21:47:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 21:47:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 21:47:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+o2I6sw75qb2ykJvM+SjXriMbwxlpebyg2UNfpSEfXA9j1S4arww4LEh1JMMmZFGAYQUqLan23NiCFwOQiDe1Fynbf+pB1du3FlIDxR0PzwtbL9EbCrI1vpYbvySj9c+okRTfOowGgk+EHXXC4I8EWpl91bB3MuemwWa+n14WMT/wqUm3EV/965nhdPDHKfYeAOXsitI0891sxaNNhGbUTXDiG5K21Q1JnvV1B2UnTTkGS/WjutpKWierCylAFMTdoQa5K9X3aNF0DUKqXcoe6+4pgp7CMiuyKBm2Vem2QU3ga5NHUE4D/NVQ4Sb9WTF7nDwBh6CQeFyRb/fiVa8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUh0tC2iAU80dGdYyXt53PbBKS/+wpDPm81wkkQZrf4=;
 b=kf0REnyPEjY9hgUn0JRmUQ26eDKkCmMkYYK/vIU0itJirwvi82Wnro7W5jaXRphdwoe3xcxLhNuIoOWl41UyEnWN/0ArAzoagfGSlZbLU5KOqD9/vwJDDFj2626IoVe+gWvbB7xw+6RrtIZr1YzAxOm2Ip0l9dWGU2WMCNnOnp0ZTpUGT5P3jGk8IzHw4ndfyJIk3n7T6V0K5Ap5ogOs/0j5Cj2k4KkYY+9fGo47Yd107SjrnjCmy1H11Q+N6E1ybkq+DCf9lrk0/FqkfKIGUBfrLNMu2e7uD8AWaphdGunAVZDVJMkI50d2FvJOA0H2JOwqXWBbmsgh97P1xLIDKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB4138.namprd11.prod.outlook.com (2603:10b6:5:19a::31)
 by BL1PR11MB5413.namprd11.prod.outlook.com (2603:10b6:208:30b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 04:47:44 +0000
Received: from DM6PR11MB4138.namprd11.prod.outlook.com
 ([fe80::a01f:d6e:1b90:3cb9]) by DM6PR11MB4138.namprd11.prod.outlook.com
 ([fe80::a01f:d6e:1b90:3cb9%5]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 04:47:44 +0000
Message-ID: <9c3a29fa-6533-de16-472c-7570605da3ed@intel.com>
Date:   Thu, 1 Jun 2023 12:47:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] iommu/vt-d: Use BUG_ON to check NULL value of 'table'
Content-Language: en-CA
To:     Baolu Lu <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
        <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20230530092503.152926-1-yanfei.xu@intel.com>
 <20230530092503.152926-3-yanfei.xu@intel.com>
 <3e75f9de-4c67-93aa-9fb4-28da9849dd48@linux.intel.com>
 <a745c910-f4be-62f6-cb02-a610c04f4698@intel.com>
 <e735528a-7bbd-b9a8-7945-10f779fb750e@linux.intel.com>
From:   Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <e735528a-7bbd-b9a8-7945-10f779fb750e@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To DM6PR11MB4138.namprd11.prod.outlook.com
 (2603:10b6:5:19a::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB4138:EE_|BL1PR11MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: d780a032-b035-4cec-26ff-08db625b565a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wBZ5AkpKm3000AdelMNt6O1tjn7RimGu2L5XprZvaGypFaAKcq48fta8xlOMKGkI2MALGqHWEHJ0XyhnbvdXoMRKjOPfsqu3ckiIwotlWwozW0ocU7jAiVhgFDRfPVuY3PnbNL2nIE89GV+BUllbwnIGrH9/4TkmLnyp9wKy5TNjoMTAf9oJ0kogcTVSYJ4hqEDByh9V9K8PTfrVjZBLtjev/NmqWnel3iEpX/sbxWyd1FcZRP0ic01oInrJxB89bzlb0GAjeyCjefx6rO9P33f72vAHV6col0mLyAtMl0LjVOvsNT5hE9S5LOqnccx+GBLScBRiT8AsNyBatuonH6mh3W6C5JenXI9FCkkgMcfMZcWfHSFVKwXQTNPYA25pcWMmD3brux8DPkUZlsu9H2H85FU7tnvW87NzrKhH4b3urPzoFmZNXcSYB4SivbY6wb3owuBvZ4TEI5ZYY5dMsye++4B6PthXLkwOS44vrC0FcHEaSWuZ6mTiK92jmOHm1toEZlPlHwuBaZYMFVStPNWNLA1GHz6GCKfiZ/oXHmIzuRg5AtzX7vkaEZh7+ZXN7hhbWqETSmiCZz6Mnr97UjKR89QEtn04pHofFw3QXnMeGzcdkRG3LyDyqzdXlNc48EDxJg5rfOnp4D09P0tEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4138.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199021)(41300700001)(6486002)(5660300002)(186003)(6666004)(8936002)(8676002)(36756003)(53546011)(38100700002)(6506007)(6512007)(26005)(4326008)(66476007)(66556008)(44832011)(31686004)(316002)(2906002)(83380400001)(478600001)(2616005)(66946007)(82960400001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0Q5L3BndDJjRDRkYzlxK1VueVU5VFpjNS84V0V3ZFFrRzJKb3MzdDg1VDVo?=
 =?utf-8?B?QTFsaVdxOUE4VUVjVGl2YlM1NjhqbTAvRENSckUyamp2TW1wM2F4ZFI1MGJp?=
 =?utf-8?B?TmhqMkhKaE9xeDA1bEFSbitPWjlGZ3NVTjJtV3dlbmRzRUZwQzFULzhqVHRW?=
 =?utf-8?B?S040dkdhcllTalhkZk9QQnMzelJaU2JsZVBpeGFHaXZIdGNYYjZNT21Ua3NZ?=
 =?utf-8?B?ZENXcEdVRDNreFQ4ZnpqNWlXQU83dG41aldRamYxMkJ3eCs4Wm54cVBHMzBv?=
 =?utf-8?B?R1NwekhaMzAwR2RrVmE2K245dFZMWmJnUTdTenlOajFVT2c5ZXl4NVB1MkZv?=
 =?utf-8?B?VVpEQzd3SG1KckovQThXQllXTER0TnRsYy9YWm9xc083ejdRS0xIWVl3SUE5?=
 =?utf-8?B?ZVQ4R3BOZTNVU3VOS1ptSVRxRmR1UXZPdzc3Rm5TdXR2UXRjT2o4bXZsd3p3?=
 =?utf-8?B?ajhBNzJHKytrQ3JyVnBHYTVxdkdTYkNQelAzU3F6MEsvNUtudnREUy9iSkZw?=
 =?utf-8?B?U2pXaWhGQzNHWURQd2ZkS0VIQ2tQb2VCRCtiOFFvYnc2eGZJK0xTa016akFj?=
 =?utf-8?B?Q3dTVUVQTDZhdytWS0o0RC9YdU45RjBaL0JKakRZUVpSaG1DRFdFS3hhWFh1?=
 =?utf-8?B?UkJNRlJuaEJPcmN0cmtJN3hiTHVPL3o1SC9Pb3hQZWJDeE9UcWZaaUtLcG9I?=
 =?utf-8?B?c1Q2QnJiWG5qSTlWWUZFaGY0SFk1ZCs5MnZnWnNWb1RxS3F1NDVUUm5MVVZ0?=
 =?utf-8?B?WUxIU3hrK3RxTllLTGtGU3BHTXBkNUw3RVZBK1pjMEx3VWJkdktKV2RoWTNt?=
 =?utf-8?B?R3crd0xKTlJRZEZ2a01vdkxHK0I1eXE4Z2FLZ1ZjclA2VlFGbHNsTHgzYk5S?=
 =?utf-8?B?OGpMd3l1MFRkRUgrbEFyWi9JMW1jUVA1WVM3dG92dmNocGZtU3NmSjFpV1RD?=
 =?utf-8?B?RjR5T29xWE9zTS9tRUEzSXhNQnJBNk1ZWUN5Z2dqNjcxdGNMZE1Ed3U4NG9S?=
 =?utf-8?B?L25sY1NWOFBFZnlQYlhWTWtxejFrL3JIQ25oUkpUREg3K2JCREtvd3NXclFY?=
 =?utf-8?B?cXB3S2l2OTdDN0Z0OWJIdm85bVppK1RDQlIxdjQ0UUdlNGVtV0w1cFpPZnh2?=
 =?utf-8?B?OVFjMEVnVVBNc2ZaWWZ3a1VEL2xWSHNzZkxOajVvRzBrWU1QN1phcUltci9I?=
 =?utf-8?B?ei85aldDQmMzb21zNDRPT0llUjdxem1EdkRrVHBoU3dGaXJRdFF6VnZuVld5?=
 =?utf-8?B?MXNhWVZIUmo3R0IyeUxaRTlWeWFmbFFYNG5oc1M0QW1CaU16RmVSdHYzTmdw?=
 =?utf-8?B?QzhvRkRhV0pvcWxNelo0NGhHYjFoMGdBeHhRQXZFMlNsUlJMc0ZXcy81MUlx?=
 =?utf-8?B?S0g0OGozb04xeERMRG9sTlNYVWFYR1VkaGNpTWZEMkNrQmJkamNxMU1XOXFk?=
 =?utf-8?B?cTY1eVVPR1JMOSs3cjlhNXk0U0dQVXFnUUJQQTVGQUJjOElJNURUandVUGRx?=
 =?utf-8?B?TW9xS3BwT05XU2JSS1FScmwxWWFabU5mYXZIdmJrb1pEeEc2bktYRnBnL1RM?=
 =?utf-8?B?ZHVIcVZQMC85cFg1bFRKTkxiUEdwS0ZiYXIzSmMxOVE4QzhOMHFSd0U1dVN3?=
 =?utf-8?B?S29rQnBZY1Y1WXV5aXJIWlEyRUVCZ3FpSkE2eVFpRVFsYkVCMlJqbU9ZSnlq?=
 =?utf-8?B?NzFYYWQwTGhJMGh1S3dKa3NYRDZYVld2NkRsWm4zV2ZwTU9TNm5OV1ltclJC?=
 =?utf-8?B?NjU0cFZhZlhHSmMvWnNDWi8vS3pIMjU4L1pXSi81VkVqVGIvSUJFeHBPbXBp?=
 =?utf-8?B?OFFLSWwxa1RxRzRDZW9GMkVWTGNIdVB1UjVMTUgzbHVnTFNqRUxlMlQzaHB5?=
 =?utf-8?B?dGx1VzRXTlNRQ1RBMmNLbVpLRGRPQ3VwT0ovQXl1VG1zN3VjZjM4dUJMYU1G?=
 =?utf-8?B?c1JvVWt4bXpwU2FPR2dYbjZQdnZFZkVJVi8zY3k1L1ZYRStLWEE1OUlXa0xY?=
 =?utf-8?B?ZDhoRDdDb1NhdFVybHBlbWlxYThhZklHbVFSd0lsUXdDN1RkZmxtVEFnaHJV?=
 =?utf-8?B?Z3NlTTRCeWJQZ0x3eW81MGMyN3RCL1hodENMdkRsamFyWSttVFArNktiQTRT?=
 =?utf-8?Q?0aqlqaJWw8vCtrfcCiRC0SFf1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d780a032-b035-4cec-26ff-08db625b565a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4138.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 04:47:43.8420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ig9MQdEXlMQEu8sSFU8d4EDJPjWnNYXmZDXZoLLZP8YTUawQQPjANVSjFBJ0kiA+jzdSRu/IJ/msyX7LTV3yXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5413
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/1/2023 9:23 AM, Baolu Lu wrote:
> On 5/31/23 3:09 PM, Yanfei Xu wrote:
>> On 5/31/2023 11:26 AM, Baolu Lu wrote:
>>> On 5/30/23 5:25 PM, Yanfei Xu wrote:
>>>> Checking NULL value of 'table' variable deserves a BUG_ON as the
>>>> following code will trigger a crash by dereferencing the NULL
>>>> 'table' pointer. Crash in advance with BUG_ON to avoid WARN_ON
>>>> plus NULL pointer dereferencing can simplify the crash log.
>>>>
>>>> Signed-off-by: Yanfei Xu<yanfei.xu@intel.com>
>>>> ---
>>>>   drivers/iommu/intel/iommu.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>>> index e98f1b122b49..8aa3bfdb7f95 100644
>>>> --- a/drivers/iommu/intel/iommu.c
>>>> +++ b/drivers/iommu/intel/iommu.c
>>>> @@ -1944,7 +1944,7 @@ static int domain_context_mapping_one(struct 
>>>> dmar_domain *domain,
>>>>       if (sm_supported(iommu)) {
>>>>           unsigned long pds;
>>>>   -        WARN_ON(!table);
>>>> +        BUG_ON(!table);
>>>
>>> BUG_ON() is not recommended. Perhaps,
>>>
>>>         if (!table)
>>>             -ENODEV;
>>>
>> Agree:) It is always better to handle the error than crash kernel.
>>
>> How about:
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 8096273b034c..7f077e3a4128 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1944,7 +1944,10 @@ static int domain_context_mapping_one(struct 
>> dmar_domain *domain,
>>          if (sm_supported(iommu)) {
>>                  unsigned long pds;
>>
>> -               WARN_ON(!table);
>> +               if (WARN_ON(!table)) {
>> +                       ret = -ENODEV;
>> +                       goto out_unlock;
>> +               }
>
> I'd recommend to remove this line directly. This pointer will be
> accessed in the following code, if empty "table" really happens, the
> kernel will report a NULL pointer reference warning at the first place.
>
> In the same function, I also saw "WARN_ON(did == 0);". It's unnecessary
> as domain_id_iommu() will never return 0. Perhaps we can clean it up as
> well.

Will do in V2.

Thanks,
Yanfei

>
> Best regards,
> baolu
