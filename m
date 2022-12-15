Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B03364DF7C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiLORO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiLOROt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:14:49 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFF5DF9E;
        Thu, 15 Dec 2022 09:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671124487; x=1702660487;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p7Wnn+btABAZ/wG73v6fyEsb8g+UV0alwABYwt6uOns=;
  b=PDm0jBrdFKbEZNLRFy569kibPZIAa/r++Jwy7HiZOaiz0x5BRYVK9sNz
   QTsLR1wBAFMVcr5CmwWQLcziu3kx+a2Mc5tt7ldOc+iHYTkuYSmiiKYd/
   c9eHtGrZUTHEM9TzxB/ZYlvcRP3UrBvUFWW12Qv7Cg0mVJZP2jdquRyzC
   X2NdRIA51O6baLSQoWoFcQznTDqVZ47OkCzV18g951kn246X7VZ69MHI5
   pX7yaBVkwmvHvEgSU5jQFqJGRmbOZ2xooVArCQPohyoHbkZm3EGARC4z0
   A5b/HFBB9LkDOogZNhAzuOylYG356S/S6oZfUUkXzAyt/T5Jfa/ZxBExq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="299084246"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="299084246"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 09:10:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="680158155"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="680158155"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 15 Dec 2022 09:10:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 09:10:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 09:10:44 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 09:10:44 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 09:10:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvjfvGXNEsbvg9YLTMw3u0WSrYLrIqI3oIEvEgyd5KKXDvHTPlwCE7eTqkKQax0d9XrN7zRPDWYUNsbSIMky1UARxaOUHdxxSWFjgoWc03cjaHHBGkuTq82XzYWnf4O8aPc8iaWZ9pz2EIZnKsdbbprMC8DGliL+QQmZYJvr2r4i9VlUiF1iQaA06s9UiSzUB6o4gMy5lRH4YgUsD+k4W2mzHKeX0AnIlYqUS7wI5h6N367cNDngBi0jKgmFIc6mAiC8H7Ip9eDcl1uBlAfuCxHRQHz6xZ7umS670YN/oKJi6hXHhTgbCMNivHRxZ1kBF/ctKyhO7hsglkdkhS1EGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNA/mRPQsnQVv9akEN2bIPzOZp5zUZpNmmsYGlcCwFw=;
 b=LlF8QzMBizo4EZZIjk5k3BLpgrHotOLJ2Ivzo2sChbAskCFi7Le8PPAQDnjUIRwRTgIBbrwpPjfsWNy4eFjDCMuOrUHdh5js2ATAjr/7VOJjDc4BooyEpOssRTPJ01Dn2UfbmxJzGp8qs36/TB85mG4jkgCmnq+LAnWy1Rt2tOjcBxtlUk8e5kii5jMf/85WD0lP/lg8sfUk6xjjy53DfGN3Gu0g4tYDyNPnUqkk4tplTplvhdIqeF0J6pfkJfUTJ6sjbGJ9lmM9RPWckYFNlfqRWqr4OTRs3LkJqiwr/id2PUrKNHZYYsXlrCExxkx0rI3H3ihjkRSbtnwISRKqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM4PR11MB7374.namprd11.prod.outlook.com (2603:10b6:8:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 17:10:36 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 17:10:36 +0000
Message-ID: <68c1fbfb-a448-671b-2030-7ba8f059efc3@intel.com>
Date:   Thu, 15 Dec 2022 09:10:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v9 02/13] x86/resctrl: Add a new resource type
 RDT_RESOURCE_SMBA
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
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
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990896761.17806.7084760980218047026.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166990896761.17806.7084760980218047026.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0068.prod.exchangelabs.com (2603:10b6:a03:94::45)
 To CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM4PR11MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: e82f8aa8-916c-4144-b37d-08dadebf4835
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3HZadyh02aOtSd0Oz5nzJLCTxNfS/35EKOdGJvBcKlI0SOvzN0mmfxloqDe9L297dvIthkQ4rqlVWchU/qpOge+TEOXmEuTj9D4379oEjgQSQMa0IgS4O9mnYrhloi42e/fEH7YK6dVgZOfiLBACX4q1Bb3Trhkwow1/ojcSf9qyHSwONFHkocweHOP6mDnr1QeLd/Q46LOR8za04HV97O4j9OSaezG8FNgo8IQJ6gVDsnJuc3LMCwHfE5BBzkY2D/7ZtnSN3trS2aXJe4p6dB04bZAHFZBSYqvjqjtTL2NBIYY4tKtZK3faUlO4vA3GBxoZ0bfZ+kouAI5QKM7grGgvshXpjGZeyGuViyQENXFqIGnQPm+hgJ8lJtx5asOBcgBe+uJlr0izTf4nIq9W9eQ19Cd25BR9TeLGQetl/BY5tVoBwUWVofMo6Y0GP9YWJUs3fY+rwZoc1YOI5vr41Mbeb2nYi69HbPck7lmNlJz0l6yYFq9vqbZSbN174VypHboqxUBLSDtq+GQodrLBU/4X+ABa3TMeiDTjvRNVNPYLLEQ+IuIdfhl/OQGuUOgWUfQ5pOgEb8L5RB7mQGym/hQART8/LAvqFz6nNfKtXm41VikbuANp+2PtEem8oigsnEs1/WmoreKHCdgjJL1WnWLdCUEckpXYXqf12Euq7tnsrt/v0vTipvTrFp31AfDjsBnmrNzWr5hQWyVhVVXBWQnelhFxF5UWMOGeJSTXPv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199015)(478600001)(86362001)(31686004)(6666004)(31696002)(6486002)(38100700002)(6506007)(53546011)(6512007)(26005)(186003)(82960400001)(8936002)(41300700001)(7406005)(44832011)(316002)(36756003)(2906002)(7416002)(2616005)(8676002)(66476007)(4326008)(66946007)(66556008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTdtRWhVWmdnQTVOcDhONXRONXlSSFJRTjJ6SDFsVUU5MUpTeFZCVDY3a3cw?=
 =?utf-8?B?NFlRSUR1UndVSmRxUFAxL2FJaUhVNUZoYmtOclBDUElVMEZocFdWZmNWeWN2?=
 =?utf-8?B?VEJPWHJyTndoQ3hMV3NrZ2xtbnZsZEw5TDI4cWxMcUZKYjZhZHRiaXc1TkR3?=
 =?utf-8?B?ZEtYek9XK0kyU0NVM2hMdkxYdkMwRzVCQkRYSWY5UklleGFPTFRING9LdExC?=
 =?utf-8?B?Zk1lR0ZURzltUnRUWWhpUjd5cTAxZndTUzB1K1VGVjkvVnFvajhSSitISGhJ?=
 =?utf-8?B?aFRJNDBwZGZ5K1A2MkhwQnNqQnpZMkxHb2dNMEdnNTRtYnVueko3M3FHN0kw?=
 =?utf-8?B?cVB0cmtPem1VZ09vR3M3T1ZUd3U3Rmk3ZjNmMDgvVzcza1paSTd1SmJKQmFO?=
 =?utf-8?B?NDRKTmVwcFJZNVY1L0xjZzZNV1k0clhNYm5Oci8rNjQ1cHFoU0Yvb3RwVGo3?=
 =?utf-8?B?VEtaUEpqTVpvbmgvRzZFQlQrTlhqbFdmN0tNTS9vNGVpQ3dqcVpybm5RMEFP?=
 =?utf-8?B?WjZ2YkU2QkhhUDB2cnJEWko0V1pla0RkMXNxSjNRMWVYUkZXdTR0OGt0a2k2?=
 =?utf-8?B?QlJ3bFlVMFM2ZUowdWozTzQzRHgraDNyaG5YZ1JBZlhPQ0VENXBzZXRrekdv?=
 =?utf-8?B?d0FFVmlrUExvWWNOb0VEOTVxVUlDQXZQNHFRL3A2M0hGS2VoQXhlL09kRnlK?=
 =?utf-8?B?aVVxWmdhYklHeEpVV0pkUlNFK1pkVGZFaGhtK2kvVlBtRFlKSE9DSktuVHkv?=
 =?utf-8?B?Z3ArZC9JdldMckMrTEtUd2kwT1JOTG1ERjFyU1NYallBb2J2aWtWbWwxSHgv?=
 =?utf-8?B?VUdTamlWdW52N2kvYkZmQXI2bTRtUk9CS2ZJd3JHL2p5TUNLdkNFT3lFbk9Q?=
 =?utf-8?B?eXphMkFoai9ZRENmNjRaVVAyL0pJaVlPcy9FdllTV3JEak1WUmFWcmRMdVVn?=
 =?utf-8?B?QWRRb0s3b0cxWlZndGs3M2xTTXV0VHpvRnh2VGE2aHhUWjZQZ252WkF0L3do?=
 =?utf-8?B?RUxjSGhTeDNVcXdWcUx0OWhDdEl4am1CaGJFd2FiVC93SFBGMUh6VWxsZ0xM?=
 =?utf-8?B?VWpiSm1DSTVHdU5JUG1FUDdNZkk1ckt5dFJObk5ubjJDZ1VmRW5TazZEYmdP?=
 =?utf-8?B?Ti9QYkx2K0l5ekFHRTBPRHFNU3BGa0dyN2xxem1zTDcvWmJCbG41bWtMVitx?=
 =?utf-8?B?OENSY0N3Qm1xbVlCdHRQK3dlenVackJGbm5RN3JudzJpSkR4Y1QxRHFNa3E2?=
 =?utf-8?B?MlN2YjVEek5ualoyWDdQQWJ5WFJMRytzNG1leXJoaVhLUVQ1MHlsUkpvaGNP?=
 =?utf-8?B?b1NuU1gwVy9uNEtBODRjSk9BTy9aM3dNRTE0eTYxZzEyN1RxcjcrYlBuZHNJ?=
 =?utf-8?B?UUVIYUN2YW5qTXA0WWVKMTQzUDlQVWVrN1I3YkFtNVV5MmZyTzVQVmlKcVhr?=
 =?utf-8?B?ZDNZK3RUcU53Z1R1aGtwaUtyZnZwQzNVQkV2S1BUdWdTMmk3ZThERExNUkVx?=
 =?utf-8?B?Zjd0bWdKQ05JMUNYWC80bHYxNFZzMFRvYVJkVUlnMUZlUzB0NU1HMmcydUdV?=
 =?utf-8?B?VUtYSDNQTFRPSzhvWDl3UzdHL01lc2xneEdvOG85dmZlOVJnajZ5K3FiQmxB?=
 =?utf-8?B?Z09zbEUreU1xVnRmTzhYUkdiVGdQMG1paTV0cWp4SThWL3M2N1pCWVJGdS82?=
 =?utf-8?B?RHJnNzEzR2cwY3NqQyt6K2xRczZXQ0JkM1NhYVJZRFErY2NpZ3N4N2Erb1Ez?=
 =?utf-8?B?RExqTWw5S2laTk1DUzdlZTJMaWZ3NTNlRGpnTW1DblV6dDgwMVg4Y0NrQVVU?=
 =?utf-8?B?dXcwTzJRdWh1TnUzazZEMDRnQ3lvZ0pIWnlxUXR6ZXVDYlBnbWdsUmM2Z1Nk?=
 =?utf-8?B?RWF2RXVyb1BKQzJlRTA4UFd1WDAvUzFSM0VNZ2oweGJHbm9EbUN6SFFWdlN0?=
 =?utf-8?B?ZjlEL0ZZNitPSkplZ1BRVmxvSnBhMXhZMjFROG0vUG5vNlJBSm9nS0w0SHhR?=
 =?utf-8?B?KzlFVVMrUGd6N3B2K3hLS3VzZC9ib1lkdjZ3K011NEFlMW00STNGQllLTVdw?=
 =?utf-8?B?clJ5ZGd0dzdjSWRFZnEvbHF5OW1sKzRSN1Y1K1BraDFRR0JkRURhNVNSd3dC?=
 =?utf-8?B?MzlXTklxVks0cFdDNTgrTzB6N1J0SjkxUE45YmZmR05zVnNzLzZucVpWcGlr?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e82f8aa8-916c-4144-b37d-08dadebf4835
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 17:10:35.9976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t12640ghUkt9U8uFSLjXmTNzH+oKbvW1txErJ1pCMYZ8o+1Mwo/W5HGNQ24Lp4BzJp+5rz/qK1bFsaY14OYxlq3JpVjhPbttas/gnQaFAYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7374
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

Hi Babu,

On 12/1/2022 7:36 AM, Babu Moger wrote:
> Add a new resource type RDT_RESOURCE_SMBA to handle the QoS
> enforcement policies on the external slow memory.
> 

I think a snippet like below may help to set reviewer's mind at
ease about the consequences of values chosen:

"Mostly initialization of the essentials. Setting fflags to
RFTYPE_RES_MB configures the SMBA resource to have the same
resctrl files as the existing MBA resource. The SMBA resource 
has identical properties to the existing MBA resource. These
properties will be enumerated in an upcoming change and exposed
via resctrl because of this flag."

> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     |   12 ++++++++++++
>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index c98e52ff5f20..f6af3ac1ef20 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -100,6 +100,18 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  			.fflags			= RFTYPE_RES_MB,
>  		},
>  	},
> +	[RDT_RESOURCE_SMBA] =
> +	{
> +		.r_resctrl = {
> +			.rid			= RDT_RESOURCE_SMBA,
> +			.name			= "SMBA",
> +			.cache_level		= 3,
> +			.domains		= domain_init(RDT_RESOURCE_SMBA),
> +			.parse_ctrlval		= parse_bw,
> +			.format_str		= "%d=%*u",
> +			.fflags			= RFTYPE_RES_MB,
> +		},
> +	},
>  };
>  
>  /*
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 5ebd28e6aa0c..fdbbf66312ec 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -409,6 +409,7 @@ enum resctrl_res_level {
>  	RDT_RESOURCE_L3,
>  	RDT_RESOURCE_L2,
>  	RDT_RESOURCE_MBA,
> +	RDT_RESOURCE_SMBA,
>  
>  	/* Must be the last */
>  	RDT_NUM_RESOURCES,
> 
> 

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
