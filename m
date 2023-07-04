Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555A5747A8C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 01:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjGDXxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 19:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGDXxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 19:53:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B061AA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 16:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688514788; x=1720050788;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KDO4F0aS2YFzcNsAmWe1OWptEHW/FT+ldD8RaHsBvyY=;
  b=TcPTklpS/8dDYothw3SQ/nEXM5gFREyGokE7TksohaAClJQSK2F7p6J7
   5rUNW/qNeFb/9ILgs3RhPzlur6yKDqrnRcU8xVBV6weCuv3HR76+mWBsW
   mJZSzlalLIcvQtt8lMultscZt9KOIQG+vkd6hYbsjhWxHLgMGG1i252/M
   pSVLoeROM3m6cbIgoaV4Xtu9R1RPAavCiw63YEQcAPQHF2A0ns3SEsnaO
   eZ1rgoirto1MNKK/guSv1f7klfxk6GcbvHn1/nXNW0i3q994MPd0i8qe/
   SY8hXXtwAlic25z/rOtXksPun+qJoy48e458vSt8cA6UKHv4LhMpNrwRO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="366694533"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="366694533"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 16:53:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="832303295"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="832303295"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jul 2023 16:53:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 16:53:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 16:53:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 4 Jul 2023 16:53:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 4 Jul 2023 16:53:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImMWaZf8hMjnT7vu0aLrzquAmWNsCaLW9DpBkEZRClO5RWsozakToLQjnEo5lVLStDH1Ei/quUCDpyxZjXbs7bHAlQ8ajFnzJ52quRtej54knarmfSHPrT1RMCHs7K7gK6e6qctmHiq503ph58xgYjcEr31Ga6Znma38Boh7t/1i6xDBeygSVsFsvnEiNEs307rITqloQ7OufPp8eoCHCQvnnAIwqS0/6GV3PYWIH+Js+wDV+ZM/A+Tf4/APdDbjEm+5XGc31NdS7tgINda1sGS3A9SbwpZGPmr7UkUdZLllIjWuxFXj4O6zbxbzUmbM5FxTCzN9GcqyTOjPYGj67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Bm+Mrd/jLo487Ya51sIqkC1mszfxttTsm9akGZmX80=;
 b=UdzTFlGOJxNunfWHbrTzkY2fEiXFLzGS3YO18oNHz8AvSmnXRyMccoRM//NeJYqgTa43QNndKEHac8g4Gryxyz+4v2yYOvG9+GRo3wxtRNnbSvrgO33O6gjSHUZ+ZmOVg8QekBjY3tCAKA930mwRqJJ39BsPRuHepxncvVI3CfSwPusV594iNcXANF6XKRZzsd5tkISYSHjycZOjUdDVBcgJCFXpmzHD15GrcGXCkNmMBGOWRlOXD4H3yQx3GoiCMuYJLvUNuavNx6WEC9GiKva/1Ra7umO8HzLtU1HquAy0KRY8sCtd6f1RpVDKyWc9unsdWL4wVGeG3esK5x1C7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB7787.namprd11.prod.outlook.com (2603:10b6:8:de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 23:53:04 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6565.016; Tue, 4 Jul 2023
 23:53:04 +0000
Message-ID: <449183bd-76ef-2a3a-c3f5-0478a7c574ef@intel.com>
Date:   Wed, 5 Jul 2023 07:52:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/5] variable-order, large folios for anonymous memory
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, Yu Zhao <yuzhao@google.com>
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
 <CAOUHufYB2kB0r9hhSbzfEzdF85MkXVfWoFOhy3LwLfJ5Qo8H6g@mail.gmail.com>
 <69aada71-0b3f-e928-6413-742fe7926576@intel.com>
 <CAOUHufYsOdywAJMxdh6W-=uLykD=7JrUwgBvUJWvfWJeQ5XxnA@mail.gmail.com>
 <467afd30-c85a-8b9d-97b9-a9ef9d0983af@arm.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <467afd30-c85a-8b9d-97b9-a9ef9d0983af@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0183.apcprd06.prod.outlook.com (2603:1096:4:1::15)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dcb3ecd-42ba-4a71-f97a-08db7ce9ce67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++fxWuUdtJbQG921TlLO2g5EmrNBdwCh99wvEnG/tCag2vk9+vJXJMYNthlobAa3t4SMphQjI7isCZa5wzGIv8IlFivBOxJQNWneuRrkF5P9a5iBqxPDeNd6IG341CgG4LWjCdK+r1CTbXKUIVNXPz39LckD4U/Yiux3VUnAswrxrdlvA4Ka9R24/UaOIuicvtx3oMH/c1zMnHwWoAPNjc1DUyXCFG8QASZBOnBTvADMVfZhiZY+fd0d5/tgPm2cjNutgxVCLlW/dZHTtwR2Y7YoLIpz+h7T5tjxJyU451KM6vGPln45xuIYYrlI+qrwDTToRLYdgSm3xS6ave2nKdF/wbTzghYaW6Q2y+Qen5eIps6s4EVezFtKT8OtibOve5DcK5NIizgFNss2mE49d6D4cOUAjNbEHiwQbCOP9uCfAU+1JowpV1jDptMXOD/Hjsinzq9UK04LlxuHc3Za40FXdy3Dv2ABlSQk6rvTC1ciMV1SJdW3DQWaz++U5xw5LyoZIwFWHmw8a+lN/3/DFAtxBYwBeY+Ip2aGQjvwe65YyiI/kOz8lOs7EOSxiNNts5FdKLrpd4WTW6Jv0SskJVF3+uwcfUe79sL0MoQ0vgEw6lpJi57lxc1Z9W3p8It6VeISxwx67igJQm+AHm8bBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(7416002)(31686004)(4326008)(66946007)(66476007)(2906002)(478600001)(66556008)(36756003)(316002)(8676002)(8936002)(5660300002)(41300700001)(31696002)(6512007)(86362001)(54906003)(110136005)(6666004)(38100700002)(6486002)(26005)(6506007)(186003)(83380400001)(53546011)(2616005)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWZLUXV0MVJubXNXaEZZWklaSUwxeVFiUTEvMWhYMWt6MFRWTlZXaVg4MjZP?=
 =?utf-8?B?dkJTbmVPTm01TXZpd3I2NXMwbE1MMVpocVRXQWlTUm5IUktEVUlFMHpXcnNw?=
 =?utf-8?B?b0RVNmE1aEl1M0JjY1hITnR5K1NSNE43TGw5bzJSaDRzOTlyNVJFUFRYVjF0?=
 =?utf-8?B?V3BCZFU4OXFtaDJZbHppeTZVSjhSTkNvTzVQbmVWNEpmY29SREovR0oxZERR?=
 =?utf-8?B?YkN3T2UzVUpwS0dnb2NwUkF6SVpqQkZIcUpJUE82aU5kWnBNQ2Fva3BKeUZp?=
 =?utf-8?B?MFE4MG1QdHE4eS81MGE3Y3FXU0gweVkxZW9xZHFBWXJlTCtvOGh6WklwS1By?=
 =?utf-8?B?WjE2TGhDUmdZeU1Ldmt4RmZRVUtzZ01XSWxQRGliWUVCWTBYQzBKSTVheFNB?=
 =?utf-8?B?Ny9WcittUk5MNHZ5L2hFL25YS1AvbFBjT0lMbWVUSEJ1a0NheW5peUZIaER5?=
 =?utf-8?B?Znp2bHpLc2Y2b2tUaXJMT1NSam5JSEU5d0pKN1Y1eWlITWprbHVKY3M2OWcw?=
 =?utf-8?B?Vmd3ZnhuYVdoMDdoai83dXo2NHlBTEFaZkhyVzRRNmJqSnZ3QjJueVVtSXhj?=
 =?utf-8?B?d1JxTUlRWURGd1pmQ2hZRS8wOXg5aEdHano4dXI0OTM0TDZrZ1pPRkd1ZUpN?=
 =?utf-8?B?Y0x3bWRiall2MElvdmw5QTdoUWh4RUdFdFRRbGt0a0xaYWs3Z3FqU2lqNjVa?=
 =?utf-8?B?OWdnVXFRR2EwQ3FEZU9lM1N0eTc3YTErQTc0M1lBdFlLQS9wNUgxalhhVGc4?=
 =?utf-8?B?Z3JDOVM3OXU4SVhJcmlONWxJbUxQaE9Bblh2U3oybW5KcHQwMFdTY2RycGor?=
 =?utf-8?B?eTloeU1JU0x6amRGdkF0dEp4T3h4Q2Z6NDlMbzB2R3Z1dWxZZXJwSmRDUWFK?=
 =?utf-8?B?WmY1ZkdmSWlWSzVEQ3lOYkZ3SUpXNldYZ00rd3BkWWhIakNqK1U3OXA4L0hI?=
 =?utf-8?B?VGNFaU5xZVBBTGdNTTllN1hWOXFJMTd3VmtuYjZTdW85Z2UvK2x5RW5ldU5t?=
 =?utf-8?B?Z3I2WXU0ay9hQUFRc1JWQjdZRytqUjR3MW9vTG1VL29BMHV6R2M1clNNaStQ?=
 =?utf-8?B?akpRUWVPV0wwUmpPTVR3VnluSzlFbEYxbFdXMDFNMHM2UlBNNGp0Ly96ZDF0?=
 =?utf-8?B?RDZYSHVqNklVdXhJVUVkYmxQaFJEcURmdnd6U3pMMWJha3IzYUlqQ084VDQr?=
 =?utf-8?B?cm9nWEFWcWZmU0w3a1BWVVgvSTdvU2FGVnhHUExCWVArQUpxMC9qaUk3TUta?=
 =?utf-8?B?OERMeVppL3NJeXcyd1VBQlRUQ3JPa3MreEtJL3hsMGdQVHlKTjhLVGt4S1dn?=
 =?utf-8?B?cE1KK2ZDM1pFR1BLYmo4a3UzSllTeTh5QnpQRmQ3Z3podnkzbW8yWXpXU3Y5?=
 =?utf-8?B?U1puRVRnUHNUQ1UzbUxNSUR0bVpCejIzMk13NmhUZC81NEYwSEZUNWRuWkxZ?=
 =?utf-8?B?MnpyeklJZHR6bk5vZzVwVG5ITFYzeTlWL0RMMmRSYVR0cXpTZk5aTldualF6?=
 =?utf-8?B?MUVhZHNETTdtU2swWWtlZmUzbW5raDFRa3VTa21BNTlNRXpHWUU4NUVubjVC?=
 =?utf-8?B?bkZFM2R4QnNsUytYdGhBTmdQZFBSdmVBM2EvMmY0ZGdpd1Y2bFdqR2N4aWtG?=
 =?utf-8?B?VnlqU3RxMzVsak5BUUZUZEZjZnh0WWp3ZjI2czRjQTM4dXFaMzRWTjlxak9q?=
 =?utf-8?B?NGtoS3RrR2h1MGNzMVNJMFBHUEJjdmVNUzUyN2trL3hTM0lRUlZsa2k2bTFN?=
 =?utf-8?B?WTltSE1PYzIyNVBON0ptblMvYXVXOGY4OWVSUUkzbEdmMUZGLzdJVnNZLzdx?=
 =?utf-8?B?Z01Zc3poMTdsd1lRdmRiT3NjTWJ2anNRR2pkNm5ybDZqVTBLcFVycGt5RXBI?=
 =?utf-8?B?eDRvVGZOUGlHekJRa3hOVTU5a2NOVUh3b3ZZSTJwc3NWNWxpSTV6OXhaRVVz?=
 =?utf-8?B?SFBuRStxeTd5ditvK0RsOHJYUTRITjNWQTdNU2ErTGlTYi81NDVzY25DaHhF?=
 =?utf-8?B?b3BuK0dzaHpsd1NSV0oxL0hvVEJCU1dkZE9JMFgzbyszUXNwOWhGMEU2dFRU?=
 =?utf-8?B?NlBjS0lGcWIxVjNEdWlFTEEvQWE3QWphU3hDbHQ4aXNhMlkxUCs5QXFYOFdR?=
 =?utf-8?B?dmJvV0M2UjFPVE5yUWN2d3FjZUlBb0JoSlpJVXBQQ3ZRejJmYW1VQVVFOXo5?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcb3ecd-42ba-4a71-f97a-08db7ce9ce67
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 23:53:03.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWhd5dTkAnAQ2nKCbIedv6Scyx0QUARdBqUqjxRpEXYnZRkUmRBep+AV5ZTWQhialSdYspKajvhiMxfM9vx0UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7787
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



On 7/4/23 23:36, Ryan Roberts wrote:
> On 04/07/2023 08:11, Yu Zhao wrote:
>> On Tue, Jul 4, 2023 at 12:22 AM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>
>>> On 7/4/2023 10:18 AM, Yu Zhao wrote:
>>>> On Mon, Jul 3, 2023 at 7:53 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>
>>>>> Hi All,
>>>>>
>>>>> This is v2 of a series to implement variable order, large folios for anonymous
>>>>> memory. The objective of this is to improve performance by allocating larger
>>>>> chunks of memory during anonymous page faults. See [1] for background.
>>>>
>>>> Thanks for the quick response!
>>>>
>>>>> I've significantly reworked and simplified the patch set based on comments from
>>>>> Yu Zhao (thanks for all your feedback!). I've also renamed the feature to
>>>>> VARIABLE_THP, on Yu's advice.
>>>>>
>>>>> The last patch is for arm64 to explicitly override the default
>>>>> arch_wants_pte_order() and is intended as an example. If this series is accepted
>>>>> I suggest taking the first 4 patches through the mm tree and the arm64 change
>>>>> could be handled through the arm64 tree separately. Neither has any build
>>>>> dependency on the other.
>>>>>
>>>>> The one area where I haven't followed Yu's advice is in the determination of the
>>>>> size of folio to use. It was suggested that I have a single preferred large
>>>>> order, and if it doesn't fit in the VMA (due to exceeding VMA bounds, or there
>>>>> being existing overlapping populated PTEs, etc) then fallback immediately to
>>>>> order-0. It turned out that this approach caused a performance regression in the
>>>>> Speedometer benchmark.
>>>>
>>>> I suppose it's regression against the v1, not the unpatched kernel.
>>> From the performance data Ryan shared, it's against unpatched kernel:
>>>
>>> Speedometer 2.0:
>>>
>>> | kernel                         |   runs_per_min |
>>> |:-------------------------------|---------------:|
>>> | baseline-4k                    |           0.0% |
>>> | anonfolio-lkml-v1              |           0.7% |
>>> | anonfolio-lkml-v2-simple-order |          -0.9% |
>>> | anonfolio-lkml-v2              |           0.5% |
>>
>> I see. Thanks.
>>
>> A couple of questions:
>> 1. Do we have a stddev?
> 
> | kernel                    |   mean_abs |   std_abs |   mean_rel |   std_rel |
> |:------------------------- |-----------:|----------:|-----------:|----------:|
> | baseline-4k               |      117.4 |       0.8 |       0.0% |      0.7% |
> | anonfolio-v1              |      118.2 |         1 |       0.7% |      0.9% |
> | anonfolio-v2-simple-order |      116.4 |       1.1 |      -0.9% |      0.9% |
> | anonfolio-v2              |        118 |       1.2 |       0.5% |      1.0% |
> 
> This is with 3 runs per reboot across 5 reboots, with first run after reboot
> trimmed (it's always a bit slower, I assume due to cold page cache). So 10 data
> points per kernel in total.
> 
> I've rerun the test multiple times and see similar results each time.
> 
> I've also run anonfolio-v2 with Kconfig FLEXIBLE_THP=disabled and in this case I
> see the same performance as baseline-4k.
> 
> 
>> 2. Do we have a theory why it regressed?
> 
> I have a woolly hypothesis; I think Chromium is doing mmap/munmap in ways that
> mean when we fault, order-4 is often too big to fit in the VMA. So we fallback
> to order-0. I guess this is happening so often for this workload that the cost
> of doing the checks and fallback is outweighing the benefit of the memory that
> does end up with order-4 folios.
> 
> I've sampled the memory in each bucket (once per second) while running and its
> roughly:
> 
> 64K: 25%
> 32K: 15%
> 16K: 15%
> 4K: 45%
> 
> 32K and 16K obviously fold into the 4K bucket with anonfolio-v2-simple-order.
> But potentially, I suspect there is lots of mmap/unmap for the smaller sizes and
> the 64K contents is more static - that's just a guess though.
So this is like out of vma range thing.

> 
>> Assuming no bugs, I don't see how a real regression could happen --
>> falling back to order-0 isn't different from the original behavior.
>> Ryan, could you `perf record` and `cat /proc/vmstat` and share them?
> 
> I can, but it will have to be a bit later in the week. I'll do some more test
> runs overnight so we have a larger number of runs - hopefully that might tell us
> that this is noise to a certain extent.
> 
> I'd still like to hear a clear technical argument for why the bin-packing
> approach is not the correct one!
My understanding to Yu's (Yu, correct me if I am wrong) comments is that we
postpone this part of change and make basic anon large folio support in. Then
discuss which approach we should take. Maybe people will agree retry is the
choice, maybe other approach will be taken...

For example, for this out of VMA range case, per VMA order should be considered.
We don't need make decision that the retry should be taken now.


Regards
Yin, Fengwei

> 
> Thanks,
> Ryan
> 
> 
> 
