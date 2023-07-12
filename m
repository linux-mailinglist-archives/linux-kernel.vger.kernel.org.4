Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AF874FF91
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjGLGo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjGLGoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:44:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C33211D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689144248; x=1720680248;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LxeDdNMJYvshSnqDFZS21O/cy42W/HqFGB6wO+e/ZxQ=;
  b=XOn5By0II++lGiyyUHdar1Lmx5dxkbf/8Xs8Zm+JnJSH5PxAcEc/JANR
   57fsGHOUgM6IcbZiBF89qi7AOPX0SS+3Y2HVSj1jDu9luy78CPTzkyjD9
   qfG2Vm1/Xy+ljPW0lKfyRHkNQCLnj2XSgTAsJvK8GoUIMMFYGtmD47nHa
   mWmL4tWmjO3dKcUBLFuM1BCo+n5+GEfXlSXQ02YZIK24pY4yswcdhWmkX
   zdy7oXc86K4P5czpQAplVgHrCS1RBja2ZVrrGHP2AQoS3rvCX0k+3XXk/
   0uwlOZ7KMF1oUOULuY9c6vUd4N1K5my8Z6r2qIW7XKJ9PeSrJD87hMf9y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="362282640"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="362282640"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 23:44:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="968107817"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="968107817"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jul 2023 23:44:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 23:44:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 23:44:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 23:44:06 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 23:44:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFi9bO94mf8r9ybSD2h6PofFP9FxzPpCtWO5z/QYdNAA34t/r0c+/HXE97nt98fOe8qvlsxCGK5G9Zrp9I0r5uGQC3loaJ2oGW9C3UPB5NwAdqYetIveI9oXUkogOyr9VW+ASieHLNosCoi9nH2FhXZRA57RwRd7ZurcYRq1M9lV06zgEGNKkrtjxWLnrTfdRlWYyKBY2wYmTe5NuxN7XwWVYTLevzwPJ7Rd2CZAR1ocLEGwLubTVFK1hJE92iUs4t/ZSTJC1bq1QCdl6xMO1VMr2FCHQHkE/VVxmsO62j6WqLBI149PFfGSf5WjX+tqL38G236trSVffGlhS8rcBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8RuiPYyTbHkBI1yXCD/m3RvQ1DvBGj9yMeYfR6+0Lg=;
 b=DQD9FE6ER6I19VG6OrSDtz0AQ0gwRQUzIanmplk3iXsyLl/d678Okv16D+sorKtnlMhjMR2NbMc/+NsSQOU8i9qW1DFPKrGx8Fq6vD63cLwzSnv6BB0MBkmCj6rwkx4DhrG880/MhdCTQ6+GHnoWlwEwyDLRn3KbkkwTy2iK2lIZGtjDWT2KTf8nuv6r5JVCkrbS9xIRAPD8yi306H8ZqKXtIytL7H6V8cljQuldnmcqn7uaF5kYWZNvlx1r7mKdAfVF/vcpH0vGtf8o/od3pNfL5+pqcmnFwCQtu//VCnVqDzldaFR+TSKidTkk01UlkokAsUhP2l+5+WVuZphUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by IA1PR11MB6073.namprd11.prod.outlook.com (2603:10b6:208:3d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 06:44:04 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 06:44:04 +0000
Message-ID: <6cc5a915-a28c-983f-9b32-6040f033970b@intel.com>
Date:   Wed, 12 Jul 2023 14:43:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 2/3] mm: handle large folio when large folio in
 VM_LOCKED VMA range
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>, <hughd@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <david@redhat.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-3-fengwei.yin@intel.com>
 <CAOUHufZQ0EpyRZ_jAMxs8uNSQOz6uAkzVjvvgD+4wBvmgHJoCA@mail.gmail.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufZQ0EpyRZ_jAMxs8uNSQOz6uAkzVjvvgD+4wBvmgHJoCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|IA1PR11MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 91303ea7-bd51-41bf-fec3-08db82a3625e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L5sdryPVe2Zv8bpVaTRvCdrNxCDiSsWIzRWwRXUhxN5kj9E6/Y/M/tdf+toXQw6Ejkr2apbFRGyo//oX4IgIRytt4ur9rTvkS3MrcZOdEwiwiRWU7BbbNneTsszkYLluhIaG6cyNB5VDez+LCz1u8kzVsN1dyCh1h9zmMsCcAZKoRCsQhl4B04BggkoXzWR5wKjkzC/x2gfnV9oICcPQI8mF6qpzuT+k7zu7w1kbKwFWJ5YmJiGnBO2AmADmWAC17R92DP5dY8OuOewaXThjuKqkX0UVS0+GfC8AOejJqhUf46v+WCAjhK0zgP2ulqNwf9KQvh51jEEVjvFyjUiOLCpEdAqhh9//3SeBw+tpQzRcyuwR1FRaDztWFocNs0a7rD3COXioMh9Uvj5h8IRLLP44emk4AfC+4Ew4UAmysgtIDOpqxELwq8cR9S4wCECVgqrzGretzsTVp29BTafM3s8t2bBKMRWsiGC0iGWR7pVE+97MATsqXMCwWhnt6wHv1eldx8UZX2H6MZUzafVJIWin0C56V5/UhB6M4U00xY/W71HzEwV+nEU9LNoy24legFO19+GX33VmtiE60Gnnnlb8766kpYn1blECui0O4sU83X7cXknwPSby21Ieb+owV3kz69TzPfPy54pGcAlVrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199021)(8936002)(8676002)(83380400001)(2906002)(2616005)(36756003)(38100700002)(82960400001)(31696002)(86362001)(53546011)(26005)(5660300002)(6506007)(186003)(31686004)(6666004)(66476007)(66556008)(4326008)(6486002)(66946007)(41300700001)(6512007)(316002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Kzh2QTNYK2lDRFdpWW5DRENtY01KSkNYQ0g4WnpPemNnTUVkRFZST25zbmM2?=
 =?utf-8?B?SXFNYUpEU0JqbHpxSGVySTdlUllLb1Z3UXRReFdHbmRjcWl4cktYa0JhWTVM?=
 =?utf-8?B?dVVoYXdDT0Q0a0RBTWlhaktTa0dxaVcrb3VtcHVxREdvYTZyOEdqOE96MlNR?=
 =?utf-8?B?dFlPVHlxOFFEYWpFTmxBQ0ZLNGVmUlBlMkRvNUZFZmdpS0wwVVdTNGxmZTls?=
 =?utf-8?B?Q3BoOWlDR1dhbmh1Ry9mTUpweFB0dFdiKzZBTFRUQUcvMlhwR1NMMWpja0lL?=
 =?utf-8?B?WjRPblBta0YrYS9HbUJUeHgxckdwWVlUTVo2VFM4R3RoZXY5YXVSWGRlbTI4?=
 =?utf-8?B?c2k0Wndldm4vM1FZeW5QV3hObTN5SHN1dm56Q2Rwa0pPRDlqNDFVRUh2Ym5r?=
 =?utf-8?B?SnYrMXdzSjQ3WXFIbW5WMDhzSkh0MWtOUU5uM3BhQWsxQnVpVWtidk9meGZv?=
 =?utf-8?B?ZTZsamVJRnJOTmh0VnUzQkE4aU1ML3dPWmVTZ3R2OUJwR204by8rMWEwVFhM?=
 =?utf-8?B?ZDJLZ0o2S0x3NzRITldORHYxQWtqVWhDdjFiaFRhb2ZFck1ncklBSVRRcHpv?=
 =?utf-8?B?Nnkzek8vUVBQb2Y3VG5aaFRjWm5UWkxvczhsZ3lRNXRzUmFCTWtGc3dDVmRW?=
 =?utf-8?B?dXN1QVVMWFQ2dENWdFBOYnc4WG1ZVEhPenpuUHd6QWtDS0M3TFJQd092Ujln?=
 =?utf-8?B?c01ndW9GNWV5cGoyV1c2Wmx2QVF1NWxrSm96cG9ab3N0b3EweThlc2ZQUjFy?=
 =?utf-8?B?Q2prcHkyNjM4V0lrK0pMQWpaOElrZkxPRnh2TE5yTUxaUDdoNko2YzFHSllz?=
 =?utf-8?B?U1doTlBQOEFOV3g4b3RrQkRCMFMxbzZnU25CRE9SUFhIZ2NRNmt2bTNyVEkz?=
 =?utf-8?B?TzAwbHpKU0xOTm8zdUphS1RiblJzTTRrRlNzQzNZc09kT3NEZURYZEx6dDhx?=
 =?utf-8?B?S3ZoSDRJc1hqa0NXRFZrZzdqS0dDbXErNHk2ZVhmZktLem81dlk4cDVaRGZy?=
 =?utf-8?B?Q2w1ek5BekcxMzNwTnh3VkcrYjF4bUd5YTlKcklYeWs3c211T0l3YTE5M0xE?=
 =?utf-8?B?UkpIVW41aFFGbFFST2c2V2s1NlU2RVVwSlhkSlNQd0o3czkxb3RzNURjN3Bi?=
 =?utf-8?B?Wjd6U1RocS9RbDNKZU1icTFXK3c1VnRwdDhHS0JpTU1zdEN2c3JOa2lRRURI?=
 =?utf-8?B?aS9DNDVPMzNIVXdoaVM3aDZSc2tpcE1wRDN0M2xsVWRwN1pOZStld3U5SEw2?=
 =?utf-8?B?KzB4Z0FzS003dmRvWVVjbzgrL1p4NlRia25CZUpHbFpTbjlxQWl5bTgwSDV1?=
 =?utf-8?B?NkF2WmcrWGhmdTMzajhGOGtSWU5WODlhNnVQZk11bVQxNUlocnNDNmVjakpU?=
 =?utf-8?B?YndEM0VzMkIxQktvQWl2WW1jeVVHMDFhc2RIWkVyS01BOHVGZzR0Wnp3Z2xr?=
 =?utf-8?B?eXFMNFdoSURFY3l5cDNRSmxYRXRISENkc0xCZ0RyNXNnWHdpaGJNY1ZBNHZR?=
 =?utf-8?B?VU91ckZTeVVQa2FFYkFyQ1Vqd2NKK3NhZ2xseitPRTNpV0tIQW9PRzRld0M2?=
 =?utf-8?B?ODYrc3J6eDlRRi85UzlRbVZKMS96U3RjZmNtK1BHcWFXdVNicGlsNG52SFJV?=
 =?utf-8?B?Vlpla0s5RWtPQnY1UExOZ2xCcXNiMGFaNTF1ZmRDQWJNdTR3QU5lM1JuUEgx?=
 =?utf-8?B?Y0lxcnpoemxhaVhWcDNDVmI5cDVROUl6S0lrV2tra2MxNHNDa2cwbEV6Rjcw?=
 =?utf-8?B?NTBLUDdWR2RrdDVDVTdTdXYwSC9SdEhhSmlHTndQenhtMUI0bjFLM0MzUU9s?=
 =?utf-8?B?T2d1SHByWnNPMXJaK2FGQzV4OExIWVlEM1QzUTdLdTJrbzgwcFp1aG5PS3Aw?=
 =?utf-8?B?ZHlFVlVYVlBCV0VoMGgyT2xVMC9MU3NJTjcxdHJTbVJteThUVVBXcGFnQzRP?=
 =?utf-8?B?WmtjVC9VbjVqSGhzTmdHaW1QMG1jbklhUDZZOFpkRWhKUnVoeXpNZFVuVmRw?=
 =?utf-8?B?cDBsNW5KRzJaU0IxWm8rVVpVRGg4U29WeS9FU3JzSjI2WGpHTUV5MWpTcDB2?=
 =?utf-8?B?RTBkQmtiYnNmeDdhTWY5elk4bjFzaHNKODB2Sy8rWmZLV1dxdGh4citGUWhT?=
 =?utf-8?Q?+a3Psz/u79h7KtMwGXFgLGTVq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91303ea7-bd51-41bf-fec3-08db82a3625e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:44:04.6631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IG4LjBLUetTAHar9R4DctnNDpl1V2v+mosUvOa9O9HMxxmkN16ZWcy34PUYLa/ZVzeXmzcpcee1E0jOnarwxyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6073
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/23 14:23, Yu Zhao wrote:
> On Wed, Jul 12, 2023 at 12:02 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>> If large folio is in the range of VM_LOCKED VMA, it should be
>> mlocked to avoid being picked by page reclaim. Which may split
>> the large folio and then mlock each pages again.
>>
>> Mlock this kind of large folio to prevent them being picked by
>> page reclaim.
>>
>> For the large folio which cross the boundary of VM_LOCKED VMA,
>> we'd better not to mlock it. So if the system is under memory
>> pressure, this kind of large folio will be split and the pages
>> ouf of VM_LOCKED VMA can be reclaimed.
>>
>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>> ---
>>  mm/internal.h | 11 ++++++++---
>>  mm/rmap.c     | 34 +++++++++++++++++++++++++++-------
>>  2 files changed, 35 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index c7dd15d8de3ef..776141de2797a 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -643,7 +643,8 @@ static inline void mlock_vma_folio(struct folio *folio,
>>          *    still be set while VM_SPECIAL bits are added: so ignore it then.
>>          */
>>         if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) == VM_LOCKED) &&
>> -           (compound || !folio_test_large(folio)))
>> +           (compound || !folio_test_large(folio) ||
>> +           folio_in_range(folio, vma, vma->vm_start, vma->vm_end)))
>>                 mlock_folio(folio);
>>  }
> 
> This can be simplified:
> 1. remove the compound parameter
Yes. There is not difference here for pmd mapping of THPs and pte mappings of THPs
if the only condition need check is whether the folio is within VMA range or not.

But let me add Huge for confirmation.


> 2. make the if
>         if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) == VM_LOCKED) &&
>             folio_within_vma())
>                 mlock_folio(folio);
!folio_test_large(folio) was kept here by purpose. For normal 4K page, don't need
to call folio_within_vma() which is heavy for normal 4K page.


> 
>> @@ -651,8 +652,12 @@ void munlock_folio(struct folio *folio);
>>  static inline void munlock_vma_folio(struct folio *folio,
>>                         struct vm_area_struct *vma, bool compound)
> 
> Remove the compound parameter here too.
> 
>>  {
>> -       if (unlikely(vma->vm_flags & VM_LOCKED) &&
>> -           (compound || !folio_test_large(folio)))
>> +       /*
>> +        * To handle the case that a mlocked large folio is unmapped from VMA
>> +        * piece by piece, allow munlock the large folio which is partially
>> +        * mapped to VMA.
>> +        */
>> +       if (unlikely(vma->vm_flags & VM_LOCKED))
>>                 munlock_folio(folio);
>>  }
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 2668f5ea35342..455f415d8d9ca 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -803,6 +803,14 @@ struct folio_referenced_arg {
>>         unsigned long vm_flags;
>>         struct mem_cgroup *memcg;
>>  };
>> +
>> +static inline bool should_restore_mlock(struct folio *folio,
>> +               struct vm_area_struct *vma, bool pmd_mapped)
>> +{
>> +       return !folio_test_large(folio) ||
>> +                       pmd_mapped || folio_within_vma(folio, vma);
>> +}
> 
> This is just folio_within_vma() :)
> 
>>  /*
>>   * arg: folio_referenced_arg will be passed
>>   */
>> @@ -816,13 +824,25 @@ static bool folio_referenced_one(struct folio *folio,
>>         while (page_vma_mapped_walk(&pvmw)) {
>>                 address = pvmw.address;
>>
>> -               if ((vma->vm_flags & VM_LOCKED) &&
>> -                   (!folio_test_large(folio) || !pvmw.pte)) {
>> -                       /* Restore the mlock which got missed */
>> -                       mlock_vma_folio(folio, vma, !pvmw.pte);
>> -                       page_vma_mapped_walk_done(&pvmw);
>> -                       pra->vm_flags |= VM_LOCKED;
>> -                       return false; /* To break the loop */
>> +               if (vma->vm_flags & VM_LOCKED) {
>> +                       if (should_restore_mlock(folio, vma, !pvmw.pte)) {
>> +                               /* Restore the mlock which got missed */
>> +                               mlock_vma_folio(folio, vma, !pvmw.pte);
>> +                               page_vma_mapped_walk_done(&pvmw);
>> +                               pra->vm_flags |= VM_LOCKED;
>> +                               return false; /* To break the loop */
>> +                       } else {
> 
> There is no need for "else", or just
> 
>   if (!folio_within_vma())
>     goto dec_pra_mapcount;
I tried not to use goto as much as possible. I suppose you mean:

    if (!should_restore_lock())
        goto dec_pra_mapcount; (I may use continue here. :)).

    mlock_vma_folio();
    page_vma_mapped_walk_done()
   ...

Right?


Regards
Yin, Fengwei

> 
>> +                               /*
>> +                                * For large folio cross VMA boundaries, it's
>> +                                * expected to be picked  by page reclaim. But
>> +                                * should skip reference of pages which are in
>> +                                * the range of VM_LOCKED vma. As page reclaim
>> +                                * should just count the reference of pages out
>> +                                * the range of VM_LOCKED vma.
>> +                                */
>> +                               pra->mapcount--;
>> +                               continue;
>> +                       }
>>                 }
