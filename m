Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C7C636982
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbiKWTF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbiKWTF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:05:56 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B6113E19;
        Wed, 23 Nov 2022 11:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669230354; x=1700766354;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GdRW4NSKZUU53xIOEqXeLPHSs/aFaMih/fkeiYFNzaI=;
  b=Sv4cbiQBX/y6vN8yu6bdCE7zjEztc4Gu8Fp1SkkKcCF75h1J2oBH18oc
   CtgA+dbEkqRAiQbcIuu9weM5MPCYfyRD5f13hXixx+rPANBbgYOkElCd7
   PtQSAlLrwZTt7DISHFcbtT9NnTURB5UWzDbXQR74bqU6GMIa2TjQmUXHC
   iBww4o3Uuu8d5G29YYFuTvihkwyhFaClnd0Ks2SsuRDdoG3oo8JH8WLBN
   W2nyy9CpybPQNLMQBgacB2yGyJ2ghbZq6e7APuHNVGn7sXCTGFF4rdEud
   zK89dd/aGeJ5MFITHlqBviGSa4RfKfYoWHe0YnNO7W6ZubJvz+aTA24pu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="301702432"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="301702432"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 11:05:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="766832909"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="766832909"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 23 Nov 2022 11:05:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 11:05:53 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 11:05:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 11:05:52 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 11:05:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gi4pFwiMGTxYdCvaqfH5HyzpyXp4vRFR++Xag6HsI872QgjjuSrQ/v9D7uXTwa/1GyKnWof5e4FiBeTfaJV7WWg1m55mkGcCWoVrNRzd7ELBnIRYLBZ0tIXrvqERLY/t3G8TbnJLrpgzSuJrLDYFNzFyUEyoD3wY4Dk0+ZMpvdXEESRbEGbVuTwmr3cuXl+YIh9ej3y1QF9ujmedAtdXc5IORRgxzbgI7CHhbL6tX3QZh/viI5cp/BSV48wcqneNJQlKZHuR8/ab/srswfRIuJi03jgbjnpzbvvOO3VBowIRonw9ZcvbMNsY16Xa4BxQg3eRGeah/W8/pOX6wPaAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6JldJVRL4v13JXTnJ0dVA3dMEsbsQ1EE6ix5DlnZUE=;
 b=ZU1FmtUXEHnJdgl3QtKDMNCU9nLQHhHwvG3/qgVBqkBPRhwXIe+unfKuT6XYrBOF8EszRxErOBijMju+etH2drqrJqkOhRqb+CijBZ9Njz7zYN4ahF5/dM9xh4kyMS30bBb1HCxtVZm5tQfPMUKzMgaRxhbooJ7GMVcfapgvVQkCNG6Cq8xY4/XGNJBZ62fwnjA9lQEnhsfzAioxHYZKB2i15HdZl31gRQLQ7P1w+xzl8uNDWtukNPTJZs2LMqQRZEpfzYmr9TbAE3XXmWGW5VSKh4cDVyYyP9wWZLGE3bPXv20HWoP/4fQx8OdRKZzUDrtS6kqHTBiHzj1OZt9x2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA3PR11MB7414.namprd11.prod.outlook.com (2603:10b6:806:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.8; Wed, 23 Nov
 2022 19:05:47 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a%12]) with mapi id 15.20.5834.015; Wed, 23 Nov
 2022 19:05:47 +0000
Message-ID: <6ce67332-2414-a5bd-28eb-ce312467b9e6@intel.com>
Date:   Wed, 23 Nov 2022 11:05:41 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v8 07/13] x86/resctrl: Introduce data structure to support
 monitor configuration
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
 <166759204323.3281208.9744810874584175730.stgit@bmoger-ubuntu>
 <74fc09e7-3a75-2c62-d505-244a12b6190f@intel.com>
 <06ca0226-687e-c123-4132-b8aa2ae76439@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <06ca0226-687e-c123-4132-b8aa2ae76439@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::21) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA3PR11MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 5776af6e-4870-4f5e-8000-08dacd85b995
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oa9jHT3Jl05P1ulEhWpP2fxTNz36GWqnUGbxTVbi7KnNdU1KF3pl/1YJa4zF9JM2OAx7hvYvMhCgEDlI+dr+NFRiDNaYPt3lFxpfFmpJqKhHtGH+PRMCCkMpyuXH6LKoQ0Ztmbi5BY72DUbbo7geKpiErkIFb3DRvWiov/BQMMgwOxQxefoFCs7ApEIlTpjyIaumnF+JCce/sDtV1I7fl4QM+fJqZ/xc35DBGB188N6HWhRBBb58zyxpyj8UrQrH4U0BG0QPYjmENqYUQvHMlmDuef5jjBQysxjkFJlaPPv/epKPmmVAyoUU45/1zoHWL9xXj4nRrKZVJ4uTSl+uITlNuFYpyO5U1IgHbS65HKMp7Yyv2kHRGBKEz2uHyfJ12HyFM5/AOnCZEIN4L/pkFdqaeyaHDfymyQvXXqmmr6TUHJtre7whq5KG69nGYzoLyHqSH2i5KnPE282+54xN6g7wmw2QF1pHg5hjS4wm42xMs9AjuB1ailjMNuFCOlSZh9c/HTQ0eOu3AjEyZW5ERn4xJfS2AxTDNej80lY6aZCKezQbZeUt1vym/n8AqUarCHf5yiR6tEkANm5VkBz5e3vSb5u4rx8gPh1jGMYB0YLHOfwi1qmWvOEBDRa6Gwp3F2Es6lWM4H5D3Pc7/NoHhSFV2AM+/D1dZdJBQLReetRaKNlhFZf6mSigF+sE/a4+xgXAo5Y0H4sp81OlhbUN/UamBEYOX51URF1cYqDnEKU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199015)(36756003)(86362001)(31686004)(31696002)(5660300002)(44832011)(7416002)(4744005)(186003)(53546011)(2616005)(26005)(2906002)(6512007)(83380400001)(82960400001)(38100700002)(66946007)(6486002)(66476007)(6666004)(66556008)(8676002)(8936002)(41300700001)(316002)(4326008)(478600001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWlvbGpKMWdrL0cxVlM0MGdGVEkrNlZtNEYveTE1Rk4yb0grY0tjODloUS9X?=
 =?utf-8?B?NkRrdEZmeXVlSG5FNDNOT2pOVElvT3pJcmpYOWt4ME1LYWxUYUZndUQyOGpz?=
 =?utf-8?B?ZVN6dGtoL01QR3dqM3E3RlBvUG52UDlscWNva3hJZ0xkcFFqb3lTZ1A2YVZo?=
 =?utf-8?B?dExnNUp5c2htSitKUStpZEpiTnB6S25OZ2tURDRpTHp3RkhqZFFvaDBOelRp?=
 =?utf-8?B?elI1RW1mYWxnZndwMW8yK3JGZ09KYU02ZmxpdjIzVGttbkdjaEE3Qm5ISUhO?=
 =?utf-8?B?Q09tU1h4dFZIb2dyR2swby9RMmswa3lXN25RNHQzTmdISjNUc1daVTQ0UWxG?=
 =?utf-8?B?RG1ncGNIRXF0M2d4bFh2Ty8zQ1dNTm1TOVJ3UncxVGp1YXdaSER3WHJrRXJP?=
 =?utf-8?B?MXVqdWJFZ0xDcUJlREQ3ajJvR1I1aEZCUlpRMk5vS1ZXU0NGRHlVK04vaWl1?=
 =?utf-8?B?M2hHenE0N0lEOTlWWTRuZ0FYVmU1QmRsUmJIc0o3bXJIQ0hpbVdLSkZ4SU8y?=
 =?utf-8?B?VzJPVGRYS3VlVlVHSmF2Ni81bDJmaS9RdHR5VmNSRC9SUERkaTNhWmgvdmFJ?=
 =?utf-8?B?Y0UyVER6S3UxcnlVdHhibTI2VmQ3N1hNMHhrdGREVjdJQyt6VEhWUndudUJU?=
 =?utf-8?B?QTFseDlOSUljaVkrSWZpeC9oUk5PR2ZSKzc1eno4MUNzNHdoc1ptL3Z6M1pP?=
 =?utf-8?B?SWRJNE5zOGVZTThVRnY0QmE4dmVwLzJSYWU0V0UxWHhzYVdGTWRWbWR6a0ZW?=
 =?utf-8?B?N0ZpSWhJc01yMUxVL2IyZEwzRjJWVFpJbU8reSs2SDhob0VhTkhMaEhpRFhT?=
 =?utf-8?B?cWJvQXQ2QXR1NmwzNnUzZG9xcTI4bUJUUHZZTEd0WFdXU2J3VjNWRkNFMDNO?=
 =?utf-8?B?WVJnbzh1b2hMUUc5TEhRQzdncjlML2MwU1hKOFJYSHpwc3lVNnpxdlJpTzZi?=
 =?utf-8?B?VTV3ZHVmTjJBQVFVcUJaSnVTYnhOR0ZjT1FpNDB6Rng1L0dKb3pMZ0FaNTJJ?=
 =?utf-8?B?elM0bXhsa3ovdmhmK0wvREFKZjNQSkRkdXZsdUtBK3l5aWNqNFFHOG1NVGk2?=
 =?utf-8?B?ZE82WjhlYVVRQkRXTWlJNEpVRFhWOFJpbXUza2NBN2hkMHNVL014QVZFNjdu?=
 =?utf-8?B?WENGVDM3dzhwNUhRYWdoOXBsVFg4aU5zUVpVUkRrZGpOR2tSMUZ6SmZ6UlB3?=
 =?utf-8?B?TXU1cnlhRGdoZnh2WHRVTEdURVF0NDhIUjdoZGp6MnhXQ1pQUGRqeEZKOXdr?=
 =?utf-8?B?Vm1RUC9FdDQ3aG1QUkk1bWt1TllBaTl1TDdkK1pkNTBVSGVXZjlDNDR1by84?=
 =?utf-8?B?ZDZ6TW5MVzUwUmhLQXB4L2JVRm8yQ3hRcTNRNkl2cUtnNEtab0lhQit2MXlt?=
 =?utf-8?B?bi9XU0pLbkViYVVTUlhCZXIwVW1lQlQzejFZTHllWDRieTZMVWtkUWhKVU9J?=
 =?utf-8?B?R1N2NVVQQUM1VzlESkVuNTFZZ3NSRE1wYTh1cU1ndkExRWNPZENuSHJDUDBp?=
 =?utf-8?B?WW5mVjF1Mko5YUJIUkgyZ1hWMGVyV3VjYndXNmUzMVhkTjF5QVo5bUZvTUh1?=
 =?utf-8?B?Q1k1SGJiMzVjT3B6UU5tbERKa0VSdi8rd2ZkRSt0Y2lBbUNCVTEyemdqU3c3?=
 =?utf-8?B?UmsrYUpoM2ZmZis1cFhBOThBTnIvR0wvUU4yYWthamNTc0RURVBQK3NSa3hT?=
 =?utf-8?B?SUkzSzJFU2kzWk1XMWNVZzZOayswS0M3QVRxczd5K2w1aVpvSGpvQStPODVD?=
 =?utf-8?B?OHFzQTNVVGxDbXhFS0d0M0Z6aVlxQWtROXZyK05uS2VvSkNjWndyQm12bkFW?=
 =?utf-8?B?alhOdHRCL1o3aU4wV2RYS1JIaWRQQ1E3UHJwb1c0dkJsWXU4U0V0dVVXRzg4?=
 =?utf-8?B?UmdoR21HbzZ4T0xwTnZOZlhvS1BaekducHgzUmFpN3FiVGpNMXV4YWxEK1dC?=
 =?utf-8?B?a3pzV3BEOVNUa3JXeHZsc0dqNk1OL1gzN2lXa08vT1JSQ3lNb1hqZFdtVzQr?=
 =?utf-8?B?ZHZDMlAxRkFiMjZmWXI2NGlHWGZUMU13NUtyaFNXbW1IZ0Zya0FMaGYzbEZx?=
 =?utf-8?B?OXZlV0VUMTRoekJSNExHd0lFZ0t3MWZSQVljdlYzRjZPUElqb3FOOFFrQ3Zq?=
 =?utf-8?B?S2QvSXF5S0tyN0JTM3ZkYW85dlY3a1NlT0RJNi9lL3JaQ3d0NWppdEtIUGFQ?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5776af6e-4870-4f5e-8000-08dacd85b995
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 19:05:46.8178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYDqlfXgBCOGBezOHcjR/HORQYoGmxeoExh/vPzml9/+o9kL8bA0Fb12UEm7RMoESOEfoUCW9o1R70kuzxtuuVDc/Lf5XMV+fyctqG1ps4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7414
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 11/23/2022 10:23 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 11/22/22 18:14, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 11/4/2022 1:00 PM, Babu Moger wrote:
>>> Add a new field in mon_evt to support Bandwidth Monitoring Event
>>> Configuration(BMEC) and also update the "mon_features" display.
>>>
>>> The sysfs file "mon_features" will display the monitor configuration
>> sysfs -> resctrl ?
> Sure.
>>
>>> if supported.
>> This is not clear. "mon_features" does not display the monitor
>> configuration, it displays the name of the file that can be used to 
>> see the monitor configuration.
> 
> Will change it to:
> 
> The sysfs -> resctrl file "mon_features" will display the supported events
> and files that can be used to configure those events if monitor
> configuration is supported.
> 

I meant that "sysfs" should be replaced by "resctrl".

Reinette
