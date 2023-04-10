Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23116DCC3B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDJUm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDJUm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:42:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70191FF7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681159375; x=1712695375;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NlzbXyiVLQVkmza3NNwpN3qXbIgscBrvTYJXkCyWQTs=;
  b=B5ZrL1sFMbwDcOCapXF+DkjkIpxpMo5Pfi9MXL3tzm846Bhk1tJOX9es
   2XXskTDGMpUmnv7EYduF78xcze6xfgTUwz0+ir59ZTXJdeTUN0gjFBQeL
   JIw6w56U3ICEOPW4EWvlvnrL4So4Z9L9uGPp+abrvMDuqYyCF8zmM71US
   1Ae5G6eh5ctRqJKsA+ZQDiv4hQaA6aZvrFRtzztt5Ix13A1rL1Or9iTFf
   3QuBnZYJ90BY0wYsoZL1uOPnLLOs+OJNI8aHjG78gT1jn5LGaQCzMxrUC
   7jaXtBXCoPwLvlxEQ0vdkcAfh+rF/dc+4cHVdTmUO0wjxp+uJEofXkDPY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="343457117"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="343457117"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 13:42:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="752887386"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="752887386"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 10 Apr 2023 13:42:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 13:42:54 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 13:42:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 10 Apr 2023 13:42:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 10 Apr 2023 13:42:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsirUNJu3OFlCMtqoK88n/jh6ZMf6+P6Ct5ZQH4m6OMwe4lFbGR9cKlnpp9xJubh4x92+9cRZHO9Z6rB3mkDPXShHRN4n1fSB/5dcKutFpUYYA+c9AGjlvtfK0BCam5TjTJ+ONuD3rvFOnW0cAotp3Zblin9XpgmuHqyFYvcrlkqYmL2z6gZ/UR/DtyC2qp5c8vMSjdfgz2CgzCnC5vn3dzfeXS+mozwtlooP03YJKZUyuRPq4dA0vI70uXDEwZUTGriedtD2oEuWcCS1gAy+JRcJRtRrVmbpQoArFgOK49QLYDYJvnQp/K33jBFCRczTg4hfuYO1KYm5oDjcN/yQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rq7flRnwvnw8sAQabivl99BslAgyhNUNgkFxBZBEE+E=;
 b=mut+t2YRBUfWmp2SUTQ8qJGLUaotIugaDG8GAP35nkPqEgZX0C0jxc6cbr73/Wp2d0Sr8Ghyunxn62Z7eVpMszhDzhp/jpqXOxSlnBd3W8AplFNtIyQ4TJ6uvNVe8FuX1Kftzc9iq4+ShDj2wVG35NWwXPNkIKE31xtJPAQ3WZIr9Amxrf/1E/3qkkaMjV7rlAcpR5BimRCmPOnJl9CPHLat7QVQHNdjawJKOWjHdQogbLhaI7fPz3y7jBY1YIBjV9GaGghelOsUNvokVaqq2bAV3tMYKByTnl+qqB1OXkBAfjXqInhQmQnIG5fwgfItZKOiaFN/LG4SKkQ6r7xmOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA1PR11MB6663.namprd11.prod.outlook.com (2603:10b6:806:257::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Mon, 10 Apr
 2023 20:42:51 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37%3]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 20:42:51 +0000
Message-ID: <c716e021-99ad-2cb7-44c0-ec8393a3440d@intel.com>
Date:   Mon, 10 Apr 2023 13:43:10 -0700
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
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <113918f9-0e44-3d46-8b48-028277ec26bb@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0041.namprd08.prod.outlook.com
 (2603:10b6:a03:117::18) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA1PR11MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 90edbf5b-8529-44d5-fb26-08db3a042724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irfPB1LNZeDlfnegYLzo30XplAeHnq0myzeuBlbPiYqj2Y82GuE4UU1tH9viIuEQR/H35qKmAx93jtymICSJK7inTw8hHpBbWLYsur5q5mS2biNkd9IUYSNge8bDB4iEPryk16MxD2xlSwQAVt7JRQwt8bvLA4fuL7EmXjn6aR/aDjv50aiQRHl7JbfHzpaIliUPn2eH7wUokgX45MLof3STn04qMedkBPbObVh9nf9eYowORxf+vvTOekVfvVG/hfDvm2yT570Ve+wVSdwRF2A0Ho/WCl0XqLhfrR19NEEyJOMqXHzKrdrz0ihavbJB6kSqKdZGZ9wC9wSYqk5n4P9gkqgWLKxJIG+pHwZtzxdVEiA2x8E4yRSAYWAMl/cFpZmb/uFQYOaUOtV6WvblsyskC9Sxvy5WTXxk2PROd5hl9hfStCxilY4UsSmgEPSiLi/YdRlvGagZlx8DbR2UA3k1EqwnqtquFEGlpyyFW+iR6Qr3+FYy4rljgzV25M9hiOTwKXJXHnixGErCpwy13TF5hTBf8soYq8o2nJn+mrFWgO9ZGpC0rGKwai9N/yWcHW0HZnhDvzLhw/DkMihe8n47/BieKq5n5ptJLhgbRfYWeswQhQlbRrTUEhV0uVPAx540WY8pVBcJt9xAB2ALJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199021)(44832011)(38100700002)(2906002)(5660300002)(8936002)(83380400001)(31696002)(86362001)(110136005)(478600001)(31686004)(6666004)(6486002)(36756003)(54906003)(316002)(6506007)(26005)(8676002)(6512007)(66946007)(66556008)(66476007)(41300700001)(53546011)(4326008)(186003)(2616005)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFdvVXBOQ3owOFFSTUZOVGphOWpEUTlNRXJCZmlQcGdpcWJoV3J4Sk9LZE5K?=
 =?utf-8?B?eFBUK3BGS2ZWMm0rSzBmbVpMeDFhUkY0SGo0UGFQVkN2YTdOYzd5alNteHB2?=
 =?utf-8?B?a3MyYk82NkRWblhpYmttN29TWGh6ZkVKcTAxVW10M3duc3hTZ0ZVWnFNczhF?=
 =?utf-8?B?bzdMYkxxRkQ0ODEvODVKZzNKYTZ4SjExcmhyL2FiQmUwK2JYRitaSTFoTUIy?=
 =?utf-8?B?Q3NyVW5TWjNSZi9wQ0NtSHVUOWN2REdudXdhSTRBV2JZejh0MWFhTkZYZ284?=
 =?utf-8?B?M1FoYWRYMVIwMlk2MW13RTEzVHhIUkZtOUFISHdOaGFyc0RPR3NQRW9qQkc2?=
 =?utf-8?B?N1NMVk81NHdtZ3Z5dndWL3c1aEFvNW5yMXQ3WUs1QlNNOEJ2VThtQTFrbVpE?=
 =?utf-8?B?dENlSU96UXp4Y0tZVGtlT0x3SlhEeE9xZFZ1akRURURDWUxuTE5MUHZjK3RV?=
 =?utf-8?B?YTk0aDBSTFBPa1NyRVRQa0JjNGR4aGd3L01hcGdxK3pQeFNTNmExQUJVc2dJ?=
 =?utf-8?B?WkQ0MmE5VmxORFdxdXVSVlNieFVkRC9GTHZXZ05KZWlQUTR0ZVZvRUpPSWNo?=
 =?utf-8?B?YXNnT2NQbHdYTXFTMktJQ3RvQlE5amRLUmlFYzdQOWZEcDZBOXhZS2wvNlc4?=
 =?utf-8?B?OUduVXI5TUFMQ3hsaFdQZzR0Z1VHNFBFTzRqSDBqVGtIaE1QOG1PWXRWYnRv?=
 =?utf-8?B?UzZVN2RiblFSNGdYT0NTTVcxcU81RTExY3NRZEI1NGpCd1dKNVJzalJYSkV2?=
 =?utf-8?B?T0h0WmxVeFJ4TlJ4dDZaODhnaHNhRWh4dnlUN1AydGRYaGdGL2FVaFpBOHdR?=
 =?utf-8?B?ZmFhV2x3bWJMTUhMWktya3Y3YXlmTFAwb05meWoxWnpERmFrWC9hMlVqV1BX?=
 =?utf-8?B?TVc3QWlFeERoOEYrT0xMNTNqNTk4OUxFRm5CNi9QY2hBczdLSGJsVG1tbk9i?=
 =?utf-8?B?aG01U091MWZzeUw5dkRadUhCbzV6MENUcmNkRkN1eElOWFZwNnhmam14dUJs?=
 =?utf-8?B?eTVLM0FpakQ3dDZOUFZPT3pqWG8vVU5CYXBVV0xGZmwzeGtFczZUeUJETmRm?=
 =?utf-8?B?Z3IzLzdlTUs2Z1REeXkybjJ4dzlqUXNWREtOMEp2UTU4RnA0eXBjR3VRUVgw?=
 =?utf-8?B?OUo5ZVU1U3A3eXF1M3h6NnR2WGMwMlJhZDFSMmFxU2xtK1N2UHk0U01VMEQ2?=
 =?utf-8?B?ci9qQnlYRzlhaFNVUHNmUU9hZ1d4TmkxazVMVlh0b1RJalg5c2VFZkszeWxR?=
 =?utf-8?B?dmUzVnRYejZUb3RTbVhsTEJvenZzc2RYS3ZZZGpnUnc3NXltVWxWTGhPdXZQ?=
 =?utf-8?B?bGhoMUVDR2h4dVRNK0tnTGtKOU5lV3gzOWFPdVhmSU14K2Uyc01ERDRlVVZz?=
 =?utf-8?B?WlFPclhNTVBSZDVQdVF6aTN4ZFlzaGNuNkZCUXV6cjZYR0ZlaC8yOXorWlZM?=
 =?utf-8?B?dDY0a0gxOWNHejB6b1dkZDV1RzNpNVh6bmcxejExTHNZSjd3YVBWR2tCSmIw?=
 =?utf-8?B?aVA0ck1SNGtOQ1ZBL1RleW02UlFaWUQ1TDVidUhzTCtNeUZ6eFZWUzFRMU1j?=
 =?utf-8?B?WXdIUGc0QjhaYWc0aWZrV1J2SCtTNUZxamhub2s1aExQQU52SlNEUmpEVXBZ?=
 =?utf-8?B?bVA0d2w1eHZ2aVZRSzUwNjF3dXhmNXRvbkN2Rkh3M1BZcllCb2Q3enlGT1Ux?=
 =?utf-8?B?OFlFdG1sellCUmNsaHVTQzdSaURrNkpXUno2eURLVHRvVE9WeW5vbjM1Vk1o?=
 =?utf-8?B?WFMxMFJIdXRFTDB5ZlQ4TmZjaWJUajdkN1UrejlXRmZqNjBzVEVYbWJvYUhJ?=
 =?utf-8?B?d3d5RXJaY1lpa1pjRUY2V0hDOEh3bUs0RGQ2OXRXVVBZeFQ0VTRDdm9tenBo?=
 =?utf-8?B?bnhCc0w4c0s4S0tjQzFOK0I2Nk90WDkwTnQ1UUkwcm5ScDJWeEowazc3UkVR?=
 =?utf-8?B?VmhvZHZZUWo0V1hLVjQ0eG56RjlLOFdMMkVOWXowU1hnYnVmK3JqaG0zMFJR?=
 =?utf-8?B?elQ5Z2t3c05ZcWNZWTJBMFBMZG5CWms0VXRuZUM5cEdCSDFYRFFnUHdSak5B?=
 =?utf-8?B?U1FrazR4Tk11TUdxNWF1NzlXc1M3OU9nNzJDZ3NaRjdKMXRUMW90cytkQmlD?=
 =?utf-8?Q?IxX5tP98x4UbiyNkGNxCvWdrA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90edbf5b-8529-44d5-fb26-08db3a042724
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 20:42:51.6666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScgecA9GShjmnRxV26RxhENkbJFBGHSimia8T3MO8dTeyUmz1G2jUA5oFf7SUKIedeAj4AnVGgHtA79WbxAGMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6663
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chang,

On 4/7/23 11:22, Chang S. Bae wrote:
> On 4/5/2023 11:39 AM, Fenghua Yu wrote:
>> A warning is emitted when xstate sizes are found inconsistent.
>> But the warning message doesn't show enough information to diagnose
>> the issue.
>>
>> Provide more detailed xstate size information to help debug the issue.
>> As a hypothetical example, on a platform that may report incorrect
>> xstate size in CPUID.0xd.1:EBX, the diagnostic information after
>> the warning will show:
>> [    0.000000] x86/fpu: max_features=0x407
>> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
>> [    0.000000] x86/fpu: xstate_offset[10]: 832, xstate_sizes[10]:    8
>> [    0.000000] x86/fpu: total size: 840 bytes
>> [    0.000000] x86/fpu: XCR0=0x7, IA32_XSS=0x400
>> [    0.000000] x86/fpu: kernel_size from CPUID.0xd.0x1:EBX: 576 bytes
>>
>> XCR0 | IA32_XSS is 0x407 which is consistent with max_features.
>> CPUID.0xd.0x1:EBX should report the size of the xsave area
>> containing xstate components corresponding to bits set in
>> XCR0 | IA32_XSS. But it only reports 576 bytes of xsave area which
>> doesn't count xstate sizes for AVX (offset 2 and 256 bytes) and
>> PASID (offset 10 and 8 bytes). This confirms that the platform
>> reports xstate size incorrectly through the CPUID bits.
>>
>> Suggest-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Tested-by: Chintan M Patel <chintan.m.patel@intel.com>
>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>> ---
>>   arch/x86/kernel/fpu/xstate.c | 33 +++++++++++++++++++++++++++++++--
>>   1 file changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
>> index 0bab497c9436..5f27fcdc6c90 100644
>> --- a/arch/x86/kernel/fpu/xstate.c
>> +++ b/arch/x86/kernel/fpu/xstate.c
>> @@ -602,8 +602,37 @@ static bool __init 
>> paranoid_xstate_size_valid(unsigned int kernel_size)
>>           }
>>       }
>>       size = xstate_calculate_size(fpu_kernel_cfg.max_features, 
>> compacted);
>> -    XSTATE_WARN_ON(size != kernel_size,
>> -               "size %u != kernel_size %u\n", size, kernel_size);
>> +    if (size != kernel_size) {
>> +        u64 xcr0, ia32_xss;
>> +
>> +        XSTATE_WARN_ON(1, "size %u != kernel_size %u\n",
>> +                   size, kernel_size);
>> +
>> +        /* Show more information to help diagnose the size issue. */
>> +        pr_info("x86/fpu: max_features=0x%llx\n",
>> +            fpu_kernel_cfg.max_features);
>> +        print_xstate_offset_size();
>> +        pr_info("x86/fpu: total size: %u bytes\n", size);
>> +        xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
>> +        if (compacted) {
>> +            rdmsrl(MSR_IA32_XSS, ia32_xss);
> 
> This shouldn't be directly read here because of the LBR state component.
> 
> See the function comment:
> 
>   * Independent XSAVE features allocate their own buffers and are not
>   * covered by these checks. Only the size of the buffer for task->fpu
>   * is checked here.
> 
> But, isn't that max_features bitmask pretty much about it?

How about getting IA32_XSS from xfeatures_mask_supervisor()? That's how 
to get kernel_size by setting IA32_XSS without independent features in 
get_xsave_compacted_size().

Thanks.

-Fenghua
