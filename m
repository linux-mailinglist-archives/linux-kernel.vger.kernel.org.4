Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9824D6F8CB3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 01:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjEEXRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 19:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjEEXRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 19:17:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A464C1D
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 16:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683328649; x=1714864649;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vPBbHnjpDIbZ2IU0xWcarEna3cYO+6LbEucWAOEw3No=;
  b=J58cegyNeIvGt8IEqS6bLO/5gFbnSaIEHJoW2KAwnxwRjaOJbnXLtWfk
   GqdeAx8ERucz8BcTsf4yifCe2CW0VkPQERdE3w36BEjukIauKG8Gyql5U
   bc8dANcZAgZ/qjqCZQCLBgJdsOi2J8cV7kPMHvnkJYWhSGIVsF7Gnd/ia
   aVwUVkaxfsCVtjIxF5jJ7NPP1YBgTYptLsik6l2WVgC15bHpIzXXCJHlw
   MLV+VpHkUwqe717k4FxDjdExjKeqhl4+PdEBCp7RFG34Ut5EnymPa73Ae
   8gxjXe22DlAH/53J2B8xdhtbg8yIxLBX0WBpukgQU525HniBa9fIgSvg0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="349354518"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="349354518"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 16:17:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="767300860"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="767300860"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 05 May 2023 16:17:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 16:17:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 16:17:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 5 May 2023 16:17:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 5 May 2023 16:17:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+cxSiBHdxPwIA88uZYjj/Op3FCGUPIi/xqP8SSttDnNl8Owi4SjBvGgD+sSVNGDJ2yiYenV4PElV6j0VZfTuNKI57cWbv/6MYYTk+zaI1/PP2GBOSZqXzDPoBpCmnBF83Z3utbsrnGEyRI2s7ygxjMZGsZ2suZqQioxTl2QDgCsluXF8gM8BvjK7jwHJHbTXuznHjZmKcgG53SG/t0GEd7AmFSwztxTO+jmUNl3bDj5155yAF6JWFxmgb9rL6ye11wLYpViqtL0dZjxQmIUVdouf5Z7M/VxtGS+uVE3OcXK+5qCOasddwQpGaIY7+3ZaEkd8trTyxt2DfRvX5a5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxOMnualWqbrh3HlbkxOfVZsE0l/Dfa4/OIzl0jBFbc=;
 b=jMOuIDZx6onFAHjpEIFp/BuqktW8WnGkXI7XtS70/XQQF+ybus/58hoVms6Lc8YjIzNcmcT/0QwXBhZAq4UU2mEMsulloKoOTBIPolCnRzwmDxoptpjm3OFe8oQ+kIiI187KjZnlc6CjQTcxKUrgWi3ojpGypUI5Uszm0+fHbInpxMlOjkRw8uJQVCVQuF5XfPkJWi+Ag6TmCybwRxPDzArQmlB0JkxRwJ1ZidgvBTxKk7zessiC+Vi+Y9cB6AeimO0vtf7Ho/iUS7cDqAJB8j1R3zXG98Xot8RjH0FnXbkOUk41a2FsbpymHrgqBnxrMEPQ/53AlcwijYO0mS1MSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5953.namprd11.prod.outlook.com (2603:10b6:208:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 23:17:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 23:17:20 +0000
Message-ID: <c0755752-ce84-b5f9-6ac6-97812e98b8c3@intel.com>
Date:   Fri, 5 May 2023 16:17:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 0/7] Add driver registration i/f to resctrl
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        James Morse <james.morse@arm.com>,
        "Babu Moger" <babu.moger@amd.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230420220636.53527-1-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230420220636.53527-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0187.namprd05.prod.outlook.com
 (2603:10b6:a03:330::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 04aff948-a913-4088-221c-08db4dbee03a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qCfmUCQCdGnlBRU3R00i1OcjfMylriSWBcFLoEkBfw+TakMRIcYWAKWeof28U/6Dl8ur/cZhTa//lThtpUxPRxyW1K8zu4Mri4f3Z62enxOp96t6/Gh3Howv7IeYP5rBOl9dStcJQNq9SIuEGLszKUUFLEGddwUHlpI/v0gP/g8F0jzqh9HlOqgJ4BX3UOZgttmbDW0/yD7ML2heUrR287h0022otfqgKbg+qkwIuHF+KhVTm1p6e+vbYrTJMRRF2Y945URzjOOtKVsdA6zQMV086cx9rCu1dpnsrxnul1BNsGpgrviAAILwa9KKdHkjQniYzUaBM/u9fy7eQs4PmWsDnDzNjCh/x+zu8tXLWOtmVhrMT7iodP74sT1YuVf/I/NZ5Ej+9MuW4p3oSIxSjS4BxJgqFjue+xuEPWVevb6fAspX53yek2RkaV4VZPoXJKN+2N/pRe2RthfulMetRDOs3hjaWGR+yqqKLXVyIP6uZmXkAlnueowbj2sAP5Vgr05I1E38bDsGwPmN7zYNUwk44Jz3o2Wwiqtv0rVf002MjRv8cy8IbFI2NyZ2mj/bJril+ChreFGP5AtEWH0kcix+sgAol8lXgp4St5wJSfElF4F26RQJyo60gx8Knlxv0a9Vhow49QSMhTdn2jH7xvWf8NpdxAamur4tkX8Gvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(6512007)(53546011)(6506007)(26005)(31696002)(186003)(66899021)(2616005)(31686004)(966005)(110136005)(36756003)(6486002)(2906002)(82960400001)(316002)(8936002)(5660300002)(478600001)(4326008)(38100700002)(7416002)(86362001)(8676002)(44832011)(66476007)(41300700001)(66556008)(921005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXE4TDFPa1VkckxQdHg3SmtTQit6ZWJFK1JLTkl4MFJmWTZYSWhLbkI1YjZR?=
 =?utf-8?B?aG9CWGJBcWhteXdOSlBQdVliaitDNmtjMDJ1OGZQc1oyRWNhSFlvSWFtWDI1?=
 =?utf-8?B?a0J5TURCOEEveDk4VDBGbnlMc3QrMGNCMTU3aHFtdkQ4Mm9MSW1uM0wzSDha?=
 =?utf-8?B?SFdBZXI3NEI0OEQvZUxBMGNUdm5VaG9TYTVGdjM5ZWpjMWZ0TFVCU0Z5dUtk?=
 =?utf-8?B?UGxBVnpqSGFScDRHZUVEN1pZdUVKa1Zhc2Zvamh1Q0hjZVBaT3lhWm51MVBC?=
 =?utf-8?B?TXh0bzVEZUpsbnk0RGFNbU94NkFDUmJkS25FcFlEWTJYdXRPMXBQdDYrd2xr?=
 =?utf-8?B?RTd6WHA5aThUMU12Sk1weXVQci9OTnJNYWFwTHlNMkdGekh1Z0k3T2F0L2Er?=
 =?utf-8?B?ZmprcTVBN2dYaHoxTVFheWE5NzN2alpURWF1L3d6WGYvaE9yTGVaZjVKdXpV?=
 =?utf-8?B?d1kzSFJKOTl4ZzBRSkNRdiszOWYvTkNnVUc0b09hNkRXT3MyUWVuNjdML1Fl?=
 =?utf-8?B?cWxSOVVyU0FuZlQ5VXZWdzFKUDk2UG01L0ZOcXlHbGNIRDNwVmMxWnc2eGhL?=
 =?utf-8?B?QWpCZFhnWUNyTW92VElTMkxBeFpjWnRnTnFoL1VkcjNVWG0wNGhlOHAzWDJa?=
 =?utf-8?B?NE1VWGx3RG9lTUR3ZFBnejlEcjdhc1oyRitMWEVkRGJBdHVFYllzNGFPRVBX?=
 =?utf-8?B?a1RFMUFIT2lZUWNXZnhkeW5lcHlNL1BQT0d2TXJNS0p4TGxkVkcxYlZvWWhI?=
 =?utf-8?B?ZHZHRmJML1h3b1NhUm1qa0NacDdRY2c1WkhDSXNCd0VPRFE2eHczcUlDeUcw?=
 =?utf-8?B?NUNmYk9VeUh4cDl4Vk1sN2p5ZzdLUzJkb25tTWRQLzFObnRUSHZqWjMzYTJM?=
 =?utf-8?B?TnR0NzJabW5sbjlZbnZQSDdYK2NRNEdPRkh2MnFtLzNvQ0tPbXFhcWZRY0lQ?=
 =?utf-8?B?bWNzMm5Nak5FQzloYm16K04raitBUFJTNllNUUZaYXBOdlJYMC9xeXdrbjZZ?=
 =?utf-8?B?aGs4a3VVZGdMSno4aFNrZ21FL3pCYjJOMG1WcEsvalB1Zlp0U3dxclZ4RTlX?=
 =?utf-8?B?Y05EdVZQYkZpT29CYWJ0MlQrRDAvNWtURjBSZWlFMm9DQkRsUGFKaTJHWXN3?=
 =?utf-8?B?c2hYZGtJZEtac3VrUlhNcGtBM0N5MEJyenVjRmNkdmFvZ29DUFZrMlZwc0RG?=
 =?utf-8?B?VXRoaUZvVkJZVWpyV3J4SHFqQkhkQ1dwTXkva3Q2b3BjUUFxYm1MREVVNWxu?=
 =?utf-8?B?L2ZoaHlYUUg5N0lIK084ZDVETUMyVmluRStTUyt0eTlGTlIwaTA5ZEhSR0Y5?=
 =?utf-8?B?RTVYK0dpTTk2RVE5cjhod21CVzdRdUJEWHpwNDFkNzdMd1YxZHoxS0ptKzF3?=
 =?utf-8?B?Q250OXM0Q2FPTy9FRWdQV1dVbHBRZ2IyZUNEbE5VaXlmQnhPeHZ0bExwQytm?=
 =?utf-8?B?TjZtYU1CSDZ0UlFpaWpkamREaStVMlllbUpZb0NNVU1pTlJFOXRRS1NzOUZ3?=
 =?utf-8?B?aFA3eVMzNDFPYTZ2QkRLckJJcEVLZ0xLYmhuTUM3bGZaQnR1bzVaTUQ4cENL?=
 =?utf-8?B?L2MrdWZJUysyNHBuR1VXME5SWE9iREtaUEYrZXVaVU9OTVdXUGt2QUVGa2FL?=
 =?utf-8?B?REZhSVRtZFVjMlROTGxDSUdNR29ZOEh4OFNnQ0l6UHV3QnV0ZUxucjZKTENR?=
 =?utf-8?B?bGFrTHJnb011ZWNPR0JSWnRvcHFzQ3JPU0daOHFRRnF3d29NQUZUVkhPd3BD?=
 =?utf-8?B?bUU5eUY5eEFtRGVNQ3pLaXJCQ0NoR0VDZTFxaDdlc1lHS0V0b3dYb0JXbFJR?=
 =?utf-8?B?RlM1T1dIM0EwWHVxUkZQQ1RjdDBOZDI0Tjdud2xId3JjVTBiUC9ydElEeEtT?=
 =?utf-8?B?RTM5RTJDN2Q5QkoreGYrdWxKR2JDYlNZck85UWlQRTl0d0lZeFpwc3lxNmRP?=
 =?utf-8?B?WVpNM25jK2VycWtWMzZpN2NvM2pzR0dWdlpJRnM0RW1tdW9xWWNlWHZVZDgr?=
 =?utf-8?B?SUpLMlEycmtLaTN1T0VrMWk4NWwzU3pPcE12TTNmSU40dU9TNUIyRFRwV0x6?=
 =?utf-8?B?SHptekIvdlJ2ZTcwN1ZIQUh0Y3NzYkhreWVRenEyZ0tPWXU5bkk3alhwaXJE?=
 =?utf-8?B?WEQwazJBY2h1dTI4R1Y2aHpFRE5BNy9HaXlkRWlOVklCUnhKRFg1MDhnSEVY?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04aff948-a913-4088-221c-08db4dbee03a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 23:17:20.5128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZp2UOnxKcl2fbpDJh7R+ap3PsDJmannzVwK4I/iaDeyYj7jpgelc5IEMMKPRegt/bsJWCq1kvjMEd37LbhDnsuJyrd3N1G1WM1NA0LabIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5953
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 4/20/2023 3:06 PM, Tony Luck wrote:
> This is very much proof of concept code at this stage. I have a few
> quality of service features that are hard to intergrate into the core

(integrate?)

> resctrl code because they are model specific, or have input parameters
> that do not fit neatly into the existing schemata model.

I would like to understand these two motivations better.

Regarding "because they are model specific": the features would remain
model specific no matter from where they are supported so it sounds to
me that you would like to move/contain the model specific logic to
the drivers? Why would this be a motivation since it seems that this
would still make things model specific. I do not think resctrl is
averse to model specific code when I consider the code like
cache_alloc_hsw_probe() and __check_quirks_intel().

Regarding "do not fit neatly into the existing schemata model": could
you please elaborate? If I understand correctly a driver would like
to take ownership of a line in the schemata file, I then look at
a driver as providing support for a resource. It looks like 
these new resources may not be "domain aware" so would require unique
parsing, but that is something we can do in resctrl, no? Something
like a unique "parse_line()" associated with each resctrl resource?

Considering the above it is not clear to me at this point why this
driver interface is needed. Why could each new driver not instead be
a resctrl resource?

> Also, as AMD, ARM, and now RISC-V are looking to share the core resctrl
> code, it might be helpful to have "driver" as a software layer for
> per-CPU architectural code to avoid cluttering the core.
> 
> None of my drivers are ready to post, so this series has a simple example
> driver that would meet the same debug requirements of Babu Moger's
> patch to expose the CLOSID/RMID in files in each directory:
> 
>   https://lore.kernel.org/all/168177449635.1758847.13040588638888054027.stgit@bmoger-ubuntu/
> 
> Doing this debug with a driver that can be loaded unloaded without
> having to unmount and remount the resctrl file system appears slightly
> more convenient that a "-o debug" option. But this example driver is
> really intended just as a toy example of what can be done.

The driver seems simple but I think it already shows that this can get
complicated with many sharp corners. If I understand correctly this driver
will add the "closid" and "rmid" files in every control and monitor group. This
driver thus assumes a system that supports both control and monitoring, but
that is not guaranteed. For robustness the "rmid" file should not appear
in a control group that does not support monitoring.

> 
> The series is broken into steps that add callback functions into various
> different parts of the resctrl hierarchy. That list of parts has been
> driven by the needs of the drivers that I want to write. The
> registration interface could be extended if there are additional
> hooks need for other drivers.

The boundaries of the resctrl and driver interface are not clear to me.
Looking at where the new driver API is created and how it is used in the
example code I see that this occurs in include/linux/resctrl.h. This is
the API that an architecture using resctrl is intended to use and
thus provides much more to the drivers that I'd expect it to want to or
be able to use based on this description. 

> 
> I'm looking for high level comments on the desireability of this approach

(desirability?)

> at this time. I don't expect any of this to be merged until I have some
> real drivers that use this to offer to upstream.

Some hints about scenarios that require this driver interface would be
helpful.

Apart from the high level comments above I looked briefly at the patches
and responded there where I have some high level comments/questions.

Reinette

