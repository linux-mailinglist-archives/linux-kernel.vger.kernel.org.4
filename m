Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C33F5B80D7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiINFZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiINFZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:25:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DCB240B5;
        Tue, 13 Sep 2022 22:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663133142; x=1694669142;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=obBLXvXm3O4YpqUXnSBpVxhUutdd1v5+ufMn7TkZiJI=;
  b=H+y9FUOR4bDyozY8+m/xBsUT5D+hXJnqbVUKCL/pThDTCXkNOySLi4my
   PC5LDYc1Sh8bGgsAr889Ik+GQMnAx+oZC+V3cpzaoBVHFtjW5wBJ7tbT+
   lsGqn165OMRWFk8qukBtaxOLpOJm0s4ECEBh/YLp2gkC66XkJGyWhAIqw
   e7xew+jQkoNBxuZ3U7VuTyFaED0P+nCZH/2MRPmoKRA0jiihwQlWdHFfZ
   JMOzj/DS2Rv2y6SAB9ilGRF4tLXjK05qGJ23HVHL36Fr4gn2ZIaQZO7E4
   A1tS/yH/haX2o+0wS1BGvfycx6+q0uxXG07Gx7c/WBwvc0plnIJjH4cxw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="384631768"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="384631768"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 22:25:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="647240808"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 13 Sep 2022 22:25:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 22:25:41 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 22:25:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 13 Sep 2022 22:25:41 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 13 Sep 2022 22:25:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCEGrWasY2joniPmcNFkpxNbtJI1IMNX9joukttI+5sthmiiisddgHMHZNcyIXTDpZEEQLSsrZH/W4pYP1AZi+YvfbpXbpvw7moJhet7/V+GM3gg+kFA45xWs+s8PbHY7bXv2bEJYxFZZAlQphs27wxg7b9+QyGhhV4oO/HxtawqtiHdskzAeiUpbw7R2fUaFkZLpmKtHRCe4KXAtWpgATaikDjKPipicLbqkuRU6BkPcX/REixrjgLHeeYv7RcLNZ9hFHqLyn/bU+pNeSSGUa+q4iv1YDMwtpjWykl6G8FU/tRCkL5m26f9HDlyY3j1M8W33NVBE3xrZkRCJZdXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Srrugc/jNOoU9S9FMUY50ohkRVIlErEd6C0RRTffpXE=;
 b=ADwqThzuPNPg4g8CeMB8Id2CAnyvSjBI0jq15cIrLOaIUMcDBqBfcRWRZTlRgaSejHcj6YZVinCz6/Oclu8f/GVL7x9l+s84CxvWkVFS8yC6IgBvHpRajBhlxdGLviifneKVQPY1kd0rHp9zzHoLmcTiQXvTIQd5O3EfYmzyBqCPacry0SFcNI1kk0cnmqNSHdw2oZJsQGgG5MxwiURlxhF9M4PuMcW/t+BR+UXzbhPZEPxdHx/zTzSK44acr9ybCvgVl9NJtwXsu7uENZKswIaJnHcJgtR4n8uRF/p/P0Vrn8EJFdotJKxqeJy2BHQdBf5/Tkps/cOp1kvNdUeJxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5157.namprd11.prod.outlook.com (2603:10b6:510:3d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 05:25:37 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::5d13:99ae:8dfe:1f01]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::5d13:99ae:8dfe:1f01%3]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 05:25:37 +0000
Message-ID: <ccd567b5-78cb-53bc-9428-d4720ee6fc9c@intel.com>
Date:   Tue, 13 Sep 2022 22:25:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 1/4] Documentation/x86: Explain the purpose for dynamic
 features
Content-Language: en-CA
To:     Dave Hansen <dave.hansen@intel.com>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>
CC:     <hpa@zytor.com>, <corbet@lwn.net>, <bagasdotme@gmail.com>,
        <tony.luck@intel.com>, <yang.zhong@intel.com>,
        <linux-doc@vger.kernel.org>, <linux-man@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220909201540.17705-1-chang.seok.bae@intel.com>
 <20220909201540.17705-2-chang.seok.bae@intel.com>
 <129981cd-32b7-0228-f932-4367f6c79316@intel.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <129981cd-32b7-0228-f932-4367f6c79316@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0063.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::40) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|PH0PR11MB5157:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b352606-da44-4a6e-af58-08da96118e7e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3UBXx2wk7x1KTOFDpUrv5g1AhmoKPT8Vc5lhOAXe16x/hSan8+HWUbmPESnQP2JeXs8J20zSd+q+8srsZ8NUHxRRvjwQ4gam1fIizRWSWiaRglvxSIBR+Leqk1CYr6etSV7oD8YmBRFLLMLmFo29c5WlFW2zWFf3g6qEviSXCukNN8eHUJj6JkCWybiXvaTx+E0nGvXAA8gMp3I5iYL1/FpYUPr6FWVDW2Fklq0mbopZDkJ/sAx61yzN24Y9kV1USIuDiJcwNGs8dDMflhzEd4GWN50RWtmDsJf+ODDp/f9kPl1lswr/cMEfEYEXuEUVJM3a7jIKfxHakm9bHh7GTm/R1Crohfp2HDCtjHyHVjWM9u7aHeGAgBBFJbllHz7ErY6a90FSpwZKxXdQLFLA5djWRIlZkO0+QPHfu7KsmVrBIq+qw0FC1f9PpS7Hzva+oi0gAK4Ndm9j1fKHHNLku4pao+4YGV3uBTgfZY4DWAw9aCXbNB2NVF16FB0X8RQLcYN6iZv7g6ODmyqnH7IdH9+CXEZNwsaxkWWyprksvPxYPjpjxeESRd/XdF1UVDCdNIXA0L7/OmiSD6KkmHWO9nMYZWdQv0DeLZajCiEAGwbRA9rpXIOx0GVkakNRNwGCxMd4ZpLw4wwrfFdL+EY3ef3QjICZCDz8Q//2yY5f9rAgiZFfHjmu3UQzi9fBkMw34KeYry55puUvlaOW/khwszNiWY0YJg4BbSoW0y4ICHzPSa+zvgUu4jQhQUeKFphKw5+9WAKQ9DnGZ9HzffAI8swI3Lklr6n0ZEexUQ7FrDgfBEUyKeFAv1ssbwHLyyfN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199015)(66476007)(8676002)(2906002)(86362001)(41300700001)(53546011)(316002)(186003)(31696002)(8936002)(7416002)(6486002)(2616005)(6506007)(6512007)(66946007)(82960400001)(26005)(5660300002)(83380400001)(478600001)(36756003)(4326008)(31686004)(66556008)(38100700002)(557034005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTF2SVFaYVdLYjlydGpmL1piYkNVU3hkYTA0cWhnOVZrU0MvWEdjeXJ3Z0ht?=
 =?utf-8?B?c3JDQUl0WEVZblBzVDZyQ25LTCtwKzRPWk51NXI3YXFZSXZ6OFl2Y3hFV0Vk?=
 =?utf-8?B?VUNuTW53UUpMUFFMejhtVklvV3h3MG1HR3JWcVdGT1NOVDRVTmRkVVY1MDhX?=
 =?utf-8?B?Z1dhbWZ5aGUyTkhheXl6eDJLMm1PZmdudmdVaUR0OFhndnVWV2dSSXdxMUJs?=
 =?utf-8?B?SW9uSUFYc0VXYnpUNm41aHBVejc1T1BuMkZhQXhHUzNrS095bVBXQzBBa0JO?=
 =?utf-8?B?T3l5SDI4a0VWNVdPQWYwVC9vc0xIMVZKSGFDYkdSY2ZuVHRoSFJMQm5HN3F5?=
 =?utf-8?B?QVlRYXNDbmZpK3BiTEdxZmoyWHRHM0VNODQ2aXN5bi93WFE1MlA5ZVJNTGJY?=
 =?utf-8?B?Y2EwZC9ncG1QVStsdjFnSGloUE92ME5UcEthMWpaSDd2QkhXT0NvUnM2UFAr?=
 =?utf-8?B?cHpGL0R6UFRQNGpiUHgzam9EUHdLcFIzK3JKZm5ES1BKZzVDUm9SaG1ad2ZO?=
 =?utf-8?B?Q0U0UVY3K05LU3h5elA0RVJVLzJpUWRVUEZ6LzFKR0o2OUl4OERtczlmS1Jv?=
 =?utf-8?B?TDJ1VU83T0pySHNERWgyYTNtUGhxUFJOSWJNK1RLNGZiK1pWbWV6eHdCQ21J?=
 =?utf-8?B?eUZ3cmZzYUxVRll5Yk9HOWdxc2VxWUVqakJTTFBLcDNUdURTdFVoODlvWXhX?=
 =?utf-8?B?MW9XNHlndk01Y05yN01UTGJkQVp0MjkvSVdxblU3WFhLMTBSU1h6RmFId1Nr?=
 =?utf-8?B?cTN0UHFUcm5zTUdjUFFSYW1abktPT3NHK3NES2NvTEFIbTk2Tklrb2M1Y2VD?=
 =?utf-8?B?YzExYmRsWS92N0ZGUWVFMnJ2RzdqVkg1bHpRODVhL3NvZ2h4R1Z1M2dMZFdY?=
 =?utf-8?B?V2ZUYzlmVHF3UWJtTStma3hYWUp5Vnpjanltdk9najFvQm96RFZnRUpIVzJ1?=
 =?utf-8?B?TFQyajRmZkFqRmN6Mk5odWo4L1hzWDVVNUdSQXQrWFh0R1p1bWhDZkVQb3Na?=
 =?utf-8?B?Rys1TWJjMkRDTVBGQnVPRjVpYXNWTXJ1L05NWjF4bU9DS2c4a0s1TWpHNTBZ?=
 =?utf-8?B?c1NmK2JabHNHcldHcEpqYnQ2aFZ0di9qbUhTTjRhY05ncldITHNLTGJQSVFv?=
 =?utf-8?B?NFBadUtOM2lOb20rVDVYalRUeGM0bGluZ1c5Wm5MaXpVSCtPQ250UmZYbFNx?=
 =?utf-8?B?eUFLU0NrNFpNZ2VoVkNNa1VmOGVLVlNZenF5Vi84Z1o4dDUrUmNvWE5EQ0xX?=
 =?utf-8?B?WmhwZnR5b011VTVQRUU2MzVyaCtlWEU4RDNUTnUvczdickxaU2czMWFTTms2?=
 =?utf-8?B?OGFGR3YrWU9RbGhlMi9PODVHUXR6bHlrZWxhdWJwK0RyZFJaSzlYeHhzR0VW?=
 =?utf-8?B?MWE0RXowUEdMZ0svOHdyZHZmNGVwU0NKbXNjbUx6YWNuZEpSV1hoRG5KVFJM?=
 =?utf-8?B?TS9FVEc3eElhdnRONzQ0aXkxUUNrSkllQkd1NWhWY29pYU5IQVdVKzBoU1k4?=
 =?utf-8?B?TFUyclc3NlJOOEJrYkZad0MyRi91eEFROG5EZDRmWTBLWVpNVmJ0NThsUUoz?=
 =?utf-8?B?WHpTREVGeTB1bEpITWc2VWx2UHF2MG5kRjcxWjFqYWY4eFdoLzVjdlMwVHBZ?=
 =?utf-8?B?STRJUG9NR0RFcEVGSnJjRFRBbnU3bTFNV1JDQmpObzV0eVNVeW5SaTZYVjZZ?=
 =?utf-8?B?cGFJRmNGQ0lTdnlQQWhYNVdyMDBpL0tNajF3enFlZDk1cms4SEFLUU1kZFVC?=
 =?utf-8?B?S1FZRldITmtZVnVYd01sTGNaVjFMU3FjdVhqNkVaRWdCNURBdnFyWUFQUG1r?=
 =?utf-8?B?c0JJUDQrVzhjbmh0dVNPSjlSd25Qc0orRnRGWFEwUko2NmVacFZ0NE83UUU3?=
 =?utf-8?B?M29aL1dVYko2ZFBKQ3R4dkFYanQ4a214WmxsbnJ0eDBnTTZ2aXlRTWZDMTVu?=
 =?utf-8?B?SEZsUXFGVjljR2x5bGVFSGdaZy96cGF4WUF3UXMrb3FyVHhldXBkL3VhZGE5?=
 =?utf-8?B?b0tueDNDMUMwZXBiWmRXNGhwbTRHRDFGeGdTdXk5ZG9pRW9Cdkk3S2x2U1Fz?=
 =?utf-8?B?VlpLazNmTXljZGNMYnZjN3BsMUNvMW1uY25FUjkwN203cWhyU25mZjZMZThn?=
 =?utf-8?B?L1FPZ09XeUFwQWZzUGdCYjNPMll0MExla1ZINkdLSXhoOGI0YmRkd2NQS0hq?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b352606-da44-4a6e-af58-08da96118e7e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:25:37.7186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCnyjiSC7m0U+NId8yTNFGJe2+lUeYbkaa2rtyqNX6bYqtnofNaq6VDJcOUMarOFPuqOWiEpiwGX/HgKLodcLlOtRGPOCw2/e0U5Sxt9JKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5157
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/2022 2:36 PM, Dave Hansen wrote:
> On 9/9/22 13:15, Chang S. Bae wrote:
>> +The purpose for dynamic features
>> +-------------------------------- >> +
>> + - Legacy userspace libraries have hard-coded sizes for an alternate signal
>> +   stack. With the arch_prctl() options, the signal frame beyond AVX-512
>> +   and PKRU will not be written by old programs as they are prevented from
>> +   using dynamic features. Then, the small signal stack will be compatible
>> +   on systems that support dynamic features.
> 
> This doesn't really ever broach the _problem_ that dynamic features solve.
> 
> 	Legacy userspace libraries often have hard-coded, static sizes
> 	for alternate signal stacks, often using MINSIGSTKSZ which is
> 	typically 2k.  That stack must be able to store at *least*
> 	the signal frame that the kernel sets up before jumping into
> 	the signal handler.  That signal frame must include an XSAVE
> 	buffer defined by the CPU. >
> 	However, that means that the size of signal stacks is dynamic,
> 	not static, because different CPUs have differently-sized XSAVE
> 	buffers.  

Yes, it was missing some points like:
* The buffer size is dynamic.
* And it depends on the CPU.

 >	Those old <=2k buffers are now too small for new CPU
 > 	features like AVX-512, which is causing stack overflows at
 > 	signal entry.

FWIW, some details are worth to be noted:
* Today's kernel prevents the overflow with commit 2beb4a53fc3f
   ("x86/signal: Detect and prevent an alternate signal stack overflow").
* On sigaltstack(), it also rejects a too-small altstack with
   the CONFIG_STRICT_SIGALTSTACK_SIZE option [2].

But, then I think AVX-512 is kind of unrelated here as it is not a 
dynamic feature. Maybe, something like:

     A compiled-in size of 2KB with existing applications is too small
     for new CPU features like AMX. Instead of universally requiring
     larger stack, this dynamic enabling can selectively enforce programs
     to have properly-sized altstacks.

>> + - Modern server systems are consolidating more applications to share the
>> +   CPU resource.
> 
> I'm not sure what this means.  Are you saying that CPU time is more
> overcommitted?  Or that different users are more likely to be sharing
> the same CPU core?  Or, is this trying to allude to the frequency
> penalties that cores (and even packages) pay for using features like
> AVX-512?

Sorry, this point looks to be too sketchy. But, clarifying the problem, 
may help but it is hardly related to the solution to one of them.

The AVX-512 use was proliferated especially in userspace libraries. Then 
notable side effect like the frequency drop was observed. But, it is 
unclear how this dynamic enabling can prevent the library code from 
enabling those features.

>> The risk of applications interfering with each other is
>> +   growing. The controllability on the resource trends to be more
>> +   warranted. Thus, this permission mechanism will be useful for that.
> 
> Should this be something more like:
> 
> Historically, a CPU shared very few resources with its neighbors outside
> of caches.  A CPU could execute whatever instructions it wanted without
> impacting other CPUs.  Also, there were minimal long-lasting temporal
> effects; an application that preceded yours running on a CPU would not
> impact how your application runs.
> 
> That model has been eroding, first with SMT where multiple logical CPUs
> share a core's resources.  Then, with features like AVX-512 that have a
> frequency and thermal impact which can last even after AVX-512 use
> ceases and have an impact wider than a single core.
> 
> In other words, it has become easier to be a "noisy neighbor".
> 
> Dynamic features allow the kernel limit applications' ability to become
> noisy neighbors in the first place.

Yeah, but it looks to be less relevant than the coscheduling mechanism 
as the solution for this. Maybe I'm missing something here.

I'd step back from this second point until finding a case that it solves 
any other problem.

Thanks,
Chang
