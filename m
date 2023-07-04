Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E16747A6D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 01:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjGDXgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 19:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjGDXgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 19:36:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8148610E0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 16:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688513776; x=1720049776;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l7wff/OLaL+UjEQH9V9E0qN3i+/k/nDaWMeViiAlY04=;
  b=Oqx/GP7L5IgEhvYgNZvfPg75In+WNTd3dTYsOOQUUkWlD0QoCt2d+EIx
   xZK2qimbbr/K5dLczvK/0IctF1PWNYhi+/x5/l9XLXPD6KsvFW0k8bRTa
   /iiljXn3v3mJtkOOdQPn5nrpV81bGJo7Q/YHLjfXbIprhFSAng5XddEOh
   zHWuwGFRSHHOy6QpaW8qcdjRAavu1PqFEhI4D0jYY0pRnKwYriI5SQsht
   SA7FGRCInJvfkXRlXtozlIFKx7hTnCx8i8I3quG5FxIFRNtGgeAXGieIl
   sBSQs0O5FEJbAWxOFDunZ97tueBbgMpcrExSyd58sbXQ36wzmCQ5pk9Qi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="360685715"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="360685715"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 16:36:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="784332476"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="784332476"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jul 2023 16:36:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 16:36:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 16:36:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 4 Jul 2023 16:36:12 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 4 Jul 2023 16:36:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSy4oUGwQGApXOKtTL63E26RePuf3f6ZqdqK+zge/w40gtVGsPF8FtMNDRKGTLJhX9ARm1KrSbfadQejbRsOKx9DFdrrovpHe5/w1uHpaI3pqKSdshhnO1+HOitlMCurRhuriwEcpO/P4ZzrjuLLXiWtSTGBWq871D6eMCL480u4WK5Ctq1advQyK/F+dG/UQjBYkZAL9fgyvm0Zu046GHgP+oC5KTxfkAfnafikeK2bqhuwNzXBZ0mWmwnzt+gRjOQvoLKZobx1IRoWAsVxR8A5TAobNNZZW+DKof80ueqNXfbUoBypsqu29yQei+J4AEoRnHFY99KK5SrDRe8LKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaJffq0s4zbXE7jgi5+hPn2uSL5JiCLRTRKRn1vX7Pw=;
 b=RrmMrn2kqNS3TR76IKcb7ydC3X8/v/SttcLWoj/qlohFFt8fDBI6dLxdLa5gpp6HV4YY9P4uauDaL/4cVWnPa4flJWv1CQ9QBDc8T/li5+eGHrr+gjgPjUphIMwUuf4BgZ+XaIkt+gy/sbMLYlcVTLYZY5x81Ut7h96frAxCb98zHDKDmDnDMbCHISdvEvtMXIC/94VrqxMo0yCRxlSnZfTTqQaHFkENHYmq8EoxHORSQze5k+Uu2zSakRbe/3A9qDcrLlrZUcY8HVslYWyS7bW1t8IT5d4b3eV1cdZrVCO/xCDLCGIFmN7jD0izXWTX8aFSTRhMB9Mx68K7KXnRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM4PR11MB5229.namprd11.prod.outlook.com (2603:10b6:5:39f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 23:36:04 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6565.016; Tue, 4 Jul 2023
 23:35:58 +0000
Message-ID: <6518ca1a-ad7e-479b-71af-dffc120a0323@intel.com>
Date:   Wed, 5 Jul 2023 07:35:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/5] mm: FLEXIBLE_THP for improved performance
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-5-ryan.roberts@arm.com>
 <6865a59e-9e40-282d-c434-b7c757388b65@intel.com>
 <f364d9f1-8f7b-f531-ab9e-400c57a60c16@arm.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <f364d9f1-8f7b-f531-ab9e-400c57a60c16@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DM4PR11MB5229:EE_
X-MS-Office365-Filtering-Correlation-Id: 76224b3e-dc88-48ef-235c-08db7ce76b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgVUrp8oYKuoJCt+NMIGjtR4LUFA0sFdcIE3j3ub0cTUraMUN8rBId6ESnyI7hGfqFLKYmx3vhRnZH96RpcZuVu/kV4Q07jcotZVCXnFLG2QrMs9XwbnEP+VczQu7qmzVitkcl0v6pd/wvPjxSkdkp9VLx9ywNY1eqHZQqxaM9UegLr1dNtfWrGB/HK2qu5tvbGJswh477lTOoZzTIv78yHomDKm5mz2U6n9OaYTXELH9+OX8x2ZL79wzHVZrkai+UytJlLNmY9umdxTsJsbQGd5LAccAI3wMi+fjj1YkO8SgpJJmjCxG/BVZSvAYoVfz6QVhemB4m/xQy/Qx7FXDOGTlVsvj5zS3xbOZ0qO8y+YE4Wm4bFc07OFleLtdB5RpoDUMWDXmS+UpBa9ZeAmhf3KucWovC3mgOdQJjK5LUE702DcYAjbdkGMbQTd4pjTbyiRWLUFvERcrKwn29YoqWcX9zUXzEifefUeFAeQGNfLcSg2B6ODrueDMm6K5rvi5YTvW5+At826TY3kBqITuz7H+D3A6TUa5UtWPFlzjSGnOYL0wtNcwiQgaihSg2WN/O4s/IkztsolP13XF6BnhgGl1ytw6E220jekwbU9Niprz7lZC+oA2vqRZ6hzT7bMv3nv3ts/UgkQgH4VTsRGAOsu4KR+DYWSkRVC5U03vxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199021)(31686004)(478600001)(26005)(82960400001)(6666004)(6506007)(6512007)(31696002)(86362001)(2616005)(186003)(53546011)(38100700002)(66946007)(4326008)(66556008)(66476007)(921005)(110136005)(83380400001)(6486002)(316002)(8676002)(8936002)(7416002)(30864003)(41300700001)(2906002)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3ZnTDdLTXRqeDQzY2xhVkdodXFyVE1GazlWRlBBby9Rd0diYXpkeWcwZnoz?=
 =?utf-8?B?bWRqN0tDb2dWMy9ON2h5V3YrOEhuak1ZakFNb0hxMG8rS3RRZmdOVWhtRmda?=
 =?utf-8?B?R0dSeDllaU45dmo0OEgrNXZtRVZBSWZUNjFyTFJoYjVXbDhHakZZUFErUjhY?=
 =?utf-8?B?N21oa1NWQ1RuZElmTDhHemxNTnF3UUl3ZGtNWUdtWldUWEZUM2t6TzQxMDhm?=
 =?utf-8?B?cE1QYWxxSnFiaHlCb2w5eGREWTc4cE9TUmNsZmw5MWUrT0ZPbENiczN6aXc1?=
 =?utf-8?B?UGlwZFRyR1ZldjRQazJVeDhBdHg3M2pVazBaSW83OGlmUEZBb0wvaFFjYkVB?=
 =?utf-8?B?dklyM2dYYXJ2eGtJWFNDdlJ4NFQwVVpMKzY4cG1qWTh2a0NKOGtydm5HUEpq?=
 =?utf-8?B?Unh1RGI5a2NUTVRPdVh6MG90MXQxcUNWUlhnR2FtTXBGQU41OGs0aHM3UU0y?=
 =?utf-8?B?VndWbWI5QUZZTXViQkpkSWQ5ZExFYzlkbVlLYVVobTA1UWgwVGFoN3J0dWxN?=
 =?utf-8?B?OGEwNXhQNzJmZE0vVERLVkQ2R1V4U3JkZ2t3UFBsVmFIbmZLNUh4RmZ2ZUNK?=
 =?utf-8?B?SDExK2hrZzcwRytvTjBjR2JnOElFRmZkUC9xWm9xVlpmN3BIVUZWQkpDZ2F5?=
 =?utf-8?B?eUdBeUc2alEyLzZGQWxrcU1lQThyQ3JsRDc5ZTFrVVFtTS9CT3U4MklUeUNi?=
 =?utf-8?B?TmI2S3ExelAyLzJrUXdTMXR1cXNIaVhlcE8xTm5aVVYwU2t3SXRCRmcyWHQx?=
 =?utf-8?B?VmdiQW1hWWljMXhFL21JZVBNMk1HUERwM3Q4d29iS0YxOGNseHNaZXhFOVli?=
 =?utf-8?B?L2xWelkwQ0ZWeGhEd1E5Wm4vaHBhT0VvNm5URHZrakdKMGxPYzRGQ3ZEWFJh?=
 =?utf-8?B?clRnMytpWTAxK2dQZnIrcDgzSS9iTVlGd2tjTUdjUVBicUZZWHVzSWRqZ2Ev?=
 =?utf-8?B?UUh5YzFLMlBwZ0JacjkyRWw1YnlPZVlnNXNSMUFnSUNiZWtkdmcvemhHVFhh?=
 =?utf-8?B?NTF5cTlWbXpSSUdwU3ZNNGRrbzFIak9WNWt3THBrdVhiZ3hNZDN3VTZtbVJM?=
 =?utf-8?B?QlNsTGdDR3VtYnM5eThLdVN2ZVVCa2lGSTI3eERFMUlkTmJIUVh3Q2hma3Fl?=
 =?utf-8?B?SUlTTzhYcmNWN3MrNS9kbDVvdWxwL2YzTDhHaDJrRWRtV2ZUa0QydFJFUTBM?=
 =?utf-8?B?a0FUWUtkSzFhdFd6enhHUVRhSkU4ZHcyNEt5SjF4dEJYYUpqb21pN1F3UFZR?=
 =?utf-8?B?cTJOcGxQa3FBL2Y3UjNucDdaT1UyZ0R1OHVtdmFJeUpONmlubkt1Qi9CMXVw?=
 =?utf-8?B?dGNkdFZ3eHlCWVJ2cG1nSjRZUVlxS2ZUT0hKRHh3bXl5dWZTWnBlblBJM3Nx?=
 =?utf-8?B?eUtOVVA4UkdGTHhkOXJST1ZRd0c5U095UisvbWVJUmRpcnkzNDAzVEZCN0hp?=
 =?utf-8?B?SzJQcDFVL0xmQzJscGNEbEVoY2ZsTlB2VVkyM0dOWEwrT2ZoOE1FeVVXT0hz?=
 =?utf-8?B?UjJTa21GcXBpTWM4SWZKSTFOYUFoR2x6eUdMKzl4Q1NzQU5ndmdiRm4vc0tQ?=
 =?utf-8?B?TjVXdmp3eGo0RUJCb2YyVGtlQmZzb0VSTHI1bkRWS0NPTngzRVBCeFJ4NU94?=
 =?utf-8?B?dUx2dlh6dlFjVTZaT3o5UkYrdVZJdHFPajJTNmw5S203NjIrN1g3ZEJmaVdT?=
 =?utf-8?B?TlVzbHZScWJlRUQrcko3NHlobHN1dkEvaWN5eWI2YnZKRXg3MUI2K1R0S3Jn?=
 =?utf-8?B?Qk54eEdoK1ArZlJ3UWdZd1Q2YXI0UC92bjR0OVlzQXFBQmRzZjNQRTVNbGNu?=
 =?utf-8?B?UzQwNXJCQ3JpZVVybjBpVFd3VG90YnhVWFMxNEJST1lKQmc3Qk5RRjd2WkZk?=
 =?utf-8?B?UnZSWmw0NFBOMTB1UkhGRW5UQmh5TkFvaDBCUkQ3RERuOWlxZFJPbkNoeFpE?=
 =?utf-8?B?NWs4bWFCeGRZWEYxRFdLVFp3SlFLdTdqN1ZZR0F4MUxidm9YVmJuRFROL1NQ?=
 =?utf-8?B?VEtTcTNjTkQ3WWFIbXRIRk9wcnh0ZktjS3lQVCs1ZjBNWVJKMUw2ZW0rQ2px?=
 =?utf-8?B?Umo3elRwak5FSWpIY2oxZWRVNW92NUxySHVSd2QzY2JMZ3Q4UHdreTgvWXND?=
 =?utf-8?B?VndwVWRLek1FMUxMR2Q0eExpRjdVVi9HTkp6UHVrTDY2dXplYjUwWmVUL0Q5?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76224b3e-dc88-48ef-235c-08db7ce76b52
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 23:35:58.3677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wV3H6OoNxxHAxBtTvJb3pjwKSUEkP3d0bzTtDjjxV/hqBgjrISoqVtE3KQgYNyGlM4Hp9MzdDMtSKcfQlilcFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5229
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



On 7/4/23 22:20, Ryan Roberts wrote:
> On 04/07/2023 04:45, Yin, Fengwei wrote:
>>
>> On 7/3/2023 9:53 PM, Ryan Roberts wrote:
>>> Introduce FLEXIBLE_THP feature, which allows anonymous memory to be
>> THP is for huge page which is 2M size. We are not huge page here. But
>> I don't have good name either.
> 
> Is that really true? On arm64 with 16K pages, huge pages are 32M and with 64K
> base page, they are 512M. So huge pages already have a variable size. And they
> sometimes get PTE-mapped. So can't we just think of this as an extension of the
> THP feature?
My understanding is the THP has several fixed size on different arch.
The 32K or 16K which could be picked here are not THP size.

> 
>>
>>> allocated in large folios of a specified order. All pages of the large
>>> folio are pte-mapped during the same page fault, significantly reducing
>>> the number of page faults. The number of per-page operations (e.g. ref
>>> counting, rmap management lru list management) are also significantly
>>> reduced since those ops now become per-folio.
>>>
>>> The new behaviour is hidden behind the new FLEXIBLE_THP Kconfig, which
>>> defaults to disabled for now; there is a long list of todos to make
>>> FLEXIBLE_THP robust with existing features (e.g. compaction, mlock, some
>>> madvise ops, etc). These items will be tackled in subsequent patches.
>>>
>>> When enabled, the preferred folio order is as returned by
>>> arch_wants_pte_order(), which may be overridden by the arch as it sees
>>> fit. Some architectures (e.g. arm64) can coalsece TLB entries if a
>>> contiguous set of ptes map physically contigious, naturally aligned
>>> memory, so this mechanism allows the architecture to optimize as
>>> required.
>>>
>>> If the preferred order can't be used (e.g. because the folio would
>>> breach the bounds of the vma, or because ptes in the region are already
>>> mapped) then we fall back to a suitable lower order.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>  mm/Kconfig  |  10 ++++
>>>  mm/memory.c | 168 ++++++++++++++++++++++++++++++++++++++++++++++++----
>>>  2 files changed, 165 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index 7672a22647b4..1c06b2c0a24e 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -822,6 +822,16 @@ config READ_ONLY_THP_FOR_FS
>>>  	  support of file THPs will be developed in the next few release
>>>  	  cycles.
>>>  
>>> +config FLEXIBLE_THP
>>> +	bool "Flexible order THP"
>>> +	depends on TRANSPARENT_HUGEPAGE
>>> +	default n
>>> +	help
>>> +	  Use large (bigger than order-0) folios to back anonymous memory where
>>> +	  possible, even if the order of the folio is smaller than the PMD
>>> +	  order. This reduces the number of page faults, as well as other
>>> +	  per-page overheads to improve performance for many workloads.
>>> +
>>>  endif # TRANSPARENT_HUGEPAGE
>>>  
>>>  #
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index fb30f7523550..abe2ea94f3f5 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -3001,6 +3001,116 @@ static vm_fault_t fault_dirty_shared_page(struct vm_fault *vmf)
>>>  	return 0;
>>>  }
>>>  
>>> +#ifdef CONFIG_FLEXIBLE_THP
>>> +/*
>>> + * Allocates, zeros and returns a folio of the requested order for use as
>>> + * anonymous memory.
>>> + */
>>> +static struct folio *alloc_anon_folio(struct vm_area_struct *vma,
>>> +				      unsigned long addr, int order)
>>> +{
>>> +	gfp_t gfp;
>>> +	struct folio *folio;
>>> +
>>> +	if (order == 0)
>>> +		return vma_alloc_zeroed_movable_folio(vma, addr);
>>> +
>>> +	gfp = vma_thp_gfp_mask(vma);
>>> +	folio = vma_alloc_folio(gfp, order, vma, addr, true);
>>> +	if (folio)
>>> +		clear_huge_page(&folio->page, addr, folio_nr_pages(folio));
>>> +
>>> +	return folio;
>>> +}
>>> +
>>> +/*
>>> + * Preferred folio order to allocate for anonymous memory.
>>> + */
>>> +#define max_anon_folio_order(vma)	arch_wants_pte_order(vma)
>>> +#else
>>> +#define alloc_anon_folio(vma, addr, order) \
>>> +				vma_alloc_zeroed_movable_folio(vma, addr)
>>> +#define max_anon_folio_order(vma)	0
>>> +#endif
>>> +
>>> +/*
>>> + * Returns index of first pte that is not none, or nr if all are none.
>>> + */
>>> +static inline int check_ptes_none(pte_t *pte, int nr)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = 0; i < nr; i++) {
>>> +		if (!pte_none(ptep_get(pte++)))
>>> +			return i;
>>> +	}
>>> +
>>> +	return nr;
>>> +}
>>> +
>>> +static int calc_anon_folio_order_alloc(struct vm_fault *vmf, int order)
>>> +{
>>> +	/*
>>> +	 * The aim here is to determine what size of folio we should allocate
>>> +	 * for this fault. Factors include:
>>> +	 * - Order must not be higher than `order` upon entry
>>> +	 * - Folio must be naturally aligned within VA space
>>> +	 * - Folio must be fully contained inside one pmd entry
>>> +	 * - Folio must not breach boundaries of vma
>>> +	 * - Folio must not overlap any non-none ptes
>>> +	 *
>>> +	 * Additionally, we do not allow order-1 since this breaks assumptions
>>> +	 * elsewhere in the mm; THP pages must be at least order-2 (since they
>>> +	 * store state up to the 3rd struct page subpage), and these pages must
>>> +	 * be THP in order to correctly use pre-existing THP infrastructure such
>>> +	 * as folio_split().
>>> +	 *
>>> +	 * Note that the caller may or may not choose to lock the pte. If
>>> +	 * unlocked, the result is racy and the user must re-check any overlap
>>> +	 * with non-none ptes under the lock.
>>> +	 */
>>> +
>>> +	struct vm_area_struct *vma = vmf->vma;
>>> +	int nr;
>>> +	unsigned long addr;
>>> +	pte_t *pte;
>>> +	pte_t *first_set = NULL;
>>> +	int ret;
>>> +
>>> +	order = min(order, PMD_SHIFT - PAGE_SHIFT);
>>> +
>>> +	for (; order > 1; order--) {
>>> +		nr = 1 << order;
>>> +		addr = ALIGN_DOWN(vmf->address, nr << PAGE_SHIFT);
>>> +		pte = vmf->pte - ((vmf->address - addr) >> PAGE_SHIFT);
>>> +
>>> +		/* Check vma bounds. */
>>> +		if (addr < vma->vm_start ||
>>> +		    addr + (nr << PAGE_SHIFT) > vma->vm_end)
>>> +			continue;
>>> +
>>> +		/* Ptes covered by order already known to be none. */
>>> +		if (pte + nr <= first_set)
>>> +			break;
>>> +
>>> +		/* Already found set pte in range covered by order. */
>>> +		if (pte <= first_set)
>>> +			continue;
>>> +
>>> +		/* Need to check if all the ptes are none. */
>>> +		ret = check_ptes_none(pte, nr);
>>> +		if (ret == nr)
>>> +			break;
>>> +
>>> +		first_set = pte + ret;
>>> +	}
>>> +
>>> +	if (order == 1)
>>> +		order = 0;
>>> +
>>> +	return order;
>>> +}
>> The logic in above function should be kept is whether the order fit in vma range.
>>
>> check_ptes_none() is not accurate here because no page table lock hold and concurrent
>> fault could happen. So may just drop the check here? Check_ptes_none() is done after
>> take the page table lock.
> 
> I agree it is just an estimate given the lock is not held; the comment at the
> top says the same. But I don't think we can wait until after the lock is taken
> to measure this. We can't hold the lock while allocating the folio and we need a
> guess at what to allocate. If we don't guess here, we will allocate the biggest,
> then take the lock, see that it doesn't fit, and exit. Then the system will
> re-fault and we will follow the exact same path - ending up in live lock.
It will not if we try order0 immediately. But see my comments to the refault.

> 
>>
>> We pick the arch prefered order or order 0 now.
>>
>>> +
>>>  /*
>>>   * Handle write page faults for pages that can be reused in the current vma
>>>   *
>>> @@ -3073,7 +3183,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>>>  		goto oom;
>>>  
>>>  	if (is_zero_pfn(pte_pfn(vmf->orig_pte))) {
>>> -		new_folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
>>> +		new_folio = alloc_anon_folio(vma, vmf->address, 0);
>>>  		if (!new_folio)
>>>  			goto oom;
>>>  	} else {
>>> @@ -4040,6 +4150,9 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>  	struct folio *folio;
>>>  	vm_fault_t ret = 0;
>>>  	pte_t entry;
>>> +	int order;
>>> +	int pgcount;
>>> +	unsigned long addr;
>>>  
>>>  	/* File mapping without ->vm_ops ? */
>>>  	if (vma->vm_flags & VM_SHARED)
>>> @@ -4081,24 +4194,51 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>  			pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>  			return handle_userfault(vmf, VM_UFFD_MISSING);
>>>  		}
>>> -		goto setpte;
>>> +		if (uffd_wp)
>>> +			entry = pte_mkuffd_wp(entry);
>>> +		set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
>>> +
>>> +		/* No need to invalidate - it was non-present before */
>>> +		update_mmu_cache(vma, vmf->address, vmf->pte);
>>> +		goto unlock;
>>> +	}
>>> +
>>> +	/*
>>> +	 * If allocating a large folio, determine the biggest suitable order for
>>> +	 * the VMA (e.g. it must not exceed the VMA's bounds, it must not
>>> +	 * overlap with any populated PTEs, etc). We are not under the ptl here
>>> +	 * so we will need to re-check that we are not overlapping any populated
>>> +	 * PTEs once we have the lock.
>>> +	 */
>>> +	order = uffd_wp ? 0 : max_anon_folio_order(vma);
>>> +	if (order > 0) {
>>> +		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
>>> +		order = calc_anon_folio_order_alloc(vmf, order);
>>> +		pte_unmap(vmf->pte);
>>>  	}
>>>  
>>> -	/* Allocate our own private page. */
>>> +	/* Allocate our own private folio. */
>>>  	if (unlikely(anon_vma_prepare(vma)))
>>>  		goto oom;
>>> -	folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
>>> +	folio = alloc_anon_folio(vma, vmf->address, order);
>>> +	if (!folio && order > 0) {
>>> +		order = 0;
>>> +		folio = alloc_anon_folio(vma, vmf->address, order);
>>> +	}
>>>  	if (!folio)
>>>  		goto oom;
>>>  
>>> +	pgcount = 1 << order;
>>> +	addr = ALIGN_DOWN(vmf->address, pgcount << PAGE_SHIFT);
>>> +
>>>  	if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
>>>  		goto oom_free_page;
>>>  	folio_throttle_swaprate(folio, GFP_KERNEL);
>>>  
>>>  	/*
>>>  	 * The memory barrier inside __folio_mark_uptodate makes sure that
>>> -	 * preceding stores to the page contents become visible before
>>> -	 * the set_pte_at() write.
>>> +	 * preceding stores to the folio contents become visible before
>>> +	 * the set_ptes() write.
>>>  	 */
>>>  	__folio_mark_uptodate(folio);
>>>  
>>> @@ -4107,11 +4247,12 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>  	if (vma->vm_flags & VM_WRITE)
>>>  		entry = pte_mkwrite(pte_mkdirty(entry));
>>>  
>>> -	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>>> -			&vmf->ptl);
>>> +	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
>>>  	if (vmf_pte_changed(vmf)) {
>>>  		update_mmu_tlb(vma, vmf->address, vmf->pte);
>>>  		goto release;
>>> +	} else if (order > 0 && check_ptes_none(vmf->pte, pgcount) != pgcount) {
>> This could be the case that we allocated order 4 page and find a neighbor PTE is
>> filled by concurrent fault. Should we put current folio and fallback to order 0
>> and try again immedately (goto order 0 allocation instead of return from this
>> function which will go through some page fault path again)?
> 
> That's how it worked in v1, but I had review comments from Yang Shi asking me to
> re-fault instead. This approach is certainly cleaner from a code point of view.
> And I expect races of that nature will be rare.
I must miss that discussion in v1. My bad. I should jump in that discussion.
So I will drop my comment here even I still think we should avoid refault.
I don't want the comment back and forth.


Regards
Yin, Fengwei

> 
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>> +		goto release;
>>>  	}
>>>  
>>>  	ret = check_stable_address_space(vma->vm_mm);
>>> @@ -4125,16 +4266,17 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>  		return handle_userfault(vmf, VM_UFFD_MISSING);
>>>  	}
>>>  
>>> -	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>>> -	folio_add_new_anon_rmap(folio, vma, vmf->address);
>>> +	folio_ref_add(folio, pgcount - 1);
>>> +	add_mm_counter(vma->vm_mm, MM_ANONPAGES, pgcount);
>>> +	folio_add_new_anon_rmap(folio, vma, addr);
>>>  	folio_add_lru_vma(folio, vma);
>>> -setpte:
>>> +
>>>  	if (uffd_wp)
>>>  		entry = pte_mkuffd_wp(entry);
>>> -	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
>>> +	set_ptes(vma->vm_mm, addr, vmf->pte, entry, pgcount);
>>>  
>>>  	/* No need to invalidate - it was non-present before */
>>> -	update_mmu_cache(vma, vmf->address, vmf->pte);
>>> +	update_mmu_cache_range(vma, addr, vmf->pte, pgcount);
>>>  unlock:
>>>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>  	return ret;
> 
