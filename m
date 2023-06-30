Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044B37437DF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjF3JCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjF3JCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:02:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECAC3594;
        Fri, 30 Jun 2023 02:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688115748; x=1719651748;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1g695wUDqN6pTXMC1FEwA5MsaUL8QiuETcjFiD+TygY=;
  b=Wq4lKq7GVfs0/+bA3u2GKStll9UGP/WQVHpmXZfhNEVK+trHiOnsfsh2
   L82XSzr4A0t3qfXxFicdHY2ykwPi7haxcNgnmq92T5An6KstKA6pySN1e
   FHej/L/IQ4r1xudULB1Wh5YWX46046SIrNp/CmDaJ8cBZLwr2wWaextkp
   MdHnYcoj4s2mISHAmOtY1khF86Z8ATRgPSIIecAII4MDcbqGr90tZVzLW
   zFlHxR6TK/mhgVOfNxazk0k92SSjJ6B/g0obfpIm8KoU0kLvg8ofoI5y/
   BbUKGwXzH/6mV0PQ54AGMc0cA24JPTIXcHaIr43znAOnJnWFWdZcClj2Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="426039061"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="426039061"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 02:02:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="667870045"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="667870045"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 30 Jun 2023 02:02:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 02:02:27 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 02:02:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 02:02:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 02:02:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/edVorv4c5N98eN1hpgjc5+OBTkhtUODL6T4udkJxaYWfkRHoS1XfgaTV1sHEZF3yDtNaLUwNWZRJ+I3pyD8b61VWqyuewcoqJQ8/2DI9mCKoOyQGp2XOcELoQwa7wcs0xXyDkBqlD164u58JFi7OXt57kXU248Sk6HyUuO6zIQYkrCm81+DPtgY7vDfgk6fRf0q/paot/hGKsPWbXtC0WmiUe8VXdOY7Fyz35X9Ly21/agr70aj9Mq2eY8fD6BrWYkfnyNj0qtU4jx3FID9Zc9DIuP/iQI88HB7RIPnIBvDDx4+tvHFGyjZJovyPVv02kcg3SSBEpOU+gbE5EF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLGCRJrf5B4bSByRUN2bEdK/QAyY16YpwliiJfcRgKQ=;
 b=jwzfSgsV5MsHOIRzZeFpAhY9hNNebasPNH72+JWrFB+cdB1iuuINW2Lyp7itVy820Uo7IZiFcjS+9p1bOmX0P4/QfuvhVghcD9qLVcnHcPNHkQQIMBMvWd06GVHAHzHec1gQ48LyiKkJ/SYhvBMOrIN/iOqIUX5qLPL7vKzEvRidOdIbCCi/CVWXXNqjKwg+nQKfbLb4xmgEkJWOrUUkCzf8X2AiY/luAkuqZlOE2bgV3wg3q88TRrx7+zDs8BBmmdLItCGczFc9nHmrLggEXpYsgzmKncMdW/znLcQehVhs8yM19M8N2tOKJPYX3JbIygazIxprniUVZAoHiLiy/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by PH0PR11MB5807.namprd11.prod.outlook.com (2603:10b6:510:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 09:02:23 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 09:02:23 +0000
Message-ID: <e94c0d23-4873-5c34-be24-c2208d03043f@intel.com>
Date:   Fri, 30 Jun 2023 11:02:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/5] acpi: Introduce new function callback for _OSC
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <andriy.shevchenko@intel.com>,
        <artem.bityutskiy@linux.intel.com>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <lenb@kernel.org>, <jgross@suse.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
References: <20230613161034.3496047-1-michal.wilczynski@intel.com>
 <20230613161034.3496047-4-michal.wilczynski@intel.com>
 <CAJZ5v0j+Wz7366kLT3ez5TNoGWXvsa53hBYYeS=aHgbTJUqvKg@mail.gmail.com>
 <CAJZ5v0gWuU1JPbzYpDZ6YQ4YNydyELQ9tXKcJgmLwe_=fZ521A@mail.gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0gWuU1JPbzYpDZ6YQ4YNydyELQ9tXKcJgmLwe_=fZ521A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::15) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|PH0PR11MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c90678-206b-4650-1df0-08db7948b77c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GvdGvCKRcktZ5Kk+iDb4QvZl1LHuwV4vJ1IFAsYHv8Ua1UEGku8pvJbpg/A5wn2tHJmvc1RJvSHEEJcqlqiyvqpFjnEZHO9jyiA4ZgrPjtHUw9cWU6TVseqD7UuNlgMScvLU2OUXa2eJasPfFsWoOIu0X2qoZ+2Rh+gjg7YMzIrB9OwRImLr1MoncjSP/Axik0TCB/Y3L1eLAGSj7q3OL6317FF8sCRqVHj9fZOmRmr8oY0kDd0Ge2Z3c1valQqPvJZQeNZgJMb2AJ67TFr+dw9Yv6uBIwvfNY/I9slExoiHq99Ih9dFYNtMSi2vIZlXq9YAe7BPji9ZDwIXFyo6O6bEUqAm13l4uwzWXzN9Qim6sX7Ai6JbunLwwwmc3ll6Tjekd37tOCt8U54ELtQ8nj6PiezEQNM/JAUGg3/snxFTkq/h6xZfUyA0tRx1qIb5wAPmhLqg01UJEpxB8YKOLbt2bF0IwG1h+Uur1ucV0ab0E2r9SUQwjFsNwFBJCCyADKarE5HufFHpEZJ4QKVzi8nwebAuk5/IBE8LMpMMLfqubOJnqqglT8uE6xO1n1HbxPU7MEj8WHnQFG0n0ZH2PZdcgi9CoBhsRf73QuXO7EpZ1erjS/jXpan2Vo7jRa3ChyP9XF/cII5NkkUdvQUxNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(6512007)(6666004)(2906002)(186003)(6486002)(86362001)(38100700002)(83380400001)(2616005)(82960400001)(53546011)(6506007)(41300700001)(31696002)(26005)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(31686004)(66476007)(6916009)(7416002)(5660300002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG9BdTlmSWlORUpMWk1ldzVOZndhOHd5cDJkcG9Dc3JaRVQwdElEVnpSR3da?=
 =?utf-8?B?VnZiZ3dZRHA3MzNwL1RON2lTTWhoMEhDRjM5Y2t0QmJ6NlpCMGYxNE9rSjky?=
 =?utf-8?B?SzhjTmFQVy9xTzgxSVJKRHUrbEpmVkVoNG1Uc05Kb2UyOUZsUms5dzVWbC80?=
 =?utf-8?B?VHhnSHJ0ck0rQ2h0TFZnd2YvT05rSFljZEtqeHhSWDBxQ0N4cjlreEwzdkQ1?=
 =?utf-8?B?SEx3OXEyMkI2Z1RzNk9jdm02a2dPemN0RmkrOWk4M3BpamJqWlppSDh4VUlr?=
 =?utf-8?B?ZHZwSUhRaTJrUWdkYWtkRXJacFc2bXdYNVYvSkk2L0NOSEN0Y0c0YlZqTnB3?=
 =?utf-8?B?Nm1HM0dpMGdyMlRFaTBvV0RCVnI4YTd0UXRYZSswQXdTMnVxYk90OWx5T2ZJ?=
 =?utf-8?B?cTFMZzRSV0NkNUhNMmg0RkZmNDRTTkw4dmExUVpwakM3M0RxYmJrQTFNa1Rk?=
 =?utf-8?B?cisyVWptL1kyTllla2F3Vk04c3JjWWV6dDZyRFVzNGpDUDlkWldwQzZ5dDBQ?=
 =?utf-8?B?V3FPQ2ZrY1dHd1hSRzdKRXNtaFBrVWtGM3l0OGdvZW44aEV1dkE3Z2JicjVz?=
 =?utf-8?B?bkZhTTZOTFRsNXZOb2UySE5jV2V4WEc1Qlp4SUNud3NxR2FvQlF2cXpYZk41?=
 =?utf-8?B?eVpvbFNyaW5OTlI5U3BTL1VockU1aWpRMS9BZUc1aFdhWjJsb25TTGN5cEFY?=
 =?utf-8?B?MjlaV2JRWHlSMEhPSE9Qa3ZXM2plcTcxTGVIOVVWMDZHWmtHUlNRdTRTRk9T?=
 =?utf-8?B?T3BpckU3N1RaMHlIdTNYbWhqekhqUnl3NW5kdzkzbFR5c1RoalZINVR5RTNp?=
 =?utf-8?B?NTdoamEreWFSRGJ0UWozNTljbjhnYSswMUozVWttc3FwVnAxWEhxZWJxQ2Ro?=
 =?utf-8?B?VktlS0dvNDdHRElsQTRsWEpSSURaWW9HYUM0ZTk5Q3lsUC9mMkI4UEs2Zjdv?=
 =?utf-8?B?N1JPRi9KR0JiRzI4eG9NN3JEc2wvV2grMVliMVJWRnR1UzZUbFBiWHNzZUps?=
 =?utf-8?B?NVRHdjlwQUZyTC9XWHIyZys1U0VneDUyMk42aVl5SHFCaDJpUEVWMnpRUkhh?=
 =?utf-8?B?S0orcTBMWXVSaVExSmdlN1hBTGVBSVJtUVJKaVV4STd2dnVOeHNmOHBzT1Zw?=
 =?utf-8?B?UHNQaE1tWDdkN0VFQjZDTnd6WHo4UEtDU3FBVkp1NFcyZ3Y1YXNxclBCMTRO?=
 =?utf-8?B?TVhUUVVnREFQMlVmVmhVUkVOckxmdWtaZjF3dHVuTnRvN1hEZWRhakRPbEhh?=
 =?utf-8?B?K1JWa21FWU0yZklaVFNGa1JBaHJ6Qjl3d1h1Y2x6eGVpdG9pS1ZKRFhTY0NV?=
 =?utf-8?B?S2huU0dHYUthQjBOMCs4NXp4Ny9CYXBtd0FEVmJ1bDBkeXRocmhkeVFPOHNL?=
 =?utf-8?B?d0J1MGtSZXFsMXlBVW0vN0t0d0FWdksxSGlPYXFFTFJWZEl4WDdWWkRocDZv?=
 =?utf-8?B?WE9lcUFWcFNSd1QxbFR1MGRhdVNTUmpIbmdWcUMzTXMvc0FkRUF5RGlYckti?=
 =?utf-8?B?RHQrM3g3cHZMNXBLYk1XOW13TGpUcUUrV1ZyMEduL2d3VXVNNXVMUDZLUVRi?=
 =?utf-8?B?bFgxc2xPVVAyeEdmWGpyUlRvY21OOFhrNVp4eVZTWDBUdFZGblBRZ3BSZHgw?=
 =?utf-8?B?NVZkbElWMzlDWGJQdE5mK2VEenBvZUt2RkcwcWVDSzlBRnBmS1RLVDJvbnc2?=
 =?utf-8?B?Q1pLTTBNakVJVEZUQVhiYUZLbGNQdHlmcW96TGFobG1MdDVTVlIwYnNMejZu?=
 =?utf-8?B?OUVuTm1zUWhkRmYzTU9wUnBUTEZIemVSM2hPamJOZ00vNGFUVEtKV3lVN0pU?=
 =?utf-8?B?TWZzczNKQ1NHc0tvSndiOWdEUWd3bzRZNFFTL3hkdlUxYks5a0oyc252VEhB?=
 =?utf-8?B?TXpYSmNrRmxvZGdaRk1DaXRSallDd2JBV0ZKbDBJUWNwaE95NE1UY0c4TlZH?=
 =?utf-8?B?dWpXVmlWbGpzMHFWYnRVQjlxSTFiZTRzOXZjMTU2VVdWdkZteTdvTUZWOXFE?=
 =?utf-8?B?MHBiTUZ2MG9DMU1yeDhTa2VGVnBPekp5UFpNQURVd21admtreU0ySThYNUVK?=
 =?utf-8?B?dUtFSlA1ZTh3QVg3SURRcGVtNllNMmwwR2N2NTV4TnRIcDdSd2s2RDRzMmUv?=
 =?utf-8?B?WWNKd3FuL2U0Rm9wNVk4N25jakhoV3F1K1huZkJOcUYxNTlpU1pOaTdGSHpm?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c90678-206b-4650-1df0-08db7948b77c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 09:02:22.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUg8d2bLOQf/Zp2/762VVij05JKyRRvEL00Cgw40wUQAag3pWurlTHfF0euo3s8N2cYqdGOdKXjBFQbFVpR6V5Aoswy9qxSlM1GICMhTJ5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5807
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/2023 3:15 PM, Rafael J. Wysocki wrote:
> On Thu, Jun 29, 2023 at 1:04 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> I would just say "Introduce acpi_processor_osc()" in the subject and
>> then explain its role in the changelog.
>>
>> On Tue, Jun 13, 2023 at 6:12 PM Michal Wilczynski
>> <michal.wilczynski@intel.com> wrote:
>>> Currently in ACPI code _OSC method is already used for workaround
>>> introduced in commit a21211672c9a ("ACPI / processor: Request native
>>> thermal interrupt handling via _OSC"). Create new function, similar to
>>> already existing acpi_hwp_native_thermal_lvt_osc(). Call new function
>>> acpi_processor_osc(). Make this function fulfill the purpose previously
>>> fulfilled by the workaround plus convey OSPM processor capabilities
>>> with it by setting correct processor capability bits.
>>>
>>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> ---
>>>  arch/x86/include/asm/acpi.h   |  3 +++
>>>  drivers/acpi/acpi_processor.c | 43 ++++++++++++++++++++++++++++++++++-
>>>  include/acpi/pdc_intel.h      |  1 +
>>>  3 files changed, 46 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
>>> index 6a498d1781e7..6c25ce2dad18 100644
>>> --- a/arch/x86/include/asm/acpi.h
>>> +++ b/arch/x86/include/asm/acpi.h
>>> @@ -112,6 +112,9 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
>>>         if (cpu_has(c, X86_FEATURE_ACPI))
>>>                 *cap |= ACPI_PDC_T_FFH;
>>>
>>> +       if (cpu_has(c, X86_FEATURE_HWP))
>>> +               *cap |= ACPI_PDC_COLLAB_PROC_PERF;
>>> +
>>>         /*
>>>          * If mwait/monitor is unsupported, C2/C3_FFH will be disabled
>>>          */
>>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
>>> index 8c5d0295a042..0de0b05b6f53 100644
>>> --- a/drivers/acpi/acpi_processor.c
>>> +++ b/drivers/acpi/acpi_processor.c
>>> @@ -591,13 +591,54 @@ void __init processor_dmi_check(void)
>>>         dmi_check_system(processor_idle_dmi_table);
>>>  }
>>>
>>> +/* vendor specific UUID indicating an Intel platform */
>>> +static u8 sb_uuid_str[] = "4077A616-290C-47BE-9EBD-D87058713953";
>>>  static bool acpi_hwp_native_thermal_lvt_set;
>>> +static acpi_status __init acpi_processor_osc(acpi_handle handle, u32 lvl,
>>> +                                            void *context, void **rv)
>>> +{
>>> +       u32 capbuf[2] = {};
>>> +       acpi_status status;
>>> +       struct acpi_osc_context osc_context = {
>>> +               .uuid_str = sb_uuid_str,
>>> +               .rev = 1,
>>> +               .cap.length = 8,
>>> +               .cap.pointer = capbuf,
>>> +       };
>>> +
>>> +       if (processor_physically_present(handle) == false)
>> if (!processor_physically_present(handle))
>>
>>> +               return AE_OK;
>>> +
>>> +       arch_acpi_set_proc_cap_bits(&capbuf[OSC_SUPPORT_DWORD]);
>>> +
>>> +       if (boot_option_idle_override == IDLE_NOMWAIT)
>>> +               capbuf[OSC_SUPPORT_DWORD] &=
>>> +                       ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
>>> +
>>> +       status = acpi_run_osc(handle, &osc_context);
>>> +       if (ACPI_FAILURE(status))
>>> +               return status;
>>> +
>>> +       if (osc_context.ret.pointer && osc_context.ret.length > 1) {
>>> +               u32 *capbuf_ret = osc_context.ret.pointer;
>>> +
>>> +               if (!acpi_hwp_native_thermal_lvt_set &&
>>> +                   capbuf_ret[1] & ACPI_PDC_COLLAB_PROC_PERF) {
>> Checking it in capbuf_ret[] if it was not set in capbuf[] is sort of
>> questionable.
>>
>> Note that acpi_hwp_native_thermal_lvt_osc() sets it in capbuf[] before
>> calling acpi_run_osc().
> So you moved setting it to arch_acpi_set_proc_cap_bits(), but then it
> should also be checked by the arch code.  That is, add an arch
> function to check if a given bit is set in the returned capabilities
> buffer (passed as an argument).

Hmm, maybe that's true, but the only reason we check that is so we can print
a debug message  - that's pretty much a leftover after a workaround. Introducing
more arch code to accommodate this seemed wasteful, since in my understanding
all workarounds are meant to be removed at some point, even if it takes a long time
to do so.


>
> Also it can be argued that ACPI_PDC_C_C2C3_FFH and ACPI_PDC_C_C1_FFH
> should be set by the arch code too.

That makes sense, but technically is also a workaround, since we're basically
checking for some specific DMI's and then we disable mwait for them.


>
>>> +                       acpi_handle_info(handle,
>>> +                                        "_OSC native thermal LVT Acked\n");
>>> +                       acpi_hwp_native_thermal_lvt_set = true;
>>> +               }
>>> +       }
>>> +       kfree(osc_context.ret.pointer);
>>> +
>>> +       return AE_OK;
>>> +}
>>> +
>>>  static acpi_status __init acpi_hwp_native_thermal_lvt_osc(acpi_handle handle,
>>>                                                           u32 lvl,
>>>                                                           void *context,
>>>                                                           void **rv)
>>>  {
>>> -       u8 sb_uuid_str[] = "4077A616-290C-47BE-9EBD-D87058713953";
>>>         u32 capbuf[2];
>>>         struct acpi_osc_context osc_context = {
>>>                 .uuid_str = sb_uuid_str,
>>> diff --git a/include/acpi/pdc_intel.h b/include/acpi/pdc_intel.h
>>> index 967c552d1cd3..9427f639287f 100644
>>> --- a/include/acpi/pdc_intel.h
>>> +++ b/include/acpi/pdc_intel.h
>>> @@ -16,6 +16,7 @@
>>>  #define ACPI_PDC_C_C1_FFH              (0x0100)
>>>  #define ACPI_PDC_C_C2C3_FFH            (0x0200)
>>>  #define ACPI_PDC_SMP_P_HWCOORD         (0x0800)
>>> +#define ACPI_PDC_COLLAB_PROC_PERF      (0x1000)
>> I would call this ACPI_OSC_COLLAB_PROC_PERF to avoid confusion.
>>
>> It may also be a good idea to introduce ACPI_OSC_ symbols to replace
>> the existing ACPI_PDC_ ones (with the same values, respectively) and
>> get rid of the latter later.
>>
>>>  #define ACPI_PDC_EST_CAPABILITY_SMP    (ACPI_PDC_SMP_C1PT | \
>>>                                          ACPI_PDC_C_C1_HALT | \
>>> --

