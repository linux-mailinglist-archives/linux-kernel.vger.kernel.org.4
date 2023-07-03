Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC46745977
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjGCJ72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjGCJ5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:57:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BC44692;
        Mon,  3 Jul 2023 02:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688378011; x=1719914011;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E60IhKU62Qhs3PDiCLhToRFnbTRcIvz8LzcPgBGTZqw=;
  b=nj+Rix+bVWSPZbp/gpROfwH0Zo4KRV8z/Bb4Wj54COjc00J5ugqJFz9K
   D315dHUY6Riz+PpLbm36RKw8BR7mwRd25lqD+ngusJMmHFq1j7Hf/g6sR
   eV2KHI8TcgOzah0yTztsSiRa3Lb1NToxFYjdaWPvyO2Q2Irzxu3acR9g2
   +/B6kq+kTdb8jL/ciVRTbtgeah2UG3FKQYSrI7OsZCtp+mbiOTiuDucb3
   swqomc6oNEx6S6cz7tx5pH7CS98n7KF/u0CG6N1fIfoCtToDG3Vgx66AU
   iln62Xmn1mBm8AlBmJHrkooh/6lc/Y4AjJazxbV54atABdJhsspgmcnOO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="347623656"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="347623656"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 02:51:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="695757073"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="695757073"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 03 Jul 2023 02:51:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 02:51:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 02:51:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 02:51:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 02:51:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOndB7eNYzy4FeS8/H5n+t3xlzuZ4Qe1i7UbRTCfhBQRon0aUUsMEJlkHYTCymV4XcntaBwPciOAMpnzXjVYry4Tyhav2zaDYKic1CNPxhpmEFN2xkCA/q1vH3Kr37WGHdcjPQtXovN2UEiYXiI7wcoqxfON6fKmSk4iKeNNvsAhF76LmOY8Uqgbwi9lkoaHTg4JPk18XDMQ69In6sWMv3mvIJ8zBv6vJ4OECv7sK10W8RLuJZOefX97Si1wnVlje7t8fbWdXVzVYKXqQkA8YSTOGZ84fUei6ZVO3ikvF+int6BIqv4jMlo+bDNTLP6DF2f2uon/JqktzgqWMQvXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=038k8/JCU+inTakE1veB5IZshlSs7ij5YsprPmF4t/c=;
 b=ELqMbwXOIXisjM46uph8vKnMu5FJDNxse82yleXAFJydVqOp5W36J/5t6b7A9+yO+xa3qVL52CuzcAIb09oDS8D7JoWwJO3CmgjMKCdN1S9tSlqP3HktJ1fJSJhwa4n4JHbr0hxFaQz3jBBbvmlr6Kcp9+Upz9DpWyr2Novpvs0d223JEdjKgothRdfNGRXHjfobZC9d1sIrDylLaV9j817Mr8nYuHDLqaPZnukfus2UmYWpZYkpv1fSSS/g6osgIop2ZHlhk7TiVObi8Zf3zGfBQFnyVbZ7/0OF+y68pyE9TlH/tWN9bAG96wjcaePT7iFA6LT7RkrWTekWwBCpQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by BL1PR11MB5446.namprd11.prod.outlook.com (2603:10b6:208:31e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 09:51:50 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 09:51:50 +0000
Message-ID: <62790f91-db75-fb8c-dec0-7354e299c89b@intel.com>
Date:   Mon, 3 Jul 2023 11:51:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/5] acpi: Introduce new function callback for _OSC
Content-Language: en-US
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
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
 <e94c0d23-4873-5c34-be24-c2208d03043f@intel.com>
 <CAJZ5v0h3mNFa4P+5o=LtUvTW4VnJs=4SJxvjoYMKCeir4tXfpQ@mail.gmail.com>
 <ba919f97-894f-8fd3-fdda-1f170c2a6fe6@intel.com>
In-Reply-To: <ba919f97-894f-8fd3-fdda-1f170c2a6fe6@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::18) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|BL1PR11MB5446:EE_
X-MS-Office365-Filtering-Correlation-Id: ef5a8a2e-11ab-4067-82b6-08db7bab1f7b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P7WSZFMmkrFMqhBCdOVNOsWPcS3Yrfkay2OEYJ3imGioAoEzTvKgcIbD91w93EcMOjH2N65cSJP/QFuux79dosAbT6RmDS27oa60amNeKdVS04C3ZkPFtD3DXrRnzeWP4YF5mlTpeoXDI57L2YLzdGhEjbJ3JyKLXfI+1yGDWcwwtzr9Sa3DiF4epsyjbMr57jaaKV6WikXzydOMzVm7CQ+fcfPZkLYBjGrXfiUGjwHbpj04By/ynWI2dy7a7Gos0MLtLFaGttbT5BYoSQMmPwigk7/OhL1wi264tqtufpFf7eMc6724qI6ICJu9wtueITqMM7zI9K/YdMfxx52P9vcypvMETX+UGifbVa5OIIVuW237o0wWF123nf6riGGqNmkhxWTHXhJUp86GE5/wR1Ie5YI6i6uZB96g+nSXYExUc+PICi0RJdlVwZWctz8gjwqauANK1KL1kZzOXCt33Q3no1KFq3DMd5TtBpSOjwr6yVaNpJ5wk+NRlxnAsaNkZGWSbW4hC5icdUUuWykv97FkPDnv5OJ9l7dYrV3p7CmXu+9jZVPX0pIE9oVmeKsUJ+OXk/exrR5CaqC4MToNB/sgGUAkAF4pBfy967am/5nwW67XmGzNP+Uo6ZX5MoSzTTFrkHK8pyN+uIUebWLV4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(26005)(31686004)(82960400001)(478600001)(6666004)(6512007)(6506007)(31696002)(86362001)(2616005)(186003)(38100700002)(6916009)(66556008)(66946007)(66476007)(4326008)(83380400001)(6486002)(53546011)(316002)(5660300002)(8676002)(8936002)(7416002)(41300700001)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qkp4bXNEU0pxbG40cnB4S2tkUW1zNndYdis4bnRrUEpBQ0VQWDRrdk92Yy9a?=
 =?utf-8?B?MlhScnZjT3VnUGY4SytqZmJkTVBjckRqUlNPYmtSWnNiM29odHRTd25LRVBU?=
 =?utf-8?B?YU1JcUZXVk9QczdrVSt5RHlFUUpzdTRyWlVRR2hHbUtGSE10bTNWcnlyNFhP?=
 =?utf-8?B?NnFlTVZjK1laTm1oM0ZZYzBtclVLNGI2NGwxeXE3ZnB1RlZXdkw4aGhIKzFa?=
 =?utf-8?B?L0VoSWN3anBJc29Na0liQXlyZkh6VitTM1R6OFV6OWtQcjgvbmE5bFBPM21M?=
 =?utf-8?B?dW9ETUNIdWpRbWUxV2UwRDYyR0twUVROLzVGdkoySURRNjMzOTZZNkZ4Y1BC?=
 =?utf-8?B?TkZKVW5hNmM4c2hsaDFuTmYvQkE2aUt0djJ2RG1nVFI2UCtLZlIyb2EwWEZh?=
 =?utf-8?B?Znp5SGlCMGU5UTQ0LytPZVZjekRHUjZJRlBLaStEcVgwdlVVTUtkbzMxcEpw?=
 =?utf-8?B?YVBGdmdMYWFScWhneEtTaGpkSzVOZHUySTJDM09xRWROdmFMclZQMFd1MnFh?=
 =?utf-8?B?NU0wb1FucmZRNnp4RWdpR2wyRFVMZWszWUppaXVZdHQ0RHNsZUY4eTAyaExO?=
 =?utf-8?B?eGJoWkJYZmZqT0pPdDJWYVZkWit6RVVHcWozQzZZYkF4NW1xK3JmMzcvUG9h?=
 =?utf-8?B?ajY2TG53ZDNLS2lGdWxFd0piTHh4Q2xhYXRUbWVEQjZWY08rbzVFd05LVjcx?=
 =?utf-8?B?Q2M4T0xibWFEblZQWkVNbjVWR01tNWpsR3lIZmNmaFhzZ29EMnZ0ODNjSWQz?=
 =?utf-8?B?elpUU2lkVVAyeTd5UUM1ZEhYSHBpMVpzQVBydnlCQkpFV0M5Q0EzblBZR1hp?=
 =?utf-8?B?NmQ3L1hJSHE1OTVsV1RPbFJuZ0w0TnBBQ2xDdEoydkw5V3FMUjZMQlFuTXlQ?=
 =?utf-8?B?RW1iN0pDakdMK1ovOVozbFR1UXFnMUpTM3htVU5vWXJrSkR5R2FqZXFSUHk3?=
 =?utf-8?B?VjR4QUVYalJ4NnpnYlczZzVZTWh2aVN2eWs1d1A0R0htQXdoRDVHK0Y4YmRj?=
 =?utf-8?B?elZrUllRU1NrME45Tm9sQ3hrZG52dVFObi94Nngvb0VZcGRwdEI2NFp6VlB5?=
 =?utf-8?B?dVpFTnFvcEgzRFo4Y3J0ampPdk5sM0xLZHNBU2gyeUpzSFpyYjBwWEErOFZi?=
 =?utf-8?B?S2lhSFNwUnI2eVlWQmVtdnFRWEQ1NnJkNnM0UmtFakV2K1B4MjJBcW0zOXNn?=
 =?utf-8?B?NVVBREFkL09oSEZKdHVqRG80SE4wNVpFZEZ1VGI0WUJsUmhra1J2UnU1YTJm?=
 =?utf-8?B?MDMvRmtUQkZNNW1FSm10YWpndVlNcE92bzdITHBPRXdJR3R6d0hRMW5CbThm?=
 =?utf-8?B?cTFuNXptUHd1OVlSRkJFQ0N2UGtOZXhZYnF2cEc2Y2VIa1ZZb29SODFhVS96?=
 =?utf-8?B?OE5GeDZrOGVQNEE1TnZ0dk1sVFRLc2I5ZDBPVVVpZVlyQzFoaXZOTVJJY2Qz?=
 =?utf-8?B?bEZ3YkwyVk14VTFuREhsVTlSWkY3Z1FDdk1qOUtWQkwzUDh3WCtDamk2Q0xp?=
 =?utf-8?B?SlVUNjdFVWM0b0E2WUN6RzdyNlVCTXAzTDhlSjFCZFlGTTdGSkxPeXV5Tk8r?=
 =?utf-8?B?UE5xUjIvY0h3VVlKUUhoR0NaYjhVTTE0eW10cFcySGZDMUh2RklVRGowQTNW?=
 =?utf-8?B?dWFydHZWeFNHZUxNSUJKZW1KMlJGa09kbFV2cFUrMTdzZmhENEM1L2NOZHpL?=
 =?utf-8?B?RFpNZmhzTU43cVNZVi9rdTlJK1ROcGlVL2JEOXIxcEYzamtDbGNsa1ExdStI?=
 =?utf-8?B?UkV2WkpMN1gwb2x4SVhYREFSU0FqSy94TWZoLzlxR1BWNkV1TFB2SWNUYnlw?=
 =?utf-8?B?SXVGOGFGZXFlNHVQUHFlY2hLMXdZN2hMMDJWRnhoRHAyaEt3K1lBTFZBWGpY?=
 =?utf-8?B?T3Bla0x3S3FPcTdlb01DYXFHZUx0OEQ3bm5RNlFIQU0venVHME13dU1qRjZr?=
 =?utf-8?B?aWZkNDRtZnE5SFN4SGUvRzFVZlhEUzZVcGdyQnBXdkVOY1dQUTlhbFZHZWw0?=
 =?utf-8?B?V09qM2NYQTNWWkVhaVZ6L3VrOTF6bFljTTAxelhKbVdlU3FZZVdlOURiWW5x?=
 =?utf-8?B?NGRZbExZWHJDL0Racmo1dUFSYzJIeHV2UlZ5T1VUT2Z2TXNkTnF2MGpZZ3JJ?=
 =?utf-8?B?eGF3c1Z4R0tIR3FMMURYQWI5VnJ3WDBYNXhDYUFaWHdCWWNBa0RSSHFyOWZn?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5a8a2e-11ab-4067-82b6-08db7bab1f7b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 09:51:50.3191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmsQfFLvByLvvlAUWWo5+LK9309IDkbscega50aAhYqUSEy7qKbiC+4wmmjc+4/ZD8YkQ4DdpNjzODvPINqeHP7kxvoK38NEZDBJP3l4nXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5446
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2023 11:23 AM, Wilczynski, Michal wrote:
>
> On 6/30/2023 11:10 AM, Rafael J. Wysocki wrote:
>> On Fri, Jun 30, 2023 at 11:02 AM Wilczynski, Michal
>> <michal.wilczynski@intel.com> wrote:
>>>
>>> On 6/29/2023 3:15 PM, Rafael J. Wysocki wrote:
>>>> On Thu, Jun 29, 2023 at 1:04 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>> I would just say "Introduce acpi_processor_osc()" in the subject and
>>>>> then explain its role in the changelog.
>>>>>
>>>>> On Tue, Jun 13, 2023 at 6:12 PM Michal Wilczynski
>>>>> <michal.wilczynski@intel.com> wrote:
>>>>>> Currently in ACPI code _OSC method is already used for workaround
>>>>>> introduced in commit a21211672c9a ("ACPI / processor: Request native
>>>>>> thermal interrupt handling via _OSC"). Create new function, similar to
>>>>>> already existing acpi_hwp_native_thermal_lvt_osc(). Call new function
>>>>>> acpi_processor_osc(). Make this function fulfill the purpose previously
>>>>>> fulfilled by the workaround plus convey OSPM processor capabilities
>>>>>> with it by setting correct processor capability bits.
>>>>>>
>>>>>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>>>>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>>> ---
>>>>>>  arch/x86/include/asm/acpi.h   |  3 +++
>>>>>>  drivers/acpi/acpi_processor.c | 43 ++++++++++++++++++++++++++++++++++-
>>>>>>  include/acpi/pdc_intel.h      |  1 +
>>>>>>  3 files changed, 46 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
>>>>>> index 6a498d1781e7..6c25ce2dad18 100644
>>>>>> --- a/arch/x86/include/asm/acpi.h
>>>>>> +++ b/arch/x86/include/asm/acpi.h
>>>>>> @@ -112,6 +112,9 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
>>>>>>         if (cpu_has(c, X86_FEATURE_ACPI))
>>>>>>                 *cap |= ACPI_PDC_T_FFH;
>>>>>>
>>>>>> +       if (cpu_has(c, X86_FEATURE_HWP))
>>>>>> +               *cap |= ACPI_PDC_COLLAB_PROC_PERF;
>>>>>> +
>>>>>>         /*
>>>>>>          * If mwait/monitor is unsupported, C2/C3_FFH will be disabled
>>>>>>          */
>>>>>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
>>>>>> index 8c5d0295a042..0de0b05b6f53 100644
>>>>>> --- a/drivers/acpi/acpi_processor.c
>>>>>> +++ b/drivers/acpi/acpi_processor.c
>>>>>> @@ -591,13 +591,54 @@ void __init processor_dmi_check(void)
>>>>>>         dmi_check_system(processor_idle_dmi_table);
>>>>>>  }
>>>>>>
>>>>>> +/* vendor specific UUID indicating an Intel platform */
>>>>>> +static u8 sb_uuid_str[] = "4077A616-290C-47BE-9EBD-D87058713953";
>>>>>>  static bool acpi_hwp_native_thermal_lvt_set;
>>>>>> +static acpi_status __init acpi_processor_osc(acpi_handle handle, u32 lvl,
>>>>>> +                                            void *context, void **rv)
>>>>>> +{
>>>>>> +       u32 capbuf[2] = {};
>>>>>> +       acpi_status status;
>>>>>> +       struct acpi_osc_context osc_context = {
>>>>>> +               .uuid_str = sb_uuid_str,
>>>>>> +               .rev = 1,
>>>>>> +               .cap.length = 8,
>>>>>> +               .cap.pointer = capbuf,
>>>>>> +       };
>>>>>> +
>>>>>> +       if (processor_physically_present(handle) == false)
>>>>> if (!processor_physically_present(handle))
>>>>>
>>>>>> +               return AE_OK;
>>>>>> +
>>>>>> +       arch_acpi_set_proc_cap_bits(&capbuf[OSC_SUPPORT_DWORD]);
>>>>>> +
>>>>>> +       if (boot_option_idle_override == IDLE_NOMWAIT)
>>>>>> +               capbuf[OSC_SUPPORT_DWORD] &=
>>>>>> +                       ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
>>>>>> +
>>>>>> +       status = acpi_run_osc(handle, &osc_context);
>>>>>> +       if (ACPI_FAILURE(status))
>>>>>> +               return status;
>>>>>> +
>>>>>> +       if (osc_context.ret.pointer && osc_context.ret.length > 1) {
>>>>>> +               u32 *capbuf_ret = osc_context.ret.pointer;
>>>>>> +
>>>>>> +               if (!acpi_hwp_native_thermal_lvt_set &&
>>>>>> +                   capbuf_ret[1] & ACPI_PDC_COLLAB_PROC_PERF) {
>>>>> Checking it in capbuf_ret[] if it was not set in capbuf[] is sort of
>>>>> questionable.
>>>>>
>>>>> Note that acpi_hwp_native_thermal_lvt_osc() sets it in capbuf[] before
>>>>> calling acpi_run_osc().
>>>> So you moved setting it to arch_acpi_set_proc_cap_bits(), but then it
>>>> should also be checked by the arch code.  That is, add an arch
>>>> function to check if a given bit is set in the returned capabilities
>>>> buffer (passed as an argument).
>>> Hmm, maybe that's true, but the only reason we check that is so we can print
>>> a debug message
>> No, it is not the only reason.  The more important part is to set
>> acpi_hwp_native_thermal_lvt_set if it is still unset at that point.
> Yeah, that too. Okay I'll modify the code
>
>>>  - that's pretty much a leftover after a workaround. Introducing
>>> more arch code to accommodate this seemed wasteful, since in my understanding
>>> all workarounds are meant to be removed at some point, even if it takes a long time
>>> to do so.
>> Not really, until the systems needing them are in use.
> Yeah I suspect it might take a very long time, and I guess it's very hard to definitely
> say that some piece of hardware is not used by **anyone**
>
>>>> Also it can be argued that ACPI_PDC_C_C2C3_FFH and ACPI_PDC_C_C1_FFH
>>>> should be set by the arch code too.
>>> That makes sense, but technically is also a workaround, since we're basically
>>> checking for some specific DMI's and then we disable mwait for them.
>> But boot_option_idle_override is set by the arch code, isn't it?
>>
>> So the arch code may as well do the quirk in accordance with it.
> I think so, I'll modify the code to move setting those bits to the arch part

I looked into that, and I'm still not sure whether setting those constants in arch
specific code is a good idea. Basically OSC and PDC are supported on two architectures
ia64 and x86, so that would introduce unnecessary code duplication, as this mechanic
is present regardless of an architecture, and in this particular case boot_option_idle_override
is set by acpi_processor.c function set_no_mwait().

One could argue theoretically that system defined in processor_dmi_table[] is an x86 so there
is no need to add any logic to ia64, but to me this is confusing. If we have a workaround in the
acpi_processor, maybe entire workaround should stay there instead of dragging innocent arch
code into it.

Please let me know your thoughts,

Michał

>
>

