Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0867A6238C2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiKJBXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiKJBXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:23:04 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9781E02B;
        Wed,  9 Nov 2022 17:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668043383; x=1699579383;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tIX9x420Tp6TD8HMQ/ouIW1DFRG9+6LYYeQtFGMRKow=;
  b=NuSS5bmKxMGsdR99j7etXzfG0vad2tUglgfwXW2XtkqmuDGdZBomftlO
   9+LeW5Hs5VxhSDvCZsamkM2++puvv1qHTyJC4HJeOSg9ezUkMmiUVb7pn
   SkGpoK/+zp6H0mRtjANuhc/3uqXS9X14/phy92kc3huae6ZNwdyeXClHj
   nczhd60nGjHzdK2Y7ONUG7uQMPJvwyWkxEf+wIiI5giHJO0RKdjR1zFq8
   BmQvrvUbjkKBn/mgL+mRQ7BwWDcpvjtn3vbuPLnkRg25ISGjwYY2GhuVK
   sur8foJnKXSl8tT5CMGuui2TsMU1Pazx0VQT2qbTQSOb7NH/VqJ580x7B
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="309887589"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="309887589"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 17:23:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="742649308"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="742649308"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 09 Nov 2022 17:23:02 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 17:23:02 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 17:23:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 17:23:01 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 17:22:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqB7Kzgxe/6isprSM1UkLxSGaSjXoLjTEno524PlpsFg6vmuZGbG6BNw1wsAFH+uWpp8cqXC4r8SCZurFFfMckwD8BkdjzLMgkseW39GztkxkzvVTeFpwVwAfZEIM+fbm6joBBoGAQnNhstsCQOOF4coaEfhRiLqEkqfAvzqpJ5TJ/HHPCNBNCgcfWWHPX7VrkxOZ/rggtvP7Cq9Sh2qrlZaHC8jrY8JEG3DyMTAXdT3zWS4eT4h4QxiXyPc+iC8P9uu1vNw3agubce7uqC0IcB9e1KOYdbmadUwekCRzg0l4/py2r6M0u6e4u86vDpG38vMcCvqE/7G2X/1jXbsnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTTqoB7x5oj7VZNtG1PYnVd7gu2tQomPwrcY/ND/ILo=;
 b=M+R71QKaQiT29Kyp63cIkLrnGhHWfQfczUKlttXdYlax4ZVLnlZF7+oBpN0SBgEs+UEvS3wW6UDE5oCe/mrhhXRniACziK6HsZP21j+foud7E3DAw7OViHCcOEZLjJ+hb7ykfznnyrMx6oKg3bJ8+/hiBpin0kK/4jC6WsDlEOy/FI6JCrTH74ChvVYF0ekQImePxCvXo973tHM/VOVJQwHLr2FkTI2Hbd+Y1/AueTHBoTMraSM+3ZPeZEjMW85o4fZwyv5ECTMOPCMubgR2kXLv6tv6CG+LqQcbh5Z03DlwJ++EXGJ9iCyCooKr3etq38l9DWvKRsGeAOX1YuEJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 01:22:58 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0%4]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 01:22:58 +0000
Message-ID: <6b98f0ef-8529-43eb-1774-ba81c0bb0839@intel.com>
Date:   Wed, 9 Nov 2022 17:22:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 10/14] platform/x86/intel/ifs: Add metadata validation
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-11-jithu.joseph@intel.com>
 <a0f6723b-ecfa-ba5b-5779-c7326cd31a86@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <a0f6723b-ecfa-ba5b-5779-c7326cd31a86@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::10) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|SJ1PR11MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: f06c3393-f5d6-46b4-11ae-08dac2ba19ed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: srQiYyg553aGcGcmE8+k0zb3LOQXKOdgoccZMZ9gyMzUt5vwQVqZBNveM2rwkpk4sICemjzVSh6jhRoTaTPNpY6DTtJIXMWB5wkoPUZJmFue/iHWqR6N92jVhvQ+BcZjGxa4z7acRLwdS3MzWNNnv6r+VoKIXhanDmpizqvBFQyWq8KDK6X+se6+VXb5HV8P37lImqFG9u97tJ+3aNzB1HUlUyciCQkKyJJAi7Pk9CJtSNsCyGFLC+OpkrUi+AKIJxq1W6dj6V1S46RcsqeQ2u8V3k/W2c3gJ2n7bg7r8/xTlDS0rq3B1mkAkAfwDTqYrdJ7ff1ta061e+0ElwNJMgMOdIcRphfnoZuMVYvFCpuEhJJ458QUdk86MSEGcUr8LP53xGOwTAr5jKn9iEPj9KgtZQZ8y0M2Ai6njjrLNUWsEcjF8FZ7E5zJ/mY07xfzzMEEEMSKeBACq7gzHvq7ZXtSEA03aO+zk2S1c+ENlrQB3HC5puY5q1dg6eRT88wFmfA+G21YVIYC4lidlZjCM2/2OqgDLSKqieWdqFSBC+MSQOdOO8SOVJvLn4gD7yx3+beez9nQAdEDp9ilb2VX0yYgGFtiO+tG4l8g92S7He0Z4lMuAaAklCo/OXgtjJjAhSGxKHG67tj5RgfCL/umhSfkSmpKh6GNZJMHgRv/XvraKlC9R1HxjusLEiKJMcgF8vJfnad8tI/n6ABTchYMqC0OOHu/KPlda1yqq9sZPFR3+ghdEwZwvUfbRUXOT3yhB40dhabriZXahawVuI8l43p++wKUOFN8QQq+bnsLLJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199015)(8936002)(478600001)(5660300002)(186003)(6486002)(2906002)(83380400001)(31686004)(2616005)(7416002)(316002)(41300700001)(26005)(82960400001)(66556008)(38100700002)(8676002)(36756003)(66476007)(66946007)(4326008)(6512007)(6666004)(6506007)(53546011)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEF0YXlSTC9YdE1UeHFaR2NPUHhNbFBSMlM5U01OdXQ5RUtLS21CWTlXMTVV?=
 =?utf-8?B?N1RMYjJDZTZaaHd5dXBKNUIrZEtVUzZ3QXhlYWgvcFkvRWp0OGlXYkFxcDhy?=
 =?utf-8?B?T1E4d3c0MGltUk5peVYySDZSVVJDc1lWSHpaYXRBYU5SbDZ6QUdsS2t3bzRR?=
 =?utf-8?B?aGJ6UzZVcTJkZCs1TytXTUIzYjl3UDhwMjg1SVBKOTd4Tmw1TmRPRWtkM1N4?=
 =?utf-8?B?NVRXMnVSTFAzRW13NlhTTEN4Z0daWForM3dYZjRMdFVyMzBkNWNPODk2SUFt?=
 =?utf-8?B?OEg4UC9SY2dmZkFrbVlPZDFBajZWN2NHQWJkK2tuZDdKRVMvUFlDS2c4MXlu?=
 =?utf-8?B?M1NDTDRuMERlVjZiRDdNRHFibkFhMWhiWHBMMTJERUpoWkNCOS9nekxDZ0xU?=
 =?utf-8?B?OHpiRjdNQ1o3TzRBbjBkZjNkanZHQXM4WGFLTzZJM21jbDh2djk1REJDc3lR?=
 =?utf-8?B?Q1pWSDZaZlVXdmc3ZFVpTksxdFlRSm95Mkw5czFXTVlNWVJORVAxQ2JaL1ZI?=
 =?utf-8?B?M1FaWU5QdkdBR1doQVZpNHRaWVBMKzRDRGFGOU82TmxVZjc2bHFCOGxmQXhp?=
 =?utf-8?B?cFMrenp4ejBNdmZVMjFqMjZ5V1JBRnZ5TWJsdy8vS1VnczYxSGthc2xJOFY5?=
 =?utf-8?B?b0RoUUlUbGJ3YmdYVEpzV0NpV2V3V0lKaDdPYVZETHBDUzlvSklWVnZGeVl4?=
 =?utf-8?B?ZnNKTUl2OFhZcTZuOFpLdXZENFhyb3VENjdweEsrYnhsTXIvRlRpVUVBMjhw?=
 =?utf-8?B?VnlIQkdFcnoxMFIxMWlaZmVHazFPUUN6cS9LSnR2NHlUcmxoQmFCM2R3RGZu?=
 =?utf-8?B?SmtINy94djh5RTQ4R3ZPOXdHTmZMQ3czT1U3czNTYWIyL1g0ZEExWnFaTnBk?=
 =?utf-8?B?QnBxNWpXb05wN241UnowbjkzWHZTSUJSeVdJVFdYdWROLzRETlJHN2l3VXk0?=
 =?utf-8?B?cXV2Rnd3YzV1ZGgwd3FyTmhhRjhsdzFZZDlsTk5pVGhzbkRtUjBiTDA4Yklz?=
 =?utf-8?B?aFZDSXVBTXMxOVl1czhIWGFEVTRqa3FCbWdtcmpHYlBFcEZtRFQzRkd5b2NY?=
 =?utf-8?B?NGFiYUFlRjE3RzcybmRvdC83RFZCUlZwREhqN0pGTHEvNTBYYkh0ZDBKREZX?=
 =?utf-8?B?OVBmSG5jNWFralVYS2RHVVIrOWxuZTZoZEV6UytlNmkzQTc1cCs0djVUVURl?=
 =?utf-8?B?dmNNRzZVWm0xbTNlQW5TZDViY0I0cHZEejhDZGJZdERzaUEyK2NiNDgzMk5p?=
 =?utf-8?B?UVNBSHkxM0MxOFdxbUpQeFIyMnZ3bEZjcHhJZSt2ZFNFYWp4LzRtSmowZFZ3?=
 =?utf-8?B?UGkrUmtyNzdUQ3J6ajBJcE9seDRBckMxZzlCQ2VVR3hWSWpCaXpJeFMreUdu?=
 =?utf-8?B?WGJSUHI2NzA1VlZiUTJRdjJjeFI2eDkvZldPZGc4RTdJL2dHaG9wLzQ2Mlhj?=
 =?utf-8?B?SS9QVVpXWUlKT1h4cWdqeTRYZWxPekw3ZEJISzk3NW5nM2I0UThpTFhmS2FP?=
 =?utf-8?B?SjdyZzNCQ3hSRVpJN1hmbnkxVXlLOTZTb2doa3BFMmRzSFM2anQ5WDBWMXJ4?=
 =?utf-8?B?cnEwMWhUS3NyNVlSY01qS0lWYi90ZStqZ3I4SFRuWDlnMENjTm11VDZObDRU?=
 =?utf-8?B?dTk1Wk01TjFzQlpWT1hTdUt5VkM2NHBTQUxUSXpRZHYwY09iQ0M0UVlFcFpk?=
 =?utf-8?B?ckJ3Sjd1UDFocDlHRUZReVZObVNtK2twRDR3OUdjbXBRV3phQXFQbmMwc216?=
 =?utf-8?B?VVd3K0pOYkNoRWV6R0FHd1dOdGxoYmxYZ3lDeTlnRzBIR1gvSjg4L2lTM2tP?=
 =?utf-8?B?cmUzVzVkMitlSUJBdTlLQno3SGVtNjh0M3B4VGFhNzVTYm83cXJCQWhXK3hQ?=
 =?utf-8?B?MDNndVM3RnRKUzNKVzlqUFFCU0F4VWFmS09JZEZ1VkNaSE5JZ0RHd0RlajBz?=
 =?utf-8?B?WW45clpzTWNoeE5Dallrc1FHMHNib2ZTdHRrOUlGSlAyL1B3Wk5aT1ZXWXB6?=
 =?utf-8?B?T2ZiUjN6QmJ4b21Zb3pKZjZvUi8yblVIZjV1dHNLY3BBRzY3Y3QzYWxPUU5G?=
 =?utf-8?B?ZWp6azcwSUc2K0prcHU3bXlRL2JtNVNMbk9BWVRXWHVVRkNnM2JONmhmbWNY?=
 =?utf-8?B?WnVpRS8zdnpIR1l0UFlvWmZiZ2IrR1ViWFYyTUtzQ0tFTUZqRlhnQjBjZ1c1?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f06c3393-f5d6-46b4-11ae-08dac2ba19ed
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 01:22:58.2737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /X7e3sSoI89SjGXL8DL3viVH0D0evBZ6GY/IIIbtnqZAkAJPqSoys46ZLBpzm3wC29FMDiaEz5bp4VOfmuHwmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6083
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/2022 3:15 PM, Sohil Mehta wrote:
> Jithu, I replied to the prior version of the series by mistake. Duplicating that comment over here.
> 
> On 11/7/2022 2:53 PM, Jithu Joseph wrote:
>> The data portion of IFS test image file contains a metadata
>> region containing possibly multiple metadata structures in
>> addition to test data and hashes.
>>
>> Introduce the layout of this meta_data structure and validate
>> the sanity of certain fields of the new image before loading.
>>
>> Tweak references to IFS test image chunks to reflect the updated
>> layout of the test image.
>>
> 
> Can you provide some more information on the updated layout of the metadata structure?
> 

Here is the layout of the metadata section in an IFS test image.
Test Data (chunks) follow the struct meta_data  defined in load.c

    IFS Metadata layout
   +----------------------+  0
   |META_TYPE_IFS (=1)    |
   +----------------------+
   |meta_size             |
   +----------------------+
   |test type             |
   +----------------------+
   |fusa info             |
   +----------------------+
   |total images          |
   +----------------------+
   |current image#        |
   +----------------------+
   |total chunks          |
   +----------------------+
   |starting chunk        |
   +----------------------+
   |size per chunk        |
   +----------------------+
   |chunks per stride     |
   +----------------------+
   |Reserved[54]          |
   +----------------------+ 256
   |                      |
   |                      |
   |                      |
   |                      |
   |Test Data/Chunks      |
   |                      |
   |                      |
   |                      |
   |                      |
   +----------------------+  meta_size
   |   META_TYPE_END (=0) |
   +----------------------+  meta_size + 4
   |   size of end (=8)   |
   |                      |
   +----------------------+  meta_size + 8


Jithu
