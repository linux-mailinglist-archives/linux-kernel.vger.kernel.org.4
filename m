Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DAF7437B4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjF3IrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 04:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjF3Iq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:46:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A101D194;
        Fri, 30 Jun 2023 01:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688114815; x=1719650815;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dzcAwYid69uXqzOzvxMH+vMvvDeC6Apd999OrKd5sUo=;
  b=nQyfCB0oPy5TfTQxa99XHLnawbaw0dBgthq7yjosiAKMf2/VoDNaVdjo
   jUdMdk0OazVummbqE177ulZcJ8jqgD3W30LKB2uqRodX6cdr2+2FUkw7c
   RcRJmR9k12g3VZ2TNdKpmBxs9h/NHuTinHcdneLSlSdlsZr2qslAkKtG/
   0xvEndLlJr11mC3Wd1CAD42iYOQsNGjpDfaW7jN2i+7/80tDPR0BGUwUF
   jnDYutIu59ya+ZEwjnUMq6aQQ/G7B4KrmGi62lwYEROhNTUQjQl65Utu8
   xDpINZBSkRvjMQ/yDeEF2W+zQCSz96hsRuk54i/6F0unpXrAXXhHx3GhN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="448726324"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="448726324"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 01:46:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="841785723"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="841785723"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2023 01:46:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 01:46:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 01:46:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 01:46:53 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 01:46:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0H/PKNis4Vc7zwUp49wD61uoKmQHGhQozGGPIIuTR6GR8IfnWJ/YiyXI+NbTMe0FJ3whWwfaSY5oGn6N3I1TGv8dvHL992kJki4m6hv26als1XBV/gyRkzpDIMPrEQBVYH+2H7Pz7NBjDXl/gJkWxZLx1QD+PByzI7VBUj7mGuUzQ6nznNWtNwzBLVulyxfcmixm0witqFWEBJ9QWSGOhX1vbixceGNMS+CrXxs9FO0a4oLJsUJaJXnMTQcMy4BZofSVvUKDM0tbAQ6EphLYykuazzFZavrtum5og1UgPEK8iH9fwrIZ5mdPmwvv/H++kAzc7iqwJ25olEyjwjQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERP7t46yUT2pxtaSbeoFZSzyFpmfW6K4AfFW9Hnk6wg=;
 b=k/PreqM1SEt7GxdN4tBQbeqapLXMCNWlKoqOQ2zj9oXq46kuZSKN5g7OklDtr5q1p5vWMkevMKxO18tOiAcfI5A6sr0R4UB2PeDsbeybNKFeBb2moFFIcXQ2W7hXKw3zXD4vdglP/JYWYYoyYpY4uahe4zlZY+v2YQ1E2EvQHJjuARCvQSIZPtkokE3o9JI2pk0l6wnszJ1lXuII+WGanDhbIfGwbxXEAZpqWMVRBp9unvIWksND+H8c5VxaczM03AbeaoAFKyjzvWfbdD5/pAcFiHh7Tdd/9JM4kW8AswH5hZtNS3Pi1jkqp5299IGir+AOQAufTKNO+Svzq/2QMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by SJ0PR11MB5039.namprd11.prod.outlook.com (2603:10b6:a03:2da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 08:46:45 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 08:46:45 +0000
Message-ID: <72ed8f32-8bfd-2d25-a377-9adbacdc8c61@intel.com>
Date:   Fri, 30 Jun 2023 10:46:37 +0200
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
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0j+Wz7366kLT3ez5TNoGWXvsa53hBYYeS=aHgbTJUqvKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::10) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|SJ0PR11MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: d313f9a4-4bd7-43f0-b5f2-08db79468891
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xI9AM0H0uY5uQFNZ+kZM+L+IkQQX7dqRj/A66A4DnMMWepIr0hKQ9sOtX82Auy3xRLB9NZWfRnaFK1dCLkmPMsQPJ88MULVU+2l+RvbxUKbr0LapcZQNsZqO/io5xHW1OGuT182/ZXImsnSuRqRaEWYmPjvxBJ6WqJ87pIQHDRQ4YfNQg14b6Vg8tszADtQJtBRg0znFpkvn6I8o9O0o4MbOi31qJQcvZRc5KVMdLEsgI1BVDXuaiNhHGnUVnHbNkTtpp/TTGvSFkXGQaEPtz1jbkaF9Y8fi5LaBRVk/6LQj7XuVz4wkvzmJ+9jskel4Kq5BaRSpdOy49XAkwCHwgX62Oa/v40UTqG0LtSig/1EKQOWNBvCjrSQ+1XxTQTJwmBRvg0UBsOHjHa6KU81miXMTXaPxqwmtQiACin85WWUuSHCBFYoUSWjthtLYeSwsQN2w45HjYcmMmmCMLlSOFndAH9GXY+pDU0MQvDw6L/mq55daQcVb7+pjyWnMMYZMCIWt5QOCXCmGkgQCco8c4FDNBWg5r5k7oDZj6/u9o/DTh74zxnoSZQte+sHdsZYZmzqnl/aGa9BbJzOtkh7xmGdlG+1t7/XodF5J5hgXktd3wjd3/VHMPHfPMPgKRNouVN30XASYcJYSLfqs6d1vA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199021)(83380400001)(6666004)(478600001)(6486002)(66946007)(2906002)(186003)(26005)(66476007)(66556008)(6512007)(53546011)(6506007)(316002)(41300700001)(38100700002)(7416002)(5660300002)(8676002)(6916009)(8936002)(36756003)(4326008)(86362001)(31696002)(2616005)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlEwckk4UkUvQ3FxNFdsOE53YzB2TlVuZjNBY0s0R1RVbklPbGFIR1ZGNjcr?=
 =?utf-8?B?Mm54cW1CUFRjM05udmE2bi9LWUpDbG9tbGlvSlpHM1hHQmYwR3Q2RDdJMVEv?=
 =?utf-8?B?Y3JFenhGNW53NjVObXo0WmxZdmFsNGFyY1Ivc2NoeERManNERWlJYXBUOE1q?=
 =?utf-8?B?eUtmby9lNlFBUkxlQjhYMTdES05LaTBuL296M2ZJbDhWbXgvYUtmUGJTTGpa?=
 =?utf-8?B?V2NQd2tZSlJIZUFWbjhsaW0yVFRDYU5XVFN4SUJRaDFqeTU0ZDY5K2p0M3Bl?=
 =?utf-8?B?NXlwWk51WktTOVJNcUpsTzdWWDU2Q2VITitScUQ2dW9zUk41bWxHRmIrVWlH?=
 =?utf-8?B?RUwzMFE2VXdFVXlrYys3WXRjdHhLSlN3TU5TNEFMQlovck9rekNtMnZlWUFF?=
 =?utf-8?B?L0JFYlZ1NThuUGJ6VFNPU0k1ZTVKT20xV0MyeGJSVnpqbEk2MDVOempDbWlH?=
 =?utf-8?B?eGM3VkFuQVN1Q2ZnRnhsZEcwa0RpY2IrMXNTZ25WZ1NYSk5OSC94bnUxZHFY?=
 =?utf-8?B?TVBZL2g2NU1BdHhEK3luZzluSWdoc25OTENqRFNmTjdXc2pmM01oNUZGd2pS?=
 =?utf-8?B?dkJsRkVUVDBjRExJVnZ0SUxnQ2hlNlQvc1lHbGZTbFJKdDJicG95bTY3WlVQ?=
 =?utf-8?B?ZDNwbDRwUjZCY01xU01LVW1BQ3JwMkY2N25tb2xqMmJwMTZzb1pvWG9wbFpE?=
 =?utf-8?B?MzJKQmlvM2lUYm9wZ3lyNjJGbU9ONXRFWTloYlhQWWJnN2lQMGp6bC9UeTVL?=
 =?utf-8?B?anN0blpsc2J4SkxScE92ay9aRTlrQS9rWTMrUzM2RW9CcjhLRXpwa2FYUFN1?=
 =?utf-8?B?QmhWNUJkTEJHZTc2T1l4bUtPRG5rZ1ovaC9xYWdQRFRtTnFBZ0Y3bG5iemlw?=
 =?utf-8?B?dXVESmhyU0VzM1ora2hDNFVvbUVjaWcvMEMvM0hoT2lYcnAwKzhBY3RCaC9i?=
 =?utf-8?B?YWVBSFM5VmVhSmJJekszcGovNzlVcDhLK3E1a1NLMVgzMGVuSFVJL1krWWtp?=
 =?utf-8?B?TXJaa09ZTFp6bFpiMHNCc0FvVGlJUlRqbVJPWEFpOVdPaWNLcHVPNzQxUSsy?=
 =?utf-8?B?R2VhT1hDUlZ3L3RRcStodVdNQkc3cEppV3ZqMkR0SWZGcVRjelVtRkl4OFNm?=
 =?utf-8?B?WExrT0c2R1JoSytza0xMRnhhM0ZBb3k4K1lPaHIzZnZCdzQxTnUremwzTi9Z?=
 =?utf-8?B?WElzUXhnai90c3VFUHArSThqTEFzZ2drTklSQmdFWWtDb1g0RHVKb0FZREEr?=
 =?utf-8?B?SW1SZ09nQTQvY2dxZDZwOXZpVWpvWXJDa2xlL2UwN0swM1lVSFJJNWRPWFhC?=
 =?utf-8?B?bGZ6R3pNa3BiWFplUWxiNjl4eFE2VUFwSjZCcTdMV1B4NEcyV0hIK25uV1BR?=
 =?utf-8?B?WjM1eFprc2lJeDZkWlRmSXhMTFhsNXZhblBaVTRHbm8yNWx1aTRhWkl1QWlW?=
 =?utf-8?B?NUZlUFNyV2Q1L28ycUpTTlh5cHlueFg3RExhWlBkRjJyd3ZXbGJ0ZmZyYmM3?=
 =?utf-8?B?dTZ1SFl4ZkNDdjdVSS9UMkZGZ2pLUlR3KzdzWE9LeUxwaU43ZXRtVERUQ1pn?=
 =?utf-8?B?VUgwQTlHYXMyWnZWeEFwcGZWTkVXTHRndm93ZWVlRzFWOEVDVkNxZ0duc0Vz?=
 =?utf-8?B?c2F6cU9DazNVYmE0Ty9lRVNGMDZRZDA4WkFOR3JXNlN1TXlaWm05UDNXbVVx?=
 =?utf-8?B?aTdEaUZtOFN4WmZnVDVjV2wrakdOWjVaYTlNVmhkeUlEN0lNcFZCcXRBU1dV?=
 =?utf-8?B?UThjMHV5b2Rtd2RMc2ZIckE0WCtTQVBHTm01eGxLL0JxTzYwS2dJMXZaRXpX?=
 =?utf-8?B?dHJHUVM3WGoyYWlDS21yVW5BMDFkeG5COEdMeDhJcDNpcUVZT1MraVk4dzJ1?=
 =?utf-8?B?UXErUVd6Z1NiVXZFanVKdTl5Lzcxei9XQ3N3SzE2WWJVVTN1MFNDM2NNTHlq?=
 =?utf-8?B?Z3lGSEMvbkhHWWJyOHJaUURZMmhLdm9oNXFNem14VG9jMTluclZpZm5hKzBG?=
 =?utf-8?B?VmF3WG8yM1JaU0NmV2Vvcm05OFZ6Z0NYdmNZQXFnZGNRZURDSHZCbzREUnNZ?=
 =?utf-8?B?ZUs3YjlSMG9Rc2E1ZG9YcDZtbkZjTlJvamQrRmZ5U3JUbUxpRE1zajI3T1FJ?=
 =?utf-8?B?cW1MSGdFemttbVRPb2RHU3A0WlFFa1RCR1ZiSlRtcG9qcHVHVGNkUHNTaVRt?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d313f9a4-4bd7-43f0-b5f2-08db79468891
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 08:46:45.1304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEj9gA+74tkhDqnFZi+JzcX+v4CNsfCi6OO7tseEBuyYX1NOLl6AGvT2CVmus4sblBDFYf01goBM/xoRnriR86AWJkUnMLE9O69kBUhSuuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5039
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


Hi,
Thanks for the review !

On 6/29/2023 1:04 PM, Rafael J. Wysocki wrote:
> I would just say "Introduce acpi_processor_osc()" in the subject and
> then explain its role in the changelog.

Sure,

>
> On Tue, Jun 13, 2023 at 6:12 PM Michal Wilczynski
> <michal.wilczynski@intel.com> wrote:
>> Currently in ACPI code _OSC method is already used for workaround
>> introduced in commit a21211672c9a ("ACPI / processor: Request native
>> thermal interrupt handling via _OSC"). Create new function, similar to
>> already existing acpi_hwp_native_thermal_lvt_osc(). Call new function
>> acpi_processor_osc(). Make this function fulfill the purpose previously
>> fulfilled by the workaround plus convey OSPM processor capabilities
>> with it by setting correct processor capability bits.
>>
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  arch/x86/include/asm/acpi.h   |  3 +++
>>  drivers/acpi/acpi_processor.c | 43 ++++++++++++++++++++++++++++++++++-
>>  include/acpi/pdc_intel.h      |  1 +
>>  3 files changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
>> index 6a498d1781e7..6c25ce2dad18 100644
>> --- a/arch/x86/include/asm/acpi.h
>> +++ b/arch/x86/include/asm/acpi.h
>> @@ -112,6 +112,9 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
>>         if (cpu_has(c, X86_FEATURE_ACPI))
>>                 *cap |= ACPI_PDC_T_FFH;
>>
>> +       if (cpu_has(c, X86_FEATURE_HWP))
>> +               *cap |= ACPI_PDC_COLLAB_PROC_PERF;
>> +
>>         /*
>>          * If mwait/monitor is unsupported, C2/C3_FFH will be disabled
>>          */
>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
>> index 8c5d0295a042..0de0b05b6f53 100644
>> --- a/drivers/acpi/acpi_processor.c
>> +++ b/drivers/acpi/acpi_processor.c
>> @@ -591,13 +591,54 @@ void __init processor_dmi_check(void)
>>         dmi_check_system(processor_idle_dmi_table);
>>  }
>>
>> +/* vendor specific UUID indicating an Intel platform */
>> +static u8 sb_uuid_str[] = "4077A616-290C-47BE-9EBD-D87058713953";
>>  static bool acpi_hwp_native_thermal_lvt_set;
>> +static acpi_status __init acpi_processor_osc(acpi_handle handle, u32 lvl,
>> +                                            void *context, void **rv)
>> +{
>> +       u32 capbuf[2] = {};
>> +       acpi_status status;
>> +       struct acpi_osc_context osc_context = {
>> +               .uuid_str = sb_uuid_str,
>> +               .rev = 1,
>> +               .cap.length = 8,
>> +               .cap.pointer = capbuf,
>> +       };
>> +
>> +       if (processor_physically_present(handle) == false)
> if (!processor_physically_present(handle))

Sure,

>
>> +               return AE_OK;
>> +
>> +       arch_acpi_set_proc_cap_bits(&capbuf[OSC_SUPPORT_DWORD]);
>> +
>> +       if (boot_option_idle_override == IDLE_NOMWAIT)
>> +               capbuf[OSC_SUPPORT_DWORD] &=
>> +                       ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
>> +
>> +       status = acpi_run_osc(handle, &osc_context);
>> +       if (ACPI_FAILURE(status))
>> +               return status;
>> +
>> +       if (osc_context.ret.pointer && osc_context.ret.length > 1) {
>> +               u32 *capbuf_ret = osc_context.ret.pointer;
>> +
>> +               if (!acpi_hwp_native_thermal_lvt_set &&
>> +                   capbuf_ret[1] & ACPI_PDC_COLLAB_PROC_PERF) {
> Checking it in capbuf_ret[] if it was not set in capbuf[] is sort of
> questionable.
> Note that acpi_hwp_native_thermal_lvt_osc() sets it in capbuf[] before
> calling acpi_run_osc().

We can add condition before checking capbuf_ret i.e

if (capbuf[OSC_SUPPORT_DWORD] & ACPI_PDC_COLLAB_PROC_PERF &&
    osc_context.ret.pointer && osc_context.ret.length > 1)
 

>
>> +                       acpi_handle_info(handle,
>> +                                        "_OSC native thermal LVT Acked\n");
>> +                       acpi_hwp_native_thermal_lvt_set = true;
>> +               }
>> +       }
>> +       kfree(osc_context.ret.pointer);
>> +
>> +       return AE_OK;
>> +}
>> +
>>  static acpi_status __init acpi_hwp_native_thermal_lvt_osc(acpi_handle handle,
>>                                                           u32 lvl,
>>                                                           void *context,
>>                                                           void **rv)
>>  {
>> -       u8 sb_uuid_str[] = "4077A616-290C-47BE-9EBD-D87058713953";
>>         u32 capbuf[2];
>>         struct acpi_osc_context osc_context = {
>>                 .uuid_str = sb_uuid_str,
>> diff --git a/include/acpi/pdc_intel.h b/include/acpi/pdc_intel.h
>> index 967c552d1cd3..9427f639287f 100644
>> --- a/include/acpi/pdc_intel.h
>> +++ b/include/acpi/pdc_intel.h
>> @@ -16,6 +16,7 @@
>>  #define ACPI_PDC_C_C1_FFH              (0x0100)
>>  #define ACPI_PDC_C_C2C3_FFH            (0x0200)
>>  #define ACPI_PDC_SMP_P_HWCOORD         (0x0800)
>> +#define ACPI_PDC_COLLAB_PROC_PERF      (0x1000)
> I would call this ACPI_OSC_COLLAB_PROC_PERF to avoid confusion.
>
> It may also be a good idea to introduce ACPI_OSC_ symbols to replace
> the existing ACPI_PDC_ ones (with the same values, respectively) and
> get rid of the latter later.

Sure I can do that, most likely in a separate commit preceeding this one, so
it's easier to explain and review,

>
>>  #define ACPI_PDC_EST_CAPABILITY_SMP    (ACPI_PDC_SMP_C1PT | \
>>                                          ACPI_PDC_C_C1_HALT | \
>> --

