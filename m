Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CAC63E125
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiK3UI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiK3UI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:08:57 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E4F2D1D6;
        Wed, 30 Nov 2022 12:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669838936; x=1701374936;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XCnK1N5nCG0it6y3rIy0ZYsDekLl25rcWRPgbbiwXKk=;
  b=lg6FofvO40j41hA8J90dscRH7ovy4VkYY3CIRdJsVIuELpsVa/y27zAk
   5lh6s6GGv/nQWkhrEzTnU5SpsDU0Y40tm5yzISO+dBdz2t+FrMEU5MvQz
   VryLpwyO6j9/J5gVWZupbKh+jIq4c/jkeiCmpaxXQCZs1t4yfrl9cVut+
   MWyqjmrCKZW+LeCcu4Yaez//JpNuzi5YVpgItj4qkgqlVIVIzFGgVBVE2
   kj47fE/0otZaK0UaEkAILoADi7Qfbi6mkbpVoKUu4Cu64h7KIUl6s763F
   +Oq7AlBuiqW7jUQisDiRMpx2TnDJz8/NP58DdlM8XHgnFuiyvirUq2w0/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="317356954"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="317356954"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 12:07:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="622015433"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="622015433"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 30 Nov 2022 12:07:22 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 12:07:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 12:07:20 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 12:07:20 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 12:07:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFRucVBwtt3R2QviaELrmq90t+sczGOcBkpffZNAbyQlAC8PRiZJgEwRO65/uRhKzK29B2ddLYZC/4MWBxL+xa6iHBQQP4ZpWbI5pw8Mfixxj/hj5xYWfFaq/9OKkpD+tFloTkcKkEwWacMusMkibD5yqlS+wVZnM/yJ8zN8GD6Uz+qdksJJecMSIm43cdrEiMeiKNL7sUmVSOPrFrO/E/001W6oGc2moRLk1IXcCbiAYkwnDwhEHWGsLrv6eKNnLYYk3pPNWIgp1dZKX0fnv1lDcAThsbCSa+dYfWPhDAkte9k7dPeJV0N0LAhIAxsp6j/vLwZTRNyBVGs5fF4HZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55ayHbBR3rGkBB9zVhJZWe2hoI2Y0ol2w/4b6Gz6eTk=;
 b=Qz0pZYhQuYhbOF7Af+lP0AsC7CuRPZpWBMBAcpq3gYxAvKkEHEsYfFanC0xuvjThCZPbX9fuEdRDVznP+YMQMXB9KglgXTxE2jQlMfpm4Qq2ckUEo7cok8t/4pVIGpQ0M1WqtTqI+34LjXOlXDl55W+WX4+OUN/aCRFNMIUMnoo+dZ5aUTKQr0FJMNObpyhpUp3PWOYz3jEowe0wgI0q9MlXturxh36xOcbT2Xh6mf14rWACMe99cmq8ShW5eBu3J42Ts8dx1FgALtbbAZYAL3Q7rxzHAJ7z0z9QuuRt4LSMB3RErxJqCnSjblMTuPCHyJYlb/WqE8eqXm4VBGbK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ0PR11MB5119.namprd11.prod.outlook.com (2603:10b6:a03:2d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 20:07:14 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::b518:90b6:52bd:bef9]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::b518:90b6:52bd:bef9%12]) with mapi id 15.20.5857.023; Wed, 30 Nov
 2022 20:07:14 +0000
Message-ID: <5d17741a-c6a6-9ab0-fc05-673337b04a57@intel.com>
Date:   Wed, 30 Nov 2022 12:07:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v8 05/13] x86/resctrl: Detect and configure Slow Memory
 Bandwidth Allocation
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
 <166759202922.3281208.6231300030834095574.stgit@bmoger-ubuntu>
 <d2209b3d-374c-efdd-a91f-217f1db3b4bf@intel.com>
 <764c8eac-7b33-3850-3052-e6444ce496d0@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <764c8eac-7b33-3850-3052-e6444ce496d0@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ0PR11MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: b016ab8e-8887-449b-33c5-08dad30e7915
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KIblDFhQSG1XTOWYYD9phcGFcn9Ujzozh2DqgOJpEeKhYDLbskT37E2VbHkFZaOvFV/9tXNTMzMvYUfWuK+6acMhFVcvgaIiiqlSx2bc/50+ifMtSe8dmV7nMUln9gehIPeu2mZGGq6AsePAFt3+Iq5dS9T7Xar6zRQBJxDyxc2VDadRPsBxa3hG/CB9Mi03BsruyfeF1Jskeu3WTlfiDZU8bmbVMAhL0ZhXk2mAFSHWJtLjRF+2FAkA0BlH6TfQUlEw9YukrfCNdGXHM6eovMvF8W710Nvyu9OqQPj6yeBEXuWp6pPO5AxDzX/40ROTGBdKJ3jL6vMftJ5spswg1ng/MgpBRsff0QCnXg3qXLtdOLo7bidiNIfOj2HaW6w3uTuOtZ8Pu4Gssywtgv5o9LFXNZ4NTZIYwwy9uH4f9yROA9g6KcNcAkrQTxlRMdE2pnfXAaFaZWQtjGirrS0h9V7fJ1uBVcMqcJK2ASjUY5cfTKptrY7WkKlxZ/ZroZtpByyEV9Pnp8b4WK1W4ZSe+NGZoGlWTJj6YWeAB0uzHCwTM5OB1g5xG1x+h4WRhUWc8ZDZ0REUSdogcKRrmeNBEk9tNIdTU57GatlYziro+bTFHTdGvLuzFgYXKveX0cVOmsqw6Qv/dZdQrVK8vo+D9r6xJf0J8sZnv78YT90EEWs7EN2mKgDh/T9Nfu4/SrpM6ERdbzSXlg2JV7J9btnYMoUs9lUmiXjoqi9q5R3NuWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199015)(36756003)(2906002)(83380400001)(2616005)(41300700001)(8936002)(44832011)(5660300002)(186003)(86362001)(31696002)(82960400001)(38100700002)(7416002)(6512007)(6666004)(26005)(53546011)(6506007)(316002)(31686004)(8676002)(4326008)(66476007)(66556008)(478600001)(66946007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MStreEpoZ2pWeU9SRkU1OHRkR3h2NTFpQmdESFpia1ZCeDFLME00Mkk4M25m?=
 =?utf-8?B?RUM5alFQRWl1MEkyajRvWS9jQVNOTW1JT1lGQVpNdlk3Yk5KQWhlUHZkWXdP?=
 =?utf-8?B?cXBLVThCbzc1QVE1NnNlaWtSWEM4elFaUkhxR3FYY2dDNldQRksrUlhWOXpa?=
 =?utf-8?B?SnVBb0JHR01DMW9yaXJwT0JDVVByNjgvSFVRY0pWek84a0pOOVlWTFZ4YWp6?=
 =?utf-8?B?UExmSTFpTEVkVEVTOWFxL0h5VWcrN3VOakM4UjR4Y3Y0OGZpQTdmOWNPcG9N?=
 =?utf-8?B?ZTYyWVREQ3c0cGNlR0R5bDlScUhhd3V1ZURmdGdVZUxSdGk0UjgvWHcwazht?=
 =?utf-8?B?R0ZldGdEVVVXYUNwcmJyNzBXTExUckM3azdJTER1RXlQVitCL0FNV0FiaE9K?=
 =?utf-8?B?RjFZS0tEVlBuS1V5VkFGWXgzSDdGNkxXbFN3TUMxa2pyalJjbG42MlI3bWRh?=
 =?utf-8?B?OGtmaDE5dndRcUI2MlM1ZzRIUHJjMWxLM2JJZytlc3JyNUVnazJmS1FlTVpq?=
 =?utf-8?B?d0dPMHFtOU5rS05KNlpSNlltSldnd05FQkU5Q3liK0N3QXRCZVB6aE5JR29G?=
 =?utf-8?B?U24xcHplTE5yRWhVaUZ4TXlHRmlKdHRYYVg1Y1V4WkZkbHVWSUIxSC8rU3N0?=
 =?utf-8?B?NnlTTXR5bi9lZjFkUlJTT2g2bUJBU1VJRGM4aGtsU3JUM2x4L25HYjNIdGU4?=
 =?utf-8?B?VVVJM0phVVV2aVUyM2VaeHFWUjZlT0ovalRSYnlWMjNtSGdSSU5GOTYxaS9a?=
 =?utf-8?B?RjdBcUVwNElIa3dFajREeFozRlZlOStkS29LRzhJMVZ6WmtZMnZFclQxRGFt?=
 =?utf-8?B?di9JM1JuRVVZNG1iZ3pjOW1sbXEwNEhvSEo0NGZvODZ6Rmt1MkNGM2VNUGRk?=
 =?utf-8?B?enFOZHJBZjc5cXh6dXI2US9kMEpjeEtWK2tveWtra1BFOEF4ZzFWUFVjY204?=
 =?utf-8?B?WGdhUm5kWEdrR0pPb3FlOUlnL1NmQndtT3dTcnovWWtKa1NJQXNISUdha2l1?=
 =?utf-8?B?VWIvNWpYUVVoRVdVU3VvYzhVMjI5T3ZtVjFhS0ZLYzl5NkgvekpqU1NtZFp0?=
 =?utf-8?B?enpGa2VVWHZvUkJpMFk0dFRhVWtzZDZPRi9Ibm1XdWRHSkMzUC8rUUpzS2R6?=
 =?utf-8?B?QzNaYTl3OTd1eUcxSUdralhTNHd4VU5mdVBjVnR4QUFxcTlPVkNOK2xXUEE1?=
 =?utf-8?B?Y2lMUEpabUFFNlRJOXF3dkxXaVUwT3pQU0tNa1ZJZit0SGdyMWVWcXJNM0Q4?=
 =?utf-8?B?VFhBdXo4T21SVlUxYWFUMHU1Q2VkMXZKQ3ZMUGFLUHEwMFFic2UwZGVYYVk2?=
 =?utf-8?B?ckdUMWRlVXBLb1FHUkpvMkx2Zk1CS0szOGZPZzU1ZDhHK2p5NDZmZTd2WUF6?=
 =?utf-8?B?eitsWHJ1dXlWWVBNZUdBK2IreWlnSU1TTzkvVFdVZG5NSnpXL1BEUk5Zem9k?=
 =?utf-8?B?TW00S29GNjhyaDJMQ3RnR21rZTRCOWhJVzhXeG9xTnFOQUR3SzFoTExHWnc5?=
 =?utf-8?B?VUNuUFJiSnMvRC9wblRuSkYvdFBIUDd3R0VnbjJLT3ZvVkF5Wm56eEdCK1F6?=
 =?utf-8?B?Y1NvdXIwejhIZ0VJMXdHN1htSVVUY2hwL211djN3cVFxSzc2MjA3TXVOdHVq?=
 =?utf-8?B?K3Z4MzNXcjhKRzFramg5bHZPeklFSHprVXQwcVUxalJ1WmN1SWxQRWRmaXVr?=
 =?utf-8?B?NDgyVmpsekVLc01nS2k3NFBwS0hObXF0emNyMk8reFIxcEpmRTZOSmlNdE5Q?=
 =?utf-8?B?L2lvdkgySlY4M2VXWmxsb3pTZkpETUtXSVBCZk45TkJ2MzdJQWFLSTRqeTgx?=
 =?utf-8?B?WGM1VlVsUG1oY1k4V1Z3K3lCdTM0ejBQWnRVQzNrOWJwaWNEd0paK2Jidlh4?=
 =?utf-8?B?dFZYNURzNG8zVURrdVRGTXQxZlRSdUJ1R29PQjk1K3RUWTRwT0lFZVBsNnNk?=
 =?utf-8?B?ZFgxTzNwSnJtTzFJVjJIMUdHN2cyUGhZVkRRbWxwYTgwM3FWMGs5cUcyNTV4?=
 =?utf-8?B?dUNhTXBDYkltZHU3NVpSWkY5SFBreVFWSTM0b1c1TlhnQVkyQTRtaEVWQTBt?=
 =?utf-8?B?NVJ3RE5WOTVnN3pZVS9TUS81RUQxRDFOaHVZMWpVZG56Um9HRVhBWVRBU2F3?=
 =?utf-8?B?UnBha2l1cDF5N0l6MzByM0o5UWoxQjEyQjAyaEdDNUhzZGd4aGNUR1g3cUpx?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b016ab8e-8887-449b-33c5-08dad30e7915
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 20:07:14.3281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4c7tdse3hwkbMMIEB1UCik5s663Da+EioktrjXwKsFQzYy35b7T6/vka1s6GZpZA1GLeIBfV2/pzDbxDvQneptqF8RtEAc3CfKRaAfYXaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5119
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 11/30/2022 10:43 AM, Moger, Babu wrote:
> On 11/22/22 18:12, Reinette Chatre wrote:
>> On 11/4/2022 1:00 PM, Babu Moger wrote:
>>> The QoS slow memory configuration details are available via
>>> CPUID_Fn80000020_EDX_x02. Detect the available details and
>>> initialize the rest to defaults.
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>>  arch/x86/kernel/cpu/resctrl/core.c        |   36 +++++++++++++++++++++++++++--
>>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |    2 +-
>>>  arch/x86/kernel/cpu/resctrl/internal.h    |    1 +
>>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |    8 ++++--
>>>  4 files changed, 41 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>>> index e31c98e2fafc..6571d08e2b0d 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>> @@ -162,6 +162,13 @@ bool is_mba_sc(struct rdt_resource *r)
>>>  	if (!r)
>>>  		return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.mba_sc;
>>>  
>>> +	/*
>>> +	 * The software controller support is only applicable to MBA resource.
>>> +	 * Make sure to check for resource type again.
>>> +	 */
>> /again/d
>>
>> Not all callers of is_mba_sc() check if it is called for an MBA resource.
>>
>>> +	if (r->rid != RDT_RESOURCE_MBA)
>>> +		return false;
>>> +
>>>  	return r->membw.mba_sc;
>>>  }
>>>  
>>> @@ -225,9 +232,15 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
>>>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>>  	union cpuid_0x10_3_eax eax;
>>>  	union cpuid_0x10_x_edx edx;
>>> -	u32 ebx, ecx;
>>> +	u32 ebx, ecx, subleaf;
>>>  
>>> -	cpuid_count(0x80000020, 1, &eax.full, &ebx, &ecx, &edx.full);
>>> +	/*
>>> +	 * Query CPUID_Fn80000020_EDX_x01 for MBA and
>>> +	 * CPUID_Fn80000020_EDX_x02 for SMBA
>>> +	 */
>>> +	subleaf = (r->rid == RDT_RESOURCE_SMBA) ? 2 :  1;
>>> +
>>> +	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);
>>>  	hw_res->num_closid = edx.split.cos_max + 1;
>>>  	r->default_ctrl = MAX_MBA_BW_AMD;
>>>  
>>> @@ -750,6 +763,19 @@ static __init bool get_mem_config(void)
>>>  	return false;
>>>  }
>>>  
>>> +static __init bool get_slow_mem_config(void)
>>> +{
>>> +	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_SMBA];
>>> +
>>> +	if (!rdt_cpu_has(X86_FEATURE_SMBA))
>>> +		return false;
>>> +
>>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>>> +		return __rdt_get_mem_config_amd(&hw_res->r_resctrl);
>>> +
>>> +	return false;
>>> +}
>>> +
>>>  static __init bool get_rdt_alloc_resources(void)
>>>  {
>>>  	struct rdt_resource *r;
>>> @@ -780,6 +806,9 @@ static __init bool get_rdt_alloc_resources(void)
>>>  	if (get_mem_config())
>>>  		ret = true;
>>>  
>>> +	if (get_slow_mem_config())
>>> +		ret = true;
>>> +
>>>  	return ret;
>>>  }
>>>  
>>> @@ -869,6 +898,9 @@ static __init void rdt_init_res_defs_amd(void)
>>>  		} else if (r->rid == RDT_RESOURCE_MBA) {
>>>  			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
>>>  			hw_res->msr_update = mba_wrmsr_amd;
>>> +		} else if (r->rid == RDT_RESOURCE_SMBA) {
>>> +			hw_res->msr_base = MSR_IA32_SMBA_BW_BASE;
>>> +			hw_res->msr_update = mba_wrmsr_amd;
>>>  		}
>>>  	}
>>>  }
>> I mentioned earlier that this can be moved to init of
>> rdt_resources_all[]. No strong preference, leaving here works
>> also.
> 
> I am little confused about this comment. Initialization of
> rdt_resources_all in core.c is mostly generic initialization. The msr_base
> and msr_update routines here are vendor specific. I would prefer to keep
> this in

This is a contradiction. Yes, rdt_resources_all[] initialization in core.c
is indeed generic initialization, so why is SMBA there? If this was really
generic initialization then the entire initialization of SMBA resource
should rather move to AMD specific code.

SMBA is an AMD only feature yet its resource initialization is fragmented
with one portion treated as generic and another portion treated as vendor
specific while it all is vendor specific.

The current fragmentation is not clear to me. Keeping the initialization
as you have in patch #2 is the simplest and that is what prompted me
to suggest the move to keep initialization together at that location.

> 
> rdt_init_res_defs_amd.Is that ok?

The generic vs non-generic initialization argument is not convincing to me. 
Could you please elaborate why you prefer it this way? I already mentioned
that I do not have a strong preference but I would like to understand what
the motivation for this split initialization is.

Reinette
