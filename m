Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49DE5FBDEF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJKWrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJKWre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:47:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AFE8A7C6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665528452; x=1697064452;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G5axYRBaHhwuzINmuZrR+Yo8ZaQe5fTBcMLR+P3Hjpk=;
  b=Z0tv+RvyTXWh2yusKtaqh7b7CM7R4ey0PMF+YONl3i8xXyvXmxVVFzgZ
   E8IHPiKgWka7ggQdltxZXGS2bO/rUYDtH8WvPGLOPOkSCaCmWn04ZZe/K
   nJS4JJUUEUpZvjNfFk6bdeE0eas9SsYoryrBiQRr70zhd57gYDEhU97CB
   Pf4llU2jQVtzCeW6nHAybzuUJefqpibjO+PuoC7BW/1gSsslTyjTjSHLq
   6TD3ckXtp1pRgLK1SC7xy27akPt6mpgRKWIvKqLkbO5D+7vuess7mRoiI
   edD4FE18HwkRfHjI0Y0YOWKX1bLFZjYzf9LSA56K+Rw7eBei/uSj4ujCs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="287909850"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="287909850"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 15:47:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="577611971"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="577611971"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2022 15:47:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 15:47:31 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 15:47:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 11 Oct 2022 15:47:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 11 Oct 2022 15:47:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgQ4gBKgUt94V2HcUcY3hELy0mwwF7Jw9z6qEQV0PtWsUWuiNxWlyefH+XB47VRrtW2RVt9Wg4/CfXAnMvuZBPvqKerTY3hdn56efoMl0sM6rYwa2wg+7fhR7ZRLRTOVp7ga61ZD/3v7te81bPvXuQNRmVwcqU8WRPfFq/L2DjN1XBaYQe/8QxrKaBPtvONcvcQZw5NtyvSGv68v7nGKmK6/vbOgTR7YtCP9AzlKwUazh05ten87AZAa4QwRzH/NaeOzjq/pzol+cPjY0vqcQNWAkQHAo+STdScHMryWm91/KDgNfkHa2kNbnqKq8jRGkek2oj9khvdcN+FcRQsYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnnszD5lwLwqYPYVphyqk/AifJIOVuLH3M08hwmh1Sk=;
 b=oCo7qcAtJ4v3b1fa9QCixXQRo5R1K5zQYeyyBs+17WbLX8YM8RZokvJw/UKKKXO8KBgQFyyTgVZM5hUl2tgArbUBHfBcdu4kMhvIVv1BYJzigQICqHDFbTolD3Exzl1kWKkwwMyHrjTXduE37E7EKnPHiNm+Dn50HfpXpUAQR0uc/b1M9r8w0U5CQzF5m6bBFqOgZotz6YoNiVkM9bphAU+zpivcWyI76ZHT8T1eUr8Hg3ONjTh3GbCu+sVONhYKYhDEL+1MbZUitbrXUdaF0TjRrYErcYz+f2FyM6wWIYnr53tUjGnLlFpT+tEOHXFz7hKhdi1RAWMYIPo6ScA7hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by DM4PR11MB6383.namprd11.prod.outlook.com (2603:10b6:8:bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Tue, 11 Oct
 2022 22:47:28 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e%9]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 22:47:28 +0000
Message-ID: <d7de8134-b3ff-35ef-0b01-187ad2ccb771@intel.com>
Date:   Tue, 11 Oct 2022 15:47:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for
 init_fpstate
Content-Language: en-CA
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Yuan Yao <yuan.yao@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20221011222425.866137-1-dave.hansen@linux.intel.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20221011222425.866137-1-dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0047.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::22) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|DM4PR11MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a01d90a-e6c0-48de-7146-08daabda92b1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0J3i6X54M051QmK6gKFY1OosCgSnkgXF0J891Lw64AmQp9BEp0g8Qo4T625GAo+eh/03fFRVqOLS7nsLnDKT08o5MNmbXinBboj9oGH2upwoJdxWvNfLrNuGfJha14I7VscCzb0qD4C6gUDy0IDk3fUWgOS7iMXhus7II/WszTlzi0H/myYdseS5uXjtEuiNwMFmgIExqb0DG+gomdC6jaE5NyeVM4OI4Gjy1Zv8smIqBFbouu+cieekgl5EDMHRmtu4YSLvWUd4QkNmPcF/jD71bpWurdJEOZ1PegNrbGbQb2mW8HAH8exfK82sevS7Iiio59yeFeHKXeqLGX5ZuW3BUq/Y8awJghvyxWHQm1cuvpLOmOLbwoy6b4tjYUxR5sHj9QahKLZd124C5a3LOeL2tGHni4vkN26M2ZrfqKz9lWULleWJpti07aNyWgkoe29tjLtp4xq4Jpo51nXYx8d7SdDknxjjQlRw0mZvdDTLZiYOnZrjIWFtrpDbhLGW19BVt8YOwZxKyXErYJrcO0Tv/7oSQgH40SvMEPPP7p0bKc5Fla7RPYyj+pj0q/hgIIuZAmgYeIYi77cgMR3zUTmF4Q4+URDtQZl9pZvnsIyIX6Vm8XomUcF38IVUS5WCWW/HMAh31+H1z3OtUNSWycmzC27WpmXQbu01KxBbv4g3yn0qcg0fLoMYia9kGkz5tbHlNa9XG3dyLHk1r9h58bvDmD4L3ENPLYFrsEDgyHgqQQyBp/J5OeREivLslKWm4B6qogYVev+HMPEwe6GEM2ppVJwt+QSFgeA0pKQNQUFw572hEJSUYQTMkhiOvx/zqdfzCYsPl+sPGvbHKms/t7PDlYwhgy97KtW3XLx7tI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199015)(186003)(2616005)(83380400001)(82960400001)(38100700002)(5660300002)(2906002)(4326008)(41300700001)(8936002)(53546011)(6486002)(8676002)(478600001)(966005)(26005)(6512007)(6506007)(316002)(66476007)(66556008)(66946007)(54906003)(31686004)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFBPRW5sY1c0eFYxQWR4VnVXV3ZKT092eE92SStIVmdtbWl4VzVVdldSNUJm?=
 =?utf-8?B?LzMrMmR1dTNwQkQzY2N6UTNNZW42cUJDbXRmUnhnYlBFRzMvWUVHZ25MMzcw?=
 =?utf-8?B?YlJjazZSWEsxWWZBUlUrVkJhc0xGWno0ZDVGOHQyenEvd2Z1dW1JZEN3MGJM?=
 =?utf-8?B?dmRqMUloYktNeXE2UU9XVGxOQUsxQU5QaTJydTVpd2VueVBsckJMaitObSt6?=
 =?utf-8?B?aGFvK09FMWRQUHg0ODRmRFdCdHdQTXFTeEt0TWFLZXFzQ1RIcm5yS3RvMHQ4?=
 =?utf-8?B?TjVhMnMxTmFVRC9TQldMQmhGSXRvSGZTYnRicVYwZDR0bTdhdFZkWHBiQlRl?=
 =?utf-8?B?eS8xZnFkZ3lkQUhaTEorMHZianltOU0rZnFOMkc1RDhCM29rSjk4UlBUdDFK?=
 =?utf-8?B?RENFRkwwcGN2UlQvNWt0YkVzUm1YNVpRa2E4bCs3dll6b0k0SGU2MlpVV3ky?=
 =?utf-8?B?NjRnZEVQUHJVNjlyYW0rZHZEdFNSd0VtN2ZoRGgrQ2R1amE4NHk3bmJpK0Rs?=
 =?utf-8?B?VzNTeUQ4dlFJaDBNdjloeDUrR09sTm03dVNHaFVjWWFhdnlXT29jemN4RmtY?=
 =?utf-8?B?Tm9aRWpzeDhITUlEUTQwQTJyRmZ6RlZEekFDRWQyUkFjVzNBc0c5RWd3TjFi?=
 =?utf-8?B?V3dLUFNNd0JlUkQ3ak41YjRlcHJONStjL05yQUxnbUtzNGhWTXR6VVJmRytB?=
 =?utf-8?B?cHF2TTMwU0pUeEtmbktsb0lYZXJJcTh0cE1NdjZUaWFRNERGL0hPd254WWl4?=
 =?utf-8?B?eTVTbVFTb2plK0FQQjV3eGJlZnovdUJXYnhuQmtaeUFVdGUxTlgwYll0anBE?=
 =?utf-8?B?ZnpoUVpSYmNvWVhBQ0xxZ2Fnd2dKZmtDdDM2WElUanczSU1IRFZzQ0ZCeXJk?=
 =?utf-8?B?Z3FjSVdHKzJlYVplenZCejY3UzV2RHA4aGwzdUtWbVFidGRscm9QRjhKUU1V?=
 =?utf-8?B?VFkvek1IZFpYeW9PeUFQbUtqd2lwWHJpYXl4Qzl1OUtVNDdGMzQ2Q1NUdHpS?=
 =?utf-8?B?Ny9UdWhKRFM2bVN4eTI1Ny9jQXUzdzVLUEJHSlpiNFJHVXJMcEJyaEJuay94?=
 =?utf-8?B?QXBuM201bkVocVNvd09wM2xJTkxHUzZYQ1RuMVBSYWFTVlcrZUNzaTkxUXVj?=
 =?utf-8?B?dVcyUU5rcVR1UEc3bTlyUFFWRUtNdXVUc3lmeThFMVlYQUVlVVpzVzZ4c21L?=
 =?utf-8?B?d1BhRlo2T1JxNEJjVnkva1AvM3d6WktiYzg0eWpuaUJMNENkTlVVK1l2d3kw?=
 =?utf-8?B?VUtHbmdIbTh6ODF4QldrM0U1RmRrV0JGOTVJZ2RuUTNMN0tIMFVYSXhRQ2Ux?=
 =?utf-8?B?THlWanN4eVR2MzM0TXZBVWxhZnBFeThobkh6aUgvUk1oQk5zNnBlbmZuMWU5?=
 =?utf-8?B?NGpFOTl0K2hDWjFVWWQyVUFFSGkzK1BSQXNiRHVFOWdUK2U5ZEFCd0NlMklV?=
 =?utf-8?B?a29QY1lRcjgzcXpPNFZIUUtZM05BS2l3dDJ3K1hqRFQvSDJTWmhENVJrd3lr?=
 =?utf-8?B?Q25NODlOMUhUZTMrM0xJaEFnQkVleGE3SVR0aDI1bW5nQkRmbWtxbkN5V3lD?=
 =?utf-8?B?dlU3TzNGZTJLUm9UU0VpY3J0Y3ZsSjVER0RnME8wZzEwZThZSWVIRlZha0xR?=
 =?utf-8?B?S3dQMXBjYm56TmNwelhwOVY5Yk45RjVRT0VaM0paSHV2eGJPV2NCUWFTVjU1?=
 =?utf-8?B?bFdQMFZZcVJjbk9oRkRHdXVsdHBqcEhIYVV6WFc4cW52djU0OWpsZFBXWlhP?=
 =?utf-8?B?ajRWeEtLdmV3NjBGRkJkdjlPZUpqUC91bG83QU5ObXFEeU9ITTZ5NFBkUjlS?=
 =?utf-8?B?R3BNbkVwQ3lyOTd2M1IzNTVmdzVQanI0VHBlM1ozN2s1bHpvVjBJVFN6dXNU?=
 =?utf-8?B?ZUIzMU5mZFNGeWJjVThIRVVRL3UzK2ZFUnc2cXBxNXEyMXY1b1ZEeTU0VVpz?=
 =?utf-8?B?bU52aEhzSHk1QTZqK0F4VlZXSDJPaUFRUnNGNUtLOUpXZjFwVXlrMGQzaU9W?=
 =?utf-8?B?eHFKNWFLNDVhZUNNek1kTVFXMWdNbzA4OWJEUUdaV0hjaDlmSlcvKy9pOWlw?=
 =?utf-8?B?NDNpdTZieGhJdktseTJoTkxFTU1ObDA2Qzg5TXhqUXUvQUxvOUtvdGVjQklN?=
 =?utf-8?B?a0hNWEZ5a3NLWDNXU1Fwb2NBbVhJUE5oUXJjU3NEbGtacldKQ1hvMHBSRnJX?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a01d90a-e6c0-48de-7146-08daabda92b1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 22:47:28.0231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8t51JPa+ntmeRfs8sgZmAshNmgDb/iUC3EuNfHaALxhYrhpKb4NcPmVN7LM1wPpSIWKavWUrierO+xTOndqppGd+aD6wjdOW4DPbOatVF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6383
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2022 3:24 PM, Dave Hansen wrote:
> From: Yuan Yao <yuan.yao@intel.com>
> 
> This was found a couple of months ago in a big old AMX
> backport.  But, it looks to be a problem in mainline too.
> Please let me know if this looks OK.  I'd also especially
> appreciate some testing from folks that have AMX hardware
> handy.
> 
> Builds and survives a quick boot test on non-AMX hardware.
> 
> --
> 
> == Background ==
> 
> 'init_fpstate' is a sort of template for all of the fpstates
> that come after it.  It is copied when new processes are
> execve()'d or XRSTOR'd to get fpregs into a known state.
> 
> That means that it represents the *starting* state for a
> process's fpstate which includes only the 'default' features.
> Dynamic features can, of course, be acquired later, but
> processes start with only default_features.
> 
> During boot the kernel decides whether all fpstates will be
> kept in the compacted or uncompacted format.  This choice is
> communicated to the hardware via the XCOMP_BV field in all
> XSAVE buffers, including 'init_fpstate'.
> 
> == Problem ==
> 
> But, the existing XCOMP_BV calculation is incorrect.  It uses
> the set of 'max_features', not the default features.
> 
> As a result, when XRSTOR operates on buffers derived from
> 'init_fpstate', it may attempt to "tickle" dynamic features which
> are at offsets for which there is no space allocated in the
> fpstate.
> 
> == Scope ==
> 
> This normally results in a relatively harmless out-of-bounds
> memory read.  It's harmless because it never gets consumed.  But,
> if the fpstate is next to some unmapped memory, this "tickle" can
> cause a page fault and an oops.
> 
> This only causes issues on systems when dynamic features are
> available and when an XSAVE buffer is next to uninitialized
> memory.  In other words, it only affects recent Intel server
> CPUs, and in relatively few memory locations.
> 
> Those two things are why it took relatively long to catch this.
> 
> == Solution ==
> 
> Use 'default_features' to establish the init_fpstate
> xcomp_bv value.  Reset individual fpstate xcomp_bv values
> when the rest of the fpstate is reset.
> 
> [ dhansen: add reset code from tglx, rewrites
> 	   commit message and comments ]
> 
> Fixes: 1c253ff2287f ("x86/fpu: Move xstate feature masks to fpu_*_cfg")
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Yuan Yao <yuan.yao@intel.com>
> Cc: stable@vger.kernel.org
> ---
>   arch/x86/kernel/fpu/core.c   | 3 +++
>   arch/x86/kernel/fpu/xstate.c | 7 ++++++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 3b28c5b25e12..4d64de34da12 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -526,6 +526,9 @@ static void __fpstate_reset(struct fpstate *fpstate, u64 xfd)
>   	fpstate->xfeatures	= fpu_kernel_cfg.default_features;
>   	fpstate->user_xfeatures	= fpu_user_cfg.default_features;
>   	fpstate->xfd		= xfd;
> +
> +	/* Ensure that xcomp_bv matches ->xfeatures */
> +	xstate_init_xcomp_bv(&fpstate->regs.xsave, fpstate->xfeatures);
>   }
>   
>   void fpstate_reset(struct fpu *fpu)
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index c8340156bfd2..f9f45610c72f 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -360,7 +360,12 @@ static void __init setup_init_fpu_buf(void)
>   
>   	print_xstate_features();
>   
> -	xstate_init_xcomp_bv(&init_fpstate.regs.xsave, fpu_kernel_cfg.max_features);
> +	/*
> +	 * 'init_fpstate' is sized for the default feature
> +	 * set without any of the dynamic features.
> +	 */
> +	xstate_init_xcomp_bv(&init_fpstate.regs.xsave,
> +			     fpu_kernel_cfg.default_features);

Along with this, perhaps this hunk needs to be updated as well [2]:

In arch/x86/kernel/fpu/init.c,

static void __init fpu__init_init_fpstate(void)
{
	/* Bring init_fpstate size and features up to date */
	init_fpstate.size		= fpu_kernel_cfg.max_size;
	init_fpstate.xfeatures		= fpu_kernel_cfg.max_features;
}

I attempted to fix the issue in the earlier posting [1]. But, mine looks 
to be clearly missing that __fpstate_reset() part.

Thanks,
Chang

[1]: 
https://lore.kernel.org/lkml/20220824191223.1248-1-chang.seok.bae@intel.c
[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/fpu/init.c#n213
