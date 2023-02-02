Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC40688B1F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjBBXsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjBBXsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:48:38 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6922D176
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675381716; x=1706917716;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K9Ae0Qs7XVv5s2VbqUYSq4MfwBAUaloKQLkjVHnp6Wo=;
  b=blFhw3cxcJzCxOYHrfkqbkk2nf+uWx3fyz54Ibcav4raLW4kwhNJCJE5
   sOtB7rmypz1tbwnivdzjA9FQHOr+jCETIp04HFFjNioB0ZvvIF14W3GQN
   4dQ4Azsu9tYr2OQHV5YzAStMZR6Nho0gmQdpgXNrEVEIV105X9fZFUToo
   1vpXnd//+sjmqCmp3DlRdV2eqjsjUDxjxnTSKcCWxmQuGaNlT5FklBw4F
   4AlgJCaqy5ow9zlO5pBshyz/taOxlzg67BELzhAt9hgtmLGF6F5f7VEiQ
   B+MAZiAN/CAYWXaESc3Vk8VzSl3RZp93cUdVJkknPUitTsa/wTg9qwf/U
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="393198570"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="393198570"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 15:48:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="789483902"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="789483902"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 02 Feb 2023 15:48:04 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 15:48:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 15:48:03 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 15:48:03 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 15:48:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsK7S8O7mRAOBDfXciz4rFEAX/XLW0ptKAsiOGqrzJjuxDwhhFem704hlDssrZrMq6fA2ZIkhpRm0qUcBty9xE6p5jaBlrCFuBFYrzKN9QkhDxcJ4LDy2DrENK/YhQUX49r4JInuMfmjmycDsuI9kWqhIxdepElm0TwJZ7HlWc4GDFJi+XLxy+kC/2RSpW4m9eRptmo1TLNLGFFeeCLAJ9RxDRpgH18wTNM2FMVP9dbyRPXmMgbRAaEjTKM4ekeMfnRxb0aJdmvgPxtPqTdRS7It610AL6AdOZB98mAK25Qx365SBbjUKbHmGlI2rd79O2VBGWnh5ezfpsa3r/AdOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nuc5cLCnpH/cRN7cE8TW3vtzAK1EoiKEcHwpYZPP1Xc=;
 b=dCoKXiCi8Y73O4bfKMCz+6Mc22XfHiroSSimzdT8NvKQSLXB9m+xdLCVrVaRthDzyATe3fMfOYtdpAF61+Ilrq1V2u3EMY5O5w4InFj88q50l/G4dpyS/vmVFmpD8lDW6bEDGQfonOWtp4EVCnBrNODB99esfljauCYdTpeOzlvm3cR80u94gDyN5Hx957N+mKWrkQMbTwaaffui3Kn64+ZVzD/jK4TO71JK8plbRuxmIXY12QFtS/1q9xx0VJyX9A/sFvdSObfdsIopgt6RL3LoE4AUfi7BnLuT8XgLp2jMlgo9RmwT9DEUNzYgz25ftCd4XEsOhLGPBrCAz1O9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 23:48:02 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 23:48:02 +0000
Message-ID: <b85cc905-3ea2-9f73-a592-0ebdc4240c37@intel.com>
Date:   Thu, 2 Feb 2023 15:47:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v2 08/18] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
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
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-9-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230113175459.14825-9-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::9) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA1PR11MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 0417dedc-a217-44ed-4467-08db0577ebab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QwfY6GgsgoOin0SJ23T1+i0O5erGw4NumxM7HQs8gQHgAhZEAVYKW3zoMUlNNqPEP85FXjb/rHZ8u2N8R9Le9WpWptfsCVe0cSuZlgttWbSGHqlLKwFIyR1Ub3sG1K9gfoTnmZ94FyssheIYEdyPUq9TzN8M+NHWPUmbEQlMmWdaRlLnqeAnkli5xtowvhd5zEHzSfeZ+VcD63cYNjFMfI289y72F5vJsEDTs/3f3EifEvz1+xrd6CjCpwyRU11XEQheXNAawmSU4uQSwjCDpErQBDhUmxfGIKGJNl6Z1pOa/hnf7/R21FDjZc7OuA872Ickj7GsB1gfcZV5DDHyxbw0RfkSr1bHpK6XI72Xh3+ukHKFzn0D11YIzcPetQ5x1RAWdaC7pr/SfYbBAh4CnZvZTVkHJAiMhaumOE7fhR3WvLW/h9FpnjWBLuPWXqQE9vhrtUpNiB+ISj7jSejayIbQWG8bJbSWjY38NWgag8TiOEJGBynC0Rs8qsegSwA6L6UZyKerRJ1hF2dZfZWwyD+kXcFt77CDm1EzT89lpySfDHMaMW/rr7TQvIlLZGlYRwXCKHoqD2oYZBxuAUq1vGwFhSxGth5WTH4U2ghTXZuzTtpp11hefeP/IuJ/anf5aigJwIBNMiEKDvwQsaEh6BMkwniV0uqNP37/1rMkoOE0O8SgZcQ+wtfDVV0FsPKWrHNULL0NPYVOwdrKtpL9YPhG225xf4vBosd+yAuyDKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199018)(36756003)(86362001)(31696002)(316002)(82960400001)(41300700001)(83380400001)(66556008)(54906003)(26005)(478600001)(38100700002)(6506007)(6666004)(53546011)(2616005)(8936002)(6512007)(186003)(66946007)(8676002)(44832011)(5660300002)(4326008)(2906002)(31686004)(7416002)(66476007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yis1UkRwekFDRnkxSm5oRER2bEJENWtHdVI1bVRoWk96ekx4Wjh2OVBwcGVM?=
 =?utf-8?B?TDdZQkNsTmt4M0FlNWVwSkNzZ3VXVG5vNGFpQUliTk9OUXNtL2pXTExoYWFI?=
 =?utf-8?B?S2JHRlNOYmcwdWJ2N3NMdlRJa2F1eldGdW9yeXAxWlNzSEFJODgyVHBlaFR2?=
 =?utf-8?B?ZkZrTnluR2xjK1hPR0hRRHRPeU1GSWxvR2dBN0hxYVh1ODhZQll0MTBVZGxI?=
 =?utf-8?B?WXY1aGZUVDMyL3E1VXh4K2tWOEF6YVVzRGVFU3hSM3poUFhpZkVXTUttMzlT?=
 =?utf-8?B?cTZZaWZwK2VORUxOeXNqS0dmaWNOakRKR2t6V3VHUTFpNEpwNVY1N2VMdU1H?=
 =?utf-8?B?c3AycWNmT3ZSSjJWcENod1pBeGFtTk83S3FqVDlhVnRadUh3M3dQQnZsNFVW?=
 =?utf-8?B?YlY3S1l1eDNlNWJENHhrMTJld3E0ZTdVYlRvKzlwWTNnTmVKN3JXZUJrbHRi?=
 =?utf-8?B?QytBSGZzSEFzTkQ1a2p4QjlZQnpHWUduWnRaamQzNWJ0Tk05cnlsRUF1NHVF?=
 =?utf-8?B?d080V1RRb0FiR0pSZVdIdSs1RitaR0JyL2hWekJpa1JBYlFjdXo2R2dKRVJo?=
 =?utf-8?B?am9RVjhYSDc5R1lpY3VyTWFUQnVuMHZlRjBNNTN3eGRlbEUxN3IwOXhqVm95?=
 =?utf-8?B?UERGOENianV3Z3Q1L2ZFMnd5Z3lxS3dUSkJWeGFkN3ljQWsvakZ2VWRUTEZx?=
 =?utf-8?B?TCtUT0pjbUZkN05DQTJUSFAyQlV1RUJJMys1aXpwWFJzYWRKNnZHZXR6Uklu?=
 =?utf-8?B?em5UTWxCdFVvZDJJU21DaCt6NFN5T29kUlFMUFJseCtacHY4dzJFVU0rTGJr?=
 =?utf-8?B?VnlJMkRGS0haaTVFdnFteVhkb3oxYzA5bWNGZThOV0x5d3ZHRzdyRlk2TlNM?=
 =?utf-8?B?dmJWWnZ5MXFJQnF6QktpT0RSOFJMYTdqUndzZG9Ccy9XVElKUUZkVkxvM01w?=
 =?utf-8?B?Zlgzc2Vubm52Qm1Ca2VWUERJSitmQ2hielRTOGVNbW5JRkdMcG5OL2pJS0xV?=
 =?utf-8?B?aERxS0p2ZU83c0dtaEw3cEllMHkxNFF1cVRQdFBFbXo4ZlozOER0cUp1THB4?=
 =?utf-8?B?SXJvcjBmcHVwbjh4VGVKaVo1V0IxTlVTeW93ZFkrVEYwV08wSzF2OWRJNmtZ?=
 =?utf-8?B?WENjOStTcDZCUTR1WS95UWk1TU1paHliQ2dtSnorc2l2RjlnN0k5ODNPTk1h?=
 =?utf-8?B?L0U3UTNpUSt4R0FYUURWMm0rK3VmMUN3Qis1YVI3TmlxRytwYTN6NkxmcGxh?=
 =?utf-8?B?UTg0WjZ6OTVzNW9JakFnS1NOT0hHR1lBbXc1eEx0OXhBYjduQjB6NEhhYmd4?=
 =?utf-8?B?cTJhWnZua0pWYmg2UzcrL0ZEdmJrcE5zamlEV1M0UFNlV1ovUjBNK2llZkVT?=
 =?utf-8?B?RXNmUDhtb3M2NmFUQ3VDT0RYem96bU80OFlqbUwyQ3h2ZFhzcyt2Nm1aZkJB?=
 =?utf-8?B?MWlQbTJYTkw4TWZqc2x3YXFXNmtudW5iRDg2UlN3WHVaTWlWdzRKWEFhc3dz?=
 =?utf-8?B?SnVOOTdxRnhQanltdzF5YVF0dWI2Y1NGR3B1dFN6ZEl4ZWJPYTJ6c2NKbGcz?=
 =?utf-8?B?YjRTM1lIWVFNSlQrT21yQ1l4OTlqUjVGVmsrcEgwUTV1eVc3WkIyNlNiT0Nm?=
 =?utf-8?B?UWMyZktPTS9nb3d1YlFqcW0rb0IySmo0Zmd1N25CRHV4Z0ZuWW5VdXRyQ0Ji?=
 =?utf-8?B?d0crc2ZZeHZCaVk4UHpnU1l4U01QcHBINTFsU2xlQVpneE9aSko1M3dtYXhn?=
 =?utf-8?B?RXB6OVFGbUdRb0ppY1ZRdGpkdmREWGlQUU4vdldBVGo0cUE5S1NEYjRaTHFq?=
 =?utf-8?B?eHlEemo4V3k4N2JaZFgzaGsyRlhoVzVlbDBHL0hyWkVjODBxbWUvY3BTS1p5?=
 =?utf-8?B?VjFCcGhWcWluNUlWVWljQUdLVjRjV0Y0SG1MZFZ4bS90eTN5YXAwa1J1cDRI?=
 =?utf-8?B?Mzdlc2RNbFp0cSt0SGVPbW52UUdHT0hTUE92KzNRenhNUEFqdUJBYXIxUDUz?=
 =?utf-8?B?MVlhS1Bma0NLaW56Sm8rMUkrZzhaMWJZUUQzQWI0YlphYjhDTDBFL2ZiVUF6?=
 =?utf-8?B?YzdRVXNvb2cwZlZNang0eFVoaFZPNUl3OUJpZENleGFMOHlCWVlVMDBiTjRR?=
 =?utf-8?B?aXhQSm9lTnp1WTBhQVVyTmZIMHIwUHNrR2I1Z29zeWhwOEVQSnVWVUV1R1cy?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0417dedc-a217-44ed-4467-08db0577ebab
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 23:48:01.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXQqg8st57fBcZBn2zPeVisA+ujdN7oSdHPTzbGlMhzBY4eSq0g2aWekJdXwyA1RilITpUjtbAGx9S8XmApICctFiZYZueZkKbOUQ9t4ruI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 1/13/2023 9:54 AM, James Morse wrote:
> x86 is blessed with an abundance of monitors, one per RMID, that can be
> read from any CPU in the domain. MPAMs monitors reside in the MMIO MSC,
> the number implemented is up to the manufacturer. This means when there are
> fewer monitors than needed, they need to be allocated and freed.
> 
> Worse, the domain may be broken up into slices, and the MMIO accesses
> for each slice may need performing from different CPUs.
> 
> These two details mean MPAMs monitor code needs to be able to sleep, and
> IPI another CPU in the domain to read from a resource that has been sliced.
> 
> mon_event_read() already invokes mon_event_count() via IPI, which means
> this isn't possible.
> 
> Change mon_event_read() to schedule mon_event_count() on a remote CPU and
> wait, instead of sending an IPI. This function is only used in response to
> a user-space filesystem request (not the timing sensitive overflow code).
> 
> This allows MPAM to hide the slice behaviour from resctrl, and to keep
> the monitor-allocation in monitor.c.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 7 +++++--
>  arch/x86/kernel/cpu/resctrl/internal.h    | 2 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 6 ++++--
>  3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 1df0e3262bca..4ee3da6dced7 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -532,8 +532,11 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
>  		    int evtid, int first)
>  {
> +	/* When picking a cpu from cpu_mask, ensure it can't race with cpuhp */

Please consistently use CPU instead of cpu.

> +	lockdep_assert_held(&rdtgroup_mutex);
> +
>  	/*
> -	 * setup the parameters to send to the IPI to read the data.
> +	 * setup the parameters to pass to mon_event_count() to read the data.
>  	 */
>  	rr->rgrp = rdtgrp;
>  	rr->evtid = evtid;
> @@ -542,7 +545,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  	rr->val = 0;
>  	rr->first = first;
>  
> -	smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
> +	smp_call_on_cpu(cpumask_any(&d->cpu_mask), mon_event_count, rr, false);

This would be problematic for the use cases where single tasks are run on
adaptive-tick CPUs. If an adaptive-tick CPU is chosen to run the function then
it may never run. Real-time environments are target usage of resctrl (with examples
in the documentation).

Reinette
