Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6116D6663AE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjAKTXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbjAKTWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:22:32 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A7BE27
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673464899; x=1705000899;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=82GLAndZ//JYlIQ4A3P2Vamhprwui1jesFViKNBC5FY=;
  b=jPvRmXT/rYizoRq7WNoPtRooPBYuOgXusGaauGVIgSn0HhO2SzFF8xUa
   IUK6LHJr3UU6U0KfWwhPEKuxiDZNki7zlU7z9jPHqfBiVWOMICkwiAxBW
   NQXTjMm4U4rajvytd3SDdwvX0uy0fyW30B2nZy19iF8UOFe6iComSW1TV
   njI3NPO4MnQ/xBeOSWs1LYeUNF+MkJRQLpDX2EknLkZ9jV/QYs7Q5TpoL
   qMx/p+yIDVDLbjj+OHj3Llu94tVWf7CGy+oeuSjVV//C4qB7hySF/Iiuq
   3bcamFOe8PSfoZB+Qa81xjii+WW4+Xw7fu/XUCX5wNYFdd5lczPCdd6PI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="322214532"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="322214532"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 11:21:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="657529903"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="657529903"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 11 Jan 2023 11:21:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 11:21:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 11:21:37 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 11:21:37 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 11:21:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acVZ8QS8PRCuqoQpPMb44FLX7E8ghgwSzGcY0ROYXLjfzG+yExX42PLqvR+bsVnqTWXvWuP/dQ2MFE0YsEv6iTKET8VqPAzxFYK1+EGtIlP8/hbRq2HCE65oSRjylLSqHueVLIG0PDZmsM8jchkWHK3PZ2B31eHBCXzFXorat6i0KU2xc7SnmAbMFnR8YZ6wwk8iqSdqTLYq4quS3RM52Cw8HBg+cx+kURCl+ebk7/DnqyhlkXSQzpgcm5gi/Y8we2hEZnm0/caJuqTrmUVhm+SP+iPXyOV5dpkJ5sFvhASUxWXZVjQZrxwYfnsgPOP2+B13qQZU1grp9b0yMRaeuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPjWF02A/S0DAXqLm137TWxvOw6OIBNJM3eg1UDiGsw=;
 b=VgNi96tYtfMvODJJ/4eGcptWiGTIrKWzKkC/xjWhcP4Rn65HZxRDVAdJvpj/tiWX+NzLg7gSzqCdu6E8ukjH6RJ1SlPShFj6H+BJf9jshchZ79nDXrEdqPZfLsgO1jwO33KjNjk5kkIkiioHqjpyqPxWYpxQy2ixYqNOqLn1UVOEGPGWxATpxIBVkU3e3l4GWp6XppoGVuOF1BjNNAeE6XsWfqAOQgrpgco+aiHqQVFF//0W5O5kQOpJwGgESHSbh4oeU8qTQMSrEo+jCLl9Tp+9BcxzecZUt+e7wixNmhlJUA8ESSeZzwmBP/SE63wYVuyPd4TVAgjsqmkPKbgF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10)
 by CO6PR11MB5617.namprd11.prod.outlook.com (2603:10b6:5:35c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 19:21:31 +0000
Received: from DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::1fe5:3ce9:9a3a:7de7]) by DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::1fe5:3ce9:9a3a:7de7%4]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 19:21:31 +0000
Message-ID: <e7352525-02e5-1a41-7eb2-4d9e1151fa02@intel.com>
Date:   Wed, 11 Jan 2023 11:21:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH 1/7] x86/cpu: Enumerate LASS CPUID and CR4 bits
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-2-yian.chen@intel.com>
 <9d935618-8f84-2d6e-4f4c-9d38eec2ba67@intel.com>
From:   "Chen, Yian" <yian.chen@intel.com>
In-Reply-To: <9d935618-8f84-2d6e-4f4c-9d38eec2ba67@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0231.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::26) To DM4PR11MB5262.namprd11.prod.outlook.com
 (2603:10b6:5:389::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5262:EE_|CO6PR11MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: b51ee9a1-e8b6-491c-a10b-08daf4090bc6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XaPzEdpNnvMHUXE+GJH3rPe1XByJSMG1HIvG31Ys9FnUQMucp7+dtE93r2V+Wt86U8xde/Bf3w9aCkXZVWT7cD924/gMfc1+E1UqnQ/incCzavrA+GQaoc8t0eycSSqEtUHBpm5BSQQtnXlPjhz4t4UC2UYv184FhkuDHC3UcoDitSKRcBmKIvk1q1RmshdazHj0l4IAVjSwGODQi+8cmoBaD5AM1duaoOA8jQ2Xssq16Jgm7gHRdEL/OeLe+zssSIW7yBx+VLWwXfV+K6iJZ38bRt0hkuAAFbKjFgAB34a8DxT+cWnqJ2fPK6dIsX6QJpybQK6UuJsFKtQQhAb3P5hmqH2FnFRzFvUcve7pSHxAoeodyaK9pYPqL+ALlPMHaGdXLv8x07sesx9GbhaoT3gTCE/sbEjQRQ3BN6hiRvpgQ1Oe9CnSV4U5BiBGvIs4nedL+npYW+xiGS7c/FiXQtcZijf9BvodoCCn+06z7f5Tcg3mZ7lANonl3LtxLuqzQX5NBs1+Asku+Sz7yUBX5AWLtFdqekOdLpJFzOQmgqohoWF/XemKCpwRfxFTqyLupM+jrOGmM6+P3A0Isodwkw2teDPuR8jkQ+x5bhhsvfxMdThGB8ldu5xI/9w8H5kYwrH9PlQi3BK/vITwDmbLrtfHuE5cvwcldDorT9xGSlqlghLg9RxgU87q55CqeRGQO07GNQT5M6/T4Q3sv9YSIF96T7Dj238zs/0/eqC75M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5262.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199015)(8936002)(2906002)(5660300002)(41300700001)(66556008)(316002)(8676002)(66476007)(66946007)(110136005)(6636002)(26005)(6512007)(2616005)(38100700002)(31686004)(86362001)(186003)(31696002)(83380400001)(53546011)(36756003)(82960400001)(6506007)(6666004)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K01BWERDZSs1bUc1WSs2NDhRd1hCeGE4NUpXSzNNWEQyWnhRcytXbGRldS9U?=
 =?utf-8?B?dEk1YWxpMXcvQ0tqWS9aSTVnNzhXdW5sQy9kYkNEaFc2WmxBT3IydGhYdWQv?=
 =?utf-8?B?cTFGNFpWZGZvVG1uWGlrSWRBajQ1VUlHQURxZlVDSGhUeFlMOVZOTFJUbGZZ?=
 =?utf-8?B?andoWTBMWkJBU09LNWZnL0QraStBTXg4ckt0Q1dHbDhONkEzNGM3TTQ0ZXg0?=
 =?utf-8?B?eDhtbGZwNU9KSERKdFgzWXJyeEJWUFVwK1lUMmdheXBMSmRIWnhqSVQ4Ukgv?=
 =?utf-8?B?bG80WGFYbzY0WGJ5SG5WTVBmdG0xczZvSTQrY3UrN0pVcUYxSXM3VUhOSVJV?=
 =?utf-8?B?djVxZDdGRTZnUUt5SWt0am0yN2IxUTlHOVRBYmhQcnR6NjM0VWd1UkM4bUEw?=
 =?utf-8?B?YzNJY0hqM2lyak9RczAzcEF4cVc5ZmtINGw4b0pQTHpxNi8zLytiTEQ5cHZT?=
 =?utf-8?B?ak16ZXFqanFiUE5UZUwzeGhUNVRzb0ZOekt5UEJVUWhtN2pSeGhhMTMwUEJs?=
 =?utf-8?B?TTFpdDllb1hKNC8vUVVvcjlXQWdWdUhTVFYxVmdQU1hXYjJLM09mN2loL00v?=
 =?utf-8?B?dkpuMnhxTWZ2aVVobys0TXJaNzVyQVVYcHpEVW9yMVBEdjdJNDc3dEE3Mldr?=
 =?utf-8?B?ZTlUM1hkSkEzckV3d2pubGs1d21kNVdibW9Wemt0RmFzaUtXZVBNQ3Zpd0RD?=
 =?utf-8?B?WmNhN0ZYQUt1ak1VTnBhZGpEUGk0L01oQnNmV2J1SmpCN0JOU3FJL3Y2L0ZB?=
 =?utf-8?B?K0o0NUVvTkdWdVdoNHQ0RXMwNFhWQnlxODVucUFRc0FueEJPa3lGZElHUDdE?=
 =?utf-8?B?Y0VZZmMyVlRHRkxOdzNheTFoSVppTTZzenZqSnB6NURSTmhQdmdhUzB2V29V?=
 =?utf-8?B?cUVPb3IybkI4WG5maGQ1R3A4S0txM1pBT0I3RmxDamNOUlpZelp2UTVjTWZy?=
 =?utf-8?B?b0ViSkh1elJ0S0EzQkVkSm8vdW1uTDZJN25taHFobDVEWGdSa1JMcXE2b2pB?=
 =?utf-8?B?QkJoTVJUYUhVTnBWbnNCRE8zdUdaa0ovUkg5RDg3MGZHM1Vxa2tmYndiM0dj?=
 =?utf-8?B?ZENyQWtpY2UyTloycHlUbTJoNlJDbXBRVUM2bU5VMGZjSitwd3ZGZTlhNUFr?=
 =?utf-8?B?Zjdsa2RvUEdJNDZXOW9PeHMrVWk3Q0xoMHVGUlc2SmRBWTNISm9Md0E4c2Vx?=
 =?utf-8?B?SUkveFc0MFFZVmZ6enY0Rm5iS1FITjdtVldqVTdIb3ZsZkdNTW1mOExVTDI1?=
 =?utf-8?B?UW9CcVdNZVBZREp5NVRYZmNWeWw5eGpSaWlLcnVWcWNscW5DQW5ZK0d5TGhO?=
 =?utf-8?B?eGlHSmZ6QWQ0ZGZ3b3I5ZUFHRzh6MU5iUGJxckMxa2owN2hUc3Jid25qR1Fy?=
 =?utf-8?B?STI5RzV1WW4xMGdIaSswYVRtV3F6Z3RqUThWTkZzY0oyeTVSaGxySytIeGc2?=
 =?utf-8?B?V3ZXK25zWGVOU1B6Z3J3UWFPSEZvcW9Kd1lqOEwwMVkvMzFmR0x4NnBINDJD?=
 =?utf-8?B?WlRWR3RGcTl6YU5HTTFJenVvQ202ZFpmWnRNSkFicytXTGY1SnRoU0oyRTFV?=
 =?utf-8?B?WmZlK1NRQ3dsZzh0L0NCVkpBSWc5dmppa0F6SDJZQzVwd2E2Z01iSG1seTVh?=
 =?utf-8?B?L3lYNmZ2b3E5UGJ4QWpockIxaVBudzNNaU1mTytTQi90YThiOXVha1dFdUdN?=
 =?utf-8?B?b01INVhwOXNsQUdpOWl3blNPTHYrSjhwemFHcHFtK1F3WUtrdjh4QzArWFRT?=
 =?utf-8?B?bC9MVkwyNHN1NStmSzk2a1FRblR2b1hhUlVBbHhsTjI5b1RpQTFSOFE2Um1S?=
 =?utf-8?B?U2huUFRRTWtKNk1hMXZhL3hjQzJPQ0JuNWJOZ1d2RkljYnJNWC8vL21jZzVj?=
 =?utf-8?B?THYxalgvL2hZNnNEZ0g5RjN6WnI3c2RjQTFmYzB4RWlxUGNVOHpiL2VmNG9Q?=
 =?utf-8?B?MVY5T1FSb0FPT1dWeWNOY0dGNUVCLzVZRy9uWHBxRDJWZlFxZXpJZVovTWNl?=
 =?utf-8?B?dGRUTTNPMFpOdDhjcHdIT2p5S25pWTZIbFJ4QkE0UXA3TnpnMU9TandxL05U?=
 =?utf-8?B?NU44Z0xXL0pHaGs2U2w5Y2FoSW9KZGNHeVZWaFRWb2NtT1RnLzNkajNJUVZC?=
 =?utf-8?Q?rfMVdLLNPtR3e0vpBqqaaKzcy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b51ee9a1-e8b6-491c-a10b-08daf4090bc6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5262.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 19:21:31.7685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vy80TSi6j7JeNBH8PT1GKac8TRXJ9UQ/BAyPjkxR5e9qeiWfJvgtrcZK3smYIVh34G/euQRjkhqFaCzyBXInEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5617
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



On 1/10/2023 12:14 PM, Sohil Mehta wrote:
> On 1/9/2023 9:51 PM, Yian Chen wrote:
>> LASS (Linear Address Space Separation) is a CPU feature to
>> prevent speculative address access in user/kernel mode.
>>
> 
> Would it be better to say?
> 
> LASS (Linear Address Space Separation) is a security feature that 
> intends to prevent unintentional speculative address access across 
> user/kernel mode.
> 
>
Sure, I will revise the statement precisely.

>> LASS partitions 64-bit virtual address space into two
>> halves, lower address (LA[63]=0) and upper address
>> (LA[63]=1). It stops any data access or code execution
>>      1. from upper half address space to any lower half address
>>      2, from lower half address space to any upper half address
>> and generates #GP fault for a violation.
>>
> 
> I am not sure if this is the best way to say it. The kernel already 
> partitions the address space this way. LASS takes what is already the 
> typical OS implementation and bakes it into the hardware architecture.
> 
Yes, LASS by design matches the addressing usage in OS. I will try to 
include this in the statement.
>> In Linux, this means LASS does not allow both kernel code
>> to access any user space address and user code to access
>> any kernel space address.
>>
> 
> There is clearly an overlap between the protections provided by paging 
> and with SMAP and SMEP. It would be useful to paraphrase some of the 
> information mentioned in the spec regarding how LASS differs from them.
> 
Yes, I will differentiate between LASS and SMAP more clearly.

> "With these mode-based protections, paging can prevent malicious 
> software from directly reading or writing memory inappropriately. To 
> enforce these protections, the processor must traverse the hierarchy of 
> paging structures in memory. Unprivileged software can use timing 
> information resulting from this traversal to determine details about the 
> paging structures, and these details may be used to determine the layout 
> of supervisor memory.
> 
> Linear-address space separation (LASS) is an independent mechanism that 
> enforces the same mode-based protections as paging but without 
> traversing the paging structures. Because the protections enforced by 
> LASS are applied before paging, “probes” by malicious software will 
> provide no paging-based timing information."
> 
Yes, I will also state the advantage of LASS.

>> Signed-off-by: Yian Chen <yian.chen@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
> 

Thanks,
Yian
