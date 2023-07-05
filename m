Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93844747B76
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 04:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjGECT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 22:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGECT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 22:19:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C0410E2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 19:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688523563; x=1720059563;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ALiEbpEKozgD5g1/RZGkJl66PBsCYfdE6VAv/mUfQyo=;
  b=FXHxvdfIVaQzOVEXWlazku7OzD1nkEQeamJoKO5bDF4izrlTghPNfTNM
   VFnZD2m90bh255XJOIv6qoPx93eZCtkWfmi9VfBlYkJ0Jy30eYOVjEDT5
   NpBSwkoLzLCQ50A1rYXLss+yOOG/y2F5Q1ZNb7G0ZuICrCAVXT/wHNjhn
   652wttGS4gcioYw2duPIbV74wWZgI3IwA1Yf5W9uqeOBZT0j+7MgoGVDN
   FOjkU1joauWhESda08x8bvOrXTBJkGaIAN23Kt0J+Lj7awrR9r/TPVw5g
   jlyNiWqfivu57GKbiRtIAyVhx7kjbTskMjI326vKFThJUI6anFJxs+Mx+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="360707968"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="360707968"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 19:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="1049538333"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="1049538333"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jul 2023 19:19:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 19:19:21 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 19:19:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 4 Jul 2023 19:19:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 4 Jul 2023 19:19:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4FHRdYYdNqRZ9sVSHQoQECAsoqOYcP95rrbWT9zDy3rjMO5pbNza1dsBaKh6PiVF4rCT0pRl/ihmRd4RJt3ypIofoIDpROGr76AIw8CFkGjFHXViKcah0t9x+w+qjfVeXcDbN2MHtb03qhces1sJhVACwQurA6tVQH/GCenjBSYFA1Ku85IPEDTNVTzjXBLFBzu+jQz2FFbVsJWHXRvC3PbN/4mEweu+X1UCI0fw4dnV8ZibTgEP9/C4q4QoXB2hh0bginuXxjy8wEamBjfnfEhzRaxCzB+PYrXZK0n0KntAf7N3JzgoPvRS8Q19ncP1eGcxlaFez4i88Qb0VS1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejADA3gRk7vTRGOJzf2U3u8c0aA6IcwNUj2Ix804SAQ=;
 b=RW0hr1tby7iJFWXYgeEVqav8s3imfF/9RA6VtL1SQUmG+E0tgBPoJQqCKASHl17t6qjKe0/ZH3Ztmdm822Pv+d3Bk6EMCdHYUQIktebKH/hn5AFZVL9gI16cp2vJrPSVbvKLY0lzEAQVY/OVyBC23Pd0mU7HPr/9K4Z88SSQCWq3yPyrMlbxaHQ10TS3snyMCWC98lK8NCkqYiKgT1ZbXKblQew3jItNiGesEQlpT09jdwl3ekoWzXwXEQRFN0OQsYt3smbShDUVB1WVILPzje2mLTp2TCrhLlbem9Qb+mNfdbaPuHTm56SNcQyhxPK38xEUQGpg5Rw/qf6mVIRAbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by IA1PR11MB7197.namprd11.prod.outlook.com (2603:10b6:208:41a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 02:19:08 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 02:19:08 +0000
Message-ID: <73477bde-b633-c219-9db4-d0c07c1bb781@intel.com>
Date:   Wed, 5 Jul 2023 10:18:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/5] mm: Default implementation of
 arch_wants_pte_order()
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>, Ryan Roberts <ryan.roberts@arm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-4-ryan.roberts@arm.com>
 <ac6802f6-01a2-6b39-38c7-2fe3cea75dde@intel.com>
 <CAOUHufbmv0pZ1h9AxBj-SD7OqRZYudHMtXzQxcwD4ky-sFd8kg@mail.gmail.com>
 <CAOUHufbpCU_Z7g1QPJ0+HzE9sdNpSh=Mzi0EByLPu5TE4S_UcQ@mail.gmail.com>
 <6d389825-1fc0-5c16-7858-2290fd632682@arm.com>
 <CAOUHufZY-zN8jjQz+iMzwmqMb2VCh7=N+YxfXobgF7i1zUmTNA@mail.gmail.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufZY-zN8jjQz+iMzwmqMb2VCh7=N+YxfXobgF7i1zUmTNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|IA1PR11MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: a3072fae-ee65-4cfb-4da2-08db7cfe366c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SBcwnih8Rpw/L8PMrZXFR8wdHqGiWUaL+q2b016U4faMBMnwzsa1r51bLCijSmUMi4bt23MvXueO7AoEifOH4hPJH+l9UWi5Zz127yHhu2ovnLU5uVjdftz2P4lBxxDU6RaIYS3Z9QeqpQt2HJIHumoMHLba48D0ouRRZCS1gBdicjxTgVWnRj1L30TV7POMGRxR0F2ODwfcK4Dx7IyCUeM0mLydMlL3IQRxvNj/j5xpeSJSRH3tloPl+vkwXdVQiXOvcAZKckWLrgEbLMxbLcr8s/QEtK326tzk80uWr18l+8RLRvLSZPl9IHAw39oraqEXKfDfrolV21hXGWh1SZWOu1q2b14cOm5kcC+jpweCGjB/nF51a3GI7hQe3bAGbawfH2C0kaMFQFIfstoNiOYrLfUjOLouVnrf0R+M6guVvYlsFU0GOxvL71hk15KwTI8YsJN6PYz8PZfVb+FI4/lKM1fBB4KAQlryH17RxMDPxF+ywc/Ei+ny7u86vGj1G3fdpHzo3GMVl2H7OA15sEsq7SVAYFZ8iOSrZaz0BZT+ii7xYqraBpLtc12ViltwsbkR8cY7rhW7CWq40YnnGOrjYWjk3oYNCfnrTWF0k5U0lqkIu9RSqJWDFwRayJT7ZWn/2MGi3/QJMTEYBT7Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(31686004)(7416002)(4326008)(66946007)(66476007)(2906002)(478600001)(66556008)(316002)(36756003)(8676002)(8936002)(5660300002)(41300700001)(31696002)(966005)(6512007)(86362001)(54906003)(110136005)(6666004)(38100700002)(6486002)(26005)(6506007)(186003)(83380400001)(53546011)(2616005)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWhmM3ZtWitkMkgvUDNTMzRYN3F3VlFUbFp3V1JDMmIrRHN1c2owbFhUT0RC?=
 =?utf-8?B?bE1kVHk2eDl0V3ZOMWxINlF5MVRLU2RqZlluaFp3Y3c4Q0ZQc2xDS3FWS1J3?=
 =?utf-8?B?dlNQdFpOZEV2dnNkN01Sc1gzZ2JpVURTaUlaT1d4SEZOZXJnQzh0blEwUU5k?=
 =?utf-8?B?N05KSkhldFRkdktiM0lGYzRETFkxTFNJWVNjL1NwRW9tYTFRb0xESGN1Lzh0?=
 =?utf-8?B?SmhRQXNwNkllYWovelZGM1kybWthdG9aSTlpNGt0Wk9pbGg1cE5FSFEveWNu?=
 =?utf-8?B?aXZzUjNEU2R1eUdZeGpJeFpPUjByQzFEOHNVSm51Wmp0amg3SmxkNzR4YWU1?=
 =?utf-8?B?ME9RTnBWR3IyTm1oWmhvUkVsbEhBVjVzM0crRFVCMnB0SG5TMG1Nb044dlpz?=
 =?utf-8?B?dEw4SVprdUtsL3EzcjFtdm9sZHJWUVAyUVlyUTlnNzVlRHpWL0xTaU1FVFV1?=
 =?utf-8?B?eWxhTVJRREJ3aFpWTlFDVjNzcEtaaUVDWnZsUVNtdE5NRXlWTy9FV01qRjVF?=
 =?utf-8?B?SnNiRGVqd1JuNkRuQy9qVTVOdkRJdHVVWGxSRGVaU1ExOXNaVGhwMFYvUnZ0?=
 =?utf-8?B?ek5qSmNLWDJUNzA3UTFkcDJyMmZiM2t2VExoUHIrMVF3K25qdnpUUVQzQzFo?=
 =?utf-8?B?MTZxVXpza21IeE5ZRUJ3MjNmM1Bxc2FucmdiZE1yWUI1RFBEZTFDR2YwSElX?=
 =?utf-8?B?akdpN2pRbmtVSzEvK0pMampQMVV6eS81N2dpbTdYTGdPRE05SFNtRlBXYVpX?=
 =?utf-8?B?cE9kUXdiWFJjc3NKWDlpUVZwaTRsNmU0eGRVVDdqTlRUUWVQc0hZUWFvRXE1?=
 =?utf-8?B?ZHBJT08xcVRRbStyc0ZHRjA0OTlqSDB2eUtaK0lZVG56dFFzamhpek1Tekpr?=
 =?utf-8?B?UC96WllhM3NFb3JPejNPN1ZlUWRoczk3bExybEVFeW5ybmVneTJOYWl0T0oz?=
 =?utf-8?B?UUsxZ3hQUVpHWXEyTEduMjNVVHR6dUFLZ3JwOFg2UHUrUUp2dWh0eHBxSU5Z?=
 =?utf-8?B?OFo1dVJNdUpsdG4wU2RvYVRIS1Z3TlJueitWMGtzblQxUHB5bVBWbXNRWERi?=
 =?utf-8?B?TXhIbnZTRzY4cTBtY0xrVlBOT0lyRVFKVy9KL3pGb3kwU3c4Y2VwbG1Oak9w?=
 =?utf-8?B?bkcxSmtwM0RnZjA5dnhRVm4yOXhMVUxCVXRYTi9FQmZzT3RCZ3Q2eEViMDNy?=
 =?utf-8?B?WW4wZURTZHM5MVF3SHU3eEwzV2xXaTYrVkdQS0FNMHBiMGZ5RURaS0JWUGM4?=
 =?utf-8?B?OTlHOUVKZDlTTUZIRy96SDh6RmYrWlBOOGxHTXlVd293MjYyS0xUVU9hZXl5?=
 =?utf-8?B?bGNzTWNvN3NabDR3bEFCWGwwOXQ0b0VuQ1dNeFIxUytxaXJhbFZjZnAydlpU?=
 =?utf-8?B?TVQ1dlF5WXhUVVNUaHdpQUY3U1NpZklMTkhOa1JtOWRMVXdsMVJGajAzUVlW?=
 =?utf-8?B?NDhUeW5jZXEvWWNPcGNGcjJtQ0xtS0pTc3pCbjk0M3I1b0Z1WENIbWhjdVlp?=
 =?utf-8?B?SldWcUd0MmRNNXhGVmlFSnhVMHd4bWdjVGpyZk1FckNaK00rNklOUzdCUTRu?=
 =?utf-8?B?RitBaEt2ai9tMXVzSE4vWENrNXBrTHN1VVpwYjNVbHNSWG4vcjVQcHdoTHFw?=
 =?utf-8?B?bVJSMmN1ZnN6SHVwYjVvNkFGazRza1k5Z2h6RWhVaExXL25QWFVPeXpYWjRy?=
 =?utf-8?B?dCs1NmF6VlJHMGtWZ0llK0EydFhSaWFqcUdKWlREQWE0ZEdaUlF6dXRHMTlt?=
 =?utf-8?B?c216Kzdmd1hoMnM1TUp6blZ6cEpmcXZFSnpFaklQWTJKNndPNUIwdWxVcWZo?=
 =?utf-8?B?K2c0a21LTlJWT0NGd0VDUnhEOThFQ1Z4TXErRndMQVhjTXhBYXN2cGhZWXZD?=
 =?utf-8?B?NzdzdEZhMUhncmV2WVBCSlJTTnBpWXQ2Qlc0M2RNTGJ6VldHZnZ1UVQ5R01t?=
 =?utf-8?B?OXhTcEErTHVCeXhUZ2RWVzJUWUd1a0UrYW1GSkJnWnhXc1JmOGplNzgzajI2?=
 =?utf-8?B?T3laZGlMTUFRQUl0L3I2d0x2R0g0S1pKbDEvOUhSSTZNeThsOGhxZDE1cVVW?=
 =?utf-8?B?Zkh6RWhSc1dYNlc4bHhzSTNnWk5Eb3VuYi9CSTdBNFhIdnZVZmVsZVlxaE1s?=
 =?utf-8?Q?S23C82TjaUJdo4m6cQURL1/IJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3072fae-ee65-4cfb-4da2-08db7cfe366c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 02:19:08.2518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrqMLF7jjEtB8F30HbH/6Xrm9kyF4UdVSFX62tTU40uxtLtMxNHoLUF4+AXHoYerFLbckeWOUd2rfYKK79F0bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7197
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



On 7/5/23 09:23, Yu Zhao wrote:
> On Tue, Jul 4, 2023 at 6:36 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 04/07/2023 04:59, Yu Zhao wrote:
>>> On Mon, Jul 3, 2023 at 9:02 PM Yu Zhao <yuzhao@google.com> wrote:
>>>>
>>>> On Mon, Jul 3, 2023 at 8:23 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 7/3/2023 9:53 PM, Ryan Roberts wrote:
>>>>>> arch_wants_pte_order() can be overridden by the arch to return the
>>>>>> preferred folio order for pte-mapped memory. This is useful as some
>>>>>> architectures (e.g. arm64) can coalesce TLB entries when the physical
>>>>>> memory is suitably contiguous.
>>>>>>
>>>>>> The first user for this hint will be FLEXIBLE_THP, which aims to
>>>>>> allocate large folios for anonymous memory to reduce page faults and
>>>>>> other per-page operation costs.
>>>>>>
>>>>>> Here we add the default implementation of the function, used when the
>>>>>> architecture does not define it, which returns the order corresponding
>>>>>> to 64K.
>>>>>>
>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>> ---
>>>>>>  include/linux/pgtable.h | 13 +++++++++++++
>>>>>>  1 file changed, 13 insertions(+)
>>>>>>
>>>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>>>> index a661a17173fa..f7e38598f20b 100644
>>>>>> --- a/include/linux/pgtable.h
>>>>>> +++ b/include/linux/pgtable.h
>>>>>> @@ -13,6 +13,7 @@
>>>>>>  #include <linux/errno.h>
>>>>>>  #include <asm-generic/pgtable_uffd.h>
>>>>>>  #include <linux/page_table_check.h>
>>>>>> +#include <linux/sizes.h>
>>>>>>
>>>>>>  #if 5 - defined(__PAGETABLE_P4D_FOLDED) - defined(__PAGETABLE_PUD_FOLDED) - \
>>>>>>       defined(__PAGETABLE_PMD_FOLDED) != CONFIG_PGTABLE_LEVELS
>>>>>> @@ -336,6 +337,18 @@ static inline bool arch_has_hw_pte_young(void)
>>>>>>  }
>>>>>>  #endif
>>>>>>
>>>>>> +#ifndef arch_wants_pte_order
>>>>>> +/*
>>>>>> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
>>>>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
>>>>>> + * to be at least order-2.
>>>>>> + */
>>>>>> +static inline int arch_wants_pte_order(struct vm_area_struct *vma)
>>>>>> +{
>>>>>> +     return ilog2(SZ_64K >> PAGE_SHIFT);
>>>>> Default value which is not related with any silicon may be: PAGE_ALLOC_COSTLY_ORDER?
>>>>>
>>>>> Also, current pcp list support cache page with order 0...PAGE_ALLOC_COSTLY_ORDER, 9.
>>>>> If the pcp could cover the page, the pressure to zone lock will be reduced by pcp.
>>>>
>>>> The value of PAGE_ALLOC_COSTLY_ORDER is reasonable but again it's a
>>>> s/w policy not a h/w preference. Besides, I don't think we can include
>>>> mmzone.h in pgtable.h.
>>>
>>> I think we can make a compromise:
>>> 1. change the default implementation of arch_has_hw_pte_young() to return 0, and
>>> 2. in memory.c, we can try PAGE_ALLOC_COSTLY_ORDER for archs that
>>> don't override arch_has_hw_pte_young(), or if its return value is too
>>> large to fit.
>>> This should also take care of the regression, right?
>>
>> I think you are suggesting that we use 0 as a sentinel which we then translate
>> to PAGE_ALLOC_COSTLY_ORDER? I already have a max_anon_folio_order() function in
>> memory.c (actually it is currently a macro defined as arch_wants_pte_order()).
>>
>> So it would become (I'll talk about the vma concern separately in the thread
>> where you raised it):
>>
>> static inline int max_anon_folio_order(struct vm_area_struct *vma)
>> {
>>         int order = arch_wants_pte_order(vma);
>>
>>         return order ? order : PAGE_ALLOC_COSTLY_ORDER;
>> }
>>
>> Correct?
>>
>> I don't see how it fixes the regression (assume you're talking about
>> Speedometer) though? On arm64 arch_wants_pte_order() will still be returning
>> order-4.
> 
> Here is what I was actually suggesting -- I think the problem was
> because contpte is a bit too large for that benchmark and for the page
> allocator too, unfortunately. The following allows one retry (32KB)
> before fallback to order 0 when using contpte (64KB). There is no
> retry for HPA (16KB) and other archs.
> 
> +       int preferred = arch_wants_pte_order(vma) ? : PAGE_ALLOC_COSTLY_ORDER;
> +       int orders[] = {
> +               preferred,
> +               preferred > PAGE_ALLOC_COSTLY_ORDER ?
> PAGE_ALLOC_COSTLY_ORDER : 0,
> +               0,
> +       };
> 
> I'm attaching a patch which fills in the two helpers I left empty here [1].
> 
> Would the above work for Intel, Fengwei?
PAGE_ALLOC_COSTLY_ORDER is Intel preferred because it fits the most common
Intel system. So yes. This works for Intel.


Regards
Yin, Fengwei

> 
> (AMD wouldn't need to override arch_wants_pte_order() since PTE
> coalescing on Zen is also PAGE_ALLOC_COSTLY_ORDER.)
> 
> [1] https://lore.kernel.org/linux-mm/CAOUHufaK82K8Sa35T7z3=gkm4GB0cWD3aqeZF6mYx82v7cOTeA@mail.gmail.com/2-anon_folios.patch
