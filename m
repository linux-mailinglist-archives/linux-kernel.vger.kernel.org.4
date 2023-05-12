Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20588700D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbjELQ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237733AbjELQ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:57:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21E9D853
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683910627; x=1715446627;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pDj/e/PoFIZR7GdaVEqs6+jEnzGPYAihSYGJJNZnXuo=;
  b=agRKZYgelZfcK7Mvddd51i6tJ2ZD1KMw0TvHwXTjnNON7wMXHeRmFMIU
   /KIcsTuaPMJVj6XtYBqQiYA/mW0Hj34S1aUS5pWNE+BCxH5WQg5Omqdxm
   ZhAjqAE15d9k3p1BdP5hrbZ/SU7hjOqkeZg0Rz4m/tjjOX5VzOcdwyJ+C
   otDHkMs8HqE5oN5XZVGMqvp80siRVzb4Y7uhYxCSYP7BSwVHUrRGc4mAb
   Yft6pe0Y5kxKC5NhZGCHFABIkVvi88SELHvBKMZrX4T1PwUSBKIs5L9e9
   q4Ss5ae9wdl89xcLc3Ex7lUv1d0u4bFkUWo7Uof/MdTLFjP6jrZmu5s2T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="416469654"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="416469654"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 09:57:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="1030154357"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="1030154357"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 12 May 2023 09:57:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 09:57:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 09:57:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 12 May 2023 09:57:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 12 May 2023 09:57:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdUN5eEXYCghEsjXdKnhNOs5gGuWjuFlfngngxB536dyzhm3BILTkK3fa+wDqX+rcL1LRzaOnsYMmwG0Y5kUaZergkqpPevucFyKwJyuj0e7TGq1nUEQnZIdQLErmdaxWLSk6jRiroExoBjJ2JbW98889yIcBoTcHyEdtYNnArB3Kmq2eUHBC261GEccLsfO0NX4Idt2QlvZdXfiJOulSQyC2tY56TZUE5nHZQJcTkRQk21Dr1nakQ/hCImdK6B57lgMbQ7vPmb08Sufoo39EaMWAvMrusmpYsWVFhpoz66zmSGyM65ws+NloFbZNhEKX54fac4DN6ilVnq8c/hwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6sOljgR6E/tI8K7CJCrN4do1qgjJ0IDqDVTY2+1Eoo=;
 b=SW2C2v8JglSs2C7LmHcLWGTeV3vvm78D+Tp07F2bLGJcAlb4yQ4BwPTluTmDLvx8ldZmn6G/t/BJcoko4NH8S/8/hvX2ZBvNpZStEqmjTOe+cwygBw5KKM3ZpdZ/8pg0Bu3/6+4JG4dN5dmnGnR+g8RofQqr3BsJjV6OPkrgeCZjKMADHt4i0/8ZHc49EtjU+A0Was/Cc5/5XIdHzDerxjEl+KF+vkYhjZ39sf3DANlOWGMrR3+WIEcBsILUX6KlpYIf9oeJUSajBb/OkHctdnkZzDSoDO/biV8J7rXwcBCPgOPmq+4Pabko+u/VInsP5/3oP7I4IEa8Lb89TZvRww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6346.namprd11.prod.outlook.com (2603:10b6:208:38a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 16:57:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 16:57:02 +0000
Message-ID: <b35c1b06-4236-15dc-6aed-ece8a0331c8c@intel.com>
Date:   Fri, 12 May 2023 09:57:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 0/7] Add driver registration i/f to resctrl
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        James Morse <james.morse@arm.com>,
        "Babu Moger" <babu.moger@amd.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230420220636.53527-1-tony.luck@intel.com>
 <c0755752-ce84-b5f9-6ac6-97812e98b8c3@intel.com>
 <SJ1PR11MB60832074F3140B38C1B08596FC719@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <237603b3-f553-2ede-5725-239b65626c69@intel.com>
 <SJ1PR11MB6083CFFA8CBDD296E966EC85FC769@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB6083031582F2A61A7D24ABAFFC749@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083031582F2A61A7D24ABAFFC749@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:a03:338::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: ddad4ba0-7966-4147-5453-08db5309e89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Jj+/RZ3IcM7VFWP8/3WWgD/cMLAX7S0jFOlODB8Vw7rKfpC4+/vLpUTBfuhLKQx9sH5tYgFkEJnOl3zgT4Q8X9vcq4h25itlmpll2no06PklBj9u1NAWdAKVfQXV2zanojdlxhZxua+MoT+nE32IDwvQxplVVx89VTDPDUaVc+dzgLi1ci7EHYcTQ6H8MiwAgM0gqCNWkmlm5qVT6mW3dqxXs6D9PYibHcCDnUxjhShC9atpPL0XtReeRlJAJZYHN8ISOxJ/xkflNQ8CrZoLJfpOHMrde8sNUDmG+yxSVa1Tf2RVNo//1jfrnZodfItmKQREq34pHfxcIvXdGKDgiIniKL4rlkz5NUGGdeqGfg899IUOKxAN4DfL4POL2P6aroJqkb54UPQZf6hgfCXz+CpHUZEozxEPl5Clg27IRImmbCWSL+kskxn4Y2uc6pJRZWslYhyBX7nDtpIZ6XutbCU5HE529jHhFTW0mSHXjLy6puBjPn/L1YY9j/r7IPHdUDrNX82MgTzxgGoB2E2txQlpC37e21sUVfbHgG9nuGczxOTnTY4oIQbIqHs+uimvPT09dur6xw2+h8XOW9sSLkqiu3BBDPv0QEiksD5o8Je2Uo+Dnba2H7qJz+uWZLQfWvK/eW1bEsrrL+13MuLEvILCuzmEOmzImm5LfGUO+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(110136005)(31686004)(54906003)(38100700002)(26005)(316002)(921005)(6512007)(83380400001)(53546011)(82960400001)(41300700001)(6506007)(8936002)(66946007)(66476007)(86362001)(31696002)(8676002)(5660300002)(4326008)(66556008)(186003)(966005)(36756003)(44832011)(2616005)(478600001)(2906002)(7416002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjZ3K2NkYzI5SU1CeXNJQ1ZrT0ZlaVVIeHNZbzYxbm9yL0h4aFVxS1NveWFp?=
 =?utf-8?B?bVlLNkczWkxjV0xRMEltenVjL3RPUzhqQWY1SnJDU2s3M2xjRUZESUhXUG5I?=
 =?utf-8?B?RTlKNExJLzhmRmtEWC9kTlRFTlNvS0dnREpUVWhiaUV4NUdaOStWazlnc1l6?=
 =?utf-8?B?cnhpRFVoTXdERE1sM1VUVThtamg3emZ2WWcyb2w3Qi9mWm45ZkhzaXJYbmlS?=
 =?utf-8?B?UG8wU1Q3WllpTFlDWkltRGUweGNRUWFheENHMk81a3FSVzEvd3VwTnllZFp2?=
 =?utf-8?B?UVl1c2dLNVZaWlhQQm1MTUZZTnNmS0RIWWFPdEh5WmIvOUZQRURNSWptV2l0?=
 =?utf-8?B?MytyTDBlOXZOZ3FEbEowdjg2eTErdE5WT3UxcUFEK2krOVBNWEtPWTJQR0xR?=
 =?utf-8?B?RVNSb1E2MFV2UXlmdy94QzA1b09SVmNDeEdpcnNRMERHZDVFcjlmUVJTSGU2?=
 =?utf-8?B?VEcweFlSQmFPR3hRcEhzYjZiSWhzRXNGcWtGOERUMFdmNEd1WjhnUUZNMlZo?=
 =?utf-8?B?MFdHekYvZC9Gd1VVUXN4dnJUb1FYMnVWbHp6R2ljUVYvWE16Y3k4N0krRDJ5?=
 =?utf-8?B?MjVnK3l4TU5mNCsrakI3Vy9tTk5pUmt6KytvaFpHb04rNS9GNlU1N1dtY2pY?=
 =?utf-8?B?VmZaU1hTbzRuallldmZxYnNaWmNYYm5LeEU1aTdYTkh2UitQYmFKMk1kaHlX?=
 =?utf-8?B?QW43RGF2STBNZzlMWmIwK0ZUWWdiT3k4UkdYWlVKdmFRdkk2TnNjZ1dzeUpi?=
 =?utf-8?B?cUY1ajJYcWNyb3VlVi9tT203Y0drTGs3L201RkZUUzBGQmI4d2ZieVd2MWNz?=
 =?utf-8?B?d1dHeGEwNWlESCtOUHdvL3ZlNGVhVnpmNEYxaGpYRDM5S25GTXlqTUNYdUl1?=
 =?utf-8?B?VDJ4RWVJR09NVVl3MnFFRWRQQm1jRUtxNURZNVpTNkU4TWcwdTJqN0lWeXlp?=
 =?utf-8?B?M0NiSkdhLzhNVFA1YloyWjNqdUQ0V3FMNEw4RmhFSFlRZ3RrL29YS1AyTG5W?=
 =?utf-8?B?b0EweG8vQzN1emRzL2VTZG5HU1B0R0RPd0lUWjZYSDJvYTVEdC9mb0o3ZlZ5?=
 =?utf-8?B?dVo3Y1VhZWZNMEpRaFRib3VWem54R3kwUFh2dGRHbkpqR09lQ3NLbUxRVWJj?=
 =?utf-8?B?NmdYU1dFTVYwdUhMb1JYb0hxZ29aTWhHalhUWmN1alJGRXBzRFE2d3JnZWFr?=
 =?utf-8?B?b1NoUllhMWhTRXFFb3dzZzB0VlFYNG5FWFdZaDdWbURTNWYwd2REK2RKVWt3?=
 =?utf-8?B?VWFINUZpU0U3enBILzM4MTl1WHczeDhjYVcwbnRUM3hiQTFPZTkzaHcxVC9B?=
 =?utf-8?B?bEt1eCtmZ2lrRUxhOVhCR0hPUGE2aXM0OEpMY21taUhyRXAxYjF4MTBoSWJz?=
 =?utf-8?B?UkhJbmRXbXdyMUNqY09aeHZOMHpDL08yUG9qbFBzVThaZWRsZ1JkaTVHemdz?=
 =?utf-8?B?TXhxRkpIeTVjTWFsald1ZHd2UUkrU2tXSTV4a05hTXNDVHJ5SVNtQU5JdzZ1?=
 =?utf-8?B?bVhTQklTemNwOUsyUEwxSzNkZ0ROOXE1VnZuQjhPU3NOLzIycG1kSmdnZk80?=
 =?utf-8?B?M1hwQ3k1NU5FNk9YMVdGdWpPajhDczdybzlrOTcrODR4ckQva20vczhZNkww?=
 =?utf-8?B?K1RxMFhrRFhPTWtkRjhFL1FUVXFjRkNaNzlTNXZmNE05eGJMU0crM0tkU0hI?=
 =?utf-8?B?cjRhVjE2bVpvOHZXTkpLRmJ2U3FyZnZwNWRCdWU2dHQybmRHUi9MKzV0RDVU?=
 =?utf-8?B?ODFPR1hJdXpZRG8yVXAzdFEyKzJ5dUNLNjhBQk5VVm5VSDFPT3llOGQrOXky?=
 =?utf-8?B?U3RmQjc3ZmV2ZGNiTjRpYVBacWgrWG5PZkd3RS9zVU1nd3JKWkoveE9kVEVk?=
 =?utf-8?B?aC9abkM5QnRIaFUydmR3OUVrenJ0eTJUMHJULzBaa1RBUGhEbnAxQmQ2RmRu?=
 =?utf-8?B?LzI4aVd4OEdHTmhOYlpDa0xZZUxlNmZLbjdleHhESHZONWlBWklQUUdXc053?=
 =?utf-8?B?b2RnTy9DMGhMT1lsVHA2K21vSlh3Q1UyVEZ3T3NUQTlFQlFsUlF3bXRuUFdB?=
 =?utf-8?B?d2VPQU9kZ1MzOVk5QjNieW5iWXpFckNTRTVDbTZmQXhzdno4SEthRityQ3l0?=
 =?utf-8?B?bmx5UXN2NE8xRjBlWmJKUFBIak9aSUdRRGJrZWJXRVhpV1RUaUhrUXlISHBG?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddad4ba0-7966-4147-5453-08db5309e89d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 16:57:02.7822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m49pRf5R95hWd1+VF9Hn+wXUXUhjVEYuaaZzz95hjLWKuoB51iOXoXkTtcAS4CJvp4EANnXANuNKbxl1sYsb7AMptZjTPyiBaONoabx2cXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6346
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 5/11/2023 1:35 PM, Luck, Tony wrote:
> Reinette,
> 
> You asked for examples of resources that don't fit well into the
> existing schemata model.
Primarily about me trying to understand what about the existing schemata
model makes these new features hard to support. My first confusion is
that it is not clear to me what you mean with "schemata
model". I think there are two parts to this: the schemata model as
the user interface and the schemata model as implemented within
resctrl.

It is not clear in your motivation whether you are talking about the
former or the latter and thus dug through the patches to figure this
out. At first it seemed as though the driver aims for a totally
different configuration mechanism with the support for driver specific
writable files in every group ... but then then the driver pivots and
hooks into schemata files so it then seems that the driver mechanism does
aim to maintain the schemata model as user interface (perhaps with
additional configuration files to give more meaning to the values
written to the schemata file).

So, it seems to me that the concern is not with the user interface, but
how the schemata parsing is done in resctrl. I just seem to keep guessing
here so I would appreciate more insight.

> Here's the details behind one of those cases.
> 
> Existing resources have a single value per domain (e.g. a cache-way
> bitmask, or a memory bandwidth percentage or target). One of my new
> resources has several parameters. At first glance this might be
> solved by just listing a comma separated list of these parameters
> for each domain. So the schemata entry for feature XYZ that has two
> domains might look like this:

 
> XYZ:0=param1,param2,param3;1=param1,param2,param3
> 
> But this feature has a second problem. The hardware supports a very
> limited set of variations. This could be handled by reporting
> num_closid for this resource to that low number. But then resctrl
> core code would limit all resources to that value. Instead the h/w
> allows programming a mapping feature from closid numbers to resource
> instances (as the saying goes "any computer science problem can be
> solved with one extra level of indirection").
> 
> So if the driver named these instances: A, B, C, D. Then a schemata
> file might look like:
> 
> XYZ:0=B;1=C
> 
> meaning that the driver will set up so CLOSID for this resctrl
> resource is mapped to instance "B" on domain 0 and to instance "C" on
> domain 1
Apologies but it is still not clear to me how this cannot be handled
in resctrl. For example, consider this hypothetical snippet that uses
a unique callback to parse a resource's schemata entry (similar to the
s->update() callback you introduce, but not have it be optional):

 	struct resctrl_schema *s;
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
		if (!strcmp(resname, s->name) && rdtgrp->closid < s->num_closid)
			return s->parse_line(tok, s, rdtgrp);
 	}
 	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);

 
> The driver provides a way to set param1, param2, param3 for each of
> the A, B, C, D instances.

Seems like these could be some new RFTYPE_RES_XYZ files?

On the model specific motivation topic: If the goal of the driver
interface is to support model specific changes to resctrl there is a
publicly available use case for consideration:
https://lore.kernel.org/lkml/20230421141723.2405942-1-peternewman@google.com/

It is not obvious to me how that model specific problem could be solved
with this driver interface. Your insight here would be appreciated but it
seems to me that we will have to keep accommodating model specific code
in resctrl.

Reinette

