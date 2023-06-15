Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F1573228B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjFOWMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjFOWMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:12:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8F22D49
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686867117; x=1718403117;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zDiHD44OOLkC5BQwFcAK6+PJeDtDeFIOjPvPCcIRW0E=;
  b=SvMBpJaxXhC7OqghpjNXoCdDQqHpe8/Lxf13H/RdGNn3veydEzx8KA1/
   y0yGu4gP3uYAb7DyWOfQMzFOrZStMTZ5mXEfgA30LO9d2Pu+Xf+lheq2C
   qEoTIoyiwfrRvMXP0AyTWeBQTTJdjYBgsNUuuaSR8oCd7XABft2a+4iq1
   MvvOxItgyU6nb5YsKj418yaoFxi7oKk370n5tBdbDA1t91QDWtdA6bZv4
   lcoarrb5Mm6O7l7PJIpKFZTVTH1yJTvP0cDqpMKbZiRjrXCgAS7SHE5Iq
   VkCmcEmasaRC8FVMlhOT7j+NtC2YILLYyAFKx5SkhLrCruQJy3g98kF19
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="339393362"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="339393362"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:11:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="689973755"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="689973755"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 15 Jun 2023 15:11:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:11:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:11:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 15:11:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 15:11:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuAAisLKyZYPQulsHuaw65iIYExtDXZ/fVAke5JEBbbDRSl5gTaV4nbNlIMtG/RdPtni1Eafxo+x4m4vkcR5reeE1LwyQFzcSqJsgAmeTJ7nzQJ/BfcdFBSxSZqTPvOIv8uOVsaejdHJ0whRLHRXoPSaBG/F9sexLOMTQJk6Vo5+KRMFDyjpUgt+10+m3bKoIJRkNGHqW5pagj5jjXO5/fo6bgQ74032PbIIe6fqFf31Rc3PBBUOYohSKdxDO+avjPLOD0n5Faa/9ZkHZsPb4/9KVTBK/vLwu1SG/GfaItqo1qzuCdtgV2Pf8vqgfrYrZTMHIVrVAZ/TYmSOFoBh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zREyzwy/BYl+tC2IOuvVW9FGYedlzy40nH/sG+/gUFU=;
 b=NKW/d2BH4wen1X3R2wlxu6tFmwdwEdrWY3ea1jrui6dw3BEIwNrmIns3dIhg+vVmIP4latOlDRMfbtuH9serm1ZGlkv0zEz0xALBKWwzFgD7REuyv0m4HOL4NGjuhP/QSL0d9WtFpMe7ZVB+VcfEXYzR6p8ZgQwRr8ahysRw17A6kAudDXi1wgABuFXYjLv8J9f4cO0gWtn7Cl7fTvfUikkovVszMiU6S7aXXjdv5rH7Bvn9FKpJQUIvhog70McDQ9nwjM34h6Av4/florZwmbJF9e+FnBQKp608MDCo5bB0FbppigodcN3IAkSmavNU9C4tbdiONYUbR8WLoe7DtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB8204.namprd11.prod.outlook.com (2603:10b6:8:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 22:11:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6455.045; Thu, 15 Jun 2023
 22:11:22 +0000
Message-ID: <8c1efa87-ddbd-1d88-3964-eddfbffe8bf6@intel.com>
Date:   Thu, 15 Jun 2023 15:10:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v4 13/24] x86/resctrl: Queue mon_event_read() instead of
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
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-14-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230525180209.19497-14-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0100.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9861d2-d649-43f8-932c-08db6ded73ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KYLLx86DjZjIsoyWTJvZoGBR1RD9YteevWAGa4dyP8te2QA6KvkIBz8M0N/Pi+fgzbvAlJNq6in5LQzbAcFeFwEfPIUyQKLARe+FKbUz65wPHRv+VSLG11WeTzXmo0+MDy4GQVuvjjrbU7v/esKm1Y9mEnGDWyn/qeRaBgj9hf+qB7FnZBJzPeL8XU48woxUPGcuPxv3oO9PmaKjgrbWvNYpesqgzYwQM2YhPO7SqPI7tojGLDTLRN2lO3zineHMLAZQ8kjk6kh+uzF8PDo0OmePK7opkpfFAwSTdA4EVt3e7nww9J2OoGi7QiWQgkuA2r6N9VwEgncnR3/ZBcZhAozPmvRDjfYJQh5n8rqUjC47sikulveUh/XHKHCBRzZ1lyvsnFxH4uJp8WQuG81UQeTC2CZUfNshw7q26ascK26Kv3y6YcD9y1viP9Y5oFWAsa0YevMe7W4uuPgaL8JAvkBaSXAS39sSO3+4pppMdow4TFj6G0r0MmHKLqXzHoiwEoYntOWQP/fs2vuisvslR8kBpyHsUVQaG4x01Sw5lyCj1zkTSh6cKRujE0m3HAkWbw++uC7gqZlsHWUa01zegW4tEeLXpffD4/jmVhZTIClLfKwQWD/8AhJjy7vDsnlkc2U+Qd0EQfcvHMztG0hc5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199021)(8676002)(8936002)(83380400001)(2906002)(5660300002)(316002)(66556008)(82960400001)(66946007)(31686004)(4326008)(66476007)(38100700002)(54906003)(41300700001)(2616005)(36756003)(478600001)(186003)(53546011)(6512007)(26005)(7416002)(6666004)(6506007)(6486002)(44832011)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjlOdXZINEJzV09XalJtZ1RESEJ4MC80ZmZ6RkNTa3Z4ckduRHpCYWFNRGt1?=
 =?utf-8?B?THhtdnY2OWJNTHlYK0o1S3lLY08xUXhrSDBUekFEVlBVMS9pVXMwOFR0WGZZ?=
 =?utf-8?B?SWxjbVJNMDBGVGNGQmRXbnJrWXFFajFJZkN4R3V5RzhIak5TdEYvQ3N3TytY?=
 =?utf-8?B?Zm1xKzcra1NvbzFFREdNR0wvc3paMHY4cTl4N0dZUzZ3RmM5RWlHVC8xR0wr?=
 =?utf-8?B?VlNNL2lRVUltVm9LOUYvTG1yM3ZMekZMaEdHNzkzWWo4Nk5RNXJPTzIvT0xG?=
 =?utf-8?B?SGFWLzdoYU9pK1Q4Yy9PTWE4QmIvcGp2NEdUSGJjOFhmakRNQnZ6V21DQ1hn?=
 =?utf-8?B?V0x0TUk5SEw0YWJZUnZzcGlXRTdrUlpMaWg3dVNUbzliRUdEdWFNSmpEK254?=
 =?utf-8?B?NFlCODE1c0ZQc1NXOEtOZVQ2U09XMUMraC9ZN3IwSUJQU3JxZUNRajFzbThz?=
 =?utf-8?B?NG5NU1NUR0NOVzdqQzAvdHMvd3ZrS1gvcmk1cnFPam1zcXpvSjhrUXNreDYz?=
 =?utf-8?B?NHNPMnZ1b2RxZEpWZEREaDF3TmIxakYrUHBnOEM4aCtjdnI0MXd5Sk1vRC8x?=
 =?utf-8?B?dTBqNlUvcy9Kbk5oV2hEU2tJWDJ3YVZzVVdmY1ZWRnBzdmlaemo5TjhIN0Nv?=
 =?utf-8?B?akdvb1BLWlIyak02Qm1FV0paeXNMeENKb09DVXlycW1YeG0yYUE5Y1VleG9x?=
 =?utf-8?B?U0RteDk4enlsZGtRQ1pXcXdCMU5mOUN3eWp5QUYvbE8rZCtmZmhYUUlxRlpB?=
 =?utf-8?B?YVFpeXJ2ekJQTzlaUGlKSTVXSDlZbkJBbnBKQ2ZaK1ZMTWdvVnRVVmJ5aGwy?=
 =?utf-8?B?ZElIWG9rckFxbVpOMEZLcmlHckZILzlud0NPYVBHMVpBejNBRWpBRUcvOWMr?=
 =?utf-8?B?b1pUNWZRMStOY0pZeGlUWU9DVENmUlkyYXpYMnZkS3lYcVc2RVo1UzF3SVJS?=
 =?utf-8?B?dHZKeE0zdEQ2T2Q4VUJtYm1GNEdmWU94d3hKS1VBRXpLM1dhQm5HSmMyN3pz?=
 =?utf-8?B?YVpMTm4yMS91RGt6dlg5UHRvcHpLM3RJdERMUnJTamFibTNNWmNZUlZuUG9E?=
 =?utf-8?B?Nyt4WVJTQStXVnlDMUN3MW4rVzFiOGdyRHZqd3drcm1ScjJhY1pXaktST2R2?=
 =?utf-8?B?SDVWMkFGYVJiRCtRZ2FLejI5WFZFd3hzV1AwMG4rQVJJM3dIL2NCdkExWlFJ?=
 =?utf-8?B?MTM2RERaRUZFeHVFTWVtc1luNXRjeDRLNTNPbjcxdndJL3QvMHBPb0tCNXA3?=
 =?utf-8?B?WWdaMkR2NHRFeHRBNGxyK0JjbHUvTDE1Mnp6ZXVSQ1FGZUswL2lwbGtyRXNZ?=
 =?utf-8?B?dURHbnR3QzNIL3dNN0hPNVlOTzUrbjA3b3dqRlVvOGd1VGxPZE5ta3BjeUdk?=
 =?utf-8?B?Yy9MMTkzYngxNXZJQllFZWo0NGgwQzBCdy80am1UVTVrVExGWmRhb2NsUUtr?=
 =?utf-8?B?a0czVkNsTW5LOHFKbnlEakxnNWFHcDhjK2VNN3VkTzl4VmVnRGxIMURCV1dS?=
 =?utf-8?B?Vit3R0JYQWpoU3J1aHJTZVJ0SC9WT216QUlmelpRenBrNU40RktyVXBvSUI1?=
 =?utf-8?B?UFU3U2xzdnpJYUZNU3dYV1prU2svSWRMUkpYT3Y3STc3eDhFR3VPUEdCWHJh?=
 =?utf-8?B?YisxS3ByTmhaYmhjSVU2SytiL0JuUnlZSEF6eVVLOWJ2QzJLWWhOZzZXUFQx?=
 =?utf-8?B?a0phb0FicnVHOUZneWtYejdMTFpmZmJpbVNDVXZGUUdjLzI3MDMxOE9FUG5J?=
 =?utf-8?B?VGpxQk50WmU2U0VScFEyck1ZNTc0WGlscWRwaWFFRHBzNUpjUFZlOXpoWE9k?=
 =?utf-8?B?aGxJcktxSVdvSDdqVmFsUUpIWEdpdGRYTExPVlQzQ2NDaWYxUUJWalNzRUxV?=
 =?utf-8?B?cWVxSHFOYUZZMDR4VlI3Ukdsa3hEMFBuVVBBNlJ1NlNKVFM5a1NiaFdSQ3Zl?=
 =?utf-8?B?VzNMZVA4VGdDeG9TQ1hlMXhJMGprRHpZSHlRTjZRKytzMFNtOWdQYVVLMGll?=
 =?utf-8?B?VExxQ3E0M3REeXVxdFU1UENuMUFKdnhtTC9ONXlXWlRtN01oYjNvRXR5RHNi?=
 =?utf-8?B?SFlQYVlERHFxQytKYXRqRzlvR2h4YjNsZFN2RlBMWDhPRVNIZWZ1ZnNZd0lQ?=
 =?utf-8?B?RU05bGRGeHR0REEwamNvMnRMdWpCNSs4TStNRHFsWHVpRFhmNDA0Y01MWWVD?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9861d2-d649-43f8-932c-08db6ded73ae
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:11:21.9960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEnS1EeHl1xnIdQQoWYrsIckbH9vrUY6pJUYh1pEu8tIaP7ref9UXduLppnPp73I77+kTb9wf3Un80G1CPdMadYeTn0lvR0ltjBFzbCAHRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8204
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

...

> @@ -520,12 +521,24 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +static int smp_mon_event_count(void *arg)
> +{
> +	mon_event_count(arg);
> +
> +	return 0;
> +}
> +
>  void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
>  		    int evtid, int first)
>  {
> +	int cpu;
> +
> +	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
>  	/*
> -	 * setup the parameters to send to the IPI to read the data.
> +	 * setup the parameters to pass to mon_event_count() to read the data.
>  	 */

I understand that you are just copying existing comment but could you
please change it so that the sentence starts with a capital letter?

>  	rr->rgrp = rdtgrp;
>  	rr->evtid = evtid;
> @@ -534,7 +547,18 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  	rr->val = 0;
>  	rr->first = first;
>  
> -	smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
> +	cpu = cpumask_any_housekeeping(&d->cpu_mask);
> +
> +	/*
> +	 * cpumask_any_housekeeping() prefers housekeeping CPUs, but
> +	 * are all the CPUs nohz_full? If yes, pick a CPU to IPI.
> +	 * MPAM's resctrl_arch_rmid_read() is unable to read the
> +	 * counters on some platforms if its called in irq context.
> +	 */
> +	if (tick_nohz_full_cpu(cpu))
> +		smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
> +	else
> +		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
>  }
>  

Reinette
