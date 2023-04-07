Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86276DB2BB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjDGSWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDGSWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:22:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A2C1BF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680891765; x=1712427765;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jaw+iAYYDMcrC2j0gIo6vkQwwXOu727b8xhLzWWK6t4=;
  b=CIXC8YBh/LOFvCPIk41b/6cDCP0ymD4sn0vMwPuQzv7lbV6uG2jo4geD
   CtAVQBy9Ngq2kVeFysYLD7NZ7/g0YnRE520iNaSVNRzea+sjZRCVKRcpJ
   rO6AWsx/LRp5DzdPzdd1owxUvg/X1JrjelrmUb0pUkPWHu6mW+m1OOboE
   ZX+jmxYTpVBdp7B0Xd+HuJQeXgrbhUMMg74gIT0c2nP2/chNNZ7p7ylxO
   HRFqTojXhCkXbovapUScZ+RXWbLHIyIUz4o1o6Yj+y1nfOA5Xry5C6n97
   Z51xhrw3uju8dBMDg8SlVQ1Zlnupz8jsyhcARb7xrkGtvvX2o2Ft2LmyL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="405864841"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="405864841"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 11:22:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="690137323"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="690137323"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 07 Apr 2023 11:22:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 7 Apr 2023 11:22:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 7 Apr 2023 11:22:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 7 Apr 2023 11:22:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 7 Apr 2023 11:22:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Me7AcR2JaVkyjZqq7OwsrsVcG4K0/rUB4P50/Xa5USoJaaBazFKVsM2jQRwuECqtxxKTF32zk5pXkHqlnoajd5rp8aH/0+np1+N+wwRZSKB3Nklf0LvAEXkVY911dtLPLMPhwQYbOQ5pMOOALm0cu2FbXPpMkZ8T4HirF3IcaMaVn+Gl+45m6/cGPfs0P5LXquL3l/zl3Ou89XPZgqfLhvSf16Pjn0HL9JKdN/WN/GbgmmsJZg3bAtUAnonLf++Rz/iwZwmYdbbAWDOaS92et/KCpyKAQJ2oiQvjxhmevVBieiqyVZi7k6xAu+X6QBidWwo4lvf23PlbbK542mQwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xifWifP80cvTL/zIydGuPQzPbE1RJR/L7hTToKJpTwQ=;
 b=kEJw89v06U8pUPpDjoFzMaa36WXCjU09m02pa7K7Qrvn5ayinVbX3q9dpsnDVCds2Q76+2yu7sa+TJKK+qexc4wUZAfsu1XYK9Nenpr5bGs/yuOW7iJgXCjGMBbyQRK1yvqHp6jfC/JVrYtuh1DXFh49l8q+QFFl9T/eIMV/PQsx+NwGOeWuNn68KeEpvxD14eiHd9oLF9PuZXBEsOT4VaUebhB0b5vPtwjcv1j+PZqdPjcUXjAFo9zIQcKqdlX3OmrzaEkDpXFuNLTNZEBSmUwguxVNnCfOWTRsHDQfoUjXM6RS0DOKIktsnCakucM8i5uxqCLVHMSLyjR5bAMRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by DS7PR11MB6126.namprd11.prod.outlook.com (2603:10b6:8:9e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.31; Fri, 7 Apr 2023 18:22:40 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::e002:4146:dfae:ba77]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::e002:4146:dfae:ba77%3]) with mapi id 15.20.6277.034; Fri, 7 Apr 2023
 18:22:40 +0000
Message-ID: <113918f9-0e44-3d46-8b48-028277ec26bb@intel.com>
Date:   Fri, 7 Apr 2023 11:22:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH] x86/fpu/xstate: Add more diagnostic information on
 inconsistent xstate sizes
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Chintan M Patel <chintan.m.patel@intel.com>,
        Thiago Macieira <thiago.macieira@intel.com>
References: <20230405183942.734019-1-fenghua.yu@intel.com>
Content-Language: en-US
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20230405183942.734019-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0080.namprd05.prod.outlook.com
 (2603:10b6:a03:332::25) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|DS7PR11MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 062fe9eb-7e8b-482d-509c-08db37951244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c2RKoChetFMqK0D4JWiPwg0qbKkDSPvpeSejWDSPYgclnb82ZFPAe0N/Yix1eTsPg2zECnt34/lpsFvLaETlmhkJkmuXPPLuXzoAJm96Yl0taIN9YRDzo+Kt3QrdannESLXKLoRw9H4NZVKb+UDTFSsvSSaHr3W/FCv+ikANOKhoG15x8Kqb2okp9eheWqqEb8RZ7fEOI1bvtErMwEHs7Juekfvy4na3hQJQj/yAmeA7xg/ycqi1kxwgFJvbW2z3J3m4chbUPm300UOaOzbCObn3uNFpS78YC3Z9cXIXylRnuZCp5Jngj5WwIFjnu7sDrwo6kqqHyvwvTQn6JT8GjhkLdc6+W/9bzcS3gkW5d9SHBwR1YpEch2gPe9iTlRmpLizZodbfIdLFfbKfe/9hk6IIy9Xxog4atyOI3dfATrYkOdybIDlvXO1Q7a1eHWsW0WURT5cJ3NIozD3iLQZWza8TyR5Z3rNWQ+flnLwQDMnWh+6G5/dK/pgk/fgUPU8jfOtX9QlYjYgsh4LXySxuXD30ICUNbQOhGntVYrQJIs26uGx2qtWSlTKRCtO99mzWMHt1xZZ0SkXicSUPfm6NSq6ll/GrWCmQLTsPapFRtDm+ers0uYKqE2enNIwDJJL4PvX9txwrDLd9M5rvKw4uOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(8936002)(66476007)(8676002)(66556008)(316002)(110136005)(54906003)(4326008)(66946007)(82960400001)(41300700001)(38100700002)(5660300002)(186003)(83380400001)(53546011)(2616005)(6666004)(6486002)(6512007)(478600001)(26005)(6506007)(36756003)(2906002)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDhPSVhPWkxZcEpYbWYwRFVxT3pMNTJ5UWg3VUF5VGZNSXIzS2VuVzl3VVFy?=
 =?utf-8?B?d0tCV2RFN05RTEVzK1NHZ1NBemZ4MlFscWVOd1pYN2NVV2MxVVJUQkJUazF3?=
 =?utf-8?B?UmpjYzZqaHJVQUNSVWpSMXM1ak1VRGxacytMNUMyWTROWWtaRWl6VmJKT1Bq?=
 =?utf-8?B?V2ZaMlkyZ2JoMXZzWnlKZFBKakI4OE9GOFhoV1NpaUdNYXRiSHlCVGFEeTFz?=
 =?utf-8?B?bEI5TENQTVA3UjNBYVBYbERMZHl6L3ZNWnYxL1RFNWJXWVE2WGtvTmFyaHQx?=
 =?utf-8?B?UWFnaW5GekNLSmhFZmxMbWtkWWh2NzZ6dEpzc1ZPM09zRUwxa3hXdzUyc003?=
 =?utf-8?B?VTZ2VGw5SWl2V3lydUJKWWc0NnliS3ZRY1YzSjlqV1JyVkZhQTNUNVJXaXA1?=
 =?utf-8?B?M0JyWFJ2eVNORTF5bjB5YmpJRHFpaHA1TmJqeWhJd2ZEZE11M1hUR3JRYStD?=
 =?utf-8?B?V3FzYUhZOVdRMlJYYXY5dG9GOFhzL1lyYnhtYUtLT0pMazRLUktmVkpKdHcz?=
 =?utf-8?B?K2pKcTRqcDl2Z3pJbmdhUkp3aW5lWkQweGNJOEFpN3Nadll5ZDNTNjdkMmhv?=
 =?utf-8?B?ajJFSzRZU0s2MG4xamRKenVDa05nU3NWUzU5bld1UkhqcU1rcWV2SGgrQzNL?=
 =?utf-8?B?Ykxmdko1K0Ura3hIZHhCeDhqODZBaUk3cU1sYXpiMVNZUU92N1RNb0MyRklM?=
 =?utf-8?B?TEQyVjlHT0hrRTdmSkJOZS9xV09qVmNPSUl0cWpFN1BPbnI1ek5tK3Nrd2hn?=
 =?utf-8?B?QTlVeGFxTzJaV2IydkJDeks3cStFY0FYektRQVg3MEh1bytEeTdlcFVTempC?=
 =?utf-8?B?eU0rVkFIWHNPOFBUMkcvWDA0MDNTODYxZXhFTC8rQmZmdG4rYVhJRWxRL2ov?=
 =?utf-8?B?djc2cmxpK1ZZeHFCZTVFTkJoTmhzN3ZDNjdzNlRoSDBVRGMvWUpNYlZBVDNy?=
 =?utf-8?B?d0Fyb2xxZlh0NnAxck52TkpCUDF1U0ZuczlYVEN6RzY0TEo3RXd6ZzZURFpQ?=
 =?utf-8?B?eHBleHpuNDJLakhPdENLdHJLTG5kekc4aERIUXJQb0JrWEFDOFFWWmN0ZUhN?=
 =?utf-8?B?bjhJNzhNTUVXL1o4MHZHTDZIdmV5NWZDKzg3a0xvVUdUQVdCTGswcGx5SzEw?=
 =?utf-8?B?cmZUdzhnbGhpYkVmUmFmWmErVUFiVlJSYm52YjVyTlpzZ1U4WHRxKzRQRGsw?=
 =?utf-8?B?bFVKZ1NETjlkMzR3ajdNemVhK0NRVVFxM3F4Si9TWlJSakpQakxzM1lOaDRj?=
 =?utf-8?B?dU1hU216OFJ5MVV5elRkTVFKaWJEZ2xNaC8ySzdCNXJWZEI0cjIzMzVZcyty?=
 =?utf-8?B?NFlSaFJTME9rWTVOaUtRc2VVSElhOWhQR0l2MjF5NVlmMzJjRUJwRWVFaVAx?=
 =?utf-8?B?RG5GYWZTdG9wU21rUDV3SkdreVQrNTJyWXN1M3VDZGg2THhVc29qa3JmdHJv?=
 =?utf-8?B?dU04dGlHODZmUWxSRS9MMDdUVUp3cnVIdXc3RzVpZ2ljREs1K3djTU1UaUEz?=
 =?utf-8?B?NG1MUTFQYVVDUURKN3lKQitHcFBzcVZMS1RtQ0hBOTEzRFgxVCtLY2tEUld2?=
 =?utf-8?B?dnZjUDcrVzBJUzNudzlUOCszdi9aQzNsVU1xZzR6V2xlazNzdWhaTXVCVGRJ?=
 =?utf-8?B?aXJHcVJDN3RzeGtERVpCLzBaRDQxK1lQS1ZMN3pvay9BUEluZU5nZVA3Ykhs?=
 =?utf-8?B?K2pOekIrUVlRaUhSY3oveHc3bEJRc1ZHQ2dTK3N3WDZTZ1JESVZseGpnKzJs?=
 =?utf-8?B?bDE2NDFvSHY3UHpjcHcrMEQ0RUx6ZkdMQzdybk5Bb0VFOVA3RklZTjd6ZHJn?=
 =?utf-8?B?VUVMZzZ3czNWNS9ZUFBaZFRqaHJxd0Y1amd0cE1nblRSNE15bFhaRzdhZG9I?=
 =?utf-8?B?UHl4WXU4Q1lXdUVOeFU3eWp1VGtDUEdXbUNBdkNDdG5vS3VQSlBkbEJjTWcr?=
 =?utf-8?B?cFo1MEp0QUlhVmtNbU5KUG5tL2k0SWVEK0VpeDhQNEZqLzh2Ynk5Z01CVnJ5?=
 =?utf-8?B?WTNXR3VObUZ1dVl5M3hXMDZsMi85WG9HWFk2VUlWZGwzd2diQkN0dWFzazA3?=
 =?utf-8?B?MHFaMDBmRjRuZnpuTTU1U0RrMkJOTjh3Zm5lbVJHYjc1VTMrZkhxdU5TaXRR?=
 =?utf-8?B?WXV0UDg4WE9jSDJFZE9BQmhLVldjWHhCM2IyT2hmNHRqbFdpRkYrSWxkeExP?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 062fe9eb-7e8b-482d-509c-08db37951244
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 18:22:40.1469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gYUBLw46ptiKoROZuuaPmJeqmiEKDrCWLrk8ktXQW4y3kl2a060SR7jz35hVI0vzZdu5N9caNkcWZ3Dmq87IU1LxZogiyPTbV4/ofOztHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6126
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/2023 11:39 AM, Fenghua Yu wrote:
> A warning is emitted when xstate sizes are found inconsistent.
> But the warning message doesn't show enough information to diagnose
> the issue.
> 
> Provide more detailed xstate size information to help debug the issue.
> As a hypothetical example, on a platform that may report incorrect
> xstate size in CPUID.0xd.1:EBX, the diagnostic information after
> the warning will show:
> [    0.000000] x86/fpu: max_features=0x407
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: xstate_offset[10]: 832, xstate_sizes[10]:    8
> [    0.000000] x86/fpu: total size: 840 bytes
> [    0.000000] x86/fpu: XCR0=0x7, IA32_XSS=0x400
> [    0.000000] x86/fpu: kernel_size from CPUID.0xd.0x1:EBX: 576 bytes
> 
> XCR0 | IA32_XSS is 0x407 which is consistent with max_features.
> CPUID.0xd.0x1:EBX should report the size of the xsave area
> containing xstate components corresponding to bits set in
> XCR0 | IA32_XSS. But it only reports 576 bytes of xsave area which
> doesn't count xstate sizes for AVX (offset 2 and 256 bytes) and
> PASID (offset 10 and 8 bytes). This confirms that the platform
> reports xstate size incorrectly through the CPUID bits.
> 
> Suggest-by: Dave Hansen <dave.hansen@linux.intel.com>
> Tested-by: Chintan M Patel <chintan.m.patel@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>   arch/x86/kernel/fpu/xstate.c | 33 +++++++++++++++++++++++++++++++--
>   1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 0bab497c9436..5f27fcdc6c90 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -602,8 +602,37 @@ static bool __init paranoid_xstate_size_valid(unsigned int kernel_size)
>   		}
>   	}
>   	size = xstate_calculate_size(fpu_kernel_cfg.max_features, compacted);
> -	XSTATE_WARN_ON(size != kernel_size,
> -		       "size %u != kernel_size %u\n", size, kernel_size);
> +	if (size != kernel_size) {
> +		u64 xcr0, ia32_xss;
> +
> +		XSTATE_WARN_ON(1, "size %u != kernel_size %u\n",
> +			       size, kernel_size);
> +
> +		/* Show more information to help diagnose the size issue. */
> +		pr_info("x86/fpu: max_features=0x%llx\n",
> +			fpu_kernel_cfg.max_features);
> +		print_xstate_offset_size();
> +		pr_info("x86/fpu: total size: %u bytes\n", size);
> +		xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
> +		if (compacted) {
> +			rdmsrl(MSR_IA32_XSS, ia32_xss);

This shouldn't be directly read here because of the LBR state component.

See the function comment:

  * Independent XSAVE features allocate their own buffers and are not
  * covered by these checks. Only the size of the buffer for task->fpu
  * is checked here.

But, isn't that max_features bitmask pretty much about it?

> +			pr_info("x86/fpu: XCR0=0x%llx, IA32_XSS=0x%llx\n",
> +				xcr0, ia32_xss);
> +		} else {
> +			pr_info("x86/fpu: XCR0=0x%llx\n", xcr0);
> +		}
> +		/*
> +		 * In compact case, CPUID.0xd.0x1:EBX reports the size of
> +		 * the XSAVE size containing all the state components
> +		 * corresponding to bits set in XCR0 | IA32_XSS.
> +		 *
> +		 * Otherwise, CPUID.0xd.0x0:EBX reports the size of an XSAVE
> +		 * area containing all the *user* state components
> +		 * corresponding to bits set in XCR0.
> +		 */
> +		pr_info("x86/fpu: kernel_size from CPUID.0xd.0x%x:EBX: %u bytes\n",
> +			compacted ? 1 : 0, kernel_size);

Include Thiago who asked this.

Thanks,
Chang

