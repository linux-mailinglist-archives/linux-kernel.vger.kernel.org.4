Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCBD732262
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjFOWFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjFOWFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:05:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B43F137
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686866710; x=1718402710;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=abeb7RKivPgSrdKjdGN+tNyCUAdoFn4FzydUn7GWjmA=;
  b=LGSEqriKwEwnNembeHWWzgMNBWDQI8E1sNNAzCMaFdFnszLjNH8KQcBu
   aZwTCGY52bQCJLcRI8xpyPfyQnCScUP064PSmBpRC5laqQvkz6PF//T5o
   CW/sQ+Q7/2Huz9m8v7vsissf2SoR5qaaKrRg4Si1DqTWOruljP7kCqC1U
   B7pF0od/EwCW30CLUoAuzuocbAh6kjN+iZgzydIxNqQZnpPgIzYraVccI
   tIVdACCb5TVFiagb1CsNg979/GB5ooSzvHKYJzUND3mkngXblPPFwThu5
   zaakazLPnROyHAyXWneB41wi5MapIJFPua1uwWVNdtX0VxdWG6Y0/aQg8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356541759"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="356541759"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:05:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="1042848088"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="1042848088"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jun 2023 15:05:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:05:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:05:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 15:05:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 15:05:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHTaHp3KjjRXBQpz0lwKGGiDjKjVfvTea78dMYdSNKCFS7PlluLH+vqyC03J8ZTopbQXIXsP/rZnMi4Y+c3Cnmk+jOr0T+e2vs+FFRQ2ApUZqd1Qomve8eHOYKONNj6IWilbLuRP+e0kNMiy1gPqkSeV9qrLK/BWq12aR7Y8OogXdCYTnx6ZqjsMNhBtSYOTBotRGhz5/BjGkrU4o6dbNBH/4WGYxbVi2edZ9oYQaC7KDdImZF17btbpPP9/6Kikey74yUMv4QNg3F+LTmZYxZNzVNxQLFCh+PVYdZsdILqj8utzXWsiI65Ifxw2VpQywNdQoIFX4PYQcDntIVNkbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOHbPY72fZ74OPBFZHEhhbrfwv3S44zItTdYs1+aoVk=;
 b=ArQ/wG+BQHFQD1l/xSZLbcEHNjJ6J5h59UDe68QKZEZUyPKnVSLFyJDfc8rEOMU4H4Ns9rCtbqyEjpfXUuquZ+txsIxH0qu91o9RpWvGdrNP0qdW4Tw8SX+kTsaRvlEiAZeDp4WNPu7Fhh/9gYp8QuWw93XImn5azuxKqrGTFne69CbHrzwP3tFqh2NkqirZObX6hzCl4iwgGryF48W7MJ/hFYP0ypUbsMPDqonVzhGG+s8G07+Rp7GFFCwumQ8yrCzu+2UiuelVCQYhtKJ4O8l7SfrnzmgieMddaYJ1jiKRIQ0vW4gIk/Xdsp/chb2bNgfVCKeiMSOZ7qkg9S/fZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7511.namprd11.prod.outlook.com (2603:10b6:806:347::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Thu, 15 Jun
 2023 22:05:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6455.045; Thu, 15 Jun 2023
 22:05:05 +0000
Message-ID: <782287bf-8334-ebbc-1fde-d4bad859e004@intel.com>
Date:   Thu, 15 Jun 2023 15:05:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v4 04/24] x86/resctrl: Move rmid allocation out of
 mkdir_rdt_prepare()
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-5-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230525180209.19497-5-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c726ae4-c179-4bfb-4e55-08db6dec9356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7EE0pEv+C8tLqEJA7igw/jyLwhklmu7AoEQjy1yHtpfCjVmoqCUSDTSjML/BfrcW2LMWhkUQKsprB2Ksy7+xHFr+3Vv/JgvU3RjMXvluho6Xlmy0F31IrD6yhxeBI4fEbsXAQvDPsTMM4fIrCnQgsQENdw6SfZYalCTonrNERFwelVAdWElr/qVeTFIYqqCOCheJ3RmotY5nmsJmE219YpQLqegrDkz2VTMnd2FutZW8UZI0NoD7yF84Yiaa6JsDIEtjHDUhjQop5c2ItH7H0CywFD9t3/+wBb0lk/qxm4KViU6hbejbUwnkzVHQauxniQUGy0r/pF8Ba/kkpDJFHFhNXmNk+r1/QpVXcONS9UUnvqk5Z2Jwi/GT6jPPPpju8oOnZ8OLXuqHSCHP5g8jEH+rRoXA2E7XWLua/JY3b9OzlXzonn41LvGkC8Vq951JWsb+DMypBouwa24cgLUfhYmLAXyBpyLyL/VwSUvZC1TKyX+wij6y5JYmU+bE19Uhj+svyHdrKPfRRA3Htk1lTIAFmksXQadM2lNszZxbqmqt30pDg6GiAhrfbFiZsgXL0E5ay1O1iV1+DGlbVknlFbdRuwbIR6WUchPtvseAjxps/4HjacTAC/o7rgmX+CO6+5qAr7PSWhrrYJMTtHtYzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(31686004)(66476007)(66556008)(66946007)(316002)(54906003)(478600001)(4326008)(36756003)(86362001)(2616005)(31696002)(6506007)(83380400001)(53546011)(186003)(6512007)(26005)(8936002)(41300700001)(44832011)(5660300002)(8676002)(2906002)(7416002)(6486002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q05sQ0RPNGVWVnlNRUJJRksxaUloYzB2Q3l1VnYxQ3ZIK3VHREhFNEE5NGNq?=
 =?utf-8?B?YW5uTDVFWGQyUHJNRm9TdUk3M2o5ZEdieVpnNjY3TVp1U0pZNndBSFJMcHZr?=
 =?utf-8?B?Ly9FWFFOd2RocjM4V0pDTitqMHNSaGdhd0VhdUViTkZweUdTRmUzTEVvK0Mz?=
 =?utf-8?B?UG8vTmFlbXRmRnJPUkVhaXBMaFJ4Nnc1K3lOT0JVNTRuNHR0cHVKU2dTS3dF?=
 =?utf-8?B?K2J3cVJZeHFnR3pEU2xtYnZqWWVnSlB2aHp2bFovRUM4S3krS3RRYWtWL0FE?=
 =?utf-8?B?clpvMlNqSzA5bzlySk1rRnExUlFpbkFsV0tKVXE2bklFRUlmNVphR1JEUmRX?=
 =?utf-8?B?anNaa0pXTUJ3d1JXMkZhSUJGWm9MR200ZlVkNHFHejk4YzlNajhRRkZETnh6?=
 =?utf-8?B?TGFLU2tQUmxDTmR3NHhrM1ZoWDloM2hLSklmQkluTWZLNHdLa2ZoYkR6bnlL?=
 =?utf-8?B?dVkrU2dlb2Q3dzNOUmVXcTltMFZiei9sYWNRMVJwWjRmL2gxTitWNmlwcjVs?=
 =?utf-8?B?VVUrb1lrTXZsNVRmWkphNUgxa1RjdUxGcUVGZUJEOWt1RXdmWXN1QnpOMklp?=
 =?utf-8?B?aXlYRjJjODlLdnc1TkJtdTFjOXVwcm1LTjlRNVY0ci9lR1RSZWs1ZUVRdkFH?=
 =?utf-8?B?N2p1ejU4U1NIZXozdTgwdXJLU1l3Y1BuZHhPdWZUNDNQa2twQTR0TjZQSUp3?=
 =?utf-8?B?NjcrUldXUVlSQTE2M0NhYXduNi9JbG9ORDNVaVNoa1BLMXpzSjdDa1ZIMmdy?=
 =?utf-8?B?c20rMzRNRXFVZkF6VDBhSjk0cEZhQ3BCcVJza08rbGNWMnJUS3pqSHR3SGF3?=
 =?utf-8?B?TkcrS2VtcFppTjg0K2FOUTltU1pOaGc0V3orNUpId2M1b2dQaE9NbjR3VEZq?=
 =?utf-8?B?eVE3QkZRWlZadWgwOHBJeTdhQ2xFVytHZ2d2M082blkrbUkwV094Wlh1YUFv?=
 =?utf-8?B?SWNsWEFWNDZpcHp5cWFpK1JZNXBvekIramVJdTd2SklrUDE0NFNiVi9xNjFE?=
 =?utf-8?B?eDN2K0wwVU14NnZqVGdubmZKMmwyNlNjSitBcVcyNzErOGlwdVVYTi80cVZV?=
 =?utf-8?B?b0plZ0hjVSs3bVovRmg2bGJyaWdIS21LY2hYMW1ySjM0VVB2U1M3U1Yvcm1i?=
 =?utf-8?B?a1JFdXVHbWpaUWMwSDJmdjY0ZVc3dFFRMnp2VDNKalM4QmJlWU5LRUE0K0dG?=
 =?utf-8?B?NkZ2T1NiOGN0bmxUUEJ5czBRQ1NXbHNDZkluTitvanYvUVh3S1VLM3QvNjEx?=
 =?utf-8?B?bWFMcittak42bTh1YUpmNHo0NGtiSXhielREdDJOU0s5Q3BpbkRWUHMza2p6?=
 =?utf-8?B?bGVLQytCa28rdXkwc1ppcUhTTnpKQzk0MDQxcGhEajBISmYxeXg2OElrTEdj?=
 =?utf-8?B?MzZCdEhKdllOZDlwRmIydlhsRzM0Y2s4WnZNcmNlL0tza3BrVlhKZ05ud0ts?=
 =?utf-8?B?MngzSjN2Z2RBRmtUWDNvclM4UVZWTklVdHFMejRqMDVXMHgvYmVHMzVGSXhy?=
 =?utf-8?B?OHk2dTdNMTVVSEkyZVlVS24raGt6NWVCY1ppaXd4NnYyMm53R0pUZFR3aEgw?=
 =?utf-8?B?cWgvYjRqVnRuVnlzc0ZVQUJublBWWVk5NXhjM0gzcE44S1JqV2RMMzZra3hl?=
 =?utf-8?B?UklLbi9qRVN3alprbUZtb2JhK1grR00rb3ZrenBNL1AxUHV0NVltOERrMlhm?=
 =?utf-8?B?cTlLSlQxWTJKWllGVEJQN0tMMCtjTGJWa255VXRPVVJVTHRPREUyQnM0dmZZ?=
 =?utf-8?B?d2pVSFlyUDBhR3JQZkxTTkZWcVpmcDhQRXhNbktzMlRXRGJleWVNRDFzQkdU?=
 =?utf-8?B?OUdJM0xvOWNZWHpudnN1Yll3OE0xcnQrWmV3OXBRTVVoYVFxLzFIc0xHOWJI?=
 =?utf-8?B?bSt2NHZLU0ZWYkVINytyWmlQR3NsbmJGejZuT0RzSm1NeXczMkpBN0pQRWNq?=
 =?utf-8?B?NlFVVUExMzJDR0U5dW5yRWFFTjd3VHhJTTNodUdoY0dLMGtRUGN1MHBvOVZT?=
 =?utf-8?B?bUlvZTNHV3J5UXlnZkZMZEJVVWQ5aTF0Yk8rb1BKZXJTMFIrMGR5cVNmNU9N?=
 =?utf-8?B?SnlUaXRWMEU3NjB2WXY4Ui82cEphYXVSaGdHVG0yRi9jQUs5LzNGcDVDcmQ3?=
 =?utf-8?B?aC9TMm8xRUU0NlY1TkI1NEFwSWtYMTFHZXZ1MVVwOU4yOHpmSWJhV251bWJJ?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c726ae4-c179-4bfb-4e55-08db6dec9356
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:05:05.6055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSDLs5FB1+uG9EgEamHnVAwR5zSoLS8U/lUV1fnHyUOcAMslmZKz03k4qAyn3PzJ/5vSd5dgxTZ+oGhVotsFvCN6TQKwHDbR5Re0RuXpYG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7511
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 5/25/2023 11:01 AM, James Morse wrote:
> RMID are allocated for each monitor or control group directory, because
> each of these needs its own RMID. For control groups,
> rdtgroup_mkdir_ctrl_mon() later goes on to allocate the CLOSID.
> 
> MPAM's equivalent of RMID is not an independent number, so can't be
> allocated until the CLOSID is known. An RMID allocation for one CLOSID
> may fail, whereas another may succeed depending on how many monitor
> groups a control group has.
> 
> The RMID allocation needs to move to be after the CLOSID has been
> allocated.

This third paragraph seems redundant.

> 
> Move the RMID allocation out of mkdir_rdt_prepare() to occur in its caller,
> after the mkdir_rdt_prepare() call. This allows the RMID allocator to
> know the CLOSID.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>  * Moved kernfs_activate() later to preserve atomicity of files being visible
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 35 +++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 05774b185eec..8346a8f2ff9f 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3176,6 +3176,12 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
>  	return 0;
>  }
>  
> +static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
> +{
> +	if (rdt_mon_capable)
> +		free_rmid(rgrp->closid, rgrp->mon.rmid);
> +}
> +
>  static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  			     const char *name, umode_t mode,
>  			     enum rdt_group_type rtype, struct rdtgroup **r)
> @@ -3241,12 +3247,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  		goto out_destroy;
>  	}
>  
> -	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> -	if (ret)
> -		goto out_destroy;
> -
> -	kernfs_activate(kn);
> -
>  	/*
>  	 * The caller unlocks the parent_kn upon success.
>  	 */
> @@ -3265,7 +3265,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)
>  {
>  	kernfs_remove(rgrp->kn);
> -	free_rmid(rgrp->closid, rgrp->mon.rmid);
>  	rdtgroup_remove(rgrp);
>  }
>  
> @@ -3287,12 +3286,21 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
>  	prgrp = rdtgrp->mon.parent;
>  	rdtgrp->closid = prgrp->closid;
>  
> +	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> +	if (ret) {
> +		mkdir_rdt_prepare_clean(rdtgrp);
> +		goto out_unlock;
> +	}
> +
> +	kernfs_activate(rdtgrp->kn);
> +
>  	/*
>  	 * Add the rdtgrp to the list of rdtgrps the parent
>  	 * ctrl_mon group has to track.
>  	 */
>  	list_add_tail(&rdtgrp->mon.crdtgrp_list, &prgrp->mon.crdtgrp_list);
>  
> +out_unlock:
>  	rdtgroup_kn_unlock(parent_kn);
>  	return ret;
>  }
> @@ -3323,10 +3331,17 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>  	ret = 0;
>  
>  	rdtgrp->closid = closid;
> -	ret = rdtgroup_init_alloc(rdtgrp);
> -	if (ret < 0)
> +
> +	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> +	if (ret)
>  		goto out_id_free;
>  
> +	kernfs_activate(rdtgrp->kn);
> +

I can see why you added this kernfs_activate() here and it certainly matches
the resctrl pattern of its use. It does seem as though resctrl often calls
kernfs_activate() as it adds files instead of a single call when all files
are ready. This is not an issue with this patch but I do think this is an
area that deserves a closer look before any more additions.

Reinette
