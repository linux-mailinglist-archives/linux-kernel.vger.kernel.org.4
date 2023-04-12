Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D956DE8C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjDLBVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 21:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDLBVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:21:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B07799
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 18:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681262470; x=1712798470;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yG3oqONuzkVfuR/TmvW6MkloClkN2OkmjJ2JNhRSlV8=;
  b=Ovhukc+PRX8NworKNOZXj8Bi+gWnUWzGUBOXlVOc68OrZNU0UOqa24HW
   +3joohernlT3FWHI3Lux9nR/Vez4QQ4mGIHAbroXdD+zJK2dsSCNzqDre
   eUdxB9AQtGBpCRKBfz7+qrF/rjOoRgObO13Re2YtdVpTMPUh9p1btEj6F
   L7MmNLPvX1qGu+lkOPfgpzMxBJKP+hmI/YnjG16dCR7D4r4p6+/A64+NW
   5dDyMRvvWv6lbmjUaWTchAhkZJmlTVoVl2JFJ+mRaW+Ak75CNthakaLZP
   ciRQEcVfbi73qK6owJOtcYB4wW66jqTkPsbPGvGDWp2z1jhAWezbc4rGf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="343778072"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="343778072"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 18:21:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="753335444"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="753335444"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 11 Apr 2023 18:21:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 18:21:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 18:21:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 18:21:09 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 11 Apr 2023 18:21:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwAPi5o4z3WkW8+mwb7YBn5hatIbq4OeAtDtRRxEjqIkvz7vmto/kFdhiglVjsiZ+BL4eijz2tQ5gK7nPm208FXrz6MGj3eHbwGk4Hl19RKuaG8kwPRXNeS2bPGBHeBWhKwWRlV/vAP/ORfNYbiX3GnLrDk3J+U+YYQOcM+w/2i+lclPAtIy+pYc0+jkvWx370Vb0oLlUpEQaaw2IU7t7jqweDHeJOh8y5SAEx/XfLhKHrGHzi5Jnry45yWrPRbAwY+GVHlYjI2hqHVOG9op2jcecQp699WpNT3xINd8seB/M8bCMVWZVbfCHtnqEeEUGjjR133D1EhsOwnqdlpkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pA3Du3W3YAAvZv5paUfzl6DRRuUNS6Rq0oJf1h/Uezk=;
 b=YThX/5yVXLkSczHgAQfqdwgZyqcz9NGimUkX1Ldx9Q7dYiAWiNMkhAwrMmtYDq2U/L4BvhJync14SpmJoX+h1mzGK5FDS6uCc6LyCYcWDUCGsCM0o7ITs4AilA2gkp+ruRr52TIORCoqIf8zoUyOmVH9p6CU0ldXwaZAXrbb+yzl1cQeA8kDvB5OH0E0TXT5wcg+NKhYIMBhvwkxJi8oZUpsX54mHRdVodvjSqMZEZzBjBrswte/R+gCdF19QrIZzPPa/9GK0SF/bwGhLu9oF1t9JIocOG27YHLy7YqZvgi5gluKb+3/obHe0HAiTdnVVk9Eda/APzwJ/2+hN0WDig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by MW4PR11MB6785.namprd11.prod.outlook.com (2603:10b6:303:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 01:21:07 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37%3]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 01:21:06 +0000
Message-ID: <50e67263-33ba-9921-1bc2-a37b99bc2459@intel.com>
Date:   Tue, 11 Apr 2023 18:21:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [RFC PATCH] x86/fpu/xstate: Add more diagnostic information on
 inconsistent xstate sizes
Content-Language: en-US
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Chintan M Patel <chintan.m.patel@intel.com>,
        Thiago Macieira <thiago.macieira@intel.com>
References: <20230405183942.734019-1-fenghua.yu@intel.com>
 <113918f9-0e44-3d46-8b48-028277ec26bb@intel.com>
 <c716e021-99ad-2cb7-44c0-ec8393a3440d@intel.com>
 <2af114b9-2737-70e5-f534-e60416b52246@intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <2af114b9-2737-70e5-f534-e60416b52246@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0032.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::45) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|MW4PR11MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c112c0-ea2c-45f1-a73a-08db3af43066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BBqazHt9/Y1G9NYvmf4v2wQbwQ6kHkgZyLNySFwYW0/Jp8lXFrjKg8dg8au9ZvBHyhVF6sl7c5m8rme8Yf71hAgWxve0/3Ylpo+M07wnwKAdbwF76xIvlqfZ9cgXRG8gacZmOe+kUXPpta5zCaY7DTPylTqXlDuiJQBPs39DwcWh6UGEO5qz5tjrNnKKhem8JW8gXrtRsGp045FuA9WKum86HfdSMRQYnF46LgZ6EuOxqiTnm+fOLfWoAVQM2PgDgpfTxhLzo2VTWAE6Lh9Q3HfH7gd67P8b0rxHT84ObLWYw69wf3T27Z5RfOxzc1eyXUEAycYBlxoQgrQ24q5llFGZvxWKdo7I//I2aYg40oIM7Wo6ZEUk4lPuB62LTIbeZ8ll0sPEnRetWXCyF8t0J5Uu51YECq3MVAbfXWsJHoN5tXxHG5NLGnqXgab878ORvZpiqEACIWzhKwH09tQ9iuQRK4KSGP+eTXMW0Ye9N/HHXxURJs34S11Shn93HnCyg2O9Bxh2jnABvlmimyFjdQZdfEkVel5O0L7SxuTS2q/uMdoCVDoucVbXdcmVGvp/AWa9ActaoCdMZpK1HXEiN09s7Ijexv4rbyAGLPEHl4iCzVhcMWKt5ocRkdiHUmrrkMLGJEmOdRpLAk2F4ZmxSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(8936002)(6666004)(44832011)(6486002)(5660300002)(31696002)(86362001)(66946007)(8676002)(4326008)(66556008)(66476007)(478600001)(316002)(110136005)(31686004)(82960400001)(54906003)(38100700002)(53546011)(26005)(2906002)(6506007)(6512007)(2616005)(186003)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEthK2EwMnVuNUtGY3pFa3NrU3ZvcUlRT1I5TDNKQWNJeW81ZE5kNVA4eTFv?=
 =?utf-8?B?VGROejN4Q0kvdm9jVVBjV3Z0a2I5VmNJWEF6NjVKYzZBZ2ZnbTl5OWtUWWx2?=
 =?utf-8?B?ZjhGcDd6dmVXSXFRdnZyL1U1SVB2aHlXOUwrYzhPRWczZzVmYXRoL1hJb3VM?=
 =?utf-8?B?WVg3K1UxNDhsSzZzQ0NLWmh6T3VCWmpKOVk0ZDZ4R2RuWERBc3VaK2NtVlRV?=
 =?utf-8?B?VWRKNCtDRWhTN00zTWEzb3pqeGI3WU1JYVluMUlWb3ZzR0lMdXVPKzBIdXMv?=
 =?utf-8?B?U1FieTR6a3YraWRYT2hkTzIwQVVybUZqZ2FiM2Vja2tGRWJkTTl4ZW5jVlY1?=
 =?utf-8?B?SExmeFM0ZnJQRkVPK1VGc2ZBYXZzVXZKb0N1bHlocDZZTnB0Zmk1eGVvZ3BW?=
 =?utf-8?B?ZGV0YW9mVWFJRzRjNEpkejNxZmF0OEl1Y0VaMGx6bTZ4eVV2YWFMSWhmbTA5?=
 =?utf-8?B?SWdvWUNTT1ZhSVhjaUpzVUxlVThwOXpkeGlTbzdHTk1SZWlBVXpFR2JOc3ZD?=
 =?utf-8?B?NiswQjRGSCt3RnRMcGRXT21GU1lqa0VzL1hobjRsZmFUZG9wd1JOQ1dPT2E3?=
 =?utf-8?B?ckxQMnZkdlRQUmc5cGVPMW1hOHJ6OVpsK2E1NWNOQXdKUVUrcENkL0p6dHQ5?=
 =?utf-8?B?NUt4UVZNYXNGaWN6Wk5BWVFNYkY2RllBWEZNNExpN2c5M3NXZDJ0ejZnSjho?=
 =?utf-8?B?L3V5WU5qWXVabEYrS1FidFIyb1BxWHBZQWdPZ3FwZGNiSUZlV0tPcG5laXJQ?=
 =?utf-8?B?emtJQ1J1aTQ4a2NuTEx6eGdkakxLdU50V3JVR2UzK1lLbzFOQzFtS251bDJP?=
 =?utf-8?B?ZXVtYUxCT2RkeXhPWmhDZ1hBUVNwRE9ZclZuN05wMTc0Mm1GY0hqQjZ4c3lP?=
 =?utf-8?B?UXVSb1JJUGl2eGpwR1pXeWs0Nk9CWDhxMTc2U2l4ZXdQano5MFp3L0RzajRF?=
 =?utf-8?B?N0laVGZUWHFRTzNkYWNiRmxvLzBhc253eFNGZzljNjkzVklzcHlhU2tPcHVY?=
 =?utf-8?B?NHN5YnU1RGxaSGwxQlBMUWtIYmxCTGZDUzRocGRUV0NxSEl3UmlTT3RiTnZT?=
 =?utf-8?B?M2RJSzA4MGM4RzExWnJ0SFVBaGIyZDRraUdKUGVzWE9RRW9qdmxMOWdybnZj?=
 =?utf-8?B?ZHdkRzdEYTBJaVJSemgxYkxJNFhqbHQ4M0prb0hESnB3M0JXcHdzMlhqb1Bh?=
 =?utf-8?B?bDR4d1hkUm5EVjJ4VkVOWUduY2U0T1haRUZmeUIxbTlZKzFFZTdveXF3a09Q?=
 =?utf-8?B?SFlhSTJKdWZReklWcVBHZVlXWnJDN0RrUjdnb0FEVjdqV3FZVFdpbmRrR3NP?=
 =?utf-8?B?VkNVdVBuWHVaR2V5YTA2bzZWdGd2anpQUm92V2V3MjRxdlFoT3RkQ09yNGtm?=
 =?utf-8?B?cEtKdTRMSkYrbTJZMzR1LzBXSUNBcGZBd3BKdnFpZnFwM1dmaXlFczcraU9T?=
 =?utf-8?B?T2c4d21hUlhYOUR2TnhZSm5uVTc3bHVwbXVmMG1ub3ZXemd4VEJIdy9kOURT?=
 =?utf-8?B?bU1lMS93ZkhlMHp4UnZ0c0xNSjRXM2htVWxraFpMb1BRWEhrMGdCTFJPaE1K?=
 =?utf-8?B?MCtIb1N0WTVESG80ZzFmTTFyVW4rbzJkRm4rREdDZXNTM3IzbHVWU29sQWVo?=
 =?utf-8?B?RkhJYVVSbWpTTmFFbVlPNW41R1R6KzFXVmQ5WXVlM1lUbWhaS0ZMUlF0aG5u?=
 =?utf-8?B?YmM4SG5TeWgvcEk5VUl5Y2wwUFd2ZXh1dEVIdGl5UVNCTEplcTg2aXFRZWVY?=
 =?utf-8?B?YVdjK3IrNE9mTU1QdW82WmVPblRDM0JvTGJ2SitXUzBVdU02UllUY1hTZkZO?=
 =?utf-8?B?clNjdWlRR04wWElhODRYWFRCNWlsYzcveUxvb0VOdFVBVmk1dDBlYU1MckN1?=
 =?utf-8?B?d0xxUGVueU4xTHpzYzQyQ3ZCdEFuWis0SzFWYWZON2NPMTVXM0VFS0ZWRkRz?=
 =?utf-8?B?M1J3cXRYTThBSFc5YUdqQkxNMG1RSWxpMWIzVmhBQnBYelo5cUlBblVjQmJj?=
 =?utf-8?B?Tm1KblRENEdKdmM0SHZxWC9Qb3l2MXNWZ0VneHQ2Yk1wbXliYzJUa1VZdmtk?=
 =?utf-8?B?V3lCU2xuSnEva3RkY3Y2Qi81K210T2Z5OERrYzhxcTlWbDRqVzFTcWhiUHdw?=
 =?utf-8?Q?zZkV5BfdBT69XhajIHtL9NHe8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c112c0-ea2c-45f1-a73a-08db3af43066
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 01:21:06.3966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kn4AjMli41mSFtv+x8mIQaF4HVJ2UHkhHt+ebmmIdCSIkv+FP18jYJMpRnWc7lqrJE7RTEddGhW4bA/TQuTxEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6785
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chang,

On 4/11/23 09:29, Chang S. Bae wrote:
> On 4/10/2023 1:43 PM, Fenghua Yu wrote:
>> On 4/7/23 11:22, Chang S. Bae wrote:
>>> On 4/5/2023 11:39 AM, Fenghua Yu wrote:
>>>>
>>>> diff --git a/arch/x86/kernel/fpu/xstate.c 
>>>> b/arch/x86/kernel/fpu/xstate.c
>>>> index 0bab497c9436..5f27fcdc6c90 100644
>>>> --- a/arch/x86/kernel/fpu/xstate.c
>>>> +++ b/arch/x86/kernel/fpu/xstate.c
>>>> @@ -602,8 +602,37 @@ static bool __init 
>>>> paranoid_xstate_size_valid(unsigned int kernel_size)
>>>>           }
>>>>       }
>>>>       size = xstate_calculate_size(fpu_kernel_cfg.max_features, 
>>>> compacted);
>>>> -    XSTATE_WARN_ON(size != kernel_size,
>>>> -               "size %u != kernel_size %u\n", size, kernel_size);
>>>> +    if (size != kernel_size) {
>>>> +        u64 xcr0, ia32_xss;
>>>> +
>>>> +        XSTATE_WARN_ON(1, "size %u != kernel_size %u\n",
>>>> +                   size, kernel_size);
>>>> +
>>>> +        /* Show more information to help diagnose the size issue. */
>>>> +        pr_info("x86/fpu: max_features=0x%llx\n",
>>>> +            fpu_kernel_cfg.max_features);
>>>> +        print_xstate_offset_size();
>>>> +        pr_info("x86/fpu: total size: %u bytes\n", size);
>>>> +        xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
>>>> +        if (compacted) {
>>>> +            rdmsrl(MSR_IA32_XSS, ia32_xss);
>>>
>>> This shouldn't be directly read here because of the LBR state component.
>>>
>>> See the function comment:
>>>
>>>   * Independent XSAVE features allocate their own buffers and are not
>>>   * covered by these checks. Only the size of the buffer for task->fpu
>>>   * is checked here.
>>>
>>> But, isn't that max_features bitmask pretty much about it?
>>
>> How about getting IA32_XSS from xfeatures_mask_supervisor()? That's 
>> how to get kernel_size by setting IA32_XSS without independent 
>> features in get_xsave_compacted_size()
> I think what it tests here is comparing the sizes between the kernel 
> code and microcode calculations on the same input, which is the 
> max_features bitmask.
> 
> We know that the kernel code calculates the size based on it and also 
> takes it to write down there -- XCR0 and IA32_XSS. Then, showing that 
> bitmask looks to be enough I thought, no?

First of all, max_features is shown already.

Kernel_size from CPUID.0xd.0x1:EBX takes XCR0 | IA32_XSS as input. 
Platform may take wrong XCR0 or IA32_XSS and get wrong kernel_size. The 
purpose of this patch is to provide more debug info to help debug 
platform/kernel issue. So instead of a whole max_features, xgetbv() to 
get XCR0 and xfeatures_mask_supervisor() to get IA32_XSS provides more 
debug info in case platform may have issue in XCR0 or IA32_XSS.

In other words, splitting max_features into XCR0 and IA32_XSS and 
showing them individually provide more useful debug info than one single 
max_features value.

Does it make sense?

> 
> I still expect some acknowledgment of what is coded here for the kernel 
> calculation details.

The kernel calculation is shown in
+        print_xstate_offset_size();
+        pr_info("x86/fpu: total size: %u bytes\n", size);

Isn't that detailed enough to show offset and size of each xstate and 
sum of sizes?

After that,
+	pr_info("x86/fpu: kernel_size from CPUID.0xd.0x%x:EBX: %u bytes\n",
+               compacted ? 1 : 0, kernel_size);
shows how kernel_size is calculated from CPUID?

Using the above debug info, a real platform CPUID issue is shown clearly.

What other details are needed?

Thanks.

-Fenghua
