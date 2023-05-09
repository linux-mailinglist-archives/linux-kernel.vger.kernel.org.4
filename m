Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B076FBC04
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 02:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbjEIAbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 20:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEIAbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 20:31:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01E42684;
        Mon,  8 May 2023 17:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683592307; x=1715128307;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FxAC9HFffP4QS4P3lFpQnijkdMSaObgV3T735L9/K/I=;
  b=jFshmrIDta37Z62IuslSsXCf377jO+xtVSS9mxO3RbHyCj/1J9c0cNGk
   PhD7sNf7PYidS5+sgpYXfZYgia9EvUT9QYNU3kII9yvbnznwqAoxy+qd3
   cQO1hofEhVOShZnRcy8lF11rTPiRkox38agKiok6WCmWFxBzvUtuGjAUt
   frFYx4TWF3hD6GN+LA6p2CCtAY5Y0LMi2SfaY0cpMA/FUjpvM5wBtlTKX
   MP8bG1pdksSaP3/LO6O19karlIuH/+erIyu82hCQXvD7ffobkSgUPXQEC
   7e5CxGiw5bA3Lpa9Mu48GSD6cVqcFaUF7vZtbU7xwkiiojf0xjPsEdlEU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="436100470"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="436100470"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 17:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="692775031"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="692775031"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 08 May 2023 17:31:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 17:31:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 17:31:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 8 May 2023 17:31:46 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 8 May 2023 17:31:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1xI/H2Fy8OwmTsk9liwEI7nok4kga5wqJ06IglondNspQ1tU269qdeDMlI+8h1b/rqxmuDvx5CjRiU7jKSPU0KN2pveXRXZsuHZfNUaoPFp789x/WDflvwRA/2tA2ylrLsEoIWFV+3iN90mCXbF/Soysl7TshRm3xL1Bad29+QjKofJusHVZYvj8Ei7A0uJQeE6gHdfltZa0QP4kIz64naS/Cuka+8mivTFnAFCtfE7qSzhwze9k95qvPgNmj+EyatcX2uhlNL8pYltpltAodzIxlLqdD3EHi2OagN3o9XY0K3uvOM79OCP2c/RSS5y+gHicy/tUjjHJQvEa/nMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raJAsgIAIrV46F7NP8hy12BhP5P4ys0YENBZNLeLAjg=;
 b=UwVAGUbpqKIkRRanFLPFX4IR5qM9SAvPa8FSwhwXpHxHJl9N3DJU1N3ESKDvRSzmBPCA4gNjkzeVGPB9e7LK3LDVdyyzqRyvJqbsScHCoR4rluoNOGmRbqFKQo4tP3/j91NcXPWkku1LYCt/GEg/Gtya4wLnurVISrxkcDKYp8y2CU+hj3cfb9GLlAuhQauS1yMMnV+b0ODZMWFXAPKzA580H3b6dVqNfxcd+RdWio8jTaSPgZVSWcNx9NviEsoSPWpdnHFyESxznogxR71EK93Piqh+AFlhfZQHnCouItk7kEzwfaf77IZak1hku6vKm8RReBdso9GKVKvaZbAXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by BN9PR11MB5242.namprd11.prod.outlook.com (2603:10b6:408:133::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 00:31:43 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::cfb2:e73:907d:cb77]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::cfb2:e73:907d:cb77%5]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 00:31:43 +0000
Message-ID: <e9508862-1fdb-d27f-8138-3b7691671405@intel.com>
Date:   Mon, 8 May 2023 17:31:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6 07/12] x86/cpu/keylocker: Load an internal wrapping key
 at boot-time
To:     Dave Hansen <dave.hansen@intel.com>,
        Eric Biggers <ebiggers@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <dm-devel@redhat.com>, <gmazyland@gmail.com>, <luto@kernel.org>,
        <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <mingo@kernel.org>, <x86@kernel.org>,
        <herbert@gondor.apana.org.au>, <ardb@kernel.org>,
        <dan.j.williams@intel.com>, <bernie.keany@intel.com>,
        <charishma1.gairuboyina@intel.com>,
        <lalithambika.krishnakumar@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230410225936.8940-8-chang.seok.bae@intel.com> <ZFWLoOZZTnBrid+7@gmail.com>
 <1b2eb485-2320-b33b-a0ac-53f7cb170adc@intel.com>
 <8748511c-cf9a-f3ce-e560-d0646dc3d108@intel.com>
Content-Language: en-US
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <8748511c-cf9a-f3ce-e560-d0646dc3d108@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|BN9PR11MB5242:EE_
X-MS-Office365-Filtering-Correlation-Id: cd45822c-d526-4518-029d-08db5024c370
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTNElw/6lvRMvc0B08EnyO96sfAY8paHYUvmL0khEHdrfFlPcxBtyOzuSt/zwCP5VXXjKlcPB+lEfCltIZjiGXO7P1WMgoQuUyuvNDWNTQFQD1K7JkUy2rMxgelBHMEtazHgm4llfhl/9SYBt8DJtWc4f/WVAAWmCtx9nYTQZBe6InLi3Z2U4MOTuxmlkd2tUFnKZOVsc4biJ2gom14qexw2Xq26HFRylZsZnA2hvLFfEGVQQ/ZjrH8N72rUgBa+YwdN7d0nrRbaoPpKYGtFGfGvpdYcr5jR3fGpNhCgx7T9GFy4ST4EkiIIOZKotrfq08oC0d/zVE4R5lCcLp0jzNp/TgUyAA4v7+nqKatAnsshzBaKs9OK9WFrzMIo2UWPJuugn5Pe99X+n2ttMJBeNxnKsrdFInkwmbYatql7EphVr034CksX7its5r+31VGf9JWqsPNRD0ZrvqNBP6nYb0JaK/ciZJT4MGV0AeYCdkMB5aVZQxR2yA9jODP0p1Is4963VCkQ9hRsbXR8BDk4l6SdsRZEbTtWBYrVXzKeMIsfJmzS6FIQ47NaNr+5TC/4U+nDN+jEvvDaD7C55V9iA+qzn9sLPmaEGmZEZ22U0ciQvGsBpfi8HTMFgF6pPFaqr8Y27oMb4B0SK1YMtz7gFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(31686004)(66556008)(66476007)(478600001)(4326008)(110136005)(6486002)(66946007)(316002)(54906003)(86362001)(36756003)(31696002)(83380400001)(53546011)(26005)(6512007)(6506007)(2616005)(7416002)(8936002)(41300700001)(2906002)(5660300002)(8676002)(82960400001)(186003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGU1TjRkM2hBR21xSElNSkJLUnpDcmpXWitSVHF0TTV6ZkhsSmFKeDJBNnk0?=
 =?utf-8?B?VFhpVmZVMlBTZHZITUNIeFRXR0tFem9nRHBkajc3bTNhc2IvYXh6SE5jRE5r?=
 =?utf-8?B?aWpYWmpHZG5IS2I4MTNBbmZJcDRNKy8rbnl5bHA2TXJEbDFDOVpVdzRKNkc0?=
 =?utf-8?B?QkpxQVVUOTRKREUvR29UMHFYSlBDcFRkcXBsLzluVW56QzNOZmhVaElWQnRH?=
 =?utf-8?B?aTJ1b2d5NEkvL0xvUjNmbm5LRGRONGd0aldoNlJMRXRyYVFLSUlDVzNGVW1K?=
 =?utf-8?B?TE1RWXNiTEs0ZGJ5cjRQRFJ4b2ZaM2QzTUdJK3R2eXVsTWlXTXd0TkdpY0xY?=
 =?utf-8?B?SU03TGx2VzM2dEFqYk90MUNmaG9LNlh6WDdpSEFXbmVJbnlLTHcvQ0FzSUhy?=
 =?utf-8?B?MnIrTjk0R3V0dGluNDlpZjZsN3I2Q0M5N3Z0aVltU3h0MGc1b204YWFBTkVv?=
 =?utf-8?B?bFlEd0g5UTdwR2JVM2NHRXZwNUNpSTM2YVZOQ0RmTWorRk53WlFFcWxjN1I5?=
 =?utf-8?B?Y3NWZDRoQjRGNExJWlFjRXJFdnVVUlV0cThKYkhINDBNenNmSWpXby9DODVy?=
 =?utf-8?B?YmZ3NURYZUIxUnhnTFNETE1FYUpybXZvbEdxSmhkRkVCZGlBN1gyOHVqSFpw?=
 =?utf-8?B?L2o2ZmVLUFJFUWlIYSttb1ZCdStaL2Q5aE5Fem41MTM2NFM4SGIvZW5tZXFZ?=
 =?utf-8?B?dFNXd3FYOGk5cHNFb1BNSjBUdi90cWUvYTFCTzBYTjdISmMvaU10Wi9DOENz?=
 =?utf-8?B?MU1hTHoyQjhXdm85OWxRZEJSS1c4Z3lHT3NDMGNCc0wzSVhEc2hXc0s4aWZk?=
 =?utf-8?B?QjIra3JMYTRrNEx1cTlwV29NdlMvZnFURmVmVk9UejdYR1FSTVBHU1ZMQWxR?=
 =?utf-8?B?VlVvcnc0M3NHSGx0NEhjUVAxSjE2OVVCUWZyQUR6WldUSFpjcm42emRDZnpk?=
 =?utf-8?B?S3J6akZSTVB6eHltbDFkRUx1QzlFYnYvVmtiTnd1eEZyUEJRd2cvelBqdEVz?=
 =?utf-8?B?ZTdZakNyemZtSVc3RDhNNG8vZ2VlektlcVgvdjdoNHlyUEdUcWJsSC85Z1Av?=
 =?utf-8?B?QUlENXorQUQ3NGdSV1lING1kVTZVNUVQRTBENDdYSEhHSzFVbnZrejAxaEpl?=
 =?utf-8?B?TUtKbC91UDhmTE51NFh6b295dmY2cEwzUE1LMmZPanovdlJNc2FKK21zdXF3?=
 =?utf-8?B?bXVPbTZ0TVppRFpRTkFGazd4OG9uSnp6S2RsbHJOYXdIblNySFFPQ2J6cnJD?=
 =?utf-8?B?VE5abEFwTjNFZytaQTh5Zi9RYjR6bVR1dDRpaEc2UFJqMGhISkdSTmpqNjZO?=
 =?utf-8?B?cks5NDdlWUwzYTlUaVVlQmd4YzFDaGNVcVcvZUN6UHlZTlppMDFCejNKQTFa?=
 =?utf-8?B?Y0RMOFdMVnZXU0NtU1Zod3FDY1hZMlBaL01wTTVnWkw4NVJDVXVnbXdkOTJq?=
 =?utf-8?B?RmJFblhPRFM2MGJUTzJOc2xTSFZyTmRhbnFjWUUza1RXbDdOOU80TWMvbHF3?=
 =?utf-8?B?ZjE0ckg4Z29MNGJHM1pmZkNYNHNLSnNTSmZaL1ZWaGROZ2FBUjF5RVRMSlRs?=
 =?utf-8?B?QjAvY2NEblFhc0FIc29LQytaVWVtTzhlaE52UklhNnV5UmxmNjErZy8vV1lK?=
 =?utf-8?B?NHRJWW1WZXlYV3BrZHJncjRyRHZRd2pScWR2N1dOUVIzS2lJcmh3WlloZXhM?=
 =?utf-8?B?cUVPMDFINTBJWTFGNytWZ0NlMndLOHRCbFk0c0NnbUZpMWRQWHpnUEFFS3ZH?=
 =?utf-8?B?eTRrc240ODgyYjB0MW9rZWF5cW9IdzM4MTRYRnpkZlhwcE1Vang2UmYxM0oz?=
 =?utf-8?B?NUl4c0hjdGJGZnNNNUNKK0NyUE9SdHJZSTFyeDM1TG0yelF4bnlTMXBQU1NK?=
 =?utf-8?B?MnRwTkNtaXZaVUgxL0xwKytPQWNaNGQ2RHk4bHRRTStXNzd1ZnY2TVVLU0Nv?=
 =?utf-8?B?RWhWZnk1NU1RSkpsNnFNL2gyKzJiL2hpdUo2bW50V3ljdjZpR0o0VEd0WVFB?=
 =?utf-8?B?NDVxSUdOWFE3cFduOEw4NFJtaWtYbjVtYVE0WWNTR010K1ZmYXhqUFR5NGs1?=
 =?utf-8?B?SXdYeE1qd05LMFB2aXdwa0lGNXBDSlpZcHZubjVyYU5hSkQ3L0c0WnplRmpT?=
 =?utf-8?B?QkZtMUo4RERDeDVEVGZyNmVJQWh5TStSM3BEN1lKTys4eklidmgxUExxZmYw?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd45822c-d526-4518-029d-08db5024c370
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 00:31:43.3789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nRd8Fq355H87Ez+6piZv2qJ/TKfMUcrai9G8ouzUXsAjdgKtuobNwogdoAbp7bIUvB+BDiQe/RVsS1m7WB/mk0oCnOXt4VF1I4vYVskBh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5242
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/2023 2:56 PM, Dave Hansen wrote:
> On 5/8/23 11:18, Chang S. Bae wrote:
>> On 5/5/2023 4:05 PM, Eric Biggers wrote:
>>> On Mon, Apr 10, 2023 at 03:59:31PM -0700, Chang S. Bae wrote:
>>>>    +#ifdef CONFIG_X86_KEYLOCKER
>>>> +void setup_keylocker(struct cpuinfo_x86 *c);
>>>> +void destroy_keylocker_data(void);
>>>> +#else
>>>> +#define setup_keylocker(c) do { } while (0)
>>>> +#define destroy_keylocker_data() do { } while (0)
>>>> +#endif
>>>
>>> Shouldn't the !CONFIG_X86_KEYLOCKER stubs be static inline functions
>>> instead of
>>> macros, so that type checking works?
>>
>> I think either way works here. This macro is just for nothing.
> 
> Chang, I do prefer the 'static inline' as a general rule.  Think of this:
> 
> static inline void setup_keylocker(struct cpuinfo_x86 *c) {}
> 
> versus:
> 
> #define setup_keylocker(c) do { } while (0)
> 
> Imagine some dope does:
> 
> 	char c;
> 	...
> 	setup_keylocker(c);
> 
> With the macro, they'll get no type warning.  The inline actually makes
> it easier to find bugs because folks will get _some_ type checking no
> matter how they compile the code.

Ah, when the prototype with one or more arguments, 'static inline' 
allows the check. Then it is not an 'either-way' thing.

Looking at the x86 code, there are some seemingly related:

$ git grep "do { } while (0)" arch/x86 | grep -v "()"
arch/x86/include/asm/kprobes.h:#define flush_insn_slot(p)       do { } 
while (0)
arch/x86/include/asm/mc146818rtc.h:#define lock_cmos(reg) do { } while (0)
arch/x86/include/asm/pgtable.h:#define flush_tlb_fix_spurious_fault(vma, 
address, ptep) do { } while (0)
arch/x86/include/asm/preempt.h:#define init_task_preempt_count(p) do { } 
while (0)
arch/x86/kvm/ioapic.h:#define ASSERT(x) do { } while (0)
arch/x86/kvm/mmu/mmu_internal.h:#define pgprintk(x...) do { } while (0)
arch/x86/kvm/mmu/mmu_internal.h:#define rmap_printk(x...) do { } while (0)
arch/x86/kvm/mmu/mmu_internal.h:#define MMU_WARN_ON(x) do { } while (0)

Now I feel owed for some potential cleanup work.

Thanks,
Chang
