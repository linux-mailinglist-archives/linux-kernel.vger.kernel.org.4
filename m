Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608D2732267
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbjFOWGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbjFOWGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:06:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9044C199
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686866749; x=1718402749;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lNxpqUnP6C+U5stL7E4KlEX/eYS8mRTco+8L86lQcm8=;
  b=G2hHcbsT3C6LOlXfJZZcHvCGA7Zpvq778ZsmaVKTiuBZY1xmaiBdZnlz
   fHCXMe89PdZVcVQ3+iQn/8sCfj1IA/fWpsLxOpLhZq1xe9QhkkR1MpV74
   uwd4L0ioZEEq9nB+Wf4Qfy+4wpzDyluOsuYA3FaHI02MRnw/7ZEXcz3uP
   iMSptSJpxGjgXacqF3gWtNmSoTJ17gXnIiO6Nzs8JtrkbmN4Hh3nYu/dM
   c+Uh2SVpXZ9IKEnXoVkXEdlZZUpRZH9TmYRHSfo4Wn2g2gsKqQRu5s6Rh
   n2Y0BSrLTcur5fj54aPplkuZW20B8nuuKPHPL/rzk9kzS6fw0mDRy5axX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356541885"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="356541885"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:05:49 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745842889"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="745842889"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2023 15:05:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:05:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:05:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 15:05:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 15:05:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrrXYvQIZvkg448aIV0u7HrfJkvm5cgaqSuiIrhOXO4yT6sNerAcjL7Ps4ts956vZoJ6LxzbiiPPtH/+aV5vdKMViM2Gd/wAdTcLOVZTfLutm5LkhwBr3DIQ0Cmckn4JmsxDCsoWBbK7ZmfDnxio8j9U/WbhSSYbAhBRxIZCJFDyWNY0R0oDzkvp4BB/TeSNAlzxDvfacpvBG0fh3wM9AVBO8awhuLu+TlCAsB1zUsf6lxegppWZnE76u9iZHUigG9r3ZlKZ5Sde2rcqXObmIB79NDf6N/MsdvVmgJN2eoWz8tjxNsJFUj2ysIbURYpvwMHyb0oW4tkIPRZUwmRokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75iqgDkFCcSaoAclJvsv/4zk7OMEkR4TRKcDyFLN3xQ=;
 b=J7/Q8l85hzASvyOgR1jznrOExCGixxoxbDK0xoQt08lDNJXs2rJL0QJkYA3NOF0P+R7DSJruGuchutn0enjSFmA6nlgH9MxNSdDxDJwbKOLZIeGUjFDVoJx+/WWT8Le2ZDtDyCeLKKphr/Kz17XEUPZUeX3UMxmX9i+HcQIZK6zRN/Txs2xMa0YUEX9G2GIdetoHgE1Sal0Vp03Q2bT8DmIjjMPmvg8Gz3BQ3hNNE5BWr90pTuV+5jzVt4yfHPvAEQi5fGR7nu5zqQAyNaQ34uLEXK3lLJ2SsS3E6DbOsB96WsvW4/tt7OsyjIA0xBJhkG2hEDm0B9ZbcKmoIP2ClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7511.namprd11.prod.outlook.com (2603:10b6:806:347::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Thu, 15 Jun
 2023 22:05:45 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6455.045; Thu, 15 Jun 2023
 22:05:45 +0000
Message-ID: <742becbc-40fb-e6da-5070-39a4b4d46a39@intel.com>
Date:   Thu, 15 Jun 2023 15:05:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v4 05/24] x86/resctrl: Allow RMID allocation to be scoped
 by CLOSID
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
 <20230525180209.19497-6-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230525180209.19497-6-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 534ef48a-5f2a-427f-452e-08db6decab49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3sxGAzTjgyQNGTn1pijGGF/Otus92CaEEw8MIgPx3Ytx8173duxjzNttywT0S1LqIhW1Um86h9OlcVsNZN3lhYIvQS31UhL/RgMAema6bU1pVhGc+deRGlPNQmnCB37d3X4nmj3QK8IwYLAWbxfJ9XEICHPGohUwZkzXcRQ4V0Gimf2Xvb7U2oDogM0LPbrJ01GYa0dvjqqGCZbJSUnlH3FSYynS2sPAgRVJJMs6qxHGPffkm76oLcxjR5Ta8QJWLH0lVp5Wc2PUjtBTzSEK1yN1ioyYeR1WF3HKUorpjFz3ytSeRhf1YyHpDPDE/xGKq3j0EiZ2SmNiQahaklupubUkg9yFstxgTY/ewTszKPNDoyGHFgg+C9Nv+s7I2VPu+LV6bIjAJtoxSrduTsi9Up278DkuuZ42gb7OYlk8fTndln2IpXlxxoJuokyZfuT2X9XMC9+/dSynU2/ZRCuYcCI5wNdNH8biFylDEz2PsrQU5eCYAURyFc8sawrRDP5hNSN0sHmDoHCNykhqhXmrmCDDfnNlPPOGLxbR0Pd2Yc5CqThWRl6y9ISKyiGr6O7379Q0LLixa2wTEAFVS9/fx+Xmnt8s2rwPGvftfo8xMRBpGne51GI++pJN5+vgsqRtQF8SDiDfhfkDt703aJuTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(31686004)(66476007)(66556008)(66946007)(316002)(54906003)(478600001)(4326008)(36756003)(86362001)(2616005)(31696002)(6506007)(83380400001)(53546011)(186003)(6512007)(26005)(8936002)(41300700001)(44832011)(5660300002)(8676002)(2906002)(7416002)(6486002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGp3V0RMWTJvbzFKTnZrYkp2YlVtWHYwcUlRMmQreGNxRUlpYVlaRGJPUzl1?=
 =?utf-8?B?VEJNNC9iMUZVa1NCeW02bHlPdUU3b3ljYmowdExkL0pTUWJyTktSWjlEbEdB?=
 =?utf-8?B?RktabnVHK1R4Q3FtYjlRUWgvZ1dUSlV5dTF1N1BIamM0NzVxUUNVS0Ryekky?=
 =?utf-8?B?Lzh2cWxTeHlva1N2YzFDSlRQbUR5djB5U2liWnRHUTZjVnlMZS8vcnU3MzlH?=
 =?utf-8?B?YjkrM29VZ0ZCMzNwYU9OczdETzI1blBLV1NXU3BQaGNDSEdmTFBZakdNZzRp?=
 =?utf-8?B?am8zSGoyc3lGTjM5Z0NpcjErYXEwMCs1dzVBU3RpTCthUHRiYWMxWXFxbHFX?=
 =?utf-8?B?N08velhGcFdReHl3bm9hVUwwa093ZTkzSG9IVCttSzhiYVptczVzc1ZSalpV?=
 =?utf-8?B?SklMYW5Ka3lZWUVkaU4wbWY0WndBVjV4WFBqZkE1R0E2UmxNL1k4SDBaMEc2?=
 =?utf-8?B?K3ZGY3JURzRBMlE3SzlDaVA2dHkwMHBNUzBaamVHQjhBV2N3Qys0bzlxUmNy?=
 =?utf-8?B?dFE1MC85RXZRemI0dzU5NTNlZ3UzakdUcjQvb1g4WTBIMzVqYWJaYVBSRWNE?=
 =?utf-8?B?MXNVeklJQVhnVmlXZ0hFUjRyeGpsT1lkSmdRcWVsLzJlTTZaL2c1cmdxc2xv?=
 =?utf-8?B?Tm1BQURSNFVYTnQzRHp6TllHTitGZ2hQVTQxYjIxcis0SVczRkduNktLWXhv?=
 =?utf-8?B?MzViQ3FNMytwand0RHkvdm40VnJ2a1NjWFVmV1BDS2ZWOGkvYVRZNGNqWWFp?=
 =?utf-8?B?WXRaZSsvb0wzR0FYTm1jaGxRMkxFLy8xc3cwWDlYOUNUdlB5VEZvU2lRK2VF?=
 =?utf-8?B?ekVEek9DT0lDZVJ1SWsxcHg2Y01JK0l6QWlXSkxhYzkwMWw1OXhJOTNRV05z?=
 =?utf-8?B?MjUvdUhHRnViTDBWU3hBVy9PbTNZMklUQ2tBUXR4NGZiQ2xiMkJQMng0cHZs?=
 =?utf-8?B?N0RpS0FNbEw4VlRLTm81V1djMDBZT3lXRWxqYmNuK2Z5L3FKQ0JBVXROdVNJ?=
 =?utf-8?B?WlVrYjNEM1lFcDhsZ1Y2UWpNZjFEK1daazRseWVtZkFvblFpdTdyaldtU1lV?=
 =?utf-8?B?RDNGZURDWG4xcWxLL1B3RTRFREZacFpBZCt6SDlmTWM2cXFhbjFRdStOc2pH?=
 =?utf-8?B?M2c5NThRV2dPLzZwM3RqUnRLaEtXVGMvelluTUlpTkhQdW1QWGszb3Vyb2c4?=
 =?utf-8?B?ZFhGWXZxYkJhZWFlRGJVRDBVMVd4dDdZeWx0NnhFRC91MXhrSTVmS1o5Z3dN?=
 =?utf-8?B?enp3SmlsQTlRQVNZSDgwcTZUdlN2UE4wY3pCTkxrdTdCWW81NWtkUjhMTjFX?=
 =?utf-8?B?K0VMT0VhN0N6UFhVQlZRdkg5UWV0bEVYay9GZlVrQWZGNkQ1ZnI4SnFRdWJW?=
 =?utf-8?B?Y0h1MDJyeTdaVzFraVdLVnh0MnNTR3FOajdyWG9rU3dad0RoSHNnWWlrZG9u?=
 =?utf-8?B?YjZyMDk2Q3pXS0ZrR0FDZWxkekhYcjBBbmkrMXY4My9oK0xKWk16VnpOM09h?=
 =?utf-8?B?cjNhWHl6Um5YQkZvY3JzQXpDZEpjTWtJYklkNmxtOEJ6UFM1dlNtNVdXNm5Y?=
 =?utf-8?B?WVhjd0ZKTHRFM1Q5bzRreUFyR2dGbS9KM3E4L01Dd3kvcEtUWE1LWFROcUVP?=
 =?utf-8?B?UDNoVnlUU25kejh0U3VQZkd6em5ScVJSNDVJTTYvSE5nZTYzMUxCTW03dDN5?=
 =?utf-8?B?dXprL2dvS3pnRXNjNC9OMmNwb25GeWJsS0UxYytYUzdBYUVMTTh1RHFnL0Vx?=
 =?utf-8?B?TnRNVWxXN3ZzSmRHZ1Y1Ny9md1ZkbHZ0MWVlSVl6U1U3TUdWZi9uak5iZEhF?=
 =?utf-8?B?Z0xKeGRmUGhzOW94WWxMTlpRVGJ6cWhRSjJtRWxUbjIxaGhzZ2xpM2lEV1ll?=
 =?utf-8?B?S1hXazNEVkxnZkZTcmlEaDVwR00zWkt5N2lVYnowYmRqcFhnOFZJcTlKdDM5?=
 =?utf-8?B?WjExVHJkWkZYN1BlSDkzUDI0UEgvWEErcitDU29YZ011UUEzR1ZwVXJhZ0Vy?=
 =?utf-8?B?TEFuQWU2a2g3SUhvKzAvR0N1V3pXVVhyakplNmxmeEt3aWJ3REZQWEIwNS95?=
 =?utf-8?B?bDZ6Y0tRZEFrOFZtWml0M3hudzAzMkdOZzBnWnN3M0RIYW9Fb3BkeG5VZk1h?=
 =?utf-8?B?VjNudlpCcVhtOUhSREdQQjJiMjVXVHZWSytnWWVNVkVoeU5Jd0pSTkZ0dWla?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 534ef48a-5f2a-427f-452e-08db6decab49
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:05:45.7966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGdTiPxnpMe5uHvHYOiostEtidWdvW29kzaI4oHz4sUBC3Jne5CPprzDMhz8Ua5Koxnj/VadonpnnnsnM9kycERt4kJjc7wDNo/xewfTqzo=
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

> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index bcc25f5339c0..27e731c7de72 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -337,24 +337,49 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)
>  	return find_first_bit(d->rmid_busy_llc, idx_limit) != idx_limit;
>  }
>  
> -/*
> - * As of now the RMIDs allocation is global.
> - * However we keep track of which packages the RMIDs
> - * are used to optimize the limbo list management.
> - */
> -int alloc_rmid(void)
> +static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
>  {
> -	struct rmid_entry *entry;
> -
> -	lockdep_assert_held(&rdtgroup_mutex);
> +	struct rmid_entry *itr;
> +	u32 itr_idx, cmp_idx;
>  
>  	if (list_empty(&rmid_free_lru))
> -		return rmid_limbo_count ? -EBUSY : -ENOSPC;
> +		return rmid_limbo_count ? ERR_PTR(-EBUSY) : ERR_PTR(-ENOSPC);
> +
> +	list_for_each_entry(itr, &rmid_free_lru, list) {
> +		/*
> +		 * get the index of this free RMID, and the index it would need
> +		 * to be if it were used with this CLOSID.

Please start sentences with a capital letter.

> +		 * If the CLOSID is irrelevant on this architecture, these will
> +		 * always be the same meaning the compiler can reduce this loop
> +		 * to a single list_entry_first() call.
> +		 */
> +		itr_idx = resctrl_arch_rmid_idx_encode(itr->closid, itr->rmid);
> +		cmp_idx = resctrl_arch_rmid_idx_encode(closid, itr->rmid);
> +
> +		if (itr_idx == cmp_idx)
> +			return itr;
> +	}
> +
> +	return ERR_PTR(-ENOSPC);
> +}
> +

Reinette

