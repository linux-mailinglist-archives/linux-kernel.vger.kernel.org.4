Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9100C74BBFD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 07:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjGHFfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 01:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHFfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 01:35:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDBF1BDB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 22:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688794517; x=1720330517;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=be597zOBlyn7EmMGuh9cnzySJp+nDNgIX+qXAw533OQ=;
  b=c5CtmLG3XwdElLzszi1duFMaVazA6pZnBwDUTGelfhF0oTI9CCctw4XY
   jCaNMJbVU9Xh1irFdIUe6SN5TEpdStDj/O0ufeqoWUDJfu/mVHvvF/S75
   S40isjvNwJ6nx+oJVRt82ZyG9AQ17ArxDcb0Hs8CiIpA87mZ511MW7Z0e
   a8gMhSaI5fUstzWX0QrPpFlFUzhCRQueDlKFC+u4CVZXJ1YapmXRHlrgK
   5V7f/LD61/UDIcr3OOVCq7oT6TsNiIRMQNRCfK+MGlrWImpBhjqgTa1u9
   wxwgGMQhgLRMP5pZXKdAkMmPS8C6cl9yfdeQaijfclhknyV4ncR2mGszY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="353886067"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="353886067"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 22:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="670367668"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="670367668"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 07 Jul 2023 22:35:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 22:35:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 22:35:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 22:35:15 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 22:35:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZKxmOh1gLDKOrZMaaFtnLNkrH3/NVwGVLJuYlnqHy5zbCU4kPBzfixxSoJ1ka3hq7p7ZKFMGzfu+5kDrpGNpA/9CIFzutNFpsqDlSfcRABQlDHaYoPP3h/2/QVig8KExz71BE9U6mcF1rCP9UuR5NhK209SrJS85R9g3IaOgRmPxVlb8W9aVB2yqkN4Eb+MIitzE+KvU9fA4VGeQov+ZgR7W6VFfqCeDsRRdgTDwffQZPK2gkJ4L75ITeIFbUmSbN1ZqGtXJC8HdYaNpjkwm/JrrEjx063C1CTdU4ZhI0SPICFlf46SBS9xFHTjpCO3b5zQQ3TecaanKmY93TRzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StjNyP/cj2B998ny2hh/eQWql2mdC/icQCM0YtGWMFo=;
 b=UZ/1L9JHuFqoy1l/tuCh3spmyGz6vh3Tv0sY39NnbgimqbNK20apMlL34QpYD2Qf9G2Rb3azoCgZtoAvYNZh2A7lmXzuxRyi/R+SbpBLJ4s01NQ+veGJMdtZs6IiLb3ahcuHQxkcAeprHnbjoii1WLEoIqWwudXvhKDgs6KDZvS9ADqr9kU+UaM5RA2tJVDaMLJSHdTI8TxFgYexJRi7+QgL7/kVHmjL/oroKBSq7nJbF89oDNLbW8RA8nPaMyt1QphAFa5oHOvTiE9J+tI2RW66SwZkhX1evk1H907CNtnYuY6VVL6diXPP3NXpIAkZuZ5OXgTFrIOfhZGWtBTwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB7651.namprd11.prod.outlook.com (2603:10b6:8:149::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Sat, 8 Jul
 2023 05:35:09 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 05:35:08 +0000
Message-ID: <362ac9b2-566f-f942-e98a-196ce38b6003@intel.com>
Date:   Sat, 8 Jul 2023 13:35:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <ryan.roberts@arm.com>, <shy828301@gmail.com>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <david@redhat.com>
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <CAOUHufY++PUYp3qcmX2rK5AQrgu9rPT3tYOpj=44BX4K67Znrw@mail.gmail.com>
 <ca1df2b0-3a36-2762-f20e-b4a235087c9d@intel.com>
 <CAOUHufY0=EW65tD01mm6ha75XWjcc43aGVuSJ8AfPc+dDLH6ZA@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufY0=EW65tD01mm6ha75XWjcc43aGVuSJ8AfPc+dDLH6ZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: a83db06e-ff48-4bbf-3598-08db7f7517a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ew6AN3+8g1pOv3nT6qE113WjmoI0S88qpVWM4oEWCFdtBL6QczxARiJf6UvAEpB4h1xnH8Gnj8kTD8rOdre9gy7MxdTT97SSgQJ1+ntULxZGoBdmiTVMoSFcx1SzSE6d+abqzy81Mzu8xmtLGMYPYonRZwBHEatS4GplDTKmlcOOyUqW81gj0SgAm9fwVbIKrYealm43ivDaDKM61+HeQIBkc5+oLVn/8eHmfKU7Qy3ADEzwvSF6tduaJQpfaAtwwe4DOFwIh1JcuM97Lv2dSAuGVlVI59XA26xhTw5byXcgTXhIRRCwXJsaRJlNTYFa+wFD8tZzMgoo1VaTYxLHpKF+5wV0raydP37noRnvlXrlQb5iDs1yPXC/IpRsuqKC9lrb1SJBy/X5lCN0OagUXV44LMIducwhgZVZCX03lxYCwR1AQtXCq+mwVBSCEjQNXxZLHKY2yRrgIzxZ4ReaPSr4OBvgPsptywg0q4Q+mWBVYsCPXyAcYTaLTDb03bS1ITajCnvnmTTH4ntFRXuyJBa13lwp+VNDRFuC6dGqmxXQr9ecDj96d/NsuknR6nA3AMmyic88rveaRZNLbzXtUQ4DXa8FF5uim+hTPJ1wf59ebGKd8ibLrPpgVKdxpqIyXAIV4b5tmftAuQI45SwjVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(38100700002)(82960400001)(86362001)(31696002)(36756003)(31686004)(8676002)(8936002)(6512007)(41300700001)(26005)(5660300002)(6506007)(186003)(53546011)(2906002)(2616005)(83380400001)(66946007)(6486002)(316002)(6666004)(478600001)(66476007)(66556008)(6916009)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2JQaEdEbkZ4Zlp6OXMyTnBPT0laUTVNSlJjMEJ2SXUvQ2tsNk1LWm40SzFx?=
 =?utf-8?B?YUFoY1lxU1U5S0lvbUxyUFlhTDRsNXRMbFNGUEhRd01WMWQ2bks4eitBdi9M?=
 =?utf-8?B?d1ZmQjU4N08rNFNUbGFoQ0pHZlZJbi93Nk5EdEhXRDZXSXlSd1ZmeDBDc3hk?=
 =?utf-8?B?THB0SmMrK0EyVzFjM01XMElTYmp5Wkp1QkFYcGFaWjZ3NDY5UkJVRXR5U1ZV?=
 =?utf-8?B?OC9zU0ZQQmtaa1BmVnZHTVhXWVRvN0NZRzIxZFhKdklIaWJmZFN6R2pVdUlB?=
 =?utf-8?B?SGhLTW94OHBQZVJnTmh2RnEzUzNLR1lFR1Z1Q0plb29nUktZaWpGbG8yWE1O?=
 =?utf-8?B?Wm1WZXMxclROaW92eGVwcjNlRDA3Q05ha1N6cjJuK3RycHZlTmJISEVBaW1w?=
 =?utf-8?B?ZlROblJJdk83NGcxRFUrWG5TVkJkbFFLNTVYZDA2cmRtVFFoQ3FEVkFYMGRW?=
 =?utf-8?B?dGF0U3FIdjBJNHhKeXAvMUJJalZEcGV5dEk4UlhWKzFIbGYrQ3ByanVyRkVv?=
 =?utf-8?B?NThKRlJkQXJHRUFPN1RyUENnQzNRTTlXSkR4eW5MdWxEbGNMdWJVUTFuL2dk?=
 =?utf-8?B?MzIzb3U0QUEzMzUrcUJQRVlUbFErNmZzRXJxK3lCNXRjc1NyWUNQT0VBK3U3?=
 =?utf-8?B?UkY1RDdhVGVvTTZrd3JYYmZNWThsR1ZYa2gva3dvdTB5WUhodkxlekpKd29G?=
 =?utf-8?B?U3NFREZubHNQTC91aGtWWUtzdTJ0MGVRaFNKRDBiRzZxMHFqREgrLzZpUjRp?=
 =?utf-8?B?VEVrTU90ZVYxaUhVQnZWNVNpeS9UL3pVSUJhd3JRUEpiT29tNHZoVGs3cXNR?=
 =?utf-8?B?MlJJSXkyYXE2azdBN0hkV1NJV1BMMFBzKzJiTURqYmluL3pKQk5FZy9YTWxW?=
 =?utf-8?B?R2M0Q3BmM0NvNmwvVFEwOUVqeWhobTR3OTRtSUhhUVArL2YxNVJUN1ZmdTlO?=
 =?utf-8?B?ZFZDYnoxdUtmKzFwNzI3cjRHM1ZvL2xoaTFTbTcwbVhKSUJQR0w3TGF5WDhi?=
 =?utf-8?B?L0VjTFpQaXM0Z2VrUnhhYUpCSHcxaXJSMEhxdzQvaHYzaUVIYmlDYXp1RDI3?=
 =?utf-8?B?ZWluQytHcmRKYit6UVZ1VjlZSk5OeWRQSUllM1N0OWUzWlA2NEhaVWIxdmdH?=
 =?utf-8?B?bVY4em9vekowTFprSVppbmZUS2NhNVdLM3NxRWZuZ1o3VStmMUxwMFRHQzBs?=
 =?utf-8?B?OFpDd0pzRVBzZnNUUHBnY0F2cEVpWU1CTnZJZjcyZDFqZGxCSjNUd0p5eUM1?=
 =?utf-8?B?K3B6bFlqdkdNMGMxbDFqU2ZVcnl3RFFSb3BoMEN6eEUremtKTHJ6VFZvang5?=
 =?utf-8?B?Vjdma3ZXNFNvYi91R3pQOGkvQUw1WnlNSDFnV2lscEpLNFFUSHdra2dvV3VN?=
 =?utf-8?B?eGo4K3Vmb2xqZ0IwL2RyblJ4RllUVDdJUUpsSFpoMUV0MVY3ZEpTWVNPTm9m?=
 =?utf-8?B?VjJjOGF0elhqYUQrRHgvVVlTd3RyazloeTI1ZVRhWWRaSUtkaUY4YUxsakpo?=
 =?utf-8?B?aGhib3pVSHhkNXdsSUtQRk1FYVEvczdBOGMvOXcrM3FPbnFjNjlBWVduOUl5?=
 =?utf-8?B?QUJudXprdi8rMUJYNUQvRFRlK09jb0VnODRYdHNGNm5yekZVSHdhSE1BaDda?=
 =?utf-8?B?eUtMYm1sa0FDc0JDZ2xnL1YwUTBKVTIzUTUrV1BuaEphNWUvNzkra0RJUFYz?=
 =?utf-8?B?N3hPTGdjcHlYNG9pcld0akVYTmFFUGh6WGF0N3JmcHk0OVJGZkcxTy9EMU92?=
 =?utf-8?B?MzNLbVVxekVtR0RIc0V2bHZ2VkNvTS92WUhYMXRSZFhQWWhyMXZRQm1SOHZW?=
 =?utf-8?B?WWxKbThEOE9ITFBEMjBQOWkvQTFNZWxuUi81aThjbXBqWi9lRjBlV3E3ZVJY?=
 =?utf-8?B?ZFpIK0tEaU1xR05rNnU2akRYUGQvYlkzK3lYdWF3dlhjRHlXOXFsVXphQ2ZE?=
 =?utf-8?B?Z1VOOW1kVU5RMVhEMGlGWDhBM0hIdnd3dS84MUpKaFJrc3hHWkt5YkFra3Jy?=
 =?utf-8?B?dmJ6R3pLTjVNMCtodlRaRzgvbENUdzc2QU5UUW9Zd3haTXVtSzQxUnc2eXlV?=
 =?utf-8?B?MzdXQkt3WFN3cDFpaFMxejJnREZGZ25GZmMxd2M0Qk4xWkRnQjVKVHNSNWVH?=
 =?utf-8?B?WXN5MHhxNTBLWVNwYkk5Nmg0SVFsZHc4RjNXVEhoeFMyOENsVkN3cER5cW81?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a83db06e-ff48-4bbf-3598-08db7f7517a6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 05:35:08.8724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jrFB6aE8AtgeckY0eO86I8+eNaWkws70TG/Adnq3zXA6TJMLu7wcpJwyxL6rK0X3RiBPLEmoqZnJH3vUo37bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7651
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/2023 1:06 PM, Yu Zhao wrote:
> On Fri, Jul 7, 2023 at 11:01 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 7/8/2023 12:45 PM, Yu Zhao wrote:
>>> On Fri, Jul 7, 2023 at 10:52 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>> Yu mentioned at [1] about the mlock() can't be applied to large folio.
>>>>
>>>> I leant the related code and here is my understanding:
>>>> - For RLIMIT_MEMLOCK related, there is no problem. Becuase the
>>>>   RLIMIT_MEMLOCK statistics is not related underneath page. That means
>>>>   underneath page mlock or munlock doesn't impact the RLIMIT_MEMLOCK
>>>>   statistics collection which is always correct.
>>>>
>>>> - For keeping the page in RAM, there is no problem either. At least,
>>>>   during try_to_unmap_one(), once detect the VMA has VM_LOCKED bit
>>>>   set in vm_flags, the folio will be kept whatever the folio is
>>>>   mlocked or not.
>>>>
>>>> So the function of mlock for large folio works. But it's not optimized
>>>> because the page reclaim needs scan these large folio and may split
>>>> them.
>>>>
>>>> This series identified the large folio for mlock to two types:
>>>>   - The large folio is in VM_LOCKED VMA range
>>>>   - The large folio cross VM_LOCKED VMA boundary
>>>>
>>>> For the first type, we mlock large folio so page relcaim will skip it.
>>>> For the second type, we don't mlock large folio. It's allowed to be
>>>> picked by page reclaim and be split. So the pages not in VM_LOCKED VMA
>>>> range are allowed to be reclaimed/released.
>>>
>>> This is a sound design, which is also what I have in mind. I see the
>>> rationales are being spelled out in this thread, and hopefully
>>> everyone can be convinced.
>>>
>>>> patch1 introduce API to check whether large folio is in VMA range.
>>>> patch2 make page reclaim/mlock_vma_folio/munlock_vma_folio support
>>>> large folio mlock/munlock.
>>>> patch3 make mlock/munlock syscall support large folio.
>>>
>>> Could you tidy up the last patch a little bit? E.g., Saying "mlock the
>>> 4K folio" is obviously not the best idea.
>>>
>>> And if it's possible, make the loop just look like before, i.e.,
>>>
>>>   if (!can_mlock_entire_folio())
>>>     continue;
>>>   if (vma->vm_flags & VM_LOCKED)
>>>     mlock_folio_range();
>>>   else
>>>     munlock_folio_range();
>> This can make large folio mlocked() even user space call munlock()
>> to the range. Considering following case:
>>   1. mlock() 64K range and underneath 64K large folio is mlocked().
>>   2. mprotect the first 32K range to different prot and triggers
>>      VMA split.
>>   3. munlock() 64K range. As 64K large folio doesn't in these two
>>      new VMAs range, it will not be munlocked() and only can be
>>      reclaimed after it's unmapped from two VMAs instead of after
>>      the range is munlocked().
> 
> I understand. I'm asking to factor the code, not to change the logic.
Oh. Sorry. I miss-understood the code piece you showed. Will address
this in coming version. Thanks.


Regards
Yin, Fengwei

