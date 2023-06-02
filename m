Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EEC71FE8A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjFBKHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjFBKHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:07:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604AB180
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685700425; x=1717236425;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SqO2xCchkxB1kOlbJehm59iFe4++lzdh/WSE+DPBnqA=;
  b=IDFryixXkIbiRQAfowaP6gJSLI3t0wSrvAeIqrgaI6m+NI/PgOA0XUNE
   iEJgK56+wnDi7GVF6XPTOvDmd8NBBdaMmsgNWkHWzTmb72EYqO67CZ6Oz
   Mcxa/rXs/ulrRGXAupsvSDJqG0SLpbwWbMkRZNCZyNB22lUU4FuyFwf1N
   rl4at/ruz/0AW2JYAHgv3MsSgIJmnxSGlGQxnzmvjN53Ca4WH/9BvNgwu
   Bs8BIaPB0VDXmhNrAhvRQuaFPxS+xDb01TKnh4VgT3G7RwOE3QuV7HDkb
   +3mGmPMcHJTrzF1H28jwzel6xOGWLYLPKrmDcVn707DtRdX36e30sUmDF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="335447323"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="335447323"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 03:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="701920418"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="701920418"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 02 Jun 2023 03:07:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 03:07:04 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 03:07:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 2 Jun 2023 03:07:03 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 2 Jun 2023 03:07:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XN5wiwqSuborlGinQw2OoH6RNVAsXNNNnfcJirN/b4c+ULJ/gFaR8owA4s8qH0+Dky5/SaAm0hpEl788VPFITTGoNp1oWuALiS4S5YAUdp5Xx/9eabjxuir6Lx9y2NCapVvXpBh+cXVHhyN0HvsbXWYUcSRiOyQ38yqWcLiNlbFaUa2klgABoKajXLIeWVBQcJ8MetQrFduWY9PQhcSUFJ6CboHUC8fTk8gyKgfQjBJTmtKrPNIkPNw9PASG/nE0LsZaYjH3nl9tY8gEELp9W7vzM4eo/Yp2KbV+gsHE3K7tiUA3toGLDG8SY4Ktw4rd1uEE8bxotQNgsxlKeCN0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGITyywkHKQSm+L56HhugUm6Zt2ASXQ34bt9ZoeT6do=;
 b=izBN4r/pWPcwei5CSQul7T2YUxRFi0uQmmoG5u7VXhbGKut4as8VTma1aJy7aojnW++3CPx3mg/ECS3NrEv6IvxVKuSDgX2zXKH18KzBHjVH91xX2Sndn/gXx4VrW3XiEhCBIATjbMT6YFFWNnJC/ayWTtE4qo3XKCiXxVFoX2IZuP/6XgqMVmeZIZz6mufiD2ycXXZqmbOVqgOcp5BlAr/NgjmVbnDz55MMJHOA4hLxsj7RLZnD/xYg0++fMRdgW1bGqHKJVc6NDgLeo62qx192qcWzBUHA/C+AzppZKiY7pQW4ydyFeL9Sucz2Q/+o991S2X0GFy5E7mu1fjbzQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB4138.namprd11.prod.outlook.com (2603:10b6:5:19a::31)
 by SA2PR11MB5211.namprd11.prod.outlook.com (2603:10b6:806:fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 10:07:01 +0000
Received: from DM6PR11MB4138.namprd11.prod.outlook.com
 ([fe80::a840:598d:cada:7e69]) by DM6PR11MB4138.namprd11.prod.outlook.com
 ([fe80::a840:598d:cada:7e69%6]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 10:07:01 +0000
Message-ID: <ce8c0a6d-f14a-7315-865d-3e7f572562a8@intel.com>
Date:   Fri, 2 Jun 2023 18:06:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] iommu/vt-d: Handle the failure case of
 dmar_reenable_qi()
Content-Language: en-CA
To:     Robin Murphy <robin.murphy@arm.com>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20230602020520.224465-1-yanfei.xu@intel.com>
 <20230602020520.224465-2-yanfei.xu@intel.com>
 <88a9afd9-eb2d-55b0-e65e-dec209a5bba3@arm.com>
From:   Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <88a9afd9-eb2d-55b0-e65e-dec209a5bba3@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22)
 To DM6PR11MB4138.namprd11.prod.outlook.com (2603:10b6:5:19a::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB4138:EE_|SA2PR11MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae5e939-940d-49ac-120b-08db63511b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOIJEsoAUjzqtBEV5guOX37tTIvPzIDzS3xMouas3moU50q6/ruJn2riWUlyrs2i3zFCm9CLdtSyu+OsQzAr8GvBY+hGIJu3LTKdcdqMU+GQOYyU2QOtnrteysQqX9P8XUCQrsKXhlFzZfWSYmlS7IcpLRSjgL9xQFAbZupbThHu85L3khlRRLV8KRbTH3niHNvjrYykV2xJ8n0oIHQOe50o5BaxSdWjxCZY2b2ryRxYPY+zH/Woa/Oa3xuqCS2EwyVcgq0CxCbOuZW154fvteiZhxE9gbKXyQ54eBLMp++lfR4ZkUlxHFQyOmeVmnVefWnDOZjgvU6ibhk9RAz44wAINcTS7iDMe5QWCyALQcbnAaXHxpGfTfY1ts3LVXrF6yonw+FvawjnzTi6hENQ+YYlrXpR6tmghA7ElS90VGGkGDiDtbkE2yOUCsNNcBR9Mw4gySQSNIPMYqMPjqzuzev6cDBf9alIfnnvH14yKrkh4sxEauWKyYCQvXoT4RMSXYjI2+Rnb7IoKLFf1QpJs3BqCA2OboV2FgYhIyFRbzQ3zktbbTBYLCey7YV3+QobHLGIwhHcA8fJUJXV4tY14rnBP/W/KLALW2Sb0j/Gf/T6IDAKimbpJot6Tl6vJfySp09px13h+VrowbtcAvftEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4138.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199021)(38100700002)(6486002)(44832011)(26005)(41300700001)(6666004)(36756003)(316002)(82960400001)(4326008)(2616005)(5660300002)(6506007)(6512007)(53546011)(66476007)(86362001)(66946007)(66556008)(31686004)(186003)(31696002)(2906002)(83380400001)(8676002)(8936002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2I1eFA5YW1vRFRWWlBQYW9DQnRpRFYwSWRsYkxUWHdrQ01LYnhHTGJnb2Ez?=
 =?utf-8?B?L2h2cnVqYVk5VTZwUEJ6WVpZNUVTS3BNMHVtRURHbE16Z3h4ZGdMKzY5NTlj?=
 =?utf-8?B?RkpkbFEvUmdRRWN3OW5DdWRUVCtrWWVMbzhDS3J2Wnh6Ny9PZVlyUkFmc0lM?=
 =?utf-8?B?UlcrVUptczQyM0JlNnZXMGlYaklLZzBIeEc2cXFFa05uNldvOWN2U0x2ajRl?=
 =?utf-8?B?WmhMbkdFZUlKcEhEZmdaY3pSU2lJYjBaTVdvUXkvRWNCZ2svRno1dzlnTEFE?=
 =?utf-8?B?NDlybFNZWHBXV0ZqZ2lXZUJIUnFFek1wS1hKWG55bVJZY1V0eGpUOHlPUlhG?=
 =?utf-8?B?d2VjWTliNjliTjJYcWVUTmN1VjVJdlJHWDZLb2tSdTFDV1BrWVQzanVVeUZo?=
 =?utf-8?B?SzhEOUZXMWh0eEZBdG13cU03ejJTWmJOdjJPbjZTODlmWktPczROTHlQRTFx?=
 =?utf-8?B?WnlZQkdETVJOMXcremtyK29YcmducWU0OFlQK3hqY09xdHF3SXlQQXVoRUpX?=
 =?utf-8?B?RXEvcmV0TzkzV1NveHIwM21IUS9YQnpYNlNIRk50a1ZUVEJhWkdHQXhlbDQ3?=
 =?utf-8?B?aTlHQ3pvaHZyMXc2aGIzemhSbTE4OWxyZHV5MmtNd1dFS3Zqa1BpQjNjWHdR?=
 =?utf-8?B?TnBTZzZuNkREbEVZd0lsaWppcWg4bENnQlpERW8yUkVBeDhlUHhXc0pYbUNF?=
 =?utf-8?B?ZzJJZUtNVm1CYmx3d1A2elhOaERCcHkvbFdJTmJXa1RhalIwVXM0UFBYUld5?=
 =?utf-8?B?aEtiYWhIL3NMM09ZUDV1dWpqa0FBdXZ2S0VYZ21RMmNyaEczQzA0ZDlQcVk1?=
 =?utf-8?B?RXFGalFQZEZNWklrckllT24yWFlEK1lYeU9vZmMwTzV0ZVJ4ZkRYYUhibkpn?=
 =?utf-8?B?eW9jQTczdUZZMzhhT2t4ajJyenM1QlJ0NVVLajVFZWhXRTl2dGVZejFYMnNW?=
 =?utf-8?B?SURNQlQ2NVNHekx1QzU4UEhFdjBxVERSdEsyT1NWM2dzZkpoRW10L2tWeTZT?=
 =?utf-8?B?bFIvdkEvNXdDRXR6Tlh5V0oxNmNDV09tNlhoRm9pREs1OTNMNFU2cm10RFhm?=
 =?utf-8?B?VjNpMlcvUThuenNKak5EK21DTEhMTzhwK1lvYk5TYm5pY3N6T3BRb0lKK1pa?=
 =?utf-8?B?V2p6WE5ZVXZCMkoySzhkT0NGQ0xzbjZ6MmZySmJlclFnYndpZEF4T3l4REdE?=
 =?utf-8?B?WG0reE1lS2tWclUvcEZDdVZOeEVyMEROeDJUREd0Qmh6bkdjemJLY1BZQm40?=
 =?utf-8?B?N3p5ZmlvTGVMZ0VFV1JsUjM2QU5UL0x0MzYrME1reEJsd3JLWWFPODlDWGxw?=
 =?utf-8?B?d1lxSGlqNThqNmZhTWlwa1ZxMGFYNmFNbUhCSm5CUDIwMUt3bzdNTWRaU1hY?=
 =?utf-8?B?TXBwanJYT2h1NG05T20zR2xHc1pBZDRmdUVOYWhjWFM0dVY1enY2TmJPM3Ay?=
 =?utf-8?B?V3NvS0V1dk8wTlNuTWc2OWNqdlV4bGxIM1BFRGVYTTE0NnFPc2tORXBIVHUr?=
 =?utf-8?B?RXNDY0ZLckVNeW5EK3FsVVlhSkZScHJUYU45R3hxQVM0ZUUvNmlRemtuTTU0?=
 =?utf-8?B?dkJMSVJrL21DV0RyQzkyM3FHby9HYmIzMDU2b3h5QVUvS2JUODdKeDVRMFlm?=
 =?utf-8?B?UXRGS2l1cVU0WGF1alFxOHcwUkVNNFFzWEtHR2lhNlp4RlpPa1p4OFVlSUNr?=
 =?utf-8?B?ZjhWRmdoSFR4eEcyZEJYSEdpcUdZbkhDREtOdnZid1Bza081SHVpWEhVM0Ny?=
 =?utf-8?B?Z1JIdlZUb0NMaG1ENDloN3BpTXhVb1dGdGtLUUdlTXRYTHZIaHgzWGpxMERB?=
 =?utf-8?B?bFNHNzdPTUc1YnUvSlhMeWZpYlV6VGpMNVNvTTkrL2w1OTQwZ3l0VUZockhT?=
 =?utf-8?B?ZmkwLzVjeVk2emdrT0ZScSt0VDVoNVJWQjlTdWpWSkhYK2JHTzRDa2VQTUZQ?=
 =?utf-8?B?dlV3TEtRSnhLZGgyc0tYVkw1Rzh3SlQ3dGJvNGRPRS9Yc1pWTmViQWhJQmpt?=
 =?utf-8?B?T3FURjVXMVVNZmxpbnNJa2VBSytPS3dZRGloUXU1NkNsbitaRGdPV1lPaHhG?=
 =?utf-8?B?NzcrQTdMRmlLZWJSazJZSk5TSFpGQU9QYUxNRnJxcWxoRjRWTnBLSjNMcnRs?=
 =?utf-8?Q?kWJ15gTPiOehIz4CHr8R7iEo5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae5e939-940d-49ac-120b-08db63511b2b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4138.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 10:07:01.2300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rA0JgeO50i6H2C7XKcKcgoWdSz6xEgdKuUCggYxKw0RauFPzx6D0KIBUvG6PTnjI5pd2O1ByCbRzqXbN7B6eIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5211
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


On 6/2/2023 5:27 PM, Robin Murphy wrote:
> On 2023-06-02 03:05, Yanfei Xu wrote:
>> dmar_reenable_qi() may not succeed. Check and return when it fails.
>>
>> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 8096273b034c..e9188d045609 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -2967,10 +2967,14 @@ static int init_iommu_hw(void)
>>   {
>>       struct dmar_drhd_unit *drhd;
>>       struct intel_iommu *iommu = NULL;
>> +    int ret;
>>   -    for_each_active_iommu(iommu, drhd)
>> +    for_each_active_iommu(iommu, drhd) {
>>           if (iommu->qi)
>> -            dmar_reenable_qi(iommu);
>> +            ret = dmar_reenable_qi(iommu);
>> +        if (ret)
>
> Nit: either this should be inside the previous condition, or you need 
> to initialise ret to 0.
>
Oh, you are right. Will correct it.

Thanks,
Yanfei

> Thanks,
> Robin.
>
>> +            return ret;
>> +    }
>>         for_each_iommu(iommu, drhd) {
>>           if (drhd->ignored) {
